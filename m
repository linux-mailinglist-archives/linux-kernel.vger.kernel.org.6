Return-Path: <linux-kernel+bounces-228804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4D916731
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08BC1C20DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E897A1591E8;
	Tue, 25 Jun 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CLOglOsj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFE156C72
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317669; cv=none; b=BJM1P6KyktIMmFPjmaxg86ZEiw6UuFe/ohx0Dn3L78Rp932V47xUCXsIQ1gHu2Ehk7IkZqhyTp2ysWwJB9cnriljh/IO8HpoPbvwer3ouegPzu0WsbvML8jG8z8GqUr4/uVETM9sXq/CrAyHPsj/sEYJsM4R5AZgjraP6FvTbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317669; c=relaxed/simple;
	bh=aVioSRzJqXlczjHmYmBjJBu7oq6xmwTohrZmb+gYSbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CoXoKYJ6hn68Q+mFZDUIRiZ+/UPL8jca2qWQPAVKI1N+WIsJ/dhQkeptuP/mL4iTztae5pzWAiR9U1wxga2DqfJEjCMF1+D3tRf5qdJoKNYApery8ciK3ZX4woIdr17BmhNUcnsN4+WxrioInVX+fXn6U0t50QR6IQL711nNx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CLOglOsj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217990f997so40662725e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719317666; x=1719922466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3mhaGF+KU5yeMisjPIARpLxwyj1AMM2/2N+WRoELhI=;
        b=CLOglOsjSD93t2ALtumKBY822qS/ALq8kVsKTFR6+BgXCwDb7ucCy6wJwQRr/Prmus
         5wnjEdfI/0MdBNRhHyeDP2fMmf20XGXLH4eHVFPU34A42Lv1emuW2WwdzlnOh4EBhjUb
         2iP/zyev7mILSvTRaD1rF0H04o6k30C+6YFP2+Q29i1XRIv5okEP5brmKVnYo6vWpnDD
         VloHNlOmLc5RnKf4x2J7wAqwc4YcQf3bIATdXt+VJ9JXgA+YzFzYK1UaFBjbQa1v3534
         EAJL35whdUwQJp8EzFJEZtReX8Z7SKknUl54dhPwFIg1S/nIzEzHnaG4rhDAMtM3Etzm
         iXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719317666; x=1719922466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3mhaGF+KU5yeMisjPIARpLxwyj1AMM2/2N+WRoELhI=;
        b=ajnnbEBJq9lbT29/8kVy4IB6kCJysyD+7ZppNcry3qEFJUlTWqxqwUnpUfQSMyGU6Y
         8Xf3Tc8bU9ScDBuF8gr/rVxg0bSsoQhCrVO86QIWolhZxnlvnUEBiws/WPuYuUeFPwud
         ac/jedX56LOqe52XBjvxr+VRgj3OqO1VfEUbKSRMsLo3L39AkVZPUee2CyzOn3f7Q28w
         g1dnpa/kzTbJGARGbZ2n1U8sN0+7ptx2AaomTE2A/BEerwFE1Kv+EGeWdpWDGO2GRl0o
         Cybc6ZYDt+fMz+CuPyNpSR/Rq/1MLVdpzRemPo3WKNDwfTxaTRarwnLpDwUbxg3GY5YS
         h+fw==
X-Forwarded-Encrypted: i=1; AJvYcCV91sE1Z1i5ngVfQBkcXjjqzXeIUs9SaxNUL8wOISaz4b8J5gu9WYe2j/Y6aQxFiVrwV6LM9+l/T/N7gxqIbJJtPAv5CfSDPYdwNmGH
X-Gm-Message-State: AOJu0YyPm6bkP59CScAUJmypR+OR4YZxsMRyXNwTY6mYkQ/3wc67ZjNc
	ZaQey4gHNFeWOwHjE+cqNMR7KbzaLzX0gqWYVWWJ43sQA9N4kquqSgScduCNu24=
X-Google-Smtp-Source: AGHT+IFK5iuAO1YBTxjhIGSX7Q8KoOhjQXwLGyqLocsV4KY5Z057M7ZH3/y+fDPFPY63w1kZ1xsu8Q==
X-Received: by 2002:a05:600c:4b1f:b0:424:a5d8:ac83 with SMTP id 5b1f17b1804b1-424a5d8acafmr6070375e9.41.1719317665539;
        Tue, 25 Jun 2024 05:14:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8b32sm12798437f8f.92.2024.06.25.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:14:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 03/12] i2c: riic: Call pm_runtime_get_sync() when need to access registers
Date: Tue, 25 Jun 2024 15:13:49 +0300
Message-Id: <20240625121358.590547-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There is no need to runtime resume the device as long as the IP registers
are not accessed. Calling pm_runtime_get_sync() at the register access
time leads to a simpler error path.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/i2c/busses/i2c-riic.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index c08c988f50c7..83e4d5e14ab6 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -301,19 +301,15 @@ static const struct i2c_algorithm riic_algo = {
 
 static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 {
-	int ret = 0;
 	unsigned long rate;
 	int total_ticks, cks, brl, brh;
 	struct device *dev = riic->adapter.dev.parent;
 
-	pm_runtime_get_sync(dev);
-
 	if (t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) {
 		dev_err(dev,
 			"unsupported bus speed (%dHz). %d max\n",
 			t->bus_freq_hz, I2C_MAX_FAST_MODE_FREQ);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	rate = clk_get_rate(riic->clk);
@@ -351,8 +347,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	if (brl > (0x1F + 3)) {
 		dev_err(dev, "invalid speed (%lu). Too slow.\n",
 			(unsigned long)t->bus_freq_hz);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	brh = total_ticks - brl;
@@ -384,6 +379,8 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 		 t->scl_fall_ns / (1000000000 / rate),
 		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
 
+	pm_runtime_get_sync(dev);
+
 	/* Changing the order of accessing IICRST and ICE may break things! */
 	riic_writeb(riic, ICCR1_IICRST | ICCR1_SOWP, RIIC_ICCR1);
 	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
@@ -397,9 +394,8 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
-out:
 	pm_runtime_put(dev);
-	return ret;
+	return 0;
 }
 
 static struct riic_irq_desc riic_irqs[] = {
-- 
2.39.2


