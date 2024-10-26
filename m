Return-Path: <linux-kernel+bounces-383282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702219B1972
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A98B2155E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690DB1D799D;
	Sat, 26 Oct 2024 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuOLzs60"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD851D5CD6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957637; cv=none; b=luHEfbUtxcirmshYmuE0JKWriHmZudZgxyndZC8MuBrTw22L4WoK14KQLgkMohS4J+RUtlDoP3hjmikcxrLjclCU1XjMZmKm/Pwo8a7odnywyb48Rc64yU6hdxcEbf2Lq5c/r4Osky+YquhIVSbK4uubTCtvwhr9oYRSaAhVss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957637; c=relaxed/simple;
	bh=1S0e8INDTJp4RQZO2xifYyW0FBrz3v2kT78lT89hhEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJ0w98AAgC2qiTVhOQhXkABEaXeTOQLdskf2m0pBdXMD+/oIlzeLrYBwM5nmUFVCfatv4E6IgxFDkBNyRUPIClvAbK+s1M3Gr84beFVX9c5GJLxmsBC6YPLOXCHCh2/WD8m0YZbacxOB0Y3Zos6g74V2yEXRN5PvKnjQ42oSiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AuOLzs60; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3225080e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729957633; x=1730562433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQiTcshw9Ox4It49mqmwWy0sWX4h7q2ja8AFVlIbjLQ=;
        b=AuOLzs60EHC0XeFsuL0O6CVgX14Lq3aswegxNzAsB2kwnXOR5/xz7oe37Rn9WmXoNk
         9XB+4XVcuSwULNJMFeZlFyVG4vQacdC0gRSr5MAk8VqpfAEfP0vy1IHIYToPdvlZPkYS
         UGbEUR8OAEEAE5Plp41rvVvecx6ny2/DrkpqGLk8XPZA0mv/FFsK4OVu5ujsqP64V4Ye
         K4jbKPYKdh1655m6DYIvVH91HrKyS002XozPMrvYaHtMa8PlwwOA0SRyxnGaEjwmXBy5
         5yyYPle6fvko/0UFqpnH5OdicF+UCWvGwz0y3GVVYYD0hNjqHaLGGqvzbLSQyGl73YHe
         Vjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729957633; x=1730562433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQiTcshw9Ox4It49mqmwWy0sWX4h7q2ja8AFVlIbjLQ=;
        b=P+w4Op/t6GNxUDyazH/Y/Wfm9zK6U0kExY4px8xNgX/l0Nyt/4N5feqr5X+pTYo6YT
         /TbemTiP2nagea5b9ZD0ipJ3ntbWJ8gSwJeebZ8l4TcEiISnNTCmsJrtzwgUjGewAoNJ
         /72Po0LAoWLo/xVy7gqmlCXU4vDU3qmykYV/bkULoAqsqyQViUjs8ZSAKVmSIv2FYsFK
         mDtgi55INMybhOHRokQCxvjvFP2WAqDB5/0MWmwIys4l0LCAtm+HJRBVyeIfjsTCWtpt
         wIcoTDCn7xE8bC2mUWsa55wwSINNeauMxeX4MWf8NGujGRVvu/R7CNPyYlsSujVfWezN
         IZFg==
X-Forwarded-Encrypted: i=1; AJvYcCUd2H+hopqLbV/rnjwEAfjO35/yIc9zzwXHit05LzxwGIh3zNDb2ZjbqiiqxPzdjXgP5bl2iuF0r9qqBHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYpG55asUqdMwSBCPQLZoC/ttMsG+ERySbLS2csudXYOXbMHt
	Rji1SlfQWImIYSQewgfRvzvPSZwGUprBRUrJVPCE+elEJXlvAAIF/0DhWyiSkR+bi9I1vuvgqHV
	B
X-Google-Smtp-Source: AGHT+IFM9o0y1CBVkiF5YjA2WA9nxw8S+6/mMEOtW2WbUFfcrAzGlP04lnVmJhLodAPMHBl4ebHu3A==
X-Received: by 2002:a05:6512:39c4:b0:539:ebb6:7b36 with SMTP id 2adb3069b0e04-53b348d893fmr954679e87.25.1729957633490;
        Sat, 26 Oct 2024 08:47:13 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c7cf4sm532188e87.184.2024.10.26.08.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:47:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 26 Oct 2024 18:47:02 +0300
Subject: [PATCH v4 04/11] dt-bindings: clock: qcom,sm8550-dispcc: Add
 SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-sar2130p-clocks-v4-4-37100d40fadc@linaro.org>
References: <20241026-sar2130p-clocks-v4-0-37100d40fadc@linaro.org>
In-Reply-To: <20241026-sar2130p-clocks-v4-0-37100d40fadc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=1S0e8INDTJp4RQZO2xifYyW0FBrz3v2kT78lT89hhEk=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnHQ72ToQpDJBXu4jZeiQUts+xrvJeVcM6Vwxpr
 +5GQzSbHm+JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZx0O9gAKCRAU23LtvoBl
 uHyGEACigZfBTkSpyzvogAr3GEUjpHulYnkQ2oXwYQ5XzAEuOFDtaeIILyllT7cC46/plKGzL8Y
 n/o8nxlfU3BLnccTWjRoR2doQMTN60g6mSxcELvvHQ2bM7j+0kn+y+9jLS3zS40mG5xCB++gT9q
 4Mh01P2lYXc5Z4JZTWD5amIsVLJZh/63iESX+ak/0++il815BWuAy4M47+KXOSv8GQsu4zkVxyH
 Foqi9IqmtO+CD8tmsJ1Qm2qtNTi5K8twanR5wfWPDjVDJWDAx1BDY2mDn8baLHfRAHb7ge42DHE
 l7DaeQdqgdWl6wcjWjp6fCa72FQHxA4wB3x7HZw2XP+C/dC4Mpuck8DcMeJVEu+4vPq+GcE2AKh
 DzFibhS1l4cTnV/1LMV7lD+r6HOZcOl/4Rxa5Uh5GxJR1Nk4PCN5tTRV/EeknsgLP2bKQcJqM4M
 dc/J5wqisoLcI+TN1x2TO/rqCYCyuYhig15duUfCeqVAsnudvRgN44psjGe7UCUxzDyo3tv3swu
 OZ7s5lQm0iU9G6Mm5aTsBxvGk+b/PjVZq0KYEp6Vx+ASBoU7mjN8emtDo7GhtXSeLx2+sy4pJ9D
 APGH3CyL87fG/mjp1dClgW5N/SdBAe/XQBz7RIqt13H2QVNQuRd/y9vV96Hq22H47R3Qq654qQb
 hDIlBljWLJTJmTQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the Display Clock Controller on SAR2130P
platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index c17035a180dbf3dde715a281bc54165122739618..c57d55a9293c214c4c101902cdd9603074e2243d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -22,6 +22,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,sar2130p-dispcc
       - qcom,sm8550-dispcc
       - qcom,sm8650-dispcc
       - qcom,x1e80100-dispcc

-- 
2.39.5


