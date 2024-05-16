Return-Path: <linux-kernel+bounces-180976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DEF8C75A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F112813FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1C145B12;
	Thu, 16 May 2024 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NbGJocm/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NwdinzhA"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52624EB30;
	Thu, 16 May 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861260; cv=none; b=siHZ62iT2o5SI0qcpHRGPfGmW0St/jSIVvdMlycrnjqfE0w2phZY2Oq2YaQSnmls+VSZV5uAd0RNdGmMZTg33Kc1Aw+OVrqYMrXw3g19anyk31t9NwbbTnvRX7GmQN1mT3Ta8Y45ua+LOZLQxVTEb9CWDnCg1Jr43vlElmDVGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861260; c=relaxed/simple;
	bh=vcdsIGqZ5qz1syFN4U6rshX8LYDZBqv5t9KYXC8SXXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuJAYv7XZXzr1VONFq1CxWoCZLyhRF4Zr9VdtmXcE2oz/2ABckpaWNnEkou+w4sUyGr0dotGnJIwFgr7a2m/eWnLdoQfeHzsNVGX7soMh6UHrIf01O/WPcpgEg6W5LSck/VFoIy1XlYHPjILtGPTNsfAjUHyFHtKNeCzO2JTL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NbGJocm/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NwdinzhA reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715861257; x=1747397257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vcdsIGqZ5qz1syFN4U6rshX8LYDZBqv5t9KYXC8SXXE=;
  b=NbGJocm/nYhNY8ItDCPxBLvGN/h2O8pG6Tb61+itiGHWN5Di3vh6mmHp
   x/V/t1HW2vTb9q8l4eOndww+mbnvRiH0bWOUhL9tCS5bdLoADUBMEHVwX
   TJc57BscwaO+X89w9y/yWfk/f9HmGMVEcZGelYBtIiV/oM/N0kAHXXMKf
   8you2V+8FWx2WhDHp3LpS74Z6TIUSFNS5kS9vFS3J/2FSaW2YEZjxXjR9
   v0C6AWlpHmdaBwZ2b0Ua23KIZosWEypKUwaVYopftLn4jwtO+z01BTmjE
   U1zcSz96LBITVUuUFvTndyvAdfC60aghjEjnmCS+Xtwg4fQ2nX6WnvveQ
   g==;
X-CSE-ConnectionGUID: RksVlVebSziJVsdXvJdhKg==
X-CSE-MsgGUID: tlJ8O3lfQa60hJSqAFcjvg==
X-IronPort-AV: E=Sophos;i="6.08,164,1712613600"; 
   d="scan'208";a="36937146"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 May 2024 14:07:34 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23DB6174204;
	Thu, 16 May 2024 14:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715861250;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vcdsIGqZ5qz1syFN4U6rshX8LYDZBqv5t9KYXC8SXXE=;
	b=NwdinzhA0JeGGqgMmGZt/8JCtKF1X2eXOUGriZ8xtAglud6v3UTZWqQ8nz3R/y1Cw84O0/
	U4AYI1vUo8hItVABU9FgsRWutlaKB1BUaGlmIa8/tNLu1QkzFNsg/zrg/Q8vn7H8rzM1Ux
	1czmd7PK1P2/3MC4JvPrYFlmQQkmPknYAlF2fYkaaR41LZd7yHXpNBJ7Eb5Iybqo90jzKv
	2K17rWErAszcPe/4kSGnP4KvdiZjQ+b9A7eq7qF/NTwAJPdIslPYmPxO3xgXloZc9MSB7j
	Ms7+cYsk+KncudPPRocDPTasNeoBkmM+AavZOKM8V2OfnqXP6he/PKkW80BAAg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Marek Vasut <marex@denx.de>, Francesco Dolcini <francesco@dolcini.it>, linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, imx@lists.linux.dev, kernel@dh-electronics.com, Pengutronix Kernel Team <kernel@pengutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2 and PDK3
Date: Thu, 16 May 2024 14:07:34 +0200
Message-ID: <5724851.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <69c3517c-0fa4-4e0d-9515-21adfb6730a8@pengutronix.de>
References: <20240514010706.245874-1-marex@denx.de> <fa01ef26-d4d4-4c62-9c12-1f8bed1cfdab@denx.de> <69c3517c-0fa4-4e0d-9515-21adfb6730a8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

Am Donnerstag, 16. Mai 2024, 13:46:33 CEST schrieb Ahmad Fatoum:
> On 16.05.24 13:44, Marek Vasut wrote:
> > On 5/16/24 1:36 PM, Ahmad Fatoum wrote:
> >> Hello Marek,
> >=20
> > Hi,
> >=20
> >> On 16.05.24 13:14, Marek Vasut wrote:
> >>> On 5/16/24 10:00 AM, Francesco Dolcini wrote:
> >>>> Hello Marek,
> >>>
> >>> Hi,
> >>>
> >>>> On Tue, May 14, 2024 at 03:06:42AM +0200, Marek Vasut wrote:
> >>>>> Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2=
 and
> >>>>> I2C mux port 1 on PDK3 respectively are used in regular I2C mode in=
stead
> >>>>> of HDMI DDC mode to permit connection of other I2C devices on those=
 buses.
> >>>>
> >>>> Are you able to read the HDMI EDID with such configuration? I have t=
he
> >>>> patch ready for verdin imx8mp, I just did not have time to figure out
> >>>> this last details.
> >>>
> >>> Yes with ddc-i2c-bus in hdmi_tx{} node, no with ddc-i2c-bus in connec=
tor node. Maybe that's what you're running into ? The DW HDMI core needs th=
e ddc-i2c-bus property in hdmi_tx{} node if you use non-native I2C bus for =
the DDC channel.
> >>
> >> What benefit does the hdmi-connector provide over just omitting it?
> >> Just for documentation purposes?
> >=20
> > I was under the impression describing the hardware in DT in full was th=
e best practice (TM), hence it is in full here.
>=20
> Sure, I am just wondering what effect, if any, it has in how Linux interp=
rets
> the device tree. I have an i.MX8MP board with HDMI as well, but without
> connector (yet).

AFAICT having a hdmi-connector has no effect at all. Linux drivers are
not using it.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



