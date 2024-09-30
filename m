Return-Path: <linux-kernel+bounces-343819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F733989FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEF91F21151
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF218E354;
	Mon, 30 Sep 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="sW3SYXsX"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A118CBF7;
	Mon, 30 Sep 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693762; cv=none; b=reK/uJG6S4G/JmiriA7SG9yz8YcOKoti07zQOo/31tgpNT2RqyhIu3Z++/5KTJsE/mkoHUsmRqhAzcI0ZQb8EocplCJepILarZZKyNEyeg/xNspY0AVZxF4k1W9oqoVPqfPaHLCsSytA7v1hwhAAMbxmmX8fVSAUHyYMNmyvF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693762; c=relaxed/simple;
	bh=ZCawuiA0vFx4YLz4LMj6GwhLj4+T19Dibj8iqFhj3Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDFdVg/MIPdAgGs/mPXTVLBWnvaSqN5sjgeIUToUyDQr5NFjpQwKIslWwQtUYYwf407VwZsMxH5cnDKFYg8z8s3ZoiaGnURXYomMr9kpR8zrOpZlANNweOYI9tQDTWvcMMae7HqqzHPD787y5trTzF8l4nXZCDFX/tqbVkuQ2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=sW3SYXsX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4I9m5gG54Sm1ZQZRuUc8e4nrJvimsb06OLbvmpozwl0=; b=sW3SYXsX+oYNhLJeeaO6xVkhoJ
	n24TUAnmxnVEVfCqyHTPIZ3cLV50ycj+FOCQ1WGss1NEBjxzuNu0eE2sMpw9NuRzc0P9qD+aJyiZg
	dpJ0YGDMrsWdLmSPo2FpbXunA47Asd2HluRFyZ34k/PdarnaxnvZEJl4DdL2HLGnNCBupQc+JywOy
	guMUHhewNPYMlVdvFdhuwbbj85f3ujFynngI6rBafQTdqjqj1UmmfAlXMGUloBD3BKqz2iaZBC2xe
	eaUsJN/jexsmTD215w12/vbgs0Mnd5Q2uC3okFwYfC23ayxj12Ijp67cHitOrB6/k4KQEVSl6k6su
	r0EC7knw==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4D-0004Xd-DR; Mon, 30 Sep 2024 12:55:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	alchark@gmail.com,
	krzk+dt@kernel.org,
	efectn@protonmail.com,
	jonas@kwiboo.se,
	linux-arm-kernel@lists.infradead.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	andyshrk@163.com,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	knaerzche@gmail.com,
	boris.brezillon@collabora.com,
	dsimic@manjaro.org,
	megi@xff.cz,
	sebastian.reichel@collabora.com,
	robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	macromorgan@hotmail.com,
	tim@feathertop.org
Subject: Re: [PATCH v5 0/2] Add support for RK3588S Evaluation board
Date: Mon, 30 Sep 2024 12:55:34 +0200
Message-ID: <172769365134.1880381.8272330238523830438.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240914095456.2347532-1-damon.ding@rock-chips.com>
References: <20240914095456.2347532-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 14 Sep 2024 17:54:54 +0800, Damon Ding wrote:
> RK3588S EVB1 board features:
> - Rockchip RK3588S
> - PMIC: RK806-2x2pcs+DiscretePower
> - RAM: LPDDR4/4x 2pcsx 32bit
> - ROM: eMMC5.1+ SPI Falsh
> 
> Damon Ding (2):
>   dt-bindings: arm: rockchip: Add RK3588S EVB1 board
>   arm64: dts: rockchip: Add RK3588S EVB1 board
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add RK3588S EVB1 board
      commit: fab49faebdfb0c3cdec6c70334e52f65343d130c
[2/2] arm64: dts: rockchip: Add RK3588S EVB1 board
      commit: 00c7fb3b8ab25c496931686860a09994c93c76e6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

