Return-Path: <linux-kernel+bounces-404624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF179C45D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE12B2235A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CB1ABEB0;
	Mon, 11 Nov 2024 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW1a2Pal"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494419C569;
	Mon, 11 Nov 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353377; cv=none; b=o0O/L7mf8HakU5O+ffi/wqJU+yuYmWYdAO3MqpqOv+TAT8JeC6zzMZeULSqbbgNJQqNG9IeMVpaC57fMtPooUouGstyGeFwhTLHgAxN+dPFoSt98OLm1S+PY90qTB6keyuVovwnNgxYsAMDnjblD+yyDmZblITVDU4jozNe48Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353377; c=relaxed/simple;
	bh=MGrDoVZBKCJUqSFuDTy6drHVcYGi4i0VUnifK1k48Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODGRH0q9+cb9fF7nkLF/4Yvpqc5qrU2XuF/EhO5dODsCZXUdHyUtVnGCYnttSuX++zHCsm/Jb1TxxRnGuJ6rdk2KOqeNJJMIiNWPEHrmDWcJ3NStksDo8FFmsUXQM54GGDWExWfVxreFD0/sXLlas1pxz1IH7izzN5YxSF3gMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW1a2Pal; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-28c654c9e79so3505453fac.0;
        Mon, 11 Nov 2024 11:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731353374; x=1731958174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1vUWXu4zDKdaSJZeWtM1voreY4yk9aTKqi7yYAqNXw=;
        b=GW1a2PalpjRylFhvt86UKMdRjpa5M0fB937AsLZcmYWtfzJ2OTVhDujlfUYI/DBP5x
         UMBemsKaJHGH2gt7XV9vv8PRjrzJHkoCZVQh769iTonPR8u9JDZQiXxoH5p1tfojhfHc
         eG+KJPSyY0C/CZKwTnhdQCkcxoXlulP1lJwlwaNMd+SOXiFLSAESjd/3TygKWA++LXZp
         m0UjPlmzSs8o9GNuyxmVAIkR27CO4+DDclt+nevSnRxM+p18sbNsSDYmHpSrgMNUlYFz
         ABchJt2qWCfQykvvTqj/bJKszsmhnaggWFxbS70Wne3TH0hOvMZ4WUOpTK/4hHjjn07N
         O8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731353374; x=1731958174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1vUWXu4zDKdaSJZeWtM1voreY4yk9aTKqi7yYAqNXw=;
        b=Qyv1zo0cBKAcYjOtK4rWzmOhKJC0TOjOL+RH0dri7ElsiGnVtUoCVHdeo5QpCQ08XI
         CwxcJFPbprT7RJL5FPpORkYjcvTY/HFf9F3nOOAUFP+GZE44IVRgAOkhIsfry9Lfvkcp
         EIdmtFqbta4PhC1yfH6K1X6BpgB/fObJiNMq02c6GgsnCvLqMMCtwwXZTZXOyfRdD8Ib
         zGOsvIbIx7cV549RG2F0pgc/O+BXMRvfrD+bG7YoiN20I0RYPQtp8cwlBdj/0fxR22n5
         pi9faSzaCYBzFUP/AS738GNRc1SUdOFNZJ6lUPz1+bOcNCLtLUvlMtbKZlmpg8j8xd+i
         jvUg==
X-Forwarded-Encrypted: i=1; AJvYcCWM7J5tNG2UBAwVCosYgCNg3zEfvInDrUD4u8ZweYrlulxmgjgGfUczKBOc2UDoY0M8/tuml0IK0tju@vger.kernel.org, AJvYcCWn6jQFU+zVMjOtZHFBH1BhNsOx8kZKVc1uFAWEBMULe5a2yWsO4B1ptJy8p1nJjZuzqpPg+IcIsVrJFwjh@vger.kernel.org
X-Gm-Message-State: AOJu0Yylv9cMN9FEKRqH6Whajf8GlMLxaToCPG1SFIiTRHMC/1Xz8FNR
	pLt0qEMftl78qEg1eeRWvDKHcDkmL8vWFVhW/EMPxBqwx9cHWjN9DQNdcPFguLHzny8NSYPcedB
	cOR/FJhEAJUGT0Ny/7rPqp1tvAqM=
X-Google-Smtp-Source: AGHT+IGHBbFAE824Z7ejSxwNuhavp9mnBTJDMnAcM9e5ShF/vhmJU9L9bJA8yQotfmv6no01sHmmXUuBPlpSARUN7sc=
X-Received: by 2002:a05:6870:b06:b0:288:4eb9:5541 with SMTP id
 586e51a60fabf-2955ff9c48cmr8070771fac.0.1731353374567; Mon, 11 Nov 2024
 11:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com> <499869db340b2d4c257e12d20e15c200d0f815b1.camel@ew.tq-group.com>
In-Reply-To: <499869db340b2d4c257e12d20e15c200d0f815b1.camel@ew.tq-group.com>
From: Bruno Thomsen <bruno.thomsen@gmail.com>
Date: Mon, 11 Nov 2024 20:29:18 +0100
Message-ID: <CAH+2xPDip+mTxhMUHVXQfmYN5cROiMyFxMb1xzxT54y9cP5Acw@mail.gmail.com>
Subject: Re: [PATCH 0/8] TQMa7x DT cleanup
To: Markus.Niebel@ew.tq-group.com
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, =?UTF-8?Q?Jo=C3=A3o_Rodrigues?= <jrodrigues@ubimet.com>, 
	linux@ew.tq-group.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den fre. 8. nov. 2024 kl. 15.03 skrev Niebel, Markus
<Markus.Niebel@ew.tq-group.com>:
>
> On Fri, 2024-11-08 at 14:49 +0100, Alexander Stein wrote:
> > Hi all,
> >
> > this series fixes some DT binding check warnings as well as removing
> > duplicated nodes. Eventually IRQ support for thernet PHYs was added.
> > Additionally add CONFIG_JC42 to imx_v6_v7_defconfig.
> >
> > Best regards,
> > Alexander
> >
> > Alexander Stein (8):
> >   ARM: dts: imx7-mba7: remove LVDS transmitter regulator
> >   ARM: dts: imx7-tqma7: Remove superfluous status=3D"okay" property
> >   ARM: dts: imx7-tqma7: add missing vs-supply for LM75A (rev. 01xxx)
> >   ARM: dts: imx7-mba7: Add 3.3V and 5.0V regulators
> >   ARM: dts: imx7-mba7: Fix SD card vmmc-supply
> >   ARM: dts: imx7-mba7: Remove duplicated power supply
> >   ARM: dts: imx7[d]-mba7: add Ethernet PHY IRQ support
> >   ARM: imx_v6_v7_defconfig: enable JC42 for TQMa7x
> >
> >  arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi  | 61 +++++++----------------
> >  arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi |  3 +-
> >  arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts  |  3 +-
> >  arch/arm/configs/imx_v6_v7_defconfig      |  1 +
> >  4 files changed, 21 insertions(+), 47 deletions(-)
> >
>
> For the whole series:

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

Thanks for the cleanup.

/Bruno

> Reviewed-by: Markus Niebel <markus.niebel@ew.tq-group.com>
>
> Thank you
> Markus
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/

