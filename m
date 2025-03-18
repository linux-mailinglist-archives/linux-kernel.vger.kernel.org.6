Return-Path: <linux-kernel+bounces-566510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1BA67903
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC03F19C4104
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DA210F59;
	Tue, 18 Mar 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QV7EQI0x"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C319B3CB;
	Tue, 18 Mar 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314677; cv=none; b=s2NWb75ssKlxrmLgVRebulzMKguR9AzjI1z6o/Ha5oY6r+YagqhCEmei+GsymouhIe/ZG7tHaXXc31dod+tEvqGEKc2MckAoAMJPtM9oXxxeB27gO0lXl6hyrFBmZbcXpXA50z7Yissw80Selirfbi+dT6z/NouWWx6fHa7BFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314677; c=relaxed/simple;
	bh=ym2igy2OrRFEHbZGLmiWHMoXN87HGxZYkWh0Q3os68Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uzIV4BK+YtzhsR5wGSfy5MTZ8nWlTpe5nohpe0dV5R+25yRepDUPlXwf2M1XGvC276iFiIHRzvJUHKg5/9llAqVx4+qEYf1LmT5b2Y/PjgU5Fom+Jgv1sLDKZi0KvJ1tqY2cGLYdKUikXwSEKJj3zQ2SDHVzWUfaTA4bAZnfVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QV7EQI0x; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70FE044187;
	Tue, 18 Mar 2025 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742314674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/1xnpzP9TTHmFe2YZGsO7xT/RMdtt3eNYKIyqdlcpo=;
	b=QV7EQI0xNy8e+ecLyLElhdGhXXLQujhp8sAu+E5WR+M10/9YvVdC6JaLEYL3ERXRYM4Yvv
	rO8AiSjRjuPnXZV3kIn99P/14zipcdYaIwB+wyv93MejCsVUJKgNbRD4vhu8Ai3OS06hfe
	e9XQ2v4YgoVgaNuo+wlAk7HQdD3fAnn0JEVpCFMqgWEpEgUbFEK8VhWLowoP02xmJjWBNI
	vqE+ik37us9t3zAFxw8Zeo44usvWGkRKJMPkJvsN7yHYDIoOXolnPch/YCwzSdF3ubkRhO
	eTr3YDxWtPIjgeE2SH9nftz0tmbWm6t1aakpir68Xffb4zEoKne6Y90DxXAkqw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, 
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250307220515.3282954-1-Frank.Li@nxp.com>
References: <20250307220515.3282954-1-Frank.Li@nxp.com>
Subject: Re: [PATCH] dt-bindings: mtd: gpmi-nand: Add compatible string for
 i.MX8 chips
Message-Id: <174231467335.979959.13152834934879467871.b4-ty@bootlin.com>
Date: Tue, 18 Mar 2025 17:17:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffieffhfefvedvgffhledugeeugeekudffgfefgfeftdehgfduveejfffffeeugfenucffohhmrghinhepmhigjegurdhsohdpmhigkehqgihprdhsohenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheph
 hgrnhdrgihusehngihprdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 07 Mar 2025 17:05:15 -0500, Frank Li wrote:
> Add compatible string "fsl,imx8mp-gpmi-nand" and "fsl,imx8mq-gpmi-nand",
> which back compatible with i.MX7D. So set these fall back to
> "fsl,imx7d-gpmi-nand".
> 
> Add compatible string "fsl,imx8qm-gpmi-nand" and "fsl,imx8dxl-gpmi-nand",
> which back compatible with i.MX8QXP. So set these fall back to
> "fsl,imx8qxp-gpmi-nand".
> 
> [...]

Applied to nand/next, thanks!

[1/1] dt-bindings: mtd: gpmi-nand: Add compatible string for i.MX8 chips
      commit: b0e63a0847ee2d01ac34a45eafb112227262820f

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


