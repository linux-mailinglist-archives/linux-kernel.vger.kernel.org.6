Return-Path: <linux-kernel+bounces-218807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40790C659
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F007B1C21F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DAA17836E;
	Tue, 18 Jun 2024 07:47:22 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A95176FA0;
	Tue, 18 Jun 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696842; cv=none; b=rQEGg5LgLFaOIPbw00woypUO/kV6oLo/+8gQpNuE7oP4Us2153oJgHNicbFabCz0hHVR6Nf7uXEz3bJ1oe81OZ4WG21yS7OFp6FQZqHR5uj5ubHNu+Wwiyp5bn4FGChdfjgSoSk9IvHMGhsbZFuAYnKenTAZsXoq3Xh59pUfZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696842; c=relaxed/simple;
	bh=1RCnMVGoq8iO2sXc1odMCtufBWgrw/UsHlVOFNduv2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXtFP1A8EQxgOcAg3JJWOS0q6PnQGFrXyFFjTKTkmILe07USvvZISp6wleHSyBpNLAI6jpA9o0kUhZiZHjC5dgSMSVZnD6sP7gDe0b/vcrpkzWAtZug2FBhCuXGBO8Hddhrp2RCyfHLmrWA3AhLm+6TFAqJGZGRXaax8/zJ6UuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c2.versanet.de ([94.134.22.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sJTYY-0006Fm-G4; Tue, 18 Jun 2024 09:47:06 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Algea Cao <algea.cao@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH 1/4] phy: phy-rockchip-samsung-hdptx: Explicitly include
 pm_runtime.h
Date: Tue, 18 Jun 2024 09:47:04 +0200
Message-ID: <2060846.kUgFBCI4xA@diego>
In-Reply-To: <20240618-rk3588-hdmiphy-clkprov-v1-1-80e4aa12177e@collabora.com>
References:
 <20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com>
 <20240618-rk3588-hdmiphy-clkprov-v1-1-80e4aa12177e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 17. Juni 2024, 23:48:09 CEST schrieb Cristian Ciocaltea:
> Driver makes use of helpers from pm_runtime.h, but relies on the header
> file being implicitly included.
> 
> Explicitly pull the header in to avoid potential build failures in some
> configurations.
> 
> Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



