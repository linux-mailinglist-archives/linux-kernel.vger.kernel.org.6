Return-Path: <linux-kernel+bounces-177339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC308C3D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E2B22026
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB81474B0;
	Mon, 13 May 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TFXK6IRs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pIDVAX6s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB01474AF
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588402; cv=none; b=OA7usYK/x739T/tbsV4Vlb2hA765C1bNdDMjEnfxcaU4XpUnlOPFeF+8T1v8nlrmMB7E7zXI+maq6RA+wA/CZeSagz8GmrSzF2qzEQ/n8hjAoiXh8kBkoCqI/fNn/BC7vgWqsnzZIAfW9od+lVG7XqwKZA7ngb90N+k/9WZBDXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588402; c=relaxed/simple;
	bh=1CSO8AntgK1+wkQW/DYUySxa8KRAmgdIAEt//qEydds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcl5+2uNSHNDG70lvwsGeYaAO2MLHahiRpVP1fT+a6Zzou4Bf8BkPj3370bt5rR4ItWGYn5MmoIjuNRhkS2nVR7Y3jUinKpl2DaFNnDPyILk4qaJDnd0a4meuftwEoxHvt7gcKgIbUnS6UIdTELxaUxj0uXj8YpeuRS1tF460Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TFXK6IRs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIDVAX6s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 May 2024 10:19:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715588397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1CSO8AntgK1+wkQW/DYUySxa8KRAmgdIAEt//qEydds=;
	b=TFXK6IRsRUOXXYBIoE21++iOaAF33lC4RfJGuoBu1KmSCqFH7sD2TWJGmwY1tNpJwRgB7W
	3l0IoErHM+dWkh4NxdOD7Rv0/cZ0R11EAqeQZVo9CMOX60mB74Pr5d5962PViQjpxCwCW8
	MpgJYXLQjd5BoQ5ZcDn2Rv/D+1aoQpESzODmpN40LpnE8SZdsDXJcT4XRITYEA9E4ikfEx
	wztlFEh7CYTZJoFOjp49ciRZ13T1buU4eJrCXAIycSFVrjJR+GbAKqkVZDgJJGYwAZP2+E
	OawjyrS0x14DL1Xuia80NgISDpJooSRkloHIH0chAlSvE6csXnFwxYz+5GviZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715588397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1CSO8AntgK1+wkQW/DYUySxa8KRAmgdIAEt//qEydds=;
	b=pIDVAX6sYRky2x2n9kvHBw6ETSmFLn3+1yZEp/OZ8W6NIhOaUg1qW3KEOcavnP8ctqNKpT
	9pTggII6nv5O+vAg==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] remove size limit on XIP kernel
Message-ID: <20240513081941.A_sou6Zn@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
 <46c70799-87b1-4478-95bb-4d4c90519f5b@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c70799-87b1-4478-95bb-4d4c90519f5b@ghiti.fr>

On Sun, May 12, 2024 at 05:47:24PM +0200, Alexandre Ghiti wrote:
> XIP kernels are intended for use with flash devices so the XIP_OFFSET
> restriction actually represents the size of the flash device: IIRC this 32MB
> was chosen because it would fit "most devices". I think it would be good to
> come up with a mechanism that allows to restrict the size at build time: a
> config? XIP kernels are custom kernels so the user could enter its flash
> size so that if kernel ends up being too large, it fails. And by default, we
> could a very large size to avoid kernel test robot build failures.

I'm not sure if it is beneficial to do that. Users' flash tool would
complain about the kernel not fitting in flash anyway. I think this would
only make it (a bit more) complicated to build the kernel.

Furthermore XIP_OFFSET at the moment is not the flash size, it is size of
text (and some other read-only sections). Kernel's data sections are in
flash too, which is copied to RAM during boot.

With the current linker setting, the first 32MB of virtual memory is
occupied by .text. Then at 32MB offset, .data section starts. So if
XIP_OFFSET limit is exceeded, the kernel's size is already way more than
32MB.

Instead, this series moves .data and .text right next to each other (well,
almost, because we need PMD_SIZE alignment). So that if .text size exceed
32MB, the offset that .data resides would increase as well.

If we really want to set flash size during build time (which, again, I
doubt the benefit of), this series would still be relevant: it is not just
removing the size limit, it is also removing the fixed position of the
data section in virtual address space (in other words, removing the
useless "hole" between .text section and .data section).

Best regards,
Nam


