Return-Path: <linux-kernel+bounces-191531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556F8D10C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE558282A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE36646;
	Tue, 28 May 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U62PoGNi"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745C364
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854970; cv=none; b=rx8UTlKnGAEFluHmD+Gy1jZie85FH2cwdJIihEiT26X05ErmRm9ZmDIOCmtdfvYQ+X0AnimLOxPWBFf7Bpy6kzosybbR7qMyBi9q8dmQv//Y2Cf78VenHGEkQ0YhpBdlL/EiHzWtK96WG/+UXqYD8/s296Y5rJUK/E6q5rzPRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854970; c=relaxed/simple;
	bh=Kh36tuBL84XtFlRGmvYa3raQLod/6PUsPZfYw1vNhL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cosZUH/iu/2kUm/VRWq+UxLg31rzB28TDti/bEOUl5MdmA0DWgwYvIkJuv2Yr8JGnrO4x2+Fr4azreTLYdWJWxUpH2BfwVwNopuDZ2Q4ce+oREUQ0yI3aJ6L/PAybX/Dxu/nEyOFGx9REEQ0//BK11HY82XqHAg5uHkXaFaWykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U62PoGNi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45dso248424a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716854966; x=1717459766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vi1k07lqbmdrx+vXD7+yADEv1Hrp2clMg7e7A28VsN8=;
        b=U62PoGNiUfDDFtBmEb2voCjPVmdsyijdxuiuKkxL6MVN4agxl1VqUGTBBLBnBVjIK2
         iCaIy2OpsaPrKhgUqjRWuu6Gwiyd8UtArgStIsGs46pZcv/o99uHtKXPlOFUOyJJyVUX
         T3gfeeai/u3h98DSlv3Fl7ZwvAZWL68WIxmEEEB31E8YGHon6R9+WMIt4BNh4fXS5T3o
         NJQxUPSrOYbzEmyTzTyAzRdUA5E6d3DNRzq81IHy+KtbHXM5t43xAbtbblrjDUcQQST8
         Iu4nhUKRkKBQt/fbiDRcSfhO+U+B1ex8mn0hHW9BeLrrwGWDvm0hgACcBBsmpGvuNjba
         t/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716854966; x=1717459766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vi1k07lqbmdrx+vXD7+yADEv1Hrp2clMg7e7A28VsN8=;
        b=k44J7aAD+XZgcAc7TitevAselBUAd50Q9xJ5lqZv4JsR+Y6uR3e0EMSCeazmwIpwBp
         lXSD7H191dIHsFMAPHdKKqaxWWRJpEjcLkmisrqggqCB4ay4LN/O/W6lkeNQ9ZaWusBW
         9MZpYc7cGztbSh6XR0vPKhTpwJv9gVVHev4ZdJx379o430FOp9KOvnnytQ2gaDtrfqs/
         kIhmlQLBiuvf4OJykLK6HsCiFv15sUz18Agpb18FjCvewcQXAt6IQi1bxgZzlNELEgvL
         SJQQh0Cfl/A6eBhtSozZvvhOG8VZJFKWEyzfNCp2K5ja0CER1tNzswVP76Vmc1+qmzqa
         AfYg==
X-Gm-Message-State: AOJu0YzzJZQz0RmnoQ8a/ttCZ+k4rI9lD3HUQvpeN6KzJIj8zlHCJnEA
	Upm9QE7eI/K6fGow+KsDz1jIzX7MXtMoayFPfB+oV10KHP/op2wjz4fA7c1+lq//dw==
X-Google-Smtp-Source: AGHT+IEjbogfZqLJix/dCQ21qE3i0tXDgz9Orpn2kWeTPlx9w+ypdIuqK5BGUG4V6YyL3Y4Sq8MU4g==
X-Received: by 2002:a17:906:3f87:b0:a59:b590:5d71 with SMTP id a640c23a62f3a-a626308f264mr671406466b.0.1716854966248;
        Mon, 27 May 2024 17:09:26 -0700 (PDT)
Received: from localhost.localdomain ([37.161.34.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c933e7dsm544678166b.46.2024.05.27.17.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:09:25 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
X-Google-Original-From: Antoni Pokusinski <apokusinski@o2.pl>
To: jic23@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski@o2.pl>
Subject: [PATCH] iio: humidity: si7020: add heater support
Date: Tue, 28 May 2024 02:08:58 +0200
Message-Id: <20240528000858.14459-1-apokusinski@o2.pl>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the integrated on-chip heater that is present
on all the devices supported by this driver (si7020, si7021, si7013, th6).
In order to configure the heater, the driver interacts with the following
device registers:
* User Register - the 2nd bit of this register is a "Heater Enable bit"
  (0 means that the heater is off, 1 means that it's on).
* Heater Register - this register is present only on the si70xx devices
  and controls the current flowing through the heater. The 4 lower bits
  of this register can be assigned values from 0x0 to 0xF.

Signed-off-by: Antoni Pokusinski <apokusinski@o2.pl>
---
 drivers/iio/humidity/si7020.c | 137 +++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index fb1006649328..f0712ad5944c 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -23,6 +23,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/stat.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -33,17 +34,38 @@
 #define SI7020CMD_TEMP_HOLD	0xE3
 /* Software Reset */
 #define SI7020CMD_RESET		0xFE
+/* Write User Register */
+#define SI7020CMD_USR_WRITE	0xE6
+/* "Heater Enabled" bit in the User Register */
+#define SI7020_USR_HTRE		BIT(2)
+/* Write Heater Register */
+#define SI7020CMD_HTR_WRITE	0x51
+/* Heater current configuration bits */
+#define SI7020_HTR_HEATER	GENMASK(3, 0)
+
+struct si7020_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u8 user_reg;
+	u8 heater_reg;
+};
+
+static const int si7020_heater_vals[] = {0, 1, 0xF};
 
 static int si7020_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
 {
-	struct i2c_client **client = iio_priv(indio_dev);
+	struct si7020_data *data = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = i2c_smbus_read_word_swapped(*client,
+		if (chan->type == IIO_CURRENT) {
+			*val = data->heater_reg;
+			return IIO_VAL_INT;
+		}
+		ret = i2c_smbus_read_word_swapped(data->client,
 						  chan->type == IIO_TEMP ?
 						  SI7020CMD_TEMP_HOLD :
 						  SI7020CMD_RH_HOLD);
@@ -96,17 +118,118 @@ static const struct iio_chan_spec si7020_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
+		.extend_name = "heater",
 	}
 };
 
+static int si7020_update_reg(struct si7020_data *data,
+				u8 *reg, u8 cmd, u8 mask, u8 val)
+{
+	u8 new = (*reg & ~mask) | val;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, cmd, new);
+	if (!ret)
+		*reg = new;
+
+	return ret;
+}
+
+static int si7020_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct si7020_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_CURRENT || val2 != 0 ||
+			val < si7020_heater_vals[0] || val > si7020_heater_vals[2])
+			return -EINVAL;
+
+		mutex_lock(&data->lock);
+		ret = si7020_update_reg(data, &data->heater_reg, SI7020CMD_HTR_WRITE,
+							SI7020_HTR_HEATER, val);
+		mutex_unlock(&data->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int si7020_read_available(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals,
+				  int *type, int *length, long mask)
+{
+	if (mask != IIO_CHAN_INFO_RAW || chan->type != IIO_CURRENT)
+		return -EINVAL;
+
+	*vals = si7020_heater_vals;
+	*type = IIO_VAL_INT;
+
+	return IIO_AVAIL_RANGE;
+}
+
+static ssize_t si7020_show_heater_en(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct si7020_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", !!(data->user_reg & SI7020_USR_HTRE));
+}
+
+static ssize_t si7020_store_heater_en(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct si7020_data *data = iio_priv(indio_dev);
+	int ret;
+	bool val;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&data->lock);
+	ret = si7020_update_reg(data, &data->user_reg, SI7020CMD_USR_WRITE,
+					SI7020_USR_HTRE, val ? SI7020_USR_HTRE : 0);
+	mutex_unlock(&data->lock);
+
+	return ret < 0 ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(heater_enable, 0644,
+		       si7020_show_heater_en, si7020_store_heater_en, 0);
+
+static struct attribute *si7020_attributes[] = {
+	&iio_dev_attr_heater_enable.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group si7020_attribute_group = {
+	.attrs = si7020_attributes,
+};
+
 static const struct iio_info si7020_info = {
 	.read_raw = si7020_read_raw,
+	.write_raw = si7020_write_raw,
+	.read_avail = si7020_read_available,
+	.attrs = &si7020_attribute_group,
 };
 
 static int si7020_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
-	struct i2c_client **data;
+	struct si7020_data *data;
 	int ret;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -126,7 +249,9 @@ static int si7020_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	*data = client;
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
 
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -134,6 +259,10 @@ static int si7020_probe(struct i2c_client *client)
 	indio_dev->channels = si7020_channels;
 	indio_dev->num_channels = ARRAY_SIZE(si7020_channels);
 
+	/* Default register values */
+	data->user_reg = 0x3A;
+	data->heater_reg = 0x0;
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.25.1


