Return-Path: <linux-kernel+bounces-439141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5B9EAB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195D32836BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB3232783;
	Tue, 10 Dec 2024 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+qGMOjT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF3230D32
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821678; cv=none; b=TyKPGseu4mxN0T67OFlNhR7hhV9yDQdTmHZQPW2YsQLPjhzLsl96ytxFS1e7eutSBB3kZly8Jegfq3pn2YCMHggMgRgDp0DNcM1iFBmgQjIdEgjmXX4LeML9jeFCxOj6pGEfbHZlHa6Ac5Q+SPA9Abe+l7d7S97Gimzq4i0j0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821678; c=relaxed/simple;
	bh=LeOeLTMTGIisFTd8s5GYZZv3DswIAXVm7zRdCpehk2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2bkDKg0UjPgTqw2I4CFyZ2QxopxD4bf9yDvTVaVALoQfWQibrtU49WIzMLNaC8/Hjy/aaZ4dcvefXdA6Iagkgj+3rwm6l1m5BXjvXbA1N3YqvfhkErF6wefgnxlg0tViWwyyubaBfTLjNEqYgGaTTx96bDCcc+vfSfJnUlqwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+qGMOjT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6997f33e4so208960766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733821675; x=1734426475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6qOsPJJdAlZWS+86xEE7U+jJkJPEqu+4/SLHbofnyo=;
        b=P+qGMOjT81XSMxqSkNHiS5ZbBOKUgkl4zAtXeN5m+bcgXF9nrpVgRxmCCh2O84gt7c
         LMiLFL7T43UKtQXTaONb9x1pSPrN9+mKc7tOj6KgM24hIPxNStCASLzSPhRPJRkkwuFC
         qkh38b2uZ4/9onf2CMwZroxveJSyQ7jZZCVzpJxoBVpK9XFQAqcKLeBNx1wM8/BYn6vm
         9fMGXLvGlim0sNEGBd/7XXVm7el2RXvfQX7m+0raSL883i8AfpJbzTQ0bp390JR3QdMI
         C82uaklx3yu+l6PZG61qqIRw6A9p3PMMrDNxwcv+yoCWZuVYl8jSFh0U8glxr5YsgdKn
         tmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821675; x=1734426475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6qOsPJJdAlZWS+86xEE7U+jJkJPEqu+4/SLHbofnyo=;
        b=gp6TXKjEBGW3xFyh8+ixGHXpEzl9GedLsM5n/p2ZcKegn7oMwXSx6xZbrHvubQOpvy
         eSJZy9v26JwZBPNWfUuKuxkrMPaty3JzbiE0Sy6wkfzNCEzCj51WnfH1m7N0jJGv96XX
         ktB0FmWqyr55VtSebiYCWh1jIjG0LBs7Btou2qtdwy6X379yqAm+wD6oI4BDy3EMWIzb
         Ak8dr3XwCEn9J6MmwoefzTq6V2gF1FyaTOCbms1SJth71ew01ycn9LV9QOTq9lNL+/X+
         9WN8y55lXNRwbP1hgxtIZnqjYtxtG1CY/rLBFlYBY27yHjP3jcZthspo9sU4fwhg1CE5
         sElQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvEPv3ipzyOb1k6tVL81lZOerVIc1hCZL9s4b+3ky4JwDfhB6OVXSVTo8xW/te7JseDkuJxIZjAYloGoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+e7K+wb2ZxnLzvcJwgTaMc28jNuXQ9eUxFNi3rgSI7bYAIB5O
	juDe2qe6dyaKQ0ULnfZZ2PiBcrfcqj5FddHGQEba2mIi6TdZHFGoYg82lyYAD1k=
X-Gm-Gg: ASbGncsdMnjmQMQeVQCEr46oz3HAXoKoqgKzkMKCeM1FWt4UvYH2gBG00czWt09RA9t
	zfqAeLYXlaD1a2LWsfQueoSuqwBwgwxO2Iju4V9D4gUHlhkemBulBDyoy/1h1xPNcBaD82z1+px
	XR1I+OLPEyztfInxCJBt9ai9sJY5yYAktM+xiKbWSFfMI5Ig+VCVDcyYCS/ua0V0iMIvnt+x4vt
	kVrGV4vwED9jambC/WyN7JWlk55PBNEjsvBgMX/hfLbhQZY+rg1+1J3nuhei1Eg6uI=
X-Google-Smtp-Source: AGHT+IGcPp2U40SOKQpcMuuXend2SGVLo2UdoLzm0IbDMKVEaEz1s+qCYkB0BamdH6ZHApYsd7Xg+Q==
X-Received: by 2002:a17:907:7844:b0:aa6:707a:af59 with SMTP id a640c23a62f3a-aa6707ad8bcmr884383566b.50.1733821675327;
        Tue, 10 Dec 2024 01:07:55 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:6709:8d26:5167:3c1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699618041sm173148066b.81.2024.12.10.01.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:07:54 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 10 Dec 2024 10:07:33 +0100
Subject: [PATCH 2/8] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Fix
 USB QMP PHY supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-x1e80100-usb-qmp-supply-fix-v1-2-0adda5d30bbd@linaro.org>
References: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
In-Reply-To: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Marc Zyngier <maz@kernel.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

On the X1E80100 CRD, &vreg_l3e_1p2 only powers &usb_mp_qmpphy0/1
(i.e. USBSS_3 and USBSS_4). The QMP PHYs for USB_0, USB_1 and USB_2
are actually powered by &vreg_l2j_1p2.

Since x1e78100-lenovo-thinkpad-t14s mostly just mirrors the power supplies
from the x1e80100-crd device tree, assume that the fix also applies here.

Cc: stable@vger.kernel.org
Fixes: 7d1cbe2f4985 ("arm64: dts: qcom: Add X1E78100 ThinkPad T14s Gen 6")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index 975550139e1024420ed335a2a46e4d54df7ee423..86762f555979d96fbaaf325b210c196e711b3635 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -763,7 +763,7 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l1j_0p8>;
 
 	status = "okay";
@@ -791,7 +791,7 @@ &usb_1_ss1_hsphy {
 };
 
 &usb_1_ss1_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";

-- 
2.47.0


