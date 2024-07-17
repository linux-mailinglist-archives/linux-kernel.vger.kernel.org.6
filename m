Return-Path: <linux-kernel+bounces-255037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A55933ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19F21C210F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B341802CD;
	Wed, 17 Jul 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hH22ulwa"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A91802AA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210781; cv=none; b=Svjp+ol4wSPSu0H11gpSkN24R3+VYuGA4zMPJkWxGNZs+1jREB6LW0Og27vUipC+jgRSOp1RhhHXiIwoNhyUE/Dut79WbYsnNkerhtzQOVUKF8Glxr3G1VST4bb3t7nIVA5LklUULAMShPpbN7+qcvZ2ClrdyyXn8mCOZtK/a4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210781; c=relaxed/simple;
	bh=NPsqQscMuW5YxdzEEbmIthLqN/ch20zn6EmqZT04SCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGQswzQt+xo7/+8wzp3fiHZifCCWcoYluzv4sDk4BwZ8HzWm9VSFImKRpFd7J45MiFMVVsYMp21GMgjY0V5jDfLK9htDlzMTCi6Q5AWqEfUDYxia6JOurnJ3oLP+icjdUv6H7Thp0nkHuAOOhDHMLUcYR1gdxOHhfkHUsEiughQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hH22ulwa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e99060b0dso7051407e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210778; x=1721815578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUM4l7NxU0k5uScQq8IEESiLEEWEEaqTyJJqCnIfkQU=;
        b=hH22ulwaOECnt+ra2JgoxXxF2fB/WkhWD2kyjH7laUqwX4VuE4SbeFFAf+nDg9SNj6
         LWf5onKSf01d0UXZyVBugAWTATVgFdkASJQC08s+TMzCL5B7pcDuT8XxdvSr1H0JKoSI
         ES7r+zpxtVJ3brMfmY1nP8eYEnOC1toMOIsOuNE1909zvNW5c0fWa+4dDb5e2AKLWHra
         8qU2177WIu48e/ckY/A9NOMFNKzWMmDLaKMoZc68KxLXPiWsJwr8O0d7eKuQNTLZsuh9
         tzYJAKgCMH9fgMhwoLLqycJAuDWaMd6KmaJiuhUPkTwphcLw2XIKpP5oJYVOI4Wuye85
         +tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210778; x=1721815578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUM4l7NxU0k5uScQq8IEESiLEEWEEaqTyJJqCnIfkQU=;
        b=o/qkytFAD7U0u8m9GMih9Cz0qmxMkHUO47GervkJF8znYAWR/EwNIr9KWi/tKppn1H
         lGBFsgw+caRbX9aJe9rL/5N++cod61SmzSlv2wkmXv8ddcJc9H9JCjKCwDXCml+9xm6g
         9ktOmbQk/SxGdF5JkSztXMheYHA/5ILsgB9bL7CBVBqty90G1v780D88L5ogjFDUHqCO
         OwPKoizS7B4gvyubKZSjSFkBoe5YmC8nfAxMF4IPULB4HcqPbPAaLiyVasJlrKPnLsus
         gHB1oBOtKdWmq4xdmArCK1JvMpIgUGyKTtXCBVyW9IY/vxPMWHVIKe68kDT1bs3Xslwm
         zLrA==
X-Forwarded-Encrypted: i=1; AJvYcCVq0Vwrgwg6XfhOS+Tig3Zy4K2+D7xtBxAOQ1ZgS3SjKjBfMt8K2sjw8i48W7voLmkbxa+iWLG5QN1u2S/KvhflqQwYnLrfe5SG6QQ4
X-Gm-Message-State: AOJu0YxIKhk7ZK3Z/9uqI9/VbBvEN4OPJwt4lqc749vp40TBj1l/hwxY
	xq8kJ/UCwdqjvALnRT1QARsYv7lprHxGkeMwbi37T8prCi4FoteZkUz9rkQi58E=
X-Google-Smtp-Source: AGHT+IEe4yKshdC5XE+lx/x85DHFDZdE9loIV36IpUydrc0hetViduQoJf0hlM7zxq6mGlyq62Jz/g==
X-Received: by 2002:a05:6512:10c5:b0:52c:e180:4eba with SMTP id 2adb3069b0e04-52ee54420a9mr832688e87.62.1721210777867;
        Wed, 17 Jul 2024 03:06:17 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e983e7sm163259245e9.23.2024.07.17.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:06:17 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: ata: qcom,apq8064-ahci: add to dtschema
Date: Wed, 17 Jul 2024 11:03:07 +0100
Message-ID: <20240717100600.19005-3-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717100600.19005-1-rayyan.ansari@linaro.org>
References: <20240717100600.19005-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The APQ8064 SATA AHCI controller is used in apq8064.dtsi, although it
was not documented in the old text bindings.
Add its compatible to ahci-platform.yaml.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v1 -> v2: added r-b tag

 Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 2c8fdfc3df9b..ef19468e3022 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -30,6 +30,7 @@ select:
           - marvell,armada-3700-ahci
           - marvell,armada-8k-ahci
           - marvell,berlin2q-ahci
+          - qcom,apq8064-ahci
           - qcom,ipq806x-ahci
           - socionext,uniphier-pro4-ahci
           - socionext,uniphier-pxs2-ahci
@@ -46,6 +47,7 @@ properties:
               - marvell,armada-8k-ahci
               - marvell,berlin2-ahci
               - marvell,berlin2q-ahci
+              - qcom,apq8064-ahci
               - qcom,ipq806x-ahci
               - socionext,uniphier-pro4-ahci
               - socionext,uniphier-pxs2-ahci
@@ -105,6 +107,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,apq8064-ahci
               - qcom,ipq806x-ahci
     then:
       properties:
-- 
2.45.2


