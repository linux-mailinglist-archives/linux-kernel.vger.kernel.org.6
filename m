Return-Path: <linux-kernel+bounces-341227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB55987CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826561F24557
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172C165F0B;
	Fri, 27 Sep 2024 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T2AIKr1c"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3098467
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403182; cv=none; b=r25BKgyA1JMU46GW1iCPephugJzTKrcmVfap079rNc7BEx5D2s9k2gR0DL7FdNBIDmd3uoS0Nwz1hYahFuxw3n0fhA5Ho2uIT8ZcuVev5XGRbjTlEtfucwmIEU56H0Oj74P/PMu8csvfQYjlu1ZlhjVaeMUu9hj0hXiDb4fE05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403182; c=relaxed/simple;
	bh=HIKNMe/niREYnQHq8hp3K+FU495JwDxLsXIyDXtLXYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLDEZ5HIIkOsbIHSRwy4gHI4PyN2jlA5OWuP12JF7x+9eCOn+LIUBannmQsNIzEP+Vn9jRSxeCot1Es/xTj8EjMEP6XL0nQKQLUuNeMcL1EmtiM5/xqAbV/a5SCK7/6KaPkYJjnYgduWoZOvoeI3RnOEdK2idCkZa6De1eF2uIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T2AIKr1c; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727403171; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6CSk17LOoyrQJbMjqeRVf9PJcXpLPrzQR/pZZ3UyV4E=;
	b=T2AIKr1cObzgpitcISQnaytuPuswOFGhUJTrmVLI1fAyBGC7Iw4T1Pdatz/W5kdp3DV5i/a3Yts72WXIYKPv+8SaY2xpPrT7DetlwLnCJXUO8yI92BqDeDjW3QbeTTpVwwEevzR8u18SurHsBvzUImGKG62eTXeP74GOkUjLpQY=
Received: from 30.74.144.105(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFooIys_1727403168)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 10:12:49 +0800
Message-ID: <9011b7cd-f6a9-4cd9-a80d-7536df1c6a60@linux.alibaba.com>
Date: Fri, 27 Sep 2024 10:12:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] mm: shmem: add large folio support to the
 write and fallocate paths
To: Matthew Wilcox <willy@infradead.org>, Daniel Gomez <da.gomez@samsung.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
 <c03ec1cb1392332726ab265a3d826fe1c408c7e7.1727338549.git.baolin.wang@linux.alibaba.com>
 <CGME20240926121649eucas1p2aec9398cab6db6fee1251a1a61568857@eucas1p2.samsung.com>
 <ZvVQoY8Tn_BNc79T@casper.infradead.org>
 <18532bd8-08bd-4494-a3af-fe252a803380@samsung.com>
 <ZvVkM0VWK5E_MfJH@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZvVkM0VWK5E_MfJH@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 21:40, Matthew Wilcox wrote:
> On Thu, Sep 26, 2024 at 02:58:31PM +0200, Daniel Gomez wrote:
>> On 9/26/2024 2:16 PM, Matthew Wilcox wrote:
>>> On Thu, Sep 26, 2024 at 04:27:26PM +0800, Baolin Wang wrote:
>>>> +static inline unsigned int
>>>> +shmem_mapping_size_order(struct address_space *mapping, pgoff_t index, size_t size)
>>>> +{
>>>> +	unsigned int order = get_order(max_t(size_t, size, PAGE_SIZE));
>>>
>>> Why introduce the max_t() call here?  Did nobody read the documentation
>>> or implementation for get_order() before writing this patch?
>>
>> get_order() result is undefined if the size is 0. I've used max_t() here to
>> avoid that case. Perhaps should we prevent that case before getting here?
> 
> Surely we've handled a length-0 write before we get here?
> 
>> I think one of my earlier attemps was to use fgf_set_order + FGF_GET_ORDER()
>> as in iomap. But the solution taken there was to share code between shmem
>> and filemap and that wasn't considered a good idea. Shall we just replicate
>> iomap_get_folio()? Or else, what do you suggest here?
> 
> We could move three of the four lines from fgf_set_order() into a
> new function and call it from both fgf_set_order() and shmem?

Sounds good. How about the following changes? Do you have a perferred 
name for the new helper? Thanks.

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d9c7edb6422b..ce418acd2737 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -629,6 +629,16 @@ typedef unsigned int __bitwise fgf_t;

  #define FGP_WRITEBEGIN         (FGP_LOCK | FGP_WRITE | FGP_CREAT | 
FGP_STABLE)

+static inline unsigned int filemap_get_order(size_t size)
+{
+       unsigned int shift = ilog2(size);
+
+       if (shift <= PAGE_SHIFT)
+               return 0;
+
+       return shift - PAGE_SHIFT;
+}
+
  /**
   * fgf_set_order - Encode a length in the fgf_t flags.
   * @size: The suggested size of the folio to create.
@@ -642,11 +652,11 @@ typedef unsigned int __bitwise fgf_t;
   */
  static inline fgf_t fgf_set_order(size_t size)
  {
-       unsigned int shift = ilog2(size);
+       unsigned int order = filemap_get_order(size);

-       if (shift <= PAGE_SHIFT)
+       if (!order)
                 return 0;
-       return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
+       return (__force fgf_t)(order << 26);
  }

  void *filemap_get_entry(struct address_space *mapping, pgoff_t index);

