Return-Path: <linux-kernel+bounces-401754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0709C1EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA57F1C21544
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D61EF095;
	Fri,  8 Nov 2024 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="oSJDw8x6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ERAhNC2S"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E51E32BC;
	Fri,  8 Nov 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074598; cv=none; b=KyVXCtegegVysj15tcdlzCXW6CbczcVgcti5ETQjd+ADxMAic4ZpKE/kzfoP/zkT3chEupT0S/KQnzrkWLcc4zBpvJ97Co4jdaT0shkxdCoeRD8KxvbbnqC6vkQJEHUCbRbQF+WHqzYg93vKmqvL9kn9vIZjtFprTuRtA6uD00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074598; c=relaxed/simple;
	bh=XfNLrjUNmr+gt22QHvtHDNIY0mNA9EcdGXQ4XNJLGp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZdseJSE2OIV5+xFueclaJALscSNyQtjfJUeLh4weReYrQpogfTfg1b3Bm0IUDpiz9pT9SH5Q1Fy11v38vnRldzl5V7qnwmhwi0RilL4VExFmyXwNfIRUvieau1Puk9Jkl9Z0wwZ/qjuCoU2pbWgF+MwLVrDjvbVw31nuwyLGGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=oSJDw8x6; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ERAhNC2S reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731074595; x=1762610595;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8s7i6hTY4ZPYkVZsEa+kaw6R5w8zz4VVGAZwBGp4xjs=;
  b=oSJDw8x6G2BsEehRSWgFHUx+gh2zyyFarAdNFhHL+kcBzS8XKTl8eXSB
   0YjikKIcrQSZQNYFHhafWvMd28/ugsna4+MG0ij4oX5/hhpMXu1MGwUub
   ruPHtv2iDy4/4RyGfA9O3xAo5HbWaINi07v5usoFkfZwW0WFDBn7+cJR6
   1AiE5B/ueXvBcio3I+xv3sOHpoLghi8vRUQlACZSZjhtbiKyAWSK3XS/g
   noIhRFE8SHa4P231qOvRid+niTpw5yO/Ys6ugbvFYFOBeZTeIfZa7wDBO
   MZEs0paqAujU/fOvlw402rPhvc5ysWyOFQ7aunCcqNbjUbUuaPaWuUcTE
   g==;
X-CSE-ConnectionGUID: k3gsdjO5TCWoFDaYJiNERw==
X-CSE-MsgGUID: m8ER5V4aSjmP+6cWLiGuTg==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39937221"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 15:03:12 +0100
X-CheckPoint: {672E1A20-13-86C05612-CA75E1CA}
X-MAIL-CPID: 502FFC223A986D9CD1878CBB94DDB6D4_1
X-Control-Analysis: str=0001.0A682F18.672E1A21.0001,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0267C163598;
	Fri,  8 Nov 2024 15:02:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731074588;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8s7i6hTY4ZPYkVZsEa+kaw6R5w8zz4VVGAZwBGp4xjs=;
	b=ERAhNC2S1xpiZuyO1UqvOQCIZ37b2yPkbjIPTYXEGUAtVGHkgfhR8CpRUMjR23mKPIHpax
	lc2Vv3hVStSEAZNpRLJAb/CTKfCY5tDOWV/r4EjOs7LYAm/t9Z0oHAEWf21CPR1KW936/7
	B9EL0oPQCnM5ZYwqaywYvcviu5ZVHJiMY+C0QfSdtkXB18MycR9FVgQ33IULYjryjPO8hZ
	Asco2jBOnFWbryeKjqDl/FN63ICHE2HgMZf95gJHabr6wAili93UhxA5HcMz1TbbTkki/o
	5sr64w8UXPqUjP2MOEOQlDAxY0yHBIoYbR1JGYguxTrWDqsLIdDzC3kcdOaJcw==
Message-ID: <499869db340b2d4c257e12d20e15c200d0f815b1.camel@ew.tq-group.com>
Subject: Re: [PATCH 0/8] TQMa7x DT cleanup
From: "Niebel, Markus" <Markus.Niebel@ew.tq-group.com>
Reply-To: Markus.Niebel@ew.tq-group.com
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>,
 =?ISO-8859-1?Q?Jo=E3o?= Rodrigues <jrodrigues@ubimet.com>, Bruno Thomsen
 <bruno.thomsen@gmail.com>
Cc: linux@ew.tq-group.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Nov 2024 15:02:54 +0100
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Organization: TQ-Systems GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 2024-11-08 at 14:49 +0100, Alexander Stein wrote:
> Hi all,
>=20
> this series fixes some DT binding check warnings as well as removing
> duplicated nodes. Eventually IRQ support for thernet PHYs was added.
> Additionally add CONFIG_JC42 to imx_v6_v7_defconfig.
>=20
> Best regards,
> Alexander
>=20
> Alexander Stein (8):
>   ARM: dts: imx7-mba7: remove LVDS transmitter regulator
>   ARM: dts: imx7-tqma7: Remove superfluous status=3D"okay" property
>   ARM: dts: imx7-tqma7: add missing vs-supply for LM75A (rev. 01xxx)
>   ARM: dts: imx7-mba7: Add 3.3V and 5.0V regulators
>   ARM: dts: imx7-mba7: Fix SD card vmmc-supply
>   ARM: dts: imx7-mba7: Remove duplicated power supply
>   ARM: dts: imx7[d]-mba7: add Ethernet PHY IRQ support
>   ARM: imx_v6_v7_defconfig: enable JC42 for TQMa7x
>=20
>  arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi  | 61 +++++++----------------
>  arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi |  3 +-
>  arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts  |  3 +-
>  arch/arm/configs/imx_v6_v7_defconfig      |  1 +
>  4 files changed, 21 insertions(+), 47 deletions(-)
>=20

For the whole series:

Reviewed-by: Markus Niebel <markus.niebel@ew.tq-group.com>

Thank you
Markus

--=C2=A0
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/

