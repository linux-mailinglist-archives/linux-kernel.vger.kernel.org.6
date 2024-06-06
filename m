Return-Path: <linux-kernel+bounces-204328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61C8FE748
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AB92856DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9A5196C7A;
	Thu,  6 Jun 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZqssjJx"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70D195FD9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679483; cv=none; b=TTxwzjJCJjgslc7qy5bHZUVNh3Nv7rcpvDpgF/HrF0KImTElar/DbYLOO8YwovPGagE+FPTna7+TDW6GBCBK3ITkGjyCzMWPQA+2Wt8HQvAFjcryhBVaDfNMKJkfMSjAjI+HjXvNNf3Rcm/83Bu3t/wu9UMDRpba9yCCdu0f4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679483; c=relaxed/simple;
	bh=qb+nX0PsQ8r0ONiEBtEpU+5wDoCjx57v1hbZ1gvN1vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5UUxfyOfneJfBkHPVtzhiq0boGIv1SR4Y4pjQdQ93V7qYCTbHynnJjuzqWymrf+ykXbwfDiAB28BeAPTePtzKB4euYvYCtooL4GvouyMJB7AkG2EG/homXMyokcFLc0vLlZtOc5ZBiyAhsexDIrnmORMd9IDeaED2Tra/u+9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZqssjJx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35e83828738so971978f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679480; x=1718284280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEWi4BwYNC7NiwESLETKdGa2PVEvW42M7cysehMEv/w=;
        b=YZqssjJxZjALoW8a9Zo/Yg3sPXUytGVL/zKpYbAGboJkB20wwQ0Z7Np8MGXT+ov0sx
         Vfzn8y8wJX1ktb2CnbW4Og6L1NWzzNXCZLjeH6cPvwtWCzzltK4EmyY3qbKJrUl8vqkj
         FVhNCZnRmUxWIVvuA5mBFWptptps50x9LZfc0edUvFZD0wUt6jFiqrolrdgQR7Fn91DJ
         n8Hd/Wv2JjbmNjxwrXDPXnbGJCVD6KadAm51ZOlGAWAd4oDVByva+Hm0KJHduE+gEB9V
         t6T0oAwZaCrDR3bOZVgxPIw5L6tmO4E/t0C2EGDajBzC8CP9d7l+wDGT0wZ0TjBeQCf8
         3TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679480; x=1718284280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEWi4BwYNC7NiwESLETKdGa2PVEvW42M7cysehMEv/w=;
        b=tnf+oLTTfvqGjOtUOZvxHs0d0G03KwUKBlPm9WzJLx70cdWlSUG9gnmsfVQa6n//Ed
         InnJazJf1anTSqwRDcXAm/4gQv429FNRftF8TEqLi/Gx8gPXVr7TyOi3JC4hFJCTf5Y6
         pytmyLLpVALgHmnNmdDsQmC28AlLPCFuVC+/jTDxTuYPUkXnrUr4sotaP9f9dFr0HT1H
         uNVv3Mia496gEgmg/MKYF1BsUnb6I69ADMzWBUd8StqdgnhcUbQyKDGsAETX/M1wzZX3
         /DJ2LBF171iWZmKfHIiyya+Kr0DphWofzDYCRSqQzmQoO4UiGqbUhAIP2WYYyfbZnOAl
         0gng==
X-Forwarded-Encrypted: i=1; AJvYcCUQZr0cDXEx8hAuTa8jgTQQ5onMEJJyl3W3zN/iUoCd6owNvS2d+iaa4QcFvQwiYGNmIeuEH25Nn6nhYGFpippvqMhz9n6B8qNcvs5r
X-Gm-Message-State: AOJu0YxVnRgOW2HaJcbzBF8oEw20zKSy2dSXlDeHTcZlR7B4eFk2zEhW
	8euACP3cm8fl6NRIc3Q96J5JMDK0HJG8LtFhUUGFveHhluL58FnDjdHYYi+0xLw=
X-Google-Smtp-Source: AGHT+IE9b0Gh3BEH2+Z6EhiMWZLgD7E7TuzNaS2tTCwJyO7yfVStod/NfZPZ5Zly8PO/5FoVvBMI+g==
X-Received: by 2002:a5d:6789:0:b0:35e:5189:2d78 with SMTP id ffacd0b85a97d-35e8ef65f13mr4278385f8f.51.1717679480088;
        Thu, 06 Jun 2024 06:11:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e96d8csm1536316f8f.68.2024.06.06.06.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:11:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 15:11:16 +0200
Subject: [PATCH v2 4/4] usb: typec-mux: nb7vpq904m: broadcast typec state
 to next mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-4-c6f6eae479c3@linaro.org>
References: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-0-c6f6eae479c3@linaro.org>
In-Reply-To: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-0-c6f6eae479c3@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qb+nX0PsQ8r0ONiEBtEpU+5wDoCjx57v1hbZ1gvN1vE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYbVzE2VApWoDdpfFcgBobGdrW+oswV9CTaRJdatQ
 yQcQhE2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmG1cwAKCRB33NvayMhJ0XMwEA
 CstrM6GVtFB3iT4ScLC99aKh3P3kIZ5m63NeW452HP255KG6zoj3lWFOOaZu5ni4doUIVI5mbRLUa1
 mbMR/c76PjtFi5T+zuP65MGXcxxiXdiAUeLY4KelNaaAMXqeOFNgZaTdH8vjW3qqa0ri9XGxJQ362N
 WEcnUr1WbqqbXnJ8qIK5ntewXkwRpxfneqZCSrAA/78Yclc03W2BTESxgdMl/aJJwmYJyIW5rx+8n3
 SxK5rlisB1GzOQGzH17bjtP6QUzh1YkczAW26+YOLvekqOS6NxAc8D/S042ZP68FSwY2WvRKhA/fZl
 c574ke1/S81rIF7GUWdWm7mTDEsz6mI56dcoxoNcnARx+cQVBc1Nk4bV84gMbyQ65OqYGmrglul/ga
 GfFINiQloveTpdP8uxBNuZLNPxQTUH91QgRR9LoCRe+fW7NUeHTipRq/2Dv4Pq6woouWR/j2xsRiAl
 945OYEFAHkPU3FUJNJIhNvV9GJMeZ69rwzGyxLT3RT+OGU9KU/4TMCmspObIFtgEBGWFRSNjSuYP7F
 f5bI/IpmhMsiFu2V4Nz5kgIVl/bF55eoylVb79zBjXd+JxxUBRf5GIKUSeodBYN5FCGpQS80W4Bh2h
 POd0+GojKcV059dYoybl8ufZOpA6oHaBU4uWCr6arQ4Y5e5TOohbXTwvhCNA==
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
 drivers/usb/typec/mux/nb7vpq904m.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index 569f1162ee2e..b57b6c9c40fe 100644
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
@@ -413,9 +422,16 @@ static int nb7vpq904m_probe(struct i2c_client *client)
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
-		goto err_switch_put;
+		goto err_mux_put;
 
 	ret = regulator_enable(nb7->vcc_supply);
 	if (ret)
@@ -458,6 +474,9 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 	gpiod_set_value(nb7->enable_gpio, 0);
 	regulator_disable(nb7->vcc_supply);
 
+err_mux_put:
+	typec_mux_put(nb7->typec_mux);
+
 err_switch_put:
 	typec_switch_put(nb7->typec_switch);
 
@@ -475,6 +494,7 @@ static void nb7vpq904m_remove(struct i2c_client *client)
 
 	regulator_disable(nb7->vcc_supply);
 
+	typec_mux_put(nb7->typec_mux);
 	typec_switch_put(nb7->typec_switch);
 }
 

-- 
2.34.1


