Return-Path: <linux-kernel+bounces-423373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A7E9DA682
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFB7B2C180
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000031F12FB;
	Wed, 27 Nov 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1Z0kSbo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1B1EE00D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705307; cv=none; b=tcVkIC1i70oboKISP+gveqVvye0alaw2Sa2M6YC71oyq93S/+mumn38cIU33nrnrqFqbRuulkikzSaWIejsCuA1nQAlEEUKXMHb3BiN4jUK9Hyh+McIJBlLo8sMh8dcXN0wbK077V4KThttRBWFcWkoWqNwy4HPx5iLzCgFrgvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705307; c=relaxed/simple;
	bh=Fx6JxYmZAWNFmGBaodns3MA1Cp/zInnAqGQR08vTJZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DL5gqO1s9nXp3ZnzbJZGrfqqP5Q28LSNWVNozq3Mw62KLQwnYS2euxyiXjuLr10YrV6oKzaGRjLiJf2mWCVPw7rR7pu34I0vpq8enVexGGR6aVHpfGrMIq6Fmm72nwVuGybC4CKx71Mz9nThY0X66JV+YCUQjIEq+23wY3d/Z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P1Z0kSbo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa55171d73cso126155066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705303; x=1733310103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOjDTz5quesA/57iR2U9/Cgnc4v0qy5hefL79EGSNfA=;
        b=P1Z0kSbo2mZaFm+sR7yUylpf7IO3m/SFtHR3GgHKgAZ5df+7O1HsypqJ6Jq6hVc6e+
         ixwJbebmPt4arP9UlrvR4wfFEucyB3LZji58ZDMeZ5OZ8/qjiRrYFooQLaSgS4N5BzaE
         N2LfQaTRfeDHoru099SXdt9d8nRmwLXFy/9kctIJwGcys5QQdKH7lhHYQG12WJveEpdu
         rvmC07krAEOpp/CjiF3z9mEA1Y8DP/+vtHfKujoTDhxKM22RSv8THMLeJA35YCWc+fG2
         lHd7mKImA6tzGGeSGez10MJl3Si27rKZFoAeOGCV4YThNKjosIui6+/9Wvkvk3lmrCgb
         LJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705303; x=1733310103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOjDTz5quesA/57iR2U9/Cgnc4v0qy5hefL79EGSNfA=;
        b=dro57yc2IJtajEnSC5H17GWXe5hTxB9tAhHUU/kJ98HYKDbUGlX+nROZIh7FIevo79
         ybt6zNBCFqZ5jITXzde4ENPhJNvntaENL1kvuBMzesL2YcNLSwu/5rR4hdZs7Kn0fgW3
         kEQ3iZhtchgyYqYmLFjYRMjtKjNsENxV+F0WLkJZKpfYYGOW5eL7Lyqm0Eb8pTkSVkx+
         3zanT/QtDlbNhBwW+x6ig2tZKb9CkDLc/q/P3A2t0wV+u+nQ8fE/lTY2nRigXndbCSy2
         3xjejXK6cBS5B8p7Nn5mWBolQ5hvt3DJ2Xbu7mYjGkVILxWa9AP8qHd88ViFMtS5j/Ht
         1O1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUG+TERNp7TtxiJ/k9wPXZxOzJX/MVvuD4IJ1/FdPxmrbpBBSsnxlhb27DuPIg6tQ4ffyrNHsj+eHNwKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGA7D9H9VGx+UPU1X+8ae2ukpZfnJR1YX60hIYtbGoewPNcDLu
	mF42t5DxcTM+otcQnzmjkLwJ9SNjXnOyotJzeV+PW5KBJPQLQOdB37kVSB2S6Dm6wDUAI39dHD8
	SiY0=
X-Gm-Gg: ASbGncseroq3LaG/cHQRxOnc7qgadwS4yrKM2SzjhSbG7PJyDq6mC8IRe0cZN2ETPD6
	+JdBae0et/Fz/EyV9cQt9/idUtmQZJM62NZJsynWP4FgcJUU/SsglnYjDPzYBVgmdG/tT8NnQ8z
	2RTl8P4PlbvtkPxs9T1F5D7MmQgbluPYrwXykfGQepCdQviQZ3qZrAXNDKbzwYHWj/PrxqepeEP
	SS2iWPvnYn8FEgg1tOU3kDm2vlQ22r+MkZlkGur4wyF4LGdzBuSRG1yOBir+FqZvVmstBljBVL7
	jdhlJYl7r/JBPmQ8eU1cBw0aQhYUUle5JA==
X-Google-Smtp-Source: AGHT+IHB5KUzcTjH16njBBTQ0xCVSadda6wBBW1QR/hMzlosFVnEKcI8ZmV5cmxHoXIIbnCGjXeWgg==
X-Received: by 2002:a17:906:318b:b0:aa5:1cdf:7bfd with SMTP id a640c23a62f3a-aa57fa99a0fmr256898166b.7.1732705302951;
        Wed, 27 Nov 2024 03:01:42 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b339612sm693762966b.84.2024.11.27.03.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:01:42 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 11:01:42 +0000
Subject: [PATCH 4/6] arm64: dts: exynos: gs101: enable
 snps,dis_rxdet_inp3_quirk for DWC3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-dts-v1-4-5222d8508b71@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

This is required for the DWC3 core to reliably detect the connected
phy's Vbus state.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 18d4e7852a1a..ab016fe9b99a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1302,6 +1302,7 @@ usbdrd31_dwc3: usb@0 {
 				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
 				phys = <&usbdrd31_phy 0>, <&usbdrd31_phy 1>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,dis_rxdet_inp3_quirk;
 				status = "disabled";
 			};
 		};

-- 
2.47.0.338.g60cca15819-goog


