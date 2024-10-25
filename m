Return-Path: <linux-kernel+bounces-382077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3365B9B08BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18321F27CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F27206501;
	Fri, 25 Oct 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jn7hM+gt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385017CA1F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871014; cv=none; b=Eu0QowezwgZfnT8jB0s9U+sa/edDeaP24zgq6gADx6CA1utnZQGQlofVReebVLJD4yekXneewsNwXhgAdlQvXTRSpeFobnJi5bn/FyUx8yhCK9uJ3bCrvuutP4LcmNc+gW4t+3E36JSB5x3WztYy5JZVFeTzopAXkiWQCEiVI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871014; c=relaxed/simple;
	bh=XvlW0vpiMSi9SfklLNRt5xYJcsZyzHInLa7y2PlPt9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gS/Nc2P2RLnWqZrGwZn4w3puXkEU7XAEqvdNKmXNRjejQXclOcqv5F57d0zEZ+l1uL29m1jr8IO83nN6EmEYc82hkIfvYQXCRDW7OHdf0KfVXD8HPnNbmXWaV03xCRbz2Qi7h5OXQq6to0UQfQk3ugAy3bJUP9YGCdXfq2mlsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jn7hM+gt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d8901cb98so2184343f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729871011; x=1730475811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhFbw1mBYu2Nay5X01WxZV5YBpfYsMrhWbGTAJYzk1Q=;
        b=Jn7hM+gtHeNMD70IekwblTx/2nKgcq1OYolMI/exMolcSFxWw/FVGiyKu3qUjVJPQU
         LiIrGwLdUAaE9HBrAIu4ErRpYGeU4U5jvdUkLjA6MhUlgYP+Oiu+fG+nRGbfznq0VUjk
         yuPwy39OQzf3uMN78Fapf6GS26cpgq+k43RFHySgBVOICayi4cCtCMakZ59yI/U1sekq
         WM515F1LqylcAZFvnfggg3RVm4u8lDLqy04d8hWzOjbJNOGd8DQFG9LjsmwQ+BwGCNzB
         S3t5WGpvD9a2JQ9yUjUXdT5p3m5iwkJLton8jHE4WPN5SSqxpQKbJTpCLX4dUkhIkWiT
         yb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729871011; x=1730475811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhFbw1mBYu2Nay5X01WxZV5YBpfYsMrhWbGTAJYzk1Q=;
        b=wU9537St4hMYaKyP68P/gFBOAgKCYpel682N5HcPim8g5TK+eEVJ99WUs2nYOcpNKR
         TpG9qkDJ+In1+400xZRwUrj1bR26D9GRyK6gTE91ag8GZ3RNURiXLf1VfdlCEnyQlEgu
         iz9QvFPtOGcDDkZ0Pa1K1DLbjTVq82+QTCf0FUnwDsPJuRyGUE2KTXHKivStgFtKftmV
         cOeYg1gQhq6JpQVZC36fZE/hW+RjY5lbrhWUarrwA902BBsTVtI8RVPSHpVHIYvPPWMW
         NUdOWvUCtxJIQa/aIL8vEJerFB3PGiIFAlIa+uatw+R9iJoFubejUTTvowDIJKybUaw5
         CIOg==
X-Forwarded-Encrypted: i=1; AJvYcCXvGLC1BORBzXHceA4r+REqDC1G0q7eX5c9tMM0gL/wSLjfodJoGhT5yzHwjmDM5PwvsmUkshSOHpTml4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KVqatJ1E8D4ZaElnbHQiLcTjGCSR41b+pa4yrZKUN0zxB2aO
	3XKXiz9v17TWuFMLsdp078ggU6jB2TXgAgBvQlJMQRUrSr/BAMSWlcFSP/YZ2hs=
X-Google-Smtp-Source: AGHT+IEpR+L7S48fUXzS3mEfaT/r/b5+mLSfBoyEeFTAJU9NB8MaARkwZJjkqVqUt/KjOOIyL0+4eQ==
X-Received: by 2002:adf:e8d1:0:b0:37c:ca20:52a with SMTP id ffacd0b85a97d-3803abb20cfmr5145111f8f.8.1729871011022;
        Fri, 25 Oct 2024 08:43:31 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm1829092f8f.49.2024.10.25.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:43:30 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 25 Oct 2024 16:43:28 +0100
Subject: [PATCH 6/6] arm64: dts: qcom: sdm845-db845c-navigation-mezzanine:
 Add cma heap for libcamera softisp support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-6-cdff2f1a5792@linaro.org>
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

libcamera softisp requires a linux,cma heap export in order to support
user-space debayering, 3a and export to other system components such as
pipewire, Firefox/Chromium - Hangouts, Zoom etc.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
index d62a20f018e7a7e1c7e77f0c927c2d9fe7ae8509..c8507afcd1e0d1f9b14b6e4edcbc646032e7b6c9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
@@ -9,6 +9,17 @@
 #include <dt-bindings/clock/qcom,camcc-sdm845.h>
 #include <dt-bindings/gpio/gpio.h>
 
+/ {
+	reserved-memory {
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+};
+
 &camss {
 	vdda-phy-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l26a_1p2>;

-- 
2.47.0


