Return-Path: <linux-kernel+bounces-573684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE27AA6DAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80A33AEFC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688E25F986;
	Mon, 24 Mar 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USCzd8Sg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30D25F7BE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821273; cv=none; b=EoprBxl2ejyKy2JdWcXLRYa3a/ed9UaoFamNhJRpAGLS7NNsj7/VuUapNzUc65M9JivOe0Zgs+Vzpyrxh/H8b6SjcFAiiW01gMHr8jrwjGEqhKnlx8MorulvhxnSXdOYKF+0OM32vy4oWnjVG3jS3prO8i/YokOXQlHYMulsaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821273; c=relaxed/simple;
	bh=SaEurHg9my0SgGDfooWj4uP1HnHehhMQjbSphU85xtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrZSGbbJHqYqNJqxXeN395ydrKI1Yde95GBAZfXE1QivXwzJ+C58L0x/BIwANxFJYfHDD3sYEMlakuwAg/vJ5BcT7AN41PWlxBd+kuz2LduLC4PsslLnMjo9zR/G9fjnm5PW24vZ8tZhB0ehHSv7ESWSrVlnZyk6UzFPwHdFb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USCzd8Sg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d45a148so3525347f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742821270; x=1743426070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ6QvHirUebkLT0cLpo0Lkee0nQc81mUaPIyQl+HrrA=;
        b=USCzd8SgUyK+4T5OGNRjWcE9P2X/46kDuMXxngjsxOunZN39YbJ0nNHzx/I4Y2Ss4D
         uXfr/eFZlR9QvLJK/MWB+IYtsjrOH07/WvT3WBOgdsZXaVvLgCkcirV12cHBS075ZROx
         PZ8C5GQAJwz9Ga0S8tkgTNCSzw3PpqNElTpjfBRatFnENWDzGkVPlD8BHDUQsi+8hwXa
         3KF6Tb8Y+5uHYRC+LKXY1fW/QqNwcMmeNhChyM6S6/zZTEq+by3D9/QCUmr4R2ofHqGn
         JLf+sedF0UJW3G13D+wN0NZbEPFI6UWGUdSCoOQ+DJhlNPr/wVBulBkhkf0urATb4jRv
         HqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821270; x=1743426070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ6QvHirUebkLT0cLpo0Lkee0nQc81mUaPIyQl+HrrA=;
        b=HjfJmhaIxtvEwSLrwrM1g+5FFkGtQ/esABI3jCCdFWkTVgEwLQ19JtYVbu/+pGOFeM
         svygWcUSOu0LpxxiyQD0R0vu7jUEmGMTer47of1hTNDefyJvjOOuU1pKAso1LZXhIsdV
         xwHRq9DEFYqgKeNZTVq+QTiCCmetRSRBn6UAOwLfARTtTOxe50lGxcW5dOWOiwRYJX2z
         6wrPXavex/aEyPEZAgQa9LJKiaD/Zckey6EKOki+liBxcHj7Xoini3B/n7dJu5Q9kaBp
         vC/WNVAGAv9C5R2MW92JGPmVUDNiva82kGF6jlScy1YOs20xKgGqrs4sMByxaQCWTbss
         iW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzOLBL3O8FW4kTjgxmcE7TmDflvOmfkac8ADjJWhXL5JXvbzKSidsR/NP320NlQ1DhjLtIUdlH+Xyooag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCpHgpawYcIBpPc6eFN1JOrMzxOZzRhhcRDPL3Do7b9PNmrM81
	xj7LU22YNqk8AB7tbFhvfPrY5Qlxhx+8DoPcNBTMhwymCuOMyNSN5mzPzT+K3Xo=
X-Gm-Gg: ASbGncvGzQEJR76QlU5VAbpji/vXD5id26MorzLHoYh1c3amNG90I/nM/3n12qmrs23
	/AjAjK0NLO2REm9IMTMlOvMPUh4ZCl1SSxhORiiWrkh+T6fa1U/lyC0Z/gIF0ZeMrcwW+mKQmRI
	dFtPHmRF/mb4agyb2EUV8Bs1cgvIyhl/RJltXrydAYY20qjBAUeVEzPVww7I5ZZit2fMzzr5c0C
	VtO/73GxYa/rTFAE5ylonkkmDIp2QlWsrkf5fOEeaVorZ26pqCufQMszHIwACaHQmfS+1tMANes
	D/jtKgoVa/n0++aMKvvgNRBXy36uMhbIxStYKF2XR0mkncE0PkQqF/RUBciRJlKXI2R20U/YCWm
	OtOpS
X-Google-Smtp-Source: AGHT+IHcZdjKo+W60+E0889CUCSjzvCnQTNGHROcaLcw11SC7gzeWcB55np64KwhSuLoUJuyekwy5g==
X-Received: by 2002:a05:6000:2107:b0:391:3d12:9afa with SMTP id ffacd0b85a97d-3997f90391emr10016304f8f.21.1742821269598;
        Mon, 24 Mar 2025 06:01:09 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd1c7sm122275975e9.40.2025.03.24.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:01:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 4/6] ASoC: dt-bindings: wcd93xx: add bindings for audio mux controlling hp
Date: Mon, 24 Mar 2025 13:00:55 +0000
Message-Id: <20250324130057.4855-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
References: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi mux is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable.

Move to using mux-controls so that both the gpio and regulators can be
driven correctly, rather than adding regulator handing in the codec.

This patch adds required bindings to add such mux controls.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index 10531350c336..ab1c6285dbf8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -23,9 +23,15 @@ properties:
       - qcom,wcd9380-codec
       - qcom,wcd9385-codec
 
+  mux-controls:
+    description: A reference to the audio mux switch for
+      switching CTIA/OMTP Headset types
+    maxItems: 1
+
   us-euro-gpios:
     description: GPIO spec for swapping gnd and mic segments
     maxItems: 1
+    deprecated: true
 
 required:
   - compatible
-- 
2.39.5


