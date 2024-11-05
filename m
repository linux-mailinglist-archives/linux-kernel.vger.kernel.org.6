Return-Path: <linux-kernel+bounces-396775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C929BD1C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A670628546F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2A16631C;
	Tue,  5 Nov 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="A28ZCbSU"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836215EFB9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823053; cv=none; b=p7gPZwshZARCUVx5NGx8ZcbPTkJHDsM9ljiJh8x3ssoSzD7zd/XFW/37CLZpsWEHWbXIgnwUvU5m8Xj0G7OUG8f8FHVTkar/tRYUUO13QKbaSDQSEgWpLaOQuohCRUMIorNZj1PI5DU06lz9je7d/F0Pe9f1yigUuD98i3zQ2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823053; c=relaxed/simple;
	bh=GOR+kBMKKKTUIGtKRM9XCI7YPrZNWfva3GQbxSEtoSM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tcmQSFN0M+ApL45r0pL6cxTk9NOsWEIY5qTP7lmVBHO8q6zezmomi7aqXE12I9xA5kwo5i3yeImevlBgV9B/CqL9T3XE5Tnm8sWEn9Lqd2SnhPD35SpfQIEWb+dIw/G0tOXQvWBPkTVte0A63QJuuw7IDtxyMRCKTITt7MBxKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=A28ZCbSU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9eb3794a04so142203566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1730823050; x=1731427850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8iWPAz9+BWvksPjr7PaPX4v4WYSbjtCmVf883G/l4A=;
        b=A28ZCbSUe1sy7nr+smYopJ15aGJDyBhkG0ZSSY/Uhrw7QSx2w3rPwewWEXN3xKx8Oy
         88ICBj4vP2tP8ZHoj29LPsCL+AS2Oao0K08YCvwuUuymC/4F4NKPkuZx0p2egP0mADgn
         UPAjYBbmJUqrLG3YwSChwu7k0bRXofnEaaoacFRi1N7X8Gd/tWzpx8sM9Xhu7RPHzFsn
         eviUj7y93Vv4MOx0RwJeDXV1wdbYYt0pcltIuxSxg86PYMcQlymGBGSnekJ1RZJZVBq5
         AI9iJFqVOVfLIZnEwkVA6BmR19z42XFP2oP4kiWd8AhcHfZftDmkVMdsz12Wyz8ILyua
         QA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730823050; x=1731427850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8iWPAz9+BWvksPjr7PaPX4v4WYSbjtCmVf883G/l4A=;
        b=A+/Q+VOy7yEUmti2JKkZvSsgMyZLju3gYemO/aIHxNH9OWwyS+Mx31EvGtJvdU2GMJ
         4NBmupniN7uXpxMyzbJ9FQrCDe1iS5CtiG0tEjFRiABQBSXjehAmd4eyQw+d5nMvC7AY
         qY4Mjt3lmrnH9HtQje1/2RdRHKM3XGhIGdl2WCa/lKH6fJhSHqgtBE39MU9GZtlL+DA0
         dfXGs6CIl/Q7SBr06IVYIudRP2qOerm6kNbYgNImow0iyToYRj3BNILGTbPqEEiZczhb
         +tJJpJr+AI5F5N4pVVpgefVBGJ4lmdLo3Gbi577BoESkevS4WLTG2fYgR7zTNKelSgXv
         5kZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYn5x+m9igaKviZ8jMboijw2/gVvjBpsYEvEPDFyOFlBJynPVzAUCO90sZvo1Oo1zhYxjS4bKmLmbuNFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NjPp8gMwCIqp/CHDFIDPEG7MZPBBIFq7KeCaUrfSpY6hWW4O
	Lq4fqx0PYXkLxqk95liDFf2FACY8nKG3m0SLs0eT1b6OnAXigVUeLAk3+HMztAykkT3JSRHhwlX
	BFupvYMNPgeWvpE+ROgQN7TNqmFG1vwgjatloilqtGCVjcbhlL2PbHdlsQ0ENDGdXEDGyE3Grjk
	rTot/i8cgKXVFDGBKbrM6pfJeN2rU=
X-Google-Smtp-Source: AGHT+IGkmJfi7dRHZtTpmNCLlbGTZDSTQBEvMTQNo52T6AzDkPM1XFezL57iku5tpryplHLQ/GERnQ==
X-Received: by 2002:a17:907:948a:b0:a9a:238a:381d with SMTP id a640c23a62f3a-a9e3a6ca29cmr2346666466b.52.1730823049770;
        Tue, 05 Nov 2024 08:10:49 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f7928sm151184666b.138.2024.11.05.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:10:49 -0800 (PST)
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
Date: Tue,  5 Nov 2024 16:10:36 +0000
Message-Id: <20241105161041.4813-1-vicentiu.galanopulo@remote-tech.co.uk>
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


