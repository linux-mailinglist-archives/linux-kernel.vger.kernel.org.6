Return-Path: <linux-kernel+bounces-570912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C130BA6B62D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951CF188C091
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E511EFFAC;
	Fri, 21 Mar 2025 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="as1rQeXY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BEC1E571A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546639; cv=none; b=EbGMlIARGkvvR6iL3fRenVOoS3FY0yrG23dCQ04XAUT7F8S4WzIWuMiX+A6TpXbHDJRI4NczlyHnyFdIBgbvfpHCOYwPcfGD4imvc6iE1Tnq+3PPeExmyHdEQaswJkOLOaZZZEZ8AP+0uQpl75uafIZyLjNHqeCMmPD/4Gs0RuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546639; c=relaxed/simple;
	bh=ZdMfirDqSxAiPoPdpxSL5z49ZYOXEt3ILIkDPg+hh20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnh7kC3D8XeUhtuVl0ueKiW+yFKfpLS1W9VWE0fUc3tbH5bRVVMRW5fTnyP4RHP/Hfp6f2Sz+cFjozgov2Kkkk1vhHk61nmtxedqhp3VM2GJhHdIYuWMkJ3Z8mYvl/zdJrxQhib7G5DaqHKTT0KGmxvvnRUhMtiWR4C9/wREcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=as1rQeXY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742546635;
	bh=ZdMfirDqSxAiPoPdpxSL5z49ZYOXEt3ILIkDPg+hh20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=as1rQeXYhMnRaCsPd82RZzQU24/nZIXzO2nWZ38SWBHexkWFTP7YGf+rzmQ6F5bhk
	 XzGjRo2wCg7bndfyV2H/qCXP/UH3Z9P/IM+sNDbkNfpTomHk7MDNKvEr+oe22NR2+C
	 Cm+K/shgkc30CRv+54GeWItwZLYcJdXRXIPdPbCAEw4sq5cdy/Mfmfrti9RLJw3AZ/
	 ubgjrfISesgmRAxqrfayIYQINo60GkcCZtncqDaz5grVFi+dNTYP6EOM8uvbKACCsd
	 b2ExAGklSfxooLTk04H+HbjhEPT6bv+qk4k/WBLVmwMNx1VIK5XeQwKqopIUoaAAuG
	 4D1XNzd+TFqsw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E158717E0EA9;
	Fri, 21 Mar 2025 09:43:54 +0100 (CET)
Date: Fri, 21 Mar 2025 09:43:51 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] drm/panthor: Move GPU info initialization into
 panthor_hw.c
Message-ID: <20250321094351.537c768c@collabora.com>
In-Reply-To: <20250321091645.0edec07a@collabora.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
	<20250320111741.1937892-5-karunika.choo@arm.com>
	<20250321091645.0edec07a@collabora.com>
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

On Fri, 21 Mar 2025 09:16:45 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Thu, 20 Mar 2025 11:17:36 +0000
> Karunika Choo <karunika.choo@arm.com> wrote:
> 
> > This patch moves GPU info initialization into panthor_hw.c in
> > preparation of handling GPU register changes. The GPU register reading
> > operations to populate gpu_info are separated into an architecture
> > specific arch_*_gpu_info_init() function and is called via the new
> > function pointer abstraction under hw.ops.gpu_info_init().
> > 
> > Future GPU support will be performed by implementing a *_gpu_info_init()
> > function specific to that architecture version. It can call any existing
> > *_gpu_info_init() and extend it with additional register reads or
> > provide an entirely different implementation.  
> 
> Could you give us an insight into what the reg layout changes are? So
> far, they were mostly unchanged between GPU gens, and I'd really
> prefer we could keep the majority of them unchanged part of the commo 
> discovery, and only add the missing reads in the ->gpu_info_init()
> callback.
> 
> Note that I'm also working on abstracting mali device operations to add
> JM support to panthor, and the only things I had to specialize are:
> 
> - CSF ID for CSF
> - JS features/present masks for JM
> 
> The rest is just common. So what I have is a common gpu_init_info()
> helper that reads all the regs excepts those two, and after that, I
> have a device ops selection based on the arch major of the GPU ID [1].
> The device-specific GPU info are then read as part of the
> panthor_device_ops::init().

With the link this time :-).

[1]https://gitlab.freedesktop.org/bbrezillon/linux/-/blob/panthor-jm/drivers/gpu/drm/panthor/panthor_device.c?ref_type=heads#L359

