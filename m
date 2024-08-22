Return-Path: <linux-kernel+bounces-296403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF095AA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C42AB22E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DD1D53C;
	Thu, 22 Aug 2024 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Ja6jB0O2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71DD3C30;
	Thu, 22 Aug 2024 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290818; cv=none; b=k+Ape97RZjZ+RkhdKtiaLXTrBPTIfcffsaYJcVbjCXQUmHYkmCXDNKLrs418iOSkZRawg7Qjeurrz0MlgkNiVsegbfeEu0bRmr8gwnlPvJ6fk1dH6YPdqfDmU7IGFQlQyiOSAFHK54aFLEeH3Yr4yeRwdHFn5UIr0d6iDDOvEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290818; c=relaxed/simple;
	bh=gHlbYubY8dlunxVf92UHONMEHDEjyN62Z8uVQjTQElU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=du4RYRIO+wjraOrFiN7OmiZBKrQpjU87zx/W975EXZ+PvUlXAPDdpUabwblCT40ALtZopEG/ssDaia/mqFQ4I2+iO7yA9TtdszDUpbLv6+4awcq/z0vsU8/9uiXlObozL7cO2y2QUysps049RoK+Yrf0QI/m4xEMUmsKmDAWnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Ja6jB0O2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724290814;
	bh=0jpArWCYnQmFmqTNGxh5siqbEOIWInHJT4VyT0QJLDc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ja6jB0O2QLOuAABXTmnQYX69qJ/KZCKkgm1JhaCsUdPQAIvGXLS8po2ggQyPQ0H8Z
	 R80fD7MSrsEUs7cYcdsj0VPoEjeN3RjDMOzI1AuA3Wmxd3KYOUalGcQPsnQtFKInel
	 JA0feAUU1yZS+gJps+ZzgBkg51PVe+TDYzGaDe39JdTWJdPLZNFVe25ovcCKpDX3Qe
	 27u1pkF2veJ2E2Kzigy10dm+SWOHwFDMLfbXL6pDg1DUuu5z6WUjpSp5AfNcJ0WpHL
	 J6hrURu/OUxOGpU9835BNX/U+knk/GsbAqDrJ7FXriQI2KXwiUP5BLjJ03zcklJjiJ
	 fMK4XiL2v5jpw==
Received: from [192.168.68.112] (ppp118-210-185-99.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.99])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B20A264FDD;
	Thu, 22 Aug 2024 09:40:11 +0800 (AWST)
Message-ID: <98e7dd9ec454c1a8156ae74fe17ded7384dbe799.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/5] usb: aspeed_udc: Use devm_clk_get_enabled() helpers
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Lei Liu <liulei.rjpt@vivo.com>, Neal Liu <neal_liu@aspeedtech.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>,
 Daniel Mack <daniel@zonque.org>,  Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Conor
 Dooley <conor.dooley@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>,  Bin Liu <b-liu@ti.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com
Date: Thu, 22 Aug 2024 11:10:11 +0930
In-Reply-To: <20240821121048.31566-2-liulei.rjpt@vivo.com>
References: <20240821121048.31566-1-liulei.rjpt@vivo.com>
	 <20240821121048.31566-2-liulei.rjpt@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 20:10 +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>=20
> This simplifies the code and avoids calls to clk_disable_unprepare().
>=20
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>


