Return-Path: <linux-kernel+bounces-372495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025899A4942
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3116A1C22255
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA819259B;
	Fri, 18 Oct 2024 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yd/YXxuP"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327771922D7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288174; cv=none; b=p7j7lQc9upPO2OzgiyxLuiSTl1sp52iksxQ6VU5NrC5Bhg7/SIvf1GWP1iuudVXjFmEFok8UPs1yJZav/ET21pxfnE0dLM1en5Uc+mdMj5oGyJKHf9gkRm81QsXsn9N8W67IoH6VDoD5MOFVDJt3wMKbyHrywR+kyEVDZ7MqX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288174; c=relaxed/simple;
	bh=vSGIECGW576rwJsHdegRSgB/e6dJJG1yWk4yZ40815g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUqv5rgOiW8PKbb+ZkykBdfSQsYLs9pKO2OiQ5xbJ+eydcQsPvQeBtYjKu6D3+BOcySH3X1VoijoqU/qipeT6BxdVYGZDl+cFDmoBpZsiW2sXVwOyBp2VTSjJ7H/ih2Sh3IDPoic/3RGO6RXn16Vs9nsIwKoZtoIWKuJFCG1DAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yd/YXxuP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f53973fdso2023285e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729288170; x=1729892970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3JlxuYLRvmuBAe/hXPotObPdIzfa3RGXwRrg41qHxk=;
        b=Yd/YXxuPOQ+3iEyOq4s/1Gm6SITS92wWoCmxx/5YUQWTfNdaD7tgYxZbxjkYhQ1BtO
         v5ZtT3rg6+uZ241s8+V7l/08z3A41jnoh+aCUQ5BkxswlYXRSwV4NvCOnCa08PEEEcA5
         JYdigYoM3gNDl1Ezfml+omq02HSrwukr6y328YEmAKiF0yAZPwiYYn0Q+2KaJSERHJru
         W1kePEhZfzMVE2JX66CQzSodku2Bg1Vd/E0xp6cykgT8PcpPD+6IkztIJTO1Nxc9JLTP
         CdImUIlVd8f7nrHR0RkADmc0G9heLwS0K/1q1AFJOPOgde8uy8xlOSxuQCvRE0bkn8lX
         jk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729288170; x=1729892970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3JlxuYLRvmuBAe/hXPotObPdIzfa3RGXwRrg41qHxk=;
        b=RcdB1R1LH9QBecv9ESnTcWfcySkXW9qhc7DkXJ54p6K61rME3RtXhTn67e0Bx7i8dw
         Evan+J/lilGllA5oOuDGEtb/qGTA0hsb76vUlpgWbDZBrLvT1Vz2ptZSN6rZiCrDJqk5
         5VuSuF2VxZQWaRiJgbEPlXesMRnLxAABwshTUl0XmM6rgrvwJ4ISkBJdR7wfe/7wfbf9
         bSxFzDbqRe0UKsO1pyf6Zbo87cQ99g+pVRtn/8tfkLlxclT1exvQ32N0DjBm5aNrolmS
         uxKmD9RGQ3PaYDiBGUPCEc4WW1+ymL6Caue+madH5LKRD82NnWCQALmXj4y1sH8H8k2e
         cLmg==
X-Forwarded-Encrypted: i=1; AJvYcCWywpYTsOY6PhIOvrO4HA6CrSypM2+Bhy7RohhQFGtjqChvl4xXgCaIpuuiSVeS9vLtoFSjgVQQ6mdu4Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwllvOC5V1PDXfReEVQ+cg+0tCkVPYojnH5OJMlUroRqI2nvGGo
	fS9K1RvXwL0ot0dRt/wIrqllAyvrdaspvn7+ve1Qb400pJGpFwXDOB2BP3wcl2o=
X-Google-Smtp-Source: AGHT+IHnKKr9DRlmVgrVc32PqUJ1XzjQFynXLr6N7p9iMEp4ytq6PRLtyD5ZxAK9ZZhPA+gqE3INBw==
X-Received: by 2002:a05:6512:3f12:b0:53a:41a:69bb with SMTP id 2adb3069b0e04-53a15b995c1mr1118216e87.28.1729288170302;
        Fri, 18 Oct 2024 14:49:30 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0ce5sm332088e87.181.2024.10.18.14.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:49:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 19 Oct 2024 00:49:17 +0300
Subject: [PATCH 6/6] drm/bridge: dw-hdmi: set bridge's ycbcr_420_allowed
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-bridge-yuv420-v1-6-d74efac9e4e6@linaro.org>
References: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
In-Reply-To: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=956;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=vSGIECGW576rwJsHdegRSgB/e6dJJG1yWk4yZ40815g=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7rQ9Xve2779/pDOty7EYZXSyS8qsUqzJ364anNd+p/J8
 axaczmmTkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMhFmQg6FNq7pWwjTa9/oz
 WwuPtULRWf7X2PdL+6+8e0tGRqG5R2r53MZrAjmrDb9tnWobqfHvwV3Gjhvqc1+sWT+x861LHd+
 ClVqcwj7lJZ8V+eR8VjbqCh4IzX0iXf90n0Ivr3x7ofi3pofPvr6VXbVcKp+l5IJueQa/9oOCD9
 /uXLlVfzNo6iaBwwUfrZI02pvOXz+e3v5v+673Idzia9prJ1QXdHxIK66sduHjulG9cU3ylzrLu
 /N3Wz6ezTMj0s9N6wTjufBcB/uDM28wl4l8ltwl0Jma+Tg03VzAeMLx7BwRhdf8QueFZ90Wu3Ar
 Pj41i/2RqZC/m+sz/wfVr58X+X18xFzvyvPm6M6g5aHlAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Set the drm_bridge's ycbcr_420_allowed flag if the YCbCr 420 output is
supported by the hardware.

Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0031f3c54882..996733ed2c00 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3503,6 +3503,9 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 
+	if (hdmi->version >= 0x200a)
+		hdmi->bridge.ycbcr_420_allowed = plat_data->ycbcr_420_allowed;
+
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
 	pdevinfo.id = PLATFORM_DEVID_AUTO;

-- 
2.39.5


