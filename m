Return-Path: <linux-kernel+bounces-553173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D657A58525
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9FF3ACEA3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF071DEFF4;
	Sun,  9 Mar 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAg+Zzij"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C61E0E00
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532261; cv=none; b=XIQYORqoJOwEABmv8AQ6frVX7yuWtEHg3nbssGwLvfN7REKdxlN+jz/d2Wub7r1ev8BO4MSstGlG4EkO86Gz9sh99INbFNcX7G45+KM/gFyZ+GwxY4fYPd3lHrCP3bvGy4zlHO6kJjN7fX/y4vknAJ44huVX4wxAqqLqR8onPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532261; c=relaxed/simple;
	bh=EY2S50CyISdq3nPrExweydCBhMumYyhAyAOp25X2rvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sm5MxHXqTwTre/kOHG9fFvIYHmoYoz7CPCQMtJWItbwGwbbYcv346gBkevN3pWdnfTXR30DBlSerrTOwnFA3iYFZ3e8X6RnJh7oj4n+zUHy6CAWw+c6ELZXcpKJwzOI3VgzuSiDAMiDsD/8wpFLdnozwJBMug/Jsl1b+jrkYFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IAg+Zzij; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1583230f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532257; x=1742137057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEnUjNuUqm5QapxreDthsg15VWD/vl1byEP9/xBmO2o=;
        b=IAg+ZzijTbJuXzyPCo5tqUbycUSU1SAH14w3BN3uQ4/WmZbtuQONlpn1iEXpLLUlzI
         e5xQpeHT3c+i8qo+1I1W3spjw1lmR8QxF75y41N5Vspb1+UMFB7xgtG+I0BDhYO5KIMA
         chxVBBYKYoyDhTNifC3DnmpJCwzf7y9AMyKli9pLQ+knmcS1L7ep420pfyJrSZdktUWz
         YNTNGw+0R452j9fU6gonRVwLrOo1MmGMFUdrlnacWIDBlvEOqTEEl714z20vF5SPFptg
         7I9BlJzEivmgp3+8WIX3OXtfBp91Tsg9rtxEcgOFzxrUDyE3jSqN+GZhWKMhDE7hY2Ur
         Mpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532257; x=1742137057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEnUjNuUqm5QapxreDthsg15VWD/vl1byEP9/xBmO2o=;
        b=Fj6Ja4i5WCIq3DCOsHBlWsiQWwt+8Mw1kquU1+/7Sm3N+w2Z5FeNdSKq6v97EBRhYo
         PrYvVAQ43upYIz817hBVRFvPrr3ZtGIz93Z0Cp7bXn+BpmHI7lxDm4mZZ7LM5TZxhPGE
         5dCTW4CdUMjsg6K4L72Tfupr9E4k1Scq1OEA+Z2CJFEVQk62o0a+ArsBWilfv5E+IRwg
         ZkBq1YC7PkprfxiZvcvTUu7glKGT4eRa3ioqbJ8X14t1vncyVwFTfnNvy2gyDpT1+tEV
         5nYvSvxz9dGXe9Lh85x90vY+zzNWX4S1IJFwcPRcA5RApv7mOzczpCDLFNBBztnDMkmK
         D59w==
X-Gm-Message-State: AOJu0YxIQ7vBz6M2Ylpg/CisjPtOp6DL1aywdus5AeN9vLJ4c2Vusvnq
	kLk79jfL7nlYGX1bOtc2zutTxwkvPbAKLhANwxQC2BN7joOG/aW7MU9hpFYnjZA=
X-Gm-Gg: ASbGncuguACjIITi4KfvMtsoC0zLAe4wgqZPnV0JVApwrbPd+KU/QGlvL91njw4+7df
	SOUrJwmhZ2htJ2O5m7ntbEByfNMSBZ1zSB6AJctOtGKDXZKiQvTzTQA4jHNqtJFD6OE2P1ODjlS
	xSptD2H+2YduahXtTFFMHf5bLZFzMolAK0Wd3jHT7mI+ufQEoCFixPzBqsW9jNM3Jbu3DDjomt7
	5+HTo8OzUPUwsVQxuIchruvdkHtgKfuH6bI3Fs0puPFX0gwoSZGYWTG9663w61esKhrSuW9iS8P
	hilCJrk4JH6k935LOzL4gfNZeVYwaN++xwkZuy87ct02BdKrcFm1oxVVUOnvTT7Un/sqAg==
X-Google-Smtp-Source: AGHT+IG5H7uiT6WwfEjNZkMpAUyGxKkkgPswkMmZvdBvlwh1c94wZxoFvGlWGX1usuAuBn1HhpGxRA==
X-Received: by 2002:a5d:6d82:0:b0:391:812:4e0d with SMTP id ffacd0b85a97d-3913aeefcdemr3346546f8f.10.1741532257651;
        Sun, 09 Mar 2025 07:57:37 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:35 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 06/13] dt-bindings: nvmem: Add compatible for MS8937
Date: Sun,  9 Mar 2025 14:56:56 +0000
Message-Id: <20250309145703.12974-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=6W6zcrnhaw2WbDgBvmsytJG9L01rOF4mMuUIqSbG5OA=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw5t9Or2Ry5G+ZoMbzoQF1DbMBw3+O647n5X asfTxAD27yJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N4clB/9rPH6bxeuipcvzCh9kJB/LPIX0qVFzO/ycab58wfvy2Tt8mMiMO0ejpSRYiwYIBf6m+aq CbdgfUlosvHX5PGYuQo3efdKo9DZGzlgQpJqJ7CpUOyeRREBhcQoGlZz6W+f2jWBGlWvzQyAnTG tstYBB03PuTPNnPR/8+PF5w4bXKxX0mUB/k4BZtmjJm4W7bISMMa1Pg6lSFmyHQhfTs4Wwe1fKp W51hJxNFZgeUCXFBQGZ7al6egd44r+lHQQ8Zrxh6kizPsGncZfk95PqCmOjpkf0THTm+OsI7Zdl jRbJW2s6z6vawOuFxkmxmHosjJmSbev8RHvDdNH0kaK5+AJE
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Barnabás Czémán <barnabas.czeman@mainlining.org>

Document the QFPROM block found on MSM8937.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index a85f817b015d..a9de635bf31e 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8917-qfprom
+          - qcom,msm8937-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom
-- 
2.25.1


