Return-Path: <linux-kernel+bounces-400840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78569C131E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5846C1F230A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEB7B3E1;
	Fri,  8 Nov 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hp4fm1G0"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDC288D1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025318; cv=none; b=TM6Y0EMWV6A1caJfpM9HI2pzzvKi6Xlg3uu6dIVFeEDzb+aGXVc7jYiXS58nctCi/iJHcDoGnl06yboJczU+K0PZ9PnxPuBdcaOZuy518u9PFDz/hJbdrtwc1bdlKXAn7dWe5wH/qNxVSdJYKJSD5+e3Ra6LfuQxELU/eKzm+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025318; c=relaxed/simple;
	bh=jW0lUdSfq875NJ3uU8R2QI2Fx6RJrk2Ntmeqk7pyzpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2QmO55KxlAZZNbTV17KelnDalVvuF/e+abz45Havw0MTm2tyX8IXTmiPn46/UT3hN6XA9oInTGOp7ZnaoaT3G6Mtc2yz6payRCe56Jn2rFnAM/aGKwpoup78VGKeYbj4sYEm50SsmEAvOJEZ+doOAZjnmoJa5WFi2Q1BsUWHn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hp4fm1G0; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5111747cso16047191fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731025314; x=1731630114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnvtCeiXUrEQM3KCig1Z6Z7tAL8VgbCKy+vpvmN5vCg=;
        b=Hp4fm1G0+DLZ5hFHNnYKiUD2clcy00hWamnHJhxt3iGXyMvu/NCduHwT7yh+mA64bP
         sIcCVhQSVk3V3+PYuGvKRcSVJ621g7LXgHPAdHWnKlZPsrle97uk8L9T7Eib6BwUpNq6
         MC1o2bjR8gXm1ceQLX8a76BKGxiM8QppjLY+3Muiobd1F8FDrR/ULGKpwbCXwZCSwpfZ
         5LT3nC8DfiXdPvo/Te8RoU1oYHqXsc7y/zWa6Bl/BvWNYEdAhToSHg11U3R0IDoA2cnq
         1ZsynzXeSh8Kd6FhHMDykJRsxj7vyi1Fug9rB8S5DIpKdacrgNO4T4PbfG6ImwakBCIE
         IDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025314; x=1731630114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnvtCeiXUrEQM3KCig1Z6Z7tAL8VgbCKy+vpvmN5vCg=;
        b=gTgy2V7FVW8r77mrxhT9aAgQgOkgqed3Wad1hZujOiBdQyDNauKiOsoV/4jcM8l+3R
         fzxyPUAiTvhwvghQ6BudHhei2Lo33/8sy9qwHeBiNCala+FCgtL6Y+o8R9jVy5CjeIiy
         jZDzB8vKB5b+4gRBg2/KD/yrRaUSF6StdOgGjwqLtvsk/re5NYEjiHgqE8HXrYgC38s+
         4p1ElNlONjWMnz1smgE0tiL+CHrY1j613UGpyNV2iL9LUs4QARtp/3CDqINuU06ZNHPo
         ONNG4JAW+co1fDb86OM18SeBQuJKZ+mpnBjHVdMAeh8qdQZ+fPZcL+/cwEpfawNgyQ8r
         CrgA==
X-Forwarded-Encrypted: i=1; AJvYcCWAwRUSB3bG5+4oefWIOvJV+04jHpBao3zXUNUqqItSgF4pqS/9nNjbULZHnEhUIfdRVdm5AuCSVYpSKnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkiYxCXerPwtfZrZ21qM57TgVxt11bmWCeUPr/2bLXuUaWprB
	LZ4WEDnoV3tcCdex5qNT9kLQliXegkmpMAhEhnfmYqRkw7c6Mf5AhP67QfitKa4=
X-Google-Smtp-Source: AGHT+IFOu2rq+IO6Fd2pkjlZdKu2xCMr18HMvNQ5wSd90EdPQk/D3aoRrsf2C/YBW3RSezhHfHJwvA==
X-Received: by 2002:a05:651c:1550:b0:2fb:955e:5c17 with SMTP id 38308e7fff4ca-2ff2031a72cmr4020481fa.40.1731025314418;
        Thu, 07 Nov 2024 16:21:54 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17900a63sm4195191fa.47.2024.11.07.16.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:21:53 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 08 Nov 2024 02:21:37 +0200
Subject: [PATCH 06/14] drm/msm/dp: move/inline AUX register functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-fd-dp-audio-fixup-v1-6-40c8eeb60cf5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11775;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=jW0lUdSfq875NJ3uU8R2QI2Fx6RJrk2Ntmeqk7pyzpQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnLVmPGks2/Obhcluk6XqtlvW+z9TkOoeOGAkbQ
 u5f7qKKEzWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy1ZjwAKCRCLPIo+Aiko
 1f85CACtEVDjAns0NNsCj8n7/o6iTQXuS/0vZ0nPJXGrcB7EdyrM1t5qXXHp5phmtkZ27xdG99k
 z1p7lv/9JGZFs5GCxpQLzwL9iQH7QlZRqPBBFJvvo629OqpRDKXfTPEr6MA+feOe8xFYvvTtUp6
 Yu3VCNlHOqDd6PE4vG+YzKCr5L63vyo9fnDPxXZ1wQ8By3hyBQUrdEYaOL+PIA+uV6rBdl++aQy
 ZO3zEgJZg1EqM5RCXWfcXv2pxEGaqaKFTKTvus6un9RiTKmM3VdGEjIHIzDrQSmzPhPjsje7hWi
 mhdlWndFlFemUu8SFfBU7dATBRT/8llkBCBysdWaTEx6QjfX
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move all register-level functions to dp_aux.c, inlining one line
wrappers during this process.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_aux.c     | 98 +++++++++++++++++++++++++++++++------
 drivers/gpu/drm/msm/dp/dp_catalog.c | 96 ------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  9 ----
 3 files changed, 84 insertions(+), 119 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index bc8d46abfc619d669dce339477d58fb0c464a3ea..46e8a2e13ac1d1249fbad9b50a6d64c52d51cf38 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/phy/phy.h>
 #include <drm/drm_print.h>
 
@@ -45,6 +46,73 @@ struct msm_dp_aux_private {
 	struct drm_dp_aux msm_dp_aux;
 };
 
+static int msm_dp_aux_clear_hw_interrupts(struct msm_dp_aux_private *aux)
+{
+	struct msm_dp_catalog *msm_dp_catalog = aux->catalog;
+
+	msm_dp_read_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_STATUS);
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0x1f);
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0x9f);
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0);
+
+	return 0;
+}
+
+/*
+ * NOTE: resetting AUX controller will also clear any pending HPD related interrupts
+ */
+static void msm_dp_aux_reset(struct msm_dp_aux_private *aux)
+{
+	struct msm_dp_catalog *msm_dp_catalog = aux->catalog;
+	u32 aux_ctrl;
+
+	aux_ctrl = msm_dp_read_aux(msm_dp_catalog, REG_DP_AUX_CTRL);
+
+	aux_ctrl |= DP_AUX_CTRL_RESET;
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_CTRL, aux_ctrl);
+	usleep_range(1000, 1100); /* h/w recommended delay */
+
+	aux_ctrl &= ~DP_AUX_CTRL_RESET;
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_CTRL, aux_ctrl);
+}
+
+static void msm_dp_aux_enable(struct msm_dp_aux_private *aux)
+{
+	struct msm_dp_catalog *msm_dp_catalog = aux->catalog;
+	u32 aux_ctrl;
+
+	aux_ctrl = msm_dp_read_aux(msm_dp_catalog, REG_DP_AUX_CTRL);
+
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_TIMEOUT_COUNT, 0xffff);
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_LIMITS, 0xffff);
+
+	aux_ctrl |= DP_AUX_CTRL_ENABLE;
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_CTRL, aux_ctrl);
+}
+
+static void msm_dp_aux_disable(struct msm_dp_aux_private *aux)
+{
+	struct msm_dp_catalog *msm_dp_catalog = aux->catalog;
+	u32 aux_ctrl;
+
+	aux_ctrl = msm_dp_read_aux(msm_dp_catalog, REG_DP_AUX_CTRL);
+	aux_ctrl &= ~DP_AUX_CTRL_ENABLE;
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_CTRL, aux_ctrl);
+}
+
+static int msm_dp_aux_wait_for_hpd_connect_state(struct msm_dp_aux_private *aux,
+					     unsigned long wait_us)
+{
+	struct msm_dp_catalog *msm_dp_catalog = aux->catalog;
+	u32 state;
+
+	/* poll for hpd connected status every 2ms and timeout after wait_us */
+	return readl_poll_timeout(msm_dp_catalog->aux_base +
+				  REG_DP_DP_HPD_INT_STATUS,
+				  state, state & DP_DP_HPD_STATE_STATUS_CONNECTED,
+				  min(wait_us, 2000), wait_us);
+}
+
 #define MAX_AUX_RETRIES			5
 
 static ssize_t msm_dp_aux_write(struct msm_dp_aux_private *aux,
@@ -88,11 +156,11 @@ static ssize_t msm_dp_aux_write(struct msm_dp_aux_private *aux,
 		/* index = 0, write */
 		if (i == 0)
 			reg |= DP_AUX_DATA_INDEX_WRITE;
-		msm_dp_catalog_aux_write_data(aux->catalog, reg);
+		msm_dp_write_aux(aux->catalog, REG_DP_AUX_DATA, reg);
 	}
 
-	msm_dp_catalog_aux_clear_trans(aux->catalog, false);
-	msm_dp_catalog_aux_clear_hw_interrupts(aux->catalog);
+	msm_dp_write_aux(aux->catalog, REG_DP_AUX_TRANS_CTRL, 0);
+	msm_dp_aux_clear_hw_interrupts(aux);
 
 	reg = 0; /* Transaction number == 1 */
 	if (!aux->native) { /* i2c */
@@ -106,7 +174,7 @@ static ssize_t msm_dp_aux_write(struct msm_dp_aux_private *aux,
 	}
 
 	reg |= DP_AUX_TRANS_CTRL_GO;
-	msm_dp_catalog_aux_write_trans(aux->catalog, reg);
+	msm_dp_write_aux(aux->catalog, REG_DP_AUX_TRANS_CTRL, reg);
 
 	return len;
 }
@@ -139,20 +207,22 @@ static ssize_t msm_dp_aux_cmd_fifo_rx(struct msm_dp_aux_private *aux,
 	u32 i, actual_i;
 	u32 len = msg->size;
 
-	msm_dp_catalog_aux_clear_trans(aux->catalog, true);
+	data = msm_dp_read_aux(aux->catalog, REG_DP_AUX_TRANS_CTRL);
+	data &= ~DP_AUX_TRANS_CTRL_GO;
+	msm_dp_write_aux(aux->catalog, REG_DP_AUX_TRANS_CTRL, data);
 
 	data = DP_AUX_DATA_INDEX_WRITE; /* INDEX_WRITE */
 	data |= DP_AUX_DATA_READ;  /* read */
 
-	msm_dp_catalog_aux_write_data(aux->catalog, data);
+	msm_dp_write_aux(aux->catalog, REG_DP_AUX_DATA, data);
 
 	dp = msg->buffer;
 
 	/* discard first byte */
-	data = msm_dp_catalog_aux_read_data(aux->catalog);
+	data = msm_dp_read_aux(aux->catalog, REG_DP_AUX_DATA);
 
 	for (i = 0; i < len; i++) {
-		data = msm_dp_catalog_aux_read_data(aux->catalog);
+		data = msm_dp_read_aux(aux->catalog, REG_DP_AUX_DATA);
 		*dp++ = (u8)((data >> DP_AUX_DATA_OFFSET) & 0xff);
 
 		actual_i = (data >> DP_AUX_DATA_INDEX_OFFSET) & 0xFF;
@@ -336,7 +406,7 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux *msm_dp_aux,
 		}
 		/* reset aux if link is in connected state */
 		if (msm_dp_catalog_link_is_connected(aux->catalog))
-			msm_dp_catalog_aux_reset(aux->catalog);
+			msm_dp_aux_reset(aux);
 	} else {
 		aux->retry_cnt = 0;
 		switch (aux->aux_error_num) {
@@ -403,7 +473,7 @@ irqreturn_t msm_dp_aux_isr(struct drm_dp_aux *msm_dp_aux)
 
 	if (isr & DP_INTR_AUX_ERROR) {
 		aux->aux_error_num = DP_AUX_ERR_PHY;
-		msm_dp_catalog_aux_clear_hw_interrupts(aux->catalog);
+		msm_dp_aux_clear_hw_interrupts(aux);
 	} else if (isr & DP_INTR_NACK_DEFER) {
 		aux->aux_error_num = DP_AUX_ERR_NACK_DEFER;
 	} else if (isr & DP_INTR_WRONG_ADDR) {
@@ -444,7 +514,7 @@ void msm_dp_aux_reconfig(struct drm_dp_aux *msm_dp_aux)
 	aux = container_of(msm_dp_aux, struct msm_dp_aux_private, msm_dp_aux);
 
 	phy_calibrate(aux->phy);
-	msm_dp_catalog_aux_reset(aux->catalog);
+	msm_dp_aux_reset(aux);
 }
 
 void msm_dp_aux_init(struct drm_dp_aux *msm_dp_aux)
@@ -460,7 +530,7 @@ void msm_dp_aux_init(struct drm_dp_aux *msm_dp_aux)
 
 	mutex_lock(&aux->mutex);
 
-	msm_dp_catalog_aux_enable(aux->catalog, true);
+	msm_dp_aux_enable(aux);
 	aux->retry_cnt = 0;
 	aux->initted = true;
 
@@ -476,7 +546,7 @@ void msm_dp_aux_deinit(struct drm_dp_aux *msm_dp_aux)
 	mutex_lock(&aux->mutex);
 
 	aux->initted = false;
-	msm_dp_catalog_aux_enable(aux->catalog, false);
+	msm_dp_aux_disable(aux);
 
 	mutex_unlock(&aux->mutex);
 }
@@ -517,7 +587,7 @@ static int msm_dp_wait_hpd_asserted(struct drm_dp_aux *msm_dp_aux,
 	if (ret)
 		return ret;
 
-	ret = msm_dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog, wait_us);
+	ret = msm_dp_aux_wait_for_hpd_connect_state(aux, wait_us);
 	pm_runtime_put_sync(aux->dev);
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 24bd9167fc2a8a5ff749a1f84e2eb76347ed8590..bed2c26f883e92319721ed8bd672eb395cbf0544 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -78,102 +78,6 @@ void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_d
 	msm_disp_snapshot_add_block(disp_state, msm_dp_catalog->p0_len, msm_dp_catalog->p0_base, "dp_p0");
 }
 
-/* aux related catalog functions */
-u32 msm_dp_catalog_aux_read_data(struct msm_dp_catalog *msm_dp_catalog)
-{
-	return msm_dp_read_aux(msm_dp_catalog, REG_DP_AUX_DATA);
-}
-
-int msm_dp_catalog_aux_write_data(struct msm_dp_catalog *msm_dp_catalog, u32 data)
-{
-	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_DATA, data);
-	return 0;
-}
-
-int msm_dp_catalog_aux_write_trans(struct msm_dp_catalog *msm_dp_catalog, u32 data)
-{
-	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_TRANS_CTRL, data);
-	return 0;
-}
-
-int msm_dp_catalog_aux_clear_trans(struct msm_dp_catalog *msm_dp_catalog, bool read)
-{
-	u32 data;
-
-	if (read) {
-		data = msm_dp_read_aux(msm_dp_catalog, REG_DP_AUX_TRANS_CTRL);
-		data &= ~DP_AUX_TRANS_CTRL_GO;
-		msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_TRANS_CTRL, data);
-	} else {
-		msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_TRANS_CTRL, 0);
-	}
-	return 0;
-}
-
-int msm_dp_catalog_aux_clear_hw_interrupts(struct msm_dp_catalog *msm_dp_catalog)
-{
-	msm_dp_read_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_STATUS);
-	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0x1f);
-	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0x9f);
-	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0);
-	return 0;
-}
-
-/**
- * msm_dp_catalog_aux_reset() - reset AUX controller
- *
- * @msm_dp_catalog: DP catalog structure
- *
- * return: void
- *
- * This function reset AUX controller
- *
- * NOTE: reset AUX controller will also clear any pending HPD related interrupts
- * 
- */
-void msm_dp_catalog_aux_reset(struct msm_dp_catalog *msm_dp_catalog)
-{
-	u32 aux_ctrl;
-
-	aux_ctrl = msm_dp_read_aux(msm_dp_catalog, REG_DP_AUX_CTRL);
-
-	aux_ctrl |= DP_AUX_CTRL_RESET;
-	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_CTRL, aux_ctrl);
-	usleep_range(1000, 1100); /* h/w recommended delay */
-
-	aux_ctrl &= ~DP_AUX_CTRL_RESET;
-	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_CTRL, aux_ctrl);
-}
-
-void msm_dp_catalog_aux_enable(struct msm_dp_catalog *msm_dp_catalog, bool enable)
-{
-	u32 aux_ctrl;
-
-	aux_ctrl = msm_dp_read_aux(msm_dp_catalog, REG_DP_AUX_CTRL);
-
-	if (enable) {
-		msm_dp_write_aux(msm_dp_catalog, REG_DP_TIMEOUT_COUNT, 0xffff);
-		msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_LIMITS, 0xffff);
-		aux_ctrl |= DP_AUX_CTRL_ENABLE;
-	} else {
-		aux_ctrl &= ~DP_AUX_CTRL_ENABLE;
-	}
-
-	msm_dp_write_aux(msm_dp_catalog, REG_DP_AUX_CTRL, aux_ctrl);
-}
-
-int msm_dp_catalog_aux_wait_for_hpd_connect_state(struct msm_dp_catalog *msm_dp_catalog,
-					      unsigned long wait_us)
-{
-	u32 state;
-
-	/* poll for hpd connected status every 2ms and timeout after wait_us */
-	return readl_poll_timeout(msm_dp_catalog->aux_base +
-				REG_DP_DP_HPD_INT_STATUS,
-				state, state & DP_DP_HPD_STATE_STATUS_CONNECTED,
-				min(wait_us, 2000), wait_us);
-}
-
 u32 msm_dp_catalog_aux_get_irq(struct msm_dp_catalog *msm_dp_catalog)
 {
 	u32 intr, intr_ack;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 42ae8dae68bd0639172350e5aef0c522c1b02f6f..fbcaf1fba66e7c5918137f7f8092f0749dd4da8c 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -133,15 +133,6 @@ static inline void msm_dp_write_link(struct msm_dp_catalog *msm_dp_catalog,
 void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_disp_state *disp_state);
 
 /* AUX APIs */
-u32 msm_dp_catalog_aux_read_data(struct msm_dp_catalog *msm_dp_catalog);
-int msm_dp_catalog_aux_write_data(struct msm_dp_catalog *msm_dp_catalog, u32 data);
-int msm_dp_catalog_aux_write_trans(struct msm_dp_catalog *msm_dp_catalog, u32 data);
-int msm_dp_catalog_aux_clear_trans(struct msm_dp_catalog *msm_dp_catalog, bool read);
-int msm_dp_catalog_aux_clear_hw_interrupts(struct msm_dp_catalog *msm_dp_catalog);
-void msm_dp_catalog_aux_reset(struct msm_dp_catalog *msm_dp_catalog);
-void msm_dp_catalog_aux_enable(struct msm_dp_catalog *msm_dp_catalog, bool enable);
-int msm_dp_catalog_aux_wait_for_hpd_connect_state(struct msm_dp_catalog *msm_dp_catalog,
-					      unsigned long wait_us);
 u32 msm_dp_catalog_aux_get_irq(struct msm_dp_catalog *msm_dp_catalog);
 
 /* DP Controller APIs */

-- 
2.39.5


