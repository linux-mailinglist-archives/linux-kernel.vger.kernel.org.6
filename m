Return-Path: <linux-kernel+bounces-447146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAB39F2DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FC18847A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7C202C50;
	Mon, 16 Dec 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGPZ7ZjS"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C0202C37;
	Mon, 16 Dec 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344010; cv=none; b=kekC/0/gXdJopCgnsUkhzdr13y5H9x5VqUJBxBcyqIMIYqXdXkocp7MNOiq0H5cVVJ2tvZnMY/80yRztrtTOLbrMva8mce4yeOpI7h/5FWUrTDbUB/br3SVn7aHgvMVXbLnVYhvmGWPiyxuqrGPArKwYvHdBbxKMhK1W95oTywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344010; c=relaxed/simple;
	bh=i/boAzoNOMo80REOAT5/9vUPnQpsvdZ914c30k9RHrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QIrlsfYProkxLE2bj2BkCnBcX5OQd0Z77ToO9ZECmWOJTJOLNOh8VlXVt1KqKo+BI4a73vBMNirxaxr6Db/0XshHmWad+ewfPWT8k2NQnrXJmMUavPN2HeE+g1GHurYjSaflUjMCqDZC8pTJtaS7syqa08BE44BkKdOrVO1YpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGPZ7ZjS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so2078985f8f.2;
        Mon, 16 Dec 2024 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344007; x=1734948807; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbXRZmRvesJ4aMa4YletGV3iwBIvD7vMTOjd87bnFd4=;
        b=CGPZ7ZjSMibUxLGUHrbhzx3SeMiQkp+y7iTaPDb5WwMkW+nWLtqwmhRBhmg+84BG0t
         KfkAOdDp6+tAVhNgjUu9cGoqKiRa+yrGt3opGY9z4udtceuYXT5IowERE7UgyvMDj6EB
         s7eAGHBuFhdgHfaVYaYWs7F1o4Bh+ImqP/oQfPRvdOFUG9eGpNbQGppxqV1Bwl1dROfq
         Epehyl1aOj0lUJvayv6kWpDjFZBk340jnn/UYYyNC3bXNRmm3yIrF7t5UH6e9xKAHqVx
         Lz+Oliqc553AXIJ91hVsQR4J75qQfiZlVGb5O/wXQvf7WDs0XXFwU/znrY4qa8Axnw3X
         WhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344007; x=1734948807;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbXRZmRvesJ4aMa4YletGV3iwBIvD7vMTOjd87bnFd4=;
        b=mGxUPe19RKvR5yjMO/PspTMFC12rc4U7ngkbFKvGq62SvyPovDJbQi/hIYc5nDyDjo
         CTBlvVwXHdd8Uw6DJWutzgUl94GBzD0/2iiwt2igoLoGxMllitXb8doY3/FMOoaUXq1O
         nVkP/YCe7BtiBC78QGpCRIvsqEydRG48BhRqb2oG1o6yWILCtoIwazeRTmTz9AGTe1NM
         zzV6JRgeMC/aYEBJkDIuY5KdSruA5LFp92L0jC05vRayqWY7b01NMNq6evVGt1iReA1R
         70ZeQPaJMyGOacPKq7h8E3lQmNl5Dqp3fcv+G+vb3DNtxRzYZo4RgZSp7BxgkMqZg+z8
         mXsw==
X-Forwarded-Encrypted: i=1; AJvYcCXfT4y40rUS536OVV6Na6YwJdAlsTtwBRpA0P3nKYF4kvNazOVXZ4iI/FxYUWcMIVEtXihomxgMuc7RNGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBm2slLrZrciH/6tF/vEdIUykd4uaR3mEtsCR2UtFDXzbGDjvj
	suArd7FqWeRMUurUr4Loc3+/fIOAVORE0cIqblTXFckQV6guIUGom8TjvQ==
X-Gm-Gg: ASbGncuEQP6GSBOKQqWOHaw/bQyyeIEBFOo9p+prAxEVAfq1f+Nkr47ILxF462AeE6a
	SIx7OhjiS+FD4ovdjU1YNso9wTD2ysrRfYVOwldSvv3HUzPEnfZBXTjnmWfS4owWpmpjWxlDT3S
	KZMVJ92vJz0xTCzWOv7GaRKfW75bthj3cJOt4PQBO/eqgzlF5eVKT7ytkhUsUPjcz10EWuBcGqB
	FOmDQAPuahx38Hwpj29cfsc4dCeiGRiIYNwzwXh1BFxojvrAcPSkuORSbhraKmuh1h/10fFllOo
	mLmm4kfeVBg2jRNKeUwy
X-Google-Smtp-Source: AGHT+IG5XVREgv++YwJa1t/IGd32+pWgXzWn0EOf0yZ9XbCmeKp9N2l1rnVFhCkcsPuz1bHaKe0l1w==
X-Received: by 2002:a05:6000:71e:b0:386:373f:47c4 with SMTP id ffacd0b85a97d-3888e0be376mr9198706f8f.49.1734344007232;
        Mon, 16 Dec 2024 02:13:27 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804d573sm7603900f8f.64.2024.12.16.02.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:13:26 -0800 (PST)
Date: Mon, 16 Dec 2024 11:13:24 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: mfd: sprd,sc2731: reference
 sprd,sc2731-efuse bindings
Message-ID: <Z1_9ROiI2ZHKsbAD@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Directly reference the sc2731-efuse bindings to simplify the schema.
Remove the duplicate example from the efuse bindings.
While at it, add the "pmic_adc" label that was missed during the
initial YAML conversion.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V4:
- rebase on next-20241216
- drop patch 1 (already applied)
- add the pmic_adc label that was initially missed

Changes in V3:
- new patch due to a missing dependency in the MFD tree 

Link to V3: https://lore.kernel.org/lkml/cd8cc95b59c31418b174bba521dd2599a7929fda.1730709384.git.stano.jakubek@gmail.com/
Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/

 .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 12 ++------
 .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 29 -------------------
 2 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
index 8beec7e8e4c6..b023e1ef8d3c 100644
--- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
@@ -67,15 +67,7 @@ patternProperties:
 
   "^efuse@[0-9a-f]+$":
     type: object
-    additionalProperties: true
-    properties:
-      compatible:
-        enum:
-          - sprd,sc2720-efuse
-          - sprd,sc2721-efuse
-          - sprd,sc2723-efuse
-          - sprd,sc2730-efuse
-          - sprd,sc2731-efuse
+    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
 
   "^fuel-gauge@[0-9a-f]+$":
     type: object
@@ -199,7 +191,7 @@ examples:
           };
         };
 
-        adc@480 {
+        pmic_adc: adc@480 {
           compatible = "sprd,sc2731-adc";
           reg = <0x480>;
           interrupt-parent = <&sc2731_pmic>;
diff --git a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
index dc25fe3d1841..8672bde24a9b 100644
--- a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
@@ -36,33 +36,4 @@ allOf:
   - $ref: nvmem-deprecated-cells.yaml#
 
 unevaluatedProperties: false
-
-examples:
-  - |
-    pmic {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      efuse@380 {
-        compatible = "sprd,sc2731-efuse";
-        reg = <0x380>;
-        hwlocks = <&hwlock 12>;
-        #address-cells = <1>;
-        #size-cells = <1>;
-
-        /* Data cells */
-        fgu_calib: calib@6 {
-          reg = <0x6 0x2>;
-          bits = <0 9>;
-        };
-
-        adc_big_scale: calib@24 {
-          reg = <0x24 0x2>;
-        };
-
-        adc_small_scale: calib@26 {
-          reg = <0x26 0x2>;
-        };
-      };
-    };
 ...
-- 
2.43.0


