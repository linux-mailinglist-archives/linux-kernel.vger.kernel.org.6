Return-Path: <linux-kernel+bounces-528027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37EA4129C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5092216FB14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067904D8D1;
	Mon, 24 Feb 2025 01:27:52 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7093FBA7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740360471; cv=none; b=pZtR8mGRaYStXH9AHlr7MAyJbh0Csg9VNcYkEqHeSGRRdJr0RrFqF4XI5mxgHt3JcgyM6Ooevd0rD/qfW2ss2sN6w4Oa0VPYorbuTT/p2wnGNuOAc5naP5x8XX91HJpAs9Z5XMVE/IN83B0XLifsoaFZSBjGr4tQtOtOLsxzpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740360471; c=relaxed/simple;
	bh=QPY4XgQVB9l8xhB2+/tvz/LGcHqwb14mQwIL70ewMls=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L18yw7tUvN1ufKxzJO8fDxVKL1A8pW48ZWWRefUPw7EyXW1wGusD3themSqq3wcsUrtMPyJpk35HzBnkN/iKumfwx8HpTeYcZawprmhJmsUmHoH016XBSkAlfMB5n+6+XwfJKf9nUab0mJEVUrBFX7gpCdgFuKZtoJUBAMhwwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z1NKl0lMDzHyyC;
	Mon, 24 Feb 2025 09:23:39 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 5791F14034E;
	Mon, 24 Feb 2025 09:27:40 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Feb 2025 09:27:39 +0800
Message-ID: <61566a74-04aa-44f1-9aa9-624644f06450@huawei.com>
Date: Mon, 24 Feb 2025 09:27:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<kasong@tencent.com>, <ryan.roberts@arm.com>, <chrisl@kernel.org>,
	<huang.ying.caritas@gmail.com>, <schatzberg.dan@gmail.com>,
	<hanchuanhua@oppo.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
To: <21cnbao@gmail.com>, <willy@infradead.org>
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <Z7lIYzLSACbWxlEM@casper.infradead.org>
 <2c7dfa44-266a-4aa6-9401-7528368f171e@huawei.com>
 <Z7qK-NFJsqcV0rPw@casper.infradead.org>
 <CAGsJ_4xHaaf_DHsFZ_zEqEd3Nb9C=7JJjy5gGFo+RhEhQYX_tg@mail.gmail.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAGsJ_4xHaaf_DHsFZ_zEqEd3Nb9C=7JJjy5gGFo+RhEhQYX_tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/2/23 14:18, Barry Song wrote:
> On Sun, Feb 23, 2025 at 3:42 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Sat, Feb 22, 2025 at 11:59:53AM +0800, mawupeng wrote:
>>>
>>>
>>> On 2025/2/22 11:45, Matthew Wilcox wrote:
>>>> On Sat, Feb 22, 2025 at 10:46:17AM +0800, Wupeng Ma wrote:
>>>>> Digging into the source, we found that the swap entry is invalid due to
>>>>> unknown reason, and this lead to invalid swap_info_struct. Excessive log
>>>>> printing can fill up the prioritized log space, leading to the purging of
>>>>> originally valid logs and hindering problem troubleshooting. To make this
>>>>> more robust, kill this task.
>>>>
>>>> this seems like a very bad way to fix this problem
>>>
>>> Sure, It's a bad way to fix this. Just a proper way to make it more robust?
>>> Since it will produce lots of invalid and same log?
>>
>> We have a mechanism to prevent flooding the log: <linux/ratelimit.h>.
>> If you grep for 'ratelimit' in include, you'll see a number of
>> convenience functions exist; not sure whether you'll need to use the raw
>> ratelilmit stuff, or if you can just use one of the prepared ones.
>>
> 
> IMHO, I really don’t think log flooding is the issue here; rather, we’re dealing
> with an endless page fault. For servers, that might mean server is unresponsive
> , for phones, they could be quickly running out of battery.

Yes, log flooding is not the main issue here, endless #PF is rather a more serious
problem.

> 
> It’s certainly better to identify the root cause, but it could be due
> to a bit-flip in
> DDR or memory corruption in the page table. Until we can properly fix it, the
> patch seems somewhat reasonable—the wrong application gets killed, it at
> least has a chance to be restarted by systemd, Android init, etc. A PTE pointing
> to a non-existent swap file and never being enabled clearly indicates something
> has gone seriously wrong - either a hardware issue or a kernel bug.
> At the very least, it warrants a WARN_ON_ONCE(), even after we identify and fix
> the root cause, as it still enhances the system's robustness.
> 
> Gaoxu will certainly encounter the same problem if do_swap_page() executes
> earlier than swap_duplicate() where the PTE points to a non-existent swap
> file [1]. That means the phone will heat up quickly.
> 
> [1] https://lore.kernel.org/linux-mm/e223b0e6ba2f4924984b1917cc717bd5@honor.com/
> 
> Thanks
> Barry


