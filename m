Return-Path: <linux-kernel+bounces-431391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045F9E3CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B28282E22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4EC204F7A;
	Wed,  4 Dec 2024 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FX6SENef"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D4189F56
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322564; cv=none; b=jUPJWauNayKcI8mYe31tZO98DkZA81fM03L1Kc8prLA7+768TNCpFhyTTCApkk8YJqbOPyEy3xUjtWrAN8WIPNd8Vif07VbOyyv7NLdqf1RPT2Od2Z9ZESGySCvWFvh3vMKtbAGx18K2997mKGDW3R3vwvMhsePHztFFJfjlD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322564; c=relaxed/simple;
	bh=3KwgxaP6FkpVeQa7wijeTQe8jb/qdggPnZ0hr39vUF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ccd+l3ggMdrmyJGVeRm8h1tChV8+fqftgTNz+78oH1Lqx2NZdltQ85kJKoGPqQESjKU140OPoGJa4ArJeLF8FHJWp99IveDKyi2ds4BVfBefp89aw8pH8rKbfH3j+VoxEQ+n1w4RXCPevmxYlAw6PxTlVjsWeVXB9PjZP9HmIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FX6SENef; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef524fda21so63112747b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733322562; x=1733927362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KwgxaP6FkpVeQa7wijeTQe8jb/qdggPnZ0hr39vUF4=;
        b=FX6SENefi4Nf1vTpV27pI4E6ZIO4k9ma1+vsj9Dm91Ls/xf1JliHUqWNzUF1xPypuZ
         aNg69vkvJYOLHah7PuiYyHoQrPWH5QaJf5Fqw6zaKtt/Jo3N/si7ZpcQQ+tHyzh1aBnm
         6nZjjI8BbEK8EZocvmUjpKnj5HvODqqxhrc04lzk7CwpX2c0ofM8//u3MpzatYWZJ3ke
         IMHhzGjMNF/iVrRHWrSaPDz/IAA+eZPg+5I45IIvnRjtBkuR8UlaJpTgQ3np/SJ2LDXS
         shYa+07hicU3d99RSOhYgiytEJlImJqTZDOPawHQxUOb2Uh3T8hFuP2vWTMh57sd+naS
         SCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322562; x=1733927362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KwgxaP6FkpVeQa7wijeTQe8jb/qdggPnZ0hr39vUF4=;
        b=AOmsLIJlMhJ5BF5RkeySO7CrH9t99DDBTp8LSQiStkif+hxoSlcMT8PgvdCiAxm3Te
         tw2u1NbXw6hD9AJ4VxbJ/Gye4SnhSUJ3mPhVBTNNNSaaALis+jQqUkp3XfoU21CIB1EU
         HscWbnpXZOSDci8gVuP4tuSKP5IVxW0EH0EAbQxXVS061h9cN7njALndr4towTeHski4
         C6saiwrnbY7Dy68UVoSXErB874EoFSbQx0CulmbGpqcCLEDjm/yNTqkv33SzuSx/fHc3
         fdOW0Vjth51WyorMN5Tiq/fJR3dO/jzl7+0Na5LLGqyfQPTbbaX03NhzOQni/Rms5IJv
         NMoQ==
X-Gm-Message-State: AOJu0Yw+lTA+HFdydupUpJuUhL4PFE0mEvJxzAM75RTivKd6lWsCUD5p
	68LDd+FWTsXl1/8cEloF7VaR6EnEI9kNxMKrHTDBM2n/NpToELzIxu/Zzije2/eO28mrgGU7eu5
	OT6hRznRazjSfwQZRQiFCB1LwdEgdDsfNxdmlew==
X-Gm-Gg: ASbGncuyHRp/4jPjv67l10PHPeG/WQer3fBqZZ5rjgr8GQz650SHEWFir96ZHWfslUW
	CYcirPud8V+AOJ4MA5LIt2J/+zwJeIw==
X-Google-Smtp-Source: AGHT+IECLKVIlaO9LpFlpnhg3iVWERPQO26qkt8DgDJbDpaMcgWnOwIIFCN7yPb5xUaGHc4umafT0ZZYEPzoxyTvdHM=
X-Received: by 2002:a05:6902:1505:b0:e39:80b9:3344 with SMTP id
 3f1490d57ef6-e39d39ec8d0mr6282859276.3.1733322561825; Wed, 04 Dec 2024
 06:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-16-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-16-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 15:29:09 +0100
Message-ID: <CACRpkdahQhj5u9ATghszi-N2OYhFbvHF_W_eAMDAU+vhmvdrJA@mail.gmail.com>
Subject: Re: [PATCH 15/15] ARM: mark footbridge as deprecated
To: Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, 
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	"Jeremy J. Peper" <jeremy@jeremypeper.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Ralph Siemsen <ralph.siemsen@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:30=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Along with RiscPC and SA1100, these are the last remaining Intel StrongAR=
M
> machines. The Corel NetWinder used to be particular popular in the late
> 1990s, but was discontinued during the bankruptcy of rebel.com in 2001.
> The other machine is the DEC (later Intel) EBSA285 evaluation board that
> was made in small numbers in 1997 for software developers.

IIRC David Rusling at DEC was sending this board out to interested
developers.

> The footbridge/netwinder platform was the main target for the first Debia=
n
> 2.0 "Hamm" release on the Arm architecture back in 1998, but was dropped
> in Debian 6.0 "Squeeze" in 2011, which only supported ARMv4T and higher
> with the EABI based ports as ARMv4 hardware had fallen already out of
> use by that time.
>
> Link: http://netwinder.org/
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I am booting it occasionally, last time to test my KCFI patches.
But admittedly that is only to test it for other SA110 users. I remember
that Christoph had problems consolidating the DMA used in this
machine as well so it is standing in the way of useful work.

Apart from Ralph and me I know Marc Z has been known to boot
this machine, so paging him as well.

My machine is using an OABI RedHat MontaVista Hard Hat
derivative but the default userspace doesn't even have a /sys
directory so it's quite dated. I have a minimal homebrew
busybox userspace that I actually use for tests, admittedly
built with an OpenWrt compiler using the --fix-v4bx trick.

So from my point of view this system is on life support:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

