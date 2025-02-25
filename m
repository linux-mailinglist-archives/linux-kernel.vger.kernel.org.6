Return-Path: <linux-kernel+bounces-530831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A79A438F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D300420AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0012690D1;
	Tue, 25 Feb 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfkzFHq+"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B28266B5D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474347; cv=none; b=J6m34/qJm7cjdNvg66GX57NY/GviYR3UsjZxgvm0Xox2VZhQpIQ9HhuCfJqQ1qOqVR7DcavZNqgeLr09RA7RaOXmuosPZXV//uZ31ZaBS6hxboo+cg1R3lHC8lf+kS8rPqSbzYitMZ/yo7tJ82HF0KjX7FgDtmL5oe5xJF/5NCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474347; c=relaxed/simple;
	bh=VbFmmIDF/8jKLhSs1wa1TXVWPdXSYsgH25cB1B+83/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaB9UL1kJ99nQedFicSQUL5doaL1pFwPEO2hQY1CWg/2Nru9M9yQQiqBqi4FVm3F7y5r048RRSY3CSyJ4JTetoNctmUgvwbAN+ncqmcdkVhKlupIX70o9QM/P8FTL6x/MRF++mOARv0mpxQH7YIRjWSqvMaHPO+jYoXRxImHAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cfkzFHq+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abad214f9c9so99484166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740474344; x=1741079144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zo1pjQ68yeCzhbkpB7J7V47zeMnYxLOEDsgL4uzRgNQ=;
        b=cfkzFHq+TH3Cd/oBAf6IHI3IlHaMNnr4drjCbuugq7Dtfjix0he8FCfb0ZYiSgmD6h
         794FBneJ5k/UrjeVY7SBNBZqeCXYGz0+mlS7DxK1zBCFQtSDVQ0o2Ndijw5r1bO6gCxr
         XnGnynzaLZl89k2Z8qoD59WqGRIkw9uBwPmw/S59+k5OyVmaYRzRXHJPFqXaOC9G7eZR
         P944pHhYnioT4bdqOpvnj4EWKwUgVIWAmyR0duus2cj+en3xFYb9LBqjUhxoO+4GwZvk
         rIGcGwMo/hyj2OXsZvgV3nfXiPZ6vcQPBLwkZ+39h0gCjgadQBEEM1pbre4XUX2A1d/F
         o2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474344; x=1741079144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo1pjQ68yeCzhbkpB7J7V47zeMnYxLOEDsgL4uzRgNQ=;
        b=lIF7vcogCYAF/eLPEOPEZqMKobJ75lAM8WAhbvDwcULFUV88odS32i/auOp2sAIKyA
         QC5yTNRMhC87KCDkwIh+HJD7lKkJXVD1h+kNqgrI5HRc1vx3bWfFPE/Qk1Pb3PDT57E9
         XHbMITK7fZ8ivYAOn2LA9MxmfpGr2m4JX7LD6m+2Y75x1P9SGAQj5a3akCBZRaptB/kZ
         vYLxFLAQRnVkg208Hl557GINPeHXuE3YZbEPFaSpzy7+3rUb36eMY656yyjs3FRbDRO5
         o8Xh4s/KS5Mbupz7XPj5OlVzdM/keE8uXssbvJz478AKbaDTcO0KqpI6l9MwPftF3Zn+
         aP9A==
X-Forwarded-Encrypted: i=1; AJvYcCVJdCoBg4bQQhPDR6CGrY20Pq2dn1CXgixV/rxmZ4UhsB1zddmjkFvHL69Rhr4s42PnxPjCEuWpvMDRqBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXCWRfQoc50ZHTBokzcSNoStyoNxcXIrGErgFNDs0kdZ6E6Nl
	Ga6OgQ16B1mpPKcOT1mUaNBkjcow1uNE35hBkMY7zhYmQwRB+X0xFNJQ/HBPv2k=
X-Gm-Gg: ASbGncuHoBC6cewGmZhLmN+DnV7yUlobS4CptL7u9wGw4nvTCG78oOEBae0+TwHmvqx
	w9D69WP2+5lR9pOmiF5631lsNZ8NrI8uX0aWsZXWPTaVS6SevV1jZ9JbzkYciwYQZalPaOePhkz
	weVbnOlI+keL02E+zDl2E1uLl6brYC3/zixwUEBA+za3CVb9KUxWa3lH4ywkmDI8t9igfsF9DsN
	GmvRYO1it9/I8RJmfVXVc9TOB39ajXGIBVLF9L6r+yHbS98BPlzuTHK0y2bxaCoTmI4QmBf1Tk9
	FcIU2Yueqk0Z7fMuibStam9w7stHLVCz56mTNJHa/Q6WGVyI1jc2Dn8VmuWLzBhkZHGEynBLsER
	8
X-Google-Smtp-Source: AGHT+IFfZNdXDJRzlMISFU49LCOakhBuM69LkIjmx8fbF/w1knTVG5tWk4V0qemTNqYROdbFXsCH5A==
X-Received: by 2002:a17:907:9814:b0:ab7:cd83:98b7 with SMTP id a640c23a62f3a-abc09e5bf1fmr582403866b.11.1740474344247;
        Tue, 25 Feb 2025 01:05:44 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d58sm106681566b.148.2025.02.25.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:05:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:05:32 +0100
Subject: [PATCH 1/5] dt-bindings: wireless: ath10k: Strip ath10k prefix
 from calibration properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-b-wifi-qcom-calibration-variant-v1-1-3b2aa3f89c53@linaro.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2764;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=VbFmmIDF/8jKLhSs1wa1TXVWPdXSYsgH25cB1B+83/E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvYfgQSbcaZwR2tq3fhOVEdWBllORf8viADQmn
 Wu6612ZHpeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72H4AAKCRDBN2bmhouD
 17M6EACV7hPG3YBlQRRjYC7EqbUoc5wWOSqUvEuuy6qx6Dkd22qcQJXm7ZEr5U3XQFvCuAcZ7nX
 ACotRz7PjoieH49a1VCo4LhSjbYT3qRDxskFF9VVdvWraUtphgnj55kdkw0d6KEoM9Y2prvbFGx
 LwZ6AFFEZj3eKiuVZlSkvEQ70viWCjCYqiZR2QFMRKlvZZuHWJhiULlNBkIIaXtkQ0/hhqz8sCi
 jbkmRLbYo8CG5ub9/uOxn7ZNwZUB+Y7UjpCC4egJne/B0v6mgaqxMIsCiFDkTZlyH89+homyqmK
 M2sLBHzdCnG/X+RK4yEu8W1sfdlS1U/ZFu0zm+q1CpYqT/RaDgNjVJu+8s5yP4XbdgVFoYDWtfU
 +fHcN+LTSeqxR5wOQ8rXc2jpyjWbN5UX+jM5Co6DALIbxv1i79LgBgg4sm4XyiwAcNuhpHi2RA1
 HZ3HNsftjAVMCnFi7erV1zzJdAugML21xyV1TkfKM50rWs8a1XGQXKWl/+w/KVfyrdKlQvSwV8G
 MluzY10xipB+fslPuWy0qRzM/tZriEjVywT9W6Yf3JCkPYTDyukCrpLYGMbEWARCXC5MyvhPDbz
 fWqno2SzFzSuwr+j5l7N5hKlf2zdeQawJ1uscMWElYBbziUO7ghhwFAu8gg7avuY/BFH6Qzbz0/
 Aoh6IGtBcs3DYZw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Devicetree properties describing exactly the same thing should be
reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
certain calibration data, so properties should not be prefixed with
device family (ath10k).

Deprecate qcom,ath10k-calibration-variant and alike, so we gradually
switch to a common property.  This will also allow moving these
properties to common schema, if desired.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Why? Because people add qcom,ath12k-calibration-data and probably they
will add qcom,ath13k-calibration-data, qcom,ath14k-calibration-data and
so on.
---
 .../bindings/net/wireless/qcom,ath10k.yaml         | 25 ++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index aace072e2d52a6830b98dd3f52d61380105c8aa1..f2440d39b7ebcda77db592de85573bec902fb334 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,20 +92,41 @@ properties:
 
   ieee80211-freq-limit: true
 
-  qcom,ath10k-calibration-data:
+  qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:
       Calibration data + board-specific data as a byte array. The length
       can vary between hardware versions.
 
-  qcom,ath10k-calibration-variant:
+  qcom,ath10k-calibration-data:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    deprecated: true
+    description:
+      Calibration data + board-specific data as a byte array. The length
+      can vary between hardware versions.
+
+  qcom,calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
     description:
       Unique variant identifier of the calibration data in board-2.bin
       for designs with colliding bus and device specific ids
 
+  qcom,ath10k-calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
+    description:
+      Unique variant identifier of the calibration data in board-2.bin
+      for designs with colliding bus and device specific ids
+
+  qcom,pre-calibration-data:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      Pre-calibration data as a byte array. The length can vary between
+      hardware versions.
+
   qcom,ath10k-pre-calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
+    deprecated: true
     description:
       Pre-calibration data as a byte array. The length can vary between
       hardware versions.

-- 
2.43.0


