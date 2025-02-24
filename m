Return-Path: <linux-kernel+bounces-529691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF0EA429EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E061605C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852B266196;
	Mon, 24 Feb 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JtZNii9m"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EAB265CD3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418331; cv=none; b=KgJ4Lrd8oRvIUt5K9j5qwRj992yJQVRJQkG5IPa5neNf2VeYarObc5EyEs4NpIfoDbSCAfI0OeClGnliCq78TEU9kVAzO4YDSOjLV7VMqS7hloygepZqiXwxAxKLG/c7anlqIR489gE0YAB4pfNi2K24YTOrC17ecA5YdUt817c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418331; c=relaxed/simple;
	bh=oIB0SGCz6w/sdFWz/voO0kJ/tz/pNsc4Pe98Mbdlmuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otEqsvlCQ+6XANiKR1xkOUR2R/XbvMO5X5evYVAW5c8FMLFAn8uyEgjKyuSyFXcQQyUDmGyr1Q7loSHYPOvN9eEhZuiAGZtaLgMsl0hmqwzXf5+WdvdWeEWDwOpYIF9VsGMcp+mHX6kMIy8yVq5JgeHcZCJsFVqLfqgF3SO5pDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JtZNii9m; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so6940689a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740418328; x=1741023128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhxXNmQS7HiqcndJwzB1tfncWGWAmFhTQNVTNzL+Iew=;
        b=JtZNii9m2CclQdlEmJ8tK24LCj6XEuU3LqkFARNKiLvFT61QPErlqVStQvrREXP40V
         w+A1L3lgCtrozH3xOhaRz66a1n7CuWOfjoHeiWEu3luJbKfzNwOfr1OIhEErPIJI2EyC
         q5nKLA5INTlnHUEjGqBiTJWOSeHI5KelLduYCL/YH+mEc83wq6wIHIOrcCqidREb5Jwq
         Q6VJ2VYZdt1UhkgD+Paq5iy8S6du0Fia9Bei5NSPsCWf6SoI6uQE10+SZoMgEX3ier1m
         tFXMgJlJI8TFO4Ov3gPVP/1aThmsFKPX5U6QEN2MHUxPERrfTffo1f/lhUGEW6Q8WZw6
         Cjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418328; x=1741023128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhxXNmQS7HiqcndJwzB1tfncWGWAmFhTQNVTNzL+Iew=;
        b=ZfiJ8oq+RWn9IfyvmPLEbA/BHKlLYY8qT/u29Gg8EI5zi2a44TxPt/LYD0KOBbcKNa
         6LdeNL63eaOal4cpDm4yA6MPy29FiVuhujSYt/tBARG5n+LOA7s0SunU0xhlMRFSkwlR
         j8PIySnMYXxjYzNbVIWcZQWIzm0uIsOXp3mpCMWEbEFRttACMuYsHDtxPkoFOMEqBoDo
         Xm8fYlBRBdyDDzYns0RnI5QiAPptat9OORSKmNjy0UL+6oZdWUibUIma6Ph2LM+DuvMa
         CZVt7w83UYGRVizGSE4s7EYLPz+Xacu9WJ9/kGj71LgaiykUKILGOW9QoC7JgxzpVdBM
         w0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmvnEk/9cFOI1cUHZH0XpOHGoy7d2NCPiWSVjW3+338IjZeEjvKGahtK4PopmQqRU9wBJnQQANMQGTRhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3j4fsNq37TDEpMwOvwQoS9+jNkzVKTv3+db+e07l2ectyyZXP
	mWgGjTXy9Xjlr2RtrlCp7cEjrkoIpX4y8cPGmAKbCTQyPebRxvGqG+XKtVzfrJc=
X-Gm-Gg: ASbGncvdL4/9Ji7EepObyqegttx3AGQ2XznLKVZUvgZW2R8575Wp5DsM/25pbokn1Ch
	DJxCDxiRL4JdOqs+kzYVdAG5X4fWACzl5rYWF0J83SQqvjFdvGT2k/4ghCu9vSOxWR+SPNGHaSv
	MziKKcpL6cTEHeiVHWthiIdVdmCHyRgqya4mOWm5PGScSPQZQis8qcI612AkVaCPrQPo9UPsQpq
	nkTpQ/bhhZGdx5L7yscxqe78qkPZEkI7gI6wyyuvLH5OHD5lksDW624vvcZ+kXlTBCNUX309PpP
	301grq6mBiDEWzjaswYbOGg7jwTuyyuaHr5bxrVxyXXlLUUEs7tkW7M=
X-Google-Smtp-Source: AGHT+IEOW8+Mti0kStIcH2NN1v3JN2p1VlS2xp8UH5KoJEBDGTjvf4FDX9S2JYf1r+OelyXxGOdoUA==
X-Received: by 2002:a17:907:970c:b0:abb:eec3:394c with SMTP id a640c23a62f3a-abc0d97e77amr1259252366b.5.1740418327678;
        Mon, 24 Feb 2025 09:32:07 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270a7fsm18674357a12.58.2025.02.24.09.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:32:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 4/4] arm64: defconfig: Enable RZ/G3S thermal
Date: Mon, 24 Feb 2025 19:31:44 +0200
Message-ID: <20250224173144.1952801-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a1cc3814b09b..c3336b1342c5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -714,6 +714,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.43.0


