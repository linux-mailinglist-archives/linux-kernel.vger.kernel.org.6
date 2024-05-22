Return-Path: <linux-kernel+bounces-186398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E28CC3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162C72821B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E028E34;
	Wed, 22 May 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NoB6c9//"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0E1AACA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390172; cv=none; b=jp2AsEXIS0vNXeqi5SyEq87aC/h5QCPmMecXSwHi8MQEg9z4x9xbGJMcTn8lFKRtGBO8LXiaD1nNOkSgzHY1ft6z4ubxXv00rHNvlytPpxktt350uC9TSJHJIpeISVgFxrrBx9w0c5y7qI0dRfjrwPytpmvNqjOp2YQCzNRKzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390172; c=relaxed/simple;
	bh=4we0BntgDjersaBwZSM/3LAXtNM+Jj31lyXstVZv+Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KN9lSqVhBK1ah1GwvDKNIDnpf1ytx36e9nOEliN0xsIOqJw7nUCuKde+e7l5fQIFsZ2i+BHofLhe7QTvh5y6D+EtFJIo96AngNHqxeFG4oSr0jURqwymyENhL7P8rm0Fo6gAbWW4/NXGjiG47TBQliP1cZCRtP9ojRINXJwdKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NoB6c9//; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e6792ea67fso80953041fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716390169; x=1716994969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwxcKi7+xm82BPDKKU7Mvqu+uOCUtLvBD3WA1VqqvxI=;
        b=NoB6c9//ZXCMaYDfIXlEZ5xUW37Fl2vA9RHxaEjQk0GWEWNJpWtNTLVAf+iDJsEfmj
         +4GxwLmNUCCJfZ+GqmyRxOlnLj3W0bqf5uWTDmJ/qAFTGIKMy9qtlNy6NQYSuQKQz7sG
         UFY4JgzkHTGF6BtzvnJzr2kPmMv/jkLjLV53A7+Fw/mNfzSZ6ZSF5scYHjeH50tgQWGI
         ycTQeLvwirZDcd1N+e4/kss8rf7UPD3kdl1ApyJ9jeLwzvvr97tPtbiQZ/N1CtKADfq2
         po/sQaZg40XSsN+EWjBnOR0Vd/YdAQVgl1nxj8+BmylH/o/uWZORp7Shy3q0xVKlgOJb
         6eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716390169; x=1716994969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwxcKi7+xm82BPDKKU7Mvqu+uOCUtLvBD3WA1VqqvxI=;
        b=AugTZ9aCBKpZN3OyMvtTp8YbccLcwdedGu3cp2YpF76qpTDULb3HBtUc97LRLtV4z6
         hSxYsbSJofJQw7KzmI6FLS3iGAKCP0oo8vI8r2LvPw4FhUhEU5qPXQH4FaAYRRugifxs
         95uRO4JC4ivMzeXgNfE7xZUn0ij+enMb0dzs9zHtrujK0zb+9hxd9euSr7ItueSIoDRb
         EDvZ8UpH8TY5hMhJ6yWdsZpSKUdvKS5KP6h5WAiaHs2CeYbzzeB557w1LSIQh5e6Wj8a
         l4Y9B0+A52nWIykY6GT0VfUJd4Rn+RaUWQ1mL+eJgY+rKo0IcFg1/zh+WBFYDwcAJ6BD
         8+NA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+Udnx4G3bC1eyfFsFxnuuYQwAUxqPyCIeRFO0+XC7AFQFxRV5l7vFTiZcEVUXwBClCVQ4WeYFne/Nsjf4iLpo1XxNafJopO2Wg1k
X-Gm-Message-State: AOJu0YwhFrVggY21gaJiBtVr8dqIos5VKnwexDn3ArPgrMGZ6SCnnc0/
	OpILMHAGbXyA9rgzgA5RKge240nSkpdvVT1hdrlvYtMgEqkP+z2sBxwqDjWeYk0=
X-Google-Smtp-Source: AGHT+IG3WCmhuD7axwgUgN8Pr1g/pdtpLYUfSMpi46cHuDX05+j2SRu2u02TGF9GsDOzIRCKt5jPXA==
X-Received: by 2002:a2e:8404:0:b0:2df:c1e7:ab65 with SMTP id 38308e7fff4ca-2e949574737mr11287421fa.26.1716390169219;
        Wed, 22 May 2024 08:02:49 -0700 (PDT)
Received: from localhost.localdomain (host-79-16-6-145.retail.telecomitalia.it. [79.16.6.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm531370515e9.9.2024.05.22.08.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:02:48 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dt-bindings: iio: dac: fix ad3552r gain parameter names
Date: Wed, 22 May 2024 17:01:36 +0200
Message-ID: <20240522150141.1776196-2-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
In-Reply-To: <20240522150141.1776196-1-adureghello@baylibre.org>
References: <20240522150141.1776196-1-adureghello@baylibre.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

The adi,gain-scaling-p/n values are an inverted log2,
so initial naming was set correctly, but the driver uses just
adi,gain-scaling-p/n, and if fdt is created accordingly with
the fdt bindings documentation, driver fails the probe.

Observing that:
- the Linux driver is the only consumer,
- there are no upstreamed dts nodes related to ad3552r,

the fix to the documentation side is preferred and less-risk.

Fixes: b0a96c5f599e ("dt-bindings: iio: dac: Add adi,ad3552r.yaml")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes for v2:
- better explanation in the commit notes
---
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 8265d709094d..4e9f80445405 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -92,13 +92,13 @@ patternProperties:
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
 
@@ -107,8 +107,8 @@ patternProperties:
 
         required:
           - adi,gain-offset
-          - adi,gain-scaling-p-inv-log2
-          - adi,gain-scaling-n-inv-log2
+          - adi,gain-scaling-p
+          - adi,gain-scaling-n
           - adi,rfb-ohms
 
     required:
@@ -208,8 +208,8 @@ examples:
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


