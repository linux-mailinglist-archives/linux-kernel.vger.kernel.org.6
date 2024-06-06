Return-Path: <linux-kernel+bounces-203602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB08FDDB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3098A285034
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92741219FF;
	Thu,  6 Jun 2024 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE6xNVQ0"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC92114;
	Thu,  6 Jun 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717647155; cv=none; b=VPVkBqfdrS/O6OaHJcmhR9hqU9J9Sc5wuo2KNmd6gq2zamjsS5QSeOZ4OrF4XlhnbHfs0gIcyelXg8I96m/JP6CpEVhADlsvhyev7ahxmKuV5LYNzr6KKuTgRXMbD+ehwAUTIKl9BI+cERj3P7LynOQTP/MIO6ZusjlMsxAkMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717647155; c=relaxed/simple;
	bh=NB6cPiw9QlP2ojVCT09yRXI9z2MUnWRnPHxnNyRD9HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVgMG0A6WtYHCKHpTKFF1l+G8Z80gtIX54AZN1/05JtBJxUUTFoCX9UdFrjUE5cLP8qfp5+X0Sjx9lKHOXvQXkHZ6XD+I1JRpar1cYAZ236GvDplya+uz8Sz1sH3YPXoTgimr71ZOot8CV+VoH3ELuaIwCTyoh0I/MvuODmyxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE6xNVQ0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f64ecb1766so4671295ad.1;
        Wed, 05 Jun 2024 21:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717647154; x=1718251954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EyTDFfYIkacZajwzGy5k7LzB0jww/Lew61Qql3uF2Lg=;
        b=mE6xNVQ0zkRfn8aG8XILUgtkdJYhI4Qe6YoMWK0haHAz/7RCJHsem/Z4LLY4cDGm6Z
         sPoZQn9MOYPtQU9ryrv4JWhjwrv8C26AJ53D5tZDJtqc+ndvbKSZgi2xKnhapku1IjGn
         nKidYeCa924cSL8/wmJE1+fGKE3yxDU+HC9ElyvlooYiQ4PwuTFvK60ouqZmGqYoSc0E
         G9RCtKdYYAsSsP3OmXQP/d4oJDNsP4Ng94I4vNzj91/QPMi6f5pkIbLumGqTFNh+p5BS
         EVNRYk/bRMuQxHOqDNHPbKIaQyt6cnSrXhkgO9eA6fHd720zQjevQn0zLlV9x9EWT9mi
         9lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717647154; x=1718251954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyTDFfYIkacZajwzGy5k7LzB0jww/Lew61Qql3uF2Lg=;
        b=eyzIYRkl+k/L5hhfbZO9xl9Z/lRdxPlAJEIoMED/dfaKfwDVRkHv0KFgFONSE9WOYX
         CJwqzp7qQL3lJbIGp75SkOiCRnN1Wfe6N7F15+oka/oagce1lBUB8LZ7UboIsD2c3iu4
         lBpMzQf0OFdJRXy0Muoxan5UmNAOIoIpYoPUvqGcAlQuxQTe0wJLDyE7NFGZppgCd8H2
         D2GUpIQ8bVMkfvC1eFdS9eTd+RlvNRRZpU+yu/6IFTyjNoGVZ1brM3g774aiSpGz2TXi
         IfxTbC9oDg5m3m//ejPC95UhhIwAaevsd4Zcv5OFE+rTFz8qtiUC55Y/XvfU1IC8g8tK
         PNlg==
X-Forwarded-Encrypted: i=1; AJvYcCWQpFgu6WN0YqI7xctslsN6O9r8L4mLayWb4pARtQOlORDLJ9YCoRdadflHJzoSdntyeGUvLckROhSV56USTCdThGG7DifsO5eNSfOHQU/WtoXE+5FJFfVPLKdhLCnCVIlRYd5IDhXW0rYOjVR9zUKuioFEtcCVpGz9pL5wxNLbArNfaNoi
X-Gm-Message-State: AOJu0Ywnzaus4k5OksVjwF4NUWu6pOUiH/+mHRaQMANbIj28tWxDXmcx
	Vu4elIfoZwVdzuIhqoZXVRlRbMUPZSzHa8S6iK/ieqUzpVB2f7V/
X-Google-Smtp-Source: AGHT+IFjhgLWKGemUun+RuvBiwWwF+aM1HrUn2VP9ZH6D0o14oF/urTXICoS2jKwPrvQo4918tGSnQ==
X-Received: by 2002:a17:902:f681:b0:1f6:1ef5:8841 with SMTP id d9443c01a7336-1f6a5a26d60mr53131865ad.34.1717647153551;
        Wed, 05 Jun 2024 21:12:33 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e063csm3548085ad.190.2024.06.05.21.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 21:12:33 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: linux,spdif: Convert spdif-reciever.txt to dtschema
Date: Thu,  6 Jun 2024 09:42:00 +0530
Message-ID: <20240606041212.78428-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the dummy SPDIF receiver bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>

---
Changes	in v2:
- Add linux,spdif-dir compatible in existing linux,spdif-dit.yaml
instead of creating new yaml file specifically for dummy SPDIF receiver.
- Change file name to support both transmitter and receiver bindings.
---
 .../sound/{linux,spdif-dit.yaml => linux,spdif.yaml}   |  8 +++++---
 .../devicetree/bindings/sound/spdif-receiver.txt       | 10 ----------
 2 files changed, 5 insertions(+), 13 deletions(-)
 rename Documentation/devicetree/bindings/sound/{linux,spdif-dit.yaml => linux,spdif.yaml} (75%)
 delete mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt

diff --git a/Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml b/Documentation/devicetree/bindings/sound/linux,spdif.yaml
similarity index 75%
rename from Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
rename to Documentation/devicetree/bindings/sound/linux,spdif.yaml
index fe5f0756af2f..0f4893e11ec4 100644
--- a/Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
+++ b/Documentation/devicetree/bindings/sound/linux,spdif.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
+$id: http://devicetree.org/schemas/sound/linux,spdif.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Dummy SPDIF Transmitter
+title: Dummy SPDIF Transmitter/Receiver
 
 maintainers:
   - Mark Brown <broonie@kernel.org>
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: linux,spdif-dit
+    enum:
+      - linux,spdif-dit
+      - linux,spdif-dir
 
   "#sound-dai-cells":
     const: 0
diff --git a/Documentation/devicetree/bindings/sound/spdif-receiver.txt b/Documentation/devicetree/bindings/sound/spdif-receiver.txt
deleted file mode 100644
index 80f807bf8a1d..000000000000
--- a/Documentation/devicetree/bindings/sound/spdif-receiver.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Device-Tree bindings for dummy spdif receiver
-
-Required properties:
-	- compatible: should be "linux,spdif-dir".
-
-Example node:
-
-	codec: spdif-receiver {
-		compatible = "linux,spdif-dir";
-	};
-- 
2.45.1


