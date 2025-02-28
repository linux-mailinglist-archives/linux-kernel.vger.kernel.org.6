Return-Path: <linux-kernel+bounces-537751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C8A4902B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79C41883006
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218391B87EF;
	Fri, 28 Feb 2025 04:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuAbZVtm"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296F1B6CE8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716062; cv=none; b=MldcmrqHLGsqQ190dU8L/MT/23N4c+7OIz1Jpq4k1pdVLn7hSQ5aFyIep99N5AwQDP7GfPYkpLsVjJeK4fK7MuMHp1nhaxz/KKBhtExx5b6Gmz+BCKe54j7UlX515ta+1pBe+wIDt5bnwgc0qWf4fHY9mSnzy7taSlwPa6eHR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716062; c=relaxed/simple;
	bh=hfgy9wzGA5Q6AEJ70BD9uWOFMy1Prwe8QkTd0ByFtoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EaUeR86nau24pvgl/lhmChOfndDRIUWJDLds5qRqDZEgxEHRoVKjXVibPZE6XtfsG5AK4BPYCj1ww9snvXi/nKafyoP5UYBoUTlMTYTPVVLvDTmJFtenbv2Uig9RKi/vJWbkS6wmqLWmIn5Bn/cCJ5JvLUNAZuL8pxGhsitas60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vuAbZVtm; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso18109521fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740716058; x=1741320858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLWgX9Jq7cWL0p5yKqN9Wo4wrXfetoQdLwdK7I3i/GY=;
        b=vuAbZVtm1DmAlmyCKom7ExUNXrZ/AHc+TWqBaQSKjWEPD7ynnKEVEq4M3qMDwvEj4k
         GFCIGK3qqdFzrudr9xVYi7PwRtMGviZGHZTr7gxTtKucigaQgJ/XOER/5KklgogAf5Ep
         SHnynRK/WCoveY3QpbB0DP3+QKCVTGg/pwNecB8VqAZbCvqN9aydJF34KIk1Y2I2PMst
         3rHflDmyPBaM4BlBgWk+PbwN4LlO1seKiWhhQWqN5TcvtNLe9OSkg8c9QA4VLQLkZ5T/
         e/WtGeBHAT3svKkLyRjodxtxaTbFj2ccpclt8/cLmVZTnO9m1BcOxYlPlsXDpFJWPqx7
         Wp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716058; x=1741320858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLWgX9Jq7cWL0p5yKqN9Wo4wrXfetoQdLwdK7I3i/GY=;
        b=XhdZstD6c/sWrwxljmCeV8KtXQEeyuTFnaMh2X0m8wmSuXEfiemrFlOpWpPvamdVlB
         pK6WWr/5IdBujjJY2xVMLZESSttao21aP0M29gbx67qNtbeibSWegXzjgPXM5UAAlHE4
         creR6YQ7M3ygEAStjgHd6UIQEnCfhb4UY2w4TtUlZAcKANlhYR0u7pDi9M4ssZY27tB5
         nGf9M56+JWErxybXWBmFlJz0U3MOzk3ecA/x983Qwn8lMYX8fu5mPHsuO0Duhwk27Gw+
         xcUqZ4VfaCnQbdcHR8YDrGNg8BAsRAgQgKMUek2w0LVgvZn1hKnZOyn+9wcbYK8KXsoS
         utEw==
X-Forwarded-Encrypted: i=1; AJvYcCXsyeycmZxuqeFEVTifbGY+VdrvZC4P92AVX63Q+uEcdkUc8RuJtpG44Q8VpJFEFU1nbnGxXC+7jwS4KF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsz9bHH0wOaNNY+29NUF91xEEGCwSS6hwSSrzpWXdSwkXJ41U
	5yY/dZUa6hxMKNup1IyyRhDqskcLTFVVEaYEtQwkqtVOYVjYBeUtdiNvebef6OQS7Xra47sZil9
	imW0=
X-Gm-Gg: ASbGncupzPlEKfWU2KKxK77QutbOqa8W/2QajaTvf+8cdX/79l1slXgy2x8au9Y9rGm
	onKDkbNS1rn2K8miX4U0wXk4KXRnxid4Z3Ai1Nnk9ODXFCrjAqQmvyjzNKzhXHzvd14R+iTUI9N
	8sVsF1IxX93+W4mwfbV63+BCQviAyhTrG0VVKHAjXdYzXCPcU/ZfH5fwZMQO6w6h14EImPmAjKz
	s2yEclH6jQvSQsHjQsBl2px161uXHA2QQ5V0GIx/c1zf43hRTb8aJ5A00V+WPYXoULddKlW1yxe
	yJWE73C5+Yfyn01fS9V09RF18N1N/bwDiw==
X-Google-Smtp-Source: AGHT+IFcT7s4yVONTyYgY6zAKsU9+9abRufWWlIMfQD+nj7E9gZmr9mDgSCmtquQiPUvpSCt6Cmr3g==
X-Received: by 2002:a05:6512:2827:b0:545:ece:82da with SMTP id 2adb3069b0e04-5494c12a0a2mr667916e87.4.1740716057671;
        Thu, 27 Feb 2025 20:14:17 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441262b9sm361101e87.0.2025.02.27.20.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:14:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 06:14:07 +0200
Subject: [PATCH v2 3/8] drm/msm/dpu: pass master interface to CTL
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-active-ctl-v2-3-9a9df2ee5193@linaro.org>
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
In-Reply-To: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=hfgy9wzGA5Q6AEJ70BD9uWOFMy1Prwe8QkTd0ByFtoY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwTgO7AzfWXjKQ6q1tuTp6RHJgAal/Up8SzZqq
 QYw2I3uvDyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8E4DgAKCRCLPIo+Aiko
 1amBB/9ISmNQ/7w5UzOXxtpKcafpK0NDzRl2xZa+xPfU3WIIyQBQl7XQ1mExWV4yT53OzNbW3fl
 UjmLXTMkn815GuemnTmkSAoWOK+9irdUboUHmSwwN1TxDscP+OemA/gvyh5QDjOVL1sYu67hisQ
 BKiTgTwO3g4PvPdjW6KTjxzind9WLQzplTYYXLi7gHkfCDqtHFf0PHcWo7dyaFXjCa6yoOtBK0z
 jIsfNBrMS1d+SYmcjKvdZOAdNx80K1m/CNymtdTl16BY/6jzvCB8cpTn3QuS4ZKGNXQUfUsI0cV
 LcGdSKR7/kwjufT9P3MgiRqzFGDZ/a/jqOTmWnTbEJm7HYYw
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Active controls require setup of the master interface. Pass the selected
interface to CTL configuration.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index da9994a79ca293ec0265680c438835742102db2a..a0ba55ab3c894c200225fe48ec6214ae4135d059 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -60,6 +60,8 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 		return;
 
 	intf_cfg.intf = phys_enc->hw_intf->idx;
+	if (phys_enc->split_role == ENC_ROLE_MASTER)
+		intf_cfg.intf_master = phys_enc->hw_intf->idx;
 	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_CMD;
 	intf_cfg.stream_sel = cmd_enc->stream_sel;
 	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index abd6600046cb3a91bf88ca240fd9b9c306b0ea2e..232055473ba55998b79dd2e8c752c129bbffbff4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -298,6 +298,8 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
 	if (phys_enc->hw_cdm)
 		intf_cfg.cdm = phys_enc->hw_cdm->idx;
 	intf_cfg.intf = phys_enc->hw_intf->idx;
+	if (phys_enc->split_role == ENC_ROLE_MASTER)
+		intf_cfg.intf_master = phys_enc->hw_intf->idx;
 	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_VID;
 	intf_cfg.stream_sel = 0; /* Don't care value for video mode */
 	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);

-- 
2.39.5


