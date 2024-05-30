Return-Path: <linux-kernel+bounces-196100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504998D5755
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61DE1F2831B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CEAD23;
	Fri, 31 May 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlMBShFU"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8E139E;
	Fri, 31 May 2024 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116425; cv=none; b=jYHZmHvLYJbKukH15fHpvbX27o/WKPz8eTnjEYaqmgE6oM5SIWSWYuz7Bikgco7gW36wcHXnU6PpZ/tBEUoBPsLoNtwiqGAvjNSE6Jz9FkPSSn0L5cczmwZbMqPUZ+YB+FYCi5kNa9ZVw0HSv4iy6hfjWUTTnwskmJMo0IZ8fZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116425; c=relaxed/simple;
	bh=iX/tDINZz5UIPO4LPUFuE7Cb7W+tkAqclCUmcd1ITu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgYrhF8fodTeJYEa4sxYJN8DQ4oL0B2Ug9oWzQvQ/8EMd5VVdr+k9fyAhzqG0i2/Y/U9MbbDzZMX5TrQxBdytShMxSAh90yL5piQmcuZTVTCyc0T8EGiLXOQB8jCFD4esNaysxN9a03f0xxfGS4WkOwqPYd41zzt43gr7ThfXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlMBShFU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35dd0c06577so397536f8f.2;
        Thu, 30 May 2024 17:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717116421; x=1717721221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU2+lUAyM4fchRPEQz+ovlM7n913qoXni595PPcQokA=;
        b=DlMBShFUUm8NWiqQ6JvVXrvzuBab+UY/qwejk3SJYTVpAevJ6XtiBRFlUxDkE90gFE
         w4icuVeba8bp6EsyonLC9rh1BBNtbpuQOuNCHlsSI+CZVkAqGmyFdoNGoKllg6M1Fn0i
         fwYdpt38rdl4O+YscyuQLLpGA+Ytk2q/y/yLtXFF6uXrdW/1sXp8ln+3qU8o4KnoCwj/
         AXkh31ROGVjYnH+CymbtpYDCaMC4E8QurZcW9vV0/DL8FxQcGxGuYmy1y191dFD3//2b
         vT1te9N2fHi0JgDwYu+yFTamC0noEzM5gmphdCASRH/SEg+ySC7RQdQDnXlfkxY/dxmm
         XAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717116421; x=1717721221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU2+lUAyM4fchRPEQz+ovlM7n913qoXni595PPcQokA=;
        b=FibDFVuFRguVmXhheEAlGMN6rrcs0I51dHbgiXY5pv9PBowcW0rWQl/fKi4gMHBFA/
         XL8OdJeN6T3bk4H7ylMD1xG25p1E7b+ifgk2do91gpnqV7178r4HoG8S+dF9nO48UpxM
         Y2iRuQTRLaXPbJkAYnzTR2tBoCSGBVGDkqLhbIaUwGpe3RF3ME6dcdt895Qk5f2h/Non
         RrFO2IFA8duMg4zPGpRnFrvP7BN7zAWYCf3TOUUybEfUem0DZWv++zpnsgAqqcf1l2tg
         K15axDnxRqyZoVZA+hs37QI8TxOT3EcOMqVg3xD6sKiLgeoHltTICg7WzzWq9gM3vuMV
         bZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJeCQSPo7l6IHMzy1Fv93dbdSaOfCRdWffVUAQ/+jGPXa2HU8OCsElzuBRVwUyNODfunsHB4+0k8gojeGwuAL/FgCeq/3d5yb7HQemJDnhNkUcRg/MppV/HT1eLIQn8Oy1S/HNx/gmYOMNGiH/6IibcVh2+ym2SrWq69m6DSeo983TP4eT
X-Gm-Message-State: AOJu0YzyMK9RSRVXC4NJr5R+hzZHallXNV8Lj95gSzaqxyjXez9vbFzb
	EZAKBSRXYuEBLi+QI32+CJrlJPspk6PQ9fgy9qFG3yUDnRx2zxHg
X-Google-Smtp-Source: AGHT+IFewALL9OsKtGkNGfa2N35M08MHHbImLxcCgoUDZU4D3lT9578krwPTylXFq+eqTI1Hb3yQFg==
X-Received: by 2002:adf:e9c7:0:b0:35d:bfac:1aae with SMTP id ffacd0b85a97d-35e0f25e049mr148818f8f.12.1717116420916;
        Thu, 30 May 2024 17:47:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c0e84sm608486f8f.13.2024.05.30.17.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 17:47:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: hwmon: g76x: Add support for g761
Date: Thu, 30 May 2024 23:16:51 +0200
Message-ID: <20240530211654.7946-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530211654.7946-1-ansuelsmth@gmail.com>
References: <20240530211654.7946-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for g761 PWM Fan controller. This is an exact copy of g763
with the difference that it does also support an internal clock
oscillator.

With clocks property not defined, the internal clock oscillator is used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes v3:
- Add Reviewed-by tag
Changes v2:
- Drop internal-clock property

 .../devicetree/bindings/hwmon/gmt,g762.yaml   | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
index 8c179cbbc65c..a2b1557684da 100644
--- a/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
+++ b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
@@ -4,13 +4,17 @@
 $id: http://devicetree.org/schemas/hwmon/gmt,g762.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: GMT G762/G763 PWM Fan controller
+title: GMT G761/G762/G763 PWM Fan controller
 
 maintainers:
   - Christian Marangi <ansuelsmth@gmail.com>
 
 description: |
-  GMT G762/G763 PWM Fan controller.
+  GMT G761/G762/G763 PWM Fan controller.
+
+  G761 supports an internal-clock hence the clocks property is optional.
+  If not defined, internal-clock will be used. (31KHz is the clock of
+  the internal crystal oscillator)
 
   If an optional property is not set in DT, then current value is kept
   unmodified (e.g. bootloader installed value).
@@ -22,6 +26,7 @@ description: |
 properties:
   compatible:
     enum:
+      - gmt,g761
       - gmt,g762
       - gmt,g763
 
@@ -51,7 +56,17 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - gmt,g762
+          - gmt,g763
+then:
+  required:
+    - clocks
 
 additionalProperties: false
 
@@ -80,4 +95,12 @@ examples:
             fan_startv = <1>;
             pwm_polarity = <0>;
         };
+
+        g761@1e {
+            compatible = "gmt,g761";
+            reg = <0x1e>;
+            fan_gear_mode = <0>;
+            fan_startv = <1>;
+            pwm_polarity = <0>;
+        };
     };
-- 
2.43.0


