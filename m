Return-Path: <linux-kernel+bounces-280295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C994C84E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BCC1C218FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E811CBD;
	Fri,  9 Aug 2024 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAap1o15"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A761FDA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168606; cv=none; b=DcioiIi01coA7H4WfrsK22EqjoWgZJqhXq8RBqmwvacwmubXArDbx53nomR0aA0sALM/yiWY8QHTLSUw+bkuQ++a11uIGWw+FJvgGbMjTbyfBlYJTL38jyJM1J1aLfp9ONLCh1Fu7Vumh90S0HSobZfeV8yvnHPmq+btmBMFXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168606; c=relaxed/simple;
	bh=AYqBfcLIGvKyMN4Fst4VwqldNre81h6AspCkSNAB8fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSv3WL7k6YszU165jZe9WABddhKbN38els+IYbQCbjiM3/6MKTKsaUP5fulvxkeKw5mWZT/K6wXRQf6ehCVmFtT+NAb3I4Ch5qAKKC5w3RFEz0XEVBU9Z7WJcxp/9F0e6SUZ28VFrDfxrDfQtB6GMG5x0K/nC/Rqg86Df65oVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAap1o15; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723168603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyrDIWJ+gklz3sPzX8cNbptE71/BtV5PAo33v+52O2s=;
	b=XAap1o15wzVLTuboPq0/VPi9F50XnEImRXrWouZDMv3Bj4K/mgzMrDeW11TbIOKQskxn2n
	g3Sys4JZdGj3gPp6lYs+xyaJIEIZwH6mUUboPowCDYw9Vwmf2vNecXzQAEbBbRFesJO1gp
	A7+0UcFGBbhhZAuxwkL+n2N/Ns2UlxI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-lLrDmAUfPZKPUWNQa4x6NQ-1; Thu,
 08 Aug 2024 21:56:36 -0400
X-MC-Unique: lLrDmAUfPZKPUWNQa4x6NQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A01801944CCC;
	Fri,  9 Aug 2024 01:56:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E10BC300018D;
	Fri,  9 Aug 2024 01:56:30 +0000 (UTC)
Date: Fri, 9 Aug 2024 09:56:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
	akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZrV3SQZ43mgymxcr@MiWiFi-R3L-srv>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
 <ZrJ1JkyDVpRRB_9e@arm.com>
 <ZrJ60vopeGDXFZyK@arm.com>
 <e01df216-0225-ef49-8eb3-2ccdcb424785@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01df216-0225-ef49-8eb3-2ccdcb424785@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/08/24 at 03:56pm, Jinjie Ruan wrote:
> 
> 
> On 2024/8/7 3:34, Catalin Marinas wrote:
> > On Tue, Aug 06, 2024 at 08:10:30PM +0100, Catalin Marinas wrote:
> >> On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:
> >>> On 08/02/24 at 05:01pm, Jinjie Ruan wrote:
> >>>> On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> >>>> will cause system stall as below:
> >>>>
> >>>> 	 Zone ranges:
> >>>> 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> >>>> 	   Normal   empty
> >>>> 	 Movable zone start for each node
> >>>> 	 Early memory node ranges
> >>>> 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> >>>> 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> >>>> 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> >>>> 	(stall here)
> >>>>
> >>>> commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
> >>>> bug") fix this on 32-bit architecture. However, the problem is not
> >>>> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> >>>> architecture, for example, when system memory is equal to
> >>>> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
> >>>
> >>> Interesting, I didn't expect risc-v defining them like these.
> >>>
> >>> #define CRASH_ADDR_LOW_MAX              dma32_phys_limit
> >>> #define CRASH_ADDR_HIGH_MAX             memblock_end_of_DRAM()
> >>
> >> arm64 defines the high limit as PHYS_MASK+1, it doesn't need to be
> >> dynamic and x86 does something similar (SZ_64T). Not sure why the
> >> generic code and riscv define it like this.
> >>
> >>>> 	-> reserve_crashkernel_generic() and high is true
> >>>> 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> >>>> 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
> >>>> 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> >>>>
> >>>> Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
> >>>> to simplify crashkernel reservation code"), x86 do not try to reserve crash
> >>>> memory at low if it fails to alloc above high 4G. However before refator in
> >>>> commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
> >>>> crashkernel reservation"), arm64 try to reserve crash memory at low if it
> >>>> fails above high 4G. For 64-bit systems, this attempt is less beneficial
> >>>> than the opposite, remove it to fix this bug and align with native x86
> >>>> implementation.
> >>>
> >>> And I don't like the idea crashkernel=,high failure will fallback to
> >>> attempt in low area, so this looks good to me.
> >>
> >> Well, I kind of liked this behaviour. One can specify ,high as a
> >> preference rather than forcing a range. The arm64 land has different
> >> platforms with some constrained memory layouts. Such fallback works well
> >> as a default command line option shipped with distros without having to
> >> guess the SoC memory layout.
> > 
> > I haven't tried but it's possible that this patch also breaks those
> > arm64 platforms with all RAM above 4GB when CRASH_ADDR_LOW_MAX is
> > memblock_end_of_DRAM(). Here all memory would be low and in the absence
> > of no fallback, it fails to allocate.
> > 
> > So, my strong preference would be to re-instate the current behaviour
> > and work around the infinite loop in a different way.
> 
> Hi, baoquan, What's your opinion?
> 
> Only this patch should be re-instate or all the 3 dead loop fix patch?

I am not sure which way Catalin suggested to take. 

Hi Catalin,

Could you say more words about your preference so that Jinjie can
proceed accordingly?

Thanks
Baoquan


