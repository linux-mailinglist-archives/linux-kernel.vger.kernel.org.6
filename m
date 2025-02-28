Return-Path: <linux-kernel+bounces-539321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC5A4A335
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6A7189CE59
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B511327603A;
	Fri, 28 Feb 2025 19:56:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF9B1B87FB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772562; cv=none; b=rBbZ/uOrTBULGRMVWfKbS75Djsyt8HuWhS3zxEO6ONZ714qyFwri1gpHy1FJZ8YP7xbJczuk7Bz+/RG/3mvMEulkPqamfgJ8ue1EpFWiKO67x4N1gy8QMkJ/pkUiH7uPxDJwrKDWyvJjE0xeBZst9NvpYn11KSN7vYIG7pUPP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772562; c=relaxed/simple;
	bh=tXkBg/wxFeO9pOJt/0nYGoKZFgxLdb9iUHb2+LPganA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgvXzogk+3HA517mA1uJBAwcggx37N2wGSBUPR1N6uHo6PN1591ZQC7rJC5qEFkLaBKEvIi1r8CX9bGai6EAre+8Cnh93kGpHRvpVg0LMF8k3AZfOxb1OXhZvwoewFnRCCrQa8vMFNuqTuAwly4BSKrRWIQ5fQpkAOaFwwiqYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5595E1515;
	Fri, 28 Feb 2025 11:56:15 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C33B3F5A1;
	Fri, 28 Feb 2025 11:55:53 -0800 (PST)
Message-ID: <61bb1e8c-c886-4f05-a148-380481530565@arm.com>
Date: Fri, 28 Feb 2025 19:55:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 28/42] x86/resctrl: Handle throttle_mode for SMBA
 resources
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-29-james.morse@arm.com>
 <e11b33a7-ffdd-4280-ba3b-986c577199ab@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <e11b33a7-ffdd-4280-ba3b-986c577199ab@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 01:20, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> Now that the visibility of throttle_mode is being managed by resctrl, it
>> should consider resources other than MBA that may have a throttle_mode.
>> SMBA is one such resource.
>>
>> Extend resctrl_file_fflags_init() to check SMBA for a throttle_mode.
>>
> 
> "Extend resctrl_file_fflags_init()" -> "Extend thread_throttle_mode_init()"?

Gah, more rebase noise.


>> Adding support for multiple resources means it is possible for a platform
>> with both MBA and SMBA, but an undefined throttle_mode on one of them
>> to make the file visible.
>>
>> Add the 'undefined' case to rdt_thread_throttle_mode_show().

> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James

