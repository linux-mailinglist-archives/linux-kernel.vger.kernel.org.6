Return-Path: <linux-kernel+bounces-174569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC858C10E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA41C227A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28A115EFB6;
	Thu,  9 May 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIuDMcQi"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73315E803;
	Thu,  9 May 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263624; cv=none; b=r9VT9ukb1qz/W8ki0bUeabZ9TTgP3WIPI+YeS930IP3OH5K6rcjl11CNesIsASKDaTCnABwRRcA/DDFzxoYA+kSt7Cz+OV109XOMUIZonSrzS9n4TuBZU0aQEfhR0Cki3SVf7yFJxxS4w/vmIBYzBGO3WDnfHSeJPKrV5JBHPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263624; c=relaxed/simple;
	bh=BqoenIEv/wpSJyCUmOCXUdukroC8lH5RwOBjFfONYf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9UeR6OH6A6fz/dtsOWjX4k4OUDld6OiteOUcFO+ntvIueqr6KD2Wq8GB2sKLRIytneDcBdgoKIFnsOjVG5pOTnZEq0beIdfEj26F21dtKrALGV6CpqW8ksEOP/YuboIkK9BDuQJHEyqaNfiElf40JGY1PxWLwxYniuxED00ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIuDMcQi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34fde285fa2so664141f8f.1;
        Thu, 09 May 2024 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263621; x=1715868421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAJ0ir3EvsiOixSkrLpbfd6IrLvM1qhtQ0lJENdLIss=;
        b=FIuDMcQiLdc0k+rk/Ol1cJJ4tqh0ElEq/6d82INgBqS6YkIcRhrYL5uI52lKsDuvS6
         el99TtKG0RhEA/3DbB56QfgUhuJPYIVt46MA4+i2TRwsjccSaURpCnHgchQgK03Ms2FY
         KXoMwi77J3B4zCpTpjR1ubatF9AaBL5TRBjSreI9VNAiIHiKsvMBbi0qPo0UVRkh4eMJ
         HgNAPc6xjYh8e3ID5JpXSmlbco/2ZmA31KRIW4mRV5mdeebaQNuUJxLMOCsJ5hC00qn4
         iwGAVRZVfRpgQ8gGoFFB5Se2vw/WqGfQpep4iIkrjTeRdQCq4E9CjMVaV24uvGhWZhDi
         VxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263621; x=1715868421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAJ0ir3EvsiOixSkrLpbfd6IrLvM1qhtQ0lJENdLIss=;
        b=wzdMwrSpq+2TjsfuzPmEf04Adhdrr1vCe+4Wv4dFDsKibtVrpe8XjP2oHlQj+fiIEh
         KmIXa2RQluJpJn6mluFokXdM2jk5uft7AfdEYQi65n1+Vj3eE1h/BRr+cYZSEWuSBlf2
         x2prjKCSy2A0owciEMYUz/RZ7JrkGLhl9JoLWFDamAKe/niUv+jybgNKql5Wc150g218
         0BGk6SuZOrTdGnuimQRzH65nDtLON83MhQhqwR9DEXU3T8W4/WouT1I1am3qzUhzgpyT
         1Nrn2mGkTYrRZZWc6/OvGBpdcQR1UYGE5RlcopAPQYDev0/CEo5BT04b/CVpTW90BonU
         9k8A==
X-Forwarded-Encrypted: i=1; AJvYcCWPNtL04AXSCUrHy5fnFJkYsRtiaQCKbeuW3sV2nrUVGIN64JcKRt1htV/VvoXt0ZjIrbXvVUzNebOtbNcoxgjM57r5el0ixzVF2/FwhinqNtpdVKBvn/QNmjloN7+2lgiAi18AfvcUQ+O7YUZEGTg/GYXE+6J3GSuTSrQEBpcHjudVZw==
X-Gm-Message-State: AOJu0YzOHyzhuT7po0qAfqB2oXaY6yKEfNyupovuW8VM4hNLL/GWXsda
	A4XzSlTYp4nxABUG2NpMgSneH/C7Ktwkd8Ymdgwr5s0drVrH4l4=
X-Google-Smtp-Source: AGHT+IGDm2zqiPzTsp+rCVEziHjhfj96YGRsnuCAnq5URS0U33f4RSu428fC/l+DFwekkggv2NMBOw==
X-Received: by 2002:adf:fa07:0:b0:34d:b4db:9927 with SMTP id ffacd0b85a97d-34fca6214femr4085933f8f.50.1715263620665;
        Thu, 09 May 2024 07:07:00 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1793311f8f.66.2024.05.09.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:06:59 -0700 (PDT)
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
Subject: [PATCH v3 3/7] clk: rockchip: rk3128: Export PCLK_MIPIPHY
Date: Thu,  9 May 2024 16:06:49 +0200
Message-ID: <20240509140653.168591-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509140653.168591-1-knaerzche@gmail.com>
References: <20240509140653.168591-1-knaerzche@gmail.com>
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


