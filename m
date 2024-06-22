Return-Path: <linux-kernel+bounces-225869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639491368A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63DD1C21672
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B112BF01;
	Sat, 22 Jun 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGyJ3skb"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C7824A6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093747; cv=none; b=B7ad7zKJkUCutBnahfD/6SNCf2Ef1EgtDL6LAJmFWjs0BxW5vKknbLRvs26jQO8F77kuWMqNOqMLoNFuuJ/jM3k38Y4eVs/WhVjcWeV8iw91WhSrIEaOmd73tTVVJK4rQsMMEbgfFva6nVqDGKtR8/D3e0hrbITHosfALnsytGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093747; c=relaxed/simple;
	bh=QxzkmaQ0F6u3Vo6vT1cw2voI5Zf/br+EPvgD/mm50S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pij8ds9LxC+HrmjACOChm6gJh5At2o4bwk+5x+Rq9i46e9e+sGhOIk8JQhZBBgsJVhzJZZF8n5pnOje2BNebtWXsWy2igjGxzpvcjJS3iIrxXmxE3qRGEcr9/0XETGCAKK9n+OQl67My+mp5bqC8bS6uj24Z4KKwkcYxrfriv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KGyJ3skb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so35126841fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719093743; x=1719698543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtmbOfPaOUNb/xUduVMXDOuWoblMLauE6Af8hrHbRgE=;
        b=KGyJ3skbcOMnkv0+8rcbnFntPHhNjQ+wrwkSBvCQWz6rPkHXASzwemR7TZAyZPWcWg
         6yC1TcgYi47p2BMHJ86o5N/Ja/NKNtuvQ/UNrBTYJ7GZCLzHZ4HyHlOqBDQMHf1z2kiw
         VoTct5iquo51U75UYeZqeUJkBRzrDkGa5oVkCtrpdP6XxOA/UdPmAtXpj5XNW/bDaGpm
         0lOaOzCtbgN3dDyZ1c+iMTCXGoosUg9CUw+rkj55Z8eYtqKrIrOpSDERxO6OpYsvP30D
         vlRWydwK4LRQO8wIv+8ch3x8waSRo83R6Ti2XbRCCSFmtgBaqOINeTFnj0WuKDu/3Gde
         wjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719093743; x=1719698543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtmbOfPaOUNb/xUduVMXDOuWoblMLauE6Af8hrHbRgE=;
        b=nMwchhe2+OjKmeyxNGqhS6uANiTHho8IGOB8aZKGGX5/QquHGjMzJ12GFwgK+PV4uJ
         KVAoqZjwmzGEbC6ehwVzG2Lid46ZDqqZDTY++BMDOuex5bIUW61D+50sxRc470qxHYU6
         WIsM+Inj16uYzAGFq7sZ9CbHRcWSQgIu4d9BYgC0Xu+H+IKjIOSjGdTCn6h/P/BheyfY
         XoCszftNjbP18Vd2GIXCcEEvfMxqiQhdPfvPHNq+mYrGGw+qu4vQhE1pXrXNh+XFDUS6
         nmqeqw1+oAcj2KHMkfMLqXQ3oPWrASG8PSaVlLtsBmfa80p1fWxBIN31QHwOGzR2VZiU
         4oIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj+YxQ6bNWAe1CY+0Z+BEtHcz+TRtMao6lOQF6Ah7Y1gEqgJwQVfxFDSfJGUWaRsY2Oo5RH/kixE2KKAXb/tF7SFkyVW4GefopwKx+
X-Gm-Message-State: AOJu0YwljxbykCrTMjJChaTVIfysFA8BTQ8ZbFDUgwpac58V4FfLoP3q
	T+mJWbL/9szPCvWR/LOVdc9eXcmGg1smzyNVC9VVEKNzjZcIqOl08vY/XV6z8Cc=
X-Google-Smtp-Source: AGHT+IFwxLQa126PcNr0V293dyG07jdnFORLo0TrMcMkOvdVXZTtsEVGMDFPHgMRWJ3JGAyugxXTPQ==
X-Received: by 2002:a2e:730b:0:b0:2ec:5933:a624 with SMTP id 38308e7fff4ca-2ec5b38ac4amr4414821fa.25.1719093743672;
        Sat, 22 Jun 2024 15:02:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec55e56ea5sm2502051fa.112.2024.06.22.15.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 15:02:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 01:02:20 +0300
Subject: [PATCH v3 07/13] drm/msm/hdmi: add runtime PM calls to DDC
 transfer function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-fd-hdmi-hpd-v3-7-8645a64cbd63@linaro.org>
References: <20240623-fd-hdmi-hpd-v3-0-8645a64cbd63@linaro.org>
In-Reply-To: <20240623-fd-hdmi-hpd-v3-0-8645a64cbd63@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=QxzkmaQ0F6u3Vo6vT1cw2voI5Zf/br+EPvgD/mm50S8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd0npagDRaaHh/etYkVpsH1SbuurrBPWY5IUbT
 LQyDC7RbTSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZndJ6QAKCRCLPIo+Aiko
 1T0yCACmTbalmvI7VNRR8xt6vysRhyetuTY3yYoAhuQmrYq9Kc/rqU8+HkB7jRrjHNfAa7O7Vvq
 BQTnhAqZonSES2XQ2coTU0c7OjZ+p7/TaxqwbYZcSuzeJMArHsr8knx5Yl7B5ssga8SglXieMto
 CX/HoukjQfeVmqLolpBwbMbyG3JvXR+UJeYKAODnNdPm94Lg0Z8VoAZY3ksdXf8SNIFcaS1WMJh
 gDUmAo9WqNskxyMYujkhs/Q9fKGGYuAuRraeMnt7WmBjFuvKCa2IikDDTh+nI0UCfXbYRIT3zZI
 uxYEjV5LeNUUlpAhxEQiGOkD6DKwgRtUi9cY2V9y2kb9LDnb
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

We must be sure that the HDMI controller is powered on, while performing
the DDC transfer. Add corresponding runtime PM calls to
msm_hdmi_i2c_xfer().

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
index 7aa500d24240..ebefea4fb408 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
@@ -107,11 +107,15 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
 	if (num == 0)
 		return num;
 
+	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	if (ret)
+		return ret;
+
 	init_ddc(hdmi_i2c);
 
 	ret = ddc_clear_irq(hdmi_i2c);
 	if (ret)
-		return ret;
+		goto fail;
 
 	for (i = 0; i < num; i++) {
 		struct i2c_msg *p = &msgs[i];
@@ -169,7 +173,7 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
 				hdmi_read(hdmi, REG_HDMI_DDC_SW_STATUS),
 				hdmi_read(hdmi, REG_HDMI_DDC_HW_STATUS),
 				hdmi_read(hdmi, REG_HDMI_DDC_INT_CTRL));
-		return ret;
+		goto fail;
 	}
 
 	ddc_status = hdmi_read(hdmi, REG_HDMI_DDC_SW_STATUS);
@@ -202,7 +206,13 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
 		}
 	}
 
+	pm_runtime_put(&hdmi->pdev->dev);
+
 	return i;
+
+fail:
+	pm_runtime_put(&hdmi->pdev->dev);
+	return ret;
 }
 
 static u32 msm_hdmi_i2c_func(struct i2c_adapter *adapter)

-- 
2.39.2


