Return-Path: <linux-kernel+bounces-206130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A39004A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4672528E3BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696EA196DA2;
	Fri,  7 Jun 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3zWx1eE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF636194C6C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766594; cv=none; b=NHmamYAXk+hrBu1XbcYBWgPyM4KWMsRWhTBFfN/OiEDr+iFxVSNDq/JN8GmBndqI0ekxnDKzBOEaBEqSoeODGBKLB6MAj6jk2c6uiiwopa1ysMzSnq1gu5gE/hyl1v2n5BalueYvfKdGedg7MKg4Fuj6mlApvPIaFO3UxYxu45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766594; c=relaxed/simple;
	bh=XS0dF9Hp3iaKsKwda8RRLnnXLW+mcezSYG9g3tkKpC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIrjsJSl1UqGGtoqfJDfFG4FvMMijAsBpUetIxB5ptwIu/Er8vviwkOBZczyn2tM2flRthRxJ0Arhmygdtfu7X+mp9Pr6b8UCCQEH26b+drZM61xjHlk7zsFmT0PIIvFRS4L7jI/78yX1xOerQeM+HHF8wFj2RnhbRV9LUMif6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H3zWx1eE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso2387709e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717766591; x=1718371391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXdquAR+phBlXTozHdm7dMyEIpvNqpWvTvyb01zEe0s=;
        b=H3zWx1eED1pTWJ0yoxTqLDKs3J57TPgKkX0EoVTCu0f/I0SAC56nPjZkpJ+DKBNDb1
         FfvTxbW9N3ditsQA5PLSReh7fDN/NCxSnrN/J+r1PVB+DwD/GTH3CnwtfdlbIHo4xm/o
         ygjRqfho6CGXrf3HBwxjt0SblEhz3IQ3r93ozcnvLJpfEhWw3najK436LX9PPWHglh26
         OW8gN8PuBIn/BQYIp8ERtzxrSbSvZj2ZeN7ATlgqQxWO9WGAoSrJna0w8MR6dlMPfk/Q
         +kPZomCA8B2FSQeLwmcUOQUjsu4seCbLTzwjOUaWxwWhRYE1pVTF3QxrFm6Du0HpNwDa
         rtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766591; x=1718371391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXdquAR+phBlXTozHdm7dMyEIpvNqpWvTvyb01zEe0s=;
        b=mXZAVjBtTuRZukWVHEJsHR+XBEPxusQAG3XTsq4a2W9Y3DGpjHx8mKiQi+6PuWBsg7
         U2/yKsIGT6Sen5MgK0cjPVnZkb2Cyl6aZ7d8W1Xz5P5452pyiR4s27CuJykVuHRDM84Q
         tQLq/Tnt42oU5QNFrRwEaicANYMRKAVUVFrEBKFOHx4zsVLkGYCh76Xp5JGszrmKqbf1
         zxe6uZSsGHmAf5gtXhDXQ2sc/ZRadewqIJNudaUrOUvKH8gtVOQy74zwoOsgNfe0cP77
         4C5Qgod8qvdmL8d6wdbpxUoshf1OrdeemFDoLWXwe8i9t9S/yCJ1Mt+H+pWxL+ZKz5HM
         q2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU+fYtcXoI6HZtizL04nlb8Q2qOqd49BZ9L8CAmqMAsWKZS17SViRIeKLXJSwa9/xUGU+6WCnNDHyAxShF8QrBNYvfiyLI6t3uqJJrT
X-Gm-Message-State: AOJu0Yxd9SrnMIFYeVKS7jvoNt+KOSHKZyhq3G0LjL/wPfJWr+jnQUn5
	Gt5kmPvRKWakADxOjGMu02EBbqhK4X5l1rI+/VfUKHys0lMjqFU9YIQ2z6IFYlorgzIjA+4HvVv
	2
X-Google-Smtp-Source: AGHT+IGLoVtK/GoET0h7mygknqinWMr3R2cDmz76SQfF6CeRRgYTYruB7fM0iGyXWid3KBk253QIDA==
X-Received: by 2002:a05:6512:1326:b0:52b:be6c:a5c0 with SMTP id 2adb3069b0e04-52bbe6ca8f0mr1271589e87.27.1717766590808;
        Fri, 07 Jun 2024 06:23:10 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bc27640easm80944e87.104.2024.06.07.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:23:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 16:23:04 +0300
Subject: [PATCH v5 7/9] drm/msm/hdmi: get rid of hdmi_mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-bridge-hdmi-connector-v5-7-ab384e6021af@linaro.org>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
In-Reply-To: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=XS0dF9Hp3iaKsKwda8RRLnnXLW+mcezSYG9g3tkKpC8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYwm2xF+lxxNOE0yXubq+gpv1Q48FKCb8JuMqj
 PLAvN+kr0CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmMJtgAKCRCLPIo+Aiko
 1fb1B/wLsMbXWPpWLAgu0Wl6XJ89Jrvfv/uxEWmtjrYIAmL4H0k1F4fHHeSeQSqj7yq821G7vee
 oir/2Zobw+jAWsmxXQSsuPheKW+oWMAVK/CBM2ii1ohH+/0mA7f8prqkMRZQd4FLovmYcGwFfz8
 M+TuljED+sP6jew1R7tMDm8AGINIXW1YPSWzmLcxEzoN4CeHzGVjp1MyQqQZj1MblHhDTjtjWIJ
 JRvgUn5zYFQJuUFnqkigObXSbpWPekr6KtZd9yq9CZrEqWcXc8XIiAO5B9lidIcHzAFYlu+uI5i
 lo9d+eBQAMhuLcS0Q4xGUaImFER7jo4BrpGgoDCw7yv6cXnH
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use connector->display_info.is_hdmi instead of manually using
drm_detect_hdmi_monitor().

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c        |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h        |  2 --
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 11 -----------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 2279e09fd2de..8c6c9dffffd6 100644
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


