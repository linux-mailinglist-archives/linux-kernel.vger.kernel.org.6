Return-Path: <linux-kernel+bounces-371987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5B9A42F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5486B257D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAEF2038D4;
	Fri, 18 Oct 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ei5UJSO8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEA2036E8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266721; cv=none; b=kfkvicnHUmPztFP0uxv8M8UbCg5QM76a7CNKWnxsDU2Z8Bl2thKKwD8csS79a/N2MggWizyY9/MJ3y4dJ+gn0Skw9i/9n6CVfwFRio+3U5qTjL49fkKvk+CvenPbzBL/TWuU1IEgWAzJVLWPSvbRQMThkjKmNFz8P0iU+iE70fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266721; c=relaxed/simple;
	bh=ZxL5yzrkp0sbWiTtd9xTe9Q8uvk3sazPRgkNCIfxgig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6awz7+2DI6QRBxr9DfS3VkGQgqjlO3p3I2aEBD4ss3NLReUtqOZxDp8uWWDUj9L+zFYWkrxLcduFfmcYY5/PYdOS+f/h7c+Mqg2VzAt773wa7lL1bl3TuJ/m1hbKW0U4SpyJEKTk84YG/+QJb/O9BOGWmif7syVrqElsFe2FEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ei5UJSO8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 372B940E0263;
	Fri, 18 Oct 2024 15:51:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LpvUSfkn-CsZ; Fri, 18 Oct 2024 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729266713; bh=H8QyrzRtlH1+pvQVjieoWcW1mIPMHGJ/BT51L6MI4aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ei5UJSO8f/yhwgHEacdOjPdGQuIs34TQc5pbU3YYe4HvK9z4bdTJxZJxXkQJMJcES
	 XnfYUoceDR3NugGvU/NRS6jRGfSPj8WDRRgfCIcB9MVQRgsnpgm4JuD9Hz1fqQzLs8
	 RQeZq5ZVDQVxHf3W0BS5OXtrau0sHW0bdDXNWcuqi3s7OmYr9rYiNSzh+EZVtRUAHN
	 VNBuluJA3+3lTGFDk4uvVC2KuHSvjxbILkLToTfc3DY7o/X0r6wfleXoIio/SZBCEm
	 n7TgMHjVC8Zeln4jSeI8DjGhoMGKa8SmC1eXq3nBk8s3Jvb7QvWiBgJB9hN5pYVtTc
	 DHeiFkd+xBWhDzqj3NV7PW5dZXIjp3R97NeUU3SpBTxnBVTTqC8GNnCMwBRAtFthFg
	 cCXSXsm3cXS9+3rPGEMMcsLCOGrKWjMcOy3y3nRG3YERQ56WyVP6cMbOnZRA+wlUX8
	 pw/1pM2QZFpOzWEgrroVKRB7zgspzb0Tvwg652HcWfjjTC26nVqlc3nNw4Dx4trzBH
	 WOEUW63PKy6b22DUG2z/S4u75FRH06DiXplfn5QR6bYS+UcHowLiW0QY2gyxxR8qYY
	 yaBDM8gB2qS6R8MigaNIspeMmDxIiehXdNiRb1VFzH3FSWx7wKQBjsNSdbaJ9ptj8k
	 Q8tGy57dtT7/8hGEcBP6zJjA=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB5F340E0163;
	Fri, 18 Oct 2024 15:51:47 +0000 (UTC)
Date: Fri, 18 Oct 2024 17:51:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
References: <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>

On Fri, Oct 18, 2024 at 07:30:15AM -0600, Jens Axboe wrote:
> At least on mine, the BIOS has an option that says something like "L3
> cache as numa domain", which is on and why there's 32 nodes on that box.
> It's pretty handy for testing since there's a crap ton of CPUs, as it
> makes affinity handling easier.

Right, so two boxes I tested with this:

* 2 socket, a bit different microcode:

[   22.947525] smp: Brought up 32 nodes, 512 CPUs

* your CPU, one socket:

[   26.830137] smp: Brought up 16 nodes, 255 CPUs
[   37.770789] microcode: Current revision: 0x0aa00215
[   37.776231] microcode: Updated early from: 0x0aa00215

and both boot with my debugging patch just fine.

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

