Return-Path: <linux-kernel+bounces-253659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8F6932471
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265C21F24059
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1C01990B5;
	Tue, 16 Jul 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEqDs/i8"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8603199245
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127256; cv=none; b=KpGeJJ/gfs01Qq1RDxnn+YsKfaPRILbPKerUKuCKSckau3KtbBTz0/aqTtrCLyEWkDIR1JnLRo1xaTOdFJ1BsWTVqlTVpNLc/cevmX4/94q+9OvtmS36OccWqztofw8TSASJN4an8wBW5l+vA1PFd+XZ0bmdUafsFiWDaLS9FlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127256; c=relaxed/simple;
	bh=fLnCOcn0YVyI228OI5sEyoJf3tCOMYcmsPToXiA0QJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy/eiOQu+WbyYvLOKCTolHledmamwRTqThLoaDfU7DPvQ8OxjHtYMy1WSFR+/j+MBBwV2uaTXgRFBsoJNwkbRFmc7GTM4SAbhNmqeHNghFqGMQU159S33j+hxvyNNIfxQm+KuTE75oDqRCs2z9xeeb4nHK7XL3T0GCBXyOqgZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aEqDs/i8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3678aa359b7so3860260f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721127253; x=1721732053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06/mGBoVpO/E3PxYGWvGUiycM4NlfZYrcU+JP01aYB4=;
        b=aEqDs/i8dlbeQAeafablfaFLtzNNEZ3Pt4sElSEcFyrIP7YCtqIj81tgCFfBsBT9g7
         Y1VQeKvqGe18DEVpaxOtyBUh5vRXKcdeAo0VOcSI81qDgKyxU0CmpyGtkuyGiMYYb2B1
         kKztuC8gt7qwXCvJ/PXdjr+Zdt0SUzIHSUIYG4Y0ufYN2SuSMVMO6Jhv6b9QCsXY1Hsn
         pSNferPzOSwOi1qHDIBxt3XXA22+E5bv/Hw9/IQv6ClTLSYiJcMKolXfTLr84vLOCB7p
         PMt0AcmWBwqU3N7dYUm9/66BldzBI0jcP29i61/ovPD2fg0plSuSpbynsjStWyMNnYOJ
         JfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127253; x=1721732053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06/mGBoVpO/E3PxYGWvGUiycM4NlfZYrcU+JP01aYB4=;
        b=FUKyxev5t3SUSCWwsuknaW54LC8VdDZRynf4dYC26x5K3xf6NU/xB4wt/4YuvLYtgS
         I6ZdXUtg+lRlmTGwgfusJ2hpIuh0be5y9hLYbMyiSRChbFrF6Hsct/VJlvoxmj4sK1EN
         SrTUH3YpWia5bIcoKEq20p99UFAiQ1feWePlKel9oRvBtsI8aqa5kqeP90n5IBMyXKWF
         Giyirghjol07A8XrtWST3cYw30/gSOJrYzLzc29p5Z0ucc7nNNlYMAIuWpYk0owft7S9
         FVrVCsv4W4oIZEQlSMfnyHdVW4VEi1KvZ4Vr9Kb+cn0rFEOO8LU3ZJAnUGL3LKaSla4W
         rgBg==
X-Forwarded-Encrypted: i=1; AJvYcCVG4BboTlNrZYd7VSXv+nnP7XDOjvKjXnnpuz8EfY5LJ2nzeHKfMivsOVWYRVpnqNFMinIVdZbr5bnwGekGn58H2NCM1DFTmNUCqn7B
X-Gm-Message-State: AOJu0Ywm4Q2E0y/Xje+jRYQwo25ZpjQKSGP/qprQkHgt/ugR8sTAzrG6
	MohKxSpkp3lL8WfROSMlWsnBN1XkuL6WChZMqJY/ano7VEMPKW688D4CAiuf3dQ=
X-Google-Smtp-Source: AGHT+IF3X3X7MG4NMq7wMRsdQiUSxzDLW2vp7H8VSvOxK4xUxE4UVg727QPaetSCY5evGN2ShEnrZg==
X-Received: by 2002:a05:6000:1f8b:b0:363:776:821b with SMTP id ffacd0b85a97d-3682717a775mr1409987f8f.0.1721127253293;
        Tue, 16 Jul 2024 03:54:13 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccbafsm8608295f8f.51.2024.07.16.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:54:12 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 3/3] dt-bindings: ata: qcom,apq8064-ahci: add to dtschema
Date: Tue, 16 Jul 2024 11:46:01 +0100
Message-ID: <20240716105245.49549-4-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716105245.49549-1-rayyan.ansari@linaro.org>
References: <20240716105245.49549-1-rayyan.ansari@linaro.org>
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
---
 Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index b103d2c44421..51624406392a 100644
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


