Return-Path: <linux-kernel+bounces-172621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C748BF45D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF46B22314
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84593944D;
	Wed,  8 May 2024 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j/qiLOhh"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9499441
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134412; cv=none; b=jAPnoYsD4TR9fDMfAbQymlGJ1l38CUcJXi67LuXpdw6G0PORJIVE6ZhXn3SNR/Cf4QD8B8KZkFlX5O/6Jw+Zv+IobVBEfnI5H084GTCHrmSOYSWn8Y1lDeXNTaMxup5NjSzxuLN5fmfmDi5PejA3hFDbxPwfGI71hTmEuXr8cx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134412; c=relaxed/simple;
	bh=n5QFlSypq32hB2yeYcNZfKutq267CVYUJOO6/Fa/m+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtE3e6P6yuH2frVUDtF0BXqVyorBsXdFB83QCiG1JWAZDHuFfVYntQwfa2Fptt0BlP6cV+buiMLWyXrl/lV4WJruayJwlSqMJVLjccE1CTMGEo0byZl2yZLgkuUBBWU7ul/uyYjcFUxF2HPCyoI+y03kNgHOiuuZWnHtpKybHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j/qiLOhh; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715134407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PnVKvCgegzpzXY1p/Owa2fV8B2MMlLljlSzcXtnLj/4=;
	b=j/qiLOhhXrhZ1kpndUmDgt3GewnErfft8O7iBC23+9/8Dg8Mgo765dhvpqKdANHbX9sZlWWe3SrvOPlmnO66iNn61lg2ovvO4kzVu6Ch2Uta73QvBTx54pqdTfcsHRcx8u+8VNXe4p7KFg636m+ebvRAiuYcwGeQVW4BrugROXk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W61sxpy_1715134404;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W61sxpy_1715134404)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:13:25 +0800
Message-ID: <2fcd6dfc-21b7-4e3f-9741-8f0d23d2da5f@linux.alibaba.com>
Date: Wed, 8 May 2024 10:13:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm: move highest_order() and next_order() out of the
 THP config
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <d9c0ac9df6f6e6176b09fc1ae58146ec4f8d73f5.1714978902.git.baolin.wang@linux.alibaba.com>
 <9576c979-8a11-48e2-aec4-646acf0d8e26@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <9576c979-8a11-48e2-aec4-646acf0d8e26@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/7 18:21, Ryan Roberts wrote:
> On 06/05/2024 09:46, Baolin Wang wrote:
>> Move highest_order() and next_order() out of the CONFIG_TRANSPARENT_HUGEPAGE
>> macro, which can be common functions to be used.
> 
> Sorry if I haven't kept up with the discussion, but why is this needed? I
> wouldn't expect a need to iterate over orders if THP is compile-time disabled
> because we will never try to allocate THP?

Cause I don't want to add some dummy functions to avoid building errors 
if CONFIG_TRANSPARENT_HUGEPAGE is not enabled in patch 6. Another 
thought is that the pagecache can also allocate a large folio even when 
THP is not enabled, so these helpers may be used in the future (not sure 
though).

Anyway, I also have no strong perference for this patch, below dummy 
functions can also work for me:
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c15bebb2cf53..7aa802ee2ce5 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -586,6 +586,16 @@ static inline bool thp_migration_supported(void)
  {
         return false;
  }
+
+static inline int highest_order(unsigned long orders)
+{
+        return 0;
+}
+
+static inline int next_order(unsigned long *orders, int prev)
+{
+        return 0;
+}
  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */

