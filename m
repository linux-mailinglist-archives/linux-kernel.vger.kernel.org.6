Return-Path: <linux-kernel+bounces-308825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F26966245
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657471C23479
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDA11AF4F7;
	Fri, 30 Aug 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="C5c25xOG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE71AD5E8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022960; cv=none; b=JIPcGZ9GIQtFW5Vq98wn7r6WVysCnz5BWFCDL+NKStqRFFSVMDeYHPdWrixnIsVTxw7QzYfwMTr/c39aJvOYU1fIYUabjicbUjJnGuZ11W9zlNOwjxVXme2jQmG+cXQrQwSGxAhzLzqHmwT6wkPUMjFR4s8wtXTudhPFXEE8Uyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022960; c=relaxed/simple;
	bh=0NDjqlI4uZwZiIKOebtOX/P36Pfw3hvCzMBzvuazjxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AA3ZqKdtqaTdDSNTxPwROku2AJitBvIonHL9Sodx739ruIfBbmBl4fyUG/aFO/FXEjav9O29IfxNhtJ21Nkd+txr3Xz2AL48jfoISCfFd5sCFikUj371eUUxgR4OWe1AIjkxKxgECwFiZUNc1ZTtW1ku12iT3qbhuUk3kIz5/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=C5c25xOG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533488ffaebso2166116e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725022957; x=1725627757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxknm/UXmtXHlPwjDVhWt1Uw2fradJB++SjLkjTrWtM=;
        b=C5c25xOGTO3E5HYmrGRcDsPdscuZXyeD8MNA/2tcDfcbddbCOGbY0wKENUm4dF/8LK
         yjVwFGvPQ+j0ifJosJmrXisITzRJWl0hJvFNrImZ6rQQEfzIYphkC3mxOVODHr55vbd9
         BYGt63Bao84JCuZvsiupWo70TxnEsUAJrH5wSMb00YHcPQXxTJNsLUbylZE148hYYW5L
         vU5SWhcTdFZd3ug0WeE/HGKBkek22kMQ2DzgfJLXOpUnlPId+2mTjF0jVDMQDstObI5D
         0VPhn9oD18zshrjIomR3B7pOExWNqoC3y8G/QBAdZnyxq1JdEzcHXMc0t4hMmCNoCJuh
         iPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022957; x=1725627757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxknm/UXmtXHlPwjDVhWt1Uw2fradJB++SjLkjTrWtM=;
        b=ifNm7lvK4RR8n2oyrv8Aleyz+Hu1MtpnXrXjXde50e4y8pwmgJs3jmv8vkGq08DO9b
         UqOSY6pyWEbUFrbNs+qqE27U76VP/XtMx89F0Ton2+hK+L9QkgMZzNKsNtrLg8AcnE7d
         cXCt0Hjrx9gomu6kogIaiorH65Y9u0CnejiRmCiXbDIp0JzpSWTkrVno6W6aXnbX6aBq
         tKXoxP9l0apBUOyRy+6r3MoCf21Nu/0yZcLVQWk5Yaysg9fDUDLqgcfGK+SN+bAYxmOx
         70I+1q4aDBxzlMEuwk2yHkNA1miDhWnROcbTopPY9BXjD9QjeyHQeC+PnviMcP8hdDOW
         ECBg==
X-Forwarded-Encrypted: i=1; AJvYcCVIObuV2zUK39M44pjv6akdr8WYupH8GKy4yHSWi7L3lby13mmuxrUbeIylq5QfLRAeovJak26LzEc6szQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJ7IcdpyAyxVQDSwafkO8KwJecfe5PX/lbgKsAo/9sk+IB95c
	xBSHToUCxI2fnylXoprw0akb3nG0EEx2w9fSbO0ca/AQr7bKm2CVixoa0uSzPBY=
X-Google-Smtp-Source: AGHT+IHczdRB06BuoSLQgq8hhYH1CNuoRnBx5DM0ialnn7WYz/l0nKY+9xvSzheB55rdSChNyE4hiQ==
X-Received: by 2002:a05:6512:1328:b0:52e:7656:a0f4 with SMTP id 2adb3069b0e04-53546b93f39mr1386545e87.41.1725022956336;
        Fri, 30 Aug 2024 06:02:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba642594dsm80361785e9.47.2024.08.30.06.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:02:35 -0700 (PDT)
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
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 03/12] clk: linux/clk-provider.h: Add devm_clk_hw_register_gate_parent_hw()
Date: Fri, 30 Aug 2024 16:02:09 +0300
Message-Id: <20240830130218.3377060-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830130218.3377060-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240830130218.3377060-1-claudiu.beznea.uj@bp.renesas.com>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none; this patch is new

 include/linux/clk-provider.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4a537260f655..824b62059364 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -608,6 +608,24 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
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


