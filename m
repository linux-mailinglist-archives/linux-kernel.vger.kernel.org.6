Return-Path: <linux-kernel+bounces-567540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B6A68781
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9817A2670
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58272512D9;
	Wed, 19 Mar 2025 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ar7Mw0Es"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316A2116ED
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375360; cv=none; b=nF3FffCHvknzrv/Ze/WpGzA39Azm7XATMBIdTNdAgJ5f5cBRCosB+k8tC7wXVKVTp4WkPY2yD/F0wKN1W754u++B+n6Za55E0vdvle1935iD2rqibsoYSGCktN2Om6wzvkMP4JrbiU/neLv0oWKth5VmWomIq5U/qvCsjzU/kOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375360; c=relaxed/simple;
	bh=191iKQoaF9vLV1axISpANOJlbHjP6oiDRSA9x623HU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZwAlZO+wpHQOyruOCQdooVB4NebkC+QdZQ/5E45T5c0q4eBRg37Mkcd7cRmpAWqq5H10Z+ioEcCSUqDfOOmR/Xxa/I07IkKFvCLWWSeExDSjKKpr3Defx13F/15d/YApBf95P2rJNCxPBjLv0GYEsH/SOZ69yC4ovaTA1PK0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ar7Mw0Es; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742375349; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bfc9kxkAuw3mjk8Scit15keQ5EfG0V41bGKUho+s6Pc=;
	b=ar7Mw0Esg0nHQnMqKXiabTzuSKiIuLE47b5pHJ9qlfExd0h1KWqJtT3ZahjgjM+zX5spqjLkGMayw0IFBAoWZ7FVAZuC0R4lqQLYrAZH+b2tqhW7sM4ePVJMlQyqAtf5R7wdPbIr8CTuFuorZTZ2eaL+y0OvfWWlBGa8Q/GFp+o=
Received: from 30.74.128.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS2FPYf_1742375347 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 17:09:07 +0800
Message-ID: <64a43d16-606c-4255-8a8b-96d6e4e44729@linux.alibaba.com>
Date: Wed, 19 Mar 2025 17:09:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, bingbu.cao@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com, rppt@kernel.org,
 ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com,
 vivek.kasireddy@intel.com, Huan Yang <link@vivo.com>
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
 <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
 <20250318083330.GB18902@lst.de>
 <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
 <20250318084453.GB19274@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250318084453.GB19274@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/18 16:44, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 04:39:40PM +0800, Huan Yang wrote:
>> A folio may be 2MB or more large 1GB, what if we only need a little, 1M or 512MB, can vmap based on folio can solve it?
> 
> Then you only map part of it by passing a length argument.  Note that
> in general when you have these large folios you also don't have highmem,
> so if you only map one of them, or part of one of them you don't actually
> need vmap at all and can just use folio-address..
> 
>> Normally, can offer 4k-page based array map it. But consider HVO, can't. That's why wanto base on pfn.
> 
> Well, for any large folio using this 4k based page interface is
> actually highly inefficient.  So let's fix that.  And my loop in
> willy as Mr. Folio while you're at it.

The minimum map unit is page size instead of variable-size folio.

For many cases, vmap (to combine many partial folios) is useful
(instead of split all folios to order-0 folios in advance) but
I agree page array may be inefficient.

So I don't think another folio vmap() version is better overall
anyway.

Thanks,
Gao Xiang


