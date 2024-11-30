Return-Path: <linux-kernel+bounces-426048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608639DEE39
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC41280D96
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E441A264A;
	Sat, 30 Nov 2024 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kix3jDC4"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445819F121
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931113; cv=none; b=Z9my/xaHgdbRtsy09HU+0FeotPsBcl2rGo/n/jO//UJRecSA2mBoQmQaShjVkAv2zLmWPy0ocfg7+TLp0RCI+kYZTix27aMGQcKAMOM16bvRG0NupCVySymybfFKs5uf9+PMCe858gSNeIqNJZjaoRi0Tzn+kD+Pbw0S5yS6VWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931113; c=relaxed/simple;
	bh=ZvLjLTixMdBQjoPe24nZu6YTlSKcs32JUm86ti1qKNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4UKHpfTSkHQmkGPbn5dOHKaCaLkjKB7kdSLCudWU+Cwc9xIIt1X4Cs5tdC5PPBZ6mhHH+g/h152LExM6/rAPrgDTlEQ4H5p1LkFtRzT9xhlsF7K/vUJW4zv1xUKYr6gL+bfFTJOGA/u7D0VZK6dc4o7wrFfvMWs0P+kfE/uKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kix3jDC4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so26616591fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931110; x=1733535910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVCmmUf8PBHlUaaL3C3W4VRmmCJtG9CpcUfpN+vwcLE=;
        b=kix3jDC4GoFZRjw9PwBhsBw/lDt25sOs2Stw+leUFx5MlqihIG3jl2JNJz/tNwUK0I
         G98tmRm9mc1DKyevFiUpw2wcZf8J3WGOodC0KcetswNnxcRaFAgU/CWXeg3BPuwp532W
         q187BXjsKrACRDFyD7bnDA2QncmwTxAw+aobUS9fXeGtpD8LUq/x8mLL+T1oSEQ8Os52
         sIfCIKPPMWGCD6pPZTNo3+nyMKu8w7kAPIiyzvkLj6uwYth3sEQjoKqRcNM6yKYiY1i9
         lmj4FxFxZ9QFO4gF+kYNRf9Zb1UFiTa2jtiB2MFxnSi0AxWJiMidKgwr6AWDWjGsERgP
         dRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931110; x=1733535910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVCmmUf8PBHlUaaL3C3W4VRmmCJtG9CpcUfpN+vwcLE=;
        b=UyyJTWuwKNsj719XK1+7te0nRgF6JIQYZIKyVpcMPgwyIVRULOR4f9Vz93hwWBug4F
         6JEV9Likgt8C1GIa6QshpKhYyb4zsJmNRdPi4gEISAeLia+Fbg5uud5KPC63QX7kFeDt
         TAvAokawc0WL1Mu1Jg1OhAjGtG3mpfsjYvfrKmKWK/wkLp5FI6B9s/u1YygJ0VmXJOIQ
         Ix41Ns7e13lVN7GRUR0M3QUJ/RmqOT+gmzbnhuH29djS4Wg3ORfmeyZ4y4pOWegD7YQk
         RXxq2K1Nd2MwJw/YMMOyanTpByjD5BmkYPH1dEaeKxjdABVU/QEmYy0utDfmcoE6sfHs
         sH+w==
X-Forwarded-Encrypted: i=1; AJvYcCWeIyBVBpjD5TNZJI2/8T8gECNhFUqcIYfWsjLgRiqcldqjjlZpuhGeyDdpBADldvbYA9qw+ksSo90hVjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqpFmDH1htkYqyy6DkpvRQ5quPBHAE94eeWkC3IY2bdj/3HW+
	5j3moNRK98TbWVW+85V2fM5Mw5/hmSjnCI7+ixeJe6IH85Uqfp3w5uzgewHQyvU=
X-Gm-Gg: ASbGncvq4nroUJ3sJWG0knmLxy5iM4tLH8DTlvc68WH6NqQAjKlixGO6l0K1CPPVAhh
	NPKCEUgJeNT8VfpVVxEsaveOSEP9km75YyX1zSRj2mngczbngIL+iF1R6KX1YEg8i8wyiJUyORA
	Gasc5vf1XieKgRgdZC/MNwwWAMcklwZP3qGWKQu8+zsrl8h74EaWYJtlYByhpWXyYadn7XDAYCE
	jZ6MjjRKuDuH1MpDaVAMG4zm79Vwb9h4uPGgE2rkqFZzo/gmIKwDJAy4Q==
X-Google-Smtp-Source: AGHT+IFesfHPpMCbFCxXsi/n57S7VZGvEbuXC2Xzw8DQX8eNlh5DmPWSv8WYGrXzVaSrbpL1Zf+8Lg==
X-Received: by 2002:a05:6512:b15:b0:53d:edba:d3fd with SMTP id 2adb3069b0e04-53df00d9ce9mr8503662e87.29.1732931109708;
        Fri, 29 Nov 2024 17:45:09 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:08 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:30 +0200
Subject: [PATCH v2 18/31] arm64: dts: qcom: x1e80100: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-18-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ZvLjLTixMdBQjoPe24nZu6YTlSKcs32JUm86ti1qKNg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7pX7tdeIW0JHfv00sobK/M55wbeeu6Y6GF9Zlvycb+9v
 /sV9bw7GY1YGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRoofs39QiZTY78QbWcGx8
 c5vzXYrg5GrJtcnrFJQjA5fEtf4MnyWXPqXM6VTHh2CGfR5GslsXBTtUsT0Q/X7fbCN7TlzaifQ
 VksICe9m5VnFH1B4/FbfHYFF+a/PNA68nq2065Syo3Rz+Uk+t6MWvQ4l5lWczQkVm7ldgemNeee
 908O7Lmq/Ej0cmxR7QEpuzflf6V/0ga872+H3/1+3U6Np3QTRpz48DZUmeyq/sax1lq35kfVO/G
 axm8LV2uqxXUc5r89m6Z7JVlsTe/Fd9O/gn6wqBztlKRd5cV26EZfm23fhhLriJ20nJ9sVC0c7g
 jhcOdrefC9wJskpLkLld8l/uclnNdc/18i9OnRdcGg4A
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The X1E80100 platform uses PMK8550 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index c18b99765c25c901b3d0a3fbaddc320c0a8c1716..8f3c4c6a1fbc57412258be820e480c1bff7b520a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -38,7 +38,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 

-- 
2.39.5


