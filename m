Return-Path: <linux-kernel+bounces-305013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C76962822
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304F8285A69
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED3B178CE8;
	Wed, 28 Aug 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Cp5ECIh8"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2881C69C;
	Wed, 28 Aug 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850113; cv=none; b=NTuB9L5UYsDxRKcQ6O3HCVIFYLYsQ9RwprETaWdwWzwA/oBpZ62GfsAdt9PeR/heQvweem/BOZR70QwQsEAbE0qJ9w3FeJs1fL0m+zSTV/lCW+Fn0/QHw6N0sbxzLQlvKotYqsv/OL9nT5hw5CoPiDcc0iMDXOuZ4q8b//09WcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850113; c=relaxed/simple;
	bh=rLgqHNKEQndI/ZqfPsBhs7kFIWtmiKTP5/dhk5W5guI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWgZJwxf9moIhldb+kfrHtbJ2FPvEGFVEQ8QXpe+d8mYSEEG0e9SE/Tm497+4h6vNXALjc5cBOjDv7YmPR1HdQsnNPGBkzrQyg96w5H00FiYA1lWO+Mo0xB6O0nmmutYRV0sh3rnlfFUpy+7BN2Hxz/IdrCx/Upopgt5T8/ro50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Cp5ECIh8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=69SKT+PKbsqR/IWoM1lSbvTSHLKO5Vqf0QLF3x2EfAc=; b=Cp5ECIh8zK9jXYUjfefTv96G+L
	q2cQWq0FYGLEkkAxx1g8xXSQQrysmkdfkRLqD2EeLWRWjXJHrrnwAN2P5yZtg1yojhEcvxqis5XIu
	JvUCwCPYPkZW83LBOV713DwvQJhtz36GGXRmlzeDf8/qQJE+9YiHlQVPP7UWvi/Mdif3Jm0iu5ni7
	WZCGZyATECOocrQ5DoA6d2cDg0DLiBxkLsf3Y2rF1T47vMnimK/H+TgubWjDVemX1Ga+VxPGGonyp
	NpQdFoRCDFj4HCNeeIrchUWrX+/5hvL2tuJePLoGUnVRwMF5RSrOhcQTJd/uXo04/MuUFAy36yf7B
	VhqG0s8g==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjIJ3-0005Q5-M3; Wed, 28 Aug 2024 15:01:49 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jonathan Liu <net147@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK
 4C+
Date: Wed, 28 Aug 2024 15:03:01 +0200
Message-ID: <3044642.0vhOF50zNu@diego>
In-Reply-To: <172484936512.3462690.18423493121475512611.robh@kernel.org>
References:
 <20240828074755.1320692-1-net147@gmail.com>
 <172484936512.3462690.18423493121475512611.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 28. August 2024, 14:51:12 CEST schrieb Rob Herring (Arm):
> 
> On Wed, 28 Aug 2024 17:47:53 +1000, Jonathan Liu wrote:
> > This adds the necessary device tree changes to enable analog audio
> > output for the 3.5 mm TRS headphone jack on the Radxa ROCK 4C+ with
> > its RK809 audio codec.
> > 
> > Signed-off-by: Jonathan Liu <net147@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3399-rock-4c-plus.dts | 46 ++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y rockchip/rk3399-rock-4c-plus.dtb' for 20240828074755.1320692-1-net147@gmail.com:
> 
> arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: pmic: vsel1-gpio: {'rockchip,pins': [[1, 17, 0, 194]], 'phandle': 138} is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
> arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: pmic: vsel2-gpio: {'rockchip,pins': [[1, 14, 0, 194]], 'phandle': 139} is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#

unrelated to the change in question, as that affects silergy regulators.
But I just asked Jonathan to check on their board if we can just remove
those seemingly unused pinctrl properties.




