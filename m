Return-Path: <linux-kernel+bounces-189080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3808CEAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E849B217B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C5084D03;
	Fri, 24 May 2024 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zDACARjf"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D326F06D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581902; cv=none; b=UCdOad0RXXbuGAgV+FxwrI/RoEBTe9AP3VeiueGCpX0DP4NuNrjjmFBfXBProrRWhd0A0SaIH+qbz4uE5hUoNNhIe3yfxdfvaWeTWKOIlQ8CZ9uXbCa8oiNb41IZL2AUIdomk+aYYcDFaiS+NicXVPPER/nUN2ACVqPfYRUofeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581902; c=relaxed/simple;
	bh=k1DKLc8pxxgg1AYnYH88mtuOhL38TUJJ1mKFETHH1fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqNOUutQhG1Uo8FsMMtF2UoBEE9PVWHN82/gbXvYWeKJFWTXN5dOGAXbpJyQReOQt9vH7nyJvOGc4g5oF4HSiFTcPgSWycsi3jZhrJm313QB56zUS2XvR/TPyi1FqLTIkpj6zp0YYIxdjibg8ykhk6iUps9/mUi5rEDdixKRMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zDACARjf; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c9f628e71so658691fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716581900; x=1717186700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtPQmXhI59y3Nbnw6w8KYqVFNmGB3yypLsi3HdguYNI=;
        b=zDACARjfdqjOjcRVrgEr4LPCyzSWbiho95LWAlQFQdSZ5qPAEdiddcBihwh5PtBwdo
         CaQ3PtDCGveRP4g5NsPo4TpoVwrm9j30B+IVIToMrFyYI608sP5YpB8G8zhdwDFVslCK
         juHorLRb/CquMHAWGyGLeW3SESyOMiqKBQ8Crib0PDBAY03vSaVSWq42Dut2T7sqTx4i
         nkvOsrRhgsmkEtv3AWT+7Cd0FmqxjHgoaVm//BC7uM2KMHE6A7CaLZcYxmPGznGXQkpz
         8C4vuUT50OLWLX2yQI8QFAGx4mWWpPXj+iYWGkbQgrqJXt22rZ9o5tt9dsjady1Ntj1z
         ygPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716581900; x=1717186700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtPQmXhI59y3Nbnw6w8KYqVFNmGB3yypLsi3HdguYNI=;
        b=TS6teuYlg+2kZKmZgrOEcN/XazZKzDX+p6xAMT/BI4i2ThtzggyutikHJUHUXkGmMZ
         7g9T46mdYD/+PVDOcgrvil4E7ziCGaRSOKb6eWCM2AFq7gDO0W9N1o6Gnrmt7dCB5fdW
         ULDE2KluSRj3Cu64CxraTKdC769STZh7L+XDDSbHOn16ksXdPpF9pkMJnRRdT8ri2yCp
         mEIV9v0ewl6dZ3EcLbW/x4ETMjbqy7DqO0XKsaegmhMVwYmX94VPWStFA3CGlXAsKtLM
         fszf5HWuF/XjtluomyhGb2hHutIpjDQCaH7jT73MaxoxPK1gQIJN2gpkQwIVJ8JfD7ct
         8GDA==
X-Forwarded-Encrypted: i=1; AJvYcCWOTJXoQmEtqjV8dSF5HwkcEBpeWoW+YCLB76AzlyR3qjP0rpWAVZvcx/vHcSDUjbSYHmlgXDXKHwq91cytIwPCRkYH4muUfmFxkROp
X-Gm-Message-State: AOJu0Ywa99TaPDBNU6PRWYBTgsJxLH+rLtnT0VHzVVlR0HMgubrfNj36
	utnwbnZP8a5KIZL2KfBFCVPCn8WSwG1rhfDdGkKhB223cQ6bG2j/YLQriGCtI8o1nWj1URQAlif
	rQKw=
X-Google-Smtp-Source: AGHT+IGLXY4Yk/y2rk2JX11F/FtbKuoZfvyir6vr6iXmAR717RZMaePwXVeT2QDqGKFN5iQ7RHolsg==
X-Received: by 2002:a05:6870:8dcf:b0:23a:2ddc:30d4 with SMTP id 586e51a60fabf-24ca129cb9dmr3711786fac.23.1716581899941;
        Fri, 24 May 2024 13:18:19 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24ca2840481sm516737fac.57.2024.05.24.13.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:18:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: add support for multiple scan types per channel
Date: Fri, 24 May 2024 15:18:09 -0500
Message-ID: <20240524-iio-add-support-for-multiple-scan-types-v2-3-a6c328fdfab7@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com>
References: <20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds new fields to the iio_channel structure to support multiple
scan types per channel. This is useful for devices that support multiple
resolution modes or other modes that require different data formats of
the raw data.

To make use of this, drivers need to implement the new callback
get_current_scan_type() to resolve the scan type for a given channel
based on the current state of the driver. There is a new scan_type_ext
field in the iio_channel structure that should be used to store the
scan types for any channel that has more than one. There is also a new
flag has_ext_scan_type that acts as a type discriminator for the
scan_type/ext_scan_type union. A union is used so that we don't grow
the size of the iio_channel structure and also makes it clear that
scan_type and ext_scan_type are mutually exclusive.

The buffer code is the only code in the IIO core code that is using the
scan_type field. This patch updates the buffer code to use the new
iio_channel_validate_scan_type() function to ensure it is returning the
correct scan type for the current state of the device when reading the
sysfs attributes. The buffer validation code is also update to validate
any additional scan types that are set in the scan_type_ext field. Part
of that code is refactored to a new function to avoid duplication.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* use union for scan_type and ext_scan_type/num_ext_scan_types
* add has_ext_scan_type flag for type discrimination
* add extra validation check for get_current_scan_type when
  has_ext_scan_type is set
---
 drivers/iio/industrialio-buffer.c | 61 ++++++++++++++++++++++++++++++---------
 include/linux/iio/iio.h           | 46 +++++++++++++++++++++++++++--
 2 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 08103a9e77f7..0c6ee5610987 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -365,8 +365,10 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	const struct iio_scan_type *scan_type = &this_attr->c->scan_type;
+	const struct iio_scan_type *scan_type =
+		iio_get_current_scan_type(indio_dev, this_attr->c);
 	u8 type = scan_type->endianness;
 
 	if (type == IIO_CPU) {
@@ -699,7 +701,7 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 	unsigned int bytes;
 
 	ch = iio_find_channel_from_si(indio_dev, scan_index);
-	scan_type = &ch->scan_type;
+	scan_type = iio_get_current_scan_type(indio_dev, ch);
 	bytes = scan_type->storagebits / 8;
 
 	if (scan_type->repeat > 1)
@@ -1597,6 +1599,22 @@ static long iio_device_buffer_ioctl(struct iio_dev *indio_dev, struct file *filp
 	}
 }
 
+static int iio_channel_validate_scan_type(struct device *dev, int ch,
+					  const struct iio_scan_type *scan_type)
+{
+	/* Verify that sample bits fit into storage */
+	if (scan_type->storagebits < scan_type->realbits + scan_type->shift) {
+		dev_err(dev,
+			"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
+			ch, scan_type->storagebits,
+			scan_type->realbits,
+			scan_type->shift);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 					     struct iio_dev *indio_dev,
 					     int index)
@@ -1626,18 +1644,33 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 			if (channels[i].scan_index < 0)
 				continue;
 
-			scan_type = &channels[i].scan_type;
-
-			/* Verify that sample bits fit into storage */
-			if (scan_type->storagebits <
-			    scan_type->realbits + scan_type->shift) {
-				dev_err(&indio_dev->dev,
-					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
-					i, scan_type->storagebits,
-					scan_type->realbits,
-					scan_type->shift);
-				ret = -EINVAL;
-				goto error_cleanup_dynamic;
+			if (channels[i].has_ext_scan_type) {
+				int j;
+
+				/*
+				 * get_current_scan_type is required when using
+				 * extended scan types.
+				 */
+				if (!indio_dev->info->get_current_scan_type) {
+					ret = -EINVAL;
+					goto error_cleanup_dynamic;
+				}
+
+				for (j = 0; j < channels[i].num_ext_scan_type; j++) {
+					scan_type = &channels[i].ext_scan_type[j];
+
+					ret = iio_channel_validate_scan_type(
+						&indio_dev->dev, i, scan_type);
+					if (ret)
+						goto error_cleanup_dynamic;
+				}
+			} else {
+				scan_type = &channels[i].scan_type;
+
+				ret = iio_channel_validate_scan_type(
+						&indio_dev->dev, i, scan_type);
+				if (ret)
+					goto error_cleanup_dynamic;
 			}
 
 			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 19de573a944a..bbcc36abc3ad 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -204,7 +204,13 @@ struct iio_scan_type {
  * @address:		Driver specific identifier.
  * @scan_index:		Monotonic index to give ordering in scans when read
  *			from a buffer.
- * @scan_type:		struct describing the scan type
+ * @scan_type:		struct describing the scan type - mutually exclusive
+ *			with ext_scan_type.
+ * @ext_scan_type:	Used in rare cases where there is more than one scan
+ *			format for a channel. When this is used, the flag
+ *			has_ext_scan_type must be set and the driver must
+ *			implement get_current_scan_type in struct iio_info.
+ * @num_ext_scan_type:	Number of elements in ext_scan_type.
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_separate_available: What availability information is to be
@@ -248,6 +254,7 @@ struct iio_scan_type {
  *			attributes but not for event codes.
  * @output:		Channel is output.
  * @differential:	Channel is differential.
+ * @has_ext_scan_type:	True if ext_scan_type is used instead of scan_type.
  */
 struct iio_chan_spec {
 	enum iio_chan_type	type;
@@ -255,7 +262,13 @@ struct iio_chan_spec {
 	int			channel2;
 	unsigned long		address;
 	int			scan_index;
-	struct iio_scan_type scan_type;
+	union {
+		struct iio_scan_type scan_type;
+		struct {
+			const struct iio_scan_type *ext_scan_type;
+			unsigned int num_ext_scan_type;
+		};
+	};
 	long			info_mask_separate;
 	long			info_mask_separate_available;
 	long			info_mask_shared_by_type;
@@ -273,6 +286,7 @@ struct iio_chan_spec {
 	unsigned		indexed:1;
 	unsigned		output:1;
 	unsigned		differential:1;
+	unsigned		has_ext_scan_type:1;
 };
 
 
@@ -435,6 +449,9 @@ struct iio_trigger; /* forward declaration */
  *			for better event identification.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
+ * @get_current_scan_type: must be implemented by drivers that use ext_scan_type
+ *			in the channel spec to return the currently active scan
+ *			type based on the current state of the device.
  * @update_scan_mode:	function to configure device and scan buffer when
  *			channels have changed
  * @debugfs_reg_access:	function to read or write register value of device
@@ -519,6 +536,9 @@ struct iio_info {
 
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
+	const struct iio_scan_type
+		*(*get_current_scan_type)(const struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan);
 	int (*update_scan_mode)(struct iio_dev *indio_dev,
 				const unsigned long *scan_mask);
 	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
@@ -804,6 +824,28 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
 }
 #endif
 
+/**
+ * iio_get_current_scan_type - Get the current scan type for a channel
+ * @indio_dev:	the IIO device to get the scan type for
+ * @chan:	the channel to get the scan type for
+ *
+ * Most devices only have one scan type per channel and can just access it
+ * directly without calling this function. Core IIO code and drivers that
+ * implement ext_scan_type in the channel spec should use this function to
+ * get the current scan type for a channel.
+ *
+ * Returns: the current scan type for the channel
+ */
+static inline const struct iio_scan_type
+*iio_get_current_scan_type(const struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan)
+{
+	if (chan->has_ext_scan_type)
+		return indio_dev->info->get_current_scan_type(indio_dev, chan);
+
+	return &chan->scan_type;
+}
+
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,

-- 
2.45.1


