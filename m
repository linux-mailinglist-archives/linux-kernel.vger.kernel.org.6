Return-Path: <linux-kernel+bounces-552355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C800FA578F6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263E11893964
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFE91A264A;
	Sat,  8 Mar 2025 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNl233nG"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A912E7E;
	Sat,  8 Mar 2025 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420248; cv=none; b=N8XHsDvkzew2Ufh5z6y0guDI6HK5ndUG44lbn7X8YMpRqaTg1XHMYGZLQcNJ0AAV6igEjDJefZ2yfqu3Dlfb4KQGpDpiSDZ1sxlkEU81cKvO/6+f33pRzBhQdl6QLPpzHgEG0ndH00e+iz1STTWsS8FDqDPtIam0ZrCoidOs4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420248; c=relaxed/simple;
	bh=8JHmyZ7xLSoRXw3dONXnXLQVoPD98R1ElG49T2mRM6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1vlBCKITZseLCOukv5IYC1mDa0hI/cL4jOfDzA9fWC/9TDxu0Tgc7beyb4IdENh7RKA04J98cWevF9t/OMptNdEGGUrlkn8qwJy2e4EMZAOa37oSK0UDPW1YToHHYl1tqVDmG6DKKmXxQVSj7whw8vQ33aESi+QCeQMCqr0CxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNl233nG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf64aa2a80so496550866b.0;
        Fri, 07 Mar 2025 23:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420245; x=1742025045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZQaSbYCSebH14qiUYwdfO7+aqeDnkJtqvZn46cM4Ew=;
        b=CNl233nGPgWcHID15jB4yxRZmppbA9/SVO74QapkMZ1iD0Rxpez13Tr3A7N1KMsnyJ
         bhZ14tUrMPs1Vxf/8liC8FGzPhMZmp9249a/A7zPyLMtbvQ++64qiX6ii8PT57TmYyC7
         rNlDjt6VgCdm/72GYcbf3IZTFaTKvOwibdsumuGsBovG4aQYe8AwSiTrpeka03hCcCbp
         FWTO5tuC1tcaGG0xE2es5G7RVs8yvgK9D3z8IR/YjwMkM7OTpt8Q5aq8SfquHBIcWz45
         8HsMt8MLOWIOzBrVScudQUUu4KmZylRjgnbh51xXsek5KIO1yPd0BU42ttBlBbqQ9H7k
         UeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420245; x=1742025045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZQaSbYCSebH14qiUYwdfO7+aqeDnkJtqvZn46cM4Ew=;
        b=dokvzsM2bJC/cU1qGgZvOzN9P9jld00m2ob/50N7cD4tDC4k7NVNlDTx5yMvUclqL6
         Oya5qgsg+BEqm5lWrBQb+tmG5rt/P29+uONaEI0CtqJfvmqMa7lV57U2K7Zi8yuS306Y
         cTT9nA6ae8Qi+Q/BYj3Gcr2JuiWN1za1LcpERJRl2/lHszCWv04Ik9oh/hVHjBPFk5sR
         ahFSpafyR/5UZhWN2UR2TbFCLdbEe+PT4bJV3x00NUtQxzAjB/WTqv+DwyourCzDDy3g
         4PHVgwiNjde4b3ZkJbAbcybPZ9PYQJj/OoYgX7bGgtLg9dXmS0NHyTQNKRmMrY2yrz8g
         s7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU+6ngYDMF87bNocIK6a14SlumfhQ78sAJjhCdfYeHKgP5v+fbmhdfWJu6o1NukXvSxRlRqJZFuVr7U@vger.kernel.org, AJvYcCW4A7qrDloGKLa9mid+5lDHlwLsfVH0ZLPxqsx7fDk82PbbnOAQ43wD7LwgqgsJW/gfEsSlEBxAq/WC@vger.kernel.org, AJvYcCXb5ht/IvcQrCPr3Ek6M01zoO+cy7Db1T5QUXf13YNLHTuRbrv3LXtvtcUu9TwVGFq59wFgsjy9N37D6dvm@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9r5mNQVwgEgyq9qDsvQQtdfsner8nKhojPNibcOLslrZJLtn
	wQmwsEeE/xVnWuu3mBYqofW03RAfhHTpCfZOBFMc9L/1I7CsswPt
X-Gm-Gg: ASbGncsdo4x+jEGENNKfiye83jdTA6jILWTpZBkaqBbPWMoCON05Gx3wDt7MnOZqO+c
	1Qo1phRjJGtzHcEceguLkwA9nMkHQRdhznPmjM4G5x3OOQI4W6Wc8JpwpigeP9bC1BBeoJM+aI6
	Pxj+PiylLBSwjkhW10pEyESA/PYpS+S0mlqRb3+UUaBRjsBU8kxqYGMK4gNWCSmRWUMFdbygSB3
	SI0qPNxPXk990YTg0OXniOmWGw6Z+QYIJc7ZLj/V+60THSGFOpVqUOeO3LojYljOfLvmbVBScQW
	8pXWKGxg9wsxahCPJMCnMLic+eIwYPvqtUI2yn/lHsKrqJvyN2pQyve5F7QKEizISBzuEGz8WUv
	+AdeitNGyMBWtnR4EPA==
X-Google-Smtp-Source: AGHT+IGLX0ep1216UiTHOGA0j980m/o5SkZyXZt49EZKs0/aflQqxDPZTwjc+dzADLuk6Whuh9q8jw==
X-Received: by 2002:a17:907:8314:b0:abf:6424:79eb with SMTP id a640c23a62f3a-ac252aaece7mr544339066b.20.1741420244894;
        Fri, 07 Mar 2025 23:50:44 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:44 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:39 +0100
Subject: [PATCH v3 1/9] clk: bcm: kona: Move CLOCK_COUNT defines into the
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-1-d6fb5bfc3b67@gmail.com>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
In-Reply-To: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=3541;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=8JHmyZ7xLSoRXw3dONXnXLQVoPD98R1ElG49T2mRM6E=;
 b=pVKFj//KQZzmknNbHNnxr+nmeB4my1RioX6bh3mVlBnOTAcOVN9Kt8Wlwj+9SYsJdISnsFjk8
 uZE7MpkFZtSBO2FWyT3f1eLUhqNrndqpUKO+uGt2Jzr3lLRF9TMsaaw
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

CLOCK_COUNT defines for each CCU are stored in the DT binding header.
This is not correct - they are not used by device trees, only internally
by the driver.

Move the CLOCK_COUNT defines directly into the driver in preparation
for dropping them from the DT binding include.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/clk/bcm/clk-bcm21664.c |  8 ++++++++
 drivers/clk/bcm/clk-bcm281xx.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
index 520c3aeb4ea9c4a431512c0909f9545c1761d17a..fa6e1649d6f5f459b63026109caea9e2f72e22dd 100644
--- a/drivers/clk/bcm/clk-bcm21664.c
+++ b/drivers/clk/bcm/clk-bcm21664.c
@@ -17,6 +17,8 @@ static struct peri_clk_data frac_1m_data = {
 	.clocks		= CLOCKS("ref_crystal"),
 };
 
+#define BCM21664_ROOT_CCU_CLOCK_COUNT	(BCM21664_ROOT_CCU_FRAC_1M + 1)
+
 static struct ccu_data root_ccu_data = {
 	BCM21664_CCU_COMMON(root, ROOT),
 	/* no policy control */
@@ -39,6 +41,8 @@ static struct peri_clk_data hub_timer_data = {
 	.trig		= TRIGGER(0x0a40, 4),
 };
 
+#define BCM21664_AON_CCU_CLOCK_COUNT	(BCM21664_AON_CCU_HUB_TIMER + 1)
+
 static struct ccu_data aon_ccu_data = {
 	BCM21664_CCU_COMMON(aon, AON),
 	.policy		= {
@@ -122,6 +126,8 @@ static struct peri_clk_data sdio4_sleep_data = {
 	.gate		= HW_SW_GATE(0x0360, 18, 2, 3),
 };
 
+#define BCM21664_MASTER_CCU_CLOCK_COUNT	(BCM21664_MASTER_CCU_SDIO4_SLEEP + 1)
+
 static struct ccu_data master_ccu_data = {
 	BCM21664_CCU_COMMON(master, MASTER),
 	.policy		= {
@@ -225,6 +231,8 @@ static struct peri_clk_data bsc4_data = {
 	.trig		= TRIGGER(0x0afc, 19),
 };
 
+#define BCM21664_SLAVE_CCU_CLOCK_COUNT	(BCM21664_SLAVE_CCU_BSC4 + 1)
+
 static struct ccu_data slave_ccu_data = {
 	BCM21664_CCU_COMMON(slave, SLAVE),
        .policy		= {
diff --git a/drivers/clk/bcm/clk-bcm281xx.c b/drivers/clk/bcm/clk-bcm281xx.c
index 823d5dfa31b84f502fcd6ada1eff6d8f4673b3dd..7589ad9db99767485d73e91ed8db4d2842cd6e32 100644
--- a/drivers/clk/bcm/clk-bcm281xx.c
+++ b/drivers/clk/bcm/clk-bcm281xx.c
@@ -19,6 +19,8 @@ static struct peri_clk_data frac_1m_data = {
 	.clocks		= CLOCKS("ref_crystal"),
 };
 
+#define BCM281XX_ROOT_CCU_CLOCK_COUNT	(BCM281XX_ROOT_CCU_FRAC_1M + 1)
+
 static struct ccu_data root_ccu_data = {
 	BCM281XX_CCU_COMMON(root, ROOT),
 	.kona_clks	= {
@@ -57,6 +59,8 @@ static struct peri_clk_data pmu_bsc_var_data = {
 	.trig		= TRIGGER(0x0a40, 2),
 };
 
+#define BCM281XX_AON_CCU_CLOCK_COUNT	(BCM281XX_AON_CCU_PMU_BSC_VAR + 1)
+
 static struct ccu_data aon_ccu_data = {
 	BCM281XX_CCU_COMMON(aon, AON),
 	.kona_clks	= {
@@ -80,6 +84,8 @@ static struct peri_clk_data tmon_1m_data = {
 	.trig		= TRIGGER(0x0e84, 1),
 };
 
+#define BCM281XX_HUB_CCU_CLOCK_COUNT	(BCM281XX_HUB_CCU_TMON_1M + 1)
+
 static struct ccu_data hub_ccu_data = {
 	BCM281XX_CCU_COMMON(hub, HUB),
 	.kona_clks	= {
@@ -172,6 +178,8 @@ static struct peri_clk_data hsic2_12m_data = {
 	.trig		= TRIGGER(0x0afc, 5),
 };
 
+#define BCM281XX_MASTER_CCU_CLOCK_COUNT	(BCM281XX_MASTER_CCU_HSIC2_12M + 1)
+
 static struct ccu_data master_ccu_data = {
 	BCM281XX_CCU_COMMON(master, MASTER),
 	.kona_clks	= {
@@ -301,6 +309,8 @@ static struct peri_clk_data pwm_data = {
 	.trig		= TRIGGER(0x0afc, 15),
 };
 
+#define BCM281XX_SLAVE_CCU_CLOCK_COUNT	(BCM281XX_SLAVE_CCU_PWM + 1)
+
 static struct ccu_data slave_ccu_data = {
 	BCM281XX_CCU_COMMON(slave, SLAVE),
 	.kona_clks	= {

-- 
2.48.1


