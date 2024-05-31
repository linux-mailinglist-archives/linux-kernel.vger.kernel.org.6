Return-Path: <linux-kernel+bounces-197424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F188D6A73
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952F41C24C82
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81B183078;
	Fri, 31 May 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLeWBTbP"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B817D374
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186059; cv=none; b=ri9EkGqDGkERo5D+5s+cw0++KAGhz19D0ack/wQWaQo1/uLaWYm+mk1NkCntowIsLkIpbauc0K7KhcrKeJamszqAykt7OY6ZntiGalY84D6VuK4XgfAd8x7jA6M0Ngcpbp2qEC4/e/QBUlly/f2QF1hYNPWKpeReyXAmLh2VOBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186059; c=relaxed/simple;
	bh=YU3BlXVbC2sxyz2PPZCCSUqtcJVpgJv63N0Ddf7f0rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYw9QbBAPqMfOOK5LNQm2MNQpx797RaO16Myeqa2b/CKwIm/GYD9hXWBbaOB2SDtU8spgu5IrKCiCMsHt0+RKbda0E7erOcO1mPiGtw63Lbv5MA8sUgeVZFQM7M1xjlDvTGChbYI+Hd1zhvDlhFCLB6ubrzGbk8o2jpFt738UEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLeWBTbP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e96f29884dso27960981fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717186056; x=1717790856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyQFsCbfAwoMIv3tWG4MkDjXNMbuJRe63fpfFnOR1dY=;
        b=sLeWBTbP/IT7kn1+cAAyxW0+8gieoIuqHiJqREmNF8kMrtRlPP64bhMshadodwRyNf
         WD8zzmuW61+ZS2c7/b1YK99Fhnw90NSoS9ft9G1PaQnFN4z2NKv5jlXxOGDZekav6mxr
         FYZq2stl5e3IEBcwTLc+wZLaQtCMyojdLhtrl4Ji/p5qzO02K6n6nBUX1Hs2sOPa8sbb
         PeBpFmV8IJmHDoHXpxHmSUeLaT/SulMJ+JhTzRt/m/vAWv5HX0XcMsOy3hIX/Xi9Kinz
         pgTeXke+joqeSwb6acLRg2Mm+uxZmR6y3SnzZzCiB254qmDmMNWO7EvYe3FGifrhYWvx
         +BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717186056; x=1717790856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyQFsCbfAwoMIv3tWG4MkDjXNMbuJRe63fpfFnOR1dY=;
        b=guVUkAF2FpYKNZIjIg9qKK5SBDAZ44eZ/Ws8M36p1jJZueBn0y2tguwWzUVaSgYf8f
         rDAVJbLGG8i3AO9L7eDgtbCLcCsDpKFelOJ0qNwIGo2xkVLn3QlM+PoWN3LkpbtTP6jH
         QkYqKz25frc9NHpWP02e3wZPhx5mnK0u0Y8ILfwFPn9UN9+YWbn0R+t30/O9hKtqVmkb
         PwVD3zDffoal/pGfsIre0J4EF88s7yWaV3xKWbn8Tpdm8Cbl3C30+5S/wDt2sc/9h5JM
         +D6hzXwKGurMNNZ0rzuUfaYrYa5D7Vu5bM4MYPTuPVlGJHZhgidlp9NZWL3qS2Zijuq8
         yZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwih8wSEk017K8/TF/GeWk7wJs2/Zs77CfvkHG9f3J7VNTZWFlOmasaqgtdroga1F61Kk0DC8E/+0f2pK4Zygjuy9QUW8DUo4iXp5D
X-Gm-Message-State: AOJu0YySXkwk8KDzjbtGLaBLbik0Ber9iIGhgxplfQXaWp22NsjzzjVV
	MUSYmeVaaC82z/A3dm/wMt3oweQeu+k4nV4Hyc4PCNq5Qthijl0B+tkExnJ2rrs=
X-Google-Smtp-Source: AGHT+IG8WKuvGdyXdl/w5pEmXWOdKQMXIjLeMy0WFBbgze9CMqtMG7e1bNR/WlANpKFq7SOK+v+ikw==
X-Received: by 2002:a2e:a787:0:b0:2ea:7e51:5166 with SMTP id 38308e7fff4ca-2ea951e7dedmr23294901fa.41.1717186055760;
        Fri, 31 May 2024 13:07:35 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cf0b83sm4022111fa.116.2024.05.31.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:07:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 31 May 2024 23:07:30 +0300
Subject: [PATCH v4 7/9] drm/msm/hdmi: get rid of hdmi_mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-bridge-hdmi-connector-v4-7-5110f7943622@linaro.org>
References: <20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org>
In-Reply-To: <20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=YU3BlXVbC2sxyz2PPZCCSUqtcJVpgJv63N0Ddf7f0rw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmWi4BHrqnztSl/bf+yajDn9vgYH4mqH0Y53sGo
 OoRBr924/SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlouAQAKCRCLPIo+Aiko
 1Xh5B/9zouH68B/F8qgbHAklwaF8yiIgh7VTIvtswpeCMmZLV2PjfKonuGoa7WMjbjwa1MrRxuf
 uMHblZllej3vHkYrPZXm1m7R34tnOWxMFrftxZpH0N9XUb2LRJ1iC5MmXv+kkLNBxAqrJcfdRp8
 BDLXB//GNhc8L2wreI+17e15dskv9NFqKM2PBiWkDv0BI1+TZ5783H/WqzJ8qGPG2ZBUc3HrOvS
 2vID35dnc5jwtgpP5l4HDLUxqS95aGxjiG9XJBbT1Asxjss6TYMpAYjlc6oOOT8eERXtBV5JSoL
 2MOfphPuAaCuwn2mPD6tFm7UcVwXHnhi2hJkIdXN3UUXupU4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use connector->display_info.is_hdmi instead of manually using
drm_detect_hdmi_monitor().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c        |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h        |  2 --
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 11 -----------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 179da72f8f70..2e2883b9229b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -25,7 +25,7 @@ void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on)
 	spin_lock_irqsave(&hdmi->reg_lock, flags);
 	if (power_on) {
 		ctrl |= HDMI_CTRL_ENABLE;
-		if (!hdmi->hdmi_mode) {
+		if (!hdmi->connector->display_info.is_hdmi) {
 			ctrl |= HDMI_CTRL_HDMI;
 			hdmi_write(hdmi, REG_HDMI_CTRL, ctrl);
 			ctrl &= ~HDMI_CTRL_HDMI;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 0ac034eaaf0f..b7fc1c5f1d1e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -67,8 +67,6 @@ struct hdmi {
 	/* the encoder we are hooked to (outside of hdmi block) */
 	struct drm_encoder *encoder;
 
-	bool hdmi_mode;               /* are we in hdmi mode? */
-
 	int irq;
 	struct workqueue_struct *workq;
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 9eecc9960e75..9258d3100042 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -346,17 +346,6 @@ static const struct drm_edid *msm_hdmi_bridge_edid_read(struct drm_bridge *bridg
 
 	hdmi_write(hdmi, REG_HDMI_CTRL, hdmi_ctrl);
 
-	if (drm_edid) {
-		/*
-		 * FIXME: This should use connector->display_info.is_hdmi from a
-		 * path that has read the EDID and called
-		 * drm_edid_connector_update().
-		 */
-		const struct edid *edid = drm_edid_raw(drm_edid);
-
-		hdmi->hdmi_mode = drm_detect_hdmi_monitor(edid);
-	}
-
 	return drm_edid;
 }
 

-- 
2.39.2


