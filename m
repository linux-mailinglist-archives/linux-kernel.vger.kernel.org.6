Return-Path: <linux-kernel+bounces-429326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 614109E1CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4088EB27477
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF41E5701;
	Tue,  3 Dec 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z+2gqJEx"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42C1E570F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224424; cv=none; b=gOEUPdKo/wmvfU15/1eIx1lWOVq/RFwYkA7VVRLqkeG4LwqOrGp7LzPMtp4bGsVrzsD790JJHB+06foBaUGOUtISLnkfTYNj3qsvHKez8hi+OtAGkJM5sfhWaNf/Y4E4dAY+l5sQz1bIHcTquPvWTQsguajkri65YWWjfjc+HyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224424; c=relaxed/simple;
	bh=dJ66VqH1lPKbG1vJ5uyMkdnhCZK/cj9xWl8VrZo+eZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nx4hFSPB5XgXCI8B7bxfmN/IrPuq2Ser25hFo8a1+PNZuW+7wMF9DZPtlRHGuXSaderSBh7ro3/ZI1JwiOJTkKPaGab65DwtnU9GanVqk7oOEjOhZctvxmuo/xs4sFbyi2apzUnkDeC0PhthcaWVqNQDZT7NHiJENlbetyqEUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Z+2gqJEx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434aa222d96so66818265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224421; x=1733829221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGjJNxAUoLlbHeze5dKZ8rYLCdUS04mEhaX4QA4tgNs=;
        b=Z+2gqJExQdzuRiPv9DPdYMSZwZ5IdAbriIf91XWR916L8+vIxd4nR6+x5WeJtL9BuV
         bGQzsrLyFcBToFHCiOHVrC+16vXjoVi5XiodBOLM4KyEdUa7bujkBN2liLc9GjE3+Sh/
         NMER/kcmbuI17iMa32Pq4r0H+TI3Q1kEd3qFvU9YEB524KuuWy7VisMkdIGaof+t3FOi
         Qrp8o79MZu69kJ6XgUpamlAJqPWpcCwQxi7bgfS845vRXOD92ujjh41zbUULSNO3S7Et
         +7BDQnnQBXx4ZjWIUN4ABT6PeJrpyw9dg4QerBeYSZcFsCer9HWVnnQpRmnyya1/4VvK
         pC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224421; x=1733829221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGjJNxAUoLlbHeze5dKZ8rYLCdUS04mEhaX4QA4tgNs=;
        b=UNTUXA6UNsfPs2Rwoa+FXcW/PVSdYr4w1LHPVpuenWvFa6+eCZL4mM2CJPBtP1a3MS
         DAWG0+sSO4suXYUkMlp8uhFJbpB5MiwdXlL+YzSj5M7oypQSSRgrUIUrKvtz5iNoRAaL
         EXtGF403f7eDXDK8yqOJr4S0MGxkhbYk7vSFvvoWkQF8UUAuyEHlZ8qVgPmMA0E16BTc
         2pH9KvqI7+Ub0Il/kzMjSgXDTuXxz6NGsQJ/RUJFa6Tmen8k3pWxgwkFJWWUHZOknzsv
         Gl4K0DFqRbTxwb6R4dzpnZ2hA/7d4LZ+Uay7INxAGjBLnMyaswqOxuB9vL0MomsZSq29
         PM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFBVkJ9ZxNO3wmk8z9qKDQV0Mm4ObrngLHbNuJ3Sb0o7eyW8yJADavK37bXXttwTCYlhGpBBZWeVpfSo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznHF/6vFYTP5Cc4acUv1rlvj1KJEFpg2opbED0qtUq3jc/IV1Q
	rO4ihMy2nHEepQP825ZxcPHdmis+SWDkDZYf+Z+SJRuO//m1/YWshx8xCq0Lu1Y=
X-Gm-Gg: ASbGncu1prc5ezpee4tg4mdVJ3cQ02PkTXSR2AWaOs5PrchZwLXzUa4waUwVDwq1Wu0
	FNNTOAnPrHhzANDvgvbBSN/sHeFgDQwm1IJpUteEHqjTuoWLPvue8RHi4a/F9GW8V+y6uVmf8eO
	CAlkVkO8ucr0R0MjBMp++JbbpN3JALToqJXenQUE1XO2Oj5By6z8vSUR5s2vQ+DDBdjQCOlKOjU
	1pRJTR5FD9E3+7KYJBSGEQvbh5BP1Pbg7i3M2Yz1QaUOe56cnm3pTGlQpnDr1ozB6WS4TJ9p4tw
	5kz8
X-Google-Smtp-Source: AGHT+IE+s1yoVLBzbwgkBBIAjbk6p+3eCyfk26hAJKZF4jfFJbnwH4ZzJ60DDcfVvJaXNdjv9UMOjA==
X-Received: by 2002:a05:600c:138a:b0:434:a684:984 with SMTP id 5b1f17b1804b1-434d09b2f31mr20189215e9.4.1733224420880;
        Tue, 03 Dec 2024 03:13:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 06/14] iio: adc: rzg2l_adc: Simplify the locking scheme in rzg2l_adc_read_raw()
Date: Tue,  3 Dec 2024 13:13:06 +0200
Message-Id: <20241203111314.2420473-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Simplify the locking scheme in rzg2l_adc_read_raw() by saving the converted
value only if the rzg2l_adc_conversion() returns success. The approach
simplifies the addition of thermal sensor support (that will be done in the
next commits). The downside is that the ret variable need to be checked
twice.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 62932f9295b6..eed2944bd98d 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -227,14 +227,11 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&adc->lock);
 		ch = chan->channel & RZG2L_ADC_CHN_MASK;
 		ret = rzg2l_adc_conversion(indio_dev, adc, ch);
-		if (ret) {
-			mutex_unlock(&adc->lock);
-			return ret;
-		}
-		*val = adc->last_val[ch];
+		if (!ret)
+			*val = adc->last_val[ch];
 		mutex_unlock(&adc->lock);
 
-		return IIO_VAL_INT;
+		return ret ? ret : IIO_VAL_INT;
 
 	default:
 		return -EINVAL;
-- 
2.39.2


