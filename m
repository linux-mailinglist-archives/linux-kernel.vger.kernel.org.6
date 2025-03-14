Return-Path: <linux-kernel+bounces-561544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2CA6134E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC59017C4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CE1FFC7A;
	Fri, 14 Mar 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeP7m0F8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18A1FF7BB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961033; cv=none; b=NGZgELrvzb//LgUmoELLpk1GOweYgrgPvGFpJlNGeDBmOtNc22W//LPwVsDZA+vWFKyUUy1f8STePwkBLQcT4R4M6eE3tKueCdc3W8amR7fN23s0n6hjMAF2chNUdPvVoRkGl+kUc8W8ISyUsHXL8mRcI3uWtNlZfYlsXDykqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961033; c=relaxed/simple;
	bh=BixFMmu9sTqy8BJKh8iJ1ywxzjkEJgvwb4uK0rEz9Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhiE8sKYU9ZxRJ60ctzmxPcTw6uh06qTdmfN0luKUZOyH3OnLsHtQq8JWO+hPhxRYvnEG+8IXkkF371XRhSWhTpURPgCmspjqdOelPIkEYshC/mjtAJwaFCgH+HsHXCYtLxbM4sduHtviKE/afvXeUPW2NdsA7LnRyEDr905Snk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qeP7m0F8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso20337335e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741961030; x=1742565830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDupoB9dBc8DfN6WTesxBF7iIJOj9N8IoeENJse5v8Q=;
        b=qeP7m0F89nY48CDaXhm6SB0ydRZt4Q5kurjKi3qRCTfuGBWzP5C5KvekpcI8f8LmoV
         XNBee6tGtooWr4hpgS/rHDi1wBZZtg4CzP80oB2wzAWeGdJ7YBY+cwG5f3/WV6s6cn6R
         ysg85bEvliXLc1ma4NblLevAxFva7S1H4mG4++T5nBy+YM9GZV0GcRnaaFoJh0xU2QcN
         wobsagaE/qJLKMMR+g3l64zg5WL+ylG6z0VtQ3BMlwTvSODlg4nP6NozKU3wziT1wErH
         YW+Knz2zNZyxRCe5EnHb5xxlgcU+oX7gr0nmO2Pq+3tcxz7bJFaRGekG+wu91symVLfA
         +5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961030; x=1742565830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDupoB9dBc8DfN6WTesxBF7iIJOj9N8IoeENJse5v8Q=;
        b=wsrGAyXedpZTbOQEudpM1DEhJyhk6valytp4fqDcWOYh+m+uOsXcE6F6u+5OcjL+Co
         QDCVjkTMe9bRZ4EcN958rnHNL2YAgx/O+0zZeSAbuImvBX9jcIrd7L7YmIYYRkr65X4n
         +Tpot9/VN0Zwojwx+vjRxvVa3RCnoFdDMEtN3fSlBKzBifK67afB0q7wsxs+Ks9Je6ti
         gThJD0nNL4PKzLzGtLQitYOCUuAIMjp3BdmQpub+xJZ7Ok4zdA2Gm9fICMFte9ea9kbo
         JXqRO0+dqZh/efkw7ERMB6bDx8F6BP01Nce0hDjS8RMKRa3J8POSJdDzLByKJAPaxnu3
         HWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZvm/T+yln1a8K6Irz1+m9cGFHOxcTeE4Gt03WqViHe8zFS6cMvilZxS3KKHbDrSsAMyNb9qgFMpKtWAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWcjl7AXMh3I5dIaJDpbCLg/tVs4VRv1vrtyOuH98pDng5S3d
	ybkb3GGMapKrATXZRjYm0HUhyX8xnHMiJz0Iz35EwmVz//JnRMHui7r9BWXNQX0=
X-Gm-Gg: ASbGncswvz2b9q7iZ4MMFuRgD3qU4luxstSFa4Qo9NN0kuV8ZIDmlJRppwTpM8jByEU
	TvXYjFfU20uhXQgfy9slf0/R/4Xf0+4m2aNuvQR03EPfo5Xss5qksZQvh7YG+IU2gLH07jmhg5N
	62nmE3sX9fVPb8QcFnBITb0T4ERrF/yVPcQedOK1664wJ4Hz+BhtakOkOJ2WAKXWOPeCWH+B0fu
	oViUue3+gFANHwKdiMsM1EzZo8KNM17fTECT6eD7P/OhCir6zg5aWcyiU03jpURCpK7R4JdIhqM
	BWX+0iejf6ZkDYZ7BqoAgGKb5bpxQ7eD+NfDyrCx4BI=
X-Google-Smtp-Source: AGHT+IHgPJJb1obTrSTys3+K62ZDhJF/Fy0GpflFQd0zruZg8pn82tMFCsUAsrtNCKhRbgLv89dzDQ==
X-Received: by 2002:a05:600c:1910:b0:43b:cbe2:ec03 with SMTP id 5b1f17b1804b1-43d1ecd93aemr31086405e9.27.1741961029562;
        Fri, 14 Mar 2025 07:03:49 -0700 (PDT)
Received: from hackbox.lan ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fae32sm18156455e9.31.2025.03.14.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:03:48 -0700 (PDT)
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
Subject: [PATCH v3 3/3] arm64: dts: qcom: x1e78100-t14s: Add OLED variant
Date: Fri, 14 Mar 2025 16:03:25 +0200
Message-Id: <20250314140325.4143779-4-abel.vesa@linaro.org>
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

Since the Lenovo Thinkpad T14s Gen6 is available with an OLED, add
dedicated a dedicated dts for it.

This is needed because the backlight is handled differently for OLED
panels when compared to LCD ones.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                    |  1 +
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts  | 12 ++++++++++++
 2 files changed, 13 insertions(+)
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
index 000000000000..be65fafafa73
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s-oled.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Linaro Limited
+ */
+
+#include "x1e78100-lenovo-thinkpad-t14s.dtsi"
+
+/ {
+	model = "Lenovo ThinkPad T14s Gen 6 (OLED)";
+	compatible = "lenovo,thinkpad-t14s-oled", "lenovo,thinkpad-t14s",
+		     "qcom,x1e78100", "qcom,x1e80100";
+};
-- 
2.34.1


