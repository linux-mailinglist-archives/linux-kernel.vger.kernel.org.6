Return-Path: <linux-kernel+bounces-175881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D808C269B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F291F21BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9217085F;
	Fri, 10 May 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iFwnDgVD"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5391311B9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350761; cv=none; b=r/jjE/AVGKsn4zdlKiE7secOO+kGAxLmDQfOBeqGZYeXUlepF6ojakA1K/ZpPPdndAzI4I2gslAWcaGmbPvCMxpIKzbWa3Pbn5DjzgyJsMm84LZOR4EeHff/lQ+1d+UD/Rra9sO08sFexPZTxZikmJcLW8Vw+dS89SxflqEfB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350761; c=relaxed/simple;
	bh=i4G7aoZtuOLQ6v/EAbm/87VL6HJuAkCoK1F6wDmVAoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETtVLMrv4whgwtB8b60AksAfiuCh4y6fPHEYgCdLKo+GYvV2OUwD/M6AJVekdoPXaBrKyhnXtwrvBzsDPKzA1JM2Wn90lqS60BNzv9zH1MozczMCdi34krW9Hb8rcc6KaOz7EDvHBpyJG3whpi4ljPnLxHMs14XV10rPws0PNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iFwnDgVD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso29480321fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715350758; x=1715955558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygxOQC15SUv3c6gwY3JPpSRcLSnmMYCDwnNrBTw5+2g=;
        b=iFwnDgVDMpE5HBR8sOAoQ76o7hp7BSvjOms/HGF2HJnJvHhi5AOLEqSKQYxUNbsfnJ
         C3iCuFyKktF45RLOTC7odHlEdBKuNc6pGYjU8El7Z6h901A9gTgeizRp+MdzVZ9Jk+BG
         j1UsYkuCuh7rvr9TxvV+N3AkpW5A736Y/LQq4nS6TwiNawXQ/N2/+KOU7o39ibEWpaM+
         BHplazxLWcyPuZC7Ty6nhrBF1iFaP7J0KrR1NM56PduTxJLc0H0MoRhFnn4A0LsagJc9
         zs8wQg6W0xnO+8mU66pcY22KHVZbZxr4SePjJiHCYXZdH8X6t76gKvCpJNzfdY2PHp7v
         08lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350758; x=1715955558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygxOQC15SUv3c6gwY3JPpSRcLSnmMYCDwnNrBTw5+2g=;
        b=YU7hYcfP7wO7Z0/L6Wgdy7s3/BJa45tNUbfnNgJjH+u2WtsxDPMSHZ2ayojqZrZ/2A
         VxTgOybh3Dlyze8O9fxX3ewboiPUvQx6gyvnOeA2RFnpjRrQJeZYbuHspkeuyvzC94t5
         N+pEMoxkMP/WtTDbCxCHWkCtu7ynoOA57aVEoqNryKuHL5pYpGaSjdmhPwDoZJ0LuZfn
         0SKBCeh3jANjx4YdjEp5DjT4HroUjtwYN3hIYGMTAlc88IXArTCWSWmbFjMTiz+m1IsY
         MydSrBnCwnRlLpKf32lq7dl/FjjDy9P693/83rjiHwJeHYKmJTPr/0ulwyfTf9FD9V9I
         A9mg==
X-Forwarded-Encrypted: i=1; AJvYcCWqynG8vvrJeRttG3Duz/grkxnbiKsN5QbNAdr+3F52P+Szih/Xi0mfMu7UkBtPZv2sXWEL0egZeGB7ggVF9yfBTmquKs4loXkxKmT8
X-Gm-Message-State: AOJu0YxRu8myIACWK0Aap4jk3nNBk4j/VOue0qnBaZ1cXDLKy5ykNbCb
	XemxFv7+hiNFxTBo0hvNmPaVtfNBxQz+dHADedmIwvXT76nDYyu9XTtUcLge3Wo=
X-Google-Smtp-Source: AGHT+IFaPZglaNJ8HKYesz9qBPTuNdjcWZFbOKI1g7KqEHhS5dnFETMdXxI9xWKnlCo8gdgjLKGLtw==
X-Received: by 2002:a2e:b16e:0:b0:2e2:1e87:bbc7 with SMTP id 38308e7fff4ca-2e51fe53fbcmr17337851fa.18.1715350758289;
        Fri, 10 May 2024 07:19:18 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-39-74.retail.telecomitalia.it. [79.47.39.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd97e842csm56111875e9.24.2024.05.10.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:19:17 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH 3/3] dt-bindings: iio: dac: fix ad3552r gain parameter names
Date: Fri, 10 May 2024 16:18:36 +0200
Message-ID: <20240510141836.1624009-3-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
In-Reply-To: <20240510141836.1624009-1-adureghello@baylibre.org>
References: <20240510141836.1624009-1-adureghello@baylibre.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

The adi,gain-scaling-p/n values are an inverted log2,
so initial naiming was set correct, but the driver uses just
adi,gain-scaling-p/n, so uniforming documentation, that seems
a less-risk fix for future rebases, and still conformant to datasheet.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 17442cdfbe27..9e3dbf890bfa 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -94,13 +94,13 @@ patternProperties:
             maximum: 511
             minimum: -511
 
-          adi,gain-scaling-p-inv-log2:
-            description: GainP = 1 / ( 2 ^ adi,gain-scaling-p-inv-log2)
+          adi,gain-scaling-p:
+            description: GainP = 1 / ( 2 ^ adi,gain-scaling-p)
             $ref: /schemas/types.yaml#/definitions/uint32
             enum: [0, 1, 2, 3]
 
-          adi,gain-scaling-n-inv-log2:
-            description: GainN = 1 / ( 2 ^ adi,gain-scaling-n-inv-log2)
+          adi,gain-scaling-n:
+            description: GainN = 1 / ( 2 ^ adi,gain-scaling-n)
             $ref: /schemas/types.yaml#/definitions/uint32
             enum: [0, 1, 2, 3]
 
@@ -109,8 +109,8 @@ patternProperties:
 
         required:
           - adi,gain-offset
-          - adi,gain-scaling-p-inv-log2
-          - adi,gain-scaling-n-inv-log2
+          - adi,gain-scaling-p
+          - adi,gain-scaling-n
           - adi,rfb-ohms
 
     required:
@@ -214,8 +214,8 @@ examples:
                 reg = <1>;
                 custom-output-range-config {
                     adi,gain-offset = <5>;
-                    adi,gain-scaling-p-inv-log2 = <1>;
-                    adi,gain-scaling-n-inv-log2 = <2>;
+                    adi,gain-scaling-p = <1>;
+                    adi,gain-scaling-n = <2>;
                     adi,rfb-ohms = <1>;
                 };
             };
-- 
2.45.0.rc1


