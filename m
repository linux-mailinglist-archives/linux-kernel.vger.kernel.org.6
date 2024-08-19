Return-Path: <linux-kernel+bounces-291875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE4895686A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C2F284830
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864F516B3AC;
	Mon, 19 Aug 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DBD1lDGr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC016A924
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063061; cv=none; b=u6lCMhUpc/0J8uouWakNW8e3cHjyJrF2FBWU3zF7OMQFCPukFXqmikqThxgJtRUcIhbrgSw/tZWhRMP4YZEA7XcOymZFHJlDZMOapZdjifLubn2aMJg5GOlKxo9fRIOhBzfho7g+zxkFFBVK1KTEd7ZvIzVE3A4Sy/2Yq7/A2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063061; c=relaxed/simple;
	bh=V0WHm+wUYe9Rdj6YrY7kFO9HEfXjRsLtMAky45YpYmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaGpOji1e3JNPJn6sxfHWtxb5o3ohZ3pHb2dqm4GGKZXsZ88jFED3G9I8i0Uf6qFSsFyLJbDj0R64jEvblkpTBbGxH1a3Ttl6Ta9/DCFrpnoD1Bo3cQuEHKd/OSvZoMM4993xDF//Uiyns7somboRSbTcOqpomRdr+wlKHoOzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DBD1lDGr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso33704355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724063058; x=1724667858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqAYvOS2QZLlt1R3iub4gvJ7Cr031qiF/TF+Io59nUA=;
        b=DBD1lDGr5oeC0cjAw4LBX3y61RhOdRZ6StugZzZF0pomOVpOtIiiRiFoUbeClmMPwz
         53kJETRNjTp1WX3y533n4ISfBDfnDG8u3y0Tx54PFDSdhuPJBZ47IE/L3nz0RSRvqm4H
         FqlauixidEQFEvX8sxQbvwzpiMKvmLVXvqQZLAGER/80cyUItBZIUPHdu1XT3ebLN96u
         swFO7Pt/maBIUmmf6YNPQrPi1QWU7mDqPpXQytcoIRT8k5XZPG6Fv70gnGqD25wdo7KZ
         FatHh+CZU5OZUddiDWmpzYYYKQFWlC3ipo+ZEIrsOdmJ5rFZoLFHGmro0ZRSGC/eBWH1
         cTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063058; x=1724667858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqAYvOS2QZLlt1R3iub4gvJ7Cr031qiF/TF+Io59nUA=;
        b=Xb72D/zq2PqqAyWEFLkQYC30YHK6y3hbE9n8YoSpo9IYZUxPpHcesb1hSRtVHok7p1
         XyBxl1lTwcz8Uik/vMdyLT7/7md8NKMXXGOiI2Mkr3SbCC3kgTe5FdGV18asi4ty4X+8
         LONvSe2UXi2uvxjOreAvK3SLbw0U5Ua0h9cLZX243xWLgQ/QcBTGk69i2Sl6/4xJg3W4
         dHndkDgbvCI+qd0gPjmcplIZjsyyotef4rNmYikxkGHopew2UsfVtp6lGo8jUYL9T7Em
         8emUZJoaPM/+ThATZXCK5xH0Vre2L8BiqLb2P5uj5hZnzg/OUPDnyUQnSn1QmrPAv958
         C+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXKalkGrFSmVQKxTs4gwmpcVipGAhH/cr4cjwcw/yTNFoBmLW+MmmYXNnaE7f0+PYJvHGwidTGBfuC1ONo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pejF1E1nphW5r9pn+71v7ldjn9sWMvO3cvH5xUJKscZuLBpd
	bUHSR3bgPUSYfGAo0NsU5OPVpFvrffzaijLpa39ySt2KpTqTbl5HPTvqejhYznI=
X-Google-Smtp-Source: AGHT+IEWaqzLill+71yYLxp+nEgFpqJ6jegA2r+E03Dnc7KQEM5L98ByqSriP1uPB2imTZ6UXYNBTA==
X-Received: by 2002:a05:600c:4f49:b0:429:e637:959e with SMTP id 5b1f17b1804b1-429ed7ba950mr76166265e9.10.1724063058098;
        Mon, 19 Aug 2024 03:24:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650402sm106690275e9.11.2024.08.19.03.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:24:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 08/11] i2c: riic: Add support for fast mode plus
Date: Mon, 19 Aug 2024 13:23:45 +0300
Message-Id: <20240819102348.1592171-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240819102348.1592171-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240819102348.1592171-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Fast mode plus is available on most of the IP variants that RIIC driver
is working with. The exception is (according to HW manuals of the SoCs
where this IP is available) the Renesas RZ/A1H. For this, patch
introduces the struct riic_of_data::fast_mode_plus.

Fast mode plus was tested on RZ/G3S, RZ/G2{L,UL,LC}, RZ/Five by
instantiating the RIIC frequency to 1MHz and issuing i2c reads on the
fast mode plus capable devices (and the i2c clock frequency was checked on
RZ/G3S).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- in riic_init_hw() checked t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ
  before applying hardware settings

Changes in v3:
- enabled FM+ for all riic_rz_a_info based platforms except RZ/A1H
  as requested in review comments; with this, dropped the riic_rz_g2_info
  and RZ/G2 specific compatibles in riic_i2c_dt_ids[];

  Note that it has been tested only on platforms mentioned in commit
  description (as I don't have all the other RZ/A platforms).

Changes in v2:
- dropped code that handles the renesas,riic-no-fast-mode-plus
- updated commit description

 drivers/i2c/busses/i2c-riic.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index cc2452853d19..32b8bd4888dd 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -63,6 +63,8 @@
 #define ICMR3_ACKWP	0x10
 #define ICMR3_ACKBT	0x08
 
+#define ICFER_FMPE	0x80
+
 #define ICIER_TIE	0x80
 #define ICIER_TEIE	0x40
 #define ICIER_RIE	0x20
@@ -80,6 +82,7 @@ enum riic_reg_list {
 	RIIC_ICCR2,
 	RIIC_ICMR1,
 	RIIC_ICMR3,
+	RIIC_ICFER,
 	RIIC_ICSER,
 	RIIC_ICIER,
 	RIIC_ICSR2,
@@ -92,6 +95,7 @@ enum riic_reg_list {
 
 struct riic_of_data {
 	const u8 *regs;
+	bool fast_mode_plus;
 };
 
 struct riic_dev {
@@ -311,11 +315,14 @@ static int riic_init_hw(struct riic_dev *riic)
 	int total_ticks, cks, brl, brh;
 	struct i2c_timings *t = &riic->i2c_t;
 	struct device *dev = riic->adapter.dev.parent;
+	const struct riic_of_data *info = riic->info;
 
-	if (t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) {
+	if ((!info->fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) ||
+	    (info->fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_PLUS_FREQ)) {
 		dev_err(&riic->adapter.dev,
-			"unsupported bus speed (%dHz). %d max\n",
-			t->bus_freq_hz, I2C_MAX_FAST_MODE_FREQ);
+			"unsupported bus speed (%dHz). %d max\n", t->bus_freq_hz,
+			info->fast_mode_plus ? I2C_MAX_FAST_MODE_PLUS_FREQ :
+			I2C_MAX_FAST_MODE_FREQ);
 		return -EINVAL;
 	}
 
@@ -401,6 +408,9 @@ static int riic_init_hw(struct riic_dev *riic)
 	riic_writeb(riic, 0, RIIC_ICSER);
 	riic_writeb(riic, ICMR3_ACKWP | ICMR3_RDRFS, RIIC_ICMR3);
 
+	if (info->fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ)
+		riic_clear_set_bit(riic, 0, ICFER_FMPE, RIIC_ICFER);
+
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
 	pm_runtime_mark_last_busy(dev);
@@ -527,6 +537,7 @@ static const u8 riic_rz_a_regs[RIIC_REG_END] = {
 	[RIIC_ICCR2] = 0x04,
 	[RIIC_ICMR1] = 0x08,
 	[RIIC_ICMR3] = 0x10,
+	[RIIC_ICFER] = 0x14,
 	[RIIC_ICSER] = 0x18,
 	[RIIC_ICIER] = 0x1c,
 	[RIIC_ICSR2] = 0x24,
@@ -538,6 +549,11 @@ static const u8 riic_rz_a_regs[RIIC_REG_END] = {
 
 static const struct riic_of_data riic_rz_a_info = {
 	.regs = riic_rz_a_regs,
+	.fast_mode_plus = true,
+};
+
+static const struct riic_of_data riic_rz_a1h_info = {
+	.regs = riic_rz_a_regs,
 };
 
 static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
@@ -545,6 +561,7 @@ static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
 	[RIIC_ICCR2] = 0x01,
 	[RIIC_ICMR1] = 0x02,
 	[RIIC_ICMR3] = 0x04,
+	[RIIC_ICFER] = 0x05,
 	[RIIC_ICSER] = 0x06,
 	[RIIC_ICIER] = 0x07,
 	[RIIC_ICSR2] = 0x09,
@@ -556,6 +573,7 @@ static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
 
 static const struct riic_of_data riic_rz_v2h_info = {
 	.regs = riic_rz_v2h_regs,
+	.fast_mode_plus = true,
 };
 
 static int riic_i2c_suspend(struct device *dev)
@@ -604,6 +622,7 @@ static const struct dev_pm_ops riic_i2c_pm_ops = {
 
 static const struct of_device_id riic_i2c_dt_ids[] = {
 	{ .compatible = "renesas,riic-rz", .data = &riic_rz_a_info },
+	{ .compatible = "renesas,riic-r7s72100", .data =  &riic_rz_a1h_info, },
 	{ .compatible = "renesas,riic-r9a09g057", .data = &riic_rz_v2h_info },
 	{ /* Sentinel */ },
 };
-- 
2.39.2


