Return-Path: <linux-kernel+bounces-519787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A136A3A1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6597A43CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482F26E165;
	Tue, 18 Feb 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdAWlPlO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352726E159
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894380; cv=none; b=WfKyfccW4SZWgTZdtY00ik2PXdp2JaZWetDJTNmH6e3PEbxL+j7z2w30RRytmXETN9kZwejVpZHdq4zW7xUmdBVMzY9+wbp58xbRYHRsp620L/ha+al4H85VDuyax2MN/uJneFQ8jgSSLXl5EXQMt2TxgsIVMshqU+zwLqD9Pso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894380; c=relaxed/simple;
	bh=abZZ89F53lA1OV0ELTX+9LFdB3L3bVnVCnIAbwmMOCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dUUZ0nRywl7WayJm9Kx5nJj+HKwgAo6LtjpZgcwCH3mP4s3w60KbqPQlHipM2M7yljm9sv0OiG6AZ6v7Y0bg0frsNJaui7242YNm7avGw5ZOXYukAvooYRM3zeJabm6KKt9szorxl0ZijXYG/nhPQl0C+gyxQylMgs8X2Xhti70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LdAWlPlO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4396d2e32b7so25550655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739894376; x=1740499176; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLiPp+tksGtaJoVcenFPvqvMvCo7VgKfvGquZJ1SEOo=;
        b=LdAWlPlOCoOO6bUPNU2qFHhcpUyDnyNvK03/fzAleSsSTE4SG0+s1v1dLSsnlzX1kz
         adOhhO22P3qmVO6FFLrYw92G9xuRigwNOnziApCaZonre8WtctUb0s8b0miD5GBf9C8o
         dMkXIppqcbAX5N6uUfdKlNc4Nuwe/HIZsy0pRGCtHLu7K9zEgk2RCegHppsyWkKj9g/Q
         ysLQntaNIbjHVDqnrGQlHnjC4SmjVXuAkP0NAoy4lJDefAB/db0WI1tPyujwSVoV7dCz
         AaYTG1ZPrIwoJvFhhE/qbudy2NDABNXryT/iZZkKiK4baw63U9N5z2MmE4QKyeIjEA0G
         RTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894376; x=1740499176;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLiPp+tksGtaJoVcenFPvqvMvCo7VgKfvGquZJ1SEOo=;
        b=NALmjKzHtfcbx5jitd3/EG8mIEaaUuNHnVePBHCZiUt74u0/KEVRF1s9BQHOtCGeAN
         B/FisF1bLAIvooatSMH3QBQTjYxvceQzAiA4mNuR2FVMyEERqGelnvlbTpxPkfzNmf5y
         n1eA6wpl6vpdH9lLpY9fxl+wirmmXz+OI3v2VnwX0dB8fg9ck2yzPzNzGaoxTvQ8M7Cb
         lKN15PqOWelPiFIzSVng8nT3vFtyBTcleB9O9ox2mwkbgjzn/ZwwO8f3oFm5C3Dd2Wv4
         oHIhWhKg65KmGxGghVUQBc0gs5gJSE1jN9OBMIDMYY2o0btYUXe8AOdbJO833aWzwnWJ
         x9vw==
X-Forwarded-Encrypted: i=1; AJvYcCVtFcPMQFX1y1Y/Dqx7csrPP4tuqqQh5Co77LjP/9N1Qvu2qDALz5AwMEiEM1wYxRf9yLJQFrQE39r/UHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLT/8KyVg8ChVFlUMrMaMCct+U6PmOaM8JX/Gps1aR7efoEy3P
	EmZvB2f34Ux5sRDHF2yDHhpUGOAoqb7/n3tuWe/vasd64X9sPXRvpDSh9WDkx7k=
X-Gm-Gg: ASbGncvfvAiWu9GYaCwDyQglnBx7nAes36GjixSkYoRcHL4FNgHLnC+Qv1XGoclQYYJ
	XwQ0QUmTHLghRL+y6Kg2x6+VWdwtIrDPazgflSMXwrJNcE5ZXOu7cmiMi+9Iz2kukakf/3FsiH5
	bFejTaEUrZS7JOHDojT0/m0JXEbkzszSXK3lqEWyaOi/E9t+R/pMwgx6BJPkM1IIfvGY58n8RE4
	QY6dgh8q0iXtrfyF906XY/bxO4ex4+blHcDHEUScKAqPKGUmgREO0uMyrRBfPsdF6+xnPHvwbYK
	GoBYvbdML5OU66WRTczSpsRbs5qvkA==
X-Google-Smtp-Source: AGHT+IFFPfR802qDKzGf8EpcaA/0PrAJS+U9zhmkfvPjSsbnNFMbY1JWC1vsFmrEkwOr49Qwmkd7iQ==
X-Received: by 2002:a05:600c:5110:b0:439:5ea4:c1e8 with SMTP id 5b1f17b1804b1-4396e762833mr119637905e9.26.1739894376111;
        Tue, 18 Feb 2025 07:59:36 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:7bb2:512b:ca43:946a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc7ecsm15174942f8f.49.2025.02.18.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 07:59:35 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 18 Feb 2025 16:59:18 +0100
Subject: [PATCH v2] irqchip/qcom-pdc: Workaround hardware register bug on
 X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-x1e80100-pdc-hw-wa-v2-1-29be4c98e355@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFWutGcC/22NQQqDMBBFryKz7pRMVBq78h7FRYyjDhQjSVGLe
 PemQnddvgf//R0iB+EI92yHwItE8VMCfcnAjXYaGKVLDFrpUmki3IiNIqVw7hyOK64W21tuuqr
 ivigrSMM5cC/bGX00iUeJLx/e58dCX/vL5f9yCyFhb5wujC2Ma239lMkGf/VhgOY4jg/DIw6gt
 QAAAA==
X-Change-ID: 20250211-x1e80100-pdc-hw-wa-b738d99ef459
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Maulik Shah <quic_mkshah@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.2

On X1E80100, there is a hardware bug in the register logic of the
IRQ_ENABLE_BANK register: While read accesses work on the normal address,
all write accesses must be made to a shifted address. Without a workaround
for this, the wrong interrupt gets enabled in the PDC and it is impossible
to wakeup from deep suspend (CX collapse). This has not caused problems so
far, because the deep suspend state was not enabled. We need a workaround
now since work is ongoing to fix this.

The PDC has multiple "DRV" regions, each one has a size of 0x10000 and
provides the same set of registers for a particular client in the system.
Linux is one the clients and uses DRV region 2 on X1E. Each "bank" inside
the DRV region consists of 32 interrupt pins that can be enabled using the
IRQ_ENABLE_BANK register:

  IRQ_ENABLE_BANK[bank] = base + IRQ_ENABLE_BANK + bank * sizeof(u32)

On X1E, this works as intended for read access. However, write access to
most banks is shifted by 2:

  IRQ_ENABLE_BANK_X1E[0] = IRQ_ENABLE_BANK[-2]
  IRQ_ENABLE_BANK_X1E[1] = IRQ_ENABLE_BANK[-1]
  IRQ_ENABLE_BANK_X1E[2] = IRQ_ENABLE_BANK[0] = IRQ_ENABLE_BANK[2 - 2]
  IRQ_ENABLE_BANK_X1E[3] = IRQ_ENABLE_BANK[1] = IRQ_ENABLE_BANK[3 - 2]
  IRQ_ENABLE_BANK_X1E[4] = IRQ_ENABLE_BANK[2] = IRQ_ENABLE_BANK[4 - 2]
  IRQ_ENABLE_BANK_X1E[5] = IRQ_ENABLE_BANK[5] (this one works as intended)

The negative indexes underflow to banks of the previous DRV/client region:

  IRQ_ENABLE_BANK_X1E[drv 2][bank 0] = IRQ_ENABLE_BANK[drv 2][bank -2]
                                     = IRQ_ENABLE_BANK[drv 1][bank 5-2]
                                     = IRQ_ENABLE_BANK[drv 1][bank 3]
                                     = IRQ_ENABLE_BANK[drv 1][bank 0 + 3]
  IRQ_ENABLE_BANK_X1E[drv 2][bank 1] = IRQ_ENABLE_BANK[drv 2][bank -1]
                                     = IRQ_ENABLE_BANK[drv 1][bank 5-1]
                                     = IRQ_ENABLE_BANK[drv 1][bank 4]
                                     = IRQ_ENABLE_BANK[drv 1][bank 1 + 3]

Introduce a workaround for the bug by matching the qcom,x1e80100-pdc
compatible and apply the offsets as shown above:

 - Bank 0...1: previous DRV region, bank += 3
 - Bank 1...4: our DRV region, bank -= 2
 - Bank 5: our DRV region, no fixup required

The PDC node in the device tree only describes the DRV region for our
particular client. We also need to map parts of the previous DRV region to
issue writes there. To maintain compatibility with old device trees, obtain
the base address of the region by applying the -0x10000 offset. Note that
this is also more correct from a conceptual point of view: We don't really
make use of the other region; we just issue shifted writes that end up in
the registers of our own region.

Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Changes in v2:
- Clarify why memory is mapped outside the region defined in the device
  tree (Dmitry, tglx)
- Rename _pdc_reg_write() -> pdc_base_reg_write() (tglx)
- Clarify what "DRV" stands for (tglx): The PDC has multiple "DRV"
  regions, each of them provides the same set of registers for a particular
  client. Linux is using only one of them, but we need to issue writes to
  the previous region to workaround the hardware bug.
- Use "switch (bank) { case 0 ... 1: ... }" style instead of if statement
  for more clarity (tglx)
- Extend commit message for more clarity (tglx)
- Link to v1: https://lore.kernel.org/r/20250213-x1e80100-pdc-hw-wa-v1-1-f8c248a48cba@linaro.org
---
 drivers/irqchip/qcom-pdc.c | 67 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 74b2f124116e3415d77269959c1ed5e7d7efd671..52d77546aacb9526a8856c9338965bd4ee7e63b7 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -21,9 +21,11 @@
 #include <linux/types.h>
 
 #define PDC_MAX_GPIO_IRQS	256
+#define PDC_DRV_OFFSET		0x10000
 
 /* Valid only on HW version < 3.2 */
 #define IRQ_ENABLE_BANK		0x10
+#define IRQ_ENABLE_BANK_MAX	(IRQ_ENABLE_BANK + BITS_TO_BYTES(PDC_MAX_GPIO_IRQS))
 #define IRQ_i_CFG		0x110
 
 /* Valid only on HW version >= 3.2 */
@@ -46,13 +48,20 @@ struct pdc_pin_region {
 
 static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
+static void __iomem *pdc_prev_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
 static unsigned int pdc_version;
+static bool pdc_x1e_quirk;
+
+static void pdc_base_reg_write(void __iomem *base, int reg, u32 i, u32 val)
+{
+	writel_relaxed(val, base + reg + i * sizeof(u32));
+}
 
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
-	writel_relaxed(val, pdc_base + reg + i * sizeof(u32));
+	pdc_base_reg_write(pdc_base, reg, i, val);
 }
 
 static u32 pdc_reg_read(int reg, u32 i)
@@ -60,6 +69,34 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
 
+static void pdc_x1e_irq_enable_write(u32 bank, u32 enable)
+{
+	void __iomem *base;
+
+	/* Remap the write access to work around a hardware bug on X1E */
+	switch (bank) {
+	case 0 ... 1:
+		/* Use previous DRV (client) region and shift to bank 3-4 */
+		base = pdc_prev_base;
+		bank += 3;
+		break;
+	case 2 ... 4:
+		/* Use our own region and shift to bank 0-2 */
+		base = pdc_base;
+		bank -= 2;
+		break;
+	case 5:
+		/* No fixup required for bank 5 */
+		base = pdc_base;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	pdc_base_reg_write(base, IRQ_ENABLE_BANK, bank, enable);
+}
+
 static void __pdc_enable_intr(int pin_out, bool on)
 {
 	unsigned long enable;
@@ -72,7 +109,11 @@ static void __pdc_enable_intr(int pin_out, bool on)
 
 		enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
 		__assign_bit(mask, &enable, on);
-		pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+
+		if (pdc_x1e_quirk)
+			pdc_x1e_irq_enable_write(index, enable);
+		else
+			pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
 	} else {
 		enable = pdc_reg_read(IRQ_i_CFG, pin_out);
 		__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
@@ -324,10 +365,29 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	if (res_size > resource_size(&res))
 		pr_warn("%pOF: invalid reg size, please fix DT\n", node);
 
+	/*
+	 * PDC has multiple DRV regions, each one provides the same set of
+	 * registers for a particular client in the system. Due to a hardware
+	 * bug on X1E, some writes to the IRQ_ENABLE_BANK register must be
+	 * issued inside the previous region. This region belongs to
+	 * a different client and is not described in the device tree. Map the
+	 * region with the expected offset to preserve support for old DTs.
+	 */
+	if (of_device_is_compatible(node, "qcom,x1e80100-pdc")) {
+		pdc_prev_base = ioremap(res.start - PDC_DRV_OFFSET, IRQ_ENABLE_BANK_MAX);
+		if (!pdc_prev_base) {
+			pr_err("%pOF: unable to map previous PDC DRV region\n", node);
+			return -ENXIO;
+		}
+
+		pdc_x1e_quirk = true;
+	}
+
 	pdc_base = ioremap(res.start, res_size);
 	if (!pdc_base) {
 		pr_err("%pOF: unable to map PDC registers\n", node);
-		return -ENXIO;
+		ret = -ENXIO;
+		goto fail;
 	}
 
 	pdc_version = pdc_reg_read(PDC_VERSION_REG, 0);
@@ -363,6 +423,7 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 fail:
 	kfree(pdc_region);
 	iounmap(pdc_base);
+	iounmap(pdc_prev_base);
 	return ret;
 }
 

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-x1e80100-pdc-hw-wa-b738d99ef459

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


