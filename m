Return-Path: <linux-kernel+bounces-426042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A59DEE27
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B187CB22033
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B229137930;
	Sat, 30 Nov 2024 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7kcCbVj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5912189F5C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931100; cv=none; b=GValPr3Gg46Ao45batuMxvaAYW0vLLhMa+YhhcVhlYdgDiVJ9xgERCn0vEv2tQXN/nzC2ZvQx1PA0Kl+Gd+NBa9iNJGz8ugV71l7kaPONAHY55e/2BMvNjjRheZolvGNLaCJz1OENDE5lR+5xnRimzwtXb5ZIq55yNJhuiZAr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931100; c=relaxed/simple;
	bh=pg+0ixud7QxxrDakgimvHJR2/Qzsae3oMGYCum0sTmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4LdkfXdKSV5Sbw8ryVfzf15d9VhP6hLbYIshsbYgFXotCpM/ba6x4hXzVvXcCXcEvsf5s6cFENOGtpLDqMIhX8SIyEv15kKvSC6FOD6AJ6hEDpcE27yaQ3qHPMpFTQysWU0hZJVLJghMiM+GDPZAdD73Pgu8YwlgbGb4m+qbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j7kcCbVj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so2983464e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931097; x=1733535897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65t0GELKzjIJZOp61osw9K8U2WzNgdRx1Petkma+CoU=;
        b=j7kcCbVjXdJPjUR83fUvRKxmz9Pjs7COY0vlu4NSvieXcv1+varvHR8U6QNyP0v5Ep
         YU/xeEgmsmyTTewPLsfC+HvDje+HbEnDTaR5n3KBeZZgfOeNK2v0QbPAWnqNRp8AYNnV
         ex1EbuHoKcjiXmdW076cLqpSSuiFVi73pVJtGFyeLKgrnEG+nmF4/pwnAQBJ1u7CPqQP
         uz0IWQa6K6BThKtGTjfr/gxEMUckQ7Eg+KUEpqmlBeUrwLx+blKaXVakHMlABI+Gj32+
         IDXvo8qFrqOISIIZB38AjwKfg1nbbeYC+JQzs7R5cdp9Ets3W5dE/lLHUCiiatV7V2wm
         LVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931097; x=1733535897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65t0GELKzjIJZOp61osw9K8U2WzNgdRx1Petkma+CoU=;
        b=CS/QPCb8rXQIKUG5sYJ5xjkbbu17xwGYcIgaeAt7rQ7lbjotc17JBmm0leWuCYdGAS
         t2Gj+SENQ3RxFP00cGZs6+rJt+sTe5NXWGqRhKrvGxvIAkmYj+0SGPSmsoAM21tIUrNv
         BUKqeMzwGRIK8h+g0T99jaUPnbZBEkSioBhrxcMqAlBqRwlsJUI7rxxCbhRR3C+J3WxZ
         sy4pi+Y+GnYlWb2UtmzLrxE6muow8MYys8dMEEEgwLLWJBP0FtCZFn7zWGw454TtHPKr
         jPT2mTnIFZVlGQUfAHYw2P0gxihsnQpASO3GRcDqP37RiyfUJNQvD3ePpQ4Kwq7gUd2j
         VFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX11JJsGrAx+ypPdOy/Cl2ZDawVH7mDFdBO8fMCLWBhmj7vowpl0NDgUHmeb21mxEsWBBcG96tGO9SoOPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxftZ5qxTZwlRQUvFg2BY+5RFbIva8edJKba8oiPCv0MqpVz5g3
	6st1HaOv7lMb++XyI6BeIC69NNXg9WoHEY7EH/6QTfgKEFiFKAW5UUhMPqzV0cg=
X-Gm-Gg: ASbGncvoEgtGbC78oAXGAJld68jK1ZNUYv1HhxOSaUY5zASZkq3NZsHUHnLavtOGlaD
	Vf/oy5bRlSoHxcBTlc8GscdEeSLVHsvUarju2MnBRJYZ3fhr5jVAjXN3d7Qvtu+p2liGdu3dY9m
	8ohQnr3cbfnXOoiBAi+mRl4oYGdwux4cmivuB/3jZ0teHut/iItzvQ/2g4dYGwrvdqBf+lzDvJW
	4MgBV/osav2VKXjoanTJpD9XsdCZPbYZzFRwDhhWXFfGS8HYIwEtVnBng==
X-Google-Smtp-Source: AGHT+IFMevCFY8zoyeQ6DE18YFL1ZiGJOLFPeyQ7r/Qji/vv9Zjs74L6RM7gpJW0EbWSlLrU3s9U9g==
X-Received: by 2002:a05:6512:2309:b0:53d:a883:5a3e with SMTP id 2adb3069b0e04-53df0108ff1mr7902207e87.39.1732931096896;
        Fri, 29 Nov 2024 17:44:56 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:44:55 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:24 +0200
Subject: [PATCH v2 12/31] arm64: dts: qcom: sm6375: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-12-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=pg+0ixud7QxxrDakgimvHJR2/Qzsae3oMGYCum0sTmc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm30pgr9Naoq+3Qet72FV6DwivG+cEdaNoCl8
 Co+czkbIsyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9AAKCRCLPIo+Aiko
 1Xg1B/92NJCJdlLS/k0Z3h+rzI/LkaRkV9Jl8wywC9w93L/MjLmdjFWCIUkp9sXn4GmRhwXVeAr
 MUu9whrSnpmxNRWjpyIQ+MFNLjUKRy0yQmA1JeT3u/gudy7hqUoglQA4ejPTTDZOzbuh2chys0D
 jFGa9k72G7oqDrieYKHc9rONxkKFoj/jbUqXC62Ov95V9wMOqGNF8LZBAR7wTEy96dBRcmRgY98
 IZzUPXSN+phglaoYbCasSiOxN8kwqsgFMRobRniIbUfb2bCmYnkrKpSqpjGa7EXyCNFgdqsyC9Y
 IknUev7fIFeNcYRAJy7FgqnXyW1H6oXo/PYxAqv4qbfLtllA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SM6375 platform uses PM6125 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 59d34ca97f91 ("arm64: dts: qcom: Add initial device tree for SM6375")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index e0b1c54e98c0e8d244b5f658eaee2af5001c3855..7c929168ed0805e832b818516083d48968d3bbce 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -29,7 +29,7 @@ xo_board_clk: xo-board-clk {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};

-- 
2.39.5


