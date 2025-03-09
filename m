Return-Path: <linux-kernel+bounces-553172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89714A58524
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4325B188EFE2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC51E1E01;
	Sun,  9 Mar 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dunwmoFI"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F91DF24A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532258; cv=none; b=Xzk2TPd2/DtzTUVVL7C7fPF7LB+OwKL/S1Erh8wEkcJNPlxnMKZnbcr78OsOT+/YX/3N3GfnfgEIZlJgMyESU8h4S1hCC6ohK/V2ymdKiw0Ix6d2bEMu70vYO6jQmWgXXPFBKGeztveWfEV40PV2XeB7xW/smtJSKwc5fOQJMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532258; c=relaxed/simple;
	bh=7MXpC1UsPTFkEH6w3Dr3IjWHrLN92YVeJc/OuOPJTDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRSK2YDbuVoHxZ08fFuYgFEILche7rCeUbZLsmMFEam8A6ERkmkEScs5VfveTCrKoDZrryoE8wsWKr0XUsxMNHi/3SIQifuxVULBRFHZjc8aW7MV9zE/N96C2ERr1nUtunH3gJeRhjn5m5MW1O8vFzFi1dwjUdOl5+sB3fp5z34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dunwmoFI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso1615929f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532255; x=1742137055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0Dr+cnFlbJ+1l2BNrPM33eKwGXGKx+rxyRsMaRmDtw=;
        b=dunwmoFIRcwTNom8pcSHxdoz+bLq7n1bvfJaWM8L5ZeNj7DF+sjC25Ib+InRV4yq5E
         2MACxCfKcleeVL3slamby400hruo0lXS217xJBSZfXDf7FudOp4tkxnAtZFfq/gVbT2p
         kN22DU30Xx6yA/LdDhfYTbKtAH8FQDtgFWbcwoZAI+S6e+CZshvlS6/UXisLi2ITrwd/
         zUQSaqrcIEz8DCX21RoVZJyCQY4PBtB+3vuZcUlSjDEjTi5FibK+Mnbn2l4JRbgeqLFM
         faVAwyBmJ5MS9K/QAFxgUzaZpBfCfW3Wd60bcZw+568OT4WyWFQGNUXPDzrDOA11BVuY
         baUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532255; x=1742137055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0Dr+cnFlbJ+1l2BNrPM33eKwGXGKx+rxyRsMaRmDtw=;
        b=WHxk0v3LwSQl99OJq4P+rZgfJDUqn7dLlYRcVDl+VtVVj7klsToDPL2ZCDF76/HWZU
         /PG0s+1SdW9VGwLDqAjhRge3PUrLHYTRnRy9wFvpGSiv7vsaF2wCs4STkHgi0EjOzNgG
         SuXY/YoDDwdyRBR+WeFG2tqymtJdXfskWn4E/0IRkO4CQ1L4JVaVRyaD77nBgTUTjcsz
         Z/56IgXcp0fJ+FO12sf237j4af8ZpKk2XMU84TH8gdTDKT6pFMEaJYhh52JhA5ETRIsX
         s9T5Z5H11f/cA4RPwC1VCX3JDS9Pc1Ou854yk+LMtLKgndoGcPop5byrbbFJnDd/Fp7w
         Ou7A==
X-Gm-Message-State: AOJu0YzbSGlDj4iPrX4NPjwxaQ5AUYkP2qc5jmgfX0KzFRtVrmbdFSx+
	mCgtW6Phw1xucwwAl6OFJMvq3/+4i2Fk+nOFypTVwnI8DcxY7398jZhBdVR9c14=
X-Gm-Gg: ASbGncuvHthRcjwSPOs+e/x/eUoZVsjOoObGc2AmxNDxCBu/b77rGHZ6efHGb/TRoPn
	nHntQpTpgFnM7KQVgX38zZzhoq99zXV4Uzy7izysvoDo2WYg3yMhPsLb+Ye4bWroFROkA1JvnHZ
	kwBJkm6nhS6ulNsk+BcP9f7Y09l5znLcTzNqTABB+Cl2B0wf+38K6sJt2JG/29kndhZV/ONawoG
	HT2i7bKEphKx3V5PAvpIvr8I1mT1Zayacxkh/8cNA6JwAmRVFLzV8VV4heQV/paR2Pdf60aVViu
	13TPRxJw0LpefDUnNz/jLvdoxDK3qIZRL+M/dLfDEamOO00e+64t03WPqnyXwsXGkLBtIJz5jeV
	tjIoa
X-Google-Smtp-Source: AGHT+IHVMeEHCPvnbe81adI9R9VIsgLbgmc8FJIIRnHJFfaVMElB/PN9M4K1iowdklqV8Hgk7Sq4yA==
X-Received: by 2002:a05:6000:2ac:b0:390:f400:2083 with SMTP id ffacd0b85a97d-39132b5bb58mr7115047f8f.0.1741532255475;
        Sun, 09 Mar 2025 07:57:35 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:35 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 05/13] dt-bindings: nvmem: qfprom: Add X1E80100 compatible
Date: Sun,  9 Mar 2025 14:56:55 +0000
Message-Id: <20250309145703.12974-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=zQ+XDU22w1KeN1u2R0sBn32K6zj/nRUuBnAFl5n+VVw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw5h90iMu8k4UWTZMM/77qH5t4+r/N3S94Id NPORNO+EZKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N3YIB/0Zd+VRU9ZvS45/uMJJEIOPGwGxPpUa033H4d+DaJ/tpYtFXY47ujcix26FO5+s735qfof isFvUhm2VWAjL24VVjhdXVPr5QLC9cwYhAvR3lLG/EwkYyfkefstcCYvBl/VSzQzT3qijhvjdR8 iD/LgzRQMFAlNi5QmY4uyuM1/CExL6HllalfKe3ZyvQTbZFplJiqsyN3IMANyaBt0ACf/C6S75I hdDpYnsi7anKyzov71lK3joEuUBe3kWxD0afs/t7SlQAjcxU1VY1I60KHr0amGt2cA8psReNTuw YmpkMr0spPDP64wArMUgvEvuE68Di4PrcAGM85f3FT/XkX30
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Akhil P Oommen <quic_akhilpo@quicinc.com>

Document compatible string for the QFPROM on X1E80100 platform.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index d37f544ab8aa..a85f817b015d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -50,6 +50,7 @@ properties:
           - qcom,sm8450-qfprom
           - qcom,sm8550-qfprom
           - qcom,sm8650-qfprom
+          - qcom,x1e80100-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1


