Return-Path: <linux-kernel+bounces-311056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C55A0968460
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF4B1F2334F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C8143C40;
	Mon,  2 Sep 2024 10:15:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117B13FD99
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272129; cv=none; b=Pvm7tVI7SuqAaC7r24UysbQYCvONhthUm63/udbcsDKmAaa6r6Q3fFIUFvEGxhIiL34lfFyu1xP/Li6oLzEHsUBoOW16HPiSmfuqsuMgxM5B8++yIGw2zmhqRo4V0EWGyiTJBknghoQqWAl/yXg3c1TL0gX5jFbvUvox5Aq7chY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272129; c=relaxed/simple;
	bh=ncvWyz3EvQrDWFuUKYkLMIRnc3nw05OT53T6DsygmpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FDc98Oz8n0PC8ZpBCWh5Io1IWT6KmsAazgG462ffgMJSopnufNvcEEIv8qizZ7loZLHcvBP+b6ceIXi4o91Cp6kjefnzIoIkSNLaOL4ES02RlhUUYg6b0PI70IEcURZ1a8TysIENo9oNbhGdvxp25gjzw40cPTjTEAZmssGX7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl45g-0006yu-LS; Mon, 02 Sep 2024 12:15:20 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl45f-004sTx-UM; Mon, 02 Sep 2024 12:15:19 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl45f-000gwP-2n;
	Mon, 02 Sep 2024 12:15:19 +0200
Message-ID: <d6a49e24c2510129c183b2795e21ad3dfc7409f7.camel@pengutronix.de>
Subject: Re: [PATCH RESEND v2 2/2] reset: eyeq: add platform driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, =?ISO-8859-1?Q?Gr=E9gory?=
 Clement <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Date: Mon, 02 Sep 2024 12:15:19 +0200
In-Reply-To: <20240730-mbly-reset-v2-2-00b870a6a2ff@bootlin.com>
References: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
	 <20240730-mbly-reset-v2-2-00b870a6a2ff@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-07-30 at 18:06 +0200, Th=C3=A9o Lebrun wrote:
> Add Mobileye EyeQ reset controller driver, for EyeQ5, EyeQ6L and EyeQ6H
> SoCs. Instances belong to a shared register region called OLB and gets
> spawned as auxiliary device to the platform driver for clock.
>=20
> There is one OLB instance for EyeQ5 and EyeQ6L. There are seven OLB
> instances on EyeQ6H; three have a reset controller embedded:
>  - West and east get handled by the same compatible.
>  - Acc (accelerator) is another one.
>=20
> Each instance vary in the number and types of reset domains.
> Instances with single domain expect a single cell, others two.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

