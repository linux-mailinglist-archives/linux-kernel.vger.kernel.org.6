Return-Path: <linux-kernel+bounces-414843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03DA9D2E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DF9282E73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0A1DB943;
	Tue, 19 Nov 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JC0Q/ApN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20BC1DA2F6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041224; cv=none; b=H6Tjb3Xc04Ugm2PZa+Nnebl6k5L1R0tr3ez6phPyE+L4roS/TP2VpewhnKAc7o9/wJUH17akSpXdPqR1IQjGL5sLDaN+RsDb9dVJ8iMolXI7oYDW7tTVZdoGYsW7YmQiItHVaC7fqN0Kn5q+MJhbHqcLfLRfll97OUhlzO13X1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041224; c=relaxed/simple;
	bh=+bL1C3+EqmoCZ+3NSkbD7ohn35NupzZbKWkMvdBYXvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRlmnjVBXayfo610wklNzCe5ukdnjyZqHVANrfKINPEW0TR4xBYnm6iIEVjyFj2CL9RmQFwzL2c6C4U/PBNfNb1fKKddTCvfd8q4i7fqKUsVAlCxSrFgM6dJcHAK/73mPAH1V1Lk6qet8c0+nF7iV7bBOM/sUFBMp+wlaaIcS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JC0Q/ApN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315549c4d5so6484655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732041221; x=1732646021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGnb+IQjlD24kYzbmGgtXKwZCCe15sEsS5u15TpXOMs=;
        b=JC0Q/ApN22DQsN+3oTrGlyNHU0EAx4msDSF02+v9Jb6jVV2mgieCatZLClgUfyxWfe
         SLCgp+nQ3ZjCg5tF3x8cSaadoFNQ++e5mK3r0KcPlnt8vmaVgVhaKawVbTwCOiubWjNr
         0YgtPViQ7ReTZyvGsw2UiPfPxaYaDxHPO51axUyvQ1LOLQyJ+opC70Ex9dHU610wLCTy
         oaYURX2Wx8gQjHNgXp0oF6bE37XyDy9YC50sxoZbeDdUicvJl1kmNvPuK6wRsVNBBiOG
         E33VDKJ1ZPlAHTwVK4cByIxKRncueJ9uiYnPLF3k/bBdTmUpH/N6XhCbLGL36Rfywwoe
         t3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041221; x=1732646021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGnb+IQjlD24kYzbmGgtXKwZCCe15sEsS5u15TpXOMs=;
        b=wKwqQrmkQKin+rCPMxb/viOg/QcLv3Q260PVfjlnbE8jzkddmeOVPN657F9aySZEET
         KZLNPzdYlkKZ3IMRD3EJre1JQQonKdq2hD+QU+3SDNJPL0HlFHI0VcgPxf0V5XxJ9JGz
         dV14eLEl505kZl9UF/U5aZ1wIKz6sqcqJIFZnNsogreyIYlzVCs5NZx19syYgr0KQnW2
         dJGa+NZELVWWw3ih3CA2FlVlZ/F1GBrWUrwcbUXcgVHxpXkdUJUftudyrd2yH26J6a9g
         FoqBi/ercdfjdZicLNnxaeYXLckocTAibMhyusfG27t5NXu/NLbbmSwcCVwNXzzw28Vv
         4THg==
X-Forwarded-Encrypted: i=1; AJvYcCWWT6GzLYlaVASZeoM4OI01FqARYpqZelm0F/ScrRdXPerAsK6nhxnED6QupIgN1zhV/lqPaNT3HQi6Z3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG2wtaFWUCYNsJC5aqU88x7qZ9008W2OBBrfbpC/kExQX6qYj
	U6ZhXCqod8ar0glAa1Eit6d3612Vqc1lmg6zArrP5RjYOj7U0ERHLZd9c7peqxg=
X-Gm-Gg: ASbGncuwsBdth2KGFJX6RCOIEvOR09O61NpexLrxyHfPa8gKROVixC8w8zIszDK1mFk
	0AjyuXnPJj7BJnPNV03A2lSbJFKVbzMXaIYNljmWEPuZFOK0NWx6QUH66mZ5qmBfxyMPwFa5CD9
	RRtw1Cg8R6h0FgytVT6JlxO5MbCMkGsHFcNcY4psBHA4wScn7dk2UOWglYjBw+enRvOamz6PvIk
	NMaV8ExUmymVN3xRqh1lDzCnkHDCAbYqNabK9Zr/jZIfj95zr6T21P0z7aKH0bEPw==
X-Google-Smtp-Source: AGHT+IGtUZSr+Po8pT92Az3nSWJsdQ3lxZTWxCYIy8qH3YtEpQSI3RE4JoZ1bMQ4vin5aZBryWJtKw==
X-Received: by 2002:a05:600c:35c5:b0:42c:b870:c52e with SMTP id 5b1f17b1804b1-4334897bd44mr45295e9.1.1732041221063;
        Tue, 19 Nov 2024 10:33:41 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fb7asm201566805e9.42.2024.11.19.10.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:33:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Nov 2024 19:33:19 +0100
Subject: [PATCH 3/6] firmware: qcom: scm: Handle various probe ordering for
 qcom_scm_assign_mem()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-3-7056127007a7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+bL1C3+EqmoCZ+3NSkbD7ohn35NupzZbKWkMvdBYXvo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnPNn6EH2hX35h9/DIDDrz2vClXDMpzR34zRb+m
 ebWhGXML26JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZzzZ+gAKCRDBN2bmhouD
 15dXD/9sXw6qRxns/scm+8XBhzKT60H5knj3tAC1YBrpipYl1oA9Z21+F2kXwEKSQqQ8i9gXWE/
 S46aOEU+x6znQ/G/PrjaDSk+auNX4Doqx/JH7v+03p1Tdin+An8PbRxtRGovYaDcBkYoASS44GQ
 Ls4365qeh/9EuCmkXis3RMiVri4GGvlX/9vC87xpqXA4ojJruDH8YaKPwkZOKomXOkT1/H2qABK
 lRkIEpa34xsSj16wvyX5SmFB81A4UU3RG4Ine4fXlmv6L6b0VMgWr0ZH5ifaevWrD7GHqY2tVjb
 LlleDaOeS3dM1hmwag1P9xuI/9UafbXLPui9naXLjrFNkdjX/eS2wK7f4Myg9wpLe4Xfwxdj/BT
 xwFkArEX25hpRjNuZOhTPJHqVXJqs6mKEWbSdvn3M/xTRn9thw9hoaZhnJFBH49lItJhTP8uvwg
 3ZeW2fP9Otbq01aFxTJ/hyFgVQHMe2nHyXD1moqMZElJZQGta7eqXOIkgUkiX0/SAY30pw1fnkd
 906Nc95t/z/w2fcl8EbjsVr24+XTJ/ErghsoTrlFA0r1pFvRAzciF2klRNIRSTkXrJiNEwk2Brm
 dcRu/vPfDudHoDBDwp2OYN5mMdViT2Dii/EsRKQzu/RZv+kzthQwiFtq/fiQzB0hQNblOqi9osZ
 2YdGJpSsC9sL42g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The SCM driver can defer or fail probe, or just load a bit later so
callers of qcom_scm_assign_mem() should defer if the device is not ready.

This fixes theoretical NULL pointer exception, triggered via introducing
probe deferral in SCM driver with call trace:

  qcom_tzmem_alloc+0x70/0x1ac (P)
  qcom_tzmem_alloc+0x64/0x1ac (L)
  qcom_scm_assign_mem+0x78/0x194
  qcom_rmtfs_mem_probe+0x2d4/0x38c
  platform_probe+0x68/0xc8

Fixes: d82bd359972a ("firmware: scm: Add new SCM call API for switching memory ownership")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I am not sure about commit introducing it (Fixes tag) thus not Cc-ing
stable.
---
 drivers/firmware/qcom/qcom_scm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 5d91b8e22844608f35432f1ba9c08d477d4ff762..93212c8f20ad65ecc44804b00f4b93e3eaaf8d95 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1075,6 +1075,9 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	int ret, i, b;
 	u64 srcvm_bits = *srcvm;
 
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
 	src_sz = hweight64(srcvm_bits) * sizeof(*src);
 	mem_to_map_sz = sizeof(*mem_to_map);
 	dest_sz = dest_cnt * sizeof(*destvm);

-- 
2.43.0


