Return-Path: <linux-kernel+bounces-372068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1D9A4412
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1B41C20AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373B2036F2;
	Fri, 18 Oct 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iogCz2dO"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035D1F428A;
	Fri, 18 Oct 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269975; cv=none; b=NmUXkF5bVQNz7MUlp4ngFzoq9J8NI2krCmzDJWUr59t09v5bBhdX0KSuoTEDegsR8+Je8LF2CzaVnazsjHuMqbirMKODAyqVUHynEZWWs7oPbO1/bAGYjEN99W+TotjrDJgpux8aBIzilxmN2jyHGLCnG4eAd7HtF4qahmz3H2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269975; c=relaxed/simple;
	bh=4j833Pj4D1ScOMps8+fOJNPmo/wCdYzKXojFxr8VU50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUQ/aefEl85NL1DllZyeYPY47rig5ibYa3RgZZRiER9D1yTMEGRen4dPZV4aM3cn+9LXdf+yQjGBvY/UBs9M5b6BH/6sBli7RmosXef/PRofaXUXHT9ocrqkE2wuq+ftlIvuCwDMrxCVhMXbLGUif/BZdn4OyR44UKtuTLHnMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iogCz2dO; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=os1PAytjU5z3dlnt3qo2d/sSpocPp2Y2Zy0gohogL/k=; b=iogCz2dOTMQuPK9s
	JA0zxSrCRlgFRF8DqptUUCkFuyIyvwop4WubsIGhMWLbaB7BmD2Aq3Yt3SlM/Vhbn2x7LFf8qhAnM
	NBvp90dCW2s5y1qCqLlaaXPMF+3ff80AHa2k0XKMli1zA54y6IugAcnK2WMliaJf9JbYlg05QRUfi
	rkE2sRTMicRRViHvx4d3ya7mX02qzaK539WebTwZBUKasqL64iDhyYw9czxo4nkkBIJ6A0bdeAQbO
	7LnBCfwFUKkl0apJnDaZl7T5IHRfs03sGKJ39YzC5M0Vt0Uddz3JYsWGW9shgkBEi88Rv43GKgARG
	SSS/gLtV7OqDI+gujg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t1q6l-00CAvU-15;
	Fri, 18 Oct 2024 16:45:47 +0000
Date: Fri, 18 Oct 2024 16:45:47 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <ZxKQux4I8We0Ax3-@gallifrey>
References: <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:45:23 up 163 days,  3:59,  1 user,  load average: 0.03, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Borislav Petkov (bp@alien8.de) wrote:
> On Fri, Oct 18, 2024 at 07:30:15AM -0600, Jens Axboe wrote:
> > At least on mine, the BIOS has an option that says something like "L3
> > cache as numa domain", which is on and why there's 32 nodes on that box.
> > It's pretty handy for testing since there's a crap ton of CPUs, as it
> > makes affinity handling easier.
> 
> Right, so two boxes I tested with this:
> 
> * 2 socket, a bit different microcode:
> 
> [   22.947525] smp: Brought up 32 nodes, 512 CPUs
> 
> * your CPU, one socket:
> 
> [   26.830137] smp: Brought up 16 nodes, 255 CPUs

(Probably unrelated but...)
What happened to number 256 ?

Dave

> [   37.770789] microcode: Current revision: 0x0aa00215
> [   37.776231] microcode: Updated early from: 0x0aa00215
> 
> and both boot with my debugging patch just fine.
> 
> Hmm.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

