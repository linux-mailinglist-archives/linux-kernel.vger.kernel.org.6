Return-Path: <linux-kernel+bounces-431006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81A9E381A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D44B3454C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A31B21BD;
	Wed,  4 Dec 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMklZTWH"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD31B412B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309825; cv=none; b=ZH/FWrreYV7PlhPgmSJk0rLjOoJKC+Ls9Lo0Y3H5dgnNJp9KQmJOyl1M/kKsUMrSpigSb3JxzjXO1W7cSsz4jyBIOREeWTrVoz1xiMJBTZA6MyafeKZV/qhmYyJYz9dkSCKJzWaQdv+uvgaiEfAXZxg1OylmcJlJxyJvtNWRzZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309825; c=relaxed/simple;
	bh=X0jc67fLpdkoLWvGYPtJ2t6lBko+be5V42GTdXCU6OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ah2thSV4schWOLaQuC8ieYm3eYFvr5pU9FqeyvtcE6wgnBQmqrIoMamRM7O0QN3ZGn0pMe7a2BI3+w/YvYDzEkSMNa5osT0YR9bN5KmF0Q9979fDdJxHhoEEKl60pmQc+4fsMGl8fu7bKeW54rxhxbjWATaVgJLYTZ5ZWzb4mJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMklZTWH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e25c5d75so3282108f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733309822; x=1733914622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3S9eHrj096rces9dTnn414lc2v6tceqMDXtlGmwyprw=;
        b=qMklZTWH3Q/jOMelZyE7x5NMO9gfHJ82k0IgvO6nJ7FCChkBanUa+8OmSAYxTsAvZQ
         RqNzB3Hy++OqdlvKI31ehWeNX5cmPCU6K1xKgUx8FszUKjywXEhQK6xuuoB+6unKO8+0
         ES8BgNfUw0WC6WEedNatolEsCXu0/n9exXfNGSCgOuvh9DP3Zu/PGmGGatiiMJzTPpJC
         0noaMXg+Xha+Cuacs5pgrONENsp8XYprvCCieziRxrZp3VrAyI0ziJnobBAYpVAYX203
         i9osp0wYCKrWNX6vD+MD17zO1uDx/wsdsu71bh+5bEgu0WKlgjRKk6AoACYHzcKLPVn3
         aqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309822; x=1733914622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S9eHrj096rces9dTnn414lc2v6tceqMDXtlGmwyprw=;
        b=fzwhuqyGn4+N/Sc2LLjSnhm76txmpg+U3WZvr7z3Clg68hW7jiOrnlIV/4Eev3vK/7
         x+J1eArgUSRzACFNQDIVL75gAgIPU82KHeTvi5jCIxvtUtr9Ue7vvQzWMxBXVIKz5YMP
         0dJ+wgGmD/qEMCMYf/gmtCVFumOA18QiwQXam34VbLOueUXAYuATNgGjOPZxiPvZNltw
         fQSR2HF+rwRMsZr+MPUVMuhq5zZ3WLjm6OpCQm43WX+mSDRvRH1aZf0Vd+6+G/2+TD2h
         oXqsswcW9rF5znHZSCnRoMpUGRJDgtJGzMxRVSp72NR1Yjc3HZr2xKAETdrjKl0ikbje
         BgIw==
X-Forwarded-Encrypted: i=1; AJvYcCUNJ8TvOB9+Tr+cpw+5hHnz391efQXyels/5BDDP6BC1yBcaQ5GEb7mSCZ74oYM/LBacaFE8VdYFc3dMTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweM7wb7MNMMV2gWfSB6ClHCQ7QaiQnnebMPSwq+VecUnJaKTxX
	nPCzjuWIDqoMdgDZ4oOLtRztR/Xr99JKg4y5YvOtVRI1fMlCiCg+OrHrHkx4SNs=
X-Gm-Gg: ASbGncsgpQrO72mdm6DCEHzqozQ0jJicPldOEMk4AnI/MhkMxqfjJqzUUpEkYIQdRJf
	4BvdHZ2nuA3ISL2N6tJ/1cZLrLijewhT2YiijtkM1x+/QAJC28AbxC+nVYwcDS5rgtURlyyUP4P
	mRViqyt/a81GSeT+S0zdR/96D1MWs+ttAlX+NUb+Twkd5gvXfosG0w1YNf9pPNwN8Gv/kukvuPo
	pnuQYfDBHWn9oqIuTRaM54CZGIZooWsAgTbhJXsbmrOuZsbwhnMp4XuttHbQu6cCNBOGqw=
X-Google-Smtp-Source: AGHT+IEEM9AsEZljH5GjZsXEAk+mrPOJrw9hP44cLvyc3CTJQnaqJ4zsxawmC4hW80yomi0T8mh7Ow==
X-Received: by 2002:a05:6000:18a3:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38605b2abd8mr3656724f8f.53.1733309821653;
        Wed, 04 Dec 2024 02:57:01 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd687c3sm18459063f8f.77.2024.12.04.02.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:57:01 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 04 Dec 2024 11:56:57 +0100
Subject: [PATCH 5/5] arm64: dts: qcom: sc7180: fix psci power domain node
 names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-topic-misc-dt-fixes-v1-5-6d320b6454e6@linaro.org>
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2585;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=X0jc67fLpdkoLWvGYPtJ2t6lBko+be5V42GTdXCU6OQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUDV4WWqHWIKjlb6aDDBeDzpTK6Gcc6KvSw48blx2
 BsqVofiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1A1eAAKCRB33NvayMhJ0TXlD/
 9ydTp6OJnbwT4nYhnKvWUL4PXt2eLBMUFXNtfytH3fNIvMv9Dn4cPtSfN/vIqB91udb+9e079PJZKd
 TxgaHog/ba6IA9w4d2O199Z3DbUX2pNUczVpYdCLCrHp3wf6TRoPHEVWB92Btu5n6anDR2fXdPXGSW
 Zu6VnYYvizOLOW5EgaSPhBcl/i7nboQEVFNOnQE475zGeYvRg1IpbPUn6VD9h86Ky92TaZW22kT1K9
 el3P09nPiIdxU5oq6BptRs9SsDdpFC4fF1wMlF1FEG180AdqLFQUt3vFuqNH4ZR3h53qQZb3c03h27
 vqZ1negPaeoERmLxBQkip0/EGoPxH+/SHN/UU/l3/xVA8Sl/pho95AlNtkBSmnWjyKZkHvd1cIqJKw
 YXGdyXsniO8g+kTXHttv0vWuia/Ha2cDz7Hnr4HvXak7WYBMJ5joUGfhAgGK65+sDKdXYRPvC8v5Fk
 6cmhVgFGJfjfnQSHbpCkFrLOGiaOtAnIWeVP4uOdZdkqLNaQDlKpUMBzwibXkMROBAar0unXqNWxSr
 MwC/hE+9Syb4UHmAXT3/CIwYBQVobgaZSN0gRq/A9yqlKxY/BsI9hJv84TueCpj7f5BHZ9ojcEzpQW
 fUvqzd08T5Dm9jRROaXDR8vuvdojz3ZXtn2i54/uFeX7c/80KDb8IuAfOpYQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Rename the psci power domain node names to match the bindings.

This Fixes:
sc7180-acer-aspire1.dts: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6', 'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 76fe314d2ad50d002ee6adf4659fa685ddae89de..e7773d215f34eba9a42808eb37fac7fa1fda87b1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -580,55 +580,55 @@ psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		cpu_pd0: cpu0 {
+		cpu_pd0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd1: cpu1 {
+		cpu_pd1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd2: cpu2 {
+		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd3: cpu3 {
+		cpu_pd3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd4: cpu4 {
+		cpu_pd4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd5: cpu5 {
+		cpu_pd5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd6: cpu6 {
+		cpu_pd6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
 		};
 
-		cpu_pd7: cpu7 {
+		cpu_pd7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
 		};
 
-		cluster_pd: cpu-cluster0 {
+		cluster_pd: power-domain-cluster {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cluster_sleep_pc
 					      &cluster_sleep_cx_ret

-- 
2.34.1


