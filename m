Return-Path: <linux-kernel+bounces-381669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DBF9B0262
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8EF1F2348C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F62227373;
	Fri, 25 Oct 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IgaGPFfk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607F226264
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859519; cv=none; b=oChpSR5noNWIrFfss66kMttKDeFVo9Z8+CUNqnolWMklKaNVJQ4KCPAHBi1E7XikJ8lwPwGP3OIzKdvpDWEVVMTIuLX2IkbFXSUUhNjy3aP16sAoOO8IV6ChFlsfLCFKyCXIvQWhVU8N6UM7754gSH9DzNpv3p/faPcEa6IKdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859519; c=relaxed/simple;
	bh=msp8mzHoL4DQwXpjyctpfR/k+WEDyE0Pk/NxEqt2mvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpUDEMXtRXBwgumSGzuaTch1SPNzI7lqw40Fdpne25LurkkFIg/RIoH7fjW7tLRA7mgFoBVEiBb6MOme0X2tcQ8oVBNVjd5dIECMX4ouh0mQS92TBe4o5XMwZUZNqEb6KC3UvL8NuT1YJmWHwvyongZ3jhh838CTjuzlAnyvrks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IgaGPFfk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729859510;
	bh=msp8mzHoL4DQwXpjyctpfR/k+WEDyE0Pk/NxEqt2mvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IgaGPFfk08mIqEf3c1meSNOb5iYdESPRUoL9HNrIJJqkVOlao0ubkeiz93BbatDZ8
	 60FtHY26G1A6UnzU1cu30gcw/Wy/sHq5T/wO0qbcVdYJPw5YihsWyvspQUYeQnwfiP
	 blzCv/k1QPCknH4D4C0Qeuvg5h7aZsNT4nQHQP5jF/udYUsJA0kqx0ZQDVRjjbfoeD
	 6EWJ2wBWHJmXEGTXzLhmk6BxY/tCt8EUS99FdsLUROXejC16cQridQpr5+j5EkGY54
	 2PUGZjI+tauLBgerQXFwV+AqZOB+hE+z4+Iex4P74Uifi4RwxWb/bib6XaeMkYn3A+
	 q2rbV4ZCgjdDg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 853A117E35F4;
	Fri, 25 Oct 2024 14:31:49 +0200 (CEST)
Date: Fri, 25 Oct 2024 14:31:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Akash Goel <akash.goel@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 steven.price@arm.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, mihail.atanassov@arm.com,
 ketil.johnsen@arm.com, florent.tomasin@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH 1/3] drm/panthor: Update memattr programing to align
 with GPU spec
Message-ID: <20241025143144.625df2b7@collabora.com>
In-Reply-To: <Zxtj0B3BrMYDt9ID@e110455-lin.cambridge.arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
	<20241024145432.934086-2-akash.goel@arm.com>
	<20241024174944.4e811816@collabora.com>
	<Zxtj0B3BrMYDt9ID@e110455-lin.cambridge.arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 10:24:32 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Thu, Oct 24, 2024 at 05:49:44PM +0200, Boris Brezillon wrote:
> > +Robin for the MMU details
> > 
> > On Thu, 24 Oct 2024 15:54:30 +0100
> > Akash Goel <akash.goel@arm.com> wrote:
> >   
> > > Mali GPU Arch spec forbids the GPU PTEs to indicate Inner or Outer
> > > shareability when no_coherency protocol is selected. Doing so results in
> > > unexpected or undesired snooping of the CPU caches on some platforms,
> > > such as Juno FPGA, causing functional issues. For example the boot of
> > > MCU firmware fails as GPU ends up reading stale data for the FW memory
> > > pages from the CPU's cache. The FW memory pages are initialized with
> > > uncached mapping when the device is not reported to be dma-coherent.
> > > The shareability bits are set to inner-shareable when IOMMU_CACHE flag
> > > is passed to map_pages() callback and IOMMU_CACHE flag is passed by
> > > Panthor driver when memory needs to be mapped as cached on the GPU side.
> > > 
> > > IOMMU_CACHE seems to imply cache coherent and is probably not fit for
> > > purpose for the memory that is mapped as cached on GPU side but doesn't
> > > need to remain coherent with the CPU.  
> > 
> > Yeah, IIRC I've been abusing the _CACHE flag to mean GPU-cached, not
> > cache-coherent. I think it be good to sit down with Rob and add the
> > necessary IOMMU_ flags so we can express all the shareability and
> > cacheability variants we have with the "Mali" MMU. For instance, I
> > think the shareability between MCU/GPU can be expressed properly at the
> > moment, and we unconditionally map things uncached because of that.  
> 
> Boris, did you mean to say "shareability between MCU/GPU *can't* be expressed
> properly" ? Currently the sentence reads a bit strange, as if there was a
> negation somewhere.

Yes, sorry, I meant "can't".

