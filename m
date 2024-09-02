Return-Path: <linux-kernel+bounces-311058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169D4968465
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B632817DA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3EB140E3C;
	Mon,  2 Sep 2024 10:16:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2213E8A5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272189; cv=none; b=VVRjSBZrySUsJexoRwak/+vI/7O4vP/ptcAbIBub2tnlAlkYj4iGx5ybyMk4zxkMv6wHHi/sQRYi3NZUC29OFgvs0TSFh71TCxzhHb2i8g7udB3nw3bj+gwib0ZCxdTBCiU4M3j/Fxt3Z/vtCCjFYUCfo7qVZM0tZbWgZIfOAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272189; c=relaxed/simple;
	bh=bPsJsAm6A0fwGsUWvf/GD9+j90woLFe5ocw5/GH3Gqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lmDJFOs3J114o51bwynoOKlI6y1CBWJEQn+Ikd7eARPrZPDhC2DJ1BMcHzj5HwucD6g4MH+YaNRy/4kK29IfQuTLxvtt0MWQNDaMon6gD/TBJWfCuO7WdVAwSJrjq40qVFeSqkGLZGW7XgmXFCm7m+E49HTTezWu/kSu6paVOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl46f-0007Zh-0a; Mon, 02 Sep 2024 12:16:21 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl46d-004sUB-Md; Mon, 02 Sep 2024 12:16:19 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl46d-000gzO-20;
	Mon, 02 Sep 2024 12:16:19 +0200
Message-ID: <33ef63248c4c8c8941d906c20f21ef57e001c720.camel@pengutronix.de>
Subject: Re: [PATCH RESEND v2 0/2] Add Mobileye EyeQ reset support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, =?ISO-8859-1?Q?Gr=E9gory?=
 Clement <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Date: Mon, 02 Sep 2024 12:16:19 +0200
In-Reply-To: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
References: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
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
> This is a new iteration on the Mobileye system-controller series. It
> used to be sent as a single series [0], but has been split in the
> previous revision (see [1], [2], [3], [4]) to faciliate merging.
>=20
> This series adds a platform driver handling SoC controllers resets. It
> is an auxiliary driver being instantiated by the platform clk driver.
>=20
> We support EyeQ5, EyeQ6L and EyeQ6H SoCs. The last one is special in
> that there are seven instances of this system-controller. Three of
> those (west, east, acc) contain a reset section.
>=20
> Related series are targeted at clk [5], pinctrl [6] and MIPS [4]. The
> first two are receiving a second version. The last one has no change
> and stays at its V1.
>=20
> Have a nice day,
> Th=C3=A9o

Thank you, applied to reset/next.

regards
Philipp

