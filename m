Return-Path: <linux-kernel+bounces-433493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED359E5940
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDFF1692B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D8222580;
	Thu,  5 Dec 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRL6svp7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E34221476
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410890; cv=none; b=WgOkEpbNXkKvdIy7f1m4oiRtxqbTaRFxGkVxd1/CjYv3Q0zKjZOGLMBaXz9JTORQQaxMe6Lws8NRc049kFnjRU5zuxVmDlJ3GhWroDH+AC1jueIvFwNZL0N+wrcAaTVI/9fhYP629KH70nRUeMAFEyKQzTSF1XavjexPRvBqFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410890; c=relaxed/simple;
	bh=uvbHEXTw+a2tX2idu+ViK6cwh2GKBsinSbc9Nbsj/3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4Ldshmv8EIRAQsPNYrTYsKqtSGNRI7XPlQ/MaeWCmCWza6Ty8z0VpOrbb+w4pNfE46cCk9/gBtqQon+b+bMWqxNqznGNEf2kRhXrdLoOiDOnPc9tv3JElURTuZaS5Wcbaw7/xtV9Db2hU4I5Uk0GS26P4XnFney07J5N2U4CDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fRL6svp7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434aabd688fso6998835e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733410887; x=1734015687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GT6Ffu6NHkparOWH1yazIoGcxgWe1DmTQ9OnbymmN/0=;
        b=fRL6svp7oLHlRdN7F3a4hz13D8Sabf7ef2j1VxG4YBcF0ZhYSTBLOroG0ZPIjvActO
         SZX93YIzwg2//GDqU+d1V3FgrmrBWseHiIb8rIvbc/l4dZOUQXar3s5AIAqdqnKs2Rru
         DZ2OoxnuzJumOa+sAXWhVHSNiiHD01Zho6QYGzVKJ50cxsvhYPPMKNa1dIZ6LppuXMTm
         vvh5/apebx8rNd0NAdcq6wFvnFCXyvw1Ig2JG80/hFqTjypJJdWRznhdBeUiH8zzCgza
         Dnt7RIp6pguFfrxbirfQ/2i7MKwsCaQR2OFrhlSPcibndPbJc4dNKY4wcpDsIELy2BKd
         h5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410887; x=1734015687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GT6Ffu6NHkparOWH1yazIoGcxgWe1DmTQ9OnbymmN/0=;
        b=g6dd28ZO0TLeKh5+MypSIx4bYKdEIw1o6wFkMCHR2sEsZrgna2FH2C52EUrkdEVLoM
         d1erlB++BbEXFu3ne9YYwuAD4pgbDPsBbF2zHqsA5eYJcsIasacstr9+y+qHsiPFY8Ck
         DQO5WJTH1s354ugHOB+5L7R6/KcSOlUvCT7JdgxgewpyiyvzozIIsGBgWSX8xa1nUmVi
         fHBMZN+2UBg9JhfnkJTM0b7XuGE3+cnqy/FiNAOlCFoIX7GvHlJsBVQIMowlMDxvMqQ1
         U0xBXynnOvPWgHYoMwJn2Eq9LH0++HhNWluvm8u/Uh3USXAwCP49C37bYLWp5oky3ZWs
         VbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNqEnoLFpyst8vqE7uDRbGkj7uDK2mjtI1KHNY+cj7ZArVYhK1GRT9HsrawdNGZ9X8WPjD8eUx+jy95Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kEINXwzI5MQv1L6wYutpwe6aH8Qt+WyY4/uSC3F1zv4eQBm5
	UedY8OkI8fXAWdn3gXLx4Y44N7L8FSlfr1s776BBVjckJOffr2EDpNd877C4RpM=
X-Gm-Gg: ASbGncuotXJMEnbMrAYOsUfy0yioHZ84EXxyo2C7iDk9EaDH89UpWG1No9KjwXyIrev
	wv+XN4hhVSV1k7oS9AhaHJ8mXWelxON+MADW/KS0cCkLmEK8T39CqNFxWkUaZXlCe4caaXrJjsg
	itvvDwWfAuV2+yicBtJw/MUmWp+BchItgKfPiTeL25dM180pVjE2hRPkuFWCv0hTKejbiWWBD2q
	AXrAPs5RlEvfpKGVBHocAY19+9bsprtpzvi9c65BRyyLpH3hovLjqbuel1Dk2XrydPG82M=
X-Google-Smtp-Source: AGHT+IEN4o+Oox5ANVYMM6enY3uS/sHjTMeJBzvAdOgxkjHoFq8gCfsd5ag0i0sigeASyixlcr1XHQ==
X-Received: by 2002:a05:600c:1906:b0:434:942c:1466 with SMTP id 5b1f17b1804b1-434d3fe3665mr70571545e9.29.1733410877656;
        Thu, 05 Dec 2024 07:01:17 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm62830795e9.35.2024.12.05.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:01:17 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 05 Dec 2024 16:01:05 +0100
Subject: [PATCH v4 1/7] drm/msm: adreno: add defines for gpu & gmu
 frequency table sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-topic-sm8x50-gpu-bw-vote-v4-1-9650d15dd435@linaro.org>
References: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
In-Reply-To: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUcA3bFRWVZyYroAh7BnbdOr16taWEJgG0OfOdkw1
 q8cOaJOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1HANwAKCRB33NvayMhJ0R9oD/
 4uwOe9t4JiQcOr7JaHYVYqTinY/nVh3yjQKUgRsMDCw/y7ZR2XV1LV9N09Rq9DZSgt/II+yiXkuRAT
 bjxT/brdEgeEjTkEcQItDtvySc51oJEYdeq1kCFqb+1XnhbEbNYg2DsZWy/KM0sV4vFOwt+1VdrckQ
 5+Yh0UR3w1PS8cpD+2WfcMEH8fc3vjJL4HaZJuF+SbKLzLnhExUAYu/sCDEPAG3iaZCy1Tmztf0Zxa
 nvph5tRyDl4oXzeIjvnFadXR9r9Z3xjcu/qy/kANOFC9k22biOavrz8tM0QSCb/Q8lIR7WqomYsV0+
 Jyi+jYMSlTJCeM/4JoUa9x02PN+FrgtY/YvTt5G5NVhIejgBbYNvBJD049qD+86etVuoYjJkP5IDR1
 WKZ5yatzqi+8mdu5oQefSQp6KXDE3z8szzKgr/0XxzAAz5YLhlOPSfLsOnF6tVYOGlX6MvySsaHFry
 HCOmlUYgOFhvl1ntM8Vjqk8wHNdD9wE5vWYHn2jGDcAcHBX9UOzaC1jMfuNWJr6SxuPY0uwA/3M1pv
 /dvujdKWYPgd2FAd9A8bgW4EMFRWYgs3cPHLxW2pk+P+4trvAYXIvhoePzUHFIPiXY53O8DAuEbZ4z
 hxA38RK663xNZEgIT/rRW5WEpljwbsmHMXkOtAkeDeipXVw8b5WjamtYsOWg==
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


