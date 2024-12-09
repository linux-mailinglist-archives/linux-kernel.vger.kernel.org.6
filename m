Return-Path: <linux-kernel+bounces-437434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3359E9329
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4FF1886CC8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1F2248B3;
	Mon,  9 Dec 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="HAsTprHA"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D4221DB3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745673; cv=none; b=Ywbp9pxT7ogePOJGJZT28cgguExfxL+kK+KZb5QydmuF3U14aTflohDDRUa4mZywzIDlT3BE1zQUMpp63TNXRqW4oaly/yQ1bu8N9BSRzbKMKgKSKAjTXEU0ViiS8UIg74rYs9Q7Pz00dj/6RieBuyyOqRdP/CQbNwelWS7CXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745673; c=relaxed/simple;
	bh=EayO3poauy5/rht+2wdYMwLDBTRR4tdjIRay8qW3Xeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQQvDuyj2gmgAONXKi+dcDj/kcj63mBrtRrSgWXjbmPSqqTx8GXg+0C63tRp9UzW5gA0ye/lpZ6bhwcfGAB/ox0B3++4S5L5vQ3IaP03pxdssUpD7j1PfoWn9QiWPBYe8awtQpY2ATDsg5kBuH1fren2TIUGNJr7zXU9Dv+NGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=HAsTprHA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa68d0b9e7bso140593366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1733745669; x=1734350469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJN+RDGJvasm5eLSW6rewyUE2UnqBa7DZC8SLRN3C/Y=;
        b=HAsTprHANCgQ+t3XVQLmEIFv9nDGiALvmFL0chTgKcWI+RRMsHBd87QM6Im4Kqmift
         04JmHuNbhIGlekInf8WTVifv+0UIEd4/seYle0hhYFD8BgTuU6+vwf6fAFEasOwE15qu
         eyIt4U7OI/DCffAgYdEzlTTA9lw9Y7TCMVEx1uESynmdTNASKfXx9unmiMqZj4x9VAdP
         6+R1F5a2SHu7HWvHD/ml9+YxFgHMDnJobDlT80EQl4NMhlGaYW+SIER0NA2Fb+DsUYRM
         AyEagYDDE7Jf8vu5o1s8ejOH2Maw0IJ/ZY/KkUIVmOEbcER4Ef+/zQVVbkF5hLovcz1A
         4x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745669; x=1734350469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJN+RDGJvasm5eLSW6rewyUE2UnqBa7DZC8SLRN3C/Y=;
        b=aMfdtr6sTJh5LanSJQImJ8F59Q8vSgezQmo63nqvNGY2j0eQt191IudlyYsVdZ3fpU
         AyF3oJCmcZxTwqllIMiTcvxGql72+r/ratzI56soDyK7A+6h+pGGEw46sP2huGcgS/p7
         cqxhg2U+VRS+hysfC3fEFJCSu36BV6tA026UjNrGC0yWdS6kBshGC/EB7msxvkKL1JDI
         jw1Hb0Tdwr5SSlr+u0wEBmzCi8Rw7M+h0LjuhsauFJCHteCbjUMMzlQvwrzxS5cmjYSU
         FzNIHRePVDmXF/6NaO92OFR1lanJkJXEDl4tsPI5LSKqIdWqUdkO5an4irSIs3i9dCYB
         wp1g==
X-Forwarded-Encrypted: i=1; AJvYcCUE+mV/rytjl2FbmZ4bHbLu+Sb11UxauPeg3FZn2OVzna7ATKQ6WWkzrqWchMDrqOcDmaKoumfJDiiX0e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaNoaf6xdBG2U4TzbggJfujJg1Bc22lb3SDiFb3Pfrww+f5QQ
	eukz8+aVImMz8lnzioGj3c1GTYn7YrsiDcPd8pZQ1RSzA6XCmoYefJ5enhbk3YU=
X-Gm-Gg: ASbGncv7vRW1b8S4QCHZCMIozyV93exe0nXmtNqBEmH7HPZbww/eFG4J9xlVgWyjSi/
	1++aatB2tyuRq5L7yWGfZJK9hLR+XJ2RRozspbGGFr4ml1aWW6mRswBHq+zhHRDu6gw4MBtLvn7
	sbBVgBQor7EOS4iKCzk3Bf0h/qOAtAcadmqkncoXdt+LdOSx1+UPfmObdZrKVb9shhpdQeIsi7M
	3vdSTkWwxeMGuIGG6dF0ZyfxB3d4LbNB89XkitdnrAVHhOhWu6GkCAvI1UBqiMsYp5ehYvmVqdU
	aH/28OqdKdPcpctXSU2AJSiml3EKlQF5E3j94OUIwS97A1UCfAhxrkCPWPbIIiCIXw==
X-Google-Smtp-Source: AGHT+IF+p9gVWhFaOEldkR3XDKLXXb1rK4KX30ftSf7RjwBOAfR7BnsNTeQR8MNatD02QvNHIJdwOw==
X-Received: by 2002:a17:907:770c:b0:aa6:8160:8495 with SMTP id a640c23a62f3a-aa69ce00080mr4712666b.42.1733745669239;
        Mon, 09 Dec 2024 04:01:09 -0800 (PST)
Received: from [100.64.0.4] (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69afa395csm22555066b.71.2024.12.09.04.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:01:08 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 09 Dec 2024 13:01:05 +0100
Subject: [PATCH 1/2] media: dt-bindings: media: camss: Restrict bus-type
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-camss-dphy-v1-1-5f1b6f25ed92@fairphone.com>
References: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
In-Reply-To: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Barnabas Czeman <barnabas.czeman@mainlining.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 David Heidelberg <david@ixit.cz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

The CSIPHY of Qualcomm SoCs support both D-PHY and C-PHY standards for
CSI-2, but not any others so restrict the bus-type property describing
this to the supported values.

The only exception here is MSM8916 which only supports D-PHY. C-PHY was
introduced with newer SoCs.

Do note, that currently the Linux driver only supports D-PHY.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/media/qcom,msm8916-camss.yaml         |  8 ++++++
 .../bindings/media/qcom,msm8953-camss.yaml         | 15 +++++++++++
 .../bindings/media/qcom,msm8996-camss.yaml         | 20 +++++++++++++++
 .../bindings/media/qcom,sc8280xp-camss.yaml        | 20 +++++++++++++++
 .../bindings/media/qcom,sdm660-camss.yaml          | 20 +++++++++++++++
 .../bindings/media/qcom,sdm845-camss.yaml          | 20 +++++++++++++++
 .../bindings/media/qcom,sm8250-camss.yaml          | 30 ++++++++++++++++++++++
 7 files changed, 133 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
index 9cc0a968a401836814560c1af3ee84d946500b4f..3de2a3d2b5b761106975aab65ff614b2ef579ef5 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
@@ -94,6 +94,10 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -113,6 +117,10 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
diff --git a/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml
index 8856fba385b1123d748199b46c5009c97700ad9b..6d776b0ca71140c0816b246dbaf41ef376205bba 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml
@@ -112,6 +112,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -131,6 +136,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -150,6 +160,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
index 5cb0e337ea6e4274dbb75b7b25a9b4ac44069cfd..cae4c4f19574be30e8a9f8ca08f26d67be1e455c 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
@@ -116,6 +116,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -135,6 +140,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -154,6 +164,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -173,6 +188,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
diff --git a/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
index c0bc31709873c20b63c011148394f10b45c1655e..f9e3f514c61bf6fd48e15904b62b59c390e63b20 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
@@ -143,6 +143,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
@@ -166,6 +171,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
@@ -189,6 +199,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
@@ -212,6 +227,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
index 584106e275f67aca814de5dd70563d395305399c..a3e2ee7f643d2a8c1490b4d02e16e509cf85f85f 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
@@ -122,6 +122,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -141,6 +146,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -160,6 +170,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -179,6 +194,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
index ec4380a0a03f7dce2539085e24d9d9ec7205e825..98cd0df4570ed168fc1495619c408c4fbaac66fa 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
@@ -109,6 +109,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -128,6 +133,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -147,6 +157,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
@@ -166,6 +181,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - data-lanes
 
diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml
index fa5073c0fd1efaa94f171e4ec26b918d8a5261d6..c95533ac92002c70efe7ef56ab2712565a5a7297 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml
@@ -129,6 +129,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
@@ -152,6 +157,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
@@ -175,6 +185,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
@@ -198,6 +213,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
@@ -221,6 +241,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes
@@ -244,6 +269,11 @@ properties:
                 minItems: 1
                 maxItems: 4
 
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
             required:
               - clock-lanes
               - data-lanes

-- 
2.47.1


