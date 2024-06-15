Return-Path: <linux-kernel+bounces-215663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF99095A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A621F230A8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66207FC0B;
	Sat, 15 Jun 2024 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2ulF58M"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A096DDD2;
	Sat, 15 Jun 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417736; cv=none; b=tPATvPMv7kWcNpN6WA6d/zW/uttkpUsb/waCKIcTov6hCl9eRPoxb5ETzloqvKBHW/Cvu14/ve23bK65MFv3J9HJWJu7iP5JlMgi5fJd6FWwSDFBajZVakeJx4cuAARX9bdvwXyUPqcRedqL+ZIZ8fJc2QgHyQzWBfKS00JREQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417736; c=relaxed/simple;
	bh=fW4OnfxSC1huAXibwjVO49aWwP6kwWsg9vuNq1cMjKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQGMA6ASOUnbnBZpQNQesZ2fhiC70pY4E7BbwYx8OZvO1uXY+Ea7AOGQPl5f3Me5VtU4oFeW71MjclNDcfMIWlZw3DRCbUJdPZF6iI+WdRYAD8mBfgRf/sofH1Wgz9ij9YGsFb+TnzDpci5G7bP2X8X6u+ow8UhW81f8qaOpo5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2ulF58M; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7eb671a835fso167482739f.2;
        Fri, 14 Jun 2024 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718417734; x=1719022534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8cWoOmqxKfRTYz+fqWWX+hQL/rBm7CI/FqFLj5thyk=;
        b=F2ulF58M/pH4CvIFaeVQD82sz3pOaTZl/9lgsI0eZC87w5pafWg79A7gQ197acTNoq
         cMjaxK/gwefMBD+XPZxkeIyOZdk8LLjQlkecpYjNZWGP3gijjKFpeoRJkE7UTaBx9nNS
         5SdS6Ix0MBBpPOPXiahmObwjo1XJvqEnq7JAyLeqVzVXx7xuMe6UuhEFW7a/r/WjFLkj
         CJ+ezdhn975cJUElrypKV/4LGJCMOCecHZ/X7oEI9Nlob05a5Sz+swfXQeOrK3FuOMTF
         9Qr4Prdr42bAq2Ys3qcpYXu4f7Ft2+Oe0+DgDKB91HaEdSu6BBzq7RNl1s4BpLVUheVD
         45Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417734; x=1719022534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8cWoOmqxKfRTYz+fqWWX+hQL/rBm7CI/FqFLj5thyk=;
        b=kclcXAjWpYBn/IxcJIiJHMhMs3HKkOZQ2G7K5VzkD+Z63hJPx7NGRKwn9IT+NDIZ14
         02skcmgD5FoJw+y6qwOvg+Yyo8Wr/LSZv2gXamcqaInsWyGG+rF09XHywLviUxBm4774
         h3J1ixtzNV5/KuC8QQVeL03Zo+oP5b7msMJoN5mNe4zpEYE4OcmOTZ8QGbocyZwEbJGN
         gHqS/J0XmJy1oRYXyeONXcNf7gdSWdzJKbftKHUiNwNSdCfRdXvyD4mC3zZt3vgvi22I
         44Mnpee+ANiXG5i5qS41XOE5XffBvsA1e3TByeTnfjB6UA3LWYMB1oIA1kVmqbE568Ep
         lMzA==
X-Forwarded-Encrypted: i=1; AJvYcCWj+WRqujzUwWNCyIk7r0G0qlseQaw3b2Oi3HGDtdA+gAjsYUlijgXTm0QWC3oz2C3M+/gX/aSe5JDF6Jwcj7V0fgi6i2b9ztHI3Zt6SlH9F7RTIHEo4vj8JFCeJh/CShSPH7kJ52iCSQ==
X-Gm-Message-State: AOJu0YzDjFM5TsVkaEed6DOCZZsUXdl9OpVcOXl3x8fNZdTvSmr3x/YX
	xDJlfaxw0nmk+eZSB+iA2QoiZdQEr0dgIoXzo5EEvdDH6/Gutv7z
X-Google-Smtp-Source: AGHT+IEsxdDM+X77Oe5QUXk7TKdHtOzNf1PKhlMLCNfRyW9jVFxiwyhgXHeMc52hNowy8T+I2Z4zIQ==
X-Received: by 2002:a05:6e02:2163:b0:375:bece:db22 with SMTP id e9e14a558f8ab-375e0e12fa1mr49667905ab.7.1718417734297;
        Fri, 14 Jun 2024 19:15:34 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1c28:4b16:65cf:ef28:5753:2be4])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2acsm3717839b3a.124.2024.06.14.19.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 19:15:33 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: kanakshilledar111@protonmail.com,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND v4 2/2] dt-bindings: riscv: cpus: add ref to interrupt-controller
Date: Sat, 15 Jun 2024 07:45:04 +0530
Message-ID: <20240615021507.122035-3-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615021507.122035-1-kanakshilledar@gmail.com>
References: <20240615021507.122035-1-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

removed the redundant properties for interrupt-controller
and provide reference to the riscv,cpu-intc.yaml which defines
the interrupt-controller. making the properties for riscv
interrupt-controller at a central place.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
Changes in v4:
- Change DCO email to @gmail.com
Changes in v3:
- No change.
- Rolling out as RESEND.
Changes in v2:
- Fix warning of `type` is a required property during `make
dt_bindings_check`.
---
 .../devicetree/bindings/riscv/cpus.yaml       | 21 +------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..f1241e5e8753 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -102,26 +102,7 @@ properties:
 
   interrupt-controller:
     type: object
-    additionalProperties: false
-    description: Describes the CPU's local interrupt controller
-
-    properties:
-      '#interrupt-cells':
-        const: 1
-
-      compatible:
-        oneOf:
-          - items:
-              - const: andestech,cpu-intc
-              - const: riscv,cpu-intc
-          - const: riscv,cpu-intc
-
-      interrupt-controller: true
-
-    required:
-      - '#interrupt-cells'
-      - compatible
-      - interrupt-controller
+    $ref: /schemas/interrupt-controller/riscv,cpu-intc.yaml#
 
   cpu-idle-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-- 
2.45.2


