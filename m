Return-Path: <linux-kernel+bounces-333029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A262997C26D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50811C21547
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DA171A1;
	Thu, 19 Sep 2024 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nMlFYnoL"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22302033A;
	Thu, 19 Sep 2024 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709063; cv=none; b=eo49bizuM9/OjO/slCodMnaKxT+m4pd+mTkTRfoSdooisfYS6yKiUCDXh48GpqncijDUCu/xlqGH95mVFeA8iHmsXkA/y977+H1g2xC5c9cplQAk1UosXhE8RLZR82wrBmS2xYgEO98qI+FnD6hNdqMoKByPNY/pzUE21vhKxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709063; c=relaxed/simple;
	bh=60FNn73+paJ1b9qXIeVpPKtcaqNLNwtGCQXM+znPqJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rl512/wUb8MaYQ2q7J5dZWLRP3gMGqzo2UtiZjNB8ylRIBK4lKsti3qDqS8DzykugWAceiyeH9h0Bd77CsId0i5WTM43GbMPABj7D0/tsFrp8CEhGTWEXna72nWg6PPuiDnrnDlfJ+Bdzl8CAjs2kVbRV0w0MS8OLuwTvDS4lQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=nMlFYnoL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726709059;
	bh=60FNn73+paJ1b9qXIeVpPKtcaqNLNwtGCQXM+znPqJc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nMlFYnoLPSMfQPySBhM8kfBVbpy4KnB2jzMUy/l6dkNpkQ/NtD8U9lFfMx7BIX4V7
	 WAst1w04ZfSRN3XGN53Gyj3TFq9pvcBTYrlLQK06lXJiHCLApt0vD1K4d53jy/jRon
	 r338KJJdyVSRZ3RnJVCjsaKUlP2idSRxPvfNkXFJbz9A8Cztv2FM5XkUkNMGGjI4vf
	 oR4KaJBplJ6VMAXx9h6JtzxzO1jZtrog00Ztyg2kHKiNjKf3iktT5MRgltf6AbEd4d
	 aVZAvj6r1nsnSTjzblr4Bq0d1Q8MXZZgTh4wFfpzhCvPi0r0FkBz6sxm04kSJz9rFu
	 URs12JW9SFM4g==
Received: from [192.168.238.88] (ppp118-210-188-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.188.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5BC0065712;
	Thu, 19 Sep 2024 09:24:18 +0800 (AWST)
Message-ID: <355b19a62e54aa979451d796c3ebe1e294a0cf45.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: support MPS MP5023
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Guenter Roeck <linux@roeck-us.net>, Delphine CC Chiu
 <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, Joel Stanley
 <joel@jms.id.au>,  Peter Yin <peteryin.openbmc@gmail.com>, Noah Wang
 <noahwang.wang@outlook.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Fabio Estevam <festevam@gmail.com>, Lukas
 Wunner <lukas@wunner.de>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
Date: Thu, 19 Sep 2024 10:54:17 +0930
In-Reply-To: <bf5258b8-a5a1-4cf3-9bd0-1fa44696c3b0@roeck-us.net>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240918095438.1345886-3-Delphine_CC_Chiu@wiwynn.com>
	 <bf5258b8-a5a1-4cf3-9bd0-1fa44696c3b0@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-18 at 10:00 -0700, Guenter Roeck wrote:
> On 9/18/24 02:54, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >=20
> > Add support for hot-swap controller MPS MP5023.
> >=20
> > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > --
>=20
> The hardware monitoring mailing list was not copied, so I assume that
> the expectation is that it will be applied through some other tree.

We can take it through the BMC tree, but I'd prefer that the hardware
monitoring list were copied regardless.

Ricky: Please do so for v3 onwards.

Andrew


