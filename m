Return-Path: <linux-kernel+bounces-327587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BD3977814
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C61DB24FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A21D54CD;
	Fri, 13 Sep 2024 04:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnkTqdt5"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD11D47C8;
	Fri, 13 Sep 2024 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202767; cv=none; b=nijqDImTzg1+MPWhtUeDwBrdccXoQaoJo0CxYYem1bti3eCA58mWL4ZO5GfvbuFQa7YeawRUvR+oIC11M0QsOgU6p64mlx9AV2WQN4GgUseuL5kQpiqC2w/hsei8uGIn0Bp0PIr4RmaLyKLh7NXX+b0hZLswbLzDQhkBYyzuWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202767; c=relaxed/simple;
	bh=aJ+DU9nNl2vdAafnF5XLLxjZIEVEy0JJs4wovDNN8nA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XtJ+kRk6rih1uLOKPdITIWA4EBKbyldibnWntLS2Bs48Xt+bzJKDuggjw76qQFRi5Dbi2/OUeakFqi7jr0Cg1QSD8pmfCyKm3Vrfym3EE7PLAzVhfcC0N7Vyn1aLtIgJRlMZm1IC2/EXf5Ilmjk+hJZSSc224y/1VPxPRF33pOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnkTqdt5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso492988a12.0;
        Thu, 12 Sep 2024 21:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726202764; x=1726807564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvjMZVYW6cr2cJF7xCG4RzHVN0FtN4ELeVl4OFEmIT0=;
        b=GnkTqdt5aez5RmSOqVXlQSBjeYW/0j8yLlhniwAlPGIpzVw09Sf4SVIIBwL0Iraobh
         ffymJtFzH7wfObDoSQIOg4bo5R8vvb+FMZ284XlNarqKJF5pEKAoA81iraqFCL9RG9/W
         RHKBkx5DeVorkp3YSFQ0dP7FIadcpxSuufPBkFbpguSfeFopCDFhxoV81s4b0p7UFAzF
         U6UnKOYoONQfb74aFGt0O91feYAGmDr+fc+tTil46N2pYXZF3/eq3qqkYELdiHVofTDM
         kWQ1xqY4U7q1+PbVvDZQny7OzA9jMkWj9+wguYRMfBjLb03QbWoWyYFCWi9KAFiUsLqr
         a7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726202764; x=1726807564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvjMZVYW6cr2cJF7xCG4RzHVN0FtN4ELeVl4OFEmIT0=;
        b=Fvy81BlDX3rc1Csu0zXvh9FqeOuAF3xwj38r+MMF+Or8xFk7mqq02HpKAi7XUIil5O
         SMZGGu4UYF5nJHmcTlUg/l4xd9dSFqibnsv22OuJMspHZFSr/CbtbfceDwdxMwTlAfM3
         7ba/ElGHfEN+ARV6IA9K8fesPsLFJHIrPykBJdLQ+0hM28mUSsEwjnoQBrYuq0Ir0+2O
         WlqV5baKzNVKUWfOT2RpjYyFzaHS/fnVLmogf1c9WD2x3U8h4z/zdsHzF3/mzYwedMiq
         KtWBk2MsI1Tq2hjOFhJeYTXAlzd1Op5MEEW6rqgjHbtlZTg2/085qo1gMrh6a1c0Tl6J
         RDPw==
X-Forwarded-Encrypted: i=1; AJvYcCXo6lgncOHP5uW/VzPFEWCVNw5xMpR5kBX373VqdgIeGlulRuVpW6IDGjo6FkmS3ACFg8Z7i0Q9an5A@vger.kernel.org, AJvYcCXzSKmM+x0eW/pHiBviP9+oCepYHOYjTR0Z8h/HMRoQ/H04RD3rlNzKbBqQnWQgLzvyz5aW+K1xpz+ii2Au@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXXPhx3lk5JV1uHrXVYcOYA1SMQptO0VzWrTRYK3Hy0ANvB01
	0MtNi31E1IWlD634Y5fhe6I6EwrVx3FU5StrGPqNshKL3nkSXNNx
X-Google-Smtp-Source: AGHT+IFfaAVy51H5u5apm3I4pEWfaWlpFB7z2h8ZgkGGlzxqpBzd+BWSTMcvBDQo5Qs5g+lQ/sfDhQ==
X-Received: by 2002:a05:6402:2b8f:b0:5c4:8ac:ff80 with SMTP id 4fb4d7f45d1cf-5c41e2ada81mr1139349a12.33.1726202764181;
        Thu, 12 Sep 2024 21:46:04 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76fc4sm7303468a12.78.2024.09.12.21.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 21:46:03 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: phy: bcm-ns-usb2-phy: drop deprecated variant
Date: Fri, 13 Sep 2024 06:45:56 +0200
Message-Id: <20240913044557.28315-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

The old binding variant (the one covering whole DMU block) was
deprecated 3 years ago. Linux kernel was warning when using it for
similar amount of time.

There aren't any known Northstar devices with bootloader providing DT to
operating system. Actually OpenWrt seems to be the only project using
this binding and it always appends DTB to kernel. It has switched to the
non-deprecated binding years ago.

Given there is close to zero chance this breaks anyone's setup it should
more than safe to drop this binding variant after 3 years.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/phy/bcm-ns-usb2-phy.yaml         | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
index 426101530a21..d72c02ab55ae 100644
--- a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
@@ -18,16 +18,8 @@ properties:
     const: brcm,ns-usb2-phy
 
   reg:
-    anyOf:
-      - maxItems: 1
-        description: PHY control register
-      - maxItems: 1
-        description: iomem address range of DMU (Device Management Unit)
-        deprecated: true
-
-  reg-names:
-    items:
-      - const: dmu
+    maxItems: 1
+    description: PHY control register
 
   brcm,syscon-clkset:
     description: phandle to syscon for clkset register
@@ -50,12 +42,7 @@ required:
   - clocks
   - clock-names
   - "#phy-cells"
-
-oneOf:
-  - required:
-      - brcm,syscon-clkset
-  - required:
-      - reg-names
+  - brcm,syscon-clkset
 
 additionalProperties: false
 
-- 
2.35.3


