Return-Path: <linux-kernel+bounces-441130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8469ECA17
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A6284B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A208209660;
	Wed, 11 Dec 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yvnsj5DW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5815236F89;
	Wed, 11 Dec 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912131; cv=none; b=BYXbd5OZ5jb+ULEXduXrzAyl5CV97rc7CPJvGwngiOW9bms1AJYazJaEh3m9DJAyhGwSQT62gqh61jypcirhZahGqllCHiJ0a1Du03TjkXRUypxFbS7Z3mNs5Pplx9nUOUuuewchu8yye14yajb9J3HgWYIzfTru61pBi6zflac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912131; c=relaxed/simple;
	bh=eAufraMFMnfi2IGWNJkkS7Jvw+zFLnnar89/NtNbjiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GttylrkSzg5tLiwRkMit7JVf9aVqRCLw19NDepXp6CciWam/KNk1MSn0KYlxRlYOxfh50QFz8GB3CgLaU5QfDyB4yk8hZ/GESrAm5vuBX1klEwf7MIVTOKVuhY59Liuy1Z8mDbYCJUMivrn5SVHc4+zb7NOL8WyfZvmqD7Tb3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yvnsj5DW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733912128;
	bh=eAufraMFMnfi2IGWNJkkS7Jvw+zFLnnar89/NtNbjiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yvnsj5DWio7ojSsr0PD02rfB0+uMYYEQE5WOnSyNKDR2HjXw2rK0L6TOU2DEitxH0
	 WCmWJy+dRCAtn4kkAO2idsGzsYbsk4bSeexucu0C/CtgEMa7ntvSaBmuWJna1s3IIh
	 t42y5gLCjbp0Oo8wiRKOWdoSKuyn2HUNlZW9kgHbJ/nrdpECJWYlWXnfvKEWa/lCVm
	 DMrsT5+7ZE/NSQZHXmWAgh3XwHYe1o+XKAzO75BOtACPE0m88HHHrIjxCp7s0CCdji
	 6LedlVG9x8WnqtBB3ySrHevu/oYhsIa37BhZ9WjgmbvSfSfwKtOJq+tqHrTRE0RCBh
	 fBXjJd1cKBCOg==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CD64417E35FC;
	Wed, 11 Dec 2024 11:15:27 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 11 Dec 2024 12:15:05 +0200
Subject: [PATCH v2 1/5] dt-bindings: display: vop2: Add optional PLL clock
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-vop2-hdmi0-disp-modes-v2-1-471cf5001e45@collabora.com>
References: <20241211-vop2-hdmi0-disp-modes-v2-0-471cf5001e45@collabora.com>
In-Reply-To: <20241211-vop2-hdmi0-disp-modes-v2-0-471cf5001e45@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

On RK3588, HDMI PHY PLL can be used as an alternative and more accurate
pixel clock source for VOP2 video ports 0, 1 and 2.

Document the optional PLL clock properties corresponding to the two HDMI
PHYs available on the SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index 2531726af306bd388c00c3c0a1785b2c7367e2bd..46d956e63338e196361483a668fbf5597ebce24f 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -53,6 +53,8 @@ properties:
       - description: Pixel clock for video port 2.
       - description: Pixel clock for video port 3.
       - description: Peripheral(vop grf/dsi) clock.
+      - description: Alternative pixel clock provided by HDMI0 PHY PLL.
+      - description: Alternative pixel clock provided by HDMI1 PHY PLL.
 
   clock-names:
     minItems: 5
@@ -64,6 +66,8 @@ properties:
       - const: dclk_vp2
       - const: dclk_vp3
       - const: pclk_vop
+      - const: pll_hdmiphy0
+      - const: pll_hdmiphy1
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle

-- 
2.47.0


