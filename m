Return-Path: <linux-kernel+bounces-551726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999FFA56FDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7967B3B95ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EAB24E4DB;
	Fri,  7 Mar 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2mJkKE9"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07724A07E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370289; cv=none; b=WhJe07rN2SMSw+IFGh9Z1m/zJRlLp5FQtEgEnQKp7mSPG79/xWBEvEUMne+3aADKQfbyM0Oy8FPhfr+3ddWMeENo9GHJ7DeUKH9LRxqX8oYSaDPg9T2HyFTQPO5zLKNC5aozS5Oosk0fRoJy0n23EPxVhetnRGDBv8XohoIInS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370289; c=relaxed/simple;
	bh=nu94xce3hyuD6l8b5q4Pb8Eh8vp9Z2NiKH6joMYQjlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/2NeqSzVJou8aR1ui7popbNN+WqDoAKUcArV/o1Ez3H6gQvFxmgtFi0SMUmiSp2qnxDM3MmIP2hs9rSJ+OB7nlPwALk726cc2PTHb9JGvDuQyEJM5cheu9HjCtvzedfAMdzpCFXhhOQ5Y4sCLc2NYIKE+wYVgZEATwvUFi2neQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2mJkKE9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so417124a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370286; x=1741975086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4ophriFopD1iIs2XtFpF4lW4o87XIA47+/GjWwD8Ak=;
        b=o2mJkKE9rokW83k6M/XzllLnMISB6N+NF1T30WBQBVHNuVnXWfLu77LCGLfeQ/rR2h
         RbtZ+NvgewyCNyHvRXU3Pscw9v74oJgWH+1ir6yLf8AuzVvdkOXxIJXIm3b7SLtwkCFa
         pU5ujxzr5zWF1pPG528+iadtAUDI9FRcWW89LlEHRBvdPTMinFs5yhngIeZRfN1W12n7
         r+4WSBLDSLhH+wR4Z4vh+HXqPIXHgX1+LtAY/vM7+hKt+7UdFR3ngq5H+D1nvpzXAu7d
         qDqJksTyya5yiFLUa6NT6k+shkqdIDHjemEYM5FfJldFs3rBNdto2qR4QXIKQ+7BMs2h
         Laxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370286; x=1741975086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4ophriFopD1iIs2XtFpF4lW4o87XIA47+/GjWwD8Ak=;
        b=MdhxW3cBrAjpJbn3YpdsQ0phZGzQlAXV/Vszac3YyELoEMEQHwEo9mCJoqBDZrZmWD
         0F5Q+iq7wapMM3JeIr1yeuvhbuYbSxV2julLW36EXro71Dan/UGOltdrqQB14lQGk3PA
         4F1A5Uh1ZCL8kRB0FmyOkKb15TdUQ4aR1gfARSHfFM2TO6Nb1W37rTb3JxfvhTJgD+te
         thnpJLGHBus1AjxBOx3jYiS5zcCu+FlcjeU1K/0uxOdY7qjvGsRR2Kh5B6llqGtDRLTy
         AJ+Fj0osutj2F1MFiPB4Yf504IvD90JqqnLyTuEq4m4cicG6OQ9NQq4eh1j38vBgcnG6
         Dllg==
X-Gm-Message-State: AOJu0Yx43rEfZtOimF3PL4Eza9Cnn1yLubp1DsAXvv/8fy7SPmKZlo9X
	/9ThxzuedYa3s5gquNndMGkYQZczW63Wv3MJTLOc6/8iffm+3IcE5sWEGTqJtHNFjQIfT8Nl2Ln
	Z
X-Gm-Gg: ASbGnctJ7zEsAbEigGubO2CnfR6M9UoekcBFT8SHrpRgR4amS03Gr6L+vCq4ahzNe4T
	y333IY66jiybebtjHcSL4p2fg4hR8R/bpeOpcZSuQYrWzvjaaSVZ9kaz2bLILLfteEVU+05osLj
	jpLVBExUo87J8p1/REvphauVE8N3ZuXAk0Bu9tRHzgxCbelkd6anCqL9RokpRUg4FxcH2qbOio4
	ovklPMIwCqHn3zbVoFE4qKZkCBK9nuwtYp5UiJeOvB45Otaitx9d7mxRbO5aLDs3B0xNBsprlAe
	Se8EafU7zt0aNsPXioTwP538BzrEDcbiqDkl+OCzSoo8jAw0gcRKpwW/THICB68Hm7jwgQ==
X-Google-Smtp-Source: AGHT+IGf/ePQheRAo2vuRy1xw++JmEYNIE2lSR8KoRs1lZitAhYGNlpeUczMrCDK0wXSWZVg2BwKNA==
X-Received: by 2002:a05:6402:448e:b0:5e5:e396:3f9a with SMTP id 4fb4d7f45d1cf-5e5e39643bfmr4338160a12.31.1741370285622;
        Fri, 07 Mar 2025 09:58:05 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:58:04 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	George Moussalem <george.moussalem@outlook.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/14] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Fri,  7 Mar 2025 17:57:23 +0000
Message-Id: <20250307175724.15068-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=7KrYFwn+zoxtcS7p7RKNnXyTkthKyH04diDTbjPiXp8=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN+uqkrbBFgImiw9ZOyRPVqD40fnJhoJoaXj 5/P1pke5OaJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfgAKCRB6of1ZxzRV NxjRB/4l91Vf8hdyaaqWn/4nGsy47UzSAzsjHTaUErZPp69ksoEClU6lfGS3SY/Hh39qYv/0vWN SOFHWvmmIpX5LF994hdwqOpA1kCNnGB8Lnz/s/qRW3do+EEFVBI+dSXbM/wFAimyWttzU0nuNOH xvDTvyL2ToSuaaQZKCURUmPio6jlYlh7MdQOSNDj/0MaD65drFJHzcXCFbhxQdWANKwT3vUvGBg 5Wsxrxbc7cocXqp6wDbuEfYmpxNGl3DrnuTQwZJxCq1F/nSra4n836fh6+z/REGPbQM1ABBaxy6 9dUobgMbOTMKwWoQ3NG51iEGcJ20rmRcdTE6+S9XlDV2lT7L
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Document the QFPROM block found on IPQ5018

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index a9de635bf31e..69e3669f8178 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
+          - qcom,ipq5018-qfprom
           - qcom,ipq5332-qfprom
           - qcom,ipq5424-qfprom
           - qcom,ipq6018-qfprom
-- 
2.25.1


