Return-Path: <linux-kernel+bounces-277184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75905949D99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D6F1F24042
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529793C092;
	Wed,  7 Aug 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YIL0IZnG"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8C3207;
	Wed,  7 Aug 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996538; cv=none; b=LQE3Qy/al0iotPtMzoDOaDP3cL24YpFEmbPh4T+JDl/6l2LaP4J6Z4l6sDDGpM7mGJM52640ty4ViGNUoCfp2w7guIc6UDtnsHIXWmoKgSx6MsyZMqfdtF4XGEw5WT+YiWyyNquvO9AwQFXB5uEplvfY5vjEb0/FcytCVng83dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996538; c=relaxed/simple;
	bh=Nu3LqlrZJuQigZRELk9wd37edloXjvXBzjs++dVFk5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L+px0AQiw9paTPIXg+sxIat4pl8UFwunBKr3CBbm7FNK4ZhtDD/bePN0WY1V0s1Sj2rZtSPV6IHk4GsBLEVUYDnqE+JYSeYUN2oIIn4CSNbkDtdcLgzGkZ/6tqfkCM5tSwjEDr4jsNQpwnY2mlknjFs8xPCZGBbcCqb/j5Xsp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YIL0IZnG; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722996533;
	bh=nDl2m8ByNTDL/Jr5G7cbij8hr6lhLY2gB+yNYJiRltw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YIL0IZnGxDfFr3ZM+58Tsk19y7Rj68uU3RXsrtsbRCQa3ua0v5fiopzLvYjfGtn2w
	 aFcnR7rxVQWcV0NiXZitMUTrNbhGn5rjoLiNop0XnWh2Oz2bHaomJBLeFjE+ndnq98
	 op6C9BzJY/t4grLQ2FgAP/l9tRSQ2TUi5erxdycWREBhnu4+pb73l6/85Ii2GmxAQ5
	 jlPxQvXnrWOq9+bwIrI95FdIyzpLle8yCGuXkKOhVZj2v6PFPBo67JfNAFFKrvfaSh
	 1R+9tx2CwSKRBRQj7/geJxUxQeRemmcDmZsRyqhDFePlHGNGQ0+nk5vzzBXENp/Pfo
	 xUkvAiIRayJ2w==
Received: from [192.168.68.112] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9F099654E9;
	Wed,  7 Aug 2024 10:08:49 +0800 (AWST)
Message-ID: <5218da67149847bb803081b9f59ed031ffd7b43c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/5] Update the device tree for Ampere's BMC platform
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chanh Nguyen <chanh@os.amperecomputing.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, OpenBMC
 Maillist <openbmc@lists.ozlabs.org>, Open Source Submission
 <patches@amperecomputing.com>
Cc: Thang Nguyen <thang@os.amperecomputing.com>, Phong Vo
	 <phong@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 07 Aug 2024 11:38:48 +0930
In-Reply-To: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
References: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 07:18 +0000, Chanh Nguyen wrote:
> Updates the device tree to support some features on Ampere's
> Mt.Mitchell BMC and Ampere's Mt.Jade BMC.
>=20
> Changes in v2:
>  - Add eeprom nodes to the riser cards and update commit message   [Chanh=
]
>  - Remove the "Add I2C Fan controllers"                            [Andre=
w]
>   =20
> Chanh Nguyen (5):
>   ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
>   ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias ports
>   ARM: dts: aspeed: mtmitchell: Add Riser cards
>   ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
>   ARM: dts: aspeed: mtmitchell: Add LEDs
>=20
>  .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  16 ++
>  .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 154 ++++++++++++++++++
>  2 files changed, 170 insertions(+)
>=20

I've applied these to be merged via the BMC tree.

Thanks,

Andrew

