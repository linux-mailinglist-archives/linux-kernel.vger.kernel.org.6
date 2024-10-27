Return-Path: <linux-kernel+bounces-383442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E719B1BBA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661971C210EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E71768E1;
	Sun, 27 Oct 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHJWDSkC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8F2BD04
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729992302; cv=none; b=jOB5e1DJZFS4qjWRsv7NRWxLgbg4cmIWmTU/e9Rzi4Jt81pwAXzQ71/wuwOuNJCZ/sCSOju7uSoW5qb4D+WoWWM10yDhxhMoDsQRV9qeIYGtiOcReYyfqU321tV5Hkv7dOFyUtqoIwCKMA9fM/0IuKwmkYEXJpoGCPcWxuIxq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729992302; c=relaxed/simple;
	bh=1S0e8INDTJp4RQZO2xifYyW0FBrz3v2kT78lT89hhEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rkt1NTonl6zf14K0Ncz39Smz+7CNqsJq/hIuRNWv0XDk0NBrSa26S0iAJo+8qW0Z6GEN4y9X1AxFmzt6NNp3+W3/bRH8OmijjQ23RgJpX7lRwhCabvMlu2p3gcgax2JJgCOm5Y+V4zHUARZbaw9AWUc3sfwx6xjG5u+fUX4bCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tHJWDSkC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e59dadebso3866567e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 18:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729992298; x=1730597098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQiTcshw9Ox4It49mqmwWy0sWX4h7q2ja8AFVlIbjLQ=;
        b=tHJWDSkCvBHoKWKwVMpa23wdZd0CGfIAhiR6WK0y6tybnQTek66thLY6WwHUj+zjX0
         ZLE/TrKmgu6Us78Rl/efyCZ1odEhJ8zC5J6ZOMbkh7mGmkjVPzjEo5EzzBR40DS5NrHy
         kShKn7HriJ+XKyCCsn5OSxAVNwMLwy6kWJKUJIY4vQ5huQq++26OWPiYCLtRvaSoTM1r
         PziV5lTvJcdfayzOsM0Yo9FEzbLFYgppTjfj/zNs4hBL3DFBqyieepMG9VB+0X++FoyR
         /+Dh8KPDUL8Hki23B98DCtaAaVcAxJSmTHkXxeZdc76iIdIi3CaYWiTbcXcTLQIJLyFX
         tk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729992298; x=1730597098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQiTcshw9Ox4It49mqmwWy0sWX4h7q2ja8AFVlIbjLQ=;
        b=beUXN+ee2AwS5ZQikEQQmx1tjh8hmlOYUUhaj5c/Thh7F9FndToVUPdbfmTJjDxWp4
         NN1m/gud9nr7qeFXqHX8kK/bbB8xHF8QjcBUugj7eEjtoqcxnx+rmKbDyXBfP0ClgNOB
         sO3uHgjBxfwVM+xTGcg331+AcQC7Gd4B+PbMShWzDE4QQgATQCZOVWbwaYjaus3tA2r1
         2GKNAB7/Ck7E2PxgIX9I0ZGpLV4QY5kQTvc7Z1LsjXgKddLbqxeGPcmXj/Lfwr7PxyiQ
         vxvdIF+MFh+E8j3yfy+hqQb1H9isymXOK99V4Q6y/kJ2A0lbiWilSty7hdB+gmJ9U/KF
         WajA==
X-Forwarded-Encrypted: i=1; AJvYcCVwOPwoEnY+xreBv37T1gPo5UkKa7rpLrYsp4yKZS0yzIP36qVjy/ouFc6iyOK3VSkSPBmdtqu4N+cw1CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNiS+keE/pw6DQarmNxsQxvcJR8M6aeuQL2Zf7aAEqwGn6wRjQ
	RLTpkODaV6GfvYb6TNeoYImf9w7aOgRurZurJ5f8tplXwydGc+8zrGLVd3w89bQ=
X-Google-Smtp-Source: AGHT+IH5CXm26TQB3hvo17DN30FJ/sSvjL7L+2bBTzmwqfT1kDCTzAOthra7CCBxoi/qcNgrGyx+Bw==
X-Received: by 2002:a05:6512:39cd:b0:535:3ca5:daa with SMTP id 2adb3069b0e04-53b348ebf88mr1319185e87.7.1729992297772;
        Sat, 26 Oct 2024 18:24:57 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c901esm642356e87.219.2024.10.26.18.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 18:24:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 27 Oct 2024 03:24:43 +0200
Subject: [PATCH v5 04/11] dt-bindings: clock: qcom,sm8550-dispcc: Add
 SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-sar2130p-clocks-v5-4-ecad2a1432ba@linaro.org>
References: <20241027-sar2130p-clocks-v5-0-ecad2a1432ba@linaro.org>
In-Reply-To: <20241027-sar2130p-clocks-v5-0-ecad2a1432ba@linaro.org>
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
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnHZZgruVOVUsl0coI/dBDX1hksdPfI8/yc/qOT
 8UvkwuWupqJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZx2WYAAKCRAU23LtvoBl
 uB+pD/9+UBnLFsgGXBvwMq6CMmo8grzYWpS2I/71QyjnBMv5BWXsxZvmq8VrPEK4OKQv83M1i6k
 Lfls5sl2zdugou0xNKpzvJRyanYYW8VB7kt1e5WQwJc09jQtyMvjApCp1lGvsUDXXWuakoSdPdG
 Ng33awMde//6uxN5sRFqhj+65Dhw31tB5Vb1oV/bgYyg46zi29jnwSm0Eb0KLSDGq9RShp0OQqW
 D7E1vX8+wQS/C1Tamas4D4PFSTA7vGv4+XO/dvgEMTYWZyq7D5IxbHoa+pMHXSt05VreKb+MN7b
 44UsBiTeSFwCp6SaU59XYNUKDpzcZbv/H4h9DaoWOPVvN+lBY07cGDEVpwTJhMBfqDRCfs3BdKs
 01nnOlhhXzdCrckVmY6CJmYH+Wb+Mqh84NrkjwTdLJe8pv2MX4yqWaVhoYcq5AKhw8647PooxyZ
 HqUffn3AKnKo43OHl8b8i3YY2AR+CwsqpIgvo7705WejNNK3wn/cmcDOZCUChLA3aQXtcVkdo+g
 INo4ycRWsR5SGeTeqo6eGJLNTSaGieUBoFGD+Ck2Gwe9jlHNpNC01E1X2I7KprnvVvSlJ/q0z+8
 mOlOfn8cGvRSRdFtNOKSoOJ/7h/LRUdpCO923lxXg4Wx1tIjuPXUK/Thfzaz7YPOACyNUsVt/9n
 kddjoqwPYN3LP1w==
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


