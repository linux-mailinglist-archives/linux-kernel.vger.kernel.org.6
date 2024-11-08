Return-Path: <linux-kernel+bounces-402063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA299C22EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4481C22F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFE61E9091;
	Fri,  8 Nov 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJsQRKW/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C098198A17
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086899; cv=none; b=XUuRQCo3GFDsqkAc+TL8s1Vlm2UgR4nJeusBjLLMM23jldQ6EfEqAn/DcuvlKwe/jK5yRzxWQO+zmjwqg9rQPWDPrm7ZaC2Ki9g72FCva3G7KtiRpWNWj/ZC89HOf4U1wVq7/pxnOYl2L97qNn7Unx+MHpi+XpPbbOK4V1u6yXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086899; c=relaxed/simple;
	bh=rBNw1GNzfA6z75fhIAP/gwSk1f0U2vf886V9DeeMwJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr4p7RHEpOFj0j42BAUPnFwH6CS6JAecD1pYVQu7jLHFeo3LJwqSdHsSqCWxt56E5cHz545sp80PS8bVIltAveRCWTpibKLX4hAcaOZnKIUkeeDKiO+0nElGWUr/3izBja9xKt4YNtKofWblcqA42kmO3iHjqYGJ8T0keeSJ0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJsQRKW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F62C4CECD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731086898;
	bh=rBNw1GNzfA6z75fhIAP/gwSk1f0U2vf886V9DeeMwJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sJsQRKW/1nYuKf/mfYrpMQnyXkZjeis9ktdRF9ApCTOr69bZMKyR/YV5AamISeWH5
	 tv7b/sgU/5uhQkNHnoanaxLdSIS/U3kaznD2is6SEXerw/iu9/dY/0FV/LvVBNXvuP
	 NcbB4xtpEseP47Y/1YMNl58oLyWwdj8WLX63IZgwexSmDayVKbk4EfIcWSxQOdDjgQ
	 J9UWQDTEq8jxHbKv6a8EeqJscfdTkFH/FfPDYtYFonxACq33h2plOvv01ln0UqW6/B
	 yOVtnztUdSPEAG26jvtLXDe9WRp6VAyQ6wyAv6yZ3uOwFvE0k7lyp/XYsPL63WmXqw
	 B9LFUMfBkOxbQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c913aso4352459e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:28:17 -0800 (PST)
X-Gm-Message-State: AOJu0YyeQuEfDv11kyeG99yDaqofsYlH8j/17gxrToRIC9ccm4T+TG0A
	YTXDOCx4YBet5Aq8k0GgDJd3W6ikdAOh2pFhHqSVyLkd/3DzWovxRdrsuGmHMqKIBFhTebQjGCc
	RcXpPdvfjuTCOXC7cGHEwRs/pj1Q=
X-Google-Smtp-Source: AGHT+IGu97hLQdM+TDMBUSa2y0Ly3o6vGpFnIgz3xz3MvJxhNbicxhfcfws1SsK7h2XKfbCLLN57P2l6Urc8xSQ2CaE=
X-Received: by 2002:a05:651c:881:b0:2f4:3de7:ac4c with SMTP id
 38308e7fff4ca-2ff201e84bbmr20645501fa.8.1731086896634; Fri, 08 Nov 2024
 09:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918045431.607826-1-masahiroy@kernel.org> <0c4dc285-f218-4c88-87f3-b7c7c786cdba@monstr.eu>
In-Reply-To: <0c4dc285-f218-4c88-87f3-b7c7c786cdba@monstr.eu>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 9 Nov 2024 02:27:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASKooM0_LuPhB0c6AfUsEB0b1Q_mo0TQvuCO2BZqYJBsQ@mail.gmail.com>
Message-ID: <CAK7LNASKooM0_LuPhB0c6AfUsEB0b1Q_mo0TQvuCO2BZqYJBsQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: use the common infrastructure to support
 built-in DTB
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:54=E2=80=AFPM Michal Simek <monstr@monstr.eu> wrot=
e:
>
>
>
> On 9/18/24 06:52, Masahiro Yamada wrote:
> > MicroBlaze is the only architecture that supports a built-in DTB in
> > its own way.
> >
> > Other architectures (e.g., ARC, NIOS2, RISC-V, etc.) use the common
> > infrastructure introduced by commit aab94339cd85 ("of: Add support for
> > linking device tree blobs into vmlinux").
> >
> > This commit migrates MicroBlaze to this common infrastructure.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > I do not know why MicroBlaze still adopts its own way.
> > Perhaps, because MicroBlaze supports the built-in DTB
> > before aab94339cd85 and nobody attempted migration.
> > Anyway, I only compile-tested this patch.
> > I hope the maintainer can do boot-testing.
>
> I took a look at it and it is changing current behavior.
> If you look at linux.bin and there is no DT inside. But when you patch is
> applied linux.bin contains system.dtb inside which is regression.
> Or is it intention of this patch?


I do not understand your comment.

If you look at the code in arch/microblaze/Makefile,
DTB is empty unless you build simpleImage.%


My patch still keeps obj-y within the
ifneq ($(DTB),) ... endif  block.


ifneq ($(DTB),)
obj-y +=3D system.dtb.o
  [ snip ]
endif


So, when you build linux.bin, system.dtb is not embedded in vmlinux,
is it?



> I think there was any documentation about it's usage in past but never re=
ally
> described in upstream kernel.
> But idea was that linux.bin requires DT to be passed from bootloader via =
R7 reg
> but simpleImage.X is linux.bin+DTB inside and can be used without bootloa=
der.

With my patch applied, it should still work like this.


--=20
Best Regards
Masahiro Yamada

