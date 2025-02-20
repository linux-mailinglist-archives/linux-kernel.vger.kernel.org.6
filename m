Return-Path: <linux-kernel+bounces-523420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD3A3D696
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EE41793EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992E81F1934;
	Thu, 20 Feb 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ceb5KgqF"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08E1F1313
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047189; cv=none; b=QSjHtfKoyIC1N69fWvjmA1djVpLnIqdAhEVykNzNPucpqLSf4gxpcntoAXW3MIblsfbvew03ZdUTizqIZ9L4xCOet3RjUkFpVtee4DW+WPrv7ZOxXgKAX6Ia7AUA9Fz5SuUogownb2xNiXoBr5QaTA31t1QxliTs0YtE1LJkNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047189; c=relaxed/simple;
	bh=Zeu2WMMg3KSN6/su6MRFquf4B/jwSUnZPPK7KQNFjVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V10eoqf/g2YE4FZKzMSfzLduYXs4aEkWDmzRWBMV01tU+nv+AAcxw4B6PWqf3MM+GtxT2zAyAr5iXqdZYBo5/r0hLQ8Na5m17APjB75yGQr+Opbc+d4oHpred774SHttUR8e+Y32Q+GBb6LGxto8XZDFQuEGZ/vo71UcuNnA5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ceb5KgqF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54527a7270eso856574e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740047185; x=1740651985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MXT2UHEqR4mXPV5rukuE4Ox5VYKDfzTrqOVamfQ/v4=;
        b=Ceb5KgqFgXlEGM9p6lCmsuWIN1nha9/YFH1dHjCRJOKpVyo89ZMEIG6XqrZi4Z9kaV
         zqei1AL74DGW5GdggzGhuxuubDJ5cDjQTim33ciqs5CCp8FetsVG+YX36k7sIkRBdQSf
         U4ZKkUniyCkrpnJXtwUUA/K0/711GtAkL0X0llqIS90w3GtN0QY3OovhGkrbfy1ozswk
         eriV+WrWY6P28x5U5wJnvwBveGJdkpxIIsckvLdwFemntBAAZgdIBYYRhojVOEIEBIXA
         90qQ0jt7aVIEg3WZJUkv0Z8cq3yNxlMLIe8HLJBk87tbTJJBnX8w2uuRAmI/Tq/vX2Ri
         a1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047185; x=1740651985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MXT2UHEqR4mXPV5rukuE4Ox5VYKDfzTrqOVamfQ/v4=;
        b=IFuc6foeNVzDNdFjD6rnYqZ4K8Lm9OGTKCyDRmgZALiVB5Gaxw1VYin+Jyb2P4WHTu
         BIvt+9iQUA3OGKyArk3qBC3p6hO4PdX4QMQSU6lFmXwJyBxQNG3NpXpMT3B8+KAfnF6L
         8poT1L7hEyaOVV+4i3FpcTyH7i9gnGtMZNK1Yp8RDWruf3RJre7/k0hXiQotOWdR3sRO
         KoSsWM96m5DXeJI2Twxhye4b7UC2TxfMbB63aFyEHcRD6r2vIPGhlkOOYtVoYQGjLgw9
         INlr/hqdn/tPT0RmgwaegBTMvcnP9bwF4e3sMpdd4KIdhd3/rMi7LLd5gPkQSx88AESc
         VefA==
X-Forwarded-Encrypted: i=1; AJvYcCU7VMCW6Y1KCYTJsAm/Iv1E8lF54rucB2K39FZoSnyIpRkTQjW+Sohlw+Nx/2fhLSkRm0JahzcOSYyZB2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHR+OomM0Lc/Sv310KDrQ5hkvulNa/wVMXNFebpYCt6OiWWv4
	2kU/BMyU0qVFYVeSw8i3v3YtAnOEFumr7zmwKrH1RbgFrBOSaglT6+hsWFqIyUc=
X-Gm-Gg: ASbGncsR654rN2jH80AvMBk3T8PGcV3RijR2xTYoBAW9YPiiF+aTc6PYR3ZAj4tURJO
	oHSbQJkbQZ9b/orXpNoS689YOsChW3K1HYEAo9d6d26QOmKMp7iZlCRhhJcbzZ87nUYhv2MEE43
	8yWZ7YOkbJuEl2o6U7rrJERQde47vHAoHQdxcri3eR2nsVyOjaXhzaQnRgsPwPgEiBbXr0oUWmZ
	3NHvCcGZpCJ2ZOIL6KGn66xvhPrhHZ7rLD7xr9WSJzSsKD3B0o8dSI2GvL5KXCVdpNWAny8MRdS
	2qWjAtyCovm+MrQlc75Ecj4=
X-Google-Smtp-Source: AGHT+IHVs7/HB47jqAC6EzTTnNTZAfzg+x9KZYaVr4/z6kRTIYCgC/Ny36xPicgL5AjVTPvk7mAqow==
X-Received: by 2002:a05:6512:3d8a:b0:545:2ab1:3de with SMTP id 2adb3069b0e04-5452fe3a020mr7735223e87.13.1740047185105;
        Thu, 20 Feb 2025 02:26:25 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545e939224esm1588052e87.135.2025.02.20.02.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:26:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 12:26:19 +0200
Subject: [PATCH 2/7] drm/msm/dpu: program master INTF value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-active-ctl-v1-2-71ca67a564f8@linaro.org>
References: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
In-Reply-To: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Zeu2WMMg3KSN6/su6MRFquf4B/jwSUnZPPK7KQNFjVE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntwNKFKkzsD3IaKYWEHR+cLcNe4qWLzmyk7+Rt
 Q1BXnwf2LeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cDSgAKCRCLPIo+Aiko
 1dnnB/9INNm7rqUorusuSFff9lMPBp5yiIpIzWu28DU9UfuKT/GZSDwpGxHhwpVllxYm6SaoRUA
 JsIxGieMq8CZxRFUboUzZnWVk4RIFIz1KasecaOaj+u/Wy7r9ZP65ngf8eexv4uVkPGhQudKtNT
 61ciN5o1CqshJMBxtf2jjNiLbERRmtQvFYl7zt07KxSfjzUP2Jp029aB/oHcLV7AIbSikxNO5g2
 2V5mkBLUTfomKKWU7YN6F6V6NmHllQuGWYBLPiwgxt/JFxxX2CCFol+diApEB9EFMu1KR/wifhT
 DsTnkQisTC5CZXzpEDK04jKAD2PKgtr1r4VTCo/kHKUtoYlO
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If several interfaces are being handled through a single CTL, a main
('master') INTF needs to be programmed into a separate register. Write
corresponding value into that register.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 3 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 321a89e6400d2824ebda2c08be5e6943cb0f6b11..db36bfa98fc310c1bf35c4817d601ae6cf88d151 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -582,6 +582,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	DPU_REG_WRITE(c, CTL_WB_ACTIVE, wb_active);
 	DPU_REG_WRITE(c, CTL_DSC_ACTIVE, dsc_active);
 
+	if (cfg->intf_master)
+		DPU_REG_WRITE(c, CTL_INTF_MASTER, BIT(cfg->intf_master - INTF_0));
+
 	if (cfg->merge_3d)
 		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE, merge_3d_active);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index 85c6c835cc8780e6cb66f3a262d9897c91962935..e95989a2fdda6344d0cb9d3036e6ed22a0458675 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -36,6 +36,7 @@ struct dpu_hw_stage_cfg {
 /**
  * struct dpu_hw_intf_cfg :Describes how the DPU writes data to output interface
  * @intf :                 Interface id
+ * @intf_master:           Master interface id in the dual pipe topology
  * @mode_3d:               3d mux configuration
  * @merge_3d:              3d merge block used
  * @intf_mode_sel:         Interface mode, cmd / vid
@@ -45,6 +46,7 @@ struct dpu_hw_stage_cfg {
  */
 struct dpu_hw_intf_cfg {
 	enum dpu_intf intf;
+	enum dpu_intf intf_master;
 	enum dpu_wb wb;
 	enum dpu_3d_blend_mode mode_3d;
 	enum dpu_merge_3d merge_3d;

-- 
2.39.5


