Return-Path: <linux-kernel+bounces-311101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2849684E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DC71F23744
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6D1D175E;
	Mon,  2 Sep 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XeNMGh6k"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E11865F7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273427; cv=none; b=Iu3qdVeniCaZz/4+ZyRFkOCYCeyGF3o8oD0hMHjpOImj6ZeFhC2VLeTyG2NnOBrJxT/e86en8/wepUSWbbSi0LhPNHhoKj++lFSc/MCYkvsv5DHkoAVBrPJa9e7dcAg/I+s18rNe/fg9OD9IA1D0ho1IbiDGvv+B24sKc+W8E3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273427; c=relaxed/simple;
	bh=0B4OtPaPq3djfnjasTB0YK8oEPN0Criv7QLDnmRZ0RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuEac5D36c1u4ej6twCE1RkS1mgtyO+c0M0mjZju0vMl1uIkAVKemaKKIEP6yXqGz9OtFglqXzel1PvgPCbUqJym5csNsA/R1+jDQ1jDmc86Izrz7SXOlPFmxZKo+CJVMQoMilML3q2frH8GH7zYuGmmQX+2lAMxaw1qNmtoAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XeNMGh6k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c84dcc64so795932f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725273424; x=1725878224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/kzmA5I23xNWWAz1AzWxwFHc2DJG5+/Mnn/xB7FK5c=;
        b=XeNMGh6kKOKCiPplTwWMmXd0+k87CTnwEirR5NKx5f1ZvQn6uSIHWIhfVRkakQoLCC
         qTUPdymix1cbfm6ykPxFYAA5YBINw4WwgpIjrgFbzrERaxq5X4+h+kJNNyf06AiJsDQz
         PlDQTe87127K8Cmt1td5qGDwBCc9dsJGlR7EVk7kDqcuRfOMHGT4tOUFEfLE2NkmU/vw
         as++E7J5qKQ81sJZ6dA1OX9ZtancMmGVnHLQB4UU5FbDIijyd6aMwuMPCUssWDrSu/rL
         zfpPaMNGOZGSBKFeARcQDfYB+vyFcbqXjRvY36do3+qFJJBjmkFU5aKLg/GYtoG2JMfD
         0BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273424; x=1725878224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/kzmA5I23xNWWAz1AzWxwFHc2DJG5+/Mnn/xB7FK5c=;
        b=H3FPwBhnQ5lBT2kF0LLywcBoi3mkr5CHd55L8gV+aCn5zhlaJ3xcua7QMDNoU8js32
         2q7r1XT+utEojtAiGXr+JcFP3iL76mfdAyPzPEbDBU3dtHv5fz3VCxsw0MELUeZyVoy2
         20EQ4g0kBEflqgMfeOJFx4SOlQd0Xi4VOt+ORQNvuo9ZeMlmh0dQsl9EM/BwcxXzAPqW
         fUcGiTF0fQ23LiCMe3TJ9CH4LioWyws5YbODo7f8iPLxkSH1e49X2aZYCc+rESDQLtB+
         1QMlsj0bq08SXA0MdIJUEd44NQoilAt2GC7Hal1TZKSbwaA3xjtFmxKfIFAto/hXaXYH
         cq9w==
X-Forwarded-Encrypted: i=1; AJvYcCXOgC9tGBUIF/LC3rYOzVOpDBlvgXcY7Xcans3V5MoD1eBCRGddUpU3tREkw4areAnKXInWllEHCfwrTIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhEHQb9l3dVBLte0/rQU7N3JHs9EqGNjkk0J2TG94UW3fqz4C
	q58SU28pkcBCXf1gaRomnjt1Mk00Bp4qj420A6lmFaf95/SPrFe3CAlhPftHzt8=
X-Google-Smtp-Source: AGHT+IEBx7IVtTTuLOdUKgwPX+nVjMSPPmQhbounNSfyRo5Pfedonxjb2TvP24fJ6LlPPgr/vZcWww==
X-Received: by 2002:a5d:6485:0:b0:374:d254:61b3 with SMTP id ffacd0b85a97d-374d2546231mr130281f8f.14.1725273423868;
        Mon, 02 Sep 2024 03:37:03 -0700 (PDT)
Received: from neptune.local ([2a02:2f0e:3004:6100:e124:ce40:67a4:fcf0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891da22bsm540876766b.182.2024.09.02.03.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:37:03 -0700 (PDT)
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
Subject: [PATCH v2 6/8] dt-bindings: iio: adc: document diff-channels corner case for some ADCs
Date: Mon,  2 Sep 2024 13:36:29 +0300
Message-ID: <20240902103638.686039-7-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902103638.686039-1-aardelean@baylibre.com>
References: <20240902103638.686039-1-aardelean@baylibre.com>
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

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 8e7835cf36fd..9b7a8e149639 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -37,6 +37,10 @@ properties:
       to both the positive and negative inputs of a differential ADC.
       The first value specifies the positive input pin, the second
       specifies the negative input pin.
+      There are also some ADCs, where the differential channel has dedicated
+      positive and negative inputs which can be used to measure differential
+      voltage levels. For those setups, this property can be configured with
+      the the 'reg' property (i.e. diff-channels = <reg reg>).
 
   single-channel:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.46.0


