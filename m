Return-Path: <linux-kernel+bounces-172679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F07748BF54B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903C2B22F53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274271400B;
	Wed,  8 May 2024 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qLRemblb"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D988F54
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715143517; cv=none; b=JDKf3NSX/W9E2Ra3CBuphE6mx4lAO0771v3hNAaqHIA6Hq2pcGvoL0pOkhRHNkTDVa1Rl9Pf/XOqtVpxMnctnP2uWUPIMzp5M4M72GUTmwEEldbN1otSi9mHVdLl+4m1BCZygx0M5b+zF5a3IwSIWWvFbNqFhlnZEXZECx5r1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715143517; c=relaxed/simple;
	bh=7K/tmlVgXG49MALg2kjDNBRdw0rBc3JcCevvdJGqKtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jaubd6US6UtXZSvPjfh3o28XAA+gSIcmbezOFNyGe1dpd9NzuZGLD9TUT7SaE16Bt1Qw+dacbFf6PDRao0+uxSsckndyo9nkHniSWRPXTXk8DHuy54VLMvxWXcY5iS5HyTu5N9q3TCzNP2QBYMup97m3IdDfepd4Q5lz8iRXP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qLRemblb; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715143512; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kTucrfHFdxw054v8j1MMXBfCRp3gtNulb6jlF9RCvOo=;
	b=qLRemblbcNPMdHJAn8m+T0LgHT7ip7s9Ho7fMgAg1V0Qzp6LBdMo6jzd/SrbB/5mnwDlhPCcwZDYfIXein7W17rJSYuLFtZQfnjCfSTFCNI8ySm19USANoNyGBzQJWFdcLdYZWAfUGLy6dX4LIBGG0IAz5b/3361mkKmyZNVtzE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W62EHYc_1715143509;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W62EHYc_1715143509)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 12:45:10 +0800
Message-ID: <0b3735bc-2ad7-44f8-808b-37fc90d57199@linux.alibaba.com>
Date: Wed, 8 May 2024 12:45:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm: shmem: add multi-size THP sysfs interface for
 anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <6b4afed1ef26dbd08ae9ec58449b329564dcef3e.1714978902.git.baolin.wang@linux.alibaba.com>
 <30329a82-45b9-4e78-8c48-bd56af113786@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <30329a82-45b9-4e78-8c48-bd56af113786@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/7 18:52, Ryan Roberts wrote:
> On 06/05/2024 09:46, Baolin Wang wrote:
>> To support the use of mTHP with anonymous shmem, add a new sysfs interface
>> 'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>> directory for each mTHP to control whether shmem is enabled for that mTHP,
>> with a value similar to the top level 'shmem_enabled', which can be set to:
>> "always", "inherit (to inherit the top level setting)", "within_size", "advise",
>> "never", "deny", "force". These values follow the same semantics as the top
>> level, except the 'deny' is equivalent to 'never', and 'force' is equivalent
>> to 'always' to keep compatibility.
> 
> We decided at [1] to not allow 'force' for non-PMD-sizes.
> 
> [1]
> https://lore.kernel.org/linux-mm/533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com/
> 
> However, thinking about this a bit more, I wonder if the decision we made to
> allow all hugepages-xxkB/enabled controls to take "inherit" was the wrong one.
> Perhaps we should have only allowed the PMD-sized enable=inherit (this is just
> for legacy back compat after all, I don't think there is any use case where
> changing multiple mTHP size controls atomically is actually useful). Applying

Agree. This is also our usage of 'inherit'.

> that pattern here, it means the top level can always take "force" without any
> weird error checking. And we would allow "force" on the PMD-sized control but
> not on the others - again this is easy to error check.
> 
> Does this pattern make more sense? If so, is it too late to change
> hugepages-xxkB/enabled interface?

IMO, this sounds reasonable to me. Let's see what others think, David?

