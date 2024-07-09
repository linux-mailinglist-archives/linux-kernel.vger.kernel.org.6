Return-Path: <linux-kernel+bounces-245951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBFD92BBC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE78F1C223DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65109184123;
	Tue,  9 Jul 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zr76ttDD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699817F4EB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532915; cv=none; b=ChFGNaFMTYMH5oTne8jy8Yhdjc+ggjAqe6+VnoOkJeASs5toHEkJP0EH/U49lPdWgDxLapL9kDQrEIWYapZIHq/iLy9r2LW/8DXZ15JGq2ee11XvxyQCDWGOuIQadwOpod7u6Lhf10zBcZmgofvwx2FXlwK4J31u1z+zwjMX58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532915; c=relaxed/simple;
	bh=+E5EN258CmnPr6iL8KBqJO5+7w/22exHf4+Ix8HRjHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7qnvgtww/m/9g0VqZzWuQfdyWMzOZ+rqjhrKuTMUE/rFEEYLxvJVoA0NFeB9Y+vvm1yQsIDgGBNlrM0QfZlk8lne7Nc+B3ocsCZSdu9TMbud328bA/KFRH79iiCf6l17DC9llGFdmSEPPf30bAlrmJigrpWw5ZjELLY9YEPXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zr76ttDD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea952ce70so3337771e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720532908; x=1721137708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3rqoSXZHGMGmxvjGDiiPCjvj8LcgIFTaqvOfNwnFjg=;
        b=Zr76ttDDfeHuwdLf4kUX12C25hkYo9VmC+JC6hoIo0Hqb2dmWEIpIfLY3iv3xBOm7l
         v63Ppl40wIVSI1KdPnH3+4skV8BKeXfiB5BHhwHAKbxeuaCN36xz/VIuaRc1AHt1Vgs2
         AIAc1KjZQUVqLhC5mJ4ddxAz0CwwWjiYOYhyDTrXC3oXH381Q0h3rB7450cfjlzqm7E1
         358zqRTstBUtCipgtzvDmhM5xwo117eVVBT9HFz0IS2vTE/6Dv1VqAyVvyvakzxu0QS6
         vpiMJ3BQE7wIct+9R8R3Hi2vPqXykYRCw2ZmM+qz1DN1OUzS9Ym5/hPzVHSjCRul9pgu
         aYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532908; x=1721137708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3rqoSXZHGMGmxvjGDiiPCjvj8LcgIFTaqvOfNwnFjg=;
        b=KXTxiVYO4D+PvT6w6FxWF9WFZw4voqDv1z4i4TxV1kgdeNp+ISHMq3D9FR3hAS93HO
         6udomF2ivBTDFx0QYOqu9fMWKgW449RpI0ko/WPDGnyIMPXXp2Ot6y3PJmZZZnWBk6qX
         q+lSnRSO5J8qU+5GG71/8RL8mneb5yQp88xc7JAji/c0dot3K8C6zsPEacR450MNVUBO
         ZjBs/WPmLBZKCmk23GyK4/yUYUgE9N5hrtGoLbLSIseXG6+Nzil1ZAGSVf3lu7sf99DU
         1a4ndT44VvBMvgONNIOZTw/4AqcBwutxUiJS9tPhlnbBPbU7AtCnjrbefJEHP0z+1vz/
         trjg==
X-Forwarded-Encrypted: i=1; AJvYcCVRkOpYS1vkbhClHZc7a7G/Fw08SApM8N8IWIC6WfgFZ6ZslBrA8sQ6Pm65IqRyATtbfs9lQJY02eJQ1mfe4IZl/eaCW/z2F9jxhTbS
X-Gm-Message-State: AOJu0YwQ3hzcKuNSqE7dl7UT0KfkO8axgCQAchDS2Zvaruv3jr1AbGN/
	RVO2maXCjfHOKGKVI/wJ0XFJ9TV3UGE5jgbQs1mvHmGhyQChbYkEwJ/P16C5orY=
X-Google-Smtp-Source: AGHT+IEJOKC9CKr3gPG/ltR1Yag3QnJkvqhSLl98qea8/8qeL+x+wytN3L9Buqxyh3K51KaCWlt2Iw==
X-Received: by 2002:a05:6512:ea5:b0:52c:dbe6:f5f9 with SMTP id 2adb3069b0e04-52eb9990e79mr1811035e87.12.1720532907990;
        Tue, 09 Jul 2024 06:48:27 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e4959csm250297e87.82.2024.07.09.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 09 Jul 2024 16:48:22 +0300
Subject: [PATCH 1/2] drm/msm/dpu1: don't choke on disabling the writeback
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-dpu-fix-wb-v1-1-448348bfd4cb@linaro.org>
References: <20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org>
In-Reply-To: <20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jordan Crouse <jordan@cosmicpenguin.net>, 
 Chandan Uddaraju <chandanu@codeaurora.org>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
 Archit Taneja <architt@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org, 
 Leonard Lausen <leonard@lausen.nl>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+E5EN258CmnPr6iL8KBqJO5+7w/22exHf4+Ix8HRjHU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmjT+ot0Pj4iBt23/EIWWepNxdc5knallwOTMKB
 koOGNPvKYCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZo0/qAAKCRCLPIo+Aiko
 1QKrCACjWqffsbS74ss5192ue6vxtSpLZimoCu02BjWnVbJm7yBYjEdISlCFKotHf0tVu/dW71C
 WhQy92Bej8KFlfXpBgnE/GvMqMDyQN7azFM/rcRWqJl/nKSbia/Fw5sKXHmNAQonGSBXEZWF0WP
 V7HsgrG016SbytVD0wPJiZaY/HfWxWsn8qZgpS1m4PRrNnPt0cM6JOF9WLaZLs27utpEm6yDD8X
 uPv2DI1F+EcsA+UQPo3hBTZnJv+GnghVf2SQqatQT64R/lPa+S+Uza7IbvvYpQcrrdf/rHB4dR7
 IJcfpheofCTjzvSWLvpf7s2AX5bmdzxZG2fv60b6kEFW0n+m
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In order to prevent any errors on connector being disabled, move the
state->crtc check upfront. This should fix the issues during suspend
when the writeback connector gets forcebly disabled.

Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu_writeback.c")
Cc: stable@vger.kernel.org
Reported-by: Leonard Lausen <leonard@lausen.nl>
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/57
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 16f144cbc0c9..5c172bcf3419 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -39,6 +39,13 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 
 	DPU_DEBUG("[atomic_check:%d]\n", connector->base.id);
 
+	crtc = conn_state->crtc;
+	if (!crtc)
+		return 0;
+
+	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
+		return 0;
+
 	if (!conn_state || !conn_state->connector) {
 		DPU_ERROR("invalid connector state\n");
 		return -EINVAL;
@@ -47,13 +54,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 		return -EINVAL;
 	}
 
-	crtc = conn_state->crtc;
-	if (!crtc)
-		return 0;
-
-	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
-		return 0;
-
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
 	if (IS_ERR(crtc_state))
 		return PTR_ERR(crtc_state);

-- 
2.39.2


