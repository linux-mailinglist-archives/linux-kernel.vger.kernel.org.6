Return-Path: <linux-kernel+bounces-426040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA289DEE21
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ACF16203D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD971170A2E;
	Sat, 30 Nov 2024 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYkYc2Fq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2412EBDB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931095; cv=none; b=Ki4DMRSOa9mQ9Bu8d+yaraZ3xgcYAosM3WDOb3JZxtpRT/ZyRsPJkd61U9uUBHnu3OFAOxd67+X3lqUfk41awnEpiX7sbytt6v5plCjWEMXZlX158HcuyXFJwsxvVjMzszUfSEHajcy29lN7CskgScn3rpb8wEcnbz5sR4EZ3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931095; c=relaxed/simple;
	bh=o/j8/+TO8OD48smfSUKUdOz/ApCt6Naf9bzdvgRGXWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSPERtKy2u70xC64GZJKOgja0HHMnjFM1LPs6BNF74fJotHtsB8qwFYS7WesaLeQDOlbyNArQgwNZWm+xJ6jZyHwLDakxpEv8b+WBCdsG47J99G39fb6n5z/fbXR84DAcR4Tsn/dUSjFdALqJJjSCsx6wZ3a7lxu3SW/8HSCOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYkYc2Fq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53dd668c5easo2530231e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931091; x=1733535891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUt/nlVp4F9zk9gauat9gnZ6HMkU6q3REW18DcUkNb0=;
        b=pYkYc2FqYFtnzGxwlcS4na8Cba5NyM84TEJMIYFvNAacj1jC8IO6Dyw6qBhultRomP
         PMNMpd/Z/P51jinoetnR4/nOofixUUBkxIsjfIQPPWzlAgzH45SR+s+VJ0p8GBlCmBa9
         iSBrrAVK85Am90JggFnJ5GGp6a+GeTo97uL+60buvrh8aBnk2WmgTUoSAkdh0H2L7zq9
         Y/V6MJuIkqr0uTJOIp0zcB8VNW1rGF1p27c7+2+8xd5CnePSfEdvgGeMHtblTxYf+60K
         4pj2DrOlJoyosWOLdKn/lkhd7GWSmq57mC494V7OvmTqyE13SVyNN8nXPN4y/X92bzlk
         h9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931091; x=1733535891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUt/nlVp4F9zk9gauat9gnZ6HMkU6q3REW18DcUkNb0=;
        b=EQ7b3XlyGY6YBTyyYgnCubtZIGCd89yARDw4jpAKnMqDRjt7ovrEfz2+5gDcJqerDn
         ALae5NJqMgFTyjm2WDYqratZwpjNsjA1J58ZAv0DfMcSmQbbXR/wMlYBqZEfxjjC5HLs
         bmlc2zh3WGZ+ECc3Kuf0DZwwtQLb/R5Htj9kkX3jdpFuGd7lvkL7v7ia2qFOLyld6x26
         b5J6E/rQuzz7JE8TvjJ31+a7N3dY0u1o1R62IyGhWzkRtM9BTKmfUzXmhQqsoD9buCDR
         TLtHrY7m49TIEh9R3ica+f2opbTCWz4RSr77OQr7WSSXLiEtfOFZB0wim2k8KJd8wURX
         pNsA==
X-Forwarded-Encrypted: i=1; AJvYcCUPJjMYUF4R7GbhvG3Eef42PqtmnqcAGcfWAxE+QBzbWByyFB2t+1z23y7Dvq4GdtCckUotOCGzNHP+/hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FZIDeZ1tSqExetnv4ccJsTFZ7NBShd67lqQH0uXPcXbu7hNm
	7uMrS8aL1Dr3ru7SLY3MFrrwxMmf+LVFuV1XVe5++NtVP++B+10trCt1ZStY8HY=
X-Gm-Gg: ASbGncvSfrMFnudlDHPXJuOFI8KS5K0+P75DfsnMN0LaRvPumUm+y/DmHtTnFTye0ji
	lPqx4qFyPs6M45DpGnMWmVDKINQdErPEr74Hpp0gslvuQcRhmiB6SQvq+shRj2mhYGMe9dp+bVA
	1b/uNd+Ehj+NvW1y8h+QTayccmdzV+fh4wntlDNxZbMFQ3WlGJ1CXTjWvuNvT/WBfc9J6wERiXj
	b7iLWVIFk/1bfMzCbMzSwuYUEkcsuzg9S8u6sJDbd9PcNRTFPOYKYSWdQ==
X-Google-Smtp-Source: AGHT+IG+VXAE6zA5YU4cvvWtvIkWyMzG8VWOgSj6ZgEKM1MCpzmDmadjkU86hkCNgb0YE9cJ5GHyPg==
X-Received: by 2002:a05:6512:239d:b0:53d:f42d:c6a3 with SMTP id 2adb3069b0e04-53df506db35mr3132580e87.14.1732931091519;
        Fri, 29 Nov 2024 17:44:51 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:44:50 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:22 +0200
Subject: [PATCH v2 10/31] arm64: dts: qcom: sm4450: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-10-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=o/j8/+TO8OD48smfSUKUdOz/ApCt6Naf9bzdvgRGXWo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm30Q9G1cCTXOPTx2dTJNxkog61JFfnb5hKE1
 85pZ2nBxB2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9AAKCRCLPIo+Aiko
 1eo4B/9Z4HSdH7h5Ma+J+mN8AU7NmBowokudpJz9rVuhxYMWz3xdMQx57sm7THAX9CKFhA7Fdn+
 tgvPenMdzkYidciMrmcXw/Z0Qbt5oD+TO2DG4bRbMarDNFeGPBqPIwufwJxUkPrmpQN9xi7LGky
 /uryff+5Z87MzG0e9RCXzHtjge5nm6GbiVuq671Ut8Lb6KhuNE6DZGkbyiOxBQumNCAyzAlkH0v
 BxhaKPTitoasm23Dc3gv9R8Rm3psCGAzZFNBI8RG1pLtkvXIIb+TD5RD6PJzjWmhvzokVOB1aoN
 h33uMTSSSnYyDCYeu+LhdnNltO1XKpfWsvsX0Ao/zzq+a8cP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SM4450 platform uses PM4450 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 7a1fd03e7410 ("arm64: dts: qcom: Adds base SM4450 DTSI")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index a0de5fe16faae5674efb0070d4017983c86603c4..27453771aa68a1c4dbd2a986af6785fa05db147d 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -29,7 +29,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 

-- 
2.39.5


