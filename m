Return-Path: <linux-kernel+bounces-231554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8FF9199F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858B5282AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB47194120;
	Wed, 26 Jun 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tfk0DhDL"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6741922D7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719438367; cv=none; b=hD6vumBXfY3bBFBclqQrRrWeiEfVxNnqXFKFiHu1INbo90jy2TGesZ6l4xpQW0z5buy7DNLvB9Hfn9teM3dnh1bIGy/eRl7rM+jd7/50spqFRrAEXZNYF2ZGbwuGcF4MGe3Mg3ytVX1fczm4JGZulQ0w7nhlzOOiersfCFd6Rmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719438367; c=relaxed/simple;
	bh=AABfn+5Wuop9C4JWNFNmkXvAwigJm3H71KL3fIC108U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzcfadXjImI1XH5cfrEUmn/i0PoHXJ+OCYu0fkZ4kNabvBZ7EXCcsG9LcYSmy0Fvam4HM24OQp3sOyiPsPLHqQFoNuq04ZG6vPs7hFOuzfz0l5v8DbxNI/ZLgNGBMdzbiWj6QhGEOlJSYo6PZYUXK6aigfGJ1CxPpZW7SQumjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tfk0DhDL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso45069521fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719438364; x=1720043164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJ6Ofnj59KCGRdS4jKTFy4IIJWcn+np9cmCpcqde7DA=;
        b=Tfk0DhDLygVFcIGK46HWyPy0W4e1eYg135Es0v17QKfK5NR1e9KgEz19wxS9kXtYVA
         2T554x85LNsAFD8dtzjUfC/kbE+WhMnvnYg2/XePE2RHIPIGZChGGl5ygOVYOvnpjpJR
         FFy0G5bz9PauaBcBWHM5DHkk/JjrqWo9lebsOYPxKgAysei6Yr9m6y3fVy8J7WZoSsSN
         nYTP4Ew0AUF9gYCKfP4ru6bdAZ/slqE98XaiZjwhK7uu96ywQC6CMnG2pP2I++mvCcsq
         rQ3n6TVVSZowndHPc/YCE8T6iwwz+kcgR/JfFg3DyBg+YwzFL2JgvAd0+d4cNRdhVRar
         i9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719438364; x=1720043164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ6Ofnj59KCGRdS4jKTFy4IIJWcn+np9cmCpcqde7DA=;
        b=vVZ/p68Yw/Zb7doclg17cSeBCdWldBRQSPwekbnyUTcoZsf/Mc//9gdpCrm5x3xZgw
         51swl2dS9GkS0aLu8d7rmGFY+at3lZDV9G94F8bEQWhgqifargHdKph5DwyWOkww20Il
         mbE2qxftUOXbB5IqPBvmZ1KVthO3lvV+FDd+Nz27GVqc+XD8fs9bc13ixSUP5vxwXkV8
         0gtlBo2ixmca/INX/a2ZI8KkK5ioognSL76tpIVQw0KY79zCN5osW/47lTGzmJitV4Rp
         TJ0i+1xP/EyZvbMkYEHkqEuh+qis+rFvTrFNca2VWA8dE/1JSRjGh8sIzHwfeC4tGJK5
         a99Q==
X-Forwarded-Encrypted: i=1; AJvYcCURrCKQKK3XNWoXS3drh3qciBR5mPXSCBB3p6WB7DQr+DC3V4exeX3ULRGgvWSwqpAHbCGcL/RDcBNhNLvGTOlD11uifQxKyT2EDp6X
X-Gm-Message-State: AOJu0Yyq6D1ZCH71bFIUCyl6aX25skdEx8cRwcNxFYz5yD6pBPD0JoS6
	/jszOq315Gglyplu0eneE76muz2OPvKNdTDr0W9wezH8T15bLrJ+w1wUt+FU8GI=
X-Google-Smtp-Source: AGHT+IE915cZlH9nn699bYkq4F+smrZwnMAUSpyQaKba2INNBB2cS3+zbtnje0X61BPw/JSw3562AA==
X-Received: by 2002:a2e:3218:0:b0:2ec:55f3:40d with SMTP id 38308e7fff4ca-2ec5b346102mr69215361fa.30.1719438363820;
        Wed, 26 Jun 2024 14:46:03 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a350d96sm23201fa.49.2024.06.26.14.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 14:46:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 00:45:55 +0300
Subject: [PATCH v5 01/12] drm/msm/dpu: limit QCM2290 to RGB formats only
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-dpu-virtual-wide-v5-1-5efb90cbb8be@linaro.org>
References: <20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org>
In-Reply-To: <20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AABfn+5Wuop9C4JWNFNmkXvAwigJm3H71KL3fIC108U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmfIwYuYOCQf2HImzQBD039gclCXtQ4YiEg+N93
 3Wd7KLe4NaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnyMGAAKCRCLPIo+Aiko
 1fffB/9KorMTaducYeo1F664LtegB//a9stV/tH9mH/NDSIYmWWPJ9YXsFT2gqxLjyDT4BqDsQT
 6byaCMtuVkc4sv5GWZ5KVzmJ5gKEiB6ionJJ9qeB4cphW7FC1ZnXiTzW+ZOi3dElbqHialO9juO
 SjAynXEHeTCZtxCf0R3td/h4hiD6MaAEmsKdTUpdfZgYVHZAcs3tqCDPT5HlrmcKBsdmwwYcY0H
 SEvg2QSTf3JFVUV0qhJCKXf3Ytfg/KzF+XUsLUPIReTKyjTZbmjcKQoifYaBYNdoLybFTe1IWs0
 5126eGHKCLripRExohwWuUcv5rEA2Ro3zpdgjrOq7UXOLpIQ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The QCM2290 doesn't have CSC blocks, so it can not support YUV formats
even on ViG blocks. Fix the formats declared by _VIG_SBLK_NOSCALE().

Fixes: 5334087ee743 ("drm/msm: add support for QCM2290 MDSS")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index fc178ec73907..648c8d0a4c36 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -308,8 +308,8 @@ static const u32 wb2_formats_rgb_yuv[] = {
 	{ \
 	.maxdwnscale = SSPP_UNITY_SCALE, \
 	.maxupscale = SSPP_UNITY_SCALE, \
-	.format_list = plane_formats_yuv, \
-	.num_formats = ARRAY_SIZE(plane_formats_yuv), \
+	.format_list = plane_formats, \
+	.num_formats = ARRAY_SIZE(plane_formats), \
 	.virt_format_list = plane_formats, \
 	.virt_num_formats = ARRAY_SIZE(plane_formats), \
 	}

-- 
2.39.2


