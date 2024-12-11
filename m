Return-Path: <linux-kernel+bounces-442376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C39EDC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35D91889E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CD1F869C;
	Wed, 11 Dec 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCzndxe0"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474431F63E0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960519; cv=none; b=fry8FNcys94BFqFXUkjXM88KiVwZnzGjysNsk+8IolZYmVD+7NMKCgU2gnl47Xv8zA1TIVBXsnz7TRZgihSuiIk7nSuye0rFZ8aCIDnOCWdSDC7qpM8tw1i+ZD6nrkQ0VCKSebHouR+J3o2JJI8WifnWbCmjuE6tDv7eS1I+RZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960519; c=relaxed/simple;
	bh=FVES12zsEtXLuC6xJIos7OOXAkyUs36V3qwdQ7KOf4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMzER4sstLWtYN4UMlPrL5NZNWHjrcC+L9k8oPJHPeV1UbM4MaAsy3p5F3dsSMQsTOCl8+V4Bhu04tET7efln2SsNIvar/pvzZgtF/SQHRORrYoKzFinV0UNz1H+8Lh7LfoEZU5XEf3D1buLiE08IL5NS748TJ4YnZp5GQEk7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WCzndxe0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401c52000dso3575e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733960515; x=1734565315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+0oWOHvpCFQk9kwPId3uMAsxICA55PC09FLWk/2MSQ=;
        b=WCzndxe0GqojfLMCauRLEgdXQIE7tWMzy1V+Jv5H7d9waFM/3sqzZPLucZQSPKTUgS
         FdZBC4m43v73ZLtyOXKbai97Q7K+ocQcD7OTv1DM/Iq78VUbcaoA8qyuhjxISMyv0BAA
         kTbJtnzm3go86c2GOs5ujVgleCaKavgHfskhCWkc3wg4BU8Ze+GpzKHVqVAcbVDlV2cf
         AkNjuCEZ8IsyXZpuGu9qodEL2qWqRjeWXlnayHXSUfWLqQPcUzmhXg1fJt8E/Kro/Yf3
         XySZVu0RHabvqgb3QwR+t2d780ex01r3vLZsjLfHTI6X14t796azivxhr5YdeIeKjz3x
         61/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960515; x=1734565315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+0oWOHvpCFQk9kwPId3uMAsxICA55PC09FLWk/2MSQ=;
        b=tZra+SXDonlvxARPxFwdo+a3rrusb7eylavuOTiHeAmmAmKaAzGmqSSZYShiNvtB2M
         wTnpPEuXzn8FnGOjTwiEEgX7lNqESqF5IBrZzMfA4l8UohPwhNUp37VHBRLOsEC3y3sD
         TR7hOePDeYxdR48hndXQLTjt68fMyOxC6wwR78cHzLy3bu/sg3j2EBjWIwuqGURKle4w
         tuasEAShloIaOwuuDb1OgVU46Feie1uaQJ6RDeWbPe6NPcpVvBtQImROLxbqlX5Lezo7
         t1VqAKbObLXmTuuQg1w2bmJX6UZJ6uSVBi7PgEIpYDyA6l7Zn6KR0cp6PAWEkDvPW/bS
         wlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCValZ9AStHQ8SVb2B6i7dbgTjf25Rw6Q0o6fmZ4lroZgTlVZz5At5BxJU6XJXp2wDbLSU8RofRQxX8dKc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSq9F/8Azxdqzx856gQN0Q7UeD1Y05ce2/9dIzIn/bJKSyzcJ
	ZyNAEURUwDEepMnwXu2hhvO2zkd/i7AguFqlD0MisyxgVK9LgEfv50JHh+ap5Lo=
X-Gm-Gg: ASbGncsJK+Q1tvOOWbxxzS4nBZWtEzu877T5xtwKD+c3cJHV6sRfAZWDOQ3vNfOAXL1
	7qi33Azj3BaWIXW5aVXI0x1zzKcGiyQET+7iFDoFsVTWwwtKwHaXxIM0Eps4TodaszcLcKvmJ5s
	R2gT1lTY2k1jZnhAAAbZOrdswTUFQNavUTGsqpNUI7DKbAHS9LC7RTTq+l3PUQLduZjYAUzFTae
	bff/ZcfDFJaeZKPI3Dqa8CT4TUu8A/ElsjqUw22gF6QDmFpV0cd7HSLvk/Yxg==
X-Google-Smtp-Source: AGHT+IGrZeWmmO/IV0DqjFEM05Da+kuQ3jbU7GsJzicVYzn+08EtfA7Mt9CNqojY6VnOlEIXauQu0g==
X-Received: by 2002:a05:6512:e86:b0:540:1d58:da7d with SMTP id 2adb3069b0e04-5402f04cf43mr407667e87.53.1733960515383;
        Wed, 11 Dec 2024 15:41:55 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401cc76909sm1222207e87.58.2024.12.11.15.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:41:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 12 Dec 2024 01:41:38 +0200
Subject: [PATCH v3 03/14] drm/msm/dp: drop msm_dp_panel_dump_regs() and
 msm_dp_catalog_dump_regs()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-fd-dp-audio-fixup-v3-3-0b1c65e7dba3@linaro.org>
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
In-Reply-To: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4615;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=FVES12zsEtXLuC6xJIos7OOXAkyUs36V3qwdQ7KOf4M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWiM3OqXSBoZIQNL87XVEdEM2hVVVhYq/3wp2p
 hU6BN0VlB6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1ojNwAKCRCLPIo+Aiko
 1X4uB/4+fJmgL1PY3+NpmwLJ7bradwADla6mL4Vx5Ixqw/2mGWXQPCP+Go+qgmUtmt08hue2jeN
 brqyl3hVGbAVIXF7uS1N0B40kF5k/8Ar3RcAQkZEG/0Z1yInkcsk3rhtxhzrVJK5W/wlPQxfbHG
 GdboDsLAwBgPXzHFtVtX1MSEK0ff0u+1KB7b0+63CzISuDsspCMsH601+W0ld2oquQBQ3IaNwpr
 fQ7dOc9aekIffC20I9/Nj98yOzwz0IvfUDK3sM5uDWSvGtHLft4QdcFyFl2b8LDTRPIqtkq+0gt
 AFFuC5dw9CLuCKaV1reI+kjUrT2/AXh7jeUjXCTthLVW1uHN
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The msm_dp_panel_dump_regs() and msm_dp_catalog_dump_regs() are not
called anywhere. If there is a necessity to dump registers, the
snapshotting should be used instead. Drop these two functions.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 37 -------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  1 -
 drivers/gpu/drm/msm/dp/dp_panel.c   | 11 -----------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  1 -
 4 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index b4c8856fb25d01dd1b30c5ec33ce821aafa9551d..0357dec1acd5773f25707e7ebdfca4b1d2b1bb4e 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -276,43 +276,6 @@ int msm_dp_catalog_aux_wait_for_hpd_connect_state(struct msm_dp_catalog *msm_dp_
 				min(wait_us, 2000), wait_us);
 }
 
-static void dump_regs(void __iomem *base, int len)
-{
-	int i;
-	u32 x0, x4, x8, xc;
-	u32 addr_off = 0;
-
-	len = DIV_ROUND_UP(len, 16);
-	for (i = 0; i < len; i++) {
-		x0 = readl_relaxed(base + addr_off);
-		x4 = readl_relaxed(base + addr_off + 0x04);
-		x8 = readl_relaxed(base + addr_off + 0x08);
-		xc = readl_relaxed(base + addr_off + 0x0c);
-
-		pr_info("%08x: %08x %08x %08x %08x", addr_off, x0, x4, x8, xc);
-		addr_off += 16;
-	}
-}
-
-void msm_dp_catalog_dump_regs(struct msm_dp_catalog *msm_dp_catalog)
-{
-	struct msm_dp_catalog_private *catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-	struct dss_io_data *io = &catalog->io;
-
-	pr_info("AHB regs\n");
-	dump_regs(io->ahb.base, io->ahb.len);
-
-	pr_info("AUXCLK regs\n");
-	dump_regs(io->aux.base, io->aux.len);
-
-	pr_info("LCLK regs\n");
-	dump_regs(io->link.base, io->link.len);
-
-	pr_info("P0CLK regs\n");
-	dump_regs(io->p0.base, io->p0.len);
-}
-
 u32 msm_dp_catalog_aux_get_irq(struct msm_dp_catalog *msm_dp_catalog)
 {
 	struct msm_dp_catalog_private *catalog = container_of(msm_dp_catalog,
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index e932b17eecbf514070cd8cd0b98ca0fefbe81ab7..62a401d8f75a6af06445a42af657d65e3fe542c5 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -104,7 +104,6 @@ int msm_dp_catalog_panel_timing_cfg(struct msm_dp_catalog *msm_dp_catalog, u32 t
 				u32 sync_start, u32 width_blanking, u32 msm_dp_active);
 void msm_dp_catalog_panel_enable_vsc_sdp(struct msm_dp_catalog *msm_dp_catalog, struct dp_sdp *vsc_sdp);
 void msm_dp_catalog_panel_disable_vsc_sdp(struct msm_dp_catalog *msm_dp_catalog);
-void msm_dp_catalog_dump_regs(struct msm_dp_catalog *msm_dp_catalog);
 void msm_dp_catalog_panel_tpg_enable(struct msm_dp_catalog *msm_dp_catalog,
 				struct drm_display_mode *drm_mode);
 void msm_dp_catalog_panel_tpg_disable(struct msm_dp_catalog *msm_dp_catalog);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 5d7eaa31bf3176566f40f01ff636bee64e81c64f..7d122496723a32fd591d094269397a9fdd51fe44 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -317,17 +317,6 @@ static int msm_dp_panel_setup_vsc_sdp_yuv_420(struct msm_dp_panel *msm_dp_panel)
 	return 0;
 }
 
-void msm_dp_panel_dump_regs(struct msm_dp_panel *msm_dp_panel)
-{
-	struct msm_dp_catalog *catalog;
-	struct msm_dp_panel_private *panel;
-
-	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
-	catalog = panel->catalog;
-
-	msm_dp_catalog_dump_regs(catalog);
-}
-
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel)
 {
 	u32 data, total_ver, total_hor;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 0e944db3adf2f187f313664fe80cf540ec7a19f2..47c1d349be470b60596b64a7bc8c7c39d2e8fdd1 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -55,7 +55,6 @@ struct msm_dp_panel {
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_deinit(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel);
-void msm_dp_panel_dump_regs(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
 		struct drm_connector *connector);
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel, u32 mode_max_bpp,

-- 
2.39.5


