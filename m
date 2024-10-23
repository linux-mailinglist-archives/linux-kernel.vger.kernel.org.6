Return-Path: <linux-kernel+bounces-377757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA79AC64E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DCE2B22AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66C19924A;
	Wed, 23 Oct 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sYjj+EVj"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2019C15B547
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675555; cv=none; b=oKlI8LYdmids7lLfZ9NYuJ/7F5KMNHMpolIfTYtEQxzGKV3AYWjor/OlbGz4F5qNdeW8PiHAgYf9wMUFTi3Eq7CFTGDojtoajtiSer7QursOc2rkp5URsujDirpgYRxuomXPgYd2UByobtsw1WIFjFAjIkI6L3ut2c3nwje/o9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675555; c=relaxed/simple;
	bh=X+9a52f/mW4zljBMMz452fVO7AQnEac/mWJQIutNCBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKFP2MS2AYBvKDsi/GcEfrwNORslTybt2P7up7hoR1ULuGTGmB5wW55JL77PlR3kGoPgoWWTw/b4waPaKZK3qrndQmZ3Be8N/shI8P5MlXrhWF//sLx+LlxcSNBok0pkFPXlE7+ZSlNDS3oZz8Nr3dzjVsYN45uptRD5ekMu0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sYjj+EVj; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729675545; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yxXS3+bQyqBkscqfDOpVpVT+Gz8HUJErpJMhoB5zdsY=;
	b=sYjj+EVjNs3/2VL6JbuzZnuEB+P6JDViSuPqqOrNFm93F8ArqWObhGJ85E1RcC88DqmOlgySEkVD31Pl8K5ex7JVbMic3w9aFQAR2etYV9Iy/rjg2jR1cLv6wwkO62i8mGPQTLS28TQqQB+lhYtY6r8GOpohwHb0VoCNT1niLr0=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHkxOvT_1729675543 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Oct 2024 17:25:43 +0800
Message-ID: <f1aa025b-b3f2-4667-b628-3f0f17f5fe76@linux.alibaba.com>
Date: Wed, 23 Oct 2024 17:25:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, ioworker0@gmail.com,
 da.gomez@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <2c6b7456-8846-44b0-8e58-158c480aaead@linux.alibaba.com>
 <5p22lehyjjzxvohppdmt2vkkplrrd6ss6tev2px6troxyii4ab@eaphjvxiwrfc>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5p22lehyjjzxvohppdmt2vkkplrrd6ss6tev2px6troxyii4ab@eaphjvxiwrfc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/22 18:06, Kirill A. Shutemov wrote:
> On Tue, Oct 22, 2024 at 11:34:14AM +0800, Baolin Wang wrote:
>> IIUC, most file systems use method similar to iomap buffered IO (see
>> iomap_get_folio()) to allocate huge pages. What I mean is that, it would be
>> better to have a real use case to add a hint for allocating THP (other than
>> tmpfs).
> 
> I would be nice to hear from folks who works with production what the
> actual needs are.
> 
> But I find asymmetry between MADV_ hints and FADV_ hints wrt huge pages
> not justified. I think it would be easy to find use-cases for
> FADV_HUGEPAGE/FADV_NOHUGEPAGE.
> 
> Furthermore I think it would be useful to have some kind of mechanism to
> make these hints persistent: any open of a file would have these hints set
> by default based on inode metadata on backing storage. Although, I am not
> sure what the right way to archive that. xattrs?

May be can re-use mapping_set_folio_order_range()?

