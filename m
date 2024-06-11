Return-Path: <linux-kernel+bounces-209204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E356F902ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D69284B67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3B44C64;
	Tue, 11 Jun 2024 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ERtlFG9u"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203B15AD96
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074780; cv=none; b=XZu4VUELTvkktJ2CfqEP77Mzh52jhAJVsDZ0kq1JVXG0gHCR/SRI0zmX1FPWJCAfHjjyeTDhh1AHY1i2RRDhB9EGOFZXGOOGEHU78G6dVUYJ0B+Xt2By+x5J4XOnhzIhLeWpSBSiqh5IFjDBTP+XIxMyFteUIUKqkvbK7O1VmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074780; c=relaxed/simple;
	bh=PmpLdm2+8aspNsynmC96eXf7FxM1IiPeXPaNJKf0cOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8kKqDPa+wRR3X4ZPecLvSA06S377b8ZZ1XJ8/SGqWVb76m1G2WvgjeR/FOubnG/W21t7bWN6X/3yEbRgijg2NbPTNiAJa13Cmym5obRp9eRg1J/qjmPG54tBUe1BDaJsCyPyumnOq57xG8J5jkrzYEfJnnYEyD89180oEVjoX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ERtlFG9u; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718074770; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jqbfjcIqKsbhmmZ6dLRwAkOAJpLyJkndAwkDmIiGK+Q=;
	b=ERtlFG9uV6bNB/b1qGH2wt3sFOgvp3WiadMjJMsF4XP2P+JD5xFg+PVzmN3jzJINrlQR2cIlPhHQ/9OkmOHn0fSQ4+WiFd0m+PZ5/dT9ASpOfPiZ6a2BSDQyv2lZiLK+hT+36lFXPmQdqH1vGaWLynOr9f0WQGVncwe6IznMeIw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8Ekx9h_1718074767;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8Ekx9h_1718074767)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 10:59:28 +0800
Message-ID: <7c834335-9872-4de3-9e53-179356826c93@linux.alibaba.com>
Date: Tue, 11 Jun 2024 10:59:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] mm: shmem: extend shmem_partial_swap_usage() to
 support large folio swap
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "david@redhat.com" <david@redhat.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "chrisl@kernel.org" <chrisl@kernel.org>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
 <358924679107339e6b17a5d8b1b2e10ae6306227.1717673614.git.baolin.wang@linux.alibaba.com>
 <CGME20240610145327eucas1p1bb32a985f8eaddf8cdda0b5415c1868c@eucas1p1.samsung.com>
 <qlk2dpg2fmro5vzjks45ciwt3qk6nzlurfmlqnjr4ecskgg7ln@w5ba55tgtcsb>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <qlk2dpg2fmro5vzjks45ciwt3qk6nzlurfmlqnjr4ecskgg7ln@w5ba55tgtcsb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/10 22:53, Daniel Gomez wrote:
> Hi Baolin,
> On Thu, Jun 06, 2024 at 07:58:54PM +0800, Baolin Wang wrote:
>> To support shmem large folio swapout in the following patches, using
>> xa_get_order() to get the order of the swap entry to calculate the swap
>> usage of shmem.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index eefdf5c61c04..0ac71580decb 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -865,13 +865,16 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>>   	struct page *page;
>>   	unsigned long swapped = 0;
>>   	unsigned long max = end - 1;
>> +	int order;
>>   
>>   	rcu_read_lock();
>>   	xas_for_each(&xas, page, max) {
>>   		if (xas_retry(&xas, page))
>>   			continue;
>> -		if (xa_is_value(page))
>> -			swapped++;
>> +		if (xa_is_value(page)) {
>> +			order = xa_get_order(xas.xa, xas.xa_index);
>> +			swapped += 1 << order;
> 
> I'd get rid of order and simply do:
> 
> 	swapped += 1UL << xa_get_order()

OK. Will do.

