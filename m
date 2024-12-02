Return-Path: <linux-kernel+bounces-427218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF20B9DFE45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0E280A76
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384F1FC7D0;
	Mon,  2 Dec 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MmHDxedt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4E1FDE28
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134016; cv=none; b=o35ThMDwOeyZijLYpCQK5TC4UnnmdVBAXPOBvbjEd3KUugxPyt/UwY85GPFOJmNMni5yyi8gVaWpXGsd1FtGGJyDl8aXulIKFwI6Q8XZphnIU8Z8QoRqXe6j0tSPdZ0v6GI/0EyF2bX8/H7fKDH+BrOPy4EaJZP/g+qRJi0BvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134016; c=relaxed/simple;
	bh=BHA6I1XwPBT7nD2YhJCKM9NSNn36jIN2pw04W7hxTUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLWh/6RTeCCKszoH3thTi4fZwQ5JUheYTWTZM72T3Xg/+tjmNNokAmPSzoTa8oythuDQ0iqwAuGxmgz2wMI7MIl0RjNOaHhqETUT36h2p4banpQwuFbertckXuva+UWhK0peCOQBW5Dtru9Ct6c6haBvPaCFHKfE+H/OLY9cS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MmHDxedt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de92be287so5624329e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733134013; x=1733738813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08p8JD14+c1Dtuoc1UVgr/yt4AmX7Hc+5DPlapkDHkM=;
        b=MmHDxedtguUm3o1cTrkJleDiY4IlcdOQvWm7V99KXHsP3EVDKPrC2tuKWA02RFCifv
         KtL0dxfC+v+9lvPhnOPvF9NDvw20RGFX+V1L+lXKNlkZg/wUhg0BtiYf89CtXxd9GNKn
         Vvb1sAlYxZV+7/S96iZLDAFIHvqK3oEF2jTUCpT72Tv6TdVUg9EyV67aVlK6BaPw4o1r
         tY6lbXKBWMWEhJIfjkil8eAHZblVL0Q0Z8rdSWMRkP4a69r0cHwgd9IfKivA8N9cAUVQ
         FrFNgCyX+mplKTraA+17ZxJtvMhb52qfYStUAhQBszrIumK1SpITAwQfDHX4KyS3Mnob
         IWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134013; x=1733738813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08p8JD14+c1Dtuoc1UVgr/yt4AmX7Hc+5DPlapkDHkM=;
        b=sZb81TO5TASYSWHh73OSsu0SWNGjt7eF2jKJIKzzNqV6XT9iM5i+UHyOHSMAudXbIN
         OoYkJpqHvfHUfCsaCrhNMF7NB+x9EykA6jCt87kEfDOBg5nn8OtW/VrAAOOQPwsIUDDS
         p5xf2l7op46beIhNKMKdwZN7kLJUVzT2OWbUlN2B6xAgy0jXpo1sz2nxnnSaN5m1yXM2
         BDcXI7XrNGz58dGfoMl107QZOiTuGSsI1Xcp6HxDFNdyLEfCi5LyUyEW/Uz29o+um4MA
         z3IE0csOt8NH+hYlv/cW6X6wEzB3k8lwY5xmTpI6s7xYnXRCqopzVOFt1C7VIKL8dXzB
         tzZA==
X-Forwarded-Encrypted: i=1; AJvYcCUtWOgPV6tArJaDevszcMSLu8xz058v0yaSLvCyH1qGWRBFxInRI+OJ4qUgLiKZR2kqDiSLekaSWdKq7Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPVB1dQzTT7u17Q2hGXdiad3s8FPG4pNQilC6YC5yIBFy0j7Y
	BlE0eLl2B3SslXBj/C2UnvWWsSuIM6/l1hhLsxLQfgpuedcdpfWNDg7ozIinLlQ=
X-Gm-Gg: ASbGnctUOyMk4aEXVAr3Vi/PWA+XC11zlL+Xtn8PQTv2b6fqOpQprYHUvxAsw5D0rd/
	s7kimFXJM7CXIV0/r1nNmtGPyYeDC1PBy4E+4KEFLRNNzq82thKjfk+1IpjThcFKQUxEtIdNFcu
	uc6dQffmdaC9y3w1Di7o6xhshOdu+Yd+HJziAR6rSDHrO6vsA/bQQCz0k2NtZXAJrJhXJjVkxQ8
	WzK0H87trQRqungrNYTFPeWv74ue+KpNHFAeqqWrMg/voelDhjgogxLNA==
X-Google-Smtp-Source: AGHT+IHILNDYLiYvUtfTvAkPGfAuV3kENocpi6uZFYznl3/janUl3sKxqNc/wIstHcHwZwQIX8HT2w==
X-Received: by 2002:a05:6512:3d86:b0:53d:a3a7:fe84 with SMTP id 2adb3069b0e04-53df00a96e8mr16969911e87.8.1733134012615;
        Mon, 02 Dec 2024 02:06:52 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f191sm1418314e87.136.2024.12.02.02.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:06:51 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 02 Dec 2024 12:06:35 +0200
Subject: [PATCH v2 05/14] drm/msm/dp: move I/O functions to global header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fd-dp-audio-fixup-v2-5-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5678;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=BHA6I1XwPBT7nD2YhJCKM9NSNn36jIN2pw04W7hxTUc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnTYatBw61SPcrQ03U+/jMhzcuiW7ZqoVK1bYw1
 xuvfFLA2DmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ02GrQAKCRCLPIo+Aiko
 1djpB/0XGEgU8e8GdO0l1XPGtDRZbyq2ZgP78lxAh8wDW69oG6+4jB1oCJOu52U4nF7mkGZgmVd
 ALOrVlj0atGKRAzOVqy8KNnVlnE7A/60El+q1zqehI5LZ1sZBn8eyZ5p3U6LgzQg229iL9nwgG3
 v+LEUDPwccWVVzdlHnj+mBA6VNUPfbBmMHTsJ6wU2pvWtEvtKtieIM4d1LrABOoLYu97Yw+dei+
 dAJZne/GnyRmJ+N6vpLDE9upzCgGGy+M8Zc33VG/ZHsUZiZqm14n1SBiosYJv/qSzQA9wpX+KCw
 Xmlv4XUyJe6I3Cu2nwQAMwUTdT98BajGSpWVCuiVC1hqInKp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move msm_dp_read()/msm_write_foo() functions to the dp_catalog.h,
allowing other modules to access the data directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 65 ------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h | 66 +++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index f02427dc08eb00e1b6a1b2e026a6bf5015c4b46e..bd9d875ca7a66aba7875085b977e75c55ba91578 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -78,71 +78,6 @@ void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_d
 	msm_disp_snapshot_add_block(disp_state, msm_dp_catalog->p0_len, msm_dp_catalog->p0_base, "dp_p0");
 }
 
-static inline u32 msm_dp_read_aux(struct msm_dp_catalog *msm_dp_catalog, u32 offset)
-{
-	return readl_relaxed(msm_dp_catalog->aux_base + offset);
-}
-
-static inline void msm_dp_write_aux(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset, u32 data)
-{
-	/*
-	 * To make sure aux reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	writel(data, msm_dp_catalog->aux_base + offset);
-}
-
-static inline u32 msm_dp_read_ahb(const struct msm_dp_catalog *msm_dp_catalog, u32 offset)
-{
-	return readl_relaxed(msm_dp_catalog->ahb_base + offset);
-}
-
-static inline void msm_dp_write_ahb(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset, u32 data)
-{
-	/*
-	 * To make sure phy reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	writel(data, msm_dp_catalog->ahb_base + offset);
-}
-
-static inline void msm_dp_write_p0(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset, u32 data)
-{
-	/*
-	 * To make sure interface reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	writel(data, msm_dp_catalog->p0_base + offset);
-}
-
-static inline u32 msm_dp_read_p0(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset)
-{
-	/*
-	 * To make sure interface reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	return readl_relaxed(msm_dp_catalog->p0_base + offset);
-}
-
-static inline u32 msm_dp_read_link(struct msm_dp_catalog *msm_dp_catalog, u32 offset)
-{
-	return readl_relaxed(msm_dp_catalog->link_base + offset);
-}
-
-static inline void msm_dp_write_link(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset, u32 data)
-{
-	/*
-	 * To make sure link reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	writel(data, msm_dp_catalog->link_base + offset);
-}
-
 /* aux related catalog functions */
 u32 msm_dp_catalog_aux_read_data(struct msm_dp_catalog *msm_dp_catalog)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 13486c9c8703748e69e846be681951368df0a29e..2c500dc0898edfe1d6bdac2eedf3c1b78056cf6b 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -63,6 +63,72 @@ struct msm_dp_catalog {
 	size_t p0_len;
 };
 
+/* IO */
+static inline u32 msm_dp_read_aux(struct msm_dp_catalog *msm_dp_catalog, u32 offset)
+{
+	return readl_relaxed(msm_dp_catalog->aux_base + offset);
+}
+
+static inline void msm_dp_write_aux(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset, u32 data)
+{
+	/*
+	 * To make sure aux reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	writel(data, msm_dp_catalog->aux_base + offset);
+}
+
+static inline u32 msm_dp_read_ahb(const struct msm_dp_catalog *msm_dp_catalog, u32 offset)
+{
+	return readl_relaxed(msm_dp_catalog->ahb_base + offset);
+}
+
+static inline void msm_dp_write_ahb(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset, u32 data)
+{
+	/*
+	 * To make sure phy reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	writel(data, msm_dp_catalog->ahb_base + offset);
+}
+
+static inline void msm_dp_write_p0(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset, u32 data)
+{
+	/*
+	 * To make sure interface reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	writel(data, msm_dp_catalog->p0_base + offset);
+}
+
+static inline u32 msm_dp_read_p0(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset)
+{
+	/*
+	 * To make sure interface reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	return readl_relaxed(msm_dp_catalog->p0_base + offset);
+}
+
+static inline u32 msm_dp_read_link(struct msm_dp_catalog *msm_dp_catalog, u32 offset)
+{
+	return readl_relaxed(msm_dp_catalog->link_base + offset);
+}
+
+static inline void msm_dp_write_link(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset, u32 data)
+{
+	/*
+	 * To make sure link reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	writel(data, msm_dp_catalog->link_base + offset);
+}
+
 /* Debug module */
 void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_disp_state *disp_state);
 

-- 
2.39.5


