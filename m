Return-Path: <linux-kernel+bounces-435603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3B9E7A05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891CD16C2EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010361DC075;
	Fri,  6 Dec 2024 20:30:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9321DE2A8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517011; cv=none; b=O+/Nek+9EKc/dHfr3ypQuKSfLxaQA5kXb4xwQ5zQsFxovAzTCDFtXbQrJ7BrIRQPW6QpHxKeiltzljfA4+cjRjOs3ilJsQZo378oMmFvO8GE7psZCtynGTgbcinVAblnCKCYaIzEKN4l/6kqShVRV17UkGRhBb7RMV2RjM7xU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517011; c=relaxed/simple;
	bh=rU1gOVpYMhHIJEcOgVuKGTFJrl7p9VeyIcOtctgJagw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HARVG3MK2QkXY8cMxRjKNdeMNqrbJhdUX13d5MwsBNkxtq4YEz5Scnh4wgMJ4QVA4T8y5oQyXRKYv1aVCEqfZfUQDytzEO5ZPwgoTSjSQFqYTf6UHPo/pu4T85pFsGkHASLOsxkhU95rrQVaaeI4zNnMmGftii5MaSXKdiPfCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28DFF12FC;
	Fri,  6 Dec 2024 12:30:36 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A58CB3F58B;
	Fri,  6 Dec 2024 12:30:07 -0800 (PST)
Message-ID: <2ae90276-67f8-4b46-9cc5-1f7062eadfff@arm.com>
Date: Fri, 6 Dec 2024 20:30:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SCHED] any modern replacement for RT_RUNTIME_GREED in the
 mainline kernel?
To: Chris Friesen <cbf123@usask.ca>, LKML <linux-kernel@vger.kernel.org>
References: <49a1c1eb-5e80-4eb2-b882-a2df3ec12012@usask.ca>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <49a1c1eb-5e80-4eb2-b882-a2df3ec12012@usask.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 18:12, Chris Friesen wrote:
> Hi all,
> 
> Some time back (https://lore.kernel.org/lkml/fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com/) a patch was proposed that would allow high-CPU usage RT tasks to use 100% of the CPU as long as there were no non-RT tasks that wanted to run, but if a non-RT task did want to run the RT-throttling would kick in to prevent starvation and deadlocks.
> 
> It was rejected for philosophical reasons, with a mention of a hypothetical deadline server being the "proper" solution.
> 
> Has anything been done in this area in the years since then?

There has!
The 'hypothetical deadline server' was implemented and is part
of 6.12
https://lore.kernel.org/lkml/cover.1716811043.git.bristot@kernel.org/


