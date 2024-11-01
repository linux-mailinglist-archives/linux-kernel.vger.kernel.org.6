Return-Path: <linux-kernel+bounces-391992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4E9B8E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399F71F239D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B818E34A;
	Fri,  1 Nov 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YrXWyvte"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2916130B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455065; cv=none; b=Xr/hkb2hbQjOPJJGDMIjGQEnmQwW4kTlZExJrEaSqveelGRIXCi1ui+XJmD5LtKi5NmLO9bHFzSRpgRFpkzNbDFcoAkXbruW7RL0zZN+P0hJCgMt6ESu0so8AiUUh6Q+nuvbk2LHjkjCNGFZjjn9iR5/drd8Anww02iCQRHwKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455065; c=relaxed/simple;
	bh=S+F2FkEdi2w5OLkb2FF8IDO/kgC5BfFXc48xK0PQxEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjqTBtDi8hNfyLFVNa9onyL3dq0psmg92bRsX5GQYBSzCU2y5oinriyPxwNOmOnF9ODvpPcY9jNLf7MgndRlmJogwbA4ZV+6McKKgRKETZK4VTt7OreHcy/wF1HZlf1/KYbAEErWSNOj02UwKk5VaiaVubWAuz1/4o9pkzSMknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YrXWyvte; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so2448996a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730455061; x=1731059861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewtg0K16I6vEI9VCro/VP2IXg7P8FX0BQ2vY0LS22pU=;
        b=YrXWyvtemX2WGnv5ubtRDUhTK7QTIqTHAEEtO37tJi3TGtO5qMEHccZZIU4b1rRixV
         5KMAy1JPN1GjnLBcAEam6x/+cNejTDUnRnO09cQ+9A+LmSzfFX5DYoYXnCHiS/t713ZU
         4s1mfJxgD/VtMt6DC88DOmF3HLSRnG7uvnHW3goK7tqKhfhQkBY8kL34Obu4iMFgHgQm
         Md3YxmL6GNYahpg7tlG83y/vP3vKFIxeKrRZF2kQ62l0qJdk9+6xscRMU8+R9DsgxqfF
         kQvnKTrzUP9Qu45hBJzBL31OQXGynjYBW9aQXwmicpExEbWPb4WMuf0A5DeG6KC4N6P4
         0wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730455061; x=1731059861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewtg0K16I6vEI9VCro/VP2IXg7P8FX0BQ2vY0LS22pU=;
        b=bWrx8Sku68gMJfNhy7XsiI2sWBth+szCSCGYZKeIHKZWPXG/JIgqRw+tvUPY36Ky6u
         9SAOPJjhZqbeb7B/YT+qT/x1xBa9n4KqjbXkjEXnU2xzRcX1k8nvBQBL+ipYvEkaPnPl
         icdB/3M3gyl7BLIHvaS7I5Ijg3FQKcjo+CHyR6sjeKNjEylzodL2FIvzxgQOa1q4MMvK
         iORxrbSccik6eIZjLx2u5SZ/SrmHSZ88Ha0iyH2ZR3pA4cxdo3bUur1yKOb3L/7CiObs
         5Ylm3BKtjQyTB4JwYtRiQmKIb3iNdoAdy1/ovBir5gX+sVLtTYly/blESeXu0ZWcM857
         6zRg==
X-Forwarded-Encrypted: i=1; AJvYcCUxaNG2bK8YAoMCNyREXU9sMWXB2tTrxvIEZ+6dROtrykryPQJSyoTcjmuQYMS7gj/rAwCjI9lncriSGPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNB/c75+ZbHEhr07jIuT9wyezhu+G990lavu619MQvAhKtLHHj
	L/FwdtJiwos8zyi84Kwo2kxXcs59Ha/mtkzkAJh3yHlYiEaTt9HsbsIkbug/GiY=
X-Google-Smtp-Source: AGHT+IEFGiN/u4W5r9i6MtaqopU2l9fL1FFrDwTz4s8iqC4tcmgZL2qm6/VdNeHlxydCj5OuRaUwEA==
X-Received: by 2002:a05:6402:350c:b0:5cb:69bb:ba8e with SMTP id 4fb4d7f45d1cf-5cbbfa78a8fmr13489266a12.34.1730455061093;
        Fri, 01 Nov 2024 02:57:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8d87sm1364136a12.76.2024.11.01.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:57:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 2/9] clk: linux/clk-provider.h: Add devm_clk_hw_register_gate_parent_hw()
Date: Fri,  1 Nov 2024 11:57:13 +0200
Message-Id: <20241101095720.2247815-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add devm_clk_hw_register_gate_parent_hw() macro to allow registering
devres managed gate clocks providing struct clk_hw object as parent.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- collected tags

Changes in v3:
- none; this patch is new


 include/linux/clk-provider.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 75444e250a78..a49859ef3304 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -622,6 +622,24 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL, \
 			       NULL, (flags), (reg), (bit_idx),		      \
 			       (clk_gate_flags), (lock))
+/**
+ * devm_clk_hw_register_gate_parent_hw - register a gate clock with the clock
+ * framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_gate_parent_hw(dev, name, parent_hw, flags,      \
+					    reg, bit_idx, clk_gate_flags,     \
+					    lock)			      \
+	__devm_clk_hw_register_gate((dev), NULL, (name), NULL, (parent_hw),   \
+				    NULL, (flags), (reg), (bit_idx),	      \
+				    (clk_gate_flags), (lock))
 /**
  * devm_clk_hw_register_gate_parent_data - register a gate clock with the
  * clock framework
-- 
2.39.2


