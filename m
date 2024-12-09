Return-Path: <linux-kernel+bounces-436981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474209E8D96
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4743A163D11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E133921519F;
	Mon,  9 Dec 2024 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HOkJRkUC"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF712CDAE;
	Mon,  9 Dec 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733425; cv=none; b=lnVhJhxnv0hfKupUfzWSMYmqvrBke4wclPnTYia065Q9mT1Exq/SQsroJlllvjWe+x1RnWGECimEE/5bDA8YAVml/35FNHIaqwUItqE3phKUPpnLEKAuv4R7B1l0JzCko4Gz/+3AA/gWaSMt039y2VVLnvGWbjwZ9IZlbTwAxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733425; c=relaxed/simple;
	bh=Mx2cKztEKfWJv1Vt5zUj8atub7ZndKLWx4o9jbm0rb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCkem0+rzu3S3PFBMQ3eTeuyFVANrNePpKbjYEY5jAb7hX1fYiEQDUzCDuvCuaqOc1e35XPEMbrnOsyTTg2d7cRT5Psfo2zH5cbQoiSi9pNJqQE3lEijUv4ZS6UzTtL4OXQc05DK33KfSev8CSIehJlZXBHnTo4qHuQEuNpPKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HOkJRkUC; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=X/9jiZf8fhiFA/PL6cxviF54vzVJKoJF/l6rlSVMZjM=;
	b=HOkJRkUCQsYZxQpDrUDpho8429/DazomUdKSR2WERRmuFyqhiu/HTyBgThrkIZ
	tL5ACN2QeSHWOqXW3L/kuABL/n9zqULYiZpZr99R93WLq6aonAp6TOrfWv1R59mq
	rwtUJvEbt60sOBHpR92Hd8A84LvL8eSVyopke/ZsEpUsk=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnhkH7q1ZntyyNBA--.47700S3;
	Mon, 09 Dec 2024 16:36:13 +0800 (CST)
Date: Mon, 9 Dec 2024 16:36:11 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: Add ABB SoM and carrier
Message-ID: <Z1ar++87FwO3jEpO@dragon>
References: <20241105064206.43626-1-hs@denx.de>
 <20241105064206.43626-2-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105064206.43626-2-hs@denx.de>
X-CM-TRANSID:Ms8vCgDnhkH7q1ZntyyNBA--.47700S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-7KsUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCw2wZWdWeOzhYAAAs3

On Tue, Nov 05, 2024 at 07:42:04AM +0100, Heiko Schocher wrote:
> add support for the i.MX8MP based SoM and carrier from ABB.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!


