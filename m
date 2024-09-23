Return-Path: <linux-kernel+bounces-335348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8020A97E46A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 02:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FC7281221
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE41FC8;
	Mon, 23 Sep 2024 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HBsM2u+U"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E133804;
	Mon, 23 Sep 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727052679; cv=none; b=rUpf5SXkX/H1xOCehiN/KKp/pO5/vTp5lCqip5Dft9ns7gHGMt+qT1+o0jT85LSc3dogMlbEtEh5ibHx3vm0iP2MIg8WXAJyCNJ3AiiK1c2/pjpT/zaEGCK3pYbrqLEg7KGrs/ncDZcLbkzOFKp2Lc1hFPLhUhAlzi2lTDjSsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727052679; c=relaxed/simple;
	bh=yc/v7062ftDZZgYI+EVeZmB31bsnrmNYD1yD91QAJVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbnhUS7HcNfitsXuRZ0pJcZbQCQLun7wcXlNCCAFI0mvbtSZIN6WRSbBme/Uy4USm4giwl3VL5U+P/eln0ur/8UC9qLo/r2hVKBAofJp7dQyulCe2mrSV28gikFwCXsuqfJp8TXrp8cMvKJ5IaUZzw3GwidHFBy3hTKfYav0MzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HBsM2u+U; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727052675;
	bh=yc/v7062ftDZZgYI+EVeZmB31bsnrmNYD1yD91QAJVY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HBsM2u+Uw7VUPeOsY8HCEFbiOHmb05iqGxuVSl+G13SIsP5P87SW1mVeDpP7j0Y4c
	 A+ABf8tPnX4KC6DXe4pJ4cZMJwi55Zpi7TKHkhFJsYdYY+fy7upBawMyPSN2Em9wmp
	 KaMN0OdSB1F9l4Lfy6dYXyGcNzfx2E81pYsC9gcTMzkaM6NRPMtD1p8SlUYbmZtzg8
	 qMDqR8bg/a2Ps9+8K2CmbPGRMVvctic8iTQpkApcw+Ie7brkDE/DJ0pL/hJuIGz9aF
	 /u6Ub/HgaL6A/LIAegQ1/u/+R4v84zx1WDIAhGOLuoEtFgSagGwrIOqqJVWJscTEAl
	 1PbRkDzxAuWEg==
Received: from [192.168.68.112] (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5FEC4640E8;
	Mon, 23 Sep 2024 08:51:14 +0800 (AWST)
Message-ID: <75b83e2585295bf0a9020133228a85059742465d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
 for TPM
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 23 Sep 2024 10:21:13 +0930
In-Reply-To: <20240920080227.711691-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240920080227.711691-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-20 at 16:02 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Enable spi-gpio setting for TPM device in yosemite4.
>=20

Thanks, I've applied this to be picked up through the BMC tree.

Andrew

