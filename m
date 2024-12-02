Return-Path: <linux-kernel+bounces-427991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5949E08FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A6AB602F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6F17ADF8;
	Mon,  2 Dec 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XKBtSZCW"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D5199247
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156599; cv=none; b=SWoVSqMXVICasQNLzUgTFKrsBGtC/KUMZ1CXmbmkwU10wTb/O6h2s12Q/cbqmXpMUMI+xsctWXj30aPxVbNihtbNIf+ghqsP0DmiYL/BsRX3lw3bx5XbzzR5DCPQuP/e8XBSFF8Uw1fmrCzkbFSeocs05k0tWOIaK4Hhbw77idU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156599; c=relaxed/simple;
	bh=ugdVppW8juyRlhhNq19nPDvRjbcXBKrkN6I/bQYhG6c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rYPg0JCTi2mldyRt9OHJbeBU4btg10JMG9FxP+6JNRm3VUyd/vUDf9a/D2H5V0L4vzMawYIDLpCw4KFTFGHElGUUZAtuM3iliFXCv6R6gBln6IH4Lmm1jSr2JLvLLbujLG+9laD18hhKL8XLNujYxLZBeH3lFVqjLst+JP5E/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XKBtSZCW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dfc53da9-a1ab-4ab3-aba2-d100f7f28b9b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733156595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvjxvbdDBtxu8PObVD+qZOh1eqejb+O6JBTeogYSI8g=;
	b=XKBtSZCWe1Rfta+EIUmnGiiAKHLAwtln2MaIgFP4o3zHtwXtJa9yqEffur+A6fFd6RheLN
	Frf4vTc0IltmesoinEHUx6sYP63g5Ga3IoPblAMOtBkNE+1Wbs0xXkrLAXhakQ+QeEm7B8
	1C3ckdFd02yQQg8Ir2KTLq9H5/dIIRY=
Date: Tue, 3 Dec 2024 00:23:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v2] loongarch/mm: disable WUC for pgprot_writecombine as
 same as ioremap_wc
To: Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>,
 Icenowy Zheng <uwu@icenowy.me>, Huacai Chen <chenhuacai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Baoquan He <bhe@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Zhihong Dong <donmor3000@hotmail.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231009042841.635366-1-uwu@icenowy.me>
 <4f1af31b-15be-cb47-6b34-45de1b5696be@loongson.cn>
 <42b0e6f6-c2b5-49c6-b1f2-0200bef913da@xen0n.name>
 <3641d3fe-c2e7-868f-ab0d-3951c9a78b6d@loongson.cn>
 <8373ccfd93b0402caf9f5c06a2d9b93b3c0d0b49.camel@xry111.site>
Content-Language: en-US, en-AU
In-Reply-To: <8373ccfd93b0402caf9f5c06a2d9b93b3c0d0b49.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 10/10/23 20:26, Xi Ruoyao wrote:
> On Tue, 2023-10-10 at 11:02 +0800, Sui Jingfeng wrote:
> 
>>
>> On LoongArch, cached mapping and uncached mappings are DMA-coherent and guaranteed by
>> the hardware. While WC mappings is *NOT* DMA-coherent when 3D GPU is involved. Therefore,
>> On downstream kernel, We disable write combine(WC) mappings at the drm drivers side.
> 
> Why it's only an issue when 3D GPU is involved? 

No one saying that only 3D GPU is suffer from this kind of issue,
I just meant that the issue is there at least for GPU

> What's the difference between 3D GPUs and other devices?  Is it possible that the other
> devices (say neural accelerators) start to perform DMA accesses in a
> similar way and then suddenly broken?

You, the patch contributor or the maintainer or whatever stuff
should carry on the test, right?

We are not intended to against the patch though.

>> - For buffers at VRAM(device memory), we replace the WC mappings with uncached mappings.
>> - For buffers reside in RAM, we replace the WC mappings with cached mappings.
>>
>> By this way, we were able to minimum the side effects, and meet the usable requirements
>> for all of the GPU drivers.
> 
> AFAIK there has been some clear NAK from DRM maintainers towards this
> "approach".  So it's not possible to be applied upstream.

That's your guys problems, stealing other programmer's patch.
And then, submit it to upstream without knowing and/or presenting
decent hardware details.


>> For DMA non-coherent buffers, we should try to implement arch-specific dma_map_ops,
>> invalidate the CPU cache and flush the CPU write buffer before the device do DMA. Instead
>> of pretend to be DMA coherent for all buffers, a kernel cmdline is not a system level
>> solution for all of GPU drivers and OS release.
> 
> IIUC this is a hardware bug of 7A1000 and 7A2000, so the proper location
> of the workaround is in the bridge chip driver.  Or am I
> misunderstanding something?
> 

You are misunderstanding everything and ranting like a dog.

The write buffers are inside the CPU, and the write-combine is related
to *both* the CPU side and the GPU side. The GPU side could choose
no snooping access mode, while the CPU side have to address such request
properly.

What's we arguing is that if this is a hardware bug of north bridge, we
at least still should be able to use WC at the CPU side, that is, WC on
system pages should be usable without any issue. While the weird commit
disable everything.



