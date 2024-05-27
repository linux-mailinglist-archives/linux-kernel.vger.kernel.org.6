Return-Path: <linux-kernel+bounces-190157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1FB8CFA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B362D1C20F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5990B3F9CC;
	Mon, 27 May 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiULr+gM"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4497224D6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795938; cv=none; b=SUFLPQibOGc16gh8/THNr22aPqn0YT3XMs3kxDIi4zswKvUH0OQkVBWKCr20n6oJuBwOlvjPNlqACLg0580CaDIye9bcoZHb0B6NdmL5uQWpVP/BWCSZDiJW1S2SUpAclq5vVCRJnUpUzOCXwKvoxjgfFbvxVbe7QHH8Y/AIC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795938; c=relaxed/simple;
	bh=HrzCuyYOTQp6Hcqse0NW0mxe7R0/QtbPKl1iU6vPkbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMh89tLZ4S5SHKwVLSOcR4ckKPAWydkkHkOpVT1k7JloiTlK8DS7ZRjgdN8CvgsZHCcA4cMazBo/my0pY25Y6PawfWpDOwIAy8Tw3TgX4cAFIhIiccp3o4iTIXQDn7pSdRXEms5Wy2pMfd10Ztb+8eAcIb6xAZKENO36IEnQ458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LiULr+gM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-354e0cc9c5cso4525463f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716795935; x=1717400735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OIdwth0KqS+sBxgs7ae2EL7EzNf1O+NkE/SPqs85gk=;
        b=LiULr+gMPThr0LuCqo1UUtix1jBRYSr4drOLhH1LC79vsJax4lWdU3opfu1q/3a7L6
         0Jd0QEJNAxfZCr00JY9ovH8J8KqOtMnpe/v1L0XZNw08vAnBoR9V+2TSAU4P4/MZMxv+
         XMBdAVYkHJMwG6z+5FzP7XUv35Yg9SwTCJH5OTA6uSuSmNF7dVWKO+As3l0CG+ZQaE3U
         jHo03HsIrwQ18LrRUcvHn4cK7c0EcawAUOACNOFZFesWxwZu/Sp2mQr2mMuSDYgsoro6
         Uz3k9F4hdAEwjS8vlz4UrB6yKKL9aZML6Gx20HUize8zLsZgccSkpcVvLjHFZnBwPpJk
         XwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795935; x=1717400735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OIdwth0KqS+sBxgs7ae2EL7EzNf1O+NkE/SPqs85gk=;
        b=YLzN3mC7vqfbbV7K3Zgchr/fR/hl4+GwhVKSnPbiEbxMtejfROz8esKcy9K+SC5hUA
         Fe+oSjKUerDIsl2mzW6oEBsiWfU9d5vtjTtnIgAlfrv/S/jVkLTCTeayU/XG5Hni0OCl
         pNxRKQ1jjDoddIMJpc6U0ZlslQ+hOP9cc3EaZ+XhjVKKNzZDaPEPlgL0mJGUXkzEnNL3
         3XBGlos1+BKGcninAX+p8n0wpfVzlG668Tzs6DF4g7JH9FCrqWCECmHmjByINnsVVrO0
         bLVDuMyhrnrERS1cmI1Mv2t3kk69EsX4HdXLeh75JjQRH+rZ2MMo7b+OXaSED6MxC9+Y
         5waQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUiQ/8W2E8ZjCNtMxfZAsq2afFeGaNIqT5bwee1iUg3lTT8ROdQeKXibYUIucMcO6rUXdMewtB7kpXhRxPyztFUyZpA/93wnC0zk0M
X-Gm-Message-State: AOJu0YyIV26E+sBre7/390/MV+hpmGNwnRvURwFfrfcAR8ZwYLtzEeO1
	oNMEEqf4DkRHViRxgAhlzyfIQR9+O5Q+HwwKVsP0sBBK8oFQLUCT0S46MX9XLR4=
X-Google-Smtp-Source: AGHT+IHY2u91yvON0SLaRQalJBNqlqvX+k3ce4dcksK49BgH1rmpX3P5U+oUBK4qkAASspc9wxgBBg==
X-Received: by 2002:a5d:4ed2:0:b0:354:e021:51c6 with SMTP id ffacd0b85a97d-35526c39f7cmr5966023f8f.29.1716795935311;
        Mon, 27 May 2024 00:45:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7d96fsm8293353f8f.12.2024.05.27.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:45:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 27 May 2024 09:45:30 +0200
Subject: [PATCH 2/2] usb: typec-mux: nb7vpq904m: broadcast typec state to
 next mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-2-79ec91381aba@linaro.org>
References: <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-0-79ec91381aba@linaro.org>
In-Reply-To: <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-0-79ec91381aba@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HrzCuyYOTQp6Hcqse0NW0mxe7R0/QtbPKl1iU6vPkbA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVDocelcDrjEPDvs6jUdABnQcdpTrLVpqpPM+z90t
 PF5o0LWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlQ6HAAKCRB33NvayMhJ0eNVD/
 9h2NJKbfL3JsS2/nrhffEi5tD5N8zEdmLMdpUapb+LS2XC9EI8U4xOIn4sH8irpmJ+TBpkEpSNtpPp
 VerjFGsdkdzVsEGmdxn2q0j5d0q7E1HLJj6bFc8ZIiWjvM7ahBxip7PXZPjryFqOTKN+77JSyonye9
 v59VyzvpmWWz92qw2LnFBevJdGaHN/Tk8xYOOq1Z5l4ekyPiqDrn4KeYizPenbDwGvG83qJjwtC9QH
 Oso2wUE0NI7m2tMKa2rL9gZZcMelPs4P+GuU0P1MZk9HUgXmcwbN8qhjCXC+uN4wnzzFW80SmhX8u0
 ELrnQbmbZlrSDromASiTQZ29+3uw+4l/fC+olHXfiEB2nw53sMoVEmddGk3RpKM77hIwGLOl4tdRqs
 bn1kX/+soTo9PmiWAuKB2gxscVXioxLHmkckWKLqlwUJyOlRDBRLBOjdvZY8jqlzD2QYME5tmxl4ou
 1+2x5sFNJwdDX56hv5glqcoAShOe6ZDIPVhJCmMJDFzaE21K3dqsE05sSX1ZSTAy+3Oo31RSk7xfa0
 Num6QnfBHVkvsZp5anY53iKxcfK7ewuTOIfPeel+bR31pQ/hd5PoITG7lC/zmBclQdAz5Pij4vuPrc
 ZECcYIkU54x3N0V21X7T+St1XLssjU4csuuJQ+f9Uy27KXVpknP0c8bHM0/w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In the Type-C graph, the nb7vpq904m retimer is in between the USB-C
connector and the USB3/DP combo PHY, and this PHY also requires the
USB-C mode events to properly set-up the SuperSpeed Lanes functions
to setup USB3-only, USB3 + DP Altmode or DP Altmode only on the 4 lanes.

Update the nb7vpq904m retimer to get an optional type-c mux on the next
endpoint, and broadcast the received mode to it.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/mux/nb7vpq904m.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index b17826713753..efb10f890fed 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -69,6 +69,7 @@ struct nb7vpq904m {
 
 	bool swap_data_lanes;
 	struct typec_switch *typec_switch;
+	struct typec_mux *typec_mux;
 
 	struct mutex lock; /* protect non-concurrent retimer & switch */
 
@@ -275,6 +276,7 @@ static int nb7vpq904m_sw_set(struct typec_switch_dev *sw, enum typec_orientation
 static int nb7vpq904m_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
 {
 	struct nb7vpq904m *nb7 = typec_retimer_get_drvdata(retimer);
+	struct typec_mux_state mux_state;
 	int ret = 0;
 
 	mutex_lock(&nb7->lock);
@@ -292,7 +294,14 @@ static int nb7vpq904m_retimer_set(struct typec_retimer *retimer, struct typec_re
 
 	mutex_unlock(&nb7->lock);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	mux_state.alt = state->alt;
+	mux_state.data = state->data;
+	mux_state.mode = state->mode;
+
+	return typec_mux_set(nb7->typec_mux, &mux_state);
 }
 
 static const struct regmap_config nb7_regmap = {
@@ -411,9 +420,16 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(nb7->typec_switch),
 				     "failed to acquire orientation-switch\n");
 
+	nb7->typec_mux = fwnode_typec_mux_get(dev->fwnode);
+	if (IS_ERR(nb7->typec_mux)) {
+		ret = dev_err_probe(dev, PTR_ERR(nb7->typec_mux),
+				    "Failed to acquire mode-switch\n");
+		goto err_switch_put;
+	}
+
 	ret = nb7vpq904m_parse_data_lanes_mapping(nb7);
 	if (ret)
-		return ret;
+		goto err_mux_put;
 
 	ret = regulator_enable(nb7->vcc_supply);
 	if (ret)
@@ -456,6 +472,12 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 	gpiod_set_value(nb7->enable_gpio, 0);
 	regulator_disable(nb7->vcc_supply);
 
+err_mux_put:
+	typec_mux_put(nb7->typec_mux);
+
+err_switch_put:
+	typec_switch_put(nb7->typec_switch);
+
 	return ret;
 }
 
@@ -469,6 +491,9 @@ static void nb7vpq904m_remove(struct i2c_client *client)
 	gpiod_set_value(nb7->enable_gpio, 0);
 
 	regulator_disable(nb7->vcc_supply);
+
+	typec_mux_put(nb7->typec_mux);
+	typec_switch_put(nb7->typec_switch);
 }
 
 static const struct i2c_device_id nb7vpq904m_table[] = {

-- 
2.34.1


