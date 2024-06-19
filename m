Return-Path: <linux-kernel+bounces-220930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F47E90E951
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D68FB241C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF313F426;
	Wed, 19 Jun 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xp+rYdm1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101313CA92;
	Wed, 19 Jun 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796250; cv=none; b=eegYWVz821JVPpz9gwDeeyfmb/sZLD8vlhJ476gWBBKtvoA7Jd/U0Us8PuKMGa1SXE0lp/5aGPz0RSc7BFd8+PFhvPsJLfE2EfafXPNjovnbRfHiV0KZBVJgNvZxz3J8dCjwfd+VtDSguhhCHj34eJyt4Zc5GN/oP1zAmfORG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796250; c=relaxed/simple;
	bh=GzRDLnuFoZMdH1hQlF6ojeOZvsWqIJBgLcgKRUN0xBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WV462zO9PGDaVMp61czs4m5jL1W+qmcHOfjsy78cNdyO/AIPb7bJYs/9mDv+favDeCtn6VWkGDE37KaZtIhd5qCg4657YEJh2Km66mfFsbwAiFSqxW2ItoCtMxk43h6mGQ+LoihzqcNrQg6jOkU+wqQVd0rhqasRggeblLK4UB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xp+rYdm1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718796247;
	bh=GzRDLnuFoZMdH1hQlF6ojeOZvsWqIJBgLcgKRUN0xBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xp+rYdm1YH+nboSfAZtAX6s/iXzFdiKjJH5gkZ0DCVDMVjCAy1YuntkUvZCXqhVrQ
	 NtAssv1O5l8f8VYQ0/Vchpmb4BDqf3NAPni6h8ZOmEf9q6uf4u/u1eJoSB2Ncw5VbZ
	 68iNYbjDljRoOwuTEGg+2RuB0PXVDJqUKD80byW7U5BtSw6UstP1aiOricV7BVeaI/
	 SUpr7AEe9ZronJtk9fSoEagOot88qyaUmXV5cTWGmE80ZYbzkvRUwuC7Z1xtaMLu25
	 4EQ7gxyLoWUeLVzF9u+lpCnOJuB4xwPQdaLRimN5jmmudpXHMR2pGTA4R6Li6m5HYG
	 0wCjvu9/O4bfQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E320E37821D3;
	Wed, 19 Jun 2024 11:24:06 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 19 Jun 2024 14:23:33 +0300
Subject: [PATCH 4/5] arm64: dts: rockchip: Fix mic-in-differential usage on
 rk3566-roc-pc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-rk809-fixes-v1-4-fa93bc5313f4@collabora.com>
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
In-Reply-To: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

The 'mic-in-differential' DT property supported by the RK809/RK817 audio
codec driver is actually valid if prefixed with 'rockchip,':

  DTC_CHK arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dtb
  rk3566-roc-pc.dtb: pmic@20: codec: 'mic-in-differential' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

Make use of the correct property name.

Fixes: a8e35c4bebe4 ("arm64: dts: rockchip: add audio nodes to rk3566-roc-pc")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
index 63eea27293fe..67e7801bd489 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
@@ -269,7 +269,7 @@ rk809: pmic@20 {
 		vcc9-supply = <&vcc3v3_sys>;
 
 		codec {
-			mic-in-differential;
+			rockchip,mic-in-differential;
 		};
 
 		regulators {

-- 
2.45.2


