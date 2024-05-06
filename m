Return-Path: <linux-kernel+bounces-169307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538A98BC6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D81F21F48
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E247F45;
	Mon,  6 May 2024 05:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="H3qdPEr0"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8A4654B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 05:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972195; cv=none; b=OuMmA+S1gqnqdRHjZDwyAr+sPtdwTuS6q5iGAV8Gp5lcZanNW4od4z2OVHzpm2XC5lQs3qZ++74ld+/T/+YC9Y5Ay0wyu0KP1ZBiHWMK45eMLd2lml2xu/BmA5uyUbP/BAVqsVeZFVfl/PrrPvAUViwU11qYlogUzA4i/mZpN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972195; c=relaxed/simple;
	bh=6T7f2QduS96nnM7wx4ZuNCcwzMht+bTEOjYv39h4ZtY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PR4b3uxptHq08+tiYXPIxQk7ztwG9jo6h1MobSPjndxoUnnpVaYApcx14Rtj7ulJijlYvBOnU0kOXcHEIFEPVS2KzSHJ/6ldpPJgLJrLy3F0XRhZwiD4aEWZiM+zt/6GemOv4d9pnDwXdp3bsqtPR+oj/aJR5Yxm/5UPSMPvV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=H3qdPEr0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5B3392009E;
	Mon,  6 May 2024 13:09:37 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714972183;
	bh=6T7f2QduS96nnM7wx4ZuNCcwzMht+bTEOjYv39h4ZtY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H3qdPEr0OVLyCxs5buMC/BZLtXLl2w770b1tXXvIfFkt4azNnrBzwywkx8+5LeLh0
	 +eopC3rlLdUDeZCkoovso/vdj97Vr85bya03hdAffcup+tP1vwdWt1X8607yyorDU7
	 JUdOM4DLJFATFqnYtVWxXnyzxnzb7v/38zGa1fZlT+/hBXnZFZ3XXIfvjUBB+5/MOw
	 BZd6oGlqze270a4B2j/x+SDc0P6c5GQEapWxhhuUyioIn+daQxZFrTzQEwLBS9lYNe
	 XyXjx/Vm+oY3Wv1o0q5/NmofLaDr/FJDi3mrPSQ0napoSB/AJgYC8glqBhewZrX/eE
	 GZKSeWRm00IcA==
Message-ID: <645d4f645b1296d54573c4fe734768adab160035.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Dylan Hung <dylan_hung@aspeedtech.com>, "alexandre.belloni@bootlin.com"
 <alexandre.belloni@bootlin.com>, "joel@jms.id.au" <joel@jms.id.au>, 
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "zenghuchen@google.com" <zenghuchen@google.com>,
 "matt@codeconstruct.com.au" <matt@codeconstruct.com.au>, 
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: BMC-SW <BMC-SW@aspeedtech.com>
Date: Mon, 06 May 2024 13:09:35 +0800
In-Reply-To: <TYZPR06MB65675E5D43EE265DD702E5689C182@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
	 <563ad5613e9c5f0671e1f49f2d9ba71d8735799b.camel@codeconstruct.com.au>
	 <TYZPR06MB65675E5D43EE265DD702E5689C182@TYZPR06MB6567.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dylan,

Thanks for the response! I have a couple of follow-up things though:

> > My interpretation of this change is that we keep the "global" IBI irq e=
nabled if
> > hot-join-nack is set (ie, always, because we don't support hot join, an=
d
> > configure the hardware to nack all hot join requests).
> >=20
> I would like to clarify the control logic, incorporating the principle
> of disabling the SIR interrupt signal:
>=20
> Case 1:
> When `DEV_CTRL_HOT_JOIN_NACK` is set, indicating `hj_rejected` is
> true, it signifies the controller's non-receptiveness to the hot-join
> event. Consequently, we can safely disable the SIR interrupt signal if
> none of the target devices request SIR (reg =3D=3D 0xffffffff).
>=20
> Case 2:
> When `DEV_CTRL_HOT_JOIN_NACK` is unset, indicating `hj_rejected` is
> false, this indicates the controller's readiness to engage with the
> hot-join event. Therefore, it's imperative to keep the SIR interrupt
> signal enabled, even if not all target devices request SIR. In this
> case, `global` is false and `enable` is false.

Yep, I see what you're doing there, but it looks like the correct state
would never be set if we're not enabling/disabling the IBIs separately;
with this code, we would only ever enable the SIR for the HJ if we
*also* happen to enable IBIs.

The initial state would be to have all SIRs masked.

> Billy recently submitted a change to implement the hot-join enabling/disa=
bling. Therefore, it is timely to consider the hot-join functionality.
> https://patchwork.kernel.org/project/linux-i3c/patch/20240429073624.25683=
0-1-billy_tsai@aspeedtech.com/

Yep, I saw that, excellent! It's next on my list to take a look at.

It's just a little unusual that we're enabling the HJ interrupt before
actually having the HJ support though.

Cheers,


Jeremy

