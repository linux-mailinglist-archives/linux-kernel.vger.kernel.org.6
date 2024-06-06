Return-Path: <linux-kernel+bounces-204326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE08FE744
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658DB287B55
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA9196436;
	Thu,  6 Jun 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7GHoHE+"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB78195F16
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679482; cv=none; b=X8ftm382cWZ5Fr0jgaVsthT5AZe1Z5H0UdR8Echzwe+evfjEOkQH1/7wM0UgHkifZiHiQ3OUaryzdWPJJQm1YSziLBI+9uFKXGIePnBHFqiC3CSRqaqAhgzj66fvGaIvzVPLYxMtHObQ689VCbr6hfxKutnt6G7ID12vLVJvFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679482; c=relaxed/simple;
	bh=tcdhakkg0NX4qYXx1dNiTJsUi801Kl1wRMPLSMJoGWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=coLurC94yUOIC7f7CH5H41mUH1tqtTF9x1v22v9HKXiWxHLdoSXp7AIJuPKplpXc8GwuuPGy5nKKwbdUrvFey7/xO7sZe3Kw+LJ7w688JupiOXctFo5Zoh3bNYeS9Wvd+5kafdmCHraRF78YXE2NvP2gTmrO308fY3tqrZFGoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7GHoHE+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dcd34a69bso967670f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679478; x=1718284278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaajZ883EdN6Sp1qsHSz8AVaEsngk8mZSxxcU3V4u6U=;
        b=G7GHoHE++3MpYMVKxb6eyI2nQcQKqb4WRtpvYutGbdzGt8WYrpNaySrV2+u/XytZCO
         VEwNGeSMoavn/5X4rOHtoa/1GFY9vRakeJLAU9BezfhRQdpsSPnLMqO0dLkJfDbnkumJ
         /WZKkekr9nIXW3gzQCz5CozMr4ryQC5BWJ406tsmm78bM5Vscz8LGQ8JxbK2Kp7RHOu2
         GUw1YxzrmCpqV79oIhRH2UYMIRqqMfrZMHPEC61a4c7tPhpBjmbTTZAL3rtsl0PDp21M
         GW91jyu1WeWI3kmMS+RZsvLVdgqJIRACE2cIlczbAYuJwIJUj+n8sMpz5WFamzmtJjIf
         D4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679478; x=1718284278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaajZ883EdN6Sp1qsHSz8AVaEsngk8mZSxxcU3V4u6U=;
        b=oH60S0iH8ChsJI14AGHszaEolHsN7TRj7bt7O5JC3gg0rLiKekXfWjO21LU4V5j8Is
         rCIjafgWJB2KGMmtnXcy/b+Oh+omi6dM+jIiwYXtgxhzx4wpDI/C2DUax5AaDGlwlANR
         lBa5s6cdghqDyPb35ZgTqJsbXddJavldN+rKeNtE8ByZ9VxBWNSdEZfJuiZKf16eCL36
         KM42HOf8XCF04L5vyIO4/rzVMJyHOo5WpejJwmgcDKVRnkr9SeEDL7iIb0u3wvGplcxu
         5UN/XsH5SnBXMMgocU1iZf6nCz9Ue6FSfRdbrgImhLQxaHTL9lah0hu0Pj9UIVpuFTKy
         2aBw==
X-Forwarded-Encrypted: i=1; AJvYcCVfqT+NPwXHucZdobQasWpYI7WnwX2FdwkREGz3QYcmCohO/W3Z3vqnXzkeyG0SKsQ8Qc0dS3PjD0pIQP6pnrSrIquXb0cDQfoQ1Blp
X-Gm-Message-State: AOJu0Yw+wgNDVBaEUDfPh1HOZrP+0OfYxQIM56UgVljpVo9t2LuupdKU
	HCSAEVLh5sHd3mm4OByYg6s3pO4/LiijSCegFZ6S+Ebhjtgjtgu14wTi7bzfmS2lYLkEtNsPF87
	a
X-Google-Smtp-Source: AGHT+IGMPYBLZ9Wo50vmXxzKX91v23RBp7dbXilVXIlrsWjw61Se+3s/X+8R0dG+Q1zNGrY8PntKkQ==
X-Received: by 2002:a5d:47a8:0:b0:35b:5ffd:9ad with SMTP id ffacd0b85a97d-35e8ef09964mr5020504f8f.41.1717679478518;
        Thu, 06 Jun 2024 06:11:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e96d8csm1536316f8f.68.2024.06.06.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:11:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 15:11:14 +0200
Subject: [PATCH v2 2/4] usb: typec-mux: nb7vpq904m: unregister typec switch
 on probe error and remove
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-2-c6f6eae479c3@linaro.org>
References: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-0-c6f6eae479c3@linaro.org>
In-Reply-To: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-0-c6f6eae479c3@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tcdhakkg0NX4qYXx1dNiTJsUi801Kl1wRMPLSMJoGWw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYbVyeiLv+WTK1IY9m4XWaI7kppF3M8JMgUcMa6b3
 QtzUQT+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmG1cgAKCRB33NvayMhJ0WcYD/
 4sSsizPLW2EUtIlkiqcXMuWhLCU20OJYh6YSMCqZItrNCryIETZsPwyH1QUu/W6Y3+x1MHbOKef1CF
 Md6s0jPf0wu3c/tc2kTQiKZlaW220WAddM3jIsCcTwL+K7wUI27NINHDNK4E9yb4PDwFyo4cyssmx1
 Z0v8xtzaSscXV+6rH+G9T5TA7LMpvaQr/3QZP4hWpRhpKQCSSXWPPe2QqW3CwSV573gu4qmfgEQyWS
 LZJc7qmATZnrtffdMLezlfk5qD2jPUQSjw0knkw7yL+8m0yAiGmlf+E5TYW0Ql2WNbR4NYInzE4c9d
 /jeChGx7U+hNUCGHIA6hZymIXWCFRAIhOK/uW3Q5fLSSJESTHqVMYKfGzWcpn02e9wRnVHFJgrZ8yW
 gr/KS0SAtszf+CRV2re/hcQV2bdXAAzM1VP2nNaOxTEFNb/OrVbHw0JGS/kHPTPo8RDmI3RsxJ5nvQ
 h62YBa78liCilCxpiwzNCYNus4W926NwGJtOoUgQLFHetJoSMSqS44ALifSzT88NeYiiQhZveWH4SG
 s0LtqCkJg2COaeUc2pIfrNbo61PR89igmsv44pD8FZwSC9OY9inmvHh+dXSdwqK8E/Y+e0WVCp9Em1
 qkN3BSqXMupgsseHozHKOFF0/gj+f07nJQoViP6tf41Eq+244q73k/B9vTFw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the missing call to typec_switch_put() when probe fails and
the nb7vpq904m_remove() call is called.

Fixes: 348359e7c232 ("usb: typec: nb7vpq904m: Add an error handling path in nb7vpq904m_probe()")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/mux/nb7vpq904m.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index ed93194b16cf..569f1162ee2e 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -415,7 +415,7 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 
 	ret = nb7vpq904m_parse_data_lanes_mapping(nb7);
 	if (ret)
-		return ret;
+		goto err_switch_put;
 
 	ret = regulator_enable(nb7->vcc_supply);
 	if (ret)
@@ -458,6 +458,9 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 	gpiod_set_value(nb7->enable_gpio, 0);
 	regulator_disable(nb7->vcc_supply);
 
+err_switch_put:
+	typec_switch_put(nb7->typec_switch);
+
 	return ret;
 }
 
@@ -471,6 +474,8 @@ static void nb7vpq904m_remove(struct i2c_client *client)
 	gpiod_set_value(nb7->enable_gpio, 0);
 
 	regulator_disable(nb7->vcc_supply);
+
+	typec_switch_put(nb7->typec_switch);
 }
 
 static const struct i2c_device_id nb7vpq904m_table[] = {

-- 
2.34.1


