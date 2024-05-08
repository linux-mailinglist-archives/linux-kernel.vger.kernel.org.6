Return-Path: <linux-kernel+bounces-173863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B88C06A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466C42842EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577013281F;
	Wed,  8 May 2024 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PgR+e4/5"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF51327E5
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205312; cv=none; b=EGchkduu/AgbKFIpkE9n2LLjB0RkBFJwbg0hBq6YemkQ51E/zaz2v4Yi4jhA4EIRUVdI8rqsRJIhMFLUk+3bDEESpcmH/Xj/3evYTLCZKmqAkQutRADQ5yTmr6SDYG2MTZJRFLQxevuTSPXVSWUNJ/wBGHqJAco14sYqPyUome0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205312; c=relaxed/simple;
	bh=+Oi5/pkEb5C9ViLsQk+n14AHWaXszItZEDYy2HvcGgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q746WoGwI/BCEp+L/e6wnhy2pcWmf1dWlv6regubCiaP8QK+Z22Y7vZdPeSGhOBmmvP8Q609heRpO5aSfR8EyhUXXtLS0OovnsX76xN5VPRKd+wX58UNxAMh7+HV5/KfmpDD3KRwE8NThHhTUsMGevMjJzn8h7m6uMoFaLONyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=PgR+e4/5; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 966AD2C0240;
	Thu,  9 May 2024 09:55:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1715205306;
	bh=18xR6vx071DV/4+BzeCizlj4ZJRQ42wdjPtjtFwTFIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgR+e4/5ZptCt8cA6TBxaInIg/Bs+FSy3FwRqQLug/AHp3OusUAt6JBAhz/iamc3d
	 3INK4YAdHGsgT/n8irSHbflecDPPsqyqOgBo9/bY0SoPxmpot+6TsHJ9k8O9FGZyfA
	 nm1bq3oaCkvVbvu6LNj9BLEmh+ObOPhyg3q06HhqmAgrmFDn0ja+gzEEJdXam9E9tq
	 DJgBnCfGeqBhnDmco/0uhQrnP5+BTwVefN3RHK5z04H3DnqVMsj6RQwvuMvZUyfjxk
	 ypX3hMGdfZmV10RWPj86Cc6B4hc48wagUKPVo7rim5kt1LFlrruO/gJl8zwRu2oF4O
	 oKol4j3s2bz5Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B663bf4ba0001>; Thu, 09 May 2024 09:55:06 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 4B98813EE52;
	Thu,  9 May 2024 09:55:06 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 47BC028042A; Thu,  9 May 2024 09:55:06 +1200 (NZST)
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
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial duty cycle
Date: Thu,  9 May 2024 09:55:03 +1200
Message-ID: <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=MfrPuI/f c=1 sm=1 tr=0 ts=663bf4ba a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=asi1NR3yGO4WnsI8QEMA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add documentation for the pwm-initial-duty-cycle and
pwm-initial-frequency properties. These allow the starting state of the
PWM outputs to be set to cater for hardware designs where undesirable
amounts of noise is created by the default hardware state.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Document 0 as a valid value (leaves hardware as-is)

 .../devicetree/bindings/hwmon/adt7475.yaml    | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 051c976ab711..97deda082b4a 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -51,6 +51,30 @@ properties:
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
+      Configures the initial frequency for the PWM outputs. A value of 0
+      will leave the PWM frequency as-is.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 3
+    items:
+      enum: [0, 11, 14, 22, 29, 35, 44, 58, 88, 22500]
+      default: 35
+
 patternProperties:
   "^adi,bypass-attenuator-in[0-4]$":
     description: |
@@ -80,7 +104,6 @@ patternProperties:
       - therm#
       - smbalert#
       - gpio
-
 required:
   - compatible
   - reg
@@ -99,6 +122,8 @@ examples:
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


