Return-Path: <linux-kernel+bounces-268657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A224094276E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D6DB217B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A01A6181;
	Wed, 31 Jul 2024 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mZlkrUgz"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD51A4F18
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409554; cv=none; b=LNf+appWockrM5TtPttc0wjr59GaXwHb+Z6WPrCXNlIWv/rj+ewVK/meJnQDuk/2BsmKP0Xqi/0JUv2kp5Jwc4vTxa1l0hiibX706kqwVWbW8Pnu6L2juNNDqrAe1tx3aKWRwe8nIkCzDaMV2IWdeWyPSy+Lxwgr5uN1rDpFf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409554; c=relaxed/simple;
	bh=DmT1lkaAUXmyCjselEQKioQon1H08Xpiwh19x8GvP9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3ETY2h6ap5h3rE66ao01VAjwRa+a0AjqhsrbGBjsofkCrYsAgDIU2RIdSJitpfo/GQ48Hg9n/5wjinUBKTVOSba+cRZZxXmKQ/ZW2aDknmPKYUf+zcLeH3j9iim1FMedd+oH48745h/fKFfvCdwTMxtqU4upUjv9imQymH0d8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mZlkrUgz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso34723715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722409550; x=1723014350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xh88NQ9QvsN4DODTuwx5BwmanL/AOw553yOYeKfdouo=;
        b=mZlkrUgzRHEXswHt7YXtfJQ0FC+Up+umcTzWRSkkJIOFkva7Ju10l7FrrR4tS24MwH
         jk5MgxQUahDjxi87zpFtKOReoAqN++JnuTAQNSc5pq2aHEo5oa1NYs4uMH/bZ2wAL74Y
         XBpdhH9k0/61DyLZsC3vTgGBkI7yDV602QkXqkBLlQK8R4GgcDi87Xrl9x9w0Xavm7ZP
         YESHvtRry99J1Yk7z3JuGvSkfFzptJmgYpSOrMFTz5Wg78a479qrkIhwwqhWAmm7JFQW
         DHPZwvryQ+kzGMV78hu35P1B3RHOIHtJdIDi4mNFAJaTKBDrR6fQFwMVikia7L923dfo
         BkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409550; x=1723014350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh88NQ9QvsN4DODTuwx5BwmanL/AOw553yOYeKfdouo=;
        b=m5ehaEw7LAk+zFuXf8OxJYx2hifQqRyBlgcwdGqsxopVn2jYAAj0s+LbdH+un7gzK5
         b9OVQuTu3lBBYaHHbhJcwFVdxFxMKpLrOCoRhhT1AAN+Ovm7aYfbem2JWIk+cw9C26Pm
         T8hJqIvHp3y5M8k0oH83XdNMb4DRyqqHU62sEtsh9daTqr4hP30CAvhZyVy2Nvjvsjl6
         UcnjmHCZmN80iNtmYrdbRG6iptOaduiGvTxsnHo1wPEXNKWAThbUUTHAq/osUQufGeWt
         clBfGnNp9Z2doO6M+2bQ8weGoSGUTotSt5NEdZkitHlkJOfkMeRaIkg3DeY07w1lHNnu
         RGtA==
X-Forwarded-Encrypted: i=1; AJvYcCWhafrpDfSsBNn6wMA+Cr2BxzOvNLuygAQQHtnLN0MV9gTSSgRfRjhUXy+OJZRugCN7WvvMYQt4QWMaKXhcUKwITzOz8qfm8DIjp1EU
X-Gm-Message-State: AOJu0Yw2rSQ4/R0ssAyB5n15UznytbWD4vUA+S19kK8SV6tlOWnxyf6j
	28UPSGCYKEBDwpxJ9mQ7p+mpn6J87efeGUVOe8bFhaYdGcBr7tmtc8UaeEWHi3E=
X-Google-Smtp-Source: AGHT+IF1BsxjqLXjQCg0o51ymFFuLeG7sRz3r2y5FeNtGXo/X7OD6zqXUXoKy9RwDi4FIdp/PydsMw==
X-Received: by 2002:a05:600c:4f8e:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-42811df0e76mr90800015e9.31.1722409550521;
        Wed, 31 Jul 2024 00:05:50 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a2593sm9953215e9.4.2024.07.31.00.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:05:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 31 Jul 2024 09:05:43 +0200
Subject: [PATCH v2 2/7] iio: core: add function to retrieve
 active_scan_mask index
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7380-add-single-ended-chips-v2-2-cd63bf05744c@baylibre.com>
References: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
In-Reply-To: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

Add a function to retrieve the index of the active scan mask inside the
available scan masks array.

As in iio_scan_mask_match and iio_sanity_check_avail_scan_masks,
this function does not handle multi-long masks correctly.
It only checks the first long to be zero, and will use such mask
as a terminator even if there was bits set after the first long.

This should be fine since the available_scan_mask has already been
sanity tested using iio_sanity_check_avail_scan_masks.

See iio_scan_mask_match and iio_sanity_check_avail_scan_masks for
more details

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/industrialio-core.c | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e6fad8a6a1fc..f18f48c7eb03 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1965,6 +1965,49 @@ static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
 	}
 }
 
+/**
+ * iio_active_scan_mask_index - Get index of the active scan mask inside the
+ * available scan masks array
+ * @indio_dev: the IIO device containing the active and available scan masks
+ *
+ * Returns: the index or -EINVAL if  active_scan_mask is not set
+ */
+int iio_active_scan_mask_index(struct iio_dev *indio_dev)
+
+{
+	const unsigned long *av_masks;
+	unsigned int masklength = iio_get_masklength(indio_dev);
+	int i = 0;
+
+	if (!indio_dev->active_scan_mask)
+		return -EINVAL;
+
+	/*
+	 * As in iio_scan_mask_match and iio_sanity_check_avail_scan_masks,
+	 * the condition here do not handle multi-long masks correctly.
+	 * It only checks the first long to be zero, and will use such mask
+	 * as a terminator even if there was bits set after the first long.
+	 *
+	 * This should be fine since the available_scan_mask has already been
+	 * sanity tested using iio_sanity_check_avail_scan_masks.
+	 *
+	 * See iio_scan_mask_match and iio_sanity_check_avail_scan_masks for
+	 * more details
+	 */
+	av_masks = indio_dev->available_scan_masks;
+	while (*av_masks) {
+		if (indio_dev->active_scan_mask == av_masks)
+			return i;
+		av_masks += BITS_TO_LONGS(masklength);
+		i++;
+	}
+
+	dev_warn(indio_dev->dev.parent,
+		 "active scan mask is not part of the avaialable scan masks\n");
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iio_active_scan_mask_index);
+
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index dd6bbc468283..73b75a9ff314 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -864,6 +864,8 @@ static inline unsigned int iio_get_masklength(const struct iio_dev *indio_dev)
 	return indio_dev->masklength;
 }
 
+int iio_active_scan_mask_index(struct iio_dev *indio_dev);
+
 /**
  * iio_for_each_active_channel - Iterated over active channels
  * @indio_dev: the IIO device

-- 
2.45.1


