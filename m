Return-Path: <linux-kernel+bounces-422951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DCC9DA05B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925B4B24885
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD2129A78;
	Wed, 27 Nov 2024 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgwYWkVF"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB1147F4A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671258; cv=none; b=H6Dn23bQ4P21e0HnOOXDbH5c77hRR5kzUwzkMLMaxDJgisln19gy88fa9b3jaX55UA6/cmYph1gvIcnOwqwlQrc76nmdAhx7YBZaRkl71SxJ62CCtixGyx6gVjGYfCxKeeSET9ttLNUsUAJIPbdiusZuvAQ/8Ja0JQz8W/+BjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671258; c=relaxed/simple;
	bh=99UHV3yRrYwP8P3G+lZ+/588SwSA7ZRGY4x9MpPEZKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCSYtYmIMCvwbNEsKj05IpzKVpXGknd3jcS4EymCw3Tz/kkX+k5bq4kJ6M+W+/glGKAbUKiahHWIMSLz/VRjzP01Nm19ywlBnztiU9VYHnbs7b7w1knQl664NELX8enUXkQtZTeB/S5dngQYXkMdMgTBeuKPvxZiK/sKSidUSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YgwYWkVF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3822ba3cdbcso3889328f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732671254; x=1733276054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvU8sExnaozjCegc6xHW74oP1FMeAkd0rv4VFUktFHk=;
        b=YgwYWkVFYUKBAgAaFNVCXCv3B0ecnXC3uB/FV1fjmDwQhk7kG+iRbfNpgP3t78QLbm
         jesgLmJ8kGAdTW0dnOJdPMiZ8S9X8zWPNIVbKwc/ERA1l1RfRPH3BIxKZ5vVTDxqhy+m
         /3jGIt9dYYbahH5duzLrT8obUQ0STeLMrNlb6xtofMm2UcisnvPtmk3KPj4LbCUEL3JJ
         gLSoHHQggVE/4nh1Zf1j+QlZP9XzWp0wLUKPbKq5Llrt2kRmLtBgz2VpQoHQWQ7FYI8G
         5VFVUXHwQsMEzGs1FpHp/SZ9xvJkMtKJoSftxeRYrXIA5Yz+Sh18cl/ZZ9/eIGHgkKim
         k12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732671254; x=1733276054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvU8sExnaozjCegc6xHW74oP1FMeAkd0rv4VFUktFHk=;
        b=k3ZovppmPfAv7AJhJCf3hP/0i6v2f5sZ3lleDSKHVZrJPW2R1gq9iGYUuQ8tRoDaEW
         CCpfHS57r/46dDSCh0DAVJaEzPh84vnlzoUBL23eot5lvhMHosu9dmsjl6LNodJ7orlH
         5K+8gtfbYbSOvMQJqowr0c1AYsd78zdiTD5Yz+2XKCd9OrelCCczjrxEAfNinaUACQHd
         T9nEKqaEZorEobOoFOZTjvE96I4rKK3tdsEf0y4G6s/FagFFOb0hYsKLcTFXchHToPyF
         1v5YeqK0KkOAPgJnWcbD1BJIiv8gE5Ei/MmjQq1IJ3FNCa98PugNuNG8aXBzD2DZnMqq
         kvlA==
X-Forwarded-Encrypted: i=1; AJvYcCWIVRN7ztsWj16DGUSfIbbVOfVk1EL80pXFi3US+MK6T1zHUVTkSiL458UJi0uqDZ6yJcjbZPyInGWNNwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8p1vraYLQGTjUNr4odJ+bPSmngrkarY+rvWHpgxm33Hxxl5iE
	G3bpXtTfymGrMCI2d9gysEWyYE0pjApK+QhHpBIdGJ1IzZh9N5ZUyyyAshs7LqY=
X-Gm-Gg: ASbGncsNhs/wnmZbUV+XelJzIRJ0blPWhpR/hFEM/+UjYDYjrXamc4jkwIMcigZ4ufs
	EoUYVqIcJKKNz5KdPxvZe7IqWtiWZU8U9/f/qNjLqUzCZXlzpkPSHAsZXc7FVU51x2kVGCJw8Fi
	J8ekACcPJWLqbXD/ybZJ/2VNw6fXLmqELrIesXKwn8/UAwtvMnlapn6A/ouCcdvJXgYwm2ok/fH
	0n49Zk8atO4kRgvfO5XHKjbMFOHibo2bYHrF3AeK8Slvk+fP5oDrnQa3n8=
X-Google-Smtp-Source: AGHT+IETcR+SnROBxBFdvZ5aejUS4KPNx66kxhGGbCsqn75MjUH+vludldR6ubFHLpGOw6j4fyxGqw==
X-Received: by 2002:a5d:6486:0:b0:382:4b5c:419d with SMTP id ffacd0b85a97d-385c6ec1125mr778528f8f.28.1732671254649;
        Tue, 26 Nov 2024 17:34:14 -0800 (PST)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc42b3sm14848641f8f.68.2024.11.26.17.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:34:13 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 27 Nov 2024 01:34:06 +0000
Subject: [PATCH 3/3] media: dt-bindings: qcom-venus: Deprecate
 video-decoder and video-encoder where applicable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-3-99c16f266b46@linaro.org>
References: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-0-99c16f266b46@linaro.org>
In-Reply-To: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-0-99c16f266b46@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com, 
 quic_dikshita@quicinc.com, konradybcio@kernel.org, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

For the list of yaml files here the video-decoder and video-encoder nodes
provide nothing more than configuration input for the driver. These entries
do not in fact impart hardware specific data and should be deprecated.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/media/qcom,msm8916-venus.yaml        | 12 ++----------
 .../devicetree/bindings/media/qcom,sc7180-venus.yaml         | 12 ++----------
 .../devicetree/bindings/media/qcom,sc7280-venus.yaml         | 12 ++----------
 .../devicetree/bindings/media/qcom,sdm845-venus-v2.yaml      | 12 ++----------
 .../devicetree/bindings/media/qcom,sm8250-venus.yaml         | 12 ++----------
 5 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
index 9410f13ca97c181973c62fe62d0399fc9e82f05d..da140c2e3d3f3c3e886496e3e2303eda1df99bb4 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
@@ -45,6 +45,7 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
   video-encoder:
@@ -57,13 +58,12 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
 required:
   - compatible
   - iommus
-  - video-decoder
-  - video-encoder
 
 unevaluatedProperties: false
 
@@ -83,12 +83,4 @@ examples:
         power-domains = <&gcc VENUS_GDSC>;
         iommus = <&apps_iommu 5>;
         memory-region = <&venus_mem>;
-
-        video-decoder {
-            compatible = "venus-decoder";
-        };
-
-        video-encoder {
-            compatible = "venus-encoder";
-        };
     };
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index 5cec1d077cda77817f6d876109defcb0abbfeb2c..83c4a5d95f020437bd160d6456850bc84a2cf5ff 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -70,6 +70,7 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
   video-encoder:
@@ -82,14 +83,13 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
 required:
   - compatible
   - power-domain-names
   - iommus
-  - video-decoder
-  - video-encoder
 
 unevaluatedProperties: false
 
@@ -114,12 +114,4 @@ examples:
                       "vcodec0_core", "vcodec0_bus";
         iommus = <&apps_smmu 0x0c00 0x60>;
         memory-region = <&venus_mem>;
-
-        video-decoder {
-            compatible = "venus-decoder";
-        };
-
-        video-encoder {
-            compatible = "venus-encoder";
-        };
     };
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
index 10c334e6b3dcf25967fa438f8e6e5035448af1b9..413c5b4ee6504ba1d5fe9f74d5be04ad8c90c318 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
@@ -68,6 +68,7 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
   video-encoder:
@@ -80,14 +81,13 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
 required:
   - compatible
   - power-domain-names
   - iommus
-  - video-decoder
-  - video-encoder
 
 unevaluatedProperties: false
 
@@ -125,14 +125,6 @@ examples:
 
         memory-region = <&video_mem>;
 
-        video-decoder {
-            compatible = "venus-decoder";
-        };
-
-        video-encoder {
-            compatible = "venus-encoder";
-        };
-
         video-firmware {
             iommus = <&apps_smmu 0x21a2 0x0>;
         };
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
index 6228fd2b324631f3138e128c918266da58f6b544..c839cb1ebc0999e10b865f4bb43ea76ffa2bf46d 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
@@ -70,6 +70,7 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
   video-core1:
@@ -82,14 +83,13 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
 required:
   - compatible
   - power-domain-names
   - iommus
-  - video-core0
-  - video-core1
 
 unevaluatedProperties: false
 
@@ -119,12 +119,4 @@ examples:
         iommus = <&apps_smmu 0x10a0 0x8>,
                  <&apps_smmu 0x10b0 0x0>;
         memory-region = <&venus_mem>;
-
-        video-core0 {
-            compatible = "venus-decoder";
-        };
-
-        video-core1 {
-            compatible = "venus-encoder";
-        };
     };
diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index f66033ae8b590e7b6f1e344c368994744411aca2..da54493220c9dc90e7d9f5fcfce7590acb241c85 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -73,6 +73,7 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
   video-encoder:
@@ -85,6 +86,7 @@ properties:
     required:
       - compatible
 
+    deprecated: true
     additionalProperties: false
 
 required:
@@ -95,8 +97,6 @@ required:
   - iommus
   - resets
   - reset-names
-  - video-decoder
-  - video-encoder
 
 unevaluatedProperties: false
 
@@ -132,12 +132,4 @@ examples:
         resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
                  <&videocc VIDEO_CC_MVS0C_CLK_ARES>;
         reset-names = "bus", "core";
-
-        video-decoder {
-            compatible = "venus-decoder";
-        };
-
-        video-encoder {
-            compatible = "venus-encoder";
-        };
     };

-- 
2.47.0


