Return-Path: <linux-kernel+bounces-530987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0CA43AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519713B2549
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8D526B2AD;
	Tue, 25 Feb 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeMMlwza"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5350268C77
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477573; cv=none; b=IIcGmCeOiQWv8AX2IwwoR0GWLoBvQjvrVJ0F5vUBsi4qM1cGD77CgjF08RP5jJQc3IZaRe0Pi6+C3noERVYay0/7GaIsN2vFGQ7kIkNnXO9UvVlzsBdACCCqwO6uG0Za+bePhKuEEUTMWDCNwG2SoobOHwAIl5QgOUEouHPv5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477573; c=relaxed/simple;
	bh=K6ulgqX9xm/IzAIs59A8ZOhyCrtGKAuLcn4skiTzF1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jr3ozeBwfTxzctFxLf96iPmH01BCqK2upTSmNbRh6cNvqp0WmwHltB0fw4pgnnQLhZcunSBm8Zk3Dnc3NGclGKWngLIsbI1CrHToE+PJg9cJPgEIyjIRP7cZLRTM44lm2TowpMf5pO8pwa6fMwTRfbh61zSvEGiRsqwPmWjJ0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GeMMlwza; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb4944fa73so79725666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477568; x=1741082368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koKJk91FQoEK5vjoU1Yv8GT+t3+x8oMSlOzgcACOV6U=;
        b=GeMMlwzake6D0GiT3EC9QPpDr5xBibh8jc0xbgLW6qLKepILpUqM9GCxOgT4QOAjfu
         vpnovGCQNxd2c4mTX3mZcVAWoja2XVW+zVxXCjwegoWOIEt6XjQzQpG+qpmcuUyd9MWR
         FSVpccHHS40ii2tSkBOTKksiu219kvi/1PN9wWE7KGjAlKaZkSq+DXc3Lg9Sz7YVfJBk
         T+JFZt+n9uNqoE6nUNOs2z9Xw1DNEXc6ibPV55ogdfvZDOYPS/FvJwDsTNDzcD+g9Xta
         DIqBBIUOntML6J/JT7+/QFB257IJ6IWCUXX9JJLTEAF0Scrc14SwENFBAmb9WjDg+BKi
         2GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477568; x=1741082368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koKJk91FQoEK5vjoU1Yv8GT+t3+x8oMSlOzgcACOV6U=;
        b=Vki7m+yZLRC06LQZZ03/jXYJdr908M42YhKWD0GsEyfeYvIbczjPjju0i/y9609hfC
         DQubsgRYnflSPCbXKGQc1C83rwzBhkZlmi6ouf2e49ym8tN5w1c54OpVBOEBfRMfdqQW
         W4A27XeAqmm3aCdDVFllrYRmx/kRnq62AzQCW3dcbupkXm06YjrXshoyPb16WP/+d+Sx
         tE6A8xbTqTN3KHlpv7Q3OqUtCiMFDVN0CGhofk8kCstGOnyUs4X/mViwyNykbbOq21vH
         X88FUGFM/gflZBHJIwaoGyJImxsYUh940wLMMgryUJxiyuaYhpp+LzBsUBS+b5z6k13k
         P0EA==
X-Forwarded-Encrypted: i=1; AJvYcCWtr2hgZb4c5UlSXVmZYGe9ilp1Y7UP95nptI3ubeCQEkOz3uzxRWoADUQB/lG9/UOFd2F/R0nuAEOlxhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uoZvgvJ8V7FWPYXH9JpHvrr9Yem5drpzDM8tdqQIzolzW7DG
	MDKeB3Y5/Z4G6ARwEZOuShUHAg0EhIWiG6mCkF1gMBIzg1Zwug+TAWj12NxP6wo=
X-Gm-Gg: ASbGnctLlWxSjwhZyQd/9p7a+g4HPUI4zghGxljLTd4EUN7IsT8EqH/QCZb3c4zwLm4
	fdyYoPEA63tUcD/7vhaDxNNgFqrqhDXH4Xw0jpctrhR/vcSH1Q6fHWw2WlOdUDHEbUiTt3/yq8r
	sp1s88+sG8MbnoV34Dx9ujQgUKgFDu/+HLdyQA8Ap6xLw4ITeAKXtCWJW4fUVBcgavlGMECFH9P
	lV8v6PEFI2aHCWPsJWJO4lT3M4MmJ1xlANXkzpBO4Y16uUmO+eGtZbXKjvdFnnc9MrPRif2LjOH
	sPCx/LEwa1LpHgxdN7XaBE1Akn4i/WYNkpAG4dvreQJIGCsDwwB2/3FzWY3QhiM214QH5psUPNK
	+
X-Google-Smtp-Source: AGHT+IEkg0Jb2tX/pkIuOINq1hjuUPnTRqSjpa4tzHIj/gcfD0L/xLuLfq5sSyqPW0tc67ephUIQJg==
X-Received: by 2002:a17:907:9713:b0:ab7:f92c:8ff9 with SMTP id a640c23a62f3a-abc099c6f28mr692882566b.1.1740477568189;
        Tue, 25 Feb 2025 01:59:28 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:59:05 +0100
Subject: [PATCH RFC 08/13] arm64: dts: qcom: sm6115: Switch to undeprecated
 qcom,calibration-variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-8-347e9c72dcfc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=K6ulgqX9xm/IzAIs59A8ZOhyCrtGKAuLcn4skiTzF1c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvZRt8Gg7oNU/V1fO9noR+r1Kz6HZU9G6dEa5v
 xxUOWIrrouJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72UbQAKCRDBN2bmhouD
 133qD/0aDC5+/lfPm62QVHqgocuV749CCvbEM+aRdb3s6MvJgTX85TCNybIzmAmHX8hzKayrGjY
 4Vg8npIswrTbn50nsRPawNumo2mRQViJLRD6HUKryWLQzxz8RuoL+OURNA9jVdszH2NM+SIfKMQ
 jw2y33NmT+rtAQys3WXtIA64Yilx0XbsCfqUmfxq07Zq+rXtSehbNNcY9/xcyasl1Hs2tfNofRC
 Rf3uQWG04AVnqrA7PhzDt9dqKzP9rqWaeZb2KJzcBzyyAO4TmPWhcK5VprqkKlir5wik2sx4CGi
 yjv6IwwSyhBWBO5TP2OAn/aWHHRSZiGUuQv4jBLQSdps6bmG86cuPE2vsR6iPkUIJ2NA4PKqKfC
 QnG//Z2bBkqr9f5Z8rSSiadstfPcmJaENbAPCfrZOdhCJQYiOGY3LuPA1Bf5WsOzFJz8iku8C0C
 H52Rt1RsybP2WAEqjIkOhTNxtfQXBqLq7FkyVaAQhJACoIBlgeNPYHffpdd97hnsmrACe1j8D8U
 /WlfUMAAzcX6k+XiHLhpyyEEbPfZ4HZNJWLQJQ9FISMysV5YX0A+esmtD0x648qWWEGJ2fhj+3O
 AvC7Zk+nntDfuqgSocPQTzKAQDRnxDuvE25w5Gv1mod/bQf+WpgVDPJ4Al8ukwPPsmRgE2evl7r
 0b1+yvtW/HHRFPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The property qcom,ath10k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts   | 2 +-
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
index f60d36c03b9b51d1ba5fb2db7d619916fe42f084..ad347ccd19755b20db8e0de6852148c76010e697 100644
--- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
@@ -566,7 +566,7 @@ &wifi {
 	vdd-1.3-rfa-supply = <&pm6125_l17a>;
 	vdd-3.3-ch0-supply = <&pm6125_l23a>;
 
-	qcom,ath10k-calibration-variant = "Fxtec_QX1050";
+	qcom,calibration-variant = "Fxtec_QX1050";
 
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 9d78bb3f71901705fd22d88b472f6fc1d0c0fffb..c17545111f49a8388d8d5802ea5c3ff3c8a6cb45 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -379,7 +379,7 @@ &wifi {
 	vdd-1.8-xo-supply = <&pm6125_l16>;
 	vdd-1.3-rfa-supply = <&pm6125_l17>;
 	vdd-3.3-ch0-supply = <&pm6125_l23>;
-	qcom,ath10k-calibration-variant = "Lenovo_P11";
+	qcom,calibration-variant = "Lenovo_P11";
 	status = "okay";
 };
 

-- 
2.43.0


