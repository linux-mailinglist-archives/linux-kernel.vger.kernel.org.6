Return-Path: <linux-kernel+bounces-426038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F19DEE1A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C878E281BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A36156C6F;
	Sat, 30 Nov 2024 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvhQx38h"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684B155335
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931089; cv=none; b=P4/zQwedTVp90sg7uACsfKB0ERiXBHk0VDFBKxVZOXOKXnBQIG2dg9S/PdGLyqoBUUOANvyNE6otaW9fFyyFGzDK/hYIsM6rUuzvM5qjI24YXR3MkkG5dHvg228XxUOR6Wgz80CJbWNUed3XBMsUTYT6l8vC9lL1t7o3FYbaKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931089; c=relaxed/simple;
	bh=cwHGT8dW2fufdVjeg8a7nAT+ERCmV5CuNqJS2eXbLFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsJsrDdkjzK5CnGMazJ9RmmzMBW0Zw6QUCMBj325sE/PzM/NOlJCOurSZoeibsCtskI4yXCDaapkx4o7JupwHgSHulD5VYWhy5C+3fPOKkB0eiwLmeNmLos9p5tuD+QLijxt4e80uufiSrYHR22dwKi6eCCSO+tC8m2cugf8jEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QvhQx38h; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so2983421e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931086; x=1733535886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUBAhw6SG3dsXPAFEzT6mizjETu8TuHeYIqS7qX2o8o=;
        b=QvhQx38hQZi8XKLRmJi6P1rM4TAkRkIZAFAy4yZnv3+OUr2rbdSfuCRV3Vwh6/2LrA
         kyBnVNmX0hqibKFLiCSZMZhvBckiUxgYTvlGymvi3vyxOv3Oj4JYsfJjZrpbIytu6Q47
         YZU7+JplFt85KgETQY4NnhuAyOcM02NIC/GYFb8jm4MY4BeZJmxJRSM6cRs7C8XNlHSg
         +eaN/y/Intyxxtl4gDcZZbHTD2cd9dcCUBhwEvSp4jS+sEm8MvIVA5LVLxQOI5uPZEe9
         Y+pn5lYzOq8KAWk+EbGC9MyTz2rkqKaGF7cDnci6tPo/vuEz4pF+Srph/zN1kZ9w7uwK
         akuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931086; x=1733535886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUBAhw6SG3dsXPAFEzT6mizjETu8TuHeYIqS7qX2o8o=;
        b=lwo0PjKmwzW0K0sq7MPNZ4RY/yaD12MEtomt3OifO1BR5NAXs+IVKJ+iclKAkxXakf
         hHlizS2jHvSQyFv1yxSp+aplArhjBhgWSsMW4D/hyaO6jk0uJ7nx79sipYC5qLWuycLu
         CxXD9bL5pgzrVNPcT/ak2/nZhQ4E6dSlXsKNj3hdqeuldvKsta0oGhU6MRxYF4ZraaCK
         BCY5cDo+8wIXRKjuNAXNjtOFyTY6X5HiFLPbalb6cqkW2shVo3na8ZEnNwKIIIIU9dTj
         rj5iBo0j4BYcyLDu7LVFQqFCz+6BzVrP+Vqj7A79nPGWffPgjK8ccjA6tnp7KWALQt5S
         FOMw==
X-Forwarded-Encrypted: i=1; AJvYcCUMjHehIpxEEjpkC/59cmX82DEoBTA99VnH/xuF2h6IcG9dDx6fanUSiZIwGyYHFcKJlgHN6QOjDn501wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99dq7yn0VJmXZ8OHWYw+/SLt6a8gJhCk55wLtMvu183BySvM5
	sitw2Kgr9eJzydnr3QsW+JhzhxxZXA5xkEEUb8Kw3sOiuY3xvc7tvH+r5WPCxVg=
X-Gm-Gg: ASbGncs713FmWP+yJh+yVXUBR6wDd7rXPr+n207fCxLjZd8DoNnWgwrR6faOkGhOsKX
	S7ohVthDDxR1sBCAcU3YysrOpdi6Tqfm18qOYjle1vhj22TLbrKXFmtm1uV2d+pOcPbEwSt+0Kz
	v791ZVE/YmHafelrBabCHbd/wrpW/2KZKDpck5UT5eVIxCfidrjTicWfpnkVo2KGe/N6xKbsFuO
	yxZOJY9RzmQ8YqbdmXb+ewnHku6ab9ORjMmAKG6O8QKaT7fff0fAwsTww==
X-Google-Smtp-Source: AGHT+IEPi+X71Xr5ydlpsLZUQnmiaX1oplH8lKawDP7TUOsj75l8a1wW89AwaS9jiffqrAY1bOLP7Q==
X-Received: by 2002:a05:6512:2203:b0:53d:e43c:9c64 with SMTP id 2adb3069b0e04-53df00de2b2mr8648482e87.30.1732931086317;
        Fri, 29 Nov 2024 17:44:46 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:44:45 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:20 +0200
Subject: [PATCH v2 08/31] arm64: dts: qcom: sc7280: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-8-b9a35858657e@linaro.org>
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
 bh=cwHGT8dW2fufdVjeg8a7nAT+ERCmV5CuNqJS2eXbLFY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm30t8SRmKOAuhUMuhgKfV7LHUvg4Wstu57so
 qZdzx/edM6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9AAKCRCLPIo+Aiko
 1aLuB/sECWiL2m2/MeQbPYtq6Q21sh6UP8on1KMocDd5jR4v6VgOSCOz7vTlB4l5sLpMYAXD5gp
 Gr8eB6kG/oGpdemcwWSVhmNvmySIxn1Ad0JMVx+PtXf9Pq7yCQhtYDzCQfbk2LuhW+c03cbq/5Y
 jrLwQC4RKjNyK9OS3grA3nKD5exT8t0y3XUKtIe2iuqnszRHuVxeXcQuAJcV1YHyyjP0EYYc4Q/
 CiW5lhaL0VYBdVZJNsiFgrgfsnsHE9vo9noJ1g9LC+Y5O6tLzsDB/WVwJIlunnAaHTaQZVuovop
 l6TzjBSgDM5Skn3CZZmyFNW5DkFut5i91qCIcxJizY5V0cx6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SC7280 platform uses PMK8350 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 7a1f4e7f740d ("arm64: dts: qcom: sc7280: Add basic dts/dtsi files for sc7280 soc")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 55db1c83ef5517f82504816baeee583695065225..d12e0a63fd087461a33622e8771422c8acfdbc25 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -83,7 +83,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};

-- 
2.39.5


