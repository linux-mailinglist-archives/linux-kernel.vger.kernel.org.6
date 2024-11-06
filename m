Return-Path: <linux-kernel+bounces-397660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AFE9BDEB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189F01C2152E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144101922E8;
	Wed,  6 Nov 2024 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="bESeYVjn"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261917B4FC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873900; cv=none; b=eTCUvSKZmL3x0EjxjsYfqTyCpqyNEW5Kd2IDn4neOlJaktpJrNpSx3SFSs1r3gHXf7Kr3ATq8GC3duA62Cn0E17JWVDx0Y5gOBkXKnq2MOCqqLw/qCIQCpGSQgYpbCkiywOEnH+hhfgcCFq6+pEhoWFdSNH0Zxu7WizvSOS+UAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873900; c=relaxed/simple;
	bh=GOR+kBMKKKTUIGtKRM9XCI7YPrZNWfva3GQbxSEtoSM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=o/v97pGAV+32BxnHGp8dHxhCX+v3AY9aQC5Pkyser6gniR5ts//8Vrf8qDe+AnPxyPfV0Ln+H0lVNyaLjoiYKqMNJJ0aIuCgnFnWmdN0pUV2rYl6wQiQ85WUSR/uUMzCoZ6dO9BoFrKz4lH3RTaQ3mcFC1TJR86kFpQEqpwia+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=bESeYVjn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9eb3794a04so219115366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1730873897; x=1731478697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8iWPAz9+BWvksPjr7PaPX4v4WYSbjtCmVf883G/l4A=;
        b=bESeYVjnchrH9XzS4dV5pZ+9Zj7e5TNJ12qsN/uRA5CfWbeXSRSHDnakshsSa0KqLa
         NvsJP/jK7mOX4kz/ljcAcWdV6lBA68vfmBK0bMkITk2B7Y03M1co+W4+ZEqrZWl0QlER
         UJa6kUWGr382jQv+EULr7+tQPgHmdvVAn0ihx1FqVsQv/MuRLDVcuFxZPj5kIvVJOKz3
         9fp9CAPlWOZOBnT223XVzkker41BdirKwcOzHrFpStgerJEDBn1gVRJdLxVJQeFmRjeT
         +h0pgP1opKFWeTrlbDdvtuJQwveXg3onz/HiCeNxVAikfRZt/prIxn4bPCDZI/d+x5/7
         PYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730873897; x=1731478697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8iWPAz9+BWvksPjr7PaPX4v4WYSbjtCmVf883G/l4A=;
        b=aSThfYQ9kUfrmRRXxtr9NU0tdnwLCE/P5pkHNMRTigsjW+cJgMGK+vv3WFiuCIXIfT
         mTiC4bnhOnvFXNrs0Ogrf9laPc0EGBLaH7asCeKRp6391/vPMWRiCD3HqI9WRsBtZgfs
         mvAbft+rESdaCqwlfIfs8p2NQpKw9N2EttpjCu6z9iUoZbuAVEMvm6H2XAVGsXmr8MVl
         Is5pjujGufpU5SVQa9Mk+o0QeZ4PCR8X8Dwj7wB+dWtVx7ZnU5jr5XB//MFg0GfXHmfN
         YUIYHHZKsYdkN6fnx1RT0U0X1lfeWurRQ48PYEMoryUHeDwqs++1BQsBSCzpSSHLvQ2t
         3cgg==
X-Forwarded-Encrypted: i=1; AJvYcCUusph/XKZ6jgi/dM99XcYxdALOB29gK1e1Y+29n8VFXc/r1NvNrHHaKATraPKmBFEVQqOPn+a3fnZYsFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OLBZypFFwaYLbbDKmQ12+tUt54rFymAYo+6ejCJtNuv0Dty2
	5sz8W/vJ/ocPbJ72kx7UI/qMQOusw+NoStjiNIeQWPDE0stv1Inv4URtxWamkhtEKhoUKetwwDI
	fdkNA6a6kL4MoEaGFFItg4S50IgklULkxKIMEk9U9qV9xAbqoQQZbJDMKBg6NjHMWOWHDkLfp1c
	R3YrycQN0ao1leLty+r6HdN5nU0Io=
X-Google-Smtp-Source: AGHT+IFhssBi+UlpY04epBO4T8YAbXnYbIOZ36OUnkPmVbmrgXEXs9H586XxPpmnYSy0vPODACN07Q==
X-Received: by 2002:a17:907:6e8a:b0:a99:5021:bcf0 with SMTP id a640c23a62f3a-a9e3a61eaa2mr2578981566b.34.1730873896762;
        Tue, 05 Nov 2024 22:18:16 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17cecccsm232360866b.102.2024.11.05.22.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 22:18:16 -0800 (PST)
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/3] [PATCH v3] Documentation:leds: Add leds-st1202.rst
Date: Wed,  6 Nov 2024 06:18:07 +0000
Message-Id: <20241106061812.6819-1-vicentiu.galanopulo@remote-tech.co.uk>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add usage for sysfs hw_pattern entry for leds-st1202

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
---
 - Changes in v3: Add leds-st1202 to index.rst
 - Changes in v2: Implement review comments
---
 Documentation/leds/index.rst       |  1 +
 Documentation/leds/leds-st1202.rst | 36 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/leds/leds-st1202.rst

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 3ade16c18328..0ab0a2128a11 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -28,4 +28,5 @@ LEDs
    leds-mlxcpld
    leds-mt6370-rgb
    leds-sc27xx
+   leds-st1202.rst
    leds-qcom-lpg
diff --git a/Documentation/leds/leds-st1202.rst b/Documentation/leds/leds-st1202.rst
new file mode 100644
index 000000000000..e647966e496c
--- /dev/null
+++ b/Documentation/leds/leds-st1202.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Kernel driver for STMicroelectronics LED1202
+============================================
+
+/sys/class/leds/<led>/hw_pattern
+--------------------------------
+
+Specify a hardware pattern for the ST1202 LED. The LED
+controller implements 12 low-side current generators
+with independent dimming control. Internal volatile memory
+allows the user to store up to 8 different patterns.
+Each pattern is a particular output configuration in terms
+of PWM duty-cycle and duration (ms).
+
+To be compatible with the hardware pattern
+format, maximum 8 tuples of brightness (PWM) and duration must
+be written to hw_pattern.
+
+- Min pattern duration: 22 ms
+- Max pattern duration: 5660 ms
+
+The format of the hardware pattern values should be:
+"brightness duration brightness duration ..."
+
+/sys/class/leds/<led>/repeat
+----------------------------
+
+Specify a pattern repeat number, which is common for all channels.
+Default is 1; negative numbers and 0 are invalid.
+
+This file will always return the originally written repeat number.
+
+When the 255 value is written to it, all patterns will repeat
+indefinitely.
-- 
2.25.1


