Return-Path: <linux-kernel+bounces-521132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4077A3B4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBCC1757E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E796A1E98FC;
	Wed, 19 Feb 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+BW7t7E"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1501E7C02;
	Wed, 19 Feb 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954272; cv=none; b=Y8buWC4WNBxw/ZzmATzV3I805eeBT2P+41lqYzTJJYyU+UNN2Xk6ZCIzpmhag6xyW/C5ANr0YsOckEgggQp3FzDX1Ut8QqyHBmBw3SSA+UC+08DX7mNdWrn+tFeOlwGe8+rlFuFLvSP/GANYiQ96OfxPkaRTBD0EInWJb/AAoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954272; c=relaxed/simple;
	bh=xaNOYtAfaZ8sqMZkx6ZBUdSQbYHa9kY7n6k69uEADFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvAfaNGrRSsJytLW7/4804CZHxkzha5QdtB5qUo53OHmeLkVhcq6qOBnuy0j2S9zRfjx7Fm2TwalMdTZwz1+//BggeLRqi7i9iET5frIQAN8vSQDQ1b5ZXseMqeICEJKqx8jKNGI/rFucqdyidOoj4iWee/96mY1oGu8MFWyAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+BW7t7E; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5439e331cceso7385214e87.1;
        Wed, 19 Feb 2025 00:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739954264; x=1740559064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r5FLjAb16UHJNl8Z75yMUTemMbWvcdj0VcymlcBf9g=;
        b=L+BW7t7EcQq99kccJ1pM8opcMWo8ZAd2iRKnbWojUW5xpOY4h0t6WUhA6jWlnzc9FH
         yf5iEuOqZoi2z5jwi4LoCW+laqIsbhuGsiqrZLIAYR0y2IuIDDs5Ke4/xA3afuQuaR0l
         cPxMXS7cYopJNEu4yRVnAuBQRp9MrPC45JhfJJCpAvKN9caRySNkWUAH7vKc2pEF0Eqz
         Wa3buqDwEIYO8rhJAyLLD60Cx5iMh5DEZ+URJYxuVu8fsEXyJBKuV425U7/tKiMwpw/F
         TKWrvGS0vfnOqyTvCHVkzdzw7VDUOWxXlceH7QKo87ccoYYZ96OjoVwhwnu34KJwCxkZ
         jANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954264; x=1740559064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r5FLjAb16UHJNl8Z75yMUTemMbWvcdj0VcymlcBf9g=;
        b=ebP70s8A58x2P0kX600bnxw4sRRXTU58Qz1CkthakNgKMKJen2CXscli3AwIlfADZ5
         fVEh29CyYrRkJc/6M+HJVIFOzCADBvtYAQnnppER9DA19UEfEpvucS7hykX+FqRtrl2l
         CKX2vMzIfqrRCTuaHkK793/AYdAmG/fimq+j0T04UBGl/sBA3JP+BdXUAgce8/QHv/T0
         Uf83FdCqbr32fggMYZna4fDrUih63xhueAI2tQqW0rij6+M5CKzNQR+iaOwGrLypiPcj
         OXtWNFQujela7cSOiz35f0knlxHeaYBaTpnInWXtzZKFK/Ua3OnSTguVio5vATrS5p+p
         DlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtIcqnohtSensnFudHjPo6bUxoZBeFDEPQP7OloZtorUdw1sG/i8f20VEV9Q+0JYT6g9xkZROCAmpX@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhQCZSD8VRA/hvas2aZGgEYYOhwtFB7WTn/hDlorlyXLY/SA2
	gByiUFB0VmUUvrRDVVjNoTFdfdzL2AuE4ZrXDFyPFjYq+SePon6K
X-Gm-Gg: ASbGncs2YhKTltUofY1zJEejEQd2Okhzt2TgljCz72+AAOi1Xi5mWHI1tZJ74rnPvol
	vCt/6QZR0c8DUNrXmjkJ8rAErEhLcA2C42EY1ck6wFGc01FzVJMCt2ZuUV+JFwlqB8O5p8YjLX6
	E+Caa/b2/HGMvZOR4Fg5hMS35k0xg7nEwvTeDVX6oTxop9TWoRqJd+AGTCvaHohLXF7v8QFtS7m
	FXtoaGDZTsXpKpiI0JqH6dr7snrucJ77SKLJTLHtmJ5rPCWNRgHiwPCnGamsldGP9jkwHYlK8N7
	DJPMXE8=
X-Google-Smtp-Source: AGHT+IGAUuw9ueH+TNazHTnysxrUBKjPLds2rgaJMOC7Zb9N0PQWptpduYpnX8zIQFopSUxkBjNSvQ==
X-Received: by 2002:a05:6512:3e1f:b0:542:6d01:f55c with SMTP id 2adb3069b0e04-5462eed8607mr1057677e87.3.1739954263866;
        Wed, 19 Feb 2025 00:37:43 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452d8e54f7sm1692319e87.9.2025.02.19.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:37:42 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] extcon: Add basic support for Maxim MAX14526 MUIC
Date: Wed, 19 Feb 2025 10:37:24 +0200
Message-ID: <20250219083724.56945-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219083724.56945-1-clamor95@gmail.com>
References: <20250219083724.56945-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX14526 is designed to simplify interface requirements on
portable devices by multiplexing common inputs (USB, UART,
Microphone, Stereo Audio and Composite Video) on a single
micro/mini USB connector. The USB input supports Hi-Speed USB
and the audio/video inputs feature negative rail signal
operation allowing simple DC coupled accessories. These device
allow a single micro/mini USB port to support all the common
interfaces on Cellular phones and portable media players over
the same external lines.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/extcon/Kconfig           |  12 ++
 drivers/extcon/Makefile          |   1 +
 drivers/extcon/extcon-max14526.c | 308 +++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/extcon/extcon-max14526.c

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index a6f6d467aacf..1096afc0b5bb 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -134,6 +134,18 @@ config EXTCON_MAX8997
 	  Maxim MAX8997 PMIC. The MAX8997 MUIC is a USB port accessory
 	  detector and switch.
 
+config EXTCON_MAX14526
+	tristate "Maxim MAX14526 EXTCON Support"
+	select IRQ_DOMAIN
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Maxim MAX14526
+	  MUIC device. The MAX14526 MUIC is a USB port accessory
+	  detector and switch. The MAX14526 is designed to simplify
+	  interface requirements on portable devices by multiplexing
+	  common inputs (USB, UART, Microphone, Stereo Audio and
+	  Composite Video) on a single micro/mini USB connector.
+
 config EXTCON_PALMAS
 	tristate "Palmas USB EXTCON support"
 	depends on MFD_PALMAS
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 0d6d23faf748..6482f2bfd661 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_EXTCON_MAX3355)	+= extcon-max3355.o
 obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
 obj-$(CONFIG_EXTCON_MAX77843)	+= extcon-max77843.o
 obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
+obj-$(CONFIG_EXTCON_MAX14526)	+= extcon-max14526.o
 obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
 obj-$(CONFIG_EXTCON_PTN5150)	+= extcon-ptn5150.o
 obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
diff --git a/drivers/extcon/extcon-max14526.c b/drivers/extcon/extcon-max14526.c
new file mode 100644
index 000000000000..5a406eb5994a
--- /dev/null
+++ b/drivers/extcon/extcon-max14526.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MAX14526 extcon driver to support MUIC
+ */
+
+#include <linux/device.h>
+#include <linux/devm-helpers.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/extcon-provider.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
+/* I2C addresses of MUIC internal registers */
+#define	MAX14526_DEVICE_ID	0x00
+#define MAX14526_ID		0x02
+
+/* CONTROL_1 register masks */
+#define	MAX14526_CONTROL_1	0x01
+#define	ID_2P2			BIT(6)
+#define	ID_620			BIT(5)
+#define	ID_200			BIT(4)
+#define	VLDO			BIT(3)
+#define	SEMREN			BIT(2)
+#define	ADC_EN			BIT(1)
+#define	CP_EN			BIT(0)
+
+/* CONTROL_2 register masks */
+#define	MAX14526_CONTROL_2	0x02
+#define	INTPOL			BIT(7)
+#define	INT_EN			BIT(6)
+#define	MIC_LP			BIT(5)
+#define	CP_AUD			BIT(4)
+#define	CHG_TYPE		BIT(1)
+#define	USB_DET_DIS		BIT(0)
+
+/* SW_CONTROL register masks */
+#define	MAX14526_SW_CONTROL	0x03
+#define SW_DATA			0x00
+#define SW_UART			0x01
+#define SW_AUDIO		0x02
+#define SW_OPEN			0x07
+
+/* INT_STATUS register masks */
+#define	MAX14526_INT_STAT	0x04
+#define	CHGDET			BIT(7)
+#define	MR_COMP			BIT(6)
+#define	SENDEND			BIT(5)
+#define	V_VBUS			BIT(4)
+
+/* STATUS register masks */
+#define	MAX14526_STATUS		0x05
+#define	DCPORT			BIT(7)
+#define	CHPORT			BIT(6)
+#define C1COMP			BIT(0)
+
+enum max14526_idno_resistance {
+	MAX14526_GND,
+	MAX14526_24KOHM,
+	MAX14526_56KOHM,
+	MAX14526_100KOHM,
+	MAX14526_130KOHM,
+	MAX14526_180KOHM,
+	MAX14526_240KOHM,
+	MAX14526_330KOHM,
+	MAX14526_430KOHM,
+	MAX14526_620KOHM,
+	MAX14526_910KOHM,
+	MAX14526_OPEN
+};
+
+enum max14526_field_idx {
+	VENDOR_ID, CHIP_REV,		/* DEVID */
+	DM, DP,				/* SW_CONTROL */
+	MAX14526_N_REGMAP_FIELDS
+};
+
+static const struct reg_field max14526_reg_field[MAX14526_N_REGMAP_FIELDS] = {
+	[VENDOR_ID] = REG_FIELD(MAX14526_DEVICE_ID,  4, 7),
+	[CHIP_REV]  = REG_FIELD(MAX14526_DEVICE_ID,  0, 3),
+	[DM]        = REG_FIELD(MAX14526_SW_CONTROL, 0, 2),
+	[DP]        = REG_FIELD(MAX14526_SW_CONTROL, 3, 5),
+};
+
+struct max14526_data {
+	struct i2c_client *client;
+	struct extcon_dev *edev;
+
+	struct regmap *regmap;
+	struct regmap_field *rfield[MAX14526_N_REGMAP_FIELDS];
+
+	struct gpio_desc *usif_gpio;
+	struct gpio_desc *dp2t_gpio;
+
+	int last_state;
+	int cable;
+};
+
+enum max14526_muic_modes {
+	MAX14526_OTG     = MAX14526_GND, /* no power */
+	MAX14526_MHL     = MAX14526_56KOHM, /* no power */
+	MAX14526_OTG_Y   = MAX14526_GND | V_VBUS,
+	MAX14526_MHL_CHG = MAX14526_GND | V_VBUS | CHGDET,
+	MAX14526_NONE    = MAX14526_OPEN,
+	MAX14526_USB     = MAX14526_OPEN | V_VBUS,
+	MAX14526_CHG     = MAX14526_OPEN | V_VBUS | CHGDET,
+};
+
+static const unsigned int max14526_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_CHG_USB_FAST,
+	EXTCON_DISP_MHL,
+	EXTCON_NONE,
+};
+
+static int max14526_ap_usb_mode(struct max14526_data *priv)
+{
+	struct device *dev = &priv->client->dev;
+	int ret;
+
+	/* Enable USB Path */
+	ret = regmap_field_write(priv->rfield[DM], SW_DATA);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(priv->rfield[DP], SW_DATA);
+	if (ret)
+		return ret;
+
+	/* Enable 200K, Charger Pump and ADC */
+	ret = regmap_write(priv->regmap, MAX14526_CONTROL_1,
+			   ID_200 | ADC_EN | CP_EN);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "AP USB mode set\n");
+
+	return 0;
+}
+
+static irqreturn_t max14526_interrupt(int irq, void *dev_id)
+{
+	struct max14526_data *priv = dev_id;
+	struct device *dev = &priv->client->dev;
+	int state, ret;
+
+	/*
+	 * Upon an MUIC IRQ (MUIC_INT_N falls), wait at least 70ms
+	 * before reading INT_STAT and STATUS. After the reads,
+	 * MUIC_INT_N returns to high (but the INT_STAT and STATUS
+	 * contents will be held).
+	 */
+	msleep(100);
+
+	ret = regmap_read(priv->regmap, MAX14526_INT_STAT, &state);
+	if (ret)
+		dev_err(dev, "failed to read MUIC state %d\n", ret);
+
+	if (state == priv->last_state)
+		return IRQ_HANDLED;
+
+	/* Detach previous device */
+	extcon_set_state_sync(priv->edev, priv->cable, false);
+
+	switch (state) {
+	case MAX14526_USB:
+		priv->cable = EXTCON_USB;
+		break;
+
+	case MAX14526_CHG:
+		priv->cable = EXTCON_CHG_USB_FAST;
+		break;
+
+	case MAX14526_OTG:
+	case MAX14526_OTG_Y:
+		priv->cable = EXTCON_USB_HOST;
+		break;
+
+	case MAX14526_MHL:
+	case MAX14526_MHL_CHG:
+		priv->cable = EXTCON_DISP_MHL;
+		break;
+
+	case MAX14526_NONE:
+	default:
+		priv->cable = EXTCON_NONE;
+		break;
+	}
+
+	extcon_set_state_sync(priv->edev, priv->cable, true);
+
+	priv->last_state = state;
+
+	return IRQ_HANDLED;
+}
+
+static const struct regmap_config max14526_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX14526_STATUS,
+};
+
+static int max14526_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct max14526_data *priv;
+	int ret, dev_id, rev, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client = client;
+	i2c_set_clientdata(client, priv);
+
+	priv->regmap = devm_regmap_init_i2c(client, &max14526_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap), "cannot allocate regmap\n");
+
+	for (i = 0; i < MAX14526_N_REGMAP_FIELDS; i++) {
+		priv->rfield[i] = devm_regmap_field_alloc(dev, priv->regmap,
+							  max14526_reg_field[i]);
+		if (IS_ERR(priv->rfield[i]))
+			return dev_err_probe(dev, PTR_ERR(priv->rfield[i]),
+					     "cannot allocate regmap field\n");
+	}
+
+	/* Detect if MUIC version is supported */
+	ret = regmap_field_read(priv->rfield[VENDOR_ID], &dev_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read MUIC ID\n");
+
+	regmap_field_read(priv->rfield[CHIP_REV], &rev);
+
+	if (dev_id == MAX14526_ID)
+		dev_info(dev, "detected MAX14526 MUIC with id 0x%x, rev 0x%x\n", dev_id, rev);
+	else
+		dev_err_probe(dev, -EINVAL, "MUIC vendor id 0x%X is not recognized\n", dev_id);
+
+	priv->edev = devm_extcon_dev_allocate(dev, max14526_extcon_cable);
+	if (IS_ERR(priv->edev))
+		return dev_err_probe(dev, (IS_ERR(priv->edev)),
+				     "failed to allocate extcon device\n");
+
+	ret = devm_extcon_dev_register(dev, priv->edev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to register extcon device\n");
+
+	ret = max14526_ap_usb_mode(priv);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to set AP USB mode\n");
+
+	regmap_write_bits(priv->regmap, MAX14526_CONTROL_2, INT_EN, INT_EN);
+	regmap_write_bits(priv->regmap, MAX14526_CONTROL_2, USB_DET_DIS, ~USB_DET_DIS);
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, &max14526_interrupt,
+					IRQF_ONESHOT | IRQF_SHARED, client->name, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register IRQ\n");
+
+	irq_wake_thread(client->irq, priv);
+
+	return 0;
+}
+
+static int max14526_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max14526_data *priv = i2c_get_clientdata(client);
+
+	irq_wake_thread(client->irq, priv);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(max14526_pm_ops, NULL, max14526_resume);
+
+static const struct of_device_id max14526_match[] = {
+	{ .compatible = "maxim,max14526-muic" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, max14526_match);
+
+static const struct i2c_device_id max14526_id[] = {
+	{ "max14526_muic" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max14526_id);
+
+static struct i2c_driver max14526_driver = {
+	.driver = {
+		.name = "max14526-muic",
+		.of_match_table = max14526_match,
+		.pm = &max14526_pm_ops,
+	},
+	.probe = max14526_probe,
+	.id_table = max14526_id,
+};
+module_i2c_driver(max14526_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("MAX14526 extcon driver to support MUIC");
+MODULE_LICENSE("GPL");
-- 
2.43.0


