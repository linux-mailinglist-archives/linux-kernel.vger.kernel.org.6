Return-Path: <linux-kernel+bounces-445642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0EB9F18D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CBC188EEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6191F7073;
	Fri, 13 Dec 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVDPdLht"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A01F6673
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128135; cv=none; b=WOwOEJZCNROEeyWkKXUNRmCTnmwzUwsNAFy/Y5QguTvQG77/7DsHL2oOSmUL0qR+xE1VnyiETy9OVQJ+yPvRC66+W/EYGoaiGwjH3UVqZ9OasbaRdvqkK1uTTx5uS3SOVmze4tO7DGzz4pU3bOKabfFdYeNy2g+4LgMC0APjtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128135; c=relaxed/simple;
	bh=no0sfKO/tylUOGei0YmNfycYpYlftUgIkxgk0z+dSYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYaCzNti6nDUHGYfqovk4nqyYcmqRSfrBKBsJlhJfqDd9RKmk5gjliVJmAMzf9CjGP/YNNU41d5z+hqwy3Xi2CT1tR02ox8GQ1Cwwhvuqqh8YhQfh3JXgVS7GkznBFMq5GnPeoYgtXzPHUvrUQa7T/QMXN/3QsxgJISv27uAnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GVDPdLht; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3001e7d41c5so22187281fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128132; x=1734732932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYiRea4EwjBuM/pDrnKzR7CxY6M8aLg13dPrT2rr+uw=;
        b=GVDPdLhth3fhfKHC7Z31je6yFAOdbsBnFEk5FkfrGjhDb6XONuepaS7ilv7/7C8ABc
         JqGSNH7AacEuLIR0l93D0a05UGAuLbdNQHoJIJw7infu1enyZgGyABmcbPOc9hbo+YLu
         1SXvx7N33fyGen16QUt9JNRDde1Oc/2Q0kR0wv0UwEEYrqa7aU2xxwq80DvD7nUNow/0
         6wJsivUh7UxSMe1eEv2Hvn/68P5C3L2Q7xsNOrdl4Rmdq8+RVMHT/G9Bf7BgFGA/9wDK
         8Dd5775YkqNj1LiSrc9nfJoS8B8mHSO9Xckw/0l4QYvEEMVVxs0ZBJwFbL1pm8cYEesW
         lccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128132; x=1734732932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYiRea4EwjBuM/pDrnKzR7CxY6M8aLg13dPrT2rr+uw=;
        b=LWJNvAmh4T7Din8ekOJp1NxMD9Eyu3DLnOdnpPD4wkHyncF1DoHFlCnxVSOu//oszV
         3PdFHwDfXsbvurNCLIctuQxCQwmbEMDsRO9SjrEhbyWMEDGBlDERrgL4owXG1jg5dSxG
         PkRAIpSyPEDFFKb+PQZNAlnP7hY5JepQ8TB0FlRmon7+BPggLh8n00uTVoY0+HAbWWMv
         79UCFODarTX4Vpc3RP3/3ZuwYKoNzRs9b9yZ3PBGTtXGPHWcO8xk85jxtPQxO+xhkId7
         cRKq3KMg74o5aA22fvJij0IiZVKT5FSu6fAErCVx5gXBtCYTIQ+r+dyK5k/rYT5Az8xA
         kT6g==
X-Forwarded-Encrypted: i=1; AJvYcCX0d74lORytcdILqvw+NX0tVox4k6njjYd0Iw27FARSO8H1rdzMCxkM6XW1rrWrbWrFPWhAqqDsG5nP3pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVAdQvbxWqnd6ZZsXqbSFpoR3ENdz/T7n8YKVgry63PjSU1Doo
	L2QzZVJbjkl+XNl9WKwJx9/vI4gH+HpBD2Ml139LZksKqo/xPKPtWYe+XzQ5AzY=
X-Gm-Gg: ASbGncv1IARpfsLYuEaxgEAtWixC6vwnErH82dsZexB5gidruxG8REsOviqGte1GPba
	KZ3enXzuHE8JYW7BynrRCuM0/sX8Gat+xGgiVUx/vqnISivypoebeKGhEPyyN2Ujhc1bijLb4kT
	xmyjVbgRN8kW84rzf/qA5/pvaHQMptPc6eEatAW9xraDD3GT/ncdJoxZPYNxQ7JiTLiJCcJNX81
	x3v57QF/H9IlqTWi8pVwQcEzknPs7izuY6IxRW8qh5cGJOGv+BbwTUyKIb83wTC
X-Google-Smtp-Source: AGHT+IHkFnwj0GDYRxTrti0RjvnXm2VfFagkgygcdKY+TFKK2Q8ADUGMLry8upg2ZGyUB8TbRM9yuA==
X-Received: by 2002:a05:651c:553:b0:300:32a3:a322 with SMTP id 38308e7fff4ca-302544ae84fmr16288621fa.32.1734128131749;
        Fri, 13 Dec 2024 14:15:31 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:40 +0200
Subject: [PATCH 24/35] drm/msm/dpu: get rid of DPU_DIM_LAYER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-24-988f0662cb7e@linaro.org>
References: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
In-Reply-To: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4760;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=no0sfKO/tylUOGei0YmNfycYpYlftUgIkxgk0z+dSYc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHHgsuXxj3B2BQiVlsVmWCsmgq1OouOBYftx
 JxPlOjFM8mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxxwAKCRCLPIo+Aiko
 1R9aCACxClRBR5KyoH/z5F91crL041ilJUSNt/WOYgnqyu+kyo8/mqnfkB7x1UdpbwMhl/7JyWE
 f/jNfXyA6vlrRt9XpRGuglMMsFyYXMUgnunKGhGKfHqln5Zsl5cnFV1vH4OQnxex9zHBTlmfTc0
 86MS9AcTwrN+d3T+8hswh+4W6MbXj64VDoT6CwG5mj9ca+Kbf8ZyeF2TxfWFevFt8TwmaRx1wOo
 WJ3unMOjguwqA7/SvcVv1IXLgS0v0cRJGHmRtwN/W1XBl+o6VT6T6iEd10ybPza+ze2M9rg/iWS
 HjODxmr2+5y+R3Wfc3KJzRTe+1DszXUBtmCa0TDXL1xbGzuh
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Continue migration to the MDSS-revision based checks and drop the
DPU_DIM_LAYER feature bit. It is currently unused, but can be replaed
with the core_major_ver >= 4 check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h  | 2 --
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h  | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h  | 1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c          | 5 +----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h          | 2 --
 6 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
index 63fdaad2f38aa8157098351fc051b64a6167e45a..24b46f570690332026cc71ba0f2548b56fafbb3e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
@@ -91,7 +91,6 @@ static const struct dpu_lm_cfg sm6125_lm[] = {
 	{
 		.name = "lm_0", .id = LM_0,
 		.base = 0x44000, .len = 0x320,
-		.features = MIXER_QCM2290_MASK,
 		.sblk = &sdm845_lm_sblk,
 		.pingpong = PINGPONG_0,
 		.dspp = DSPP_0,
@@ -99,7 +98,6 @@ static const struct dpu_lm_cfg sm6125_lm[] = {
 	}, {
 		.name = "lm_1", .id = LM_1,
 		.base = 0x45000, .len = 0x320,
-		.features = MIXER_QCM2290_MASK,
 		.sblk = &sdm845_lm_sblk,
 		.pingpong = PINGPONG_1,
 		.dspp = 0,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
index 842505ab5c4a6555e0a3223804065e68a5a4e680..155db203282f687e5632dcb042393951bb03876f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
@@ -57,7 +57,6 @@ static const struct dpu_lm_cfg sm6115_lm[] = {
 	{
 		.name = "lm_0", .id = LM_0,
 		.base = 0x44000, .len = 0x320,
-		.features = MIXER_QCM2290_MASK,
 		.sblk = &qcm2290_lm_sblk,
 		.pingpong = PINGPONG_0,
 		.dspp = DSPP_0,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
index 7087c3c2e728c51f070b67ab0f8039f74eb7da6c..708cf1544bd1d5c72a125b572e51d628c53f5033 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
@@ -57,7 +57,6 @@ static const struct dpu_lm_cfg qcm2290_lm[] = {
 	{
 		.name = "lm_0", .id = LM_0,
 		.base = 0x44000, .len = 0x320,
-		.features = MIXER_QCM2290_MASK,
 		.sblk = &qcm2290_lm_sblk,
 		.pingpong = PINGPONG_0,
 		.dspp = DSPP_0,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
index a2fdbe39e4415c1da1da0517db2284f368bfa07b..b5a3574e2ce43f7f5d47c42fe1bdd0f084396a9f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
@@ -58,7 +58,6 @@ static const struct dpu_lm_cfg sm6375_lm[] = {
 	{
 		.name = "lm_0", .id = LM_0,
 		.base = 0x44000, .len = 0x320,
-		.features = MIXER_QCM2290_MASK,
 		.sblk = &qcm2290_lm_sblk,
 		.lm_pair = 0,
 		.pingpong = PINGPONG_0,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 2107d0ed7f3606b3467796c298010651f6425b8d..976fbae56a4cb6ab01663ad0f92ee4d095e7ddef 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -90,10 +90,7 @@
 	(BIT(DPU_MIXER_SOURCESPLIT))
 
 #define MIXER_SDM845_MASK \
-	(BIT(DPU_MIXER_SOURCESPLIT) | BIT(DPU_DIM_LAYER))
-
-#define MIXER_QCM2290_MASK \
-	(BIT(DPU_DIM_LAYER))
+	(BIT(DPU_MIXER_SOURCESPLIT))
 
 #define WB_SDM845_MASK (BIT(DPU_WB_LINE_MODE) | \
 			 BIT(DPU_WB_UBWC) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 8b94ed395392a4ee43030e92d0b58baeb4d47dec..3947fbf7e7f4f5e0e3c0ccc263ed14c7b22bff8d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -84,14 +84,12 @@ enum {
  * @DPU_MIXER_LAYER           Layer mixer layer blend configuration,
  * @DPU_MIXER_SOURCESPLIT     Layer mixer supports source-split configuration
  * @DPU_MIXER_GC              Gamma correction block
- * @DPU_DIM_LAYER             Layer mixer supports dim layer
  * @DPU_MIXER_MAX             maximum value
  */
 enum {
 	DPU_MIXER_LAYER = 0x1,
 	DPU_MIXER_SOURCESPLIT,
 	DPU_MIXER_GC,
-	DPU_DIM_LAYER,
 	DPU_MIXER_MAX
 };
 

-- 
2.39.5


