Return-Path: <linux-kernel+bounces-410668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DCF9CDEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E52D1F21148
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC41BD017;
	Fri, 15 Nov 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gK6MerwE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63C2AE77
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675328; cv=none; b=MulFFGGtHT7D6MVEy6ykQ3wK4U5YNNltGGlIPJXlE1ZER0NPZIrmTvfr9JDFHetzh2D7JUfaNRQCPNanT+PPgYLr+kVWmQLFLh0JABUkttuhHyp9sGYDWWVNreIbx+Q3z5KbFYepkVDKGi8LkDsAkdbSmy9KlYrVCmS1cRvVVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675328; c=relaxed/simple;
	bh=CCI27rlvVRosezWzuY/2E3AP29V/IuLh6N24eCBmC9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g2Yn0qBV9ZvVT1abtiSV2Evxu3Xy7zLrqi0fkvKNAm1heSy5lQxPTwo4qlBFUwC2mOjfSNXOgsTPSn/pkom0bp2o/aDugsViuui2FwxrDDPvwUz8+4cityL6PhRbgZQsCPXJVq/ICkKif3VXxoLIBrsST0gPJK59WW0Q0wpUmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gK6MerwE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d866f70fso14770925e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731675324; x=1732280124; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZze3yn24TXviwcT7N4kjvraoXCM6pscw+3oqLD8HvY=;
        b=gK6MerwEa/Cg/PTunyjr5GbAvw7A4y2cLBGlWTaykMNTpwYkDLbdMytxaf2sR9YRKh
         d8IPKQtZT6WgAIvAZb+LAbFdWmm6WKWWqR8UvDJYvmpzBfVNubsMpf10shFQSQG/7VOj
         BAyC99VVGMW6S7Fc1dPD8sJTrcmAGyXgMzd6UBJpLkra4A4TjInU8AZeM3f2DOwkuc1w
         Q/fTaoNuvdz2GkSm7LmPtyu6U4RmBBot4T9n99I9hRkYtSQk0gQgYkb7Y41T8m2caulj
         Vf0W+LJUsbbFyqrnJwz5QCVJrV/IpfjCiaX3kYBtxBXIMQ5dyFI3b30Gs478yQGXyjMI
         SiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675324; x=1732280124;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZze3yn24TXviwcT7N4kjvraoXCM6pscw+3oqLD8HvY=;
        b=wMj1y4is9DB/WNBEQQdzFpRZQ+V1AZrmN3ClJGADdnqS8FGoFXFKunfLZ0vmrnX9d/
         AJp1Up+vX/EeJuXXv3iMWwsYG28q+xcumYOv6LGC6YFxu0YH0X5zLADUZWWoHlbNCmvv
         vm9eXi0ZGcYxxahT6rG0ioGvePTkjCPF+QJtPzK8S4T1Hgk0DyL9sfeSZNxGQ3bo3cFh
         m9lztl1DYGL5Tf1Ldaw7wvRSxbNG2+5cFGtVSXlaywLWf26STJamdiIkUJDPJqiI4VLH
         g/aSzX3/vPF7TIA+IOWlo/FGJ2AVpZmzRDudOc7OqEXayIcwyGDNr9ItJEhqzYduVuRV
         W6QA==
X-Forwarded-Encrypted: i=1; AJvYcCX2JjPPrL7mMHJ7jsC2rEY41296JqV1atmtZcMysHyfhmeMIQh8ZTBNiuNVBgSo0EzHlpHOeGS3wmEpzxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQysA8aWR5utK+FLbAc60AfAWJjkgOd18Lk8SO+Tt/tEK73EsA
	MweQwGn9bUZAFGCCWsZO6d2MtSfmImaK+QHU6TWFaMqMdtfiKgrCuA+LtKGnZFA=
X-Google-Smtp-Source: AGHT+IFCxeXdFwVvRfx+K9CW5GOw9LM/hVZhe41k/tOelfCV9iTkGBsMWti9JMRBfFAiS/C37CDtfA==
X-Received: by 2002:a05:6000:70e:b0:37d:492c:4f54 with SMTP id ffacd0b85a97d-3822590b9aemr1876457f8f.3.1731675324056;
        Fri, 15 Nov 2024 04:55:24 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:f4fb:dc44:5c32:eaef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae31083sm4285582f8f.103.2024.11.15.04.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:55:23 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 15 Nov 2024 13:55:13 +0100
Subject: [PATCH] drm/msm/dpu: fix x1e80100 intf_6 underrun/vsync interrupt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-x1e80100-dp2-fix-v1-1-727b9fe6f390@linaro.org>
X-B4-Tracking: v=1; b=H4sIALBEN2cC/x2MQQqAIBAAvyJ7bsGViuor0cF0q71YKIQg/j3pO
 AMzBRJH4QSLKhD5lSR3aECdAnfZcDKKbwxGm56IBszEkyat0T8GD8m4807Gjd5ZN0PLnshN/8t
 1q/UD7WkMTGIAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

The IRQ indexes for the intf_6 underrun/vsync interrupts are swapped.
DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16) is the actual underrun interrupt and
DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17) is the vsync interrupt.

This causes timeout errors when using the DP2 controller, e.g.
  [dpu error]enc37 frame done timeout
  *ERROR* irq timeout id=37, intf_mode=INTF_MODE_VIDEO intf=6 wb=-1, pp=2, intr=0
  *ERROR* wait disable failed: id:37 intf:6 ret:-110

Correct them to fix these errors and make DP2 work properly.

Cc: stable@vger.kernel.org
Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index a3e60ac70689..d61895bb396f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -389,8 +389,8 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_2,
 		.prog_fetch_lines_worst_case = 24,
-		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
-		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
 	}, {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,

---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241115-x1e80100-dp2-fix-beb12c6dcac9

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


