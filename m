Return-Path: <linux-kernel+bounces-414845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998A79D2E12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A63328155A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91EE1DD0E7;
	Tue, 19 Nov 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7gJwu+o"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974201DC185
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041228; cv=none; b=iv9RMnGSuVLj/EPe975ulp0T2GALmJcd/+dTTrQrt4UNbm20jEYptZlsczP1bNn2bEhZHR6r2yVHntLsGLQZfCmnpcnAiQbI8Eq1DOcRady/jXLcU6oluKKpbQb1oCkqK+ac3PqRGiCJgiFQA4qszCgYhSssuTEOW3LZYIDv51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041228; c=relaxed/simple;
	bh=5TLlUUFMlxVBRA9LfgfySqW4/f430JBLZVgZXAnTFfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sx6ek9WYbYb2I3uOMlPHMlZ8k1P1u2pQtDgI6/q6D3JQ0ngkjBI9YGu7uVTNCg9xfVNK8wAPpbahMwvUHW/cJY58fYYsIvKwwLVX3lPKEBmvWk/akOEfDOXaIuZOiGYryoRHsY8iwJJObY+G5gY+wnpEKsIDm1p7IJ2ZsAIDRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7gJwu+o; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43160c5bad8so3483945e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732041225; x=1732646025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krw1ZM4+VGT72qR1TvdXm8jH8NeT3h/uE5f54vAoMeM=;
        b=g7gJwu+oKeRSGGE9X8TsprElghS+LoJyAlDHbfOytpT9fu2YTbcx5qhAPBkJwju73W
         pFTd5JGLq/C+1BLrDL0FqMQ7gL4qzzIeoMhAmDgcN5kaBlu/tJIiY5aldOYxYMu7YyYi
         lxh2aFnCmDDKMTUzitGT0/zDV7Mj/mrctaFd4/onG8tr3/CwiZt3N+PCxZuItaFgZ0Fz
         33s0kYvw72W3s1+0703gi2rmY/tmWqMM1nEOkYrLjPqxQ8UYc+BXWpeyO6cO/WJdvjQb
         u+uli13+BjzTm2tXwE5rz8axfNnuOxUaJ5kpQzg23w8wAOhChji9reKRdDDFokKTp0DN
         oJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041225; x=1732646025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krw1ZM4+VGT72qR1TvdXm8jH8NeT3h/uE5f54vAoMeM=;
        b=DOwhDKjd4IXXY7iRA4DHn/ES/QrO7s7/AvFeESjh3+yRcfcv2VlYvtdcKxOGTOt+aZ
         ew6+gHXJFnrdaloXL9KNm7V/eCNqVKrbM1GfWQiSw+uMaFsCZaNjlKm2TDSerQpYfkus
         wz9sMLuhxoXJph5ROrcTANrh6QKMVmejEfF+9xhT09v4YuC1RBUad24l0a8+BN2jc8KV
         dvTINAozOvu0hvy502m2o8VyoqsgRxedR2BCDPoncSIiUpOmVA06GLfY3s00sVfxpIEc
         aKm3iH7AdJOvOAVlhTZVVnGwPLHcL6ttJQmUVTjZXRCWzj9HJN762RiHmCSfIIkyMUA7
         zGgg==
X-Forwarded-Encrypted: i=1; AJvYcCX7KsImFYEmaGooL1zuoAc+HdlUINqidAO+GAeKbGD7toC9h0LPb6WwDy2Ntjq0MmBSX2yyxi6QcDFYCH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ffn2Q/8F/nMkTS8mnN9NQFZ8D6/JLrDFwi3Ck38wwXa7HoQe
	8lAaWV7Djwu3og4EMJB1xEOlzX/mr2rph6rPHscHWUvBLKEVilsCE7LDqDW7Yu4=
X-Gm-Gg: ASbGncso+UivZ0oNkzYmdPEGyV6uJj7qD94q2gBJSfvTR+Qn6OPUGUsDU5U14XRcioF
	G99aDUTHDt/6s98pDYlDxCVSvPSuh/Sgl0gtG/Gkot0tthyA1Kgmu4OUuWfhOOG0odJ1QRxWz8d
	u+v4UOSTB/QhYCqHMvCYAj/K5jMDYGLWXmC2U++rRsENUs9PAxxD2hx7Ru9kJNdL4XTPuQDle/n
	XpPqFtRWY7pUOQgmztCMq7r4e7GP5XcyyZPCW2011yhsGKABXpMgTi5/Z9TjumCIA==
X-Google-Smtp-Source: AGHT+IFKsT1DiSbpf5PXE5z3Wd3P4fsh4a8OVSAGjFSsPxYJz3NDmkZpyljk4ipR8meIpqAZqRhrBw==
X-Received: by 2002:a05:600c:1c1f:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-432df790752mr64864275e9.7.1732041224946;
        Tue, 19 Nov 2024 10:33:44 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fb7asm201566805e9.42.2024.11.19.10.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:33:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Nov 2024 19:33:21 +0100
Subject: [PATCH 5/6] firmware: qcom: scm: smc: Handle missing SCM device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-5-7056127007a7@linaro.org>
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Kuldeep Singh <quic_kuldsing@quicinc.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, 
 Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=985;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5TLlUUFMlxVBRA9LfgfySqW4/f430JBLZVgZXAnTFfw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnPNn7FzUgjn+Cac29NIvPhw3hxDzi8lbQQrhEq
 VIrozZ5IZmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZzzZ+wAKCRDBN2bmhouD
 1+pTD/9arhmbhIWwWWeIpDWqvzkFts1PjFJXdAfWSCfH3WDvOMhlhUTREATysuQnrP+DCg1E5rE
 jn1Ul1wQYfrMk44pXbDOozHS/vIer8FLRpaIMNYBYG/jsrgefeIBenN6PyMh1zfe9edb5GqdVNa
 G61OkT1aFhQEpR3gK0RFDNKcM8P1tU/pPs2f1WpBaM4GkVe0YDdvHE9TRritxqkoWHpKKiBDm7t
 pq96rTJp9h6KbUVAQ+GwMBhGaCiVtMzcaaV1ddAEy+H1kOae05s1QL4718gvvHQ/sxEpATbgLUF
 gCVXLlAPNKi+MserPmxE2e9t8wnSCqe3CXUE+Cy/jCRABUVBJQmsc+XQ9rXw4PXhVJ5ujm+ffmP
 JfLI359OrWOQCC8l6x05UPbaaLjvt36/4oY2X3o5ric8W/Jtwo4gyQx7LguyogZVh/LjT7wyE6q
 iLWifBHS7WhuLTVf3JQm/K86y/QCNMo9jA3v/dDpFogN2NFyUwVbhgiFVuTW/ky/VSnj3CM40dN
 5amoX9FOtnsYuPkaoTfhREg1eMiWKiGdLxvorAPAx1n6BhPN9soE9/FBaum1wKtQxOrsIy/XsWx
 hEpbnVwIm41Do1fgmED9deO87p63GL08bcH5KPVRbaXFvliGXNh+Jt9qWZogi3tSEtZX1TLX2tH
 mzq2FHLKiPof37Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit ca61d6836e6f ("firmware: qcom: scm: fix a NULL-pointer
dereference") makes it explicit that qcom_scm_get_tzmem_pool() can
return NULL, therefore its users should handle this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm-smc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 2b4c2826f57251f25a1bc37c3b467dde28e1268b..3f10b23ec941b558e1d91761011776bb5c9d11b5 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -173,6 +173,9 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		smc.args[i + SCM_SMC_FIRST_REG_IDX] = desc->args[i];
 
 	if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
+		if (!mempool)
+			return -EINVAL;
+
 		args_virt = qcom_tzmem_alloc(mempool,
 					     SCM_SMC_N_EXT_ARGS * sizeof(u64),
 					     flag);

-- 
2.43.0


