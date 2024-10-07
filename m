Return-Path: <linux-kernel+bounces-352939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CF899265F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA391C2217D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F318C33C;
	Mon,  7 Oct 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nq6xIRkz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PbDB2P0i"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F718C03F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287406; cv=none; b=L2T3+5ourBU7SLMsEUmQaDjoEGvgJvZlrufFzqQ7DijZ1rsq992AORzUelliPqJ3YdndQpKM07/Y2W8UX0dU4QgOAR77AQOOzz76BUptBgYc/MDY+QLnfYR4P5McMaLbQMBUOV8FZBWQMRcGazGYEqvzn+Ao9hqjW13UAq4jTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287406; c=relaxed/simple;
	bh=jxkavo/tM+rYCI+t0fbmVZXkphZMNzEIWwdjBYEI5ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3cED82A5IKcJnT9P6xKJkfXRRnkyQSgoKbruXFrIei9b/ECzRv67ggfYRsvovVGF6SDidaK/dsSRflqFw3kYD3aryBeK/fZu5dMraGf+nvxvqBHdTL/8hW1oI2t0fPUr65GBxgs/zvnXL+JSf7MbYXeHZV0aes9DE44TFP6Oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nq6xIRkz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PbDB2P0i reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1728287404; x=1759823404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JHI/TzT2XeV1xxP38MEeTQKqc+rV2tkJJ3sIpKxqutY=;
  b=nq6xIRkzIqiYaZ0oG3nCOnWukGLDRR6Q6Tw3WybSuAqdDYUmQ6moxOA/
   KiTtukHT0RmNsRc+yTbYoqDI6OQjLVRKP4eG7XGxLg//1z06IkJ3Tm/zd
   NqcsHaNlw30U6BdTaQdba8QGo9pgBwYHEZ7nsbM3G0GpuVH1+bYD5JHNG
   +eTB+r0jlQgr8NgbBXAQ79S0lv9XX7xhVEaekqNdn9XZugGxHBAgloQDm
   0Ro7t91Uq/ywefrYod92lshbqhgItGZ8GjF2mXUuiw/Z52XF9Y5hMAIsT
   WZJKeHp+i3ZrBM9VlueigwliTACpP7BPrGZJe3iM6tfI4qh799C2NEyYl
   Q==;
X-CSE-ConnectionGUID: WusW+MpwS/Sju6ZJKRWpbA==
X-CSE-MsgGUID: zVTwcZhxS2yK6den+j9hzA==
X-IronPort-AV: E=Sophos;i="6.11,183,1725314400"; 
   d="scan'208";a="39297584"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Oct 2024 09:49:01 +0200
X-CheckPoint: {6703926D-1C-57F7EB54-E9270DBB}
X-MAIL-CPID: F573D7437B6156EFD848842CE7118E67_2
X-Control-Analysis: str=0001.0A682F1A.6703926C.0089,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15CC916BD56;
	Mon,  7 Oct 2024 09:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1728287337;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JHI/TzT2XeV1xxP38MEeTQKqc+rV2tkJJ3sIpKxqutY=;
	b=PbDB2P0ijDZ8YaQVX+zVyIsXLMe4r2QBVnOhEz6r8wLD8+YxIx8NoAbiJTmRpCjSTXI/ZT
	nEGs45S0EN43U9N9BeRNezZs/4lPeWuhupmPFWA1CshIL3/DV2H6J37JQUy5Lp/BvQDRtg
	RoreOYsVHKJTnO3/k936iO8dVBOiejRZlgS2wfJZcFgwdmb2dKJI2f7hUAi+NhLkAP7Mm0
	4Fj7GbKNipSZZ0YNy7EbEWcZ1V+UpTqD6y190OJwMz9dGv5GXi7nbgF72kDeEdc8dvuX79
	qq4bQhLndn6f0w5vJkMo+8fPi3KC+BP2cfd+pHkFa3/kM1VVqq23xjZb0KInMQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v4 5/5] mfd: tqmx86: add I2C IRQ support
Date: Mon,  7 Oct 2024 09:48:08 +0200
Message-ID: <e44098d2e496fda8220f9965f7a6021c1026eb18.1728286453.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Gregor Herburger <gregor.herburger@tq-group.com>

The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
Add module parameter to allow configuring the IRQ number, similar to the
handling of the GPIO IRQ.

Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: improve module parameter description (was patch 4/4)
v3: replace IRQ 0 resource with an empty placeholder to simplify error handling
v4: no changes

 drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index e444fcd2a3e9d..057d035b71d33 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -50,6 +50,7 @@
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
+#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
@@ -60,7 +61,16 @@ static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
-static const struct resource tqmx_i2c_soft_resources[] = {
+static uint i2c_irq;
+module_param(i2c_irq, uint, 0);
+MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)");
+
+static struct resource tqmx_i2c_soft_resources[] = {
+	/*
+	 * Placeholder for IRQ resource - must come first to be filled in by the
+	 * probe function.
+	 */
+	{},
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
 };
 
@@ -263,6 +273,14 @@ static int tqmx86_probe(struct platform_device *pdev)
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
 
 	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
+		if (i2c_irq) {
+			err = tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
+					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
+			if (!err)
+				/* Assumes the IRQ resource placeholder is first */
+				tqmx_i2c_soft_resources[0] = DEFINE_RES_IRQ(i2c_irq);
+		}
+
 		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					   tqmx86_i2c_soft_dev,
 					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


