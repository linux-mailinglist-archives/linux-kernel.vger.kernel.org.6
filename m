Return-Path: <linux-kernel+bounces-174470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A58C0F43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9AFB2298D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9847A14D28C;
	Thu,  9 May 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Su/48b"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013E14B95F;
	Thu,  9 May 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256447; cv=none; b=G/6mtGebQedJJfFh5icr5CpaZnIsRf27//ixr/e1RWyJ3BldXqrKtpXK2lSJ7opYqqUKAa47ZlZsQRqo7MnD9546PzoZ2FK0k3w6VP0o0kfBgWAwZwnqIUEt185sn8OwNS9kBOOs5IdcJOu2HZOYq2T53bTjoGHp1ca9k9qBCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256447; c=relaxed/simple;
	bh=BqoenIEv/wpSJyCUmOCXUdukroC8lH5RwOBjFfONYf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOEApOrPhZADfHUTpSP8qlWEwMywT8XRW9rcLNJ96zB6/OxgO18oHDOjMG8W0rQXYZ8ImACvMhu9/+Q0ATmn57sPIO/v+7fBZsjckVWc/FmnWVSFgls2JovIxiRR1zqlKuO2G9LrOp1l+ky9FJCsJmj0DmxDpebYrTMEabR1b8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8Su/48b; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so9926451fa.0;
        Thu, 09 May 2024 05:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256444; x=1715861244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAJ0ir3EvsiOixSkrLpbfd6IrLvM1qhtQ0lJENdLIss=;
        b=O8Su/48bKDyub0wKhtxHshv2yqw9+OdnBzxEgHVvEH0IHVaZHwSeNPxM2WOrwNiFCc
         fYRKgWtlopdiNcbpaAWP1lXU4lKzauJh7HE0/5V+ngWvnWD4VSiOxesakCdXEt31+vsX
         NMwyCR+Mvf5sRT9CYZU+h3c0zV3V5eSpbLG9r5Q4JBLEhFxwILV0sI3b63OEhq8Q/TLQ
         CnDWKlRXLDp6VpA2t0n428KQGywMbX5GwIqsahtLNxSluFPZjzA2DZT9fQdV3ltHjB12
         g+UWZoMvWkFUugTiw1jgqVudWiiiUOYf40mzPvArXXfIqW+ZF4HwqJCl1cjG8V4QJS/b
         nLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256444; x=1715861244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAJ0ir3EvsiOixSkrLpbfd6IrLvM1qhtQ0lJENdLIss=;
        b=HXu60p6ZfeZ+yfg/LUGNIkOmzyD7qXv0Q2SX8PsGnpppm7qiDyD3VTlaplEt8oTC+I
         W9NjFCd59jpuK7E/ShWKg8PLYWTgEDBLqYKzA6HAA0O5Hxf3olZ+RsuihMAs5gLzUMrz
         hTNEDpN5wfXnvpXmIOOJifKd/znkNsHPKfL7XXIRNYZB+pUtEkDZNqyMZJFbBRGGlsE3
         svAIUkynf4uyUekYWdGQ8n2pOme7t8RYR0I6R8P8QQm/ww2i8q/XtfSsNTpeekySkXVG
         D/Vv/o+VS3QACCpVl2VR+26LDFmnvpjD6FQLQRl4wjzvWbAgCkdxVY2JEKjmt/m+yfdA
         wyEw==
X-Forwarded-Encrypted: i=1; AJvYcCUrGdOcZRPZeUVN0nAxNinn/ReV+TkO7BuCLVwYZRrToK71gjCqliZPofJn1iAfQ3XyHmWVVt/5NdZ/0aqjsFZcmlJp8rs6UOe1h38vDR5dtpEAT/a80lRF/rtoQGOSy/oCPf8tdfiAt1J+DX6seBijeF8hIYX5jILxpkRWoosXk2ZYoA==
X-Gm-Message-State: AOJu0Yy1te7gmLyrpUiuw2yIs3VWvMhTnX9sleOm/O43cQv8rcw8vryE
	cyHUH3fPMYSITaiKA1sUVd0Ml3TTvjED26bV/+gZ/hwPbVsmJK4=
X-Google-Smtp-Source: AGHT+IFUYRwayrG45zhDJt6ESVgR9RDCoOYAoZNv9N+U2t+cQ8R6nC8DmHzJhqkPB1HbzzA7y03QZQ==
X-Received: by 2002:a2e:9005:0:b0:2df:dae1:b2c0 with SMTP id 38308e7fff4ca-2e4473a9373mr34950901fa.13.1715256444099;
        Thu, 09 May 2024 05:07:24 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm24112005e9.11.2024.05.09.05.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:07:23 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 3/7] clk: rockchip: rk3128: Export PCLK_MIPIPHY
Date: Thu,  9 May 2024 14:07:11 +0200
Message-ID: <20240509120715.86694-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509120715.86694-1-knaerzche@gmail.com>
References: <20240509120715.86694-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the D-DHY's APB clock for usage in the DT. Also drop the
CLK_IGNORE_UNUSED-flag, as the clock will be enabled on demand.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - reword commit message

 drivers/clk/rockchip/clk-rk3128.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 75071e0cd321..a20d1fd25e2a 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -526,7 +526,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(PCLK_ACODEC, "pclk_acodec", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS),
 	GATE(0, "pclk_ddrupctl", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 7, GFLAGS),
 	GATE(0, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 4, GFLAGS),
-	GATE(0, "pclk_mipiphy", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 0, GFLAGS),
+	GATE(PCLK_MIPIPHY, "pclk_mipiphy", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 0, GFLAGS),
 
 	GATE(0, "pclk_pmu", "pclk_pmu_pre", 0, RK2928_CLKGATE_CON(9), 2, GFLAGS),
 	GATE(0, "pclk_pmu_niu", "pclk_pmu_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 3, GFLAGS),
-- 
2.43.2


