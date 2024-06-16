Return-Path: <linux-kernel+bounces-216454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45A909F90
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA66283486
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43D54E1CA;
	Sun, 16 Jun 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQdtDkP3"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49291B27D;
	Sun, 16 Jun 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718566833; cv=none; b=kL5M0r/LxTkzahmmKRB01JeplbQFjfG+0pJFSe5ww81S20z2KuOU2dFo5LZBHuqucET81o1TFv7SMfVP7nG0gunkPMUhxDPBb9OEA1tACuglc923lMAoI52/oKDRG0y+G1RpMQZpp9WQQvPV0AQGahXvEgV7PmcyOawsopr5m2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718566833; c=relaxed/simple;
	bh=uHa5e+oni+iICefqSKjxWNXM0XkjCJyrTpLjB8rULjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dnpJ9ghc0zxF7Tw9u3pSn6Ceygflcdry0HvV+IR6XdUVXiEBo8Fk6UiOjqP92JRvfJlvb7fd1kONT/vsMrYSAqwFLzRGYRSiztPYflKQVF+5ketn60os1Va28P4FUcT4BgIxGF+hTBhntI/YTYpNiIKpGOSX7I/F3EbWU/mmtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQdtDkP3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f7720e6e8so80593366b.3;
        Sun, 16 Jun 2024 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718566830; x=1719171630; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6L3NCeGT4sGFh8kYG/GxPyDNO15JRCaWpkmIRoOQZw=;
        b=JQdtDkP3bxBcWnsFXCILwYV9Qi40BvqS5dAAHCQ6ybN93kj2Xu2Zzg3iz+QQ6qO6aV
         vpAPvnkhrKSq1RkKctaN2tDnBUU9IRCkzrN4mgo6/0tU/2dxJ31Kva1BwktH108fC3zo
         jE1Q/L+shaMxBYo6ZBRt7dW/VRiKlcgC4so69wi9IDNMvgZsTrql6JLx4wwc/uEdBdBc
         mM98UMw037O2ZJQw5rFtw3bwIbdAaeNRqfyVCqe/MafwS3l7V/t19gOqqgDSFPkmhdLB
         ci+qt2lYE+rVdaxG5ay7t0B8Xg0R4E6xacO6uBxZ2+IlcTmcHfVVQxitT6hkmDTXKuAz
         g8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718566830; x=1719171630;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6L3NCeGT4sGFh8kYG/GxPyDNO15JRCaWpkmIRoOQZw=;
        b=O4lhpJ6kDG1N3bJpF6ENBl3Gj7imKO/NqUqxGjcyzBVj10zYJhvA8dxeduX0MgZgxP
         SDg7mBB1cMRyLGaDKDuLK/tNqmR97KAZ6DipqKf5mldnxqvLVTM7HE9Ma2DlDkjXZ3bH
         rlekZgtEglmZPX0NkitdX8GeErMlwDdo9LB8c7APiXrD4xkt8jpGQ/w+k1By4cE7Jk8E
         SBXQWijLkqSRFL13iVQrlJBPHt0Lec2QBS2kJGCb63jV68D5EWBj9szHf0oO3D/4ZFXU
         VFUBAGF7+DPFscDgQ5kNM8k0iXxN+wQ4bFastKoC4nb9+webb1nJg4h99CnHWc6iY3iv
         x98A==
X-Forwarded-Encrypted: i=1; AJvYcCVzrXJoIyXRr/R/+VwfbwLghJ52YmYsK37jQnJcwYnJubBYLp1omyYFDvAvCdeMgrS6bxqSF5hvjme18VSU7c3/eh5QHW8aFptZ5EVcTUIIuqvelUuhB6nuC5yDXgXZt7ooFWz0r2kwWw==
X-Gm-Message-State: AOJu0YyavLnVQoh5KPrtae7CirG4ycqiJeeh9kkVk4BaVOFbEACvbBSD
	JREEjJ5z8CwihSnKCQInw4y+m89rKn/VUwhCy1FVOGu07tinaq/e
X-Google-Smtp-Source: AGHT+IE46LpZ9yhJLkMRZbMAo1colG/V6YVZKIMF31xeNH4cSnUuv0VMS2ak7aMdSYN2R76SpvECnQ==
X-Received: by 2002:a17:906:fa15:b0:a6f:48b2:aad4 with SMTP id a640c23a62f3a-a6f60dc89a5mr716461366b.50.1718566829403;
        Sun, 16 Jun 2024 12:40:29 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4182fsm441530366b.178.2024.06.16.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 12:40:29 -0700 (PDT)
Date: Sun, 16 Jun 2024 21:40:27 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: ti,tmp108: document V+ supply, add short
 description
Message-ID: <Zm8/qxGc8fvi/tuE@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

TMP108 is powered by its V+ supply, document it.
While at it, add a short description with a link to its datasheets.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Not entirely sure of the "v+-supply" name, but the datasheet only ever
refers to it as "V+" or simply as the "supply voltage".
Only other name I've seen is in the schematic for the msm8226-based
motorola-falcon smartphone, where it's called "V_POS".

 .../devicetree/bindings/hwmon/ti,tmp108.yaml          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
index 8b5307c875ff..71d3b51d24d1 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -9,6 +9,14 @@ title: TMP108 temperature sensor
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
+description: |
+  The TMP108 is a digital-output temperature sensor with a
+  dynamically-programmable limit window, and under- and overtemperature
+  alert functions.
+
+  Datasheets:
+    https://www.ti.com/product/TMP108
+
 properties:
   compatible:
     enum:
@@ -24,6 +32,8 @@ properties:
   "#thermal-sensor-cells":
     const: 0
 
+  v+-supply: true
+
 required:
   - compatible
   - reg
@@ -45,6 +55,7 @@ examples:
             interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
             pinctrl-names = "default";
             pinctrl-0 = <&tmp_alrt>;
+            v+-supply = <&supply>;
             #thermal-sensor-cells = <0>;
         };
     };
-- 
2.34.1


