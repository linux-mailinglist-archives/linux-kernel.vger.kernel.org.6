Return-Path: <linux-kernel+bounces-445649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385FB9F18E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D8188F017
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC2C197512;
	Fri, 13 Dec 2024 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbiye48n"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711161E3DE6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128151; cv=none; b=tGRgEfgvgJ+39i7I0MN/d7hPy+Qw0NbbZ8yUr7Dh8Jd8QIKZEOTFZ7c0HYi/7mxBua24pLkqWaywfYJadiVxrzY4kAKZTWEtO0SImQ9W5KjVrvDQ8T0MD674c+wcQWW/q6p7T9VJheTwhmOEizwyMZ0eV4YuaqRu0EQ8s4M1PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128151; c=relaxed/simple;
	bh=hlCOG/IMMVZjQpDe5hK7mWJQbmUOCcipcbOQSkwTM8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBIneyQvsFoLJJTmw9aZBWeMLeYwA6Ud11ZBY5fr04ZgKP/WdoMfD1/1PMZcD4cXKjcjPNsj3adVMCkaZpfuQ7/kbug3/PuPYd2nGRmfJoKwffxQxvZZxeuDbcsQnmq4kRHL40sa/I9ygbqaQVO17QtVdeNC1C3q9IW/DtanTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jbiye48n; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so21884311fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128147; x=1734732947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8CJ5PyGkkM5Ge4k8pgvd7rSlPr0G4VhT2YhYoApx+0=;
        b=jbiye48nhJWTe882inxJXzxHVU3fPkatD25SAcCiUmmz2ZOmZ6lkYlahoLvlM9djd4
         UykAUuSUIkNo1jHHYs7CdSdl5EMkM30EkJ1Q2CeP04HJ8T9cSb1aNGJz2/7trJ8vHGfL
         CbCXhFyyX0sbXCaLyw4xznb/DY+YvXop8rcQ4YQXf8TUGRxpDzPBomaYJPTjyXuFihzP
         6kZQfhDjh1U/tjxBVsgLp7da81TQeD/m8RkXQ3RfticByPluAyZtDNm50EkyY9OY6x6i
         4WP77KEXaVKgy2KfOOjo5Krv0ZXCtmB5OTqEldV/i7k+iywhwYuMI0DA4I3jeudbnNoG
         5jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128147; x=1734732947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8CJ5PyGkkM5Ge4k8pgvd7rSlPr0G4VhT2YhYoApx+0=;
        b=OrSrWAkVHiFssbtwDen6GHRN62s9Ab3FwrHncsIKGQZN4KlO+3FA57Sk7xUve0ue9l
         L40afP/A6x1/agZgwIOr2wTd0M9tXD+fOPnsaEiTEj47Y0+GhbGTxj0EaQjY0aQ1lEzg
         +bKduULKRJ/lKOO4+svaWPGMw6GIN9xomnDxtVlrGQO7DLOcYoJgpQgWgcR9G4vBuzVU
         krarRz0ixuoXRnrVRx34vfGWJZsyAZ4968kqx+wK7tscHBdUHayCV5E8nZ4l1jHjmgHt
         MAi9/+mRgmAvM4X5ek/GLoZi3qVTWgUQcTU9Lbhu2URCsA+kW0trAonPkA2shMq4x2P8
         KSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKrEzu4it8pCOxsZK3ih7p+3z/Ewh0ilK4sJdM/qCicNfedNUGRezl+GIviBIJ3XmhirayEGbegOLTE28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrbmh9/1ah1qKmvXXElPI9ig6G4MnvK5ekDov6ZfFBQ9xrN9CD
	1Ol2T74IeWqgz6gcB+bdC1dU2diMOBGYTFWQv90Bgk9608ZF0yS7I+cudHKtqHg=
X-Gm-Gg: ASbGncsyvPDKHoMs2ncntZc0I1L2+eNtZ8AiTbSEHQQ7s8nyAaTfDdrB/oAQXXFYfiX
	LsiNGIOjGGj3HLh91JKfNb01NlxGKD4WV+5SxPKePbhQBlwBmOMjvQmnLq4oeNtZ1O5yCE/qujy
	9LvKTc7iFVeJggSYNWpMDs6r5GpxYvqKvJpBCLCHeDoq6MCxO+MrC9S1pmPcNIRqFadC6upO085
	AB+qa9H30qDY6uyzEy72X5nlMd5U7xY5ebTLiKXRQaLxD1CN4SLePs9DAccuEZf
X-Google-Smtp-Source: AGHT+IGvudpnoHreCO5KIQhK9qwIa5L6cho7TQJdvBqPzj2l+x7eTsmEjbphk2uP/+FGeeeXkorPRw==
X-Received: by 2002:a05:651c:a0a:b0:302:1b18:2c06 with SMTP id 38308e7fff4ca-3025454f5d6mr11743491fa.17.1734128147557;
        Fri, 13 Dec 2024 14:15:47 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:46 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:47 +0200
Subject: [PATCH 31/35] drm/msm/dpu: drop ununused MIXER features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-31-988f0662cb7e@linaro.org>
References: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
In-Reply-To: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=hlCOG/IMMVZjQpDe5hK7mWJQbmUOCcipcbOQSkwTM8w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHIdKb5IbiCWlXlzhohjog6fJ8jvk2mR1h3c
 HTkOqwlKaGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxyAAKCRCLPIo+Aiko
 1SVJB/0YyiYeGnl9rwP5nT9T++SfpIT+VYC5j3zaEY83RzxKkMjVnZkWG48601WHyzHBtNf+eM7
 PlTDH5WkWsy/Pk10fKH1iYynd56f3RNnt8eLrwsp4dd3FW/wcmf+o9m5lndxHLPHbf5f7s9jL1e
 DKXkhFxoZpM7EUo8/kuc8BDzGLncnudWMHDzDlsLtKsQJx0ZOq6jx4nFWN4tWzLZM6ChP3eco8/
 vvLOzKUqhR7uHhCtbsZtaPpnfPkWUUWHjdRK7tW/dZ+FCG2b5jQ3HQLN3VoqL3teZMgjZjMI/2Q
 1ZNcSfs23kcsR9wbXF6ExDeARq/Qgp985O2EdHeDCKycwmGx
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop unused LM features from the current codebase.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 178c5440a9f4439b3e53719aaafa9458e353e58e..3267a145d8927c458545668607bfc1d82a6b028c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -66,16 +66,12 @@ enum {
 
 /*
  * MIXER sub-blocks/features
- * @DPU_MIXER_LAYER           Layer mixer layer blend configuration,
  * @DPU_MIXER_SOURCESPLIT     Layer mixer supports source-split configuration
- * @DPU_MIXER_GC              Gamma correction block
  * @DPU_MIXER_MAX             maximum value
  */
 enum {
-	DPU_MIXER_LAYER = 0x1,
-	DPU_MIXER_SOURCESPLIT,
-	DPU_MIXER_GC,
-	DPU_MIXER_MAX
+	DPU_MIXER_SOURCESPLIT = 0x1,
+	DPU_MIXER_MAX,
 };
 
 /**

-- 
2.39.5


