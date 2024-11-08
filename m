Return-Path: <linux-kernel+bounces-400839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584AB9C131B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40CD1F23103
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B23D0A4;
	Fri,  8 Nov 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUzUdfWT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5E2770C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025315; cv=none; b=BMPdsvBrZazX4XFWz9LpxI6xm6tsLjXBTf9NoM4OpTWz0X983wfWZjZbuo8dNmJGbpfbXsr8UWWWiM72Rqi+bOJlx0NLVRgfQ35RxLkU88s/XRm4X3mplpi/JNmPgdpmife979dRCdUBPt20m1rvAG0bDaVM8umyt3pyq+vVPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025315; c=relaxed/simple;
	bh=tnEeIrByurbE7rTzcskKZuqjBOLJnljywD+1OL2NWBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYTIwFCjD3HP0KyOFmLxkw+BQC/Fn04bbJ735fsnle6B++wkestkdRqFfFWbdQYSlQcmBosfPpqdKc219T9O+3whp3ndeOnCMn0LYhzNWwr8kfJ1P44iZWPJZ+rTCA4Tvzq78VS1KpYhiY7MpFNdrUU/b+p4c2uLAAdQmGtRGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUzUdfWT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fc968b3545so15404451fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731025312; x=1731630112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqTmYkI1sTYF3qb4f0/yZ60dAOKRHc0Ytx57Zzv01ak=;
        b=yUzUdfWTl59Giu1w+TZcNV/IrnLFtwz2XaLQGbvAl2GkTTf2dEGvsvATNxQ6lzy8If
         6Rq2hfchSdRP3EcXVx77nCGKi7d27ZdsUE8mCYomGJmELRftEqxTDCRExv3Ye3NMVReQ
         CGXWmEs/bIDL5xxhOlYuS1iopHhj/Y/oRjsz5jKWr9mWItBr0FCtPxbjWZeU9zimHQnR
         naslbIdojM18Cftgp2lrbLI/dJWah02pSx6ZKqsSud3zCHnVjnjSz9REBXmrlr5GV1ar
         KAw/WPDb1gQwxYUCub3o9Q+1kXLmhdY8i3umleoclDq6JUZnKEivEGkLHtoQq9XIBKed
         bgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025312; x=1731630112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqTmYkI1sTYF3qb4f0/yZ60dAOKRHc0Ytx57Zzv01ak=;
        b=esvnI23PmDSjvmVyJcFw53SWQ2BO2r3P3I50lHWdIFSPKwCmfffK4PAegzvMK4HpJB
         JnGWChg4rkbQAOwE1Mhj9RQUzyrB3UswwqazQKghre4hIcho9t81S3TBbm2FHSBJltn9
         LsQeVE1bSggLsr447PO/bkCJuGPd3JBHQxibsayuStEDvIVWr8cfY7PN6RVam9CjYU66
         IKtrjxGXv7/JR3W/43iwAkVgXaeJBI4YoEcuTZwl0u0AMMaonAPobBoGJ8PWBdUYzFZa
         eK9S7kGWUPUBI3m6s0Y6oUw1Nk22MOoOE9LNjY5o6xlwfto6gzpVSH1MisRsKRmo00Ru
         q98Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjNFqg4+0xXk8PP/t4YGjA9iGFtqRgAtMiLbeGP0AOENAfhdxqaatOmTtuUTnV7lsvTPSY4zKCtw6brYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGfK/HTkj7Jc9zR0rLVxyocPh0aRv3m1qG9X6B3SOYFqHcm4p
	ETAolQQIGsxe82o4ZU+ur38ge3rZB4bF2uYwuLldmeAEeHQd1o+UTI6qsP7KpAo=
X-Google-Smtp-Source: AGHT+IFB3EtcuwSPXXvmrgYqcgPpMCEm7lQHTJceygQenOEGhO5aTkUQzo7cPBTWOwghLKXmByPdtw==
X-Received: by 2002:a05:651c:1512:b0:2fb:382e:4120 with SMTP id 38308e7fff4ca-2ff2027179cmr3948591fa.38.1731025311803;
        Thu, 07 Nov 2024 16:21:51 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17900a63sm4195191fa.47.2024.11.07.16.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:21:50 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 08 Nov 2024 02:21:36 +0200
Subject: [PATCH 05/14] drm/msm/dp: move I/O functions to global header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-fd-dp-audio-fixup-v1-5-40c8eeb60cf5@linaro.org>
References: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
In-Reply-To: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
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
 bh=tnEeIrByurbE7rTzcskKZuqjBOLJnljywD+1OL2NWBk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnLVmPPIrBWCFun0FcX9KyCze1YM7zEISmrTGr9
 dW/f+yzSbyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy1ZjwAKCRCLPIo+Aiko
 1egpCACgI95kC95g/HFjhz0RngHTkYApUNtYnbpwdJH5CtIQ8/YUZD1RlXX49flEX3PmRoeJUC3
 YO8qFg2+3jROdG7ygfBhMhPeXwvIIFFrrwjZlQhNzWNZeps4vAwM/utgNmglDC9Vif1+t5i6tzo
 0w4jNFkqTr1EMNuDm3velteWAn9zHdqgN+zl8I9Hm1Mp8uekC8LU+NRIse1SjscMqP+uclzylNf
 nyakI28pKS1bPD0r6LmU8gOR+uEQ+/veyfXwp9f1Oia84da65TBN8CfecwT7LcxZnFnoVMvVc5R
 Znuy8PLxDS9+0t+6HuuMupJAHONEm4KkUGUQNGfzHrS8dc2q
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
index a8193581eaaaed9234a061283577af068ada0ad6..24bd9167fc2a8a5ff749a1f84e2eb76347ed8590 100644
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
index af54f8850a88f86e3c998cf6b5d1bdb93d42ba94..42ae8dae68bd0639172350e5aef0c522c1b02f6f 100644
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


