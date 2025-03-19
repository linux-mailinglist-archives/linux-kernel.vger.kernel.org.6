Return-Path: <linux-kernel+bounces-568455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83EDA695B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A6A188C106
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4794B1E5B8A;
	Wed, 19 Mar 2025 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZCQoycsg"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AD1DED54;
	Wed, 19 Mar 2025 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403787; cv=none; b=e80Kl3WWiqHeVGKCzfAQ+37WiWd0fz3Y6cE5ATElapAIcybM+tdUppbV5lm3u9dEF3FRcpitgaEIvjPF/F7OIX3fhvpo/72emPUrHrLcfbxWZ7G8sKcuf+sGJJv25Sl2oEpqFPYMRgli/2LxNPSWSDeBn2oPXvx68tY4gqdRVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403787; c=relaxed/simple;
	bh=MEnoHLGYwe4Rb7Ea354q75Q9fI7nlecT5f2HHmcVKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC3uvaiz9yVejLDwXwTnE52ue8KpzPydG/QarDtQCcAA429g8L5FaZuYwLEYcP3Z879+dVfmJDskzE+VwWRoVnGWDFDg9I0fsOzo7qOXfT49Zmdv6UW0ltroum/p801z6K7tUklNG2X8Ign7Gtb2M+Tas3OW5fiLPH5rzwMervo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZCQoycsg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbd96bef64so1237172766b.3;
        Wed, 19 Mar 2025 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742403783; x=1743008583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gmn/szojUb2XRCVxx2vq97+0SfCLkMAnLZfQjRsCyYQ=;
        b=ZCQoycsg869n5NnJE1hYMvGsvn5HUjlI/OlpeZdoTsCS8gRgAreSPzALdW6V31HdWw
         Ls/uy8wIC1NmWEPc9CV2B/tq9B2eaE8p6bUAmRzu3YT25/U97662tdDKTGg1o/rPZXt3
         qJWTrr8zBmiqJma0J1pKWGNR3ClgyL8fvRZ9Mx6dth9EhaSXj1Yw++7KpENo5aD2jler
         Qp1JDamQSmTy0PbK1qetIOSsg+6t4rDiexTIA4bHkCHWP7BrVkkdqSbxaUTP1Q1X8cN6
         8BS+a3+UY9sY/PTsYDw62zde+1EOmqTGlXPj0tXXNRHJI5T9kAjL2ThQiT04kXqyva6F
         sj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403783; x=1743008583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gmn/szojUb2XRCVxx2vq97+0SfCLkMAnLZfQjRsCyYQ=;
        b=bHYN1zs2eI7csEPuD5Qq3AX7s4j03pzQk1lb4MX34ElSbNSEskb/bt8t8XBdTXGMio
         SR0fouxsNteidqkWvuChv07Ioyls1IG9HuLandEsm05YiWv8HM4DlG9ybhJb+DzK46A3
         swgXoIsTNd455JarKHciX5kNwnm72sEV8B1soR9gcTeydW2r0wb8KYiBOhQQUTmH/2nY
         io0tcZtxk0jUX7JxaG5hxlvJuYTl0K2GiOHWCh6lX9+vYMDx1/iMj/HseitMlL+zIyaq
         kxhy6HZdLClEo5BFZTsBTwnuAmmw7tTdv+MDdl7HkNXAYLXdIZeM1v8VBadgLbkw4kHl
         2FOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdVEooa0t1zF+ss3r7wGFkl1qzdbxiSv/2vkzSl4+5IKbc6sEy4yOB+9nKdKybh8m96AnoUnw+L3g5@vger.kernel.org, AJvYcCVuoR5l5TTr1Jo76HbPnujVuj/k70bOTf1oddCYda2ois9qAOkwSi3ip1yCLwxFhgYjO9/JS8cn8ZPS@vger.kernel.org, AJvYcCWAQpzALK34yQUSQ3LVj1pvFmhzTCWWYF5P0X+5xqSNVNOvqs0u25rgYjb5jQU85tt1wtkcL51nFMzy569q@vger.kernel.org, AJvYcCWPixqIdlRtO+5EqKgw6Po8yjx0L6IT8k92Aw4eePw8t+pV2FZkKRtWarlbiPK4rC2HkpSec6UXt0uWh+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gXlSXVHLseiHCDUbDEw97f1JdeQ0JuhA54O9NfPs4RYAf1ft
	e+aeeICM8KhF59fWk0W/BuAvX2jzFtYAIZgOAoHTwRDrJ2Rs4iNX
X-Gm-Gg: ASbGncs5cvEBYTapartweg+iVl4/YN6GP+5lftdYBSiMaOjW2j9J6HDZ1clY7Oh9hf6
	82Bv06gPAdOIy3W+bz1dIkk3KuiP+dE+5MfUJ3XqjNBQPG5nu4Tlmx+5I6XDuBKD8jkfbgk26zi
	GOUdYtH1nqhaVoPZBOMOd8dgLM0XPAuZNTs6rmeP6ARB9gnunGYl0u2Yrdzezr2zzUPrjkSzoRW
	LvANNvkfkSsQFCJXYzNUOEKSyCsl2fdOQFwQY+xIBfDl207Z4ybrsAlJ2Xo5VWf6VnlhmEhJ3ns
	eWK/1Wd/5x1Q6YWLd8KitGXW8i/2bDwga4s3uIQn0mu5oQYknJxgMaQ5k9pf
X-Google-Smtp-Source: AGHT+IGgFizY22IaRrCil9h8iYvAugq35x9ZEW6VddwafBRI+NvOmQHOghy+3ClPj7V7k7nbchGYug==
X-Received: by 2002:a17:907:9408:b0:abf:7940:dba2 with SMTP id a640c23a62f3a-ac3b7ddf8f8mr384598066b.30.1742403778215;
        Wed, 19 Mar 2025 10:02:58 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.67.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3143653a7sm1034235866b.0.2025.03.19.10.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:02:57 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@googlemail.com>
X-Google-Original-From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: 
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] hwmon: Add support for TI TPS389008
Date: Wed, 19 Mar 2025 19:02:28 +0200
Message-ID: <20250319170234.63723-2-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319170234.63723-1-flaviu.nistor@gmail.com>
References: <20250319170234.63723-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TI TPS38900x are voltage monitor IC's.

All device variants offer an I2C interface and depending on the
part number, x monitor inputs.

Support chips by the driver are TPS389008, TPS389006 and TPS389004.

The driver adds support for reading the 8-bit ADC value of any of
the VMON inputs. By default the inputs are disabled and have a scaling
factor of 1x. They need to be enabled in the device tree, or using the
sysfs attribute from user space.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 Documentation/hwmon/index.rst     |   1 +
 Documentation/hwmon/tps389008.rst |  56 ++++
 MAINTAINERS                       |   8 +
 drivers/hwmon/Kconfig             |  10 +
 drivers/hwmon/Makefile            |   1 +
 drivers/hwmon/tps389008.c         | 466 ++++++++++++++++++++++++++++++
 6 files changed, 542 insertions(+)
 create mode 100644 Documentation/hwmon/tps389008.rst
 create mode 100644 drivers/hwmon/tps389008.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 874f8fd26325..b04643d14972 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -239,6 +239,7 @@ Hardware Monitoring Kernel Drivers
    tmp513
    tps23861
    tps25990
+   tps389008
    tps40422
    tps53679
    tps546d24
diff --git a/Documentation/hwmon/tps389008.rst b/Documentation/hwmon/tps389008.rst
new file mode 100644
index 000000000000..6e1166165ac4
--- /dev/null
+++ b/Documentation/hwmon/tps389008.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver tps389008
+======================
+
+Supported chips:
+
+  * TI TPS389008, TPS389006, TPS389004
+
+    Prefix: 'tps389008'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.ti.com/lit/ds/symlink/tps389006.pdf?ts=1741000787840&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTPS389006
+
+Author:
+
+  - Flaviu Nistor <flaviu.nistor@gmail.com>
+
+Description
+-----------
+
+This driver implements support for TI TPS389008, TPS389006 and TPS389004 voltage monitor chips.
+The driver supports only the chips that have default values based on datasheet and not OTP NVM settings.
+Monitored voltages can be read out via an internal ADC with one register per input channel.
+Measured voltage is expressed in mV per LSB.
+The measurement voltage ranges depends on the scaling factor used as following:
+
+  - 1x scaling: 200 to 1475 mV (8-bit resolution)
+  - 4x scaling: 800 to 5900 mV (8-bit resolution)
+
+The scaling factor is 1 by default for all channels.
+
+All input VMON channel are disabled by default, and they can be enabled via the dts (during probe)
+or using the provided sysfs attribute from user space.
+
+The device communicates with the I2C protocol and uses the I2C address 0x30 by default.
+
+
+Known Issues
+------------
+
+The driver does not support usage of alarms and setting of thresholds (for the alarms).
+
+sysfs-Interface
+---------------
+
+The following list includes the sysfs attributes that the driver will provide for each added input channel:
+
+=============================== ======= ========================================
+Name                            Perm    Description
+=============================== ======= ========================================
+in[12345678]_input:             RO      Voltage channel input
+in[12345678]_label:             RO      Voltage channel label
+in[12345678]_enable:            RW      Voltage channel enable controls
+=============================== ======= ========================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 16f51eb6ebe8..fbf07f26d933 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23510,6 +23510,14 @@ F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
 F:	Documentation/hwmon/tps23861.rst
 F:	drivers/hwmon/tps23861.c
 
+TEXAS INSTRUMENTS TPS389008 VMON DRIVER
+M:	Flaviu Nistor <flaviu.nistor@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/ti,tps389008.yaml
+F:	Documentation/hwmon/tps389008.rst
+F:	drivers/hwmon/tps389008.c
+
 TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
 M:	Ricardo Ribalda <ribalda@kernel.org>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4cbaba15d86e..5562eea4d0bb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1340,6 +1340,16 @@ config SENSORS_TPS23861
 	  This driver can also be built as a module. If so, the module
 	  will be called tps23861.
 
+config SENSORS_TPS389008
+	tristate "TI TPS389008 VMON Driver"
+	depends on I2C
+	help
+	  This driver provides support for voltage monitoring for the Texas
+	  Instruments TPS389008, TPS389006 and TPS389004 chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called tps389008.
+
 config SENSORS_MENF21BMC_HWMON
 	tristate "MEN 14F021P00 BMC Hardware Monitoring"
 	depends on MFD_MENF21BMC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b7ef0f0562d3..6eb0b7696239 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -164,6 +164,7 @@ obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
 obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
 obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
 obj-$(CONFIG_SENSORS_TPS23861)	+= tps23861.o
+obj-$(CONFIG_SENSORS_TPS389008) += tps389008.o
 obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
 obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
 obj-$(CONFIG_SENSORS_MR75203)	+= mr75203.o
diff --git a/drivers/hwmon/tps389008.c b/drivers/hwmon/tps389008.c
new file mode 100644
index 000000000000..6ee6c3b58747
--- /dev/null
+++ b/drivers/hwmon/tps389008.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * tps389008.c Support for the TI TPS389008 Voltage Monitor
+ *
+ * Part numbers supported:
+ * TPS389006, TPS389008
+ *
+ * Author: Flaviu Nistor <flaviu.nistor@gmail.com>
+ *
+ * Datasheet and application notes:
+ * https://www.ti.com/
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#define TPS389008_NUM_CHANNELS      8
+#define TPS389008_1LSB              5
+#define RANGE_OFFSET                200
+#define BANK0                       0
+#define BANK1                       1
+/*BANK0 REGISTERS*/
+#define MON_LVL			            0x40
+#define BANK_SEL                    0xF0
+/*BANK1 REGISTERS
+ * use 0x100 to signal that address is part of BANK1
+ */
+#define MON_CH_EN                   0x11E
+
+struct tps389008_input {
+	const char *label;
+	int vrange_mult_mv;
+	bool enabled;
+	bool disconnected;
+};
+
+struct tps389008_data {
+	struct device *hwmon;
+	struct i2c_client *client;
+	struct tps389008_input input[TPS389008_NUM_CHANNELS];
+	struct mutex dev_access_lock; /* device access lock */
+	const char *name;
+	int current_bank;
+};
+
+enum tps_chan_addr {
+	TPS_CHANNEL_0 = 0,
+	TPS_CHANNEL_1,
+	TPS_CHANNEL_2,
+	TPS_CHANNEL_3,
+	TPS_CHANNEL_4,
+	TPS_CHANNEL_5,
+	TPS_CHANNEL_6,
+	TPS_CHANNEL_7,
+	TPS_CHANNEL_8
+};
+
+static int tps389008_read_string(struct device *dev, enum hwmon_sensor_types type,
+	u32 attr, int channel, const char **str)
+{
+	struct tps389008_data *tps = dev_get_drvdata(dev);
+	int index;
+
+	index = channel - 1;
+	*str = tps->input[index].label;
+
+	return 0;
+}
+
+static umode_t tps389008_is_visible(const void *data, enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	const struct tps389008_data *tps = data;
+	const struct tps389008_input *input = NULL;
+	int index;
+
+	/* channel numbering starts from 1, but index from 0*/
+	index = channel - 1;
+
+	/* in0_ or disconnected channels should be ignored*/
+	if (channel == 0 ||
+		(tps->input[index].disconnected ||
+		 tps->input[index].vrange_mult_mv == 0)) {
+		return 0;
+	}
+	switch (attr) {
+	case hwmon_in_input:
+		return 0444;
+	case hwmon_in_label:
+		input = &tps->input[index];
+		/* Hide label node if label is not provided */
+		return (input && input->label) ? 0444 : 0;
+	case hwmon_in_enable:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int change_bank(struct tps389008_data *data, u8 bank)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, BANK_SEL, bank);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"change to bank%d failed with error code: %d\n", bank, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int tps389008_write_reg(struct tps389008_data *data, u16 reg, u8 val)
+{
+	int ret;
+	u8 bank;
+
+	bank  = (reg & 0x100) >> 8;
+
+	if (bank != (u8)data->current_bank) {
+		change_bank(data, bank);
+		data->current_bank = bank;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, reg, val);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+				"I2C write failed at address: 0x%X with error code: %d\n",
+				reg, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tps389008_read_reg(struct tps389008_data *data, u16 reg, u16 *val)
+{
+	int read_byte;
+	u8 bank;
+
+	bank  = (reg & 0x100) >> 8;
+
+	if (bank != (u8)data->current_bank) {
+		change_bank(data, bank);
+		data->current_bank = bank;
+	}
+
+	read_byte = i2c_smbus_read_byte_data(data->client, reg);
+	if (read_byte < 0) {
+		dev_err(&data->client->dev,
+			"I2C read failed at address: 0x%X with error code: %d\n", reg, read_byte);
+		return read_byte;
+	}
+
+	*val = read_byte;
+
+	return 0;
+}
+
+static int tps389008_get_in_val(struct tps389008_data *data, u16 reg, int channel, long *val)
+{
+	u16 reg_val;
+	int ret;
+	int index;
+
+	/* channel numbering starts from 1, but index from 0*/
+	index = channel - 1;
+
+	ret = tps389008_read_reg(data, reg, &reg_val);
+	if (ret)
+		return ret;
+
+	*val = ((reg_val * TPS389008_1LSB + RANGE_OFFSET) * data->input[index].vrange_mult_mv);
+
+	return 0;
+}
+
+static int disable_input(struct tps389008_data *data, u8 channel)
+{
+	u16 reg_val;
+	int ret;
+	int index;
+
+	index = channel - 1;
+
+	ret = tps389008_read_reg(data, MON_CH_EN, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val = reg_val & ~(1 << index);
+
+	ret = tps389008_write_reg(data, MON_CH_EN, reg_val);
+
+	return ret;
+}
+
+static int enable_input(struct tps389008_data *data, u8 channel)
+{
+	u16 reg_val;
+	int ret;
+	int index;
+
+	index = channel - 1;
+
+	ret = tps389008_read_reg(data, MON_CH_EN, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val = reg_val | (1 << index);
+
+	ret = tps389008_write_reg(data, MON_CH_EN, reg_val);
+
+	return ret;
+}
+
+static int tps389008_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+			int channel, long val)
+{
+	struct tps389008_data *data = dev_get_drvdata(dev);
+	int index;
+	int ret;
+
+	/* channel numbering starts from 1, but index from 0*/
+	index = channel - 1;
+
+	guard(mutex)(&data->dev_access_lock);
+
+	if (attr == hwmon_in_input || attr == hwmon_in_label) {
+		dev_warn(dev, "Write to READ ONLY resource\n");
+		return -EOPNOTSUPP;
+	}
+	if (attr == hwmon_in_enable) {
+		if (val == 0) {
+			data->input[index].enabled = val;
+			ret = disable_input(data, channel);
+			return ret;
+		} else if (val == 1) {
+			data->input[index].enabled = val;
+			ret = enable_input(data, channel);
+			return ret;
+		}
+		dev_err(dev, "invalid value %ld\n", val);
+		return -EINVAL;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int tps389008_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+			int channel, long *val)
+{
+
+	struct tps389008_data *data = dev_get_drvdata(dev);
+	int ret;
+	int index;
+
+	/* channel numbering starts from 1, but index from 0*/
+	index = channel - 1;
+
+	guard(mutex)(&data->dev_access_lock);
+
+	switch (attr) {
+	case hwmon_in_input:
+		ret = tps389008_get_in_val(data, MON_LVL + index, channel, val);
+		if (ret)
+			dev_err(dev,
+				"Reading the ADC value for channel %d failed with error code: %d\n",
+				channel, ret);
+		break;
+	case hwmon_in_enable:
+		*val = data->input[index].enabled;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct hwmon_channel_info *tps389008_info[] = {
+	HWMON_CHANNEL_INFO(in,
+					/* 0: dummy, skipped in is_visible */
+					HWMON_I_INPUT,
+					/* 1-8: input voltage Channels */
+					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
+					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
+					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
+					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
+					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
+					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
+					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
+					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops tps389008_hwmon_ops = {
+	.is_visible = tps389008_is_visible,
+	.read_string = tps389008_read_string,
+	.read = tps389008_read,
+	.write = tps389008_write,
+};
+
+static const struct hwmon_chip_info tps389008_chip_info = {
+	.ops = &tps389008_hwmon_ops,
+	.info = tps389008_info,
+};
+
+
+static int tps389008_probe_child_from_dt(struct device *dev,
+	struct device_node *child,
+	struct tps389008_data *tps)
+{
+	struct tps389008_input *input;
+	u32 val;
+	int ret;
+
+	ret = of_property_read_u32(child, "reg", &val);
+	if (ret) {
+		dev_err(dev, "missing reg property of %pOFn\n", child);
+		return ret;
+	}
+	if (val < 1 || val > TPS_CHANNEL_8) {
+		dev_err(dev, "invalid reg %d of %pOFn\n", val, child);
+		return -EINVAL;
+	}
+
+	/* remember that children nodes starts from 1, but we have the input start index 0.*/
+	input = &tps->input[val-1];
+
+	ret = (int)of_property_read_bool(child, "ti,vrange-mult-4x");
+	if (ret)
+		input->vrange_mult_mv = 4;
+	else
+		input->vrange_mult_mv = 1;
+
+	ret = (int)of_property_read_bool(child, "ti,vmon-enable");
+	/* missing optional property. Default enable the channel*/
+	if (ret)
+		input->enabled = true;
+
+	/* Log the disconnected channel input */
+	if (!of_device_is_available(child)) {
+		input->disconnected = true;
+		return 0;
+	}
+
+	/* Save the connected input label if available */
+	of_property_read_string(child, "label", &input->label);
+
+	return 0;
+}
+
+static int tps389008_probe_from_dt(struct device *dev, struct tps389008_data *tps)
+{
+	const struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int ret;
+
+	for_each_child_of_node(np, child) {
+		ret = tps389008_probe_child_from_dt(dev, child, tps);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int tps389008_probe(struct i2c_client *client)
+{
+	struct tps389008_data *data;
+	struct device *dev = &client->dev;
+	int ret, i;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->dev_access_lock);
+	data->client = client;
+
+	ret = tps389008_probe_from_dt(dev, data);
+	if (ret) {
+		dev_err(dev, "Unable to probe from device tree\n");
+		return ret;
+	}
+
+	data->current_bank = 0;
+
+	/* Enable channels if they are enabled */
+	for (i = 0; i < TPS389008_NUM_CHANNELS; i++) {
+		if (data->input[i].enabled) {
+			enable_input(data, i+1);
+			dev_dbg(dev, "VMON input %d is enabled\n", (i+1));
+		}
+	}
+
+	data->hwmon = devm_hwmon_device_register_with_info(dev, client->name,
+							   data, &tps389008_chip_info,
+							   NULL);
+
+	if (IS_ERR(data->hwmon))
+		return dev_err_probe(dev, PTR_ERR(data->hwmon),
+					 "Failed to register hwmon device tps389008\n");
+
+	dev_info(dev, "hwmon device tps389008 probed successfully\n");
+
+	return 0;
+}
+
+static void tps389008_remove(struct i2c_client *client)
+{
+	struct tps389008_data *tps = dev_get_drvdata(&client->dev);
+
+	hwmon_device_unregister(tps->hwmon);
+
+	mutex_destroy(&tps->dev_access_lock);
+}
+
+static const struct i2c_device_id tps389008_ids[] = {
+	{ "tps389008" },
+	{ "tps389006" },
+	{ "tps389004" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tps389008_ids);
+
+static const struct of_device_id tps389008_of_match[] = {
+	{ .compatible = "ti,tps389008", },
+	{ .compatible = "ti,tps389006", },
+	{ .compatible = "ti,tps389004", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tps389008_of_match);
+
+static struct i2c_driver tps389008_i2c_driver = {
+	.driver = {
+		.name = "tps389008",
+		.of_match_table = tps389008_of_match,
+	},
+	.probe = tps389008_probe,
+	.remove = tps389008_remove,
+	.id_table = tps389008_ids,
+};
+
+module_i2c_driver(tps389008_i2c_driver);
+
+MODULE_AUTHOR("Flaviu Nistor <flaviu.nistor@gmail.com>");
+MODULE_DESCRIPTION("TI TPS389008 voltage monitor driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


