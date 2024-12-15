Return-Path: <linux-kernel+bounces-446609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3149F26D8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394D91883BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA61D433C;
	Sun, 15 Dec 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2AcAyHU"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B551C5481
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302678; cv=none; b=Y9b21hPxHXzHTj9E9jWFG09426kQccQ3q48XkS3ip+ppsyfcQSV4A73Yg9i2PHhg2+wYumo0Knw1Bqj3p+HkXM/cvF/yJHNMRew4Q7lg7P33PYvKLknNemgh4K4U7BCwqRrl8OHLP0th5KUS5Er93Gzq5PEQpmso7Y2s4JnbWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302678; c=relaxed/simple;
	bh=Q9a2tVUQRtXoK3RAzUw2vGdLzirA/LJdw1Lj/fr61I4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYm70rCuICbVB5g8YS+MlYvmFw4lSUZMxx/RSYCLs0JFFkGgkArVCNgq79J8i4ClDAgoNqyFtHaXwvILUEXvIutVWy0EnPoMqvHqFiRPYBvaQFraZzjpzEYo4Vy3Jn3VxbgVClJ6bJCihVDA2lIrgzikQyBAx3+bsytGzYId0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2AcAyHU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30036310158so31260381fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734302675; x=1734907475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIJddOd/Lq+z1ByZLfkGPBEa7UhiDwOlN7aC9m1O2ic=;
        b=X2AcAyHUEFpRSEbCR8tJNYrOSZuG0Jde7TRPF0/wyUJwM5vzqQUt10RqCRJwZY1mE6
         i4/2gg9/1nTCQxNfISAnMyNWXZYYsUs3ssJoyFqlP6SN/Oa9S5C7HIyXpujozZ9pC71K
         U9w+ulZtzNQ9hjd5XklUxfmBhIaryVxV5NEmxumVz4rEi4h6qijR4EveqHOZURSphxGG
         +eZbWqNQtyq/zxUzF6eEz040NMfCAlwddrDYhkad6homNNTKaq37wumeKwRjUL9+dbVb
         8B3zq3cz7xGnpLQvn3tqT137hFtY6J3T5GWUTvzDgCzxqxGlYJ+mxyhykD268y6YaR+R
         4vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734302675; x=1734907475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIJddOd/Lq+z1ByZLfkGPBEa7UhiDwOlN7aC9m1O2ic=;
        b=CJAXTMgd9ckzuJW6tq+dGneR1EHicauSSNqkT7sPvkEjdvoW94a7rawSiAr3J2xtO8
         dZ2IQ/hBX8ETIGZH+MQscXF32uPhgSDkdMsFyvrVVqO6KIcJP2bURe7ov8EoB7pvdJRO
         OkbW1QKB2ArB6I2d6Scj9niIWR9fJAVK/lZ3+w7rUbaYAyjau1iwtmUIZXwCvGex+ouc
         9LtPrALOjQQjiVKTzCTWCdwQVzDZg1ASwJFu4foIwa+/CJdj9jQvDx0gdBiKrrUbt2Xg
         IucWeFZvAZUBvXiUHAsEVmkEMY5qWACP1YyK6XhobArJiyfv8Rdogltf10i112V0FWVG
         WsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgFM9JsPhOJQje9HTVjKr/zb129pMA5D8cqgRbbl3/2bfuNDRo9v14LmHXyoiqgGjFpnN7cPk4E3YOBHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnUZKY1jk6GOUmXssYNZaoDk1dzmlCVVy+Pqd2l7AUv4csjkv
	gMAMVGgEqdNdZiJzAMD6/doJHANbriUgWmrXBLnlp8CHRm6h2od18/6UA8LgQzI=
X-Gm-Gg: ASbGnctaMNtzADAylJFC9gTB3DFB3ksoIUafhCjayH0OxvUrBUrK8oExKQ0MB3IWyMH
	EBDk+SzuheFMpMYSll4r0mQ0ZvtTR73EsI/1brRqgU8zOyrRmwvFbqZzWaEuIQgenU3aNftEU3P
	tQaFgqILUUZk/3L99LkziLfJT/MqClTRyReewF+UKxJPxO9gFCZLCtvLDP6z5v1Y/6Hq+mlC9bB
	v6Jt3Fo6DOShaOE53wxpv3cZaCZp0DQDnn2yGcLf6fCAoMXvDAzsOLY7/57J2SU
X-Google-Smtp-Source: AGHT+IFtj8Is41TWdJBleQnf+wXOaynHUqVDXHOO1wsfK9DOxqw9f297G5QpgI1udU3s/mXBMbEDRA==
X-Received: by 2002:a2e:be0c:0:b0:302:25f2:4853 with SMTP id 38308e7fff4ca-302545b6eedmr34259861fa.38.1734302674543;
        Sun, 15 Dec 2024 14:44:34 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a41d1sm7201701fa.100.2024.12.15.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:44:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 00:44:14 +0200
Subject: [PATCH v4 09/16] drm/msm/dp: move/inline AUX register functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fd-dp-audio-fixup-v4-9-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11841;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Q9a2tVUQRtXoK3RAzUw2vGdLzirA/LJdw1Lj/fr61I4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3p89K6fHNPlP6dyXfgt/+FQh9aR6envrrv87/9lr7c7j
 E/pmNT6TkYjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBM5NQm9u/xNvN2+yg5TTm9
 /0OhsFfD5w3Mj3r82WTunufvfP5za97Z56w7FtjcP5fuqerQPd/Jm6u2nHlGSJecof7q32FpAje
 1+F15LT4qGZ5Qdnyg0OaUN5mjWLD4rmpn887IXWuO/vlYF5z0bYaE9J7SQPtZ+qLHpps831q69x
 5XdkzTW8MTLX6a294/b7Pj1j/uFdi1eLar3pbvV3pu5Ds913b53yF94618z22v/G1Ci372+iZyX
 VB6+8b5U1Nr5Knq6nmi960qXHcvTytTlZBf7BORzdfB8yrNIjo12FnxW8V3Z7emd8Xexomy6+IK
 9q17Hh/ctm7zEQvXHZurd3zzj06eEp2pbPsnVrprczIA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move all register-level functions to dp_aux.c, inlining one line
wrappers during this process.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_aux.c     | 96 +++++++++++++++++++++++++++++++------
 drivers/gpu/drm/msm/dp/dp_catalog.c | 96 -------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  9 ----
 3 files changed, 82 insertions(+), 119 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index bc8d46abfc619d669dce339477d58fb0c464a3ea..cdcab948ae7086964d9e913dadadacc333f46231 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/phy/phy.h>
 #include <drm/drm_print.h>
 
@@ -45,6 +46,71 @@ struct msm_dp_aux_private {
 	struct drm_dp_aux msm_dp_aux;
 };
 
+static void msm_dp_aux_clear_hw_interrupts(struct msm_dp_aux_private *aux)
+{
+	struct msm_dp_catalog *msm_dp_catalog = aux->catalog;
+
+	msm_dp_read_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_STATUS);
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0x1f);
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0x9f);
+	msm_dp_write_aux(msm_dp_catalog, REG_DP_PHY_AUX_INTERRUPT_CLEAR, 0);
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
@@ -88,11 +154,11 @@ static ssize_t msm_dp_aux_write(struct msm_dp_aux_private *aux,
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
@@ -106,7 +172,7 @@ static ssize_t msm_dp_aux_write(struct msm_dp_aux_private *aux,
 	}
 
 	reg |= DP_AUX_TRANS_CTRL_GO;
-	msm_dp_catalog_aux_write_trans(aux->catalog, reg);
+	msm_dp_write_aux(aux->catalog, REG_DP_AUX_TRANS_CTRL, reg);
 
 	return len;
 }
@@ -139,20 +205,22 @@ static ssize_t msm_dp_aux_cmd_fifo_rx(struct msm_dp_aux_private *aux,
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
@@ -336,7 +404,7 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux *msm_dp_aux,
 		}
 		/* reset aux if link is in connected state */
 		if (msm_dp_catalog_link_is_connected(aux->catalog))
-			msm_dp_catalog_aux_reset(aux->catalog);
+			msm_dp_aux_reset(aux);
 	} else {
 		aux->retry_cnt = 0;
 		switch (aux->aux_error_num) {
@@ -403,7 +471,7 @@ irqreturn_t msm_dp_aux_isr(struct drm_dp_aux *msm_dp_aux)
 
 	if (isr & DP_INTR_AUX_ERROR) {
 		aux->aux_error_num = DP_AUX_ERR_PHY;
-		msm_dp_catalog_aux_clear_hw_interrupts(aux->catalog);
+		msm_dp_aux_clear_hw_interrupts(aux);
 	} else if (isr & DP_INTR_NACK_DEFER) {
 		aux->aux_error_num = DP_AUX_ERR_NACK_DEFER;
 	} else if (isr & DP_INTR_WRONG_ADDR) {
@@ -444,7 +512,7 @@ void msm_dp_aux_reconfig(struct drm_dp_aux *msm_dp_aux)
 	aux = container_of(msm_dp_aux, struct msm_dp_aux_private, msm_dp_aux);
 
 	phy_calibrate(aux->phy);
-	msm_dp_catalog_aux_reset(aux->catalog);
+	msm_dp_aux_reset(aux);
 }
 
 void msm_dp_aux_init(struct drm_dp_aux *msm_dp_aux)
@@ -460,7 +528,7 @@ void msm_dp_aux_init(struct drm_dp_aux *msm_dp_aux)
 
 	mutex_lock(&aux->mutex);
 
-	msm_dp_catalog_aux_enable(aux->catalog, true);
+	msm_dp_aux_enable(aux);
 	aux->retry_cnt = 0;
 	aux->initted = true;
 
@@ -476,7 +544,7 @@ void msm_dp_aux_deinit(struct drm_dp_aux *msm_dp_aux)
 	mutex_lock(&aux->mutex);
 
 	aux->initted = false;
-	msm_dp_catalog_aux_enable(aux->catalog, false);
+	msm_dp_aux_disable(aux);
 
 	mutex_unlock(&aux->mutex);
 }
@@ -517,7 +585,7 @@ static int msm_dp_wait_hpd_asserted(struct drm_dp_aux *msm_dp_aux,
 	if (ret)
 		return ret;
 
-	ret = msm_dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog, wait_us);
+	ret = msm_dp_aux_wait_for_hpd_connect_state(aux, wait_us);
 	pm_runtime_put_sync(aux->dev);
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 871c935cbe10bc2749960d61cc6b835a3ec2e296..85cc3d3548438ee1d4e5d4aa1fec03cfa6c1bbd3 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -81,102 +81,6 @@ void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_d
 				    msm_dp_catalog->p0_len, msm_dp_catalog->p0_base, "dp_p0");
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
index d08761697a8e48b5e6827411eb5d1bc9df4894c8..40fbea821dddfd445ff48b62e2acbf10be522d63 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -113,15 +113,6 @@ static inline void msm_dp_write_link(struct msm_dp_catalog *msm_dp_catalog,
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


