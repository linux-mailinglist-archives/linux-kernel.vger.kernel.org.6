Return-Path: <linux-kernel+bounces-518128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B7FA38A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942B7172040
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F629228361;
	Mon, 17 Feb 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXOJdCKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11C227584;
	Mon, 17 Feb 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811859; cv=none; b=iPPMxVYLOi93ahPMUx42Z+P6qY+p/AvOq6nUUbSUvZzJgvNjSX38B7r7m2+SgCHjWHj6+qK+xciXdKhOURaZr+lTlw0gF6/KGjdFJHt5lpG+b8KVt0p6mCutPUgyE5K29eDsZfqri8u9EQozioRKvwyx37fV1BubepTQAmM60Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811859; c=relaxed/simple;
	bh=ZmSc8mMIKJjr06qBSyOu8Bv+q9wbNq8MGVbD05+1lPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkEcuWnBAb9zg8UWmiS/hxls8DsP2+vowkW/es5HXtqVr6GsUNlqSjsD1gUqyarIy9cq9RAJ1FqWTNZ86eCAztbUSPDawC/j+MyM4OYqrVsPMFTYARsdXfHdE9PnNUqFLxqNROaCrEI76Hz3WA4bbWVH1UJdT1LacRmm+x3ufbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXOJdCKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1717C4CED1;
	Mon, 17 Feb 2025 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739811859;
	bh=ZmSc8mMIKJjr06qBSyOu8Bv+q9wbNq8MGVbD05+1lPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CXOJdCKYO7gofAlxxZfu5jCtvQLV9FxxyHE/Rm/jOckfdHM3SFqi2gjbkuiXrLu4t
	 9oYphmjSNeURidd9NOvupQEwIYnEMUzzDBiaAbd919xQuNGFnIziiTNrjWFzv9jip3
	 cu2N4m7TWYtOvqsBu3ZjF27if1M8/lX47DaAswJa70wsmNimEB+yixKmJ+Iuy3Fc35
	 aT0NMHstZlonF7kPggT/CU3/UAsV02PYyCzbrgyxXKJYpyJ87WvlXk6qCPBDoVup21
	 jw8WCSArzrFwV6YzhCeZBJDxEu6GGefEObi64RzmZGsXwbsHq+U/vtGhWWYVp6vBuD
	 n972U7crVhqjw==
Message-ID: <92da3765-def8-4164-b667-8caaba01706c@kernel.org>
Date: Mon, 17 Feb 2025 11:04:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] cpufreq/amd-pstate-ut: Continue on missing
 policies
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-10-superm1@kernel.org>
 <Z7MfqEB48RqD7tuZ@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <Z7MfqEB48RqD7tuZ@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/2025 05:38, Gautham R. Shenoy wrote:
> On Fri, Feb 14, 2025 at 06:52:36PM -0600, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If a CPU is missing a policy then the unit test is skipped for the rest
>> of the CPUs on the system.
>>
>> Instead just skip the rest of that test and continue to test the rest
>> of them.
> 
> Along with this change, does it make sense to only loop over the
> online CPUs instead of possible CPUs ?
> 
> 

Sure thing.  Will change this patch for v3.

Thanks!

