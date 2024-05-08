Return-Path: <linux-kernel+bounces-173604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A428C02C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4CAB24639
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92BA12B14B;
	Wed,  8 May 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="bF31rzb+"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D819128829
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188456; cv=none; b=aWL3cIxTgo2x/DyaQk8tycU5N6VIVIYRYq4sH9B0M17CPAoKjCb3QUDiuFQM8ny59grfHFC7hjwbjI7SWw8rmSFSR9PEjV4u/5LoF+DblP+ClCVpPBqqFJQloyTBIfQSmRK1MvBfY9e9PVrt1LVAqHGA3RuAlEV9yjUd19fNK8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188456; c=relaxed/simple;
	bh=IYjtQTAzRs1RtcfgocV5XwZyEpEUX5EMrwnW6fF/sao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKbMv9QyuoTFCKYW4ubfpE2ud9ezd92ou6ogtUdG8KKgKUYtxbvN0bvb+HVkbil1jW2VazF61zV0tkzxY7O3dUKbcJIraA2tFpwcKr0Ps0Fw5isPV6z9ZeiZZt5ZHEI+EpThy0Tc7rHyAcpU2+niRteqfzONyeEeXPzt9wnd5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=bF31rzb+; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 205C32C01BD;
	Thu,  9 May 2024 05:05:48 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1715187948;
	bh=DVXNJSLG09bJ3kApB+BghaNalIu/DwTPBx5KTlb7z1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bF31rzb+lLKjwch6xGOI+cXGf277+pQIdUdqeBl92K1WNnZSoY6SZylqtLW4M13gW
	 7TRfFLPSIcvaONEKZdiF0yEq9Z3+qkCZNwbhMJ4C17Fw6VjYHGWAtYCSccsAvX+Abe
	 YLb/ATVslQbeqyqECpUTwY0VYcNqEtjLwsJAeO/5EHD+oUn3Ey8v44ckaySxyfNRs+
	 ytPjxytiaNXPw7WuIGlAiQ/sUKtJDVK74zp9fO1ciHprfaC4Yd4ESnpGO4uU1or0/o
	 oDjR+ttfI54PSOVA+Bda32htvJZTMsZsgnAs637eJrfu9ZaXSv3LboS5iDarT03BgZ
	 mJ0Iu2FCkJueQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B663bb0eb0001>; Thu, 09 May 2024 05:05:47 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id C7F1213EE52;
	Thu,  9 May 2024 05:05:47 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id C3A97280461; Thu,  9 May 2024 05:05:47 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] dt-bindings: hwmon: Document adt7475 PWM initial duty cycle
Date: Thu,  9 May 2024 05:05:42 +1200
Message-ID: <20240508170544.263059-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240508170544.263059-1-chris.packham@alliedtelesis.co.nz>
References: <20240508170544.263059-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=MfrPuI/f c=1 sm=1 tr=0 ts=663bb0eb a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=asi1NR3yGO4WnsI8QEMA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add documentation for the pwm-initial-duty-cycle and
pwm-initial-frequency properties. These allow the starting state of the
PWM outputs to be set to cater for hardware designs where undesirable
amounts of noise is created by the default hardware state.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/hwmon/adt7475.yaml    | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 051c976ab711..3de300c9da2a 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -51,6 +51,29 @@ properties:
       enum: [0, 1]
       default: 1
=20
+  adi,pwm-initial-duty-cycle:
+    description: |
+      Configures the initial duty cycle for the PWM outputs. The hardwar=
e
+      default is 100% but this may cause unwanted fan noise at startup. =
Set
+      this to a value from 0 (0% duty cycle) to 255 (100% duty cycle).
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 3
+    items:
+      minimum: 0
+      maximum: 255
+      default: 255
+
+  adi,pwm-initial-frequency:
+    description: |
+      Configures the initial frequency for the PWM outputs.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 3
+    items:
+      enum: [11, 14, 22, 29, 35, 44, 58, 88, 22500]
+      default: 35
+
 patternProperties:
   "^adi,bypass-attenuator-in[0-4]$":
     description: |
@@ -80,7 +103,6 @@ patternProperties:
       - therm#
       - smbalert#
       - gpio
-
 required:
   - compatible
   - reg
@@ -99,6 +121,8 @@ examples:
         adi,bypass-attenuator-in0 =3D <1>;
         adi,bypass-attenuator-in1 =3D <0>;
         adi,pwm-active-state =3D <1 0 1>;
+        adi,pwm-initial-duty-cycle =3D <128 0 128>;
+        adi,pwm-initial-frequency =3D <22500 0 22500>;
         adi,pin10-function =3D "smbalert#";
         adi,pin14-function =3D "tach4";
       };
--=20
2.43.2


