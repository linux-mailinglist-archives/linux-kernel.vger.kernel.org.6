Return-Path: <linux-kernel+bounces-340654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55A98764E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094671F29154
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640FD14E2E3;
	Thu, 26 Sep 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMUUOQ4b"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E943EAD5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363676; cv=none; b=elDkhZs1amjNUk8dLGU0/3LGlYha2b2p/5m8oe8TEb8FYpFuPJYbs2G2+S8MU82eTOV7dg7uCt6k4IB9uYxNuRP8zPKnUxwCuv6ihfY0wq+5tpghT8hCoEfDNtW9wq3pNijTSRhmfqEcO/U3qf9UDwetfN7YW8UXEtB96bBcyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363676; c=relaxed/simple;
	bh=Ho2KGkPIH/lcc4u6kBKOd+9XrOvdSJ7mLfP5ix7NveU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2KrjXFce2Yt04gODfhX5uKfsnViP5eGgaxXAl7QBlKZz8jDc5t71gwmCcMW1/X4r2akzika36YrcV9XpVbbfvfI4hDAI2i6pnvSnTNqWknooccqMwwx7w8Fd6b3QMXOQdZsToFGtpUgw8GHV95pB63k0/vq1ccmqLulfvxk8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMUUOQ4b; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb2f344dbbso7894346d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727363674; x=1727968474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1/V21dBZLsZonf5vh5zmlJO2y+vMSM21arOiKuItW3g=;
        b=fMUUOQ4bWzfBr0vyse0gTc3Ig1RyVl6ZX1Aj81RHKGpUkEESfpmhfjcTiRHlb4yxnp
         3FA8TgBEphKWZfHBPyTnjkHCjNuwX9jstn1nVyupLyVohKyTNQYi8VYuur3ZSWJQPWvr
         UX+Al06pqftZLzCw91+e6a09oZYyLT5M9P8RbSQu1DU4GV0v7lJoicb9sV+9ayoojXsR
         jfcS9RGefRSNa7bNR8EIfc8VYQhZIn59DBQy+JUOZ32C0j4oPtjOsmVwFwySEs0Dq831
         G9M+lg8M5tJvBfPNmsftyIW/w6qv93YVChkavGxfpQWNPYM31uZJuKdo+qTbAOjxztMl
         jOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727363674; x=1727968474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/V21dBZLsZonf5vh5zmlJO2y+vMSM21arOiKuItW3g=;
        b=OGaOnQNLJ2sHceBWfofEF8ZeYVfkl9vppNxq+/S/BZOUtlcBtXblUwaaSiMiOXT7wl
         YFaw8i5K8yDJWPMt1HThyT8W+iX8UHG6MCl8SAJvS6wuOPNQpSCMNhFLIkpW1DEjrZJ0
         HrPn4U6/7B46wWwrqaPXv/F11nZ4rYloLRvDpMoap7WhLGo1qphdUViFrE40dYqnZAW3
         rMkUv6Qx+MZTS3Mk9NeGoqQWp9SeiENQW+Y9pK+Jvt/psL7jVLKYCAahs2fPtw91h36J
         uohyTTXGVXdPgBJI+9o2xBo/ED8zL0RHyX+uIZISw4Uo+/cHcoRC3VHvXntim+zzqVrh
         ApQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4f1dK3xG196i0k3HO2RZ/AqlE3t+HeKS+psv/GV+o1PaJ3E4hgco8hXS9Wx88qtDPoO/dUWdAapSfPag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtE/Jqi+BNZ48mifSqCyYeDqxQ9FB+sUXkveq3YwDCGutBGXA
	XxDV7z2/2q1WWPbhK28eO3k9Rbmui6bi3eJleFM18YowlRC40YhW
X-Google-Smtp-Source: AGHT+IEy9Tc2r/Qo9SbT5Etug4R5D6DdQpLVnUz3ZKphIzueDnFJ9PbLnCA1CyvOlreUuLJLaWbmOg==
X-Received: by 2002:a05:6214:3215:b0:6c3:5492:982d with SMTP id 6a1803df08f44-6cb3b5b8b31mr1002416d6.8.1727363673583;
        Thu, 26 Sep 2024 08:14:33 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b680019sm95896d6.119.2024.09.26.08.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:14:33 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id C64D21200068;
	Thu, 26 Sep 2024 11:14:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 26 Sep 2024 11:14:32 -0400
X-ME-Sender: <xms:WHr1Zq2yVH1voh-vX1_zEwfsVSxYTPMjpn6oRefzeLskjoe0epUsTA>
    <xme:WHr1ZtGdCXtI_nyXoPWi332eYVuGx-IWRS5j7gV1cbclsoFLLmHa5vHsJwZKxP-LB
    hoiTYK9YZ1vKL0Tsg>
X-ME-Received: <xmr:WHr1Zi5Q7rh0K-GjmoDlwkh8I5XHz9BrZToykKya_HncAFuDk9nC0PuGFZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgfelheetkefgudetjeejkefhjeefvdeifedt
    hfehgffgheehieeliefhtdetheefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epugifmhifvdesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehtghhlgieslhhi
    nhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthho
    peifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhgrhhoshhssehsuhhsvgdrtghomhdprhgtph
    htthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:WHr1Zr3jzOyp20fBvtbLBnaQKoR8n5WHzhlpIawuviOjTV4EzOQrbw>
    <xmx:WHr1ZtGJWPxBaJNzxZZzMRAVMM81x0-SDMO70s5zp_O9qA40_HAqBQ>
    <xmx:WHr1Zk8QF8l0n8xHFlMHkRx8ABe4_8X_rdW0E9nm8cVwX1wHAJYNxw>
    <xmx:WHr1Zil96lR2ATKeYw70zCHHoep7g4YcMZWAVdANvsh1vA6EOmXolA>
    <xmx:WHr1ZlHtxsx0KlmwDeQedZdm9rIYtq6CdKPZWIh_zim3jwiz-MxnkYWV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 11:14:32 -0400 (EDT)
Date: Thu, 26 Sep 2024 08:13:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <ZvV6Kg-qe4e4DigZ@boqun-archlinux>
References: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
 <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
 <2b8c36376fa01fa6a1bac9570eb7d41e7e232a29.camel@infradead.org>
 <1da59ef5df8e8a2bebd31535fa13264113a316ff.camel@infradead.org>
 <ZvVO3F7BJW7OwbEg@boqun-archlinux>
 <ec2ec6b7682b33f0ddf06c3d3c2e23c9c5971b67.camel@infradead.org>
 <ZvVUuOq7dLd6_f09@boqun-archlinux>
 <53d3d2e143eac428312ea74c8e6209aef1737a63.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53d3d2e143eac428312ea74c8e6209aef1737a63.camel@infradead.org>

On Thu, Sep 26, 2024 at 03:34:57PM +0100, David Woodhouse wrote:
> On Thu, 2024-09-26 at 05:34 -0700, Boqun Feng wrote:
> > On Thu, Sep 26, 2024 at 01:16:32PM +0100, David Woodhouse wrote:
> > > On Thu, 2024-09-26 at 05:09 -0700, Boqun Feng wrote:
> > > > 
> > > > 
> > > > I think this is already fixed by:
> > > > 
> > > >         9bb69ba4c177 ("ACPI: processor_idle: use raw_safe_halt() in acpi_idle_play_dead()")
> > > > 
> > > > , no?
> > > 
> > > That patch fixed the bug.
> > > 
> > > *This* patch fixes the fact that lockdep didn't *tell* us about the bug.
> > 
> > But I thought along with the above commit, Peter also made it possible
> > that objtool can detect leaving noinstr section in the offline path? Do
> > you have a case where you can alter hardirqs_enabled flag in offline
> > path but don't hit the objtool warning?
> 
> I do not recall such. Peter?
> 

Oh I mis-read Peter's response here:

	https://lore.kernel.org/lkml/20231027191435.GF26550@noisy.programming.kicks-ass.net/

, so seems the noinstr annotating for CPU offline path is still a WIP.

> IIRC the bug fixed by commit 9bb69ba4c177 only showed up under real
> Xen, as QEMU doesn't expose processor C-states. So I reintroduced the
> equivalent bug by doing this instead:
> 
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1390,7 +1390,7 @@ void __noreturn hlt_play_dead(void)
>                 wbinvd();
>  
>         while (1)
> -               native_halt();
> +               safe_halt();
>  }
>  
> 
> Without this patch, I get a triple-fault on bringing the CPU back
> online as before. With it, as intended, I get a warning, but success:
> 
> [root@localhost ~]# echo 0 > /sys/devices/system/cpu/cpu1/online 
> [   42.090839] smpboot: CPU 1 is now offline
> [   42.091989] CPU 1 left hardirqs enabled!
> [   42.091997] irq event stamp: 144559
> [   42.094155] hardirqs last  enabled at (144559): [<ffffffff89098b2e>] hlt_play_dead+0x1e/0x30
> [   42.096196] hardirqs last disabled at (144558): [<ffffffff891800ee>] do_idle+0xae/0x260
> [   42.098062] softirqs last  enabled at (144530): [<ffffffff89107260>] __irq_exit_rcu+0xb0/0xd0
> [   42.100056] softirqs last disabled at (144519): [<ffffffff89107260>] __irq_exit_rcu+0xb0/0xd0
> [root@localhost ~]# echo 1 > /sys/devices/system/cpu/cpu1/online 
> [   47.480889] installing Xen timer for CPU 1
> [   47.485308] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [   47.491569] cpu 1 spinlock event irq 35
> 
> 
> So I think the patch is still applicable.
> 

Yeah, it was just that I thought we have static checking for the issue
(via objtool), and I think that's slightly better, because it covers
more problems.

> > Anyway, the commit log needs a rework.
> 
> Sure. Other than to refer to commit 9bb69ba4c177 instead of the mailing
> list message, is there anything else that needs changing? I suppose I
> should drop the word 'recently' from '...was recently observed'? :)
> 

Given that Peter did send a POC for static checking:

	https://lore.kernel.org/lkml/20231030111724.GA12604@noisy.programming.kicks-ass.net/

Maybe you could explain why this is needed even though static checking
is technically possible? Thanks!

Regards,
Boqun

