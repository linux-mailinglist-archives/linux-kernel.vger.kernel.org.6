Return-Path: <linux-kernel+bounces-211267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBCA904F48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E229A1C22364
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F116DED0;
	Wed, 12 Jun 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AOrJ5cGv"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192716D4F6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184546; cv=none; b=sI9IOSdhOai7EIcSuSLEvDhWUdhWR2k88EtSm+QMkRMAUEuGgQEZch6S6weu8AfYd3UMT33MnONUnMWSf/2exqYEBIetmeO9tpVvq3cTZ/6LluV4TU5saeauaKkBdkOHbpJuYiTwCje16WrkA8K/e8Pw8OhWE9lQ3jI1qmZVoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184546; c=relaxed/simple;
	bh=GqwZyjbDTb2LW7L7RQnUs/jhE0c2peodbic9mCWJ92k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyC8X1epmBLqhYjwZS+Q2yFFAXgVL69spHO92aNAo0OH+sa+S7z9gYJBm6CCYAvgTVA/Ul2K2W4KomPeZokB7QkYMNt2JJJTTmMEGCgffQFhVEG1TGFpzNsVXQGrNmUuxKRyAiw/GewoQ7yFbwe9LuV+sgf/AovPnYv5EcCjn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AOrJ5cGv; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718184536; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UvzU82ARd3O0HY9mewpe3B6t/gdUxhobUBIFn6ECcTE=;
	b=AOrJ5cGvHTZu6JJN0yuO8HocECn/U5Fa5twm3KxBcnPKfd9wpnKLVLTDlHB1dcOf6eQdTk9h/ehYMBIv8MA6P/7WcEX74eh6e7/z+yNHJm2povRcrvBJAAuMNLy6ZYjIB6AflUbRxqZoRyB0DjpZhW2qJLmF73d0cisqb+T/lTs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8KLpTr_1718184503;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8KLpTr_1718184503)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 17:28:54 +0800
Message-ID: <aef7c71e-5aff-4ce3-a2a9-8df930232af8@linux.alibaba.com>
Date: Wed, 12 Jun 2024 17:28:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] mm: memory: extend finish_fault() to support large
 folio
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <3a190892355989d42f59cf9f2f98b94694b0d24d.1718090413.git.baolin.wang@linux.alibaba.com>
 <DF94C669-963F-4BA7-81A1-B25031D2365A@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <DF94C669-963F-4BA7-81A1-B25031D2365A@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/11 22:38, Zi Yan wrote:
> On 11 Jun 2024, at 6:11, Baolin Wang wrote:
> 
>> Add large folio mapping establishment support for finish_fault() as a
>> preparation, to support multi-size THP allocation of anonymous shmem pages
>> in the following patches.
>>
>> Keep the same behavior (per-page fault) for non-anon shmem to avoid inflating
>> the RSS unintentionally, and we can discuss what size of mapping to build
>> when extending mTHP to control non-anon shmem in the future.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/memory.c | 57 +++++++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 47 insertions(+), 10 deletions(-)
>>
> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks Zi for reviewing.

