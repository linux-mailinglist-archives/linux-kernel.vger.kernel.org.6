Return-Path: <linux-kernel+bounces-523423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203BA3D69C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CCF179759
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268671F0E4A;
	Thu, 20 Feb 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Emu/dR3M"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E81F37BC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047195; cv=none; b=CgyZ9JJSAq6AmnmqyD6c9q3+F26TJwNqQn0sLGvkrUPbKQygiJZBSBoRU5fuhG5LtwOfEzKTuxWDps+kWD2MlwI2j/AAJ7zuo8s9SljrNhjXDLq3Y6Qv7XV4SvTgW+z2fs5V+uYjiOh6SlzVZYObUSMzddQKi+cb1OpBvBvP3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047195; c=relaxed/simple;
	bh=Mj6W/g1cQTXrPDSCV2G/UAnCYQZDcnBUJoxZDb1VnZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLQTxdawLh9qtu0fxoMkFHGfCtjuJMcRdgtoI98JJFmiMNNtuyMRpD41K6Frd1NToEsmmRXFogM3wfcl9x4GLCo3Dsf5Eo1wKGNVEgzV9SsWnASadSbuWm2mRrRmPbBs6UYAYI9wXMubOR4OVu0cifKWU2fVWwvkcYQyejRi9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Emu/dR3M; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5452c2805bcso907493e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740047191; x=1740651991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3V4xBbQpvjplr+11vPrizjbtJxjqV5/lKZ5s7afZXk=;
        b=Emu/dR3Ms+30bqAlriqNt6uiFlb2cIJEZT465faxUXmi5fifRKF3Uk0yBOZCHllBKt
         eeqUHdPOtCrZoEfiadbIeeKRXqQ4FcSUpNA7Nm6zbSCvHntOyAbnHEgQ+dVMFHTfGxM1
         y01VDML+fOHrTT6ZcZ5kZrj7eaD9MzpVNegVfHYvbjGPmt47koLRkyFH+o2/4UFci0eX
         3WBTJMgT1HYnY756eoM3NzSkxfZxxSKXrHw/h96l9g6qRKzfPkr+/BqektBXNZ2sJCCE
         QfuhI/HTa3zcV+EjycEe0j69i04fb9uGqctJ33yN5S03GGMcBX5t7UmO6o6YMQx8OLcw
         By1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047192; x=1740651992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3V4xBbQpvjplr+11vPrizjbtJxjqV5/lKZ5s7afZXk=;
        b=RXW9YL33GfwLrhHjJTj/zuAEosdNzqwb438NI8X+P96RHwobaJrpfKd8lq0NlMUQVa
         Au/kgf18+zDMZK+AVxNcwPK2UJC1rMvozgDyr61gpQMaesDYD391pUHUi94KXk1OnQZ/
         fn9KH7wBg8sQq53fAXuSFs/FMZHwf9EDd5+Hhf8wcT0/wXiEnV87u66tvYsWPAtp2HTF
         y7ymakI6CMl43MT4l5n4m/MIRt+nVECQmdC1z478gN0mgsaC+IRJNUMoMJEE+AW2U2+m
         02N6DkQrxbAAjSmtqnEqEwfwpjDVrgTKE2FRENiC5UAN0D77N5Il6H4pgYfA7tfOlsf4
         ssng==
X-Forwarded-Encrypted: i=1; AJvYcCXEhgjU2tCzTYeogQVe+rZmgDDLhhs35/0SuTVMCoQhn6JeMe0qgc9e95ibhg0+W2tqreVf2AsjWip4IFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/mmuDDZLv8vzfN73ePOOJDeEpqhy5xPRaeRHOaXCumIGWauN
	tzAmGyKp+fg43m7wf2AjyKFd+5BQiR1JAGaWcEtsrjDrsMxjVd2Nl5IowkKoTBM=
X-Gm-Gg: ASbGncvbi/boshr/SM3Knb0QAn8b0vMs42/7lMOukfLdxuF//DgJd/MVf7vRb3u2oaD
	iTyj9ggonLIZBmZ8/9/J0eUMnd64jDLMlyEI3GKws5oIA50bq+cOm2zTscfp8JLA3Z056XQ09Y8
	NdEPcabpjt7OzcAP8FIG9UiokfPGY66vfBRsiq+/HxMx+AfV9+Pjl0cWxI9TlqCi2CSb2bQltNb
	QQuOgHCHXJ9qgZmjoiWy2latiGVkycMw4HuW3JJlnzXrZec62otkmObilgHZbQNHgGv6dOJRTp3
	0AMuG4vqtanNviRBytPKY/I=
X-Google-Smtp-Source: AGHT+IFT7l/AtVtBLArk2SRlJ/wJq5MyR0YALvIDoLeckr+vIWmad/Qo311RAVJkfTcP2k498cUn/A==
X-Received: by 2002:a05:6512:eaa:b0:545:c9d:ef26 with SMTP id 2adb3069b0e04-5452fea5da8mr7575910e87.46.1740047191589;
        Thu, 20 Feb 2025 02:26:31 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545e939224esm1588052e87.135.2025.02.20.02.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:26:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 12:26:22 +0200
Subject: [PATCH 5/7] drm/msm/dpu: don't select single flush for active CTL
 blocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-active-ctl-v1-5-71ca67a564f8@linaro.org>
References: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
In-Reply-To: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Mj6W/g1cQTXrPDSCV2G/UAnCYQZDcnBUJoxZDb1VnZ4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntwNLSoDCJhBaYmL2ldFx0C1L91FbiV3nkagNu
 zV9tG1YFlWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cDSwAKCRCLPIo+Aiko
 1Xl+CACrEnvEy3oMgM9VlWjdwvKg0hXcZYrjUorlyeRUYERUk9dlZKLpH1zwax5tK0rUBc6Eq47
 A3Jpti5ik0g9bLxSisjpAwlNEgK+js56CDJ/++RgzCxWtZNligajW7lTnYDiWekbR1DngK1HBLU
 RZtrlTc9BE62ycVDxN9iwpfzyZKNi7Odk6UAgnA1RPb9l/WBnh5bAqytMKywl70PCuDC7N6XkvH
 kKQhlVaF5U+ZYU8lYwds1aI8QQlXAQ6JtpeoubML+TUyeONzeyyJICJcLrS6Dqhec64HUfPnuGi
 TPufr0KlKKM4eweQwpOnN2F7QE5k4Qt3bfsUPj5sfEzj9JkU
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In case of ACTIVE CTLs, a single CTL is being used for flushing all INTF
blocks. Don't skip programming the CTL on those targets.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 232055473ba55998b79dd2e8c752c129bbffbff4..8a618841e3ea89acfe4a42d48319a6c54a1b3495 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -374,7 +374,8 @@ static void dpu_encoder_phys_vid_underrun_irq(void *arg)
 static bool dpu_encoder_phys_vid_needs_single_flush(
 		struct dpu_encoder_phys *phys_enc)
 {
-	return phys_enc->split_role != ENC_ROLE_SOLO;
+	return !(phys_enc->hw_ctl->caps->features & BIT(DPU_CTL_ACTIVE_CFG)) &&
+		phys_enc->split_role != ENC_ROLE_SOLO;
 }
 
 static void dpu_encoder_phys_vid_atomic_mode_set(

-- 
2.39.5


