Return-Path: <linux-kernel+bounces-253275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F86C931EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEA51C21069
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E47EAD32;
	Tue, 16 Jul 2024 02:38:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB53FF1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097487; cv=none; b=AmWmaM01xQNHIiK6dOWG7DOADbmCUhxPvU56ZtaySBiTiDVxsT/17/gDe47uOnWi31s1FWAIknHKQnM0Ohy6i+sF7imNEGNQRURneIr+bXpkIvv8zPSwVsfg6mqHpowsTr7u/5rkvZhu1/E1zkwT66d4wKVmG1KhWRVe6iQgwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097487; c=relaxed/simple;
	bh=BASY3W4o0xl5rn57zgdxei6D301uXGrdyoXN+Nu4zR8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MlZinCefd1Mc5dw5l5pdeezIXX63IcKb4nZgjJ9gtnO6xfq2jIcweGMqGAVzaxv0BUjpGBafPyPZl9DI62PDdT/f1HpFe+jMq22tZiLaiIVBLJmNsvVJ636HxQUlp8Gk5+SmGIpvz/L52T3HhwwFIxfwfD1WPhFMMkGFZAE7tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WNNVN1zJFzdhjF;
	Tue, 16 Jul 2024 10:36:12 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 60AA0140FC8;
	Tue, 16 Jul 2024 10:37:55 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jul 2024 10:37:54 +0800
Subject: Re: [PATCH] mm/hwpoison: reset hwpoison filter parameters in
 pfn_inject_exit()
To: Andrew Morton <akpm@linux-foundation.org>
CC: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240715102806.2638849-1-linmiaohe@huawei.com>
 <20240715133338.fb8b3b9a99f05b086fc54b82@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <29487e61-8785-0064-6208-5044b6419c9c@huawei.com>
Date: Tue, 16 Jul 2024 10:37:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240715133338.fb8b3b9a99f05b086fc54b82@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/16 4:33, Andrew Morton wrote:
> On Mon, 15 Jul 2024 18:28:06 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> When hwpoison_inject module is removed, hwpoison_filter_* parameters
>> should be reset. Otherwise these parameters will have non-default values
>> at next insmod time.
>>
>> ...
>>
>> --- a/mm/hwpoison-inject.c
>> +++ b/mm/hwpoison-inject.c
>> @@ -64,9 +64,20 @@ static int hwpoison_unpoison(void *data, u64 val)
>>  DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
>>  DEFINE_DEBUGFS_ATTRIBUTE(unpoison_fops, NULL, hwpoison_unpoison, "%lli\n");
>>  
>> -static void __exit pfn_inject_exit(void)
>> +static inline void reset_hwpoison_filter(void)
>>  {
>>  	hwpoison_filter_enable = 0;
>> +	hwpoison_filter_dev_major = ~0U;
>> +	hwpoison_filter_dev_minor = ~0U;
>> +	hwpoison_filter_flags_mask = 0;
>> +	hwpoison_filter_flags_value = 0;
>> +#ifdef CONFIG_MEMCG
>> +	hwpoison_filter_memcg = 0;
>> +#endif
>> +}
>> +
>> +static void __exit pfn_inject_exit(void)
>> +{
>>  	debugfs_remove_recursive(hwpoison_dir);
>>  }
> 
> The new reset_hwpoison_filter() has no callers?

I'm sorry but I can't figure out why that's missed. I remember I tested this patch
and queued it... Will send a new version and re-test it.
Thanks.
.

