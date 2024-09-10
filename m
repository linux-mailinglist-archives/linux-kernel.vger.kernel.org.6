Return-Path: <linux-kernel+bounces-323055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309B973710
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538F91C23B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DDE191F70;
	Tue, 10 Sep 2024 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OegVua5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7C18C347
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970822; cv=none; b=CzZjU9HeShIjv4UjCFOZQhuM0XLHD/OAD+ofNIme18HMRfe/5u4WzEzGFrNxBkZ8tvBWWNrHvJI0p+gz5dMUKSikB8xIVLpTMypctKBzi13tc8ibI828Mz1Tpf7ZRcJbQZ1DBL46/ADngHdx33pez8zH4awsIt/OyxS6lA0k9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970822; c=relaxed/simple;
	bh=ud08iVSrPMxDdTB1teNxUwCBywhQ4hgRuqFYY2CdsDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9uUzMHeGfXrxh1iSBlOYmY3fgBOatJhS1RKD9dNQnMCgJkUcKL+X526KrLldoyxBAB0VSih2S0q+S+gJbYpy3TaZMHkw4voADPvJR1N8gQw1PA5PVzNhn9N42Rqy4U+Lv7TH7qklJYdp7esOIvE8m4psM/nFdfts+HANwLwm58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OegVua5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A2C4CEC6;
	Tue, 10 Sep 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OegVua5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725970819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWukTYxn43Cxv+kn3bjpuRfYdi04hrVpvSOuNl4C/2Y=;
	b=OegVua5Cgz6s1rMh99ogKjlzfqgCxOZ2ZOh/NtBFmoJ8L+zbVvn+t9YEqyyJr4fvkeQnvG
	DRlJmd5TwKYpBO9J8pFL6xfmUc+QBrhLc/GZFXgXQoawQVCmaChOWwWwy4IL6tUnAjSOhv
	4REmickJHsOuVCkKy0cw3obtC3tHTJ4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 112bd2c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 12:20:19 +0000 (UTC)
Date: Tue, 10 Sep 2024 14:20:17 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH tip] x86: vdso: Compute timens page offset statically
Message-ID: <ZuA5gaOhJNwDSb4x@zx2c4.com>
References: <20240906190655.2777023-1-Jason@zx2c4.com>
 <Zt8XxiQrma1R2a70@zx2c4.com>
 <8734m7btjo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734m7btjo.ffs@tglx>

On Tue, Sep 10, 2024 at 02:08:11PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 09 2024 at 17:44, Jason A. Donenfeld wrote:
> > On Fri, Sep 06, 2024 at 09:06:55PM +0200, Jason A. Donenfeld wrote:
> >> The expression `((void *)&__timens_vdso_data - (void *)&__vdso_data)`
> >> seems harmless, but it actually results in quite a bit of code and two
> >> jumps, in a place that's supposed to be somewhat lean on code. The value
> >> of that calculation is always 3*PAGE_SIZE, as it turns out. Changing it
> >> to that results in a more modest cmov instruction being emitted. It also
> >> makes it a bit more clear what's happening.
> >> 
> >> To accomplish this, define offset macros in vvar.h, which can be shared
> >> by C code and by the linker script that decides where these pages will
> >> actually go.
> >
> > I noticed we've only got a week left til the merge window opens, so I
> > thought I should poke you about this, if you want to take this through
> > tip. I can also take it through my random.git tree with your ack, if
> > that's easier for you. (Assuming, of course, that this patch is actually
> > correct.) Let me know.
> 
> It's not the end of the world if this does not go in now. It's in my
> back log and that VDSO stuff needs more care than this particular thing
> as the recent discussion about vdso random on other architectures show.

Okay, that makes sense. And thanks for taking a look.

Jason

