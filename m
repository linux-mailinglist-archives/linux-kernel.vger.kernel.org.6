Return-Path: <linux-kernel+bounces-448092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E399F3AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21361884A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0A31D63E2;
	Mon, 16 Dec 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9VwpDWb"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C51D5176
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381477; cv=none; b=bUuHD9fawBatdSIz0SiE+TZq4ynzfd8uGJ20n5X+MGd7kRqf/JuD8+9pFNFl+S5wHaFASZ2TrmPi8J9/z1KT7gtJcalwHpE5R+oGPw6r3RTrYoy9LRS/OzAWUr7QYTi/xds75ARRBRWpluj0gz22FpyVe4GIq5rUjmSFzi7YYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381477; c=relaxed/simple;
	bh=HBhpT3Z8kNizKOdmkqpshRkGlYEe3CV+4avHxoYClXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g51ru78a/q5F8ZNA79rdvoP5d+QEjgLG9wUHZ2cInbyI/UkZw48kcrvtcackZZe/GFMYL4ybrfwlgOTPhbdl4D44KyitTvOy6MVr/wp0KL1yJVVTHyGSi52cdkYBUAi6koDLPfZDszyyyBeWlH78Co8EB3bTJ4Dar5+T/dOUfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9VwpDWb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3863494591bso2470221f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381472; x=1734986272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT+yZp7KZfeuF1pQSOvhA42qjXkxkwlrh5Rhv7qAP/A=;
        b=c9VwpDWbDJWVMuXumBtkQZzo7gBBb/ctMmi9jDEZRiBSZvjHShFVRbmBosLv0dYq0l
         6ii+C6w+GmTCb2fkyM7U7s7y/31TnQq9qyVpFenBCzNHnNl0OvjT1T33OkFujevPsbSd
         mV+KuVEZLGeR6iANnQtkLwrDPj3LLaIxaw3c3J2/uvJxcZkZKsT18BSQCLZp3QiUtDBx
         EwGUMP+mworbyzPyHKTxXKoVExJuNKkyrLIy03+3pNMUPM64TOToeTkbAS7Fs0tSdWPg
         ivjxYRdpnemTJ8D19WoA9zoIai792gzKDIWfb/1hY7Wj21U3yOBz7Ip8qkgxbra2M4Ha
         TdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381472; x=1734986272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nT+yZp7KZfeuF1pQSOvhA42qjXkxkwlrh5Rhv7qAP/A=;
        b=vxNcO+g56RUpK/aK627fBcqbnCHFKg68FmdwQ334z/qlHiB6441dseHXzuPGgHu5vu
         21waWAFqVBUfEOXWGphJNFzjMQCjNOQPY65dv7Ifz85eAjehRgBCKBENyK0EwDlHBn08
         +gfnGRerYt7D6Pd56lqcFy67L+MxhAPxl3aGZXNsc5PUnlaXHBqUW6qHOTtQvLbPHrKZ
         auUA/f/uNXa5hAH+6TVcudeQV/c5IKPrv47S+zQJsiBdAtTexp9nHrBH/yt+61Zb9ECi
         Aqu8zqp1yEYkxwvgUeUtTLmvPeHwVmZqFwqMnLR1ACu9PUqe3nTHcH3+zoiCOu8lnZtq
         0/8A==
X-Forwarded-Encrypted: i=1; AJvYcCXSjw8uNbiUC/299hjO/SFUYYvf9RJOBqYiCDqpGjv90RPTFgEJ3dNM3J2HHT3eIJ7eVdLTB+YX8A3gj74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNrBDIS3byB/KeFligd6dzWqhMSeWO/STJVmc18xz2akx+tIP
	HM0i5pjRFEQalNQl13ASBljMNjdruFwIYbI8CdIpyk9qoA8Wo37yQBbeKgpYRNxcbxw1RVioIb3
	E
X-Gm-Gg: ASbGnctPbEgI4uhSqmvWbyyEniIot95oiHYRRZQ5z4nNGM8lOvH4mfTlpMREBY0qv1/
	SW1+q1OnpRIZG3XH5yLyUWpj/Ux+pn7gL/ya766x+NHwPCufQTFyYVP5PWprmeAAAJrSzZHIIOf
	QsZ4wwv5qgYfft8sAgQlrXUduk4W3DWoFgf7CgXO5zhcWC6OD4D6W8t00taTzxGGMUak9/zHeBP
	+xF+bds6ZklfHEkU3jj6V4uWJ+9mgjDHOZC9T9UMDBOC+ERrZ1hSlSYeihiAjfcxSl8Q97wNbtt
	UTiJN/SkOkd/4U8eXNeAEsmhKvKpM9oxrw==
X-Google-Smtp-Source: AGHT+IFh1mJdBHrzlKMOog2KpSvIJzAt0K5JQgDX1J3pNUMf3BCekFbjJ2X7kYCo0/FSmtvehX8QUw==
X-Received: by 2002:a05:6000:144a:b0:385:f7ef:a57f with SMTP id ffacd0b85a97d-38880ad9591mr11709434f8f.27.1734381472520;
        Mon, 16 Dec 2024 12:37:52 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:51 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:24 +0100
Subject: [PATCH 4/8] iio: backend: add API for interface configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-4-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>
X-Mailer: b4 0.14.1

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

Add backend support for setting and getting the interface type
in use.

Link: https://lore.kernel.org/linux-iio/20241129153546.63584-1-antoniu.miclaus@analog.com/T/#m6d86939078d780512824f1540145aade38b0990b
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
This patch has been picked up from the Antoniu patchset
still not accepted, and extended with the interface setter,
fixing also namespace names to be between quotation marks.
---
 drivers/iio/industrialio-backend.c | 42 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        | 19 +++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 363281272035..6edc3e685f6a 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -636,6 +636,48 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_interface_type_get - get the interface type used.
+ * @back: Backend device
+ * @type: Interface type
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_interface_type_get(struct iio_backend *back,
+				   enum iio_backend_interface_type *type)
+{
+	int ret;
+
+	ret = iio_backend_op_call(back, interface_type_get, type);
+	if (ret)
+		return ret;
+
+	if (*type >= IIO_BACKEND_INTERFACE_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
+
+/**
+ * iio_backend_interface_type_set - set the interface type used.
+ * @back: Backend device
+ * @type: Interface type
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_interface_type_set(struct iio_backend *back,
+				   enum iio_backend_interface_type type)
+{
+	if (type >= IIO_BACKEND_INTERFACE_MAX)
+		return -EINVAL;
+
+	return  iio_backend_op_call(back, interface_type_set, type);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_set, "IIO_BACKEND");
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 10be00f3b120..2b7221099d8c 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -70,6 +70,15 @@ enum iio_backend_sample_trigger {
 	IIO_BACKEND_SAMPLE_TRIGGER_MAX
 };
 
+enum iio_backend_interface_type {
+	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
+	IIO_BACKEND_INTERFACE_SERIAL_CMOS,
+	IIO_BACKEND_INTERFACE_SERIAL_SPI,
+	IIO_BACKEND_INTERFACE_SERIAL_DSPI,
+	IIO_BACKEND_INTERFACE_SERIAL_QSPI,
+	IIO_BACKEND_INTERFACE_MAX
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -88,6 +97,8 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @interface_type_get: Interface type.
+ * @interface_type_set: Interface type setter.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -128,6 +139,10 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*interface_type_get)(struct iio_backend *back,
+				  enum iio_backend_interface_type *type);
+	int (*interface_type_set)(struct iio_backend *back,
+				  enum iio_backend_interface_type type);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -186,6 +201,10 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const char *buf, size_t len);
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
+int iio_backend_interface_type_get(struct iio_backend *back,
+				   enum iio_backend_interface_type *type);
+int iio_backend_interface_type_set(struct iio_backend *back,
+				   enum iio_backend_interface_type type);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);

-- 
2.47.0


