Return-Path: <linux-kernel+bounces-391362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD69B859E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021AF2833E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18541E25FB;
	Thu, 31 Oct 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiHqzLyL"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032E1CCB27
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411065; cv=none; b=m1je1tY4P6AzPNWDhR0psZtRQktwcFXizj4PPyi8Ps0NpT/WS2EgkKBZM9m3O0n7wlhClePFejBgZ+pL+8fjUK/fqzTFv9K3doREpPFYizGUrDxeDTV8cwWMXLNWIjieBprFD6hTWr0+Ot9JJXgcjIPBaZ/zr5flqyYfDvXcAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411065; c=relaxed/simple;
	bh=EC7IGqyWyXuYvmoAr9YuRm5TGifA5Zv3WnYyU2rd82o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzLAs8e5CGB3It+SmSXHrp0lRRvStRJeFACsWpFDMIlkIyq/zYG5MaxQuKI+w9X3NZzk01GkheUl2U2tw9lhBALC7eGSNb9tc8IJ5jqs2E4QS/W89/PWbXAyb0F3an/JAcgTHSWQtG2NXVtY8Pnu8Kk90hjEukFO+VhuNVLEl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LiHqzLyL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f84907caso1584254e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730411057; x=1731015857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPKV1l7WQPDfH9lzOb2q17A3D4m537PwpneYn5oJnQU=;
        b=LiHqzLyLsL1zH/JLYrV2dlbb6CwkEig6rwBvQl1pzY/qGtIxQe1lEMQzHouLG8CHDh
         F4RQtqlqTlmT1ipGomkLCF6JX1gZU2hhUvDoMzZAvCoOpEsEHJw8wMNnviRqViU/Y9lZ
         GN0c/Ys2n4X+AIjZLU0hIuKfg3qX6toTuWKGd+VeXRSAt0NuIWAT76K+CgjLP8O73CZw
         Xhy2KlclOqOwZ9ET7lY0Yhn0I83A1DHfemOZREpld0dtILjR3k5pmypaCRLtJA6D+tnM
         vjIz0dqxi3FTfadQqc3+y7sukkvTSFRvevlXeTxxGWevOYK3YZbNCWhUndiwKimXLapd
         ewjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411057; x=1731015857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPKV1l7WQPDfH9lzOb2q17A3D4m537PwpneYn5oJnQU=;
        b=rd4OpF9e1ED+McgBXLHXlz3WDU9JsKU/WdHAD2gBwhHNiTROADzTw2AH0p0BKN6vkX
         nMx9AuctEyBJVkgS1OSTRZZ4l9HNXFj+R8V0ikEkd4Oz0GyLD0GlP2LRJw+5C+geeND4
         eXoNIxHJowNx9CiAd6gifWztDEr53D8rkOukCHALafHePA05DbcuGnJgn3aKgY3SagVA
         OQNAZ7UNwsBGuMzvEK0lZbHdbWfqS9UlIlck4Vo2gGY4lLTWsXJK3brd4V/kkLZQDM9s
         NvRUeRolMNI7qca+rYyDftwHMVHCbI/ThJFnTRKTpKWl3RB+NAaHNYA5uTp5dLu+PFTh
         +l3A==
X-Forwarded-Encrypted: i=1; AJvYcCWfFSJrR4fbUnc+gsX5DGQV9/GcgMwiolgPe5JoPr6cjry9M3+RDlWBlppxlvh2yA3oRk++H5PiUhbDRp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyQye67n8jsyHDglxzI5+BX6gTIkJjqi49cP1LlHdxZbM3tL6
	GI7tVtRtlAtPCsrZkMdDLEIlxn7948eylNWbDRXsVk0l5luElmuzV4AX07OCiJ0=
X-Google-Smtp-Source: AGHT+IF7OeiHuEUiv/XfwwF6Y6HWxRlTSBXOzk5RY/Fkj6TlVnxbw0iYwOlxHHfb633UcIq0Xh3bIw==
X-Received: by 2002:a05:6512:1086:b0:52e:fd75:f060 with SMTP id 2adb3069b0e04-53b34ca4c4emr9695300e87.61.1730411057141;
        Thu, 31 Oct 2024 14:44:17 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c162sm339567e87.96.2024.10.31.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:44:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 31 Oct 2024 23:44:07 +0200
Subject: [PATCH 2/3] drm/msm: move MAX_H_TILES_PER_DISPLAY to the DPU
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-dpu-move-topology-v1-2-8ffa8122d3b6@linaro.org>
References: <20241031-dpu-move-topology-v1-0-8ffa8122d3b6@linaro.org>
In-Reply-To: <20241031-dpu-move-topology-v1-0-8ffa8122d3b6@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=EC7IGqyWyXuYvmoAr9YuRm5TGifA5Zv3WnYyU2rd82o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnI/opi+wDcjEvxhC+rIat6pKUCcGKpfNdmmaAt
 9vUSHuUDLqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyP6KQAKCRCLPIo+Aiko
 1YzdB/4jdKKPqLoJbWAouBP5G+3BfGdeVtLUvTtV+yvyS3gWhRxPsytqFnjEoXTckZ1A/yTNGNA
 Hb943ynC6jUrpCYTdDNvinO5brkmhw2yx0HO9e12L6677VH8SlBRGevTaKEDoK4IO+EYyZBWLiy
 hBxllul6PktuqP5crBnmLU/5SNphhqNxeeofJlbeDF8eCqPQuBwB3jxL4kB51UIAGeFbRAAdRzC
 UsyyhYE5wCkWa/BNqNAsbitddR45Dgx2UnhHmGdI5RCsaoaKAziQJmOogxPK36Uc8KD7BhfqBPz
 WYV7Uhf3Bqgh5r/DkrsbgULO9cXKAoJjA5gJsRoxIq7ObEH4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MAX_H_TILES_PER_DISPLAY const is only used by the DPU driver, move
it to the corresponding header.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 2 ++
 drivers/gpu/drm/msm/msm_drv.h               | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index f7465a1774aa..6c4f3d7dfbb1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -19,6 +19,8 @@
 
 #define IDLE_TIMEOUT	(66 - 16/2)
 
+#define MAX_H_TILES_PER_DISPLAY 2
+
 /**
  * struct msm_display_info - defines display properties
  * @intf_type:          INTF_ type
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index ae3adb0f68a8..1dc161d9bf51 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -71,7 +71,6 @@ enum msm_dsi_controller {
 };
 
 #define MSM_GPU_MAX_RINGS 4
-#define MAX_H_TILES_PER_DISPLAY 2
 
 /* Commit/Event thread specific structure */
 struct msm_drm_thread {

-- 
2.39.5


