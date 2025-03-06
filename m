Return-Path: <linux-kernel+bounces-548511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAFEA545D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626EA7A23D8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595220969D;
	Thu,  6 Mar 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LV7UTtU2"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701C20897D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251927; cv=none; b=hsebbONuPIZUS7wKC3kQugzRtq0MS7fjIMqCjVSHSe1s6a6Tx+Jlim2TPH74rffkc3mbtQWjOxSfYhYAh+h2RYj0w9iPEc3gjDxHqVOQU37TDmas3u9pfPbJL1Kew4wOrMrMML4vGvsBzXywskENQ3BvGpuP7zS4Z/EJZIpCiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251927; c=relaxed/simple;
	bh=p1PjBgzx6b5CCqqsstRRWhCBnA7J6btvkzsO7hVie44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAMgzykjgROa1sLLW3/CpV4qT342vSI183h/A4YOvNCg76YOpDQtinQAlpp+R73fH+LFfqUfAQ5kCFDwRfxbSzMdBgLROS1C+Fi0sfPzkET8xJzMytF94k8dBIxurpycMk8I4/pV1+v4Jq1yAk/UKULQVIQVdErRrM9ui2hRxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LV7UTtU2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso82662266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741251923; x=1741856723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrQjM7IQyFKyZiPXOT0aMP5QicIarZ+wMT6jNBpqAVQ=;
        b=LV7UTtU2ImR/dUl5/fulpt4FqB8CUfSnXdTK+cY9OWe2QARhaD9RW+q2yGUydQZOHT
         M7b422T/MqIiDgdSiAckm7M+cyVEx+c0pDhMgdLkIevi5mIZVcrnLW5KOXlBkT0psf9U
         2WwjND6hkCdQ5nJcIUzy1Sr1MbdSrdiPGTl4JcV8q3zZ6F1Kwikbx05pCqEJnzlGqkRx
         fYXJnWfE//vYBc+3ckfrgPdn03MsJOrqvM3bn+lJU4tZ9Xvll7TdPSYAk0HkIYYzlliR
         nFs3emTmgo4yzEgGkYP2Oj5jRHxsCeD5mpkC1VSMlxZV95NYvIjdAX+0qQx/jolGEi0I
         RuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251923; x=1741856723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrQjM7IQyFKyZiPXOT0aMP5QicIarZ+wMT6jNBpqAVQ=;
        b=HhJ0NrdrTdLbBI/kUy5zEj7mZNpXyGsT6VVXML/Q4410aCfuU3MSOmW9L2PEFQYQeH
         k1cFGwC4hzrxsVDnZ3Nq6PwNImaUN83KOe2VWXPJeVRvLb7HHgGvLMyspy5/bJVC8XO1
         YpzhDwuqUYvRzwoRCCvL6AQ24GurofN5pIZX1D2f/mQOgwdB+Zr5x6FEG8SOjODT/Ylp
         tN6XhLR1K8CiTEK4g6y5/rMEurUYgYKCrlBokHOF7yGogYSTrLw3limBFEQh3pdNUkp8
         nC3uan4grYVvtzHOTOhRL4HwZYEQtEEjZEc/cUWZYNF5E7kbTaCUBVo3yOJj/Z7ZkFhi
         Ko/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPU9/fzINbuhfjeb0c4SlMsR5cPrO8XIs9voXRqH4kbDJCe9GaDfPQjnxDxxb/ffFoLmG+pEaU994oGek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDCJzbQTTBmVadD3DTdumD2KsV3zcJVLRDRIMsS/oWoY6t2dA
	KaPVs5eTG9KbGmbUHTERziv4FN9fSxZHpMMacjbLMRtze7ILZ7vdTWBVdUL7B2o=
X-Gm-Gg: ASbGncveVekExtNywByf4oi+RFxKfVqW54utFQi98ofQS3e5B3Nr4fPPyoDom0+x5Wx
	lC2dZ3KEZgRSjy3UmmF/HLThFpvqGvJ36Cdq3VSJz+mNLmGuxUIppIwnIBVMA678PT5bm2jzsOB
	BaDrtnsLbbo+/EfxqsXXgYYjXsio6tISwCwqV3RUtQ9T7SoawoaeEir7vyeEvUbK7Aw/gr0tl3a
	AH2yaUTVieKtsQua3IUfp7SWZr+xTIRsaJMhI7juEhpN+B2FGP7g5Ti/FMfLcT1uk90RAd7W1UL
	WlJnUkw0BhFtrkuBqb+Nm4RDnfIQMfgRYjJqbjajhtg=
X-Google-Smtp-Source: AGHT+IEGjkDNOrIByxVzQMvdZ3yuv6/fOpZUz6eYYP4NxiiFaRGnAEn+bVqc9B5Gr4Dr3tphGX8DzQ==
X-Received: by 2002:a17:906:cc84:b0:ac2:29cf:643d with SMTP id a640c23a62f3a-ac229cf6594mr206934766b.25.1741251923435;
        Thu, 06 Mar 2025 01:05:23 -0800 (PST)
Received: from hackbox.lan ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943a194sm61606866b.37.2025.03.06.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:05:22 -0800 (PST)
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
	Sebastian Reichel <sre@kernel.org>
Subject: [RFC 2/2] arm64: dts: qcom: x1e78100-t14s: Add OLED variant
Date: Thu,  6 Mar 2025 11:05:03 +0200
Message-Id: <20250306090503.724390-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306090503.724390-1-abel.vesa@linaro.org>
References: <20250306090503.724390-1-abel.vesa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the Lenovo Thinkpad T14s Gen6 is available with an OLED, add
dedicated a dedicated dts for it.

This is needed because the backlight is handled differently for OLED
panels when compared to LCD ones.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                           | 1 +
 .../boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts    | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b54f45b3bec8..df8d63560d06 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -290,6 +290,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e78100-lenovo-thinkpad-t14s.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= x1e78100-lenovo-thinkpad-t14s-oled.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-asus-vivobook-s15.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-dell-xps13-9345.dtb
diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts
new file mode 100644
index 000000000000..1891f6143ec9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Linaro Limited
+ */
+
+#include "x1e78100-lenovo-thinkpad-t14s.dtsi"
-- 
2.34.1


