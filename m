Return-Path: <linux-kernel+bounces-357927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C479977EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228301C226D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464F1E32D3;
	Wed,  9 Oct 2024 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duRES0Ng"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13778193092;
	Wed,  9 Oct 2024 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510672; cv=none; b=bjraNklBhNLu//LP0LKqzY4pJEAxT5KDccBWnuJZyazaAuYAmsxpSscjN/u2HWNJ9VnCWPjREGssLcmRufsNOGLB5XlOaYzUaJ09J47EE0rUJrdSXJ4vvQKikROOnsTnYU+KUv1S3pzOvIw9w5wnn45AUDEEQRomfB/tIuGUl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510672; c=relaxed/simple;
	bh=B6je7jiASQma6mnF5MKfSYj3VVukHkDMhDLnpofeCsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae2iG3WNOBHpcY/XoOVbOpcpLNVjxggcbYAGJ+xScBlEcgfhxu8uzMMFdM+bXheh5NyTMd3R0jldqt3C4dik1ot7HtKlZqU+QsGiHXF7r0eQckKtkeurchdZnhbUGlO9KGCaVhx5Ye7kOFQsK4rHUDsw1HG8mdOL6kDLczS0Mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duRES0Ng; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e15fe56c9so239737b3a.3;
        Wed, 09 Oct 2024 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728510670; x=1729115470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytdNCpY3ywuE2VnDeLP5mnfyE1FOZ+8OMXSn6PncjqA=;
        b=duRES0Ng3euFfrubIL4fjQmxdtZmH0tXLg2zXT/HrAQLmhlRR3C2LPSsiSYesM2bfW
         j+0oNyTreQ1O1+gOfkSWE2sX+tPSblZo9VG1icv3GzVjiVLL+E37GlOVWSWQ7kZinlRW
         H4HnTQuCFaKNa6lO7nRVTCU2OTZOrVaGr9zGtTq1Lxe5Ks+us0ImsVl+NMchsjYob0XQ
         C6iBJ9r7Ud58AyITtTgInC3CGoU7DTXDwqbR78E0ax+pIHDq+FFMXc5Yl0/cJ1j+HoX/
         BLHZJEMz+p1AehXQZt6fQXw2BQdd3Ccb5lOeUbbyQAQkgLCAHgRSZE+IkWXOJngklkuS
         q94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510670; x=1729115470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytdNCpY3ywuE2VnDeLP5mnfyE1FOZ+8OMXSn6PncjqA=;
        b=obPOGyySwMgca6CYvR/yw2DUWEAc/foj8y/a7KdQ8OqYWWA7oiBOxFu0SkYev5p8iZ
         gkRBOMmwa4ugj69c1udkmKJ7GZjVrddYpAjtJDHJR0kWbgFZMj7mAV3CVdRre0tv7xUa
         nVrUsZan1vNU4cFBXWXqx3y09o70I2fSBuvsWnv/SAluzeRVJm5OOibXE1lXUbloR5p6
         kaolO2e3zFg8rnHvVffHPpw6AiW6xjLZL62vchWeCbPu+QKoyGZl4XIklfGdj1IwBlnN
         7W7xsbiDxrOJw2Snvf7dOWh5z8jORF+6QxqgWq4xMUHte9rToNHJpnSHVfIppFCHCAzD
         kJDw==
X-Forwarded-Encrypted: i=1; AJvYcCUMVy1g1jpCw46ZegJQLUwJhCmoOUsdIN5seUMPdQuCQARYLj5nSRvVQJBwjbWkKMd2SWWYHvz6WwED@vger.kernel.org, AJvYcCWaeZkBNDaUstjFAANs0xUpwC2EzoNPSUxG27LPyt9BcsEQWGFJtrCFyvf1hmypFyosL2j2dTjY3WAGv+eu@vger.kernel.org
X-Gm-Message-State: AOJu0Yydd9j9Xen0tI80LBvd/f9PARETQWwttV+rYaW4aDY6rTNgeGg9
	GQIKSvkmRN/xuvWLib6his3WFCtMUrYvEoeY2g+z3eIT6b97agpX
X-Google-Smtp-Source: AGHT+IGAb8YE10SWaJg6VOPcMZnsWnq/ERhnLIaiMtgIwviert0u7YtGlBsmxO3ymE0702ihsbZdrQ==
X-Received: by 2002:a05:6a21:6b0a:b0:1cf:359b:1a3e with SMTP id adf61e73a8af0-1d8ad83cd67mr2252199637.32.1728510670257;
        Wed, 09 Oct 2024 14:51:10 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833a95sm7651847a12.52.2024.10.09.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:51:09 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 1/3] dt-bindings: mtd: Relax BCM4908 partition schema
Date: Wed,  9 Oct 2024 14:50:44 -0700
Message-ID: <20241009215046.1449389-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241009215046.1449389-1-CFSworks@gmail.com>
References: <20241009215046.1449389-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM4908 partition "parser" is really just a fixed partitions table,
with a special partition compatible (`brcm,bcm4908-firmware`) that
automatically labels the partition as "firmware" or "backup" depending
on what CFE is communicating as the selected active partition.

The bcm4908-partitions schema is currently too restrictive, requiring
that all child nodes use this special compatible or none at all. This
not only contracits what is allowed by the "parser" but also causes
warnings for an existing file ("bcm4908-asus-gt-ac5300.dts").

Modify the schema to be strict only for child partitions that use the
-firmware compatible. Also update the child name regex to agree with
fixed-partitions, so that these differences apply consistently.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 .../mtd/partitions/brcm,bcm4908-partitions.yaml | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
index 94f0742b375c..aed37922a5fc 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
@@ -30,12 +30,17 @@ properties:
     enum: [ 1, 2 ]
 
 patternProperties:
-  "^partition@[0-9a-f]+$":
-    $ref: partition.yaml#
-    properties:
-      compatible:
-        const: brcm,bcm4908-firmware
-    unevaluatedProperties: false
+  "^partition(-.+|@[0-9a-f]+)$":
+    type: object
+    if:
+      properties:
+        compatible:
+          const: brcm,bcm4908-firmware
+    then:
+      $ref: partition.yaml#
+      properties:
+        compatible: true
+      unevaluatedProperties: false
 
 required:
   - "#address-cells"
-- 
2.44.2


