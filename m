Return-Path: <linux-kernel+bounces-557705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4BA5DCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DB43B8689
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839E245013;
	Wed, 12 Mar 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMu3Lbbq"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9137241678;
	Wed, 12 Mar 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782689; cv=none; b=EDX9KIc4V19vfkijH2XEc6BN59PjY61QuL5WAbmbSGIutBV+CNp15RDDJBwwOHG3jsPQVcKeqOl/NBIFyeXBUF+yeeXKGV5iuN31IIUWYzRQ4Lbm2v99v43cwOd2MUQUiy+Xsg3TRX2Rri6IPY82Couu/vqPIdKb6+Dj9xLYy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782689; c=relaxed/simple;
	bh=H8QG5ecMLGOEY4Og/1MgPGyGHgWq5rjT5XfBRuu9LJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8PP/53/ljlrizKqE7LwqINpzgtVqHeY83egcy3gx8XUA2htIoIuegdfii6dqVi3f/AFO8DQKe5x6FUwBsbaiYxP2gApvHfyuit7Tcg6hAyUhbpcNG7tyZQ+rcDLWU5lehq+MSQVV93ipCDF+MMJI3yntDiR/cQmWubZbFiPHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMu3Lbbq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fec3176ef3so9867902a91.1;
        Wed, 12 Mar 2025 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782687; x=1742387487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYLJt2gp4oH8mVnJOtzfiFQb5AVimjLmYZhCSJgTXlw=;
        b=QMu3LbbqC85zl+NPwZ3jOHPdkgBUOnTeYbflkv497S7/nXzaMuWnZ3uv53pehdjoyM
         49+2SRlKNWa4yQGNatpYjYyq1wo0Hg/RxDx/Q4GQsWMNozXzxA/3Gz2t4+mGBPW8WLSv
         u7X+YvvGr31d1A3lxaj59skSM2Ph1ndZDF2EvcXnb/UJOIn5VjPnZ/vsYGvBrMbg6zTk
         HI7VB2cSSExl/F7I0/zjDEz48/tV92G/8xxCXETmdlX90Gw7Xb5vmN9uGqejQBjc0PWO
         l4TJj1ucMIP/cLrrYorBPAWIQvA+p+UJxpk2uPx2Y8WWVBi/Yq43iIYbospoDcFe/Bjj
         lbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782687; x=1742387487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYLJt2gp4oH8mVnJOtzfiFQb5AVimjLmYZhCSJgTXlw=;
        b=QlmwsHkjRGk9v3Zm6PaYaqNFbsxJvkVGVH3STkInXReQhGSlLjBsJa28pgcjKPmWNj
         ErsQXNbdaYsEJM+3k/ZM2ysg/Mrex7+Uq2M9L7ujLaAwAioZ+uzii3BYs/s1iTkr/xRZ
         ShFOSGSmWBgamxp3cIa06VoF5N0YoJxIvIrIjG12PIL2ahxv508fQZ1bRIGvT/xad0xa
         ms9ktV8DseLkplXMgQSa7tyFouX0OT2ZeJnJfwdIJA1v4iiQ03xWgxmxUXMmrk+cfUsL
         KnXnAUj/PV080COd4f6HwtnVDn6qywaie/ed0U4ZFjBKHC8V/upNajmTSnFzbXPg9bYt
         FyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBx/x2gWq+HyH+wGCJfP0IOBf7+9cb1M8rfNQxo3CCPENfd/QQlDphrmmf1GNkLPy+QX/p5Xc9EE/yu7XN@vger.kernel.org, AJvYcCXet/+d52pWDNZliVY5RwhWXkS73vRUpxiG/N+HSMTktEIhdXYr81vSu1cr3zV7yGnK/B4bOhIo1CJMvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCxG+GK/DdGhEPNg06lvRlwh4BsQOW4fVYwvrpwX2lYHXJwya
	zMCKVvkLGBWp/1zMEXxmBjApc62Yzn+I7ADYleGNpbS00jzsS7Nw
X-Gm-Gg: ASbGncueFX0xyzX5WHwRxUt7rhXVKqUnxhKNsnSqM6avWK7FCXIYP29CUYhmWhqCLSy
	9gjWpk5/pqUlOQh6jathteqw0yQ0tc9OpW+iqv0FTAqpGGjwg4Ql3t2gWNOz/qNXWcg3/0YzSOu
	4IqbVYpNg/N2X96xytLGEMyqnRtFpIl0uBNbUSI8vmWyONlIrLGH7Bga41q6rgy3+UkD7rp8DZ+
	EdKmeJL4GaM+i/d66ekmDtqae1ejWtTcwE4sSytz3AJVbVpvodl/IuNW1RGActzzQgxPx0lWcS2
	JeCmaEAsEhXgop6SZTsDSSb2+8C56EP5W9Z5n/37cYhEi6/S9GVofGoYZ2Ih8T1fc3nxWNbNue7
	V4jqnlY+xnK/hxgchfPMzzE+1eCs=
X-Google-Smtp-Source: AGHT+IHaV5eNAX6fjVra4FDgV+bkab0WccBzwzAJMJtmvvw5216pVI9cMpIffkO5ZphZ9IBnnEw5GA==
X-Received: by 2002:a17:90b:1d0a:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2ff7ce5965amr30359359a91.4.1741782686911;
        Wed, 12 Mar 2025 05:31:26 -0700 (PDT)
Received: from kernel-Apple-Virtualization-Generic-Platform.. ([2401:4900:8898:8129:deb0:598c:ebb7:dc81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301182181c3sm1621784a91.5.2025.03.12.05.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:31:26 -0700 (PDT)
From: Subu Dwevedi <messigoatcr7nop@gmail.com>
To: 
Cc: Subu Dwevedi <messigoatcr7nop@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon/applesmc: add fan support for newer macs
Date: Wed, 12 Mar 2025 18:00:23 +0530
Message-ID: <20250312123055.1735-3-messigoatcr7nop@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312123055.1735-1-messigoatcr7nop@gmail.com>
References: <20250312123055.1735-1-messigoatcr7nop@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer Mac models have transitioned
the fan speed values from short to float.

Additionally, the fan manual
control mechanism (fan_manual) have changed from u16 to u8

Signed-off-by: Subu Dwevedi <messigoatcr7nop@gmail.com>
---
 drivers/hwmon/applesmc.c | 124 +++++++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 1be4a4026a6e..9157f5978ee7 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -71,10 +71,12 @@
 #define MOTION_SENSOR_KEY	"MOCN" /* r/w ui16 */
 
 #define FANS_COUNT		"FNum" /* r-o ui8 */
+#define FANS_MANUAL_FMT	"F%dMd" /* r-w ui8*/
 #define FANS_MANUAL		"FS! " /* r-w ui16 */
 #define FAN_ID_FMT		"F%dID" /* r-o char[16] */
 
 #define TEMP_SENSOR_TYPE	"sp78"
+#define FLOAT_TYPE		"flt "
 
 /* List of keys used to read/write fan speeds */
 static const char *const fan_speed_fmt[] = {
@@ -145,6 +147,8 @@ static s16 rest_y;
 static u8 backlight_state[2];
 static u8 *__iomem mmio_base;
 static bool is_mmio;
+static bool is_fan_manual_fmt;
+static bool is_fan_speed_float;
 static u32 mmio_base_addr, mmio_base_size;
 static struct device *hwmon_dev;
 static struct input_dev *applesmc_idev;
@@ -652,6 +656,50 @@ static int applesmc_read_s16(const char *key, s16 *value)
 	return 0;
 }
 
+/*
+ * applesmc_float_to_u32 - Retrieve the integral part of a float.
+ * This is needed because Apple made fans use float values in the T2.
+ * The fractional point is not significantly useful though, and the integral
+ */
+static inline u32 applesmc_float_to_u32(u32 from)
+{
+	u8 sign = from >> 31;
+	s32 exp = ((from >> 23) & 0xFF) - 0x7F;
+	u32 fr = from & GENMASK(22, 0);
+	u32 round_up = 0;
+
+	if (sign || exp < 0)
+		return 0;
+
+	u32 int_part = BIT(exp);
+	u32 frac_part = fr >> (23 - exp);
+
+	if (fr & BIT(22 - exp))
+		round_up = 1;
+
+	return int_part + frac_part + round_up;
+}
+
+/*
+ * applesmc_u32_to_float - Convert an u32 into a float.
+ * See applesmc_float_to_u32 for a rationale.
+ */
+static inline u32 applesmc_u32_to_float(u32 from)
+{
+	if (!from)
+		return 0;
+
+	u32 bc = fls(from) - 1;
+	u32 exp = 0x7F + bc;
+	u32 frac_part = (from << (23 - bc)) & GENMASK(22, 0);
+	u32 round_up = 0;
+
+	if (from & BIT(bc - 1))
+		round_up = 1;
+
+	return (exp << 23) | (frac_part + round_up);
+}
+
 /*
  * applesmc_device_init - initialize the accelerometer.  Can sleep.
  */
@@ -763,6 +811,8 @@ static int applesmc_init_mmio_try(void)
 static int applesmc_init_smcreg_try(void)
 {
 	struct applesmc_registers *s = &smcreg;
+	const struct applesmc_entry *e;
+	char newkey[5];
 	bool left_light_sensor = false, right_light_sensor = false;
 	unsigned int count;
 	u8 tmp[1];
@@ -788,6 +838,15 @@ static int applesmc_init_smcreg_try(void)
 	if (!s->cache)
 		return -ENOMEM;
 
+	scnprintf(newkey, sizeof(newkey), fan_speed_fmt[1], 1); //example value
+
+	e = applesmc_get_entry_by_key(newkey);
+	if (IS_ERR(e))
+		return PTR_ERR(e);
+
+	if (!strcmp(e->type, FLOAT_TYPE))
+		is_fan_speed_float = true;
+
 	ret = applesmc_read_key(FANS_COUNT, tmp, 1);
 	if (ret)
 		return ret;
@@ -820,6 +879,10 @@ static int applesmc_init_smcreg_try(void)
 	if (ret)
 		return ret;
 
+	ret = applesmc_has_key(FANS_MANUAL_FMT, &is_fan_manual_fmt);
+	if (ret)
+		return ret;
+
 	s->num_light_sensors = left_light_sensor + right_light_sensor;
 	s->init_complete = true;
 
@@ -1044,11 +1107,16 @@ static ssize_t applesmc_show_fan_speed(struct device *dev,
 	scnprintf(newkey, sizeof(newkey), fan_speed_fmt[to_option(attr)],
 		  to_index(attr));
 
-	ret = applesmc_read_key(newkey, buffer, 2);
+	if (is_fan_speed_float) {
+		ret = applesmc_read_key(newkey, (u8 *) &speed, 4);
+		speed = applesmc_float_to_u32(speed);
+	} else {
+		ret = applesmc_read_key(newkey, buffer, 2);
+		speed = ((buffer[0] << 8 | buffer[1]) >> 2);
+	}
 	if (ret)
 		return ret;
 
-	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
 	return sysfs_emit(sysfsbuf, "%u\n", speed);
 }
 
@@ -1067,10 +1135,14 @@ static ssize_t applesmc_store_fan_speed(struct device *dev,
 	scnprintf(newkey, sizeof(newkey), fan_speed_fmt[to_option(attr)],
 		  to_index(attr));
 
-	buffer[0] = (speed >> 6) & 0xff;
-	buffer[1] = (speed << 2) & 0xff;
-	ret = applesmc_write_key(newkey, buffer, 2);
-
+	if (is_fan_speed_float) {
+		speed = applesmc_u32_to_float(speed);
+		ret = applesmc_write_key(newkey, (u8 *) &speed, 4);
+	} else {
+		buffer[0] = (speed >> 6) & 0xff;
+		buffer[1] = (speed << 2) & 0xff;
+		ret = applesmc_write_key(newkey, buffer, 2);
+	}
 	if (ret)
 		return ret;
 	else
@@ -1084,11 +1156,13 @@ static ssize_t applesmc_show_fan_manual(struct device *dev,
 	u16 manual = 0;
 	u8 buffer[2];
 
-	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
-	if (ret)
-		return ret;
-
-	manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
+	if (is_fan_manual_fmt) {
+		ret = applesmc_read_key(FANS_MANUAL_FMT, buffer, 1);
+		manual = buffer[0];
+	} else {
+		ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
+		manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
+	}
 	return sysfs_emit(sysfsbuf, "%d\n", manual);
 }
 
@@ -1104,22 +1178,26 @@ static ssize_t applesmc_store_fan_manual(struct device *dev,
 	if (kstrtoul(sysfsbuf, 10, &input) < 0)
 		return -EINVAL;
 
-	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
-	if (ret)
-		goto out;
-
-	val = (buffer[0] << 8 | buffer[1]);
+	if (is_fan_manual_fmt) {
+		buffer[0] = input & 0x01;
+		ret = applesmc_write_key(FANS_MANUAL_FMT, buffer, 1);
+	} else {
+		ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
+		if (ret)
+			goto out;
 
-	if (input)
-		val = val | (0x01 << to_index(attr));
-	else
-		val = val & ~(0x01 << to_index(attr));
+		val = (buffer[0] << 8 | buffer[1]);
 
-	buffer[0] = (val >> 8) & 0xFF;
-	buffer[1] = val & 0xFF;
+		if (input)
+			val = val | (0x01 << to_index(attr));
+		else
+			val = val & ~(0x01 << to_index(attr));
 
-	ret = applesmc_write_key(FANS_MANUAL, buffer, 2);
+		buffer[0] = (val >> 8) & 0xFF;
+		buffer[1] = val & 0xFF;
 
+		ret = applesmc_write_key(FANS_MANUAL, buffer, 2);
+	}
 out:
 	if (ret)
 		return ret;
-- 
2.43.0


