Return-Path: <linux-kernel+bounces-254779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA8F933781
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823BB1C22A24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0771BF53;
	Wed, 17 Jul 2024 06:59:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83071B815
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199594; cv=none; b=C0jlm79MzBykdDg2z4itu27BWTzHq/WaMxr6GNS9mkN7gSiidl0wbmSs4tsclZTCkrk/N24jWtxIPuMpC/CDiKO/wpKCYplm+bkRU1hL5h33/YD1pnT+Jm7Fq/o0j04s4n1kqS37eJetnbdLbaulI5ZxPTmlEPs0dvDQzlyb0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199594; c=relaxed/simple;
	bh=V5Vv26hNYQKTU1E0v2PYqTtVgytUg6KK/ajHQvWMLgI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bvh3op34QDDehyFwJ5Dh4c8UiIwUDel5N7ndHwXNvjwLK98FtsFtqVwcQ7MTNkv3ZKs0mF6pC0daLeEFxuu7yYiaQLfu8tqF5tZ1cPs273TvwW3842tqevH1wQazPwn+hH92YzcjGS1y7ykiLZ8bh/BFDQ6OHG4tf44IlCsIesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WP6Fy3zhFzdhwy;
	Wed, 17 Jul 2024 14:57:58 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CB671800A1;
	Wed, 17 Jul 2024 14:59:42 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jul 2024 14:59:41 +0800
Subject: Re: [PATCH v2] mm/hwpoison: reset hwpoison filter parameters in
 pfn_inject_exit()
To: Michal Hocko <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240716033516.606582-1-linmiaohe@huawei.com>
 <ZpYxkH1EFB65tEzt@tiehlicka>
 <c81031da-2722-dea4-0118-9f4911035cae@huawei.com>
 <ZpdiOAjdSJfkpbr7@tiehlicka>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d04b9e4f-fc43-f93b-c1a2-2ed9479ffc71@huawei.com>
Date: Wed, 17 Jul 2024 14:59:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZpdiOAjdSJfkpbr7@tiehlicka>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/17 14:18, Michal Hocko wrote:
> On Wed 17-07-24 10:23:06, Miaohe Lin wrote:
>> On 2024/7/16 16:38, Michal Hocko wrote:
>>> On Tue 16-07-24 11:35:16, Miaohe Lin wrote:
>>>> When hwpoison_inject module is removed, hwpoison_filter_* parameters
>>>> should be reset. Otherwise these parameters will have non-default values
>>>> at next insmod time.
>>>
>>> There is a clear layering broken here. We have mm/memory-failure.c using
>>> values and mm/hwpoison-inject.c defining the values. Both with a
>>> potentially different life time. Shouldn't that be fix instead?
>>
>> In fact, we have mm/memory-failure.c defining and using these values while they can
>> only be modified through mm/hwpoison-inject.c from userspace.
> 
> Yes, this is exactly what I mean by broken layering that should be
> fixed.
> 
>> The common usecase should be:
>>
>> 1. User set hwpoison filter parameters first through mm/hwpoison-inject.c.
>> 2. Then doing memory hwpoison test through mm/hwpoison-inject.c.
> 
> Why does this need to be done through different modules? Why it cannot
> be part of the memory-filure.c?

This is a bold idea for me. :) I think it can be part of the memory-filure.c.
So CONFIG_HWPOISON_INJECT should be removed from the world and then make
hwpoison-inject default on when MEMORY_FAILURE is configured?

Thanks.
.


