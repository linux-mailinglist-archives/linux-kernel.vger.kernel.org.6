Return-Path: <linux-kernel+bounces-561542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C62FA61347
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C8178C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E19200BB5;
	Fri, 14 Mar 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNfeafim"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7A1FFC7A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961028; cv=none; b=rc2shDcqybrjclWgP2fnMrO7XXcD9GXJSqsGP36xG5tsCc0fwp4b6KqbnYlaipCu5CR0DN42/sWd39gt+DzyyUZ8j/h9UdJhLFYGr4kw3oZOpeVW6zeEwCg7I/ksGCNv74U0YsfItNl8Z0yijyyzR70beom5LrEgWNUPsUlIH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961028; c=relaxed/simple;
	bh=DF6LBm7oBQoMFX+SLpJBlp0Dl8XtrOzdWQmhNfaOJK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpdR6Yy+SmsU8HqGdanU0WkP1/qrQOSwq8je4zWnln7Nds1YF9Mi27UhUXKqxy7XoSEZ/aTnp0ZiL4GxM8Mv/K2UfFGU98HWJUFVmfjPcd/F153l4wFetWsvdSaEq6wu8lhqaC35B0r2OZ64eNCLDFlszzesUgGPKez34DYe0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FNfeafim; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so19221575e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741961025; x=1742565825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mrs2pi/IR80jSTZMZiwbcMuogKUEOta3sRCRaBeIlpM=;
        b=FNfeafimwnGu5ssoT3SEsr57SHzKNkcjq1lAdEM5gRkU/jBp4JC4EmdPvKamcNLP6m
         iO8G/xOx8kMTGLlT5ahCRxaeFecV8URUvTcJ3KdQ1gTrwPOywiqNlHy/7/B4H5O6tm2R
         ZiizeUXFNvb6C+PCpohoo3LfnhwNwimtCL8pAo/M/FXCnLtKKOZY8UdQMNgrN/ex+YYk
         Oq8EZq3dn3pieJ8W2bbXHhsNzxUk9nlbpAZn7g+Z+lDxxHx41d7XvZ27h4EDpoud8hRE
         BRBIxQ7xqKyOu4mejKt7geOIuPrrlUdsbVNEPHeT/tf3Q3K/MqEoVeFr/2dJzWJfnnjw
         ZgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961025; x=1742565825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mrs2pi/IR80jSTZMZiwbcMuogKUEOta3sRCRaBeIlpM=;
        b=BUnp5p20gtAgD5rIlPfDi7zvqJcXB0ZmM0oav72d437YSCojdZ3Wx0CtU/R/v7R3fM
         l5w9U1k/yXAdIxatI2e364QwbNGyZCxuAciKNtk+oxKZ+RzSWfzC2LpgQIsOQqzkH04Z
         QgmYJ/RnvmyHRItJQkwUDo3c/0W9gKdGhiU3Ty2hgzlQ7DFx445oNqwo7fN8ojquBIOM
         vaK59CsyuMnxPBjtt0wNGthu3DLCfsUdGcdnG4rS8B7inQA+z/i1Llr/N+K8eWbc1Wgd
         /XChQG3lH0mJpRk21fMsFrLFafnnykHYpfd/buvRGNFZfzaJR1e/68pEuU/HURqEKhDG
         cg5g==
X-Forwarded-Encrypted: i=1; AJvYcCWpsdErorXDipbVr6j++Ai1wj5Zv7rG7HpmqSvIFqW1+niNriSRXApwjLMwT/8Ai5wvA/FwG+0vxDNfJZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjomIBDK96TTZPOZRCevV7OVccDKiuxT5KEtwlfbeJke45vvSH
	Ey+rlqpTcfqkLTrXDpBlAWwanuFtmADd4n1xLTDBQrgMMQf5AlFMhdX+cWlV9mw=
X-Gm-Gg: ASbGncvXnNHuxU8bNBmmVBBg2J90VlIW+7bgcwhzcQkglClOfZRIdgRgNrpTbE4u9sM
	G4W3HNgatB4iNfG7E3r2dvWuQ2FjS4wpEO5zzXbaKLMqMdPmvlRXbkwby6XcqfmMxjkz8BgXuxN
	p03DW63E3sTtvjBXXx4KuN/TJNIwO7KYBGYf9//uo2a+zS8ThungYQDGzvSI2Mx63YorUees/3s
	DFPiyqFEHi1Jo9ldJ/EAXk2X+loVdN1wuRJwzJ+vGcawlzqouiXjJKfCJh+lgzXFbY7pV1ryWMS
	0M4o0sxa1GFQhya1fIeWhmRbLxrH3fDWG1mpL8LD8Fs=
X-Google-Smtp-Source: AGHT+IE5MmqvNVK29oXVp5YU+GxENy/l3KYf+hYkaIt3jW75ricplBKSUTwse/i4MPM+8TgKs3dyZg==
X-Received: by 2002:a05:600c:4f87:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43d1ec82c14mr33789905e9.18.1741961024508;
        Fri, 14 Mar 2025 07:03:44 -0700 (PDT)
Received: from hackbox.lan ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fae32sm18156455e9.31.2025.03.14.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:03:43 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: arm: qcom: Document Lenovo ThinkPad T14s Gen 6 LCD and OLED
Date: Fri, 14 Mar 2025 16:03:23 +0200
Message-Id: <20250314140325.4143779-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314140325.4143779-1-abel.vesa@linaro.org>
References: <20250314140325.4143779-1-abel.vesa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the difference in how the panel backlight is being handled
between the OLED variant and LCD one, it is required to have two
separate DTBs.

So document the compatible string for both the OLED and LCD variants.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 618a87693ac1..6260839fe972 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1123,7 +1123,9 @@ properties:
 
       - items:
           - enum:
-              - lenovo,thinkpad-t14s
+              - lenovo,thinkpad-t14s-lcd
+              - lenovo,thinkpad-t14s-oled
+          - const: lenovo,thinkpad-t14s
           - const: qcom,x1e78100
           - const: qcom,x1e80100
 
-- 
2.34.1


