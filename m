Return-Path: <linux-kernel+bounces-316616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D84796D1FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D145328680C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03F18BC0A;
	Thu,  5 Sep 2024 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vR0KxDxd"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5710190075
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524658; cv=none; b=SQ47nu4E9RsqYZZC2iukCoyUnGlqr62f+A9+rsEyRqQ4j/JEkrhfwyiWMZnRdfktDWkgTgfzYVw0q6a711bDjz3gJxHgeYoql0w6TEUz1FMHtaxi2nVuYYR2CIMTDYipOKQjnhJytLHIbbU8TUIAnErChw/npCUyiCztdiZogFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524658; c=relaxed/simple;
	bh=9wWTe2RhHwvr6CPLWLyUmFQssffTJWZ48+UUgVNgMfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7soazxpbyvVs4Zz077nBcKcVO1M8dULnI17cE+nupdPdGPz9xxD2ICk/2otTlgrZBkBzhOVi59AO47gfBvUM2hwFL4KXlM2M9Dd6wpzRZ/q/cPCqG8cD9TB0czISsK5K30wertk7gROHbbol7casMhm4w6FcHD/U0xF1wYwztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vR0KxDxd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a7929fd64so17077966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725524654; x=1726129454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=vR0KxDxdQ77x0HcgiwxAV6eJwsx97UxYlez2UKMSNBEIoQTZU6sq/t0u4cX/uVdr23
         Dz2pg2B5opjkyW5cvvv4SBuw3QtVo7eWu3v9npQN492SzUf/WkJudObmBxAc3oyPiOJ1
         /FNSZHr81CoTKsGIWRNzRTY7qxj35lNyZbKaLGejx/rx3k+Uko/zIxfRW/38RAImye/p
         MSbysA3Glsn47VUJ9tPvD9/y55X+r3IcsWow2YcNVZ828T/O/0+fENT4Ag4slh/KKMve
         evst4mE8EmsvVD+1Sj0ALwGPSht0iJdLNw0s763Aml4kEaTJd2lab//babVn5clbiCyl
         VcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524654; x=1726129454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRucj7sLZEUBkFzhvRqpr3JKNs6+16Ez8lks/iAJ3Xo=;
        b=fqRYPJt4GmhHg5tGIvtAGZlEDz6I99CR0yCBx7TcOMKDp5MIrGHAsh2rQBh7W4w3Mw
         Jrk4czSI6pg/CdOXHcfIlvHsee8PanIBgQLC7HHa/kCUqI1sz+YWxQYZdkz580E6GH3l
         7yy3OcV+UaVTSXLt5RP9l1yIlZ77FNDxuFb64G+c4AxFqPpMKqV3nEzAYrjhGd6eQR21
         QhKmi2inbuyfRnsBs+Qb0J1uRU6wwO5v1fqIPn+mU+sj/J09h9M7We20qmMpVYpVaLFF
         d6D3QjE3q8ZCisoSDTH7oSkaKAGRZ8blGzusy88dv7KeOJg/87NWEA36FIEIW211+jll
         2+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY271qemYBf1sQGEIi1y4jeHaK/G7slxqALbeh2MV40QgkTl3jdGIFZueS4LyIb3lylZdhAzm0ELcsSzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9XZE0My9iPl8g7lkv6YbF1SMxOz+603e90bPb4dsgW+9EP3XX
	TQClyYE/M75D0tw5PvZroZOWtit8SfXl5Fkkxhfa9Uo5ZRQg1P0VBLse9+Lnuhg=
X-Google-Smtp-Source: AGHT+IGysHzpaI/D+IHLYDFtgbkl4iiw0+CnPgXwvIIR+LDXrAkqivGsmmQIUYkaxNsMKt0GYadSBA==
X-Received: by 2002:a17:907:72d6:b0:a80:788e:176c with SMTP id a640c23a62f3a-a89a35ceef6mr1707691766b.23.1725524653974;
        Thu, 05 Sep 2024 01:24:13 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c80sm102300366b.174.2024.09.05.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 01:24:13 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v4 3/8] iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
Date: Thu,  5 Sep 2024 11:23:57 +0300
Message-ID: <20240905082404.119022-4-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905082404.119022-1-aardelean@baylibre.com>
References: <20240905082404.119022-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change moves the logic for setting up SW mode (during probe) into it's
own function.

With the addition of some newer parts, the SW-mode part can get a little
more complicated.
So it's a bit better to have a separate function for this.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 5049e37f8393..b400c9b2519d 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -545,6 +545,29 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
+static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (!st->bops->sw_mode_config)
+		return 0;
+
+	st->sw_mode_en = device_property_present(st->dev, "adi,sw-mode");
+	if (!st->sw_mode_en)
+		return 0;
+
+	indio_dev->info = &ad7606_info_os_range_and_debug;
+
+	/* Scale of 0.076293 is only available in sw mode */
+	st->scale_avail = ad7616_sw_scale_avail;
+	st->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
+
+	/* After reset, in software mode, ±10 V is set by default */
+	memset32(st->range, 2, ARRAY_SIZE(st->range));
+
+	return st->bops->sw_mode_config(indio_dev);
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -617,23 +640,9 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	if (st->bops->sw_mode_config)
-		st->sw_mode_en = device_property_present(st->dev,
-							 "adi,sw-mode");
-
-	if (st->sw_mode_en) {
-		/* Scale of 0.076293 is only available in sw mode */
-		st->scale_avail = ad7616_sw_scale_avail;
-		st->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
-
-		/* After reset, in software mode, ±10 V is set by default */
-		memset32(st->range, 2, ARRAY_SIZE(st->range));
-		indio_dev->info = &ad7606_info_os_range_and_debug;
-
-		ret = st->bops->sw_mode_config(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = ad7606_sw_mode_setup(indio_dev);
+	if (ret)
+		return ret;
 
 	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 					  indio_dev->name,
-- 
2.46.0


