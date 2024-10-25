Return-Path: <linux-kernel+bounces-382071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FFD9B08AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8130280052
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED2155C88;
	Fri, 25 Oct 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yICnfuxX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65373157E99
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871010; cv=none; b=M6xqkDhBqyZM1aY716uODtUj6YARaXBtCBoRB8e6T66/NaODKc5MxqsygnlMVYCvxRQ2xq26zjyGR7zDtfUM0DS99o1WslnBpr5SwvKUQlq4Ccevxb4occBIkKR9df6QLtG4VUfW2L9TuB1qlDIDRHnhNKM8Rik92dZxhS/XKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871010; c=relaxed/simple;
	bh=kmTctavQgDHV1WQJ665/sMMhzSlzxhDHLk7W3MfKgRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNiurOHxoj5HsxhxgbIYk99kzxx0MjyKMSL7akwErgWtdOPhDJxLwdmLn92fpO2ov+XfXe1QYOs1w4/dzBBR/gGsmQoii4aCUvZuqcKsU5nzwpxhdKlVU1CAMNkgoXtISfZBfFsh7gbEVvBgNbHI0IAYZWLgMpJeHJOhyKb0AcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yICnfuxX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1861417f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729871006; x=1730475806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A19SWF8cZ8jpezoswd9dTv1UcUhXtoHX2w/uo6Xt0MU=;
        b=yICnfuxX76xo4jvfZG3r1VtICQBjwcR3PzrOTX0dQXlGUhFgazo4f71abc+/UW6pBs
         jhhwyRz9+1bwFXiWQEmDIDgOli0VuuTDcfiVp88CIiebBkM/mdTrij1pfYaLagc0ZYWp
         S2MoG+QUJWxZJLV2XFoQse1csf3qmT4uR7kwSjUVeO5QX2fqJAv+QVRDibQb08RViJQU
         s2aRyZ2r34Yext6fM7+7cdrb5dIDV2qH+/TRpZ8qRipM1Jjc5u/VarvptUwwFKyf7IMb
         jWngaUI1TMW95IB8iG2eDZYuKLGMgX+PkjMmDxTISBBlYDcRgbRTJTMzcYWED19OxlKE
         Vq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729871006; x=1730475806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A19SWF8cZ8jpezoswd9dTv1UcUhXtoHX2w/uo6Xt0MU=;
        b=Y3Y1jYl4RPgKqOa7S11Ih6PrwSDx2FzsxTbqAQkNQrldYxdG7vGjxTZ/qQt3hE0CyC
         ppxvjoww8L5GSUObgZDxMfaW2AWMtKrkJnR5HPW+pIYzbQz0tctIINZHbgvoV7TzqfXw
         /vNr2lNGeaD70hee5+oHZemI8Lt+7U+96n76+Vdbu/oW3EVssJta1UY+eOJ/B/Ob/ctk
         PdjzbJ1wbh0PnMSO9RkfpJC9Pfe87p4pG7LtayNGc7vvFD8rSSeleT6+dQwh291NRPCm
         6vSftPMA5s8d+sa0cEAy8lns32T/HjenMFCtozZ2ucMWjdU5lAUMZ4jaP3Qb7BeNbaYm
         93gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7+cxSW5QfEo7sh/k5k6CspUDINg8UQQww9Ay6Ch3IbfM+zfU6I+VMhb+f3cZQyFKUQBZV0cqAPkDE1uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVR8j5jIJd7MJGf9G06vQnY//ENlJgy4f0DCwc2w4U5VCXS61Q
	vb+/i3ckY34FdEQzqGGLrSxWVueuGyjrcc6VH0TbeVZ8hO+1aRoSWia5QngZVwU=
X-Google-Smtp-Source: AGHT+IFGpuLALqSBvTN7KF7uWbZnKi/jAWWq0+CWqgqXUTcp0W/Q5TxtDHUSrdJ35giIWhVXIl26Rw==
X-Received: by 2002:a05:6000:1e4f:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-37efcf18afbmr8143373f8f.28.1729871006327;
        Fri, 25 Oct 2024 08:43:26 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm1829092f8f.49.2024.10.25.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:43:26 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 25 Oct 2024 16:43:23 +0100
Subject: [PATCH 1/6] arm64: dts: qcom: qrb5165-rb5-vision-mezzanine:
 Convert mezzanine riser to dtbo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-1-cdff2f1a5792@linaro.org>
References: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
In-Reply-To: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Depeng Shao <quic_depengs@quicinc.com>, 
 Vikram Sharma <quic_vikramsa@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

Convert the navigation / camera mezzanine from its own dts to a dtso. A
small amount of additional includes / address / cell size change needs to
be applied to convert.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # rb5
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                                  | 3 +++
 ...-rb5-vision-mezzanine.dts => qrb5165-rb5-vision-mezzanine.dtso} | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index ac199f809b0d4e514878518604a23b4f1ab8ef79..7145748afaf53c816e7b3efd8d5f583a2efbb82e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -116,6 +116,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
+
+qrb5165-rb5-vision-mezzanine-dtbs	:= qrb5165-rb5.dtb qrb5165-rb5-vision-mezzanine.dtbo
+
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
similarity index 88%
rename from arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts
rename to arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
index edc0e42ee01735eda96b2c5c68be247ea37cd534..0603954e24d88fa203679279f01705eea15ce6c3 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
@@ -4,8 +4,10 @@
  */
 
 /dts-v1/;
+/plugin/;
 
-#include "qrb5165-rb5.dts"
+#include <dt-bindings/clock/qcom,camcc-sm8250.h>
+#include <dt-bindings/gpio/gpio.h>
 
 &camcc {
 	status = "okay";
@@ -33,6 +35,9 @@ &cci1 {
 };
 
 &cci1_i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	camera@1a {
 		compatible = "sony,imx577";
 		reg = <0x1a>;

-- 
2.47.0


