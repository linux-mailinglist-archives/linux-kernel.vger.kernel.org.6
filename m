Return-Path: <linux-kernel+bounces-328324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73EA978214
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDCD1C23F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382351E0B65;
	Fri, 13 Sep 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qhrOy5Df"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E21E0085
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235881; cv=none; b=AwdzXkqfZyj0L9Qezm7DYc3yIlTITetx9iocuZIuRTEFYGmboOc/7sHrsTy/yJ1jsU4zGXijZY13iD4TT14qC1EZ04WVrgUjCtIGfxyszLNYxT+MqVIhcewy1zVlF+4THT1Bw4HYikjkMnsRXf11V9EpL0+WeyTzfdhPYgdhd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235881; c=relaxed/simple;
	bh=/ovmFlVD/7j+ipJY0VPXyzdNP1zhe/wqKiyGk4ajqgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEWOv+OLKDjDYZwFa8Dy6aiuEWH38P9rXb2Woc4SyWz9Ov+7KN97qjbvpJigvXW/TlIoc/93RCVNEtXR9AJDCS6KvGhTPz1bt9AQIDJpEYGyN3kMGFyvpFm4psIVPJTx80DdH/Z76U+vvPEij6J+yggFcYYzq7SH1+XPm0LqlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qhrOy5Df; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b9761eecso1729178f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726235878; x=1726840678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g46xgvcRuzluvD9uFfVgOC6tB6SvIHIhrOwQLDjP3Ko=;
        b=qhrOy5DftY8E5YlAyhsJr4ch+KnN7MHNJ6zvz0N+JXZeqZjRbqA9ePTgU+p0GC5Tls
         +iCY7CMLEi5TS+2lCt1+T3OwqP0sh9VosbxQAOOvyiPmGTTHmQTNBWyrbkfMt5yPldjh
         fSBk67Zpffkf/HgPUy3rrw1soGe6BW3VPRIsQ3fRYxZ/W+dJjezMd1CM5t13SXtlCZ8e
         5tnXBg/n5Ed+Q4v5w0NjINlIp+ajmXcoo1rFmo5EKnRZhAyskXlfh9k/31huzuZofA7d
         7kyecAgLh69fNOiNNHlq9rq9Ypwe7O9G7bxZtJlSJ5gsD/giKxtdO6E4YuWzPsgM/4ei
         TZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235878; x=1726840678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g46xgvcRuzluvD9uFfVgOC6tB6SvIHIhrOwQLDjP3Ko=;
        b=J888Kvo0Fh7wjWIb6FQxtAtTOHipIriL69zwZlqbW97ZsEeGFXmJlI1EahXvxFpUCX
         gTxGBdxDe4qnz5jn7NVAsWW23mPEwKz0TWZ+qIn59CpZlqGCoUinFaU5NjQO3SInNShF
         OlQ2MY2UPwJxfZ2ze/0YvyzFC7OyohJWjzGlT99l3Db8rrX7A9RRD2qH+TizIOANdcd4
         wP4oYSXR94J7hxKMFfyG8dqyuXQAlZMwdX/1eg3E9Kd4e0vzEGnzkPs0z0gK6LbCQrT2
         CyDi84r7CkVpxGiiYXZtAdannZSfsfrj6OjMfwXwdVwPxjCBxHG7VELaA2qakrdlA5rV
         EPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD9O8tCqBdnZVbKvD7EqAC+G58F4/eSZ1zlUDMwFKF1TuQKt4VDbhWQC59NcuJutk1Xs+WSAVCt1A8ZMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFl7Z1/Fhj1S3slkyF/ZCeE/tv8PdRma7CCEgUuvqy0FQO6Vu6
	WGOjQuk6gMTBjuW4en9HX1DsVeL4oDhqGqdyaUKPkKFY8tRAuQtUqTcpf3d4x2Q=
X-Google-Smtp-Source: AGHT+IFcysEod0NxncaxDd4SBio0xzbV0cHz5ucPvVZFdGqB2E7WOEJARnDjPv23bNoUkmOyAClF0w==
X-Received: by 2002:adf:ea8c:0:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-378c2cd3e6amr3985869f8f.8.1726235878002;
        Fri, 13 Sep 2024 06:57:58 -0700 (PDT)
Received: from neptune.lan ([188.27.129.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3941sm17104749f8f.84.2024.09.13.06.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:57:57 -0700 (PDT)
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
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 6/8] dt-bindings: iio: adc: document diff-channels corner case for some ADCs
Date: Fri, 13 Sep 2024 16:57:41 +0300
Message-ID: <20240913135744.152669-7-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913135744.152669-1-aardelean@baylibre.com>
References: <20240913135744.152669-1-aardelean@baylibre.com>
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


