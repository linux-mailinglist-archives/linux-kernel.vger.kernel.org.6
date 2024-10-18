Return-Path: <linux-kernel+bounces-371639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A39A3DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE50282FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0518EAB;
	Fri, 18 Oct 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Nx0l7yN9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B712B94
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252757; cv=none; b=RSNTjLIp+qXMAmza8Mb9H3BDvZYA+XuAwwlqJn8Z1s8K9zxXvidcyttxGvpxvEAodRiDa6CBCP4M1araNFnrSfZUx0MO+0H6MfbayMPbr2rlgJGmf3h6MuuSkbpZaNJ5qESoaKnBFk5HdNy/6mTbLw2JdMtJKRkq3G0k+r+xebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252757; c=relaxed/simple;
	bh=jLdGFAnByKk4EDXuBUQdIKnZTDQytV94tH7DytBqpO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXee3Gf5iGh0A8+QnejjTQK95Vs7jmLlyKh2ZobrXmOWrIP+yMbhsv/F+EIZD5dOGL2SM63g1yUCe7bIlG1wBfOnOHzZzeLRTP50uQcSePExABkshrdubi7z70HgE4wKav9APlGSuS3gbNShMEGzlM7xh0Gjp1K9+2tZot/kRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Nx0l7yN9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B470440E0169;
	Fri, 18 Oct 2024 11:59:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 73rrnD_nvut5; Fri, 18 Oct 2024 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729252748; bh=eztp7n7uogd10ZGbLvrjPAJ3XLEfcBGrLeqx+A6CC3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nx0l7yN9r4lawVctvtg6dlu7U8K04J0u3h1yn7ocbl/ESDNf9D/WBWBI1f/TLmPPN
	 EITKZhuth340Bm5gJHyzPztY3X33+iSigx0hHOD0+xkg0JNxrtTQ6rcc2QzR+0MZzU
	 SKkGdPhVHkwlggf7zPvz85i9HYy/dVuBwZYsNgLL8DdernDS2dSa+3iU9Vdmn7Wcx+
	 UaeAtJm1rieV3BEgvRuIUzJHMcCMaicbFl4a33bw4shWPB+MVj9Wzj+Jma0f2Z6MnX
	 otqk1QZhi0qyIusRB82zX1gTXEUsK6m7T2+yhlHmcE0UoBTK3uobqKrOejiGdLptX4
	 lWYsYy91TSv61qZGceTim+2UmBlT5L47tfcWkxYpytUV1L51jzK7Mhk/VzvLieF2HV
	 +zkVCo2C81Sx81RLe7004ikLFx5BL0RZxXa9whhqU7pUT44T7Vtbgjzy4uybgFU29B
	 me3hwYlCcV9EpQHJBCRGk4Jx1KUq3Gy51jXlZzDljKzwZtMEq2dn8z7lwSpQtsV/WW
	 PcgAfzc6fc7KsyLM2AIjsueqnCc5gVYbTLNq3oGAq1Jdi6eO7LWXuVPYn1X+uquf1p
	 6sdwyBZsw79qGPRQoSvykgVsWRofpSUrHiaPR5zHoWm4PIyrt27PlLQXZ74YeDW0ru
	 5lE2h1SVF5AUTIkGplH7x/30=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07CFB40E0285;
	Fri, 18 Oct 2024 11:59:02 +0000 (UTC)
Date: Fri, 18 Oct 2024 13:58:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
References: <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>

On Thu, Oct 17, 2024 at 08:40:18AM -0600, Jens Axboe wrote:
> Maybe? There might be some way to do it through ilo. I'm not near the box
> today, but I can take a look at that tomorrow most likely.

So I found a box exactly like yours:

[    3.699583] smpboot: CPU0: AMD EPYC 9754 128-Core Processor (family: 0x19, model: 0xa0, stepping: 0x2)

and it updates just fine and just like on yours:

[   28.457381] microcode: Current revision: 0x0aa00215
[   28.462827] microcode: Updated early from: 0x0aa00215

The next thing that is catching my eye is your simulated NUMA config:

[    1.668943] smp: Brought up 32 nodes, 512 CPUs

Lemme see if I can repro that here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

