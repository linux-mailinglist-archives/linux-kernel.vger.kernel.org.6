Return-Path: <linux-kernel+bounces-449397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3B29F4E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1440F188B361
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70421F75B0;
	Tue, 17 Dec 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVKOwMhA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A491F709A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447086; cv=none; b=cVyFeiP/toBjq2c+J6tu+a4s1IOahHdBqze0w4Qrrdc+P2/H/VONK2cCqGRR2PtS2b33XmhijpUzZKS/AP6SS5gcKd9Og8373wmOQBBBxUS4SsCNKaaft8B0kjGHGRemH4RUU1rrv7keyu7pVSBtL2H1Pa0DxnY3voEu+ppRlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447086; c=relaxed/simple;
	bh=uvbHEXTw+a2tX2idu+ViK6cwh2GKBsinSbc9Nbsj/3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8qU7jQYM/KicaIA8UTRpjKUlqwEkL9KNnWBRfcsT7QwMP4bB9XndgJyvuUkKy6r++03tPMyEVvZXyjSmZbvPyhTowFgspN05GBDB1/gvtdDNpccL0nfNsVRedv969xUTkk7T6IIRpC2UjB1tYMGPzoH4nKGUQEMZCM9IALmz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cVKOwMhA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4363ae65100so30517305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734447083; x=1735051883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GT6Ffu6NHkparOWH1yazIoGcxgWe1DmTQ9OnbymmN/0=;
        b=cVKOwMhAXNbPaNCOCSeXe08CCp8n7NawVefz32mSXtJnnJ+iFfpN8uMQiQzEc3ppao
         WnDcSJs+1YD8663zZS4bGCl+yBvfpvn0Y8BzQw4dVIT86nd4ZJbWRhlYMIuMZcGjo6bi
         hhHM2uCw5Z3xPSHw6TPJIh4TuDV8XqNxzzM+Vm4E2SrFJYzaIYCPOMVbSLzt7FrrAyWc
         zUl++h4YgNxc38ognlu1CX2fLaI0s8//ZCSiNQkX3rvsh9CW6jqDlPdeh6YYzd797GV9
         H97kWRlNAXuM7Vzhu18bxVDDAjYCQNtQo7QG6ksWRcr7hSfkmxUluEST1u9aBSDaJ47T
         jGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734447083; x=1735051883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GT6Ffu6NHkparOWH1yazIoGcxgWe1DmTQ9OnbymmN/0=;
        b=jh4AKQr6q8i6hyzuVHcxil+mBkaG7MkCMNVCOEgsXYzeeucJcrHaI63rSMvdn1PfW8
         gESrhuU7p3x9OgYf8HQfnesRsIyrXps6sDmjIA8PQG2W38+BWCOkBBTr3FwTLzxcpfzb
         vvw+tbs8eivrfXtxo1zPo+cfN7KU8EtfioufOvMQReey8O5UMuRxK5is2KnYO3GniXob
         9xzFq5WrY+IMjoNGaTziStUcRKsPsUZY99UPOl9k3XAbc59kqnC+/ZJqBAOAUfue5h/R
         HCDiiNCxMDeymKdAbJKbuLf5DhIAptli/CVvn87jix9nlsw0YZbIjmSNPPkTw0otF7kX
         y8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa3sTtBIVVP+b7byQ6AfgU9L6fXQID5iLcthk3hU8OcO59uTEVV0ZmMK7hdiylEERvseqcaKXhEzo+bNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA2Zy7OHKG3ty/ggd3On7UCfWmNMj9EntgI6HKUff2k2BfFH2d
	cYDDMH7uycmxutHc6vox6C7qGfnceIC+8TVdmfeY6yrqdsSgvAxDvWPuc3jcDC4=
X-Gm-Gg: ASbGncvB3b5ugOhrIEDRRrBKnIsRStigQPbSG1jlZl1JYqTCPfsnpqzRZ+VQK/IzP8d
	XjJbkA6eeYvptSszIZpIOLJq6gGtL6ooCTabMVGehta5AlVmKMeDmVxM+k4gCMtMZEdvejczMgo
	gft5qf2DJ7fbKHF90gcpLA5mplytBbQxsKFvreBplJVgyAv6ynCAgAOQ7ZCVhCJwi1e3CazIoxX
	bMd+XfY9WUKHOjY135cfLF6rO/d88R5LGCySHS54eQrCny9abHRX4BD0l+sSJU1v/bhWc9tIWGn
	tw==
X-Google-Smtp-Source: AGHT+IGjHbqNp8cDdsy6Oq2RFM1IUlLm39Klwx1ZEdjDhrhBRuiF6MponH/ZmYHPq50ykB3CjppPKw==
X-Received: by 2002:a05:600c:524c:b0:436:2238:97f6 with SMTP id 5b1f17b1804b1-4362aa1af5emr139392875e9.1.1734447082898;
        Tue, 17 Dec 2024 06:51:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43636066f51sm118417375e9.22.2024.12.17.06.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:51:22 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Dec 2024 15:51:14 +0100
Subject: [PATCH v6 1/7] drm/msm: adreno: add defines for gpu & gmu
 frequency table sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-topic-sm8x50-gpu-bw-vote-v6-1-1adaf97e7310@linaro.org>
References: <20241217-topic-sm8x50-gpu-bw-vote-v6-0-1adaf97e7310@linaro.org>
In-Reply-To: <20241217-topic-sm8x50-gpu-bw-vote-v6-0-1adaf97e7310@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uvbHEXTw+a2tX2idu+ViK6cwh2GKBsinSbc9Nbsj/3M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnYY/lMatVkt4Mbak1GnvvuBsBxUWPqGuUF+iBtsMV
 ZxctFHaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ2GP5QAKCRB33NvayMhJ0XNdD/
 wMDYuo87ZbvQDlNKrmg8m0TKTmuzm6Vi8bZ3YqXCP+JZa4822CmGwkEoCMpy2dn3nHL8bEwwWt3I06
 TlNlLLJmtgWNPSYCqRBBu0SPu3CWmVSQzBHvOEFva6zze1oehdzK7WZYM8PzIq6y/f2abdOqCSWlzs
 dkqMewThz50/CrE6YZmEtrCWxZYo+PA5/BrZgemHNkSpJjxA0mwkwyuHRyK3WHHC41mvEccAcOfMG/
 vzk2M1kTD8iTO1LvOT0ASuwue9nWylLizEoDA/fRH7z/5jMng3lrarbv5HBCeWYfb9NHmiFP//T/EB
 79ZH01G0JTHBG3RgVZ2JVpDGxnQFJJJE15nQ6/zsDMvvHwxKQ7kNvb32njY5tznZvKHauF0CkavYH6
 QIxL+7i+Fy717scnA++eGiLrQeb+uzRpeb0uz0ke63g59Ru5fIid4D5Rh9gT4DjrgxEQH6QNXdcmCQ
 HhCP73/ItzDMjYnX8GB6a7A3pvwSQIv8yYFURipLw4SU42X3AEdGOK5I5BL6V0z1SYKmu9hWa8BdOG
 ybYtYdHXJAcjRr54JiAtdZTy7m+KBqRuVROgNqyiFZT34WWUc7v+zO76YqwoCOgl4Ybg1+68scunp2
 lc6/bYCbilN3gEb+/YzdCp86qkRcYXyvP9JQIblzS6XmK/ZfZG6i6y9Xm44A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Even if the code uses ARRAY_SIZE() to fill those tables,
it's still a best practice to not use magic values for
tables in structs.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index b4a79f88ccf45cfe651c86d2a9da39541c5772b3..88f18ea6a38a08b5b171709e5020010947a5d347 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -19,6 +19,9 @@ struct a6xx_gmu_bo {
 	u64 iova;
 };
 
+#define GMU_MAX_GX_FREQS	16
+#define GMU_MAX_CX_FREQS	4
+
 /*
  * These define the different GMU wake up options - these define how both the
  * CPU and the GMU bring up the hardware
@@ -79,12 +82,12 @@ struct a6xx_gmu {
 	int current_perf_index;
 
 	int nr_gpu_freqs;
-	unsigned long gpu_freqs[16];
-	u32 gx_arc_votes[16];
+	unsigned long gpu_freqs[GMU_MAX_GX_FREQS];
+	u32 gx_arc_votes[GMU_MAX_GX_FREQS];
 
 	int nr_gmu_freqs;
-	unsigned long gmu_freqs[4];
-	u32 cx_arc_votes[4];
+	unsigned long gmu_freqs[GMU_MAX_CX_FREQS];
+	u32 cx_arc_votes[GMU_MAX_CX_FREQS];
 
 	unsigned long freq;
 

-- 
2.34.1


