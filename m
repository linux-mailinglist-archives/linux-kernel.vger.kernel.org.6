Return-Path: <linux-kernel+bounces-437800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87049E98CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDC5281E0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEF1C5CA0;
	Mon,  9 Dec 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUiVqrU5"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5A1BEF73
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754493; cv=none; b=PTR8qceaL2wRokahbrjAcfRDsrFfgKTe8cFympcDKDqrT8fecq9ZMzW/mbiz2Vi3MAbPkvBr5OSsMu4fga6sHQuJ724IlDzHI40F3K+ctQyPbmzJTx93IlC7MIWsdwdEZGZYo1GE03FbH94cWKpJq0OFxGncOgrNJRSjIhWS0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754493; c=relaxed/simple;
	bh=+bL1C3+EqmoCZ+3NSkbD7ohn35NupzZbKWkMvdBYXvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubZr5pVXH5tH5ruySw30BfcIwRb1g3xqWOxES2/DFk4gEfArHWuiX2fowd6GGAxuiV+d6TMSWY9RPaqZFVvc91DhWGtxxMzPhBCO98QZMFTeQh1qwZdSHFDVYmX0a1TMSvFQZbQHlnfUt25BzSHV8/wtG6ABnr7gPyjcfsze5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUiVqrU5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68f1bso308155a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733754490; x=1734359290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGnb+IQjlD24kYzbmGgtXKwZCCe15sEsS5u15TpXOMs=;
        b=bUiVqrU5gcg/8WCYYP0oNHDZU/5gu71ixXr6JNkvi+p4fhIIzNl9Mr0u+utsvGw6DA
         EqR/KoP4kSe1h5alEBPbKoF6p6DxfVj0ChsAErMWH6nCj85k4Ozu3nYHYT8lNsXfxLlO
         Ja+lu7xKkWTY0rdxJPaaqxGyVZJlNX6WoAltjrME8+btX72qcC1D2g2BnXCIWihfZHc0
         lvhxorLnMi1GqDkzqiYcPCtgJV7MDDQ2AcZnlC81ii+zVPjtnW1PXT7rYLzZ/YX6RtS1
         banTNtauRWNYirQBAGtWgLwTmDKPjgepxx5hQ02NdH1qmRGXONuc+CMzHiCa2gjFb2Ww
         mp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754490; x=1734359290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGnb+IQjlD24kYzbmGgtXKwZCCe15sEsS5u15TpXOMs=;
        b=QJ8E92STHyTsmPi2GYD17t0Q12VImqvZsXUnHR+mj1D1Zd8tfV6igZpsgBniKp8hjj
         10efmGYcyWuB4fVi8Tbufjs1/sKRM1AxQKpoHvD8EJtzigkVXRVljO3VhykPz1v7uOMO
         SKAMYE8S8WM5nJPN3PjALhsWbEV8jxNyqDjmbcuiR3urMowgrNrr81xa6VFM6prZ9RS5
         UaqK1ZWHi/Czc7avIMiU5pyeR9ondVUTD0fwK1U3XbnHdJVHfjHoff2tp7EiBU7DExr0
         RetHaL95Tkra6+zwV7vQ8HQ1XyHEKqEdZXEz8jR/jW8Jh3fp8ZsB6IVTgAxpaYgiTxo3
         WX8A==
X-Forwarded-Encrypted: i=1; AJvYcCWx170LAxlW9xVePnMY7JODrrx7D3li+QTYo7mbwOOPOiMxa1EbNrwkDh24tXvdE9n9Py/WZlWTlB7pTIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwtB2JCNAgW8OWkIlsK1EKiE6WRE9sLl+0n942b5jftxn7vFPX
	WWJE3e7YDNjBLig4ctuPqsRcF1HrtEgcJ2WfCOuB+IGhssrBerh5LXjqIEFkfDs=
X-Gm-Gg: ASbGnctKHzOluHu6XeJsefTpqKysaaXsKarfrupiLhrcOJ4GAEadU08rxgCVh63prSV
	1BVUGpsPlwdnDDo0ab+57bEgwGk7b+AZBho//SsZTdoPI6Q0dkA14yyF6g61MeGnTfQ2shcTbF5
	k8pisCQh88iUnw01PJrhSRzWpTh2zln0EFA+JXqcT9EfPS1YfTqIg/FCwN6MdFX2XJHkyTAjsQy
	Z99oV9IQdRxa2koBnuaDI8vDBhugK0e9ZE1ylxfxHYlMbOFPNcC8ndIn2j1Zx04lw==
X-Google-Smtp-Source: AGHT+IHgFy5jwj3ZZsfJHP5oyOrDc5Q3gesJdagWrryrrmWchcTc/iUsAE5cQ2IUAPj3AnV8JRqIyg==
X-Received: by 2002:a05:6402:5106:b0:5cf:6635:858f with SMTP id 4fb4d7f45d1cf-5d3be6d6a3dmr4807719a12.3.1733754490094;
        Mon, 09 Dec 2024 06:28:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3eb109bc9sm2887141a12.42.2024.12.09.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:28:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 15:27:56 +0100
Subject: [PATCH v2 3/6] firmware: qcom: scm: Handle various probe ordering
 for qcom_scm_assign_mem()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-3-9061013c8d92@linaro.org>
References: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-0-9061013c8d92@linaro.org>
In-Reply-To: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-0-9061013c8d92@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVv5vnIllq8kxBhdiVODsdx6QNBhfih1LR0aj8
 VDXAx3dVzKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1b+bwAKCRDBN2bmhouD
 1znTD/0TcLa8dg9E1O5wu1+l5cUms9pve6al9nhGVpkYOhyLhPq9JcQWfzIpgXuz/Lo62Objr/r
 o1MygFPFO9/rb2mRDJL+TGbgbVwj9rGCsAayUHwZ42hScMdmCJ3POaoImDTZujfMJ/Ltddmka9I
 w7/79sQfl2GR2WKrHrg2iEL6sLS2P682FaQBQGYfftUwT+N+3IHaUoCJ7a1iR3L59gI5FsII7j4
 8qJC0BJB/RvHTTd9Dp+kpqya71zI1s2f/d5/NFgANUFclRgjJ0CEfPy7hZqOx//5X9AiD0b8zLn
 QElijFsE5TKRmGT/b7MRaU32VMgdE9T8ET4xk3KgieELnmN8L3ij4ZaqMX2vCAt/Awv+Gdh0sNT
 Pch1/EOIIP9ZT86pFeETnskutIFCdqLGgZ57dcX1CynZJdAi0YqrpQ70tQp2WNF10CQryvCynZp
 ifldt7g+9zTNY6rwkdl9yUXw7lUhQ7E2e4z5X7nYxE+zTVmBZdO7W2fsw6WWTnWNzAogZKlzwWx
 YoMG+RBvvtc+f/UulqSNpD0sGUajEUf6nvi/l99CTBEdXBCNBGnp6Klg3xGpysy5ehIEQ4Po13k
 mypwIBSLQAuVbmMso4x9qpGHyy94fC+LbUcq+bdig7t7ngR9LpAZNp36V0PcXr2utfmLWOB6pW/
 pYio2vbG8wn48qQ==
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


