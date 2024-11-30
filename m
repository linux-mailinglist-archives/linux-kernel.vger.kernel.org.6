Return-Path: <linux-kernel+bounces-426034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E89DEE0F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F30B21FE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BBD146A68;
	Sat, 30 Nov 2024 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGkdtBxZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1D5733A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931079; cv=none; b=Estw6oh9jbsCdIspcVkpnrXRv46z0a1+yg4Id40Ww8xZ4EypkWRtdRIbhaMxfO1mIaRdh8kpD6tjo+M1kESd0u2986hyyDnKXTrygB1kfNsTpor/suONT0TjMooVVLFqaCkj+DLGnJLg9Io9IL9pK3F+aD/AI+jg7qcPb3eFMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931079; c=relaxed/simple;
	bh=rR33tk4iShQizxX1vNrKanPGs6fsj3vgKiMhLvDMp+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0QWYPF/LeSGhT3MpGKtxuf4uGM72qXAWgWzJZW5EywVLTIoeoVW/qqX9LvcV0GNmM1N1j1KXaW6BiecwSOjMvvEQx5/LI0JrX11Brhw3M2/9FatUZWdbRz97jUKoGKoG/YPtvRzoENhSdQTKgmnVrlV5q5ppA6u9ZujoQ9z0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kGkdtBxZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df119675dso2965670e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931076; x=1733535876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enlHR4jkuvtTrE3pGjdSHmUxNqvLGDczVHxXmenPlOE=;
        b=kGkdtBxZ6hsx8adnibJpQQIMEJPGcTsq9FOrs0gqJtHn05uGt2avHF0E7yeJyHbj7H
         6ntTMuJRI2+wzEwlLXhk6i5TZES9rOW7OHM0EhSmByy/RcL9JeDj+0IIbumLqfs+bcwu
         jQhhwo+YvCbydBFtkbfl+CuUitEzCQOelzo+NZJdYYG4DyvVpQcrlbJVqve/coekB54T
         o/D+tDPUjDm2BSsvH8K/1WQygFTVNfeWxc4vzc03USYeOE9tECydrbR1hJ2I94w6CSph
         x+RGbR3Xfzv+UAQaF5Kp8bknLuL5R/OO8YOPxGiSCNbxyMGKFrUVGEmIKH05srxb4C/s
         Guug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931076; x=1733535876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enlHR4jkuvtTrE3pGjdSHmUxNqvLGDczVHxXmenPlOE=;
        b=aqA9avJhxFCFxzOEqsWaAZY5r68xB8E7wgQw7pKIKV0MhyvrsxlNmTZd7IRBka4CNe
         GgOAM9HyrCb6EwpJ6aDHolGEHl6u+0abJ6q5TGOPgbS2XBULHcraHQuoP9A3tOL2rsLJ
         /4jCuv8wU2nhRduoSph/j0A6V51EtLVEhU5mWmRw9Gd9rb1IRlaC2gm1hKtb4qwJqSch
         HHNnL8lvbFWrwImjPuoEU9NxIYkmzJv2Tt6TZz5ifCuae26t4V9a7rDvvlwnwbO1UrKt
         tgCPeOWbaS3dEpzMPFXC+vkGFIdQlhFs+fuTwcm2nzXQvS+Ow5tYLWJVTg4yBAcCKIQp
         jvVw==
X-Forwarded-Encrypted: i=1; AJvYcCVqzjz0l25g/xhYYWhpvV7EwPpUK2vxIWER1t0o33P7SMxyL99/fwDMYA47Kd4vRKlWD3kJsaAtjp2+bFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEosQmeQF84EvAlV0MkaMt/J7+oWUUPWHzUrr4yFoQEpDlk8sy
	1Ldin24XYHNkkNeqBGDX3mmdLmJ9Pu3r0XaBAx5XocYyIzT+b7eN+OLiSpQxIBs=
X-Gm-Gg: ASbGncteLoIuQGRSxhRnJTXf2gz6FrK0j0MOSXGXx3lHU8EcBi0EYQKJYS+Vs+EBXhF
	K/Ebhf7m+gy/MUeGP1VaWVu6MuebZsHdHpDMH4Nqoz539JZDTADo+8fm8cjza+pcKtJj/n99Xqa
	pqZD8Uf+y13MKFg0fJVnVmFQdQgmzjVC+6t3bkDlowX/kCKr9wLn6V5s8GQSkxppNAyBTry9bKS
	HkujTcEK2Gw6BSW3c/eVlyvu7eVMNGjHwQxsYpgeZx1Gf3ojLxIcqKLKw==
X-Google-Smtp-Source: AGHT+IHywoREWlTPjCHgXz6LrNp2XPq8QdRZQCNCwljTgITn5uYE5NAaBxp2XpYese1j4K/wCyPxXQ==
X-Received: by 2002:ac2:5684:0:b0:539:fcb7:8d53 with SMTP id 2adb3069b0e04-53df01048e1mr8529046e87.46.1732931076138;
        Fri, 29 Nov 2024 17:44:36 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:44:34 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:16 +0200
Subject: [PATCH v2 04/31] arm64: dts: qcom: qcs404: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-4-b9a35858657e@linaro.org>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
In-Reply-To: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>, Joseph Gates <jgates@squareup.com>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>, 
 =?utf-8?q?Bastian_K=C3=B6cher?= <git@kchr.de>, 
 Andy Gross <andy.gross@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
 cros-qcom-dts-watchers@chromium.org, Stephen Boyd <swboyd@chromium.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jonathan Marek <jonathan@marek.ca>, Vinod Koul <vkoul@kernel.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
 James Willcox <jwillcox@squareup.com>, Max Chen <mchen@squareup.com>, 
 Vincent Knecht <vincent.knecht@mailoo.org>, Benjamin Li <benl@squareup.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rR33tk4iShQizxX1vNrKanPGs6fsj3vgKiMhLvDMp+M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm3zc0cOtxzcV+s0AdlejbFKfCk3MoBgg7lHI
 mdE/TXRJr+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt8wAKCRCLPIo+Aiko
 1QlOB/9R4WPOD5FR9qjxe/CCeC1L3cVvKs+q7z4z2LeVjql5LDA9RaD3lDajRH60NKnYbzwbnBT
 MucSphWrWWsOspuOnFPcgfOnMM2G1pdxD0O4Yzen7I4gt1Tin1CmYCCHIe45ubo6b0VF4Yquzpb
 QfHHcfrf8aa8gl4bXrbLZ1djLrGH9/TzmVdbEOe5mRWxfOjJTM05jTY9u+vsL2+dATs2TM5j9gM
 iPmyfNPf0w/P/eNLj+XF7rH2+pYRmvzuZkSs9lXzdNvXt3GQcdOPe/koeGwXVQyjc4tbI5LDURc
 5fgr32id6mSgRNJrQ4AUle2qb/orjv6JI1M/Dr4+8EWiJoml
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The QCS40x platforms use PMS405 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 9181bb939984 ("arm64: dts: qcom: Add SDX75 platform and IDP board support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 215ba146207afd25128692781926cf1964743655..2862474f33b0eab7c42fa2b22006f580c567ad2e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -28,7 +28,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 		};
 	};
 

-- 
2.39.5


