Return-Path: <linux-kernel+bounces-199469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A58D8785
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE451C21F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A81369BF;
	Mon,  3 Jun 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a7KIZvvx"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9413213E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433885; cv=none; b=PtHA8wDg2qbAMtpezV3p3sSZRdtOD3nL21ewLjXEM13Mf1o0217XAD9zTSFuryrGKyQb+K1GevfF3IrIrB3RGXsYMYcu0Uhk/hxOEYScfMQX2hR0kjdy+FB69BFCln+sOgiwzxG8N9UXNzGRa0EFwbTNeXZpNx0ZORfaoa6e+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433885; c=relaxed/simple;
	bh=YmfhrGKR576T+lERklhD3qCbieB1UQ/6RTgNn0+mM/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8PkDSQx2/WJUGabMDQt3pbcZvg3L+068jvQJ1btIgY2mrDjgrF90PHDAWF7nwfoTPx0aJyJ8ikJvPBpIYLXX0o5fwGmuuPJlm0Rq5k4Nn0x2J8UikoWoOVGGCnlqwyBiMBQpOdjNqpXjgvYQfyNH41n+ebvKmcpcbYKP/nKJv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a7KIZvvx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso105387a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717433881; x=1718038681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u5ebltTeVjJmxSwR146N9eCu8AyLuoasTttIxwHglR0=;
        b=a7KIZvvxBugNNfA/aUlr+aOMfzFDM8ip7JlhYDfPW5ZPWIY3om445LAw6aFOm4DxNY
         tVYk+W0zurXUXbo5qrf34Y9dSkJnlsI0/NHxEO1xgF2KItCYSBo5hyHCkGRu6ZvUX4Vi
         ilZDkU/503KC5lScK8mEiMV+5hP9nX8oRlqPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433881; x=1718038681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5ebltTeVjJmxSwR146N9eCu8AyLuoasTttIxwHglR0=;
        b=FbLCLVVteUoIHm5SivCVD+CYyW8dc0mnVFifrHBf4gumQMGOP0JpVaQZSF3Z/JTI5+
         zngutPllDiazRNak+XjkJnzftotexg1qv4VulEUsV273cc0z2jvqMVXiCi1Ag50yt52r
         PR0korAGfGvXD7EYWotCV5CcAAcRwvSRIQmJ6W3KH/08dyF54G5f8T2fCc5iFuKjWROe
         VvfHQeBvXhUwiv+gR/OCtEXOeREyTbuYu0BoIlhlnenaGVf8z+mKKOaBk2+llIvJ/G7Z
         J0FLzIwvdl5hySvELRSLpz67YiL8zHBWdtiWoQtxOtXiPft98sc5m4nmLFk2HAmtkHVT
         mSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAzHn7ZQHZNfHGW1BVhmwWaQM+lCEGiGZ8i9zazzNYLcmwGiwL+vPuHsmCb8vTbvxRaGPdQTcwS/AvPiro8I2fa7pSGZ4MAj4xg9t/
X-Gm-Message-State: AOJu0Yz/V/OXVYxjVm/aTMwv3PbaRZdFUJDjZr+BtD4cR5mEn2ERCrdV
	7qrRpThgklYXvg1aN2IXuF9o7IR15wd49YUdxKUsnsuD09wXeVP3bx9lA0t5sScG7RKCll5o0HX
	g7SfqjA==
X-Google-Smtp-Source: AGHT+IFz1axEfH4xDGwudD3qEvikGkEP6LR9qZ4uqOslbtC3utns5JLtmviPo9YBIQtrzLWV/ALuQw==
X-Received: by 2002:a50:cd55:0:b0:57a:1d0f:47f7 with SMTP id 4fb4d7f45d1cf-57a36389d9dmr6613413a12.17.1717433880633;
        Mon, 03 Jun 2024 09:58:00 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a690678bcsm1237980a12.65.2024.06.03.09.57.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 09:58:00 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso105356a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:57:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTwtG0/87uSrADvvlwuvFX/cc2dJGg73tuLG/PfSw7aeOrbpG/EGCSq2GQs1Q0Aj3qW/ymRiTcQCEt+rZv2W8zfScCrjRM4hbczTWe
X-Received: by 2002:a17:906:2855:b0:a68:a2e7:118b with SMTP id
 a640c23a62f3a-a68a2e7230bmr456124266b.19.1717433879674; Mon, 03 Jun 2024
 09:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com>
 <alpine.DEB.2.21.2405302115130.23854@angie.orcam.me.uk> <CAHk-=whiH6g+T7+YWSYgAhJ9HsJ2bUUDJfLLo_Yhbi8CVgkHDg@mail.gmail.com>
 <alpine.DEB.2.21.2405310457060.23854@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2405310457060.23854@angie.orcam.me.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 09:57:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha2rH2UcTvHUYK+dNnP6UCDRkYM0atvw_GTP5Sz3OZrQ@mail.gmail.com>
Message-ID: <CAHk-=wha2rH2UcTvHUYK+dNnP6UCDRkYM0atvw_GTP5Sz3OZrQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@kernel.org>, 
	linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 04:09, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
>  Anyway, back to my point.  A feasible solution non-intrusive for Linux
> and low-overhead for GCC has been found.  I can expedite implementation
> and I'll see if I can regression-test it too, but I may have to rely on
> other people to complete it after all, as I haven't been prepared for this
> effort in the light of certain issues I have recently suffered from in my
> lab.

Yeah, if compiler support makes us not have to care, then I don't
think the difference between pre-BWX and BWX is going to matter much
for the kernel.

The real pain with alpha has been that it's special enough that it
affects non-alpha code, and BWX was one big piece of that.

That said, some of the EV4 misfeatures end up being a huge pain inside
the alpha code either because of the horrible hoops that the IO
accessors have to jump through, or because of the broken ASID's.

So even with enw compiler support, maybe it's worth trying to
re-introduce any support for older cpu's incrementally.

For example, the ASID hw issue is _claimed_ to have been fixed in
PALcode, and maybe the games we played for ev4-era cpus aren't
actually needed any more?

And the various odd IO platforms should only be re-introduced when
there are people who actually have access to the relevant hardware and
will test.

           Linus

