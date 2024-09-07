Return-Path: <linux-kernel+bounces-319680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D38970077
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD011C20B54
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E324715A4AF;
	Sat,  7 Sep 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I6b01P3v"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F951586DB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725691864; cv=none; b=d4zqsOVEvh8iqhXhmfWIzg3zFWmi81Ym6DypVMPLX8nNXnxznL3qIcbiuFDyGSEFosOp7FND6iyg9M3IZLT11JKXF+j/wge7DmWVjAvcPDdnMqtzp1bbGQheTqRpx9wD4Q3Ua3VT55WkzCZ77rhW8ViZS5P0wx+vpKLYbZpPTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725691864; c=relaxed/simple;
	bh=/ovmFlVD/7j+ipJY0VPXyzdNP1zhe/wqKiyGk4ajqgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZL7PX/ybGnY4F3XuRh0W+pKnkpWor1bSRXSoqglUd5XskQKcOT0oNWbPE7esZ8VJpmSQ2ZpzUnpdJ7fXhIsPnvF52I/YGfvDcTZE8Q+6MvzW3CD31tAjwuTeZ/3c2Ef9tSwUtYa5wA5El61LMU4i4xSBmQ8LMjTHWsNxCam+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I6b01P3v; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a89c8db505bso368937766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 23:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725691861; x=1726296661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g46xgvcRuzluvD9uFfVgOC6tB6SvIHIhrOwQLDjP3Ko=;
        b=I6b01P3vzUUiezNXDvPSKQHqpy6Vt8MZI65nq7QSzu1c95LiQQ1074KyboKxOfe3d4
         ZRSc6YubFTd62WL0eS4ADryiILiWz+MxZlgDwzbDcNOWmkaDmr0xE7xqH5ZnrEgZV1OZ
         LT9LcG+ugggdjMR9cUWcl4U3dAbD3Thd/TU6bI3oRPR84MY/VMGRZP9MP5Ft3WcX3bHV
         oMgMSAOh10kynlbsF6uCVwcL3DC8X86OrPjezva++ib0Yo2501klhxVAljzwx2+oUel/
         0XKdjG7xgzBNlLvhaPFdNyzzyMJe70eIUM+PVvRAAGTXfcgXWqSKUs3S5hEPgsGzyy65
         I4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725691861; x=1726296661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g46xgvcRuzluvD9uFfVgOC6tB6SvIHIhrOwQLDjP3Ko=;
        b=RB4xmY5RjQ/FOPfMjIP+r5fNMXN36eThkd1HOC+txe2F+8FhxOmSRR/Q4h3OnqKBdi
         DEEyRZxL+Uipo+SMIcpG5eN0pQJn7pSAddeRvNaJiRuTQOkg3vppPhDSYXBRkw1ZV1ZX
         Sxu7cQmIxrTxXwNdl9D59sghm9RYmxKPwfdnPfhUbuDifg7SFYldxPxWMELk/BwGDML2
         VzjoJHH7osxoDqK93h78jnL6j27yaEL5I79WyHE6xIp/O3B4DTGYMJbkCfw6Szg1yYNl
         dSMthk10asmkB2nHGHO92zOw46LG8C0EN6tpx0Ggud2rCIpRYeGTRk+3wLh+yQZ5XAhe
         AH0g==
X-Forwarded-Encrypted: i=1; AJvYcCXmXwbP9Pzo9L9+UR+PqfXuMWit5Qp9Oh6OUZ7wSwR+GI+JE+ZzMnpsMK3YIk2qwoUUMdjoSpENmkUmwVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQ/i8SJMOIr6ZhXmUElRU6VWpy7KsHjlySuntuwik1esOZYym
	Fur9C8pdI6MN2QvDV2YGuYoLf+ZWHLhivDmxKjCpn034jw7d+nkyIl6NIao5VF4=
X-Google-Smtp-Source: AGHT+IF/D/Hkio2fyON8uWC4iTvVwDxSzhUtXtMuIcBtWjFH5BJ3N39nUeLSDxpP7WsrXEs9UeSfWA==
X-Received: by 2002:a17:907:3d8b:b0:a7a:ba59:3164 with SMTP id a640c23a62f3a-a8a888e9c21mr347077966b.53.1725691860868;
        Fri, 06 Sep 2024 23:51:00 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835a76sm36539266b.39.2024.09.06.23.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 23:51:00 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 7/9] dt-bindings: iio: adc: document diff-channels corner case for some ADCs
Date: Sat,  7 Sep 2024 09:50:40 +0300
Message-ID: <20240907065043.771364-8-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907065043.771364-1-aardelean@baylibre.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ADCs have channels with negative and positive inputs, which can be
used to measure differential voltage levels. These inputs/pins are
dedicated (to the given channel) and cannot be muxed as with other ADCs.

For those types of setups, the 'diff-channels' property can be specified to
be used with the channel number (or reg property) for both negative and
positive inputs/pins.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 8e7835cf36fd..b9bc02b5b07a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -37,6 +37,10 @@ properties:
       to both the positive and negative inputs of a differential ADC.
       The first value specifies the positive input pin, the second
       specifies the negative input pin.
+      There are also some ADCs, where the differential channel has dedicated
+      positive and negative inputs which can be used to measure differential
+      voltage levels. For those setups, this property can be configured with
+      the 'reg' property for both inputs (i.e. diff-channels = <reg reg>).
 
   single-channel:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.46.0


