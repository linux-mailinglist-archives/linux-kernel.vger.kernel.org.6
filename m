Return-Path: <linux-kernel+bounces-227192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741949149C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B181F23258
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F513C9DE;
	Mon, 24 Jun 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJf4fspc"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AED13C3C4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231831; cv=none; b=XnZ+NsxZEp++Lgyu8oxVV2HsCtQjEa9MnPMmPaJZhMNnr3q5yLhmK7B/ne5Ks3G4SpUprGBWN3JsddnCxmKJcd9J62X71+cB1cIpHcVbYz9QTvD3EDmyBUZJJWuATSgUQ7V1zbF4dzVfaCPYKwXFzY4oomRpnEeoab9JbabhrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231831; c=relaxed/simple;
	bh=Q03S+m8RREtYznOYyYSMwUZft3i7SsFb0QK4NZsB+iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QqgJVPDO6W275zmoS0wNz2+pFkLTaOyj4JtEw65BBd7tp94duTHBwX0yIJJGqbcI7YkUeT4/W7GAp0aJzkKyTc7QLsAkLJ6e0/Gu/Slgub44Z29B5KYGuxFlxSlOIRkEqa4A1MLq0uO4fIe57HAAoKCWsSmo7zXeHS+4IjY6hBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJf4fspc; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec50d4e47bso27171251fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719231828; x=1719836628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCh+p1yiDwBiqYBJf5orPgY8K+j5IOBZYYgEaZUM/ww=;
        b=wJf4fspcpHR/7SNRAoEcfyvf72ELEQkeqsXUbm3BvpEYPDLhrgqGPBXhGjqEiI6OTW
         4WTi1wrfmGC3T+9qBPWI2FZWBKcGN86C8GCxR2unHMER8oXY7WVee1CtlciAHSE9oNlK
         8zQrnIzKQn4uvEQnorLdS8COV8wgV5vNFMn+jB9ngSqI5SNzlCj7YokEOXX/dQf7qUAn
         n2ug+q31BT+itcR8ITl36MFiuzTZxTFLrJ59DHBRaCaTtFrtJP24RV1OulDX1HK0MpxS
         wnnUyg9aMLNOx5MN4rETcXOM958zQenzn4pabdba6Pk4bllboB+P2Pz0KVCkMP3aoLEM
         Liag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719231828; x=1719836628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCh+p1yiDwBiqYBJf5orPgY8K+j5IOBZYYgEaZUM/ww=;
        b=rjrISu1CRrVNpGWZnjpLsuWkOJasw+srf4iziZeobZNEYRp5SK++bp8flOQkUFrDli
         Ox2YsGkcZ8aiFbN202fDpeBC4G/pkhwE+wiM0oatp4ahkqhfT67Lz8kY27Jug8ECuZnR
         EUq61x3dLbwgZIKo1hIT40fPjBgxpxeEdGRWCxjUsb6NlPzUa1tWQMxpXrUfqqIvJE9u
         DPMdiMONczsS8UYg6FHmXHN+XObZBEHZ1pkpEih+qX7bViu2mWSzLy5fctRPDA95Yq9o
         0BjdWktBSmBduSEvz90x1/MnhC2ZPkK5OSURAtYyEjgrYbYQ8HzijP/HwlRa+4wiIxpt
         nsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf+d3jgmXfKZo2ky5wvkEkUWVBG2zQCWr9E6PN1S5e/FiTEZ9aYo0YeqOqXZ56PPxXz8RlSluxlDKefkXsVwbE6sNPQTLUTu1lqHTY
X-Gm-Message-State: AOJu0Yw57V5LqEIDjaMRHnDXRsKqbiWI39UoBmRMu5pYqF1ZhINbS3ey
	aRfU5+HpDnzYragZzQJSL6g80gqRZtJqIiRPu7fBzfuPe56zCWNEXkDumds/kmU=
X-Google-Smtp-Source: AGHT+IHrG2Sg+YPJRuZW4mgcoM4ro6znp/Zs2eSnC/pBThrvu1K2iEA59wvYd2ssrg8DmrNqDb6wKQ==
X-Received: by 2002:a2e:6808:0:b0:2ec:588d:7ecc with SMTP id 38308e7fff4ca-2ec5b27a875mr27938121fa.12.1719231827755;
        Mon, 24 Jun 2024 05:23:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::52af])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d45496336sm2946824a12.22.2024.06.24.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:23:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 24 Jun 2024 14:23:43 +0200
Subject: [PATCH 2/3] arm64: dts: qcom: sm8350: move usb-role-switch to
 sm8350.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-b4-rb2-fixes-v1-2-8d763ee4e42e@linaro.org>
References: <20240624-b4-rb2-fixes-v1-0-8d763ee4e42e@linaro.org>
In-Reply-To: <20240624-b4-rb2-fixes-v1-0-8d763ee4e42e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Q03S+m8RREtYznOYyYSMwUZft3i7SsFb0QK4NZsB+iE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmeWVQjnq1mBovb8HvYoPh0vuVwKpVjlYkad2q2
 7XiYgj/mdGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZnllUAAKCRAFgzErGV9k
 tuZpD/9p9oRi+Khry2hCP71AqHez5aVglyBE95sleeJpmijhWh2mCh5Knz6Jdx+PsLxliQrL/Lj
 T/rESTC6rHSvE+GG6SsEBpYi3vs+sje05P59PkwEnuVJs/yLVlK+dLGCf/CkFPlLayErx8a+fw9
 I13j0y4qQRdpyqswB50/ZZWRjZJz7ZDQOV+JfbP2jwj9zkcKBI647jVpyylDtRcqENx1Z/HIkOj
 n4uerO6l7TC2WnLYg3FCw/YXCGNikn4oot4B8e9CCq4SNsHPOFjzFI9Sn+RfV6YA2mr7fFnH9Lo
 pILmCTuKnGUsGxwMZ/cfb/2JEr2vI0Rw0jZv+l0pUJgQmWXbHaU7SoSPAKvfi3PqlmV8ZnuMei7
 A6FquGzLQXvNbzGJb+ak7OtzLcR3ELibxN4zpZkn/6f+5MRbfz/BFw0mC7p7e2DRgrybJgH/m7H
 oP28ID8kmaR3BohtPAoUpznmSL/RWlEVGUABoVv/MamlXHOLQZA0P8K7lUAeeMlCv+8VROJxjuG
 +WNd5U2ozYFcd32Dl6mBMtNJfQToJO48a2GOWMbjNBLh8HDFzluD2wAQQ8ouybdspMJ9gq+EzOK
 3UsMNf01HdA3pVVJY1pNKA79vYfo/XduG+xVDZRwapj/WVfzvvHO5HR+LxEGE+Ycf2tc302nqKH
 egRNeuQF2bApiOA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Since all boards with this soc are capable of role switching, move the
usb-role-switch property to the soc dtsi and stop explicitly setting
dr_mode to OTG since it's the default.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 5 -----
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 895adce59e75..e031ad4c19f4 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -847,13 +847,8 @@ &ufs_mem_phy {
 &usb_1 {
 	status = "okay";
 };
 
-&usb_1_dwc3 {
-	dr_mode = "otg";
-	usb-role-switch;
-};
-
 &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 38ee0850c335..f88c4d66164b 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2404,8 +2404,9 @@ usb_1_dwc3: usb@a600000 {
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
+				usb-role-switch;
 
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;

-- 
2.45.0


