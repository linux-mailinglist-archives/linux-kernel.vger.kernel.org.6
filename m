Return-Path: <linux-kernel+bounces-374400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DE9A69DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67ABFB2A7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F231FAC49;
	Mon, 21 Oct 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ib65VqwW"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226971FA252
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515773; cv=none; b=ay+xF9rd6QlLof+sa02eVxKqE2AoX2c2XklB6K2/SNN7CRxMspXuXbdg34orPB2UTkmWmz+RztshY5l4Bqdgkspkw34SNPNTx5KkeqxorF/VvjOgPckxtZBWdYm8q4OL31+2S3FCtXUBPmOkGLr+1AQbCzUYv798AlqIkJtO7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515773; c=relaxed/simple;
	bh=UPblkw53lzncb25Tu6KKdBbVcH1Rxwx9uYPtlL0G030=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rErUfzgqEsKIyQzQjdW7CYv020Tjr+Kc6TpmRuW/mnLuBARpWojQCxbcK/fa64AAvCmLJv9RXd+CCmFrRIm5Pj3b44eX/Lmg8yR0bnjacGFr8uj1K+NhO8Wln+l2ojx+bc7a3/i7re9//j0pYIJWT97iqt4K9LnjFVbuBLOzpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ib65VqwW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a68480164so396444166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729515768; x=1730120568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlAIxOTbWyu2Rw7zFdBhuqCcECL8XcGJhiWh79pHgY4=;
        b=Ib65VqwWhCfahPoeuUMnvJBEgUrCcRGpsda7aK5Wip9HTfJnI8UFYiW5XM2Y3zK5Th
         TxolhR4DZHWBQsGEsrJI+ARTDPStn7zcIDacA76by+PJnJit8FjCbMW5ioTXXeA7SrWm
         A3Uwu/UytPH21G5W65LzOu+o9sF2qsVbjVpiuWWV5aigozGVO6W4cEiyp9obIsRuTIjD
         xOUcrr/svk0tbdmlkI193awt1qi1YuzsXhCMVim7aw4Esfru83IT+ykXpgirD9js08Ex
         WlDq0ssjQVU/ARwLMvwM6w/o7wj1p+2QsGRPDFkv703HVEjoJoyu4GC/qvPTgFFYLeTA
         TDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515768; x=1730120568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlAIxOTbWyu2Rw7zFdBhuqCcECL8XcGJhiWh79pHgY4=;
        b=e7sJaUSmYV70RgvRZHkX6IL9xyIFuBhNK+e5H51uH7oZeJWpnHrpUSKp/sBEtI8jCM
         e13bp4cAqhE12bLPwroqOhRuEcXjFplxUbrVkDsnQpNn9oE2GaQuP47VNPz+IlvdNugC
         oqSKqPBJ+acfKZ02uIoeDaS8hISUvoKFKEnSV8X+mm6yZeELmoiwgFLMRHhKkyxdl+IZ
         le9WPuzQYa6NUAxIaCkSTBkaGVGnBu7MSvx1vN6fSx99014tIGbbEkncNC+C0NqDMUa2
         N4Ad/runMP0/v2Ake9s/651s8+HtZT6Wpbe40BwE8N1iSFCTkdyKEzEuxb6vQB4BvkRH
         FqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhKiSJz/KFLNJIoCEUOGQIH8ysEcBZfPAuaFH+JV2+Jxp3De3avv/jB4vOHY7DSBwXE31KxYKstoFFtJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUImnS0x+4847ZC+x+v6snY4p0eXkqVxgbZnTJfu8mtQTf3xC7
	WIr3sXUmN6Kiox5Nf7DWBSVsf0YYMxyHDxO0tcRG9U0Xkqp9NtohCSDWrbEVv3M=
X-Google-Smtp-Source: AGHT+IGTninUCYxKIMVO802oyPqqPEoBY089f3BVRWcxEG3HcKrxFvhS9FtKlcj/b3xJ0iBTgZY86A==
X-Received: by 2002:a17:907:6e90:b0:a99:f1aa:a71f with SMTP id a640c23a62f3a-a9a69a671a8mr1157254966b.11.1729515768318;
        Mon, 21 Oct 2024 06:02:48 -0700 (PDT)
Received: from neptune.lan ([188.27.132.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e33sm202310366b.120.2024.10.21.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:47 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 5/6] dt-bindings: iio: adc: adi,ad7606: document AD760{7,8,9} parts
Date: Mon, 21 Oct 2024 16:02:20 +0300
Message-ID: <20241021130221.1469099-6-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021130221.1469099-1-aardelean@baylibre.com>
References: <20241021130221.1469099-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds the AD7607, AD7608 & AD7609 parts to the binding doc of
the ad7606 driver.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 0a612844029a..ab5881d0d017 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -16,6 +16,9 @@ description: |
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7607.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7608.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7609.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
 
 properties:
@@ -28,6 +31,9 @@ properties:
       - adi,ad7606b
       - adi,ad7606c-16
       - adi,ad7606c-18
+      - adi,ad7607
+      - adi,ad7608
+      - adi,ad7609
       - adi,ad7616
 
   reg:
@@ -250,6 +256,9 @@ allOf:
               - adi,ad7606-4
               - adi,ad7606-6
               - adi,ad7606-8
+              - adi,ad7607
+              - adi,ad7608
+              - adi,ad7609
     then:
       properties:
         adi,sw-mode: false
-- 
2.46.1


