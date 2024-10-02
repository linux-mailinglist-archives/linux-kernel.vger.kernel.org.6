Return-Path: <linux-kernel+bounces-347089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6898CDA9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E7BB2124C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003F1885AD;
	Wed,  2 Oct 2024 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RNkBufXd"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836487DA81
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853542; cv=none; b=fNAYTsq8U4yzrSLLPvcA8q7zmqeTBo/Eo0m99JpQ7vUE23C0LPYHMh/REyajRvbcFsxJaITyiis007PsXQdv674N5sTcJqwFge71KBDUk69VfmV3f+FVoMEg4oLjRBPizI5Xt4b1GZ7S1fKoEMd1Job5mw+Wdltz60yG8x9g9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853542; c=relaxed/simple;
	bh=h2L63Hjt//sawD6KF5ZXuFON46cUXT8sUuXLt2VSNP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0vNdjxfgM8URNwen8ux0TdxCm4l7L+y/7w9UaMOdCD0BeXHsufGGyq4rf9LKX1+zm4lbqc0y1Ke0zdu8qCvFILdgoVKUdHvvkFgSmiM1q2dCpr2XVVJ6x0FFhJXamLGyLqFbm4YupkJPrXpgDoJTEKCVZRIiNz/SHszpVb7Kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RNkBufXd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3AC1FF804;
	Wed,  2 Oct 2024 07:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727853538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2L63Hjt//sawD6KF5ZXuFON46cUXT8sUuXLt2VSNP8=;
	b=RNkBufXdSbZHsntgIhy3xUQxbrYWO++SlOZjyz6wNVF6VFe2Qt+oFWVu0pAIKol0PFX3SJ
	fJOiwoFSUrvblvt05eKl79ZJ3qXqct5Hth16QJEmBTvEKu4leZJ/NM6kjR6e5UoxZ+PMZG
	qaHHLPrUGUkaXOM1qO9Aa4fuktg+ZGkby8jVqvho48fERknVYy0fz7ZW01FdoqyDEEmwoK
	Hn/YY8LNDP4DdEG43LyuabaQw/LcjB3jdmg47XsxbRTTpc9UFUPTDg09G2kGumqFbtdVjR
	/E24cXXxbs3jL32PIbXaBDQIkdlOI8+iPVRaXNU5/OsmI510NmIgOn/6BFRLpw==
Date: Wed, 2 Oct 2024 09:18:56 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 bbrezillon@kernel.org, boris.brezillon@collabora.com,
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH 1/3] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_STATUS_BITS
Message-ID: <20241002091856.17ab576b@xps-13>
In-Reply-To: <20241001-i3c_dts_assign-v1-1-6ba83dc15eb8@nxp.com>
References: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
	<20241001-i3c_dts_assign-v1-1-6ba83dc15eb8@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Tue, 01 Oct 2024 13:08:20 -0400:

> Replace the hardcoded value 2, which indicates 2 bits for I3C address
> status, with the predefined macro I3C_ADDR_SLOT_STATUS_BITS.
>=20
> Improve maintainability and extensibility of the code.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

