Return-Path: <linux-kernel+bounces-530979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABFBA43AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC043B58BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492B267B1D;
	Tue, 25 Feb 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOrg2UAo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9A267AFD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477561; cv=none; b=k87f70dXuVfKRSOUq/9H0TMrkOw6ZgsZZ3WFK0zH3YEZ7Yx38FDqjKrLaf3c1gY3BD25oX7Xi0dsc7JgeLshRYTSKTYTLG5ijPiEgpiMI8ic0PxBeASUTtuHom9N6Zv2MZyWVYGx3ry4ZiswLGJrJYb9dxumwIxk6zdH8fR98uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477561; c=relaxed/simple;
	bh=uAkOhFz/ds17g3Knhh8kOV5Lunr6MCa4mPjSf1FPgyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCl4ocvrRKWr0Ji9V8zXaHfA4RnSr3Ig+sYjAthx6UeB8ckaKkQTXLU4JSGgK8aroKHMVolzWXvKoqLN0DVqLIEppKidu+Htio/ru513YSeivuYQFK2MZssjLY7lEYCZCLvwZ34JRN364lKcXKsVHGpQUvjKqK+0NiBD148Fh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOrg2UAo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dc050e6a9dso1403815a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477558; x=1741082358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGYXjJK5GAqb0O3Fi6psK47cB0ARpE1CvBe6Vy83cDE=;
        b=HOrg2UAorOzIzZWLy+4c/WUYnsAjOIHiCgHuPE37nm+6/FXMHlnbDsguNMfRGHJfR6
         pYL04jpJ8QeO9yQl1nEmVodxrxkZsMS+cA3ZTBVXyWzV1ZRvwK0fHpn6jOS3WN63ledc
         3+ZR6aDxzk2/s/nEf4fP2qI6W717ZSC5q7oVu0mbIIvc8fa0O4AiIDTGSVOkaOgZ+icT
         CLJ/KJB50KvfozMOPTkOGvj0EOboEolRmswtUNDna4JZ1aeVDGNvkZP2YYeSZXXi1iSG
         Q4JIP32IljOXjLT6yqh/bGSWWP/WvS/tKDb6tWQHmjUiMBxteJPNV1dcS1OafXjBv132
         dyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477558; x=1741082358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGYXjJK5GAqb0O3Fi6psK47cB0ARpE1CvBe6Vy83cDE=;
        b=IX1/1Yzu2Jj+YHkg5U5swl94/mNyDjGp03oku1D6GO1Z7EPkVyMoGJKAPNqsMckVe7
         flfEw/Ofh3hFgKYYw9aVfkB473hNlXIInuF2xN8fYMSIbP5x4nmc1Xf9kAkNm9bRVoYJ
         nIc+HIX8WvuZOx0jRrx+E5DHFiR4td1XbDltNRCif1xUpBX+iNvXN/KEzPAJXse4KWI2
         9rQTem1oqWNixuHPAorkocAOw3dGLa3hZjqNC0cmRdRveW5qjcRzUFBZQq2sS/6HJsWA
         0s7zQZx8vdSbtN1kQLq2Y3YBKyl3vy7yCQzO+VXgZ5llV/3+Ex0EPnRW8aOmSalrgkmg
         nLLA==
X-Forwarded-Encrypted: i=1; AJvYcCWoqy15EfZT8flUTWi9CzZlARlkLTz54Ok6zO5yRqSZHS/k+Xd8WkpsKnOqP7iMrgz6eUIG/RZeX6LoD94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAA1+mG75VCGi332j1zed06/FdMLMELDImI9lQpvLsNaMG/AN
	0Zdm9fQ2KHQfSpkfrF9XUJP+qHjzO4eSvv0xRE9HLiI+t/BCcQCvdnQnB00C+1k=
X-Gm-Gg: ASbGncsTqNqdOMKDVzlRniDTpiUhNY6rddFfv5OaRRj9gdYq6qhTelBN53bYAb6SI7X
	kv9GaPsvwTItDbsDWKOvGlNPDG7PVozj3+fQFfDELa+KVMOO+bnabNrlEqz5YdY0sb+oIAX/cKa
	0ejvJYDEYbxB25AdJDS1z3ho7kMu5zJiLNTaD5X8ZxX0H9+46m95dTtrNH7obnKEzXg+VsjOUCl
	V96M0F84yEOf8u41E2Khk9i2aAw1b69PiK3VZe30WPYeI6+sra3vrt6tUy6asLDg+1u04DFaEOT
	CbPbCoGj/ro+TJLN7O/sDNImP4TTsPt2FuZmodVS4+jUfoLROQAko+naHjsyIJs1OdYfs9z7oeS
	E
X-Google-Smtp-Source: AGHT+IGPZgZbUGuhlmSdot/dlN0kkHRXF0etmolx4ezj3a9mEEIY3EVVQJAq6p2bTXw/cPoTWQuzlQ==
X-Received: by 2002:a17:907:2d20:b0:ab7:bb4b:aa49 with SMTP id a640c23a62f3a-abc09a0bf7fmr683713366b.5.1740477558264;
        Tue, 25 Feb 2025 01:59:18 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:58:58 +0100
Subject: [PATCH RFC 01/13] ARM: dts: qcom: ipq4018: Switch to undeprecated
 qcom,calibration-variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-1-347e9c72dcfc@linaro.org>
References: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
In-Reply-To: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uAkOhFz/ds17g3Knhh8kOV5Lunr6MCa4mPjSf1FPgyk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvZRntN7+lecd4kYjDPj5WYLHzHSKoereZFnXh
 Z+kdlHhasOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72UZwAKCRDBN2bmhouD
 14AfEACG2KZRsffXm/8B5gJnyrqbgdOxVyAeEZvbVoTI+iKgme4C+2XbjMFF6TppWcQMndwIVSn
 riS1RH0fSbMKm3ODlPLpaqF1YpP5f2qIuC9E2Ek/QkvlXJAt72+v6l1qhcQjrXm9lKdP9XCQLeb
 JAscr1yhfZb+Vbecjj1cV2tT+8MCi0NWEzUSG2kA1xy4vqDGiMZyiCsn6ugg/kJdp9Bn5LjdzTP
 KcooRK7ZtKVHII0rs9K2wUrKYgvtlLEka98eJk1HE8YrSng27lR5c3XhFZt1KlACilDQ3Ll2oJV
 GXpiXfV1VQphJvHIUj6YkLzV9ewzemE/r2YEtB89jAA3SdSIN/5NW942yn3/gZ+eqM9jCUcEEvk
 OofZeAL3qIYCOP9u3x4ONSl6TEyAGsUvH+RcXIfEj55frQkitFKzQOPiSQiQAKHlfQ/mC/c+VDX
 uO+eT5LnpjOSJtkKctLaS6OwKKZUWzr3qClhHRWa0oJkt4/kbsCy0LNHD7s1ReLxcWfXXVJ3bfN
 eCGlvB3owazdNeGJxPW7OCCgnwS9PKoHP+4hvRhSlLA0R6QB/AeIm/IjbycJaxCcvFA/tsV6ff5
 DyU1pCtB80ymJtY300cLt+MLL/3xyA+V+LU1qncghQQOpg0RjBoGZlglg5CtMI57mWMm3wmBA9E
 ilzntyWtHzEx/ow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The property qcom,ath10k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please do not merge until corresponding driver changes hit mainline (see
cover letter).
---
 arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
index a6d4390efa7c394398b9b6b067c9e64b21334cc0..be76bc39ac2774fc5eb3c0e92844eb609b01dba6 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi
@@ -251,7 +251,7 @@ &wifi1 {
 	status = "okay";
 	nvmem-cell-names = "pre-calibration";
 	nvmem-cells = <&precal_art_5000>;
-	qcom,ath10k-calibration-variant = "ALFA-Network-AP120C-AC";
+	qcom,calibration-variant = "ALFA-Network-AP120C-AC";
 };
 
 &usb3_hs_phy {
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts b/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts
index 6640ea7b6acb2f1d3002b52b25ef327cdc8a5bdd..15baaf0d1529875a804bf3662fc66bb517bc1f11 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts
@@ -179,13 +179,13 @@ &mdio {
 &wifi0 {
 	status = "okay";
 
-	qcom,ath10k-calibration-variant = "8devices-Jalapeno";
+	qcom,calibration-variant = "8devices-Jalapeno";
 };
 
 &wifi1 {
 	status = "okay";
 
-	qcom,ath10k-calibration-variant = "8devices-Jalapeno";
+	qcom,calibration-variant = "8devices-Jalapeno";
 };
 
 &usb3_ss_phy {

-- 
2.43.0


