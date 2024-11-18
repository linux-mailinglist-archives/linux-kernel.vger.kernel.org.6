Return-Path: <linux-kernel+bounces-412342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAF9D07D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931E6281DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A0C1F5FD;
	Mon, 18 Nov 2024 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HBS3ieCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82F2907
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896344; cv=none; b=P+gdIBgz8LfAjSIs2nEXJUDT79DTJXFN613TevFXt5Iz5o0hdq69CS/Hdo0twXoxafzC2rwwxgi4q6pCrjjqOb8LLl9YWzFV3quljejgJYnjo/elqfi4KEsMy/rPBoIw6+PgNlL7hZq9dH1AjW4hCXk5Yo5YekLbr7pAge25gxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896344; c=relaxed/simple;
	bh=Lx2P/RMyVbUJP/lwCnnu8nlrpvTp8r+fiC6bWYiUbrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd7iajdMcUgfweNKxeaLayMn3E1ahMFRdCVsRzxbkSe7s4Da9xXAudZaNFgAWOYrVmkmcIOydPReYHuQc0zRQtUHjFCsrgSVrNaUm7aLRoMNREiPDRYhZ+B+d5btvWAryxA7Vzn5ApoKLp0QBxz9xnOcbfGpyYjrMbPw4fONznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=HBS3ieCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9897EC4CECD;
	Mon, 18 Nov 2024 02:19:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HBS3ieCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731896341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0eBzG7akzQCesE4TDpMSeJrp/v2fYa8EK8PrD0HFGw=;
	b=HBS3ieCCXUIeo60sVKlaTyBaP+q485mHD78MQRqtgaOq1Iny/T4nDw/8D690z5FCV8M2ek
	+4oorbFE8e4TGp8kRO/e2uey8BCrGqH/p6bL2biptT7gf41RN3jTqPXTm/SShqH+gVoGHD
	0CvI45lCwH8vvB4iHC9jgDGs6GONjcQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b329eb56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 02:19:01 +0000 (UTC)
Date: Mon, 18 Nov 2024 03:18:59 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH tip] x86: vdso: Compute timens page offset statically
Message-ID: <ZzqkEzxJ69dBSps_@zx2c4.com>
References: <20240906190655.2777023-1-Jason@zx2c4.com>
 <Zt8XxiQrma1R2a70@zx2c4.com>
 <8734m7btjo.ffs@tglx>
 <ZuA5gaOhJNwDSb4x@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuA5gaOhJNwDSb4x@zx2c4.com>

On Tue, Sep 10, 2024 at 02:20:17PM +0200, Jason A. Donenfeld wrote:
> On Tue, Sep 10, 2024 at 02:08:11PM +0200, Thomas Gleixner wrote:
> > On Mon, Sep 09 2024 at 17:44, Jason A. Donenfeld wrote:
> > > On Fri, Sep 06, 2024 at 09:06:55PM +0200, Jason A. Donenfeld wrote:
> > >> The expression `((void *)&__timens_vdso_data - (void *)&__vdso_data)`
> > >> seems harmless, but it actually results in quite a bit of code and two
> > >> jumps, in a place that's supposed to be somewhat lean on code. The value
> > >> of that calculation is always 3*PAGE_SIZE, as it turns out. Changing it
> > >> to that results in a more modest cmov instruction being emitted. It also
> > >> makes it a bit more clear what's happening.
> > >> 
> > >> To accomplish this, define offset macros in vvar.h, which can be shared
> > >> by C code and by the linker script that decides where these pages will
> > >> actually go.
> > >
> > > I noticed we've only got a week left til the merge window opens, so I
> > > thought I should poke you about this, if you want to take this through
> > > tip. I can also take it through my random.git tree with your ack, if
> > > that's easier for you. (Assuming, of course, that this patch is actually
> > > correct.) Let me know.
> > 
> > It's not the end of the world if this does not go in now. It's in my
> > back log and that VDSO stuff needs more care than this particular thing
> > as the recent discussion about vdso random on other architectures show.
> 
> Okay, that makes sense. And thanks for taking a look.

Thought I'd poke again about this. It looks like this still applies to
tip.

Jason

