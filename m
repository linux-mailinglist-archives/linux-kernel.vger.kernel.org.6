Return-Path: <linux-kernel+bounces-537657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC31A48ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBC7170453
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F92198E9B;
	Fri, 28 Feb 2025 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+fZQ/J9"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26B189B80
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710454; cv=none; b=pZJQK+QTf/FB2zVPaeUJskVLA4+Gf3bhXUUPpCTeo1DEWvrR8yDdQ+MBf8fZVQ5aVSeqj1kQTKJ0lTR432yJvN3LNw7IfvNXnBbtBnpxy3VXrLr31O1Jfk+aw1KGfpz1x3l8XbRtuOj6uG8Bcho2MiBA/QldhNR9TGz6oRBUSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710454; c=relaxed/simple;
	bh=Bwi+iwgQ+Rb+/es8x9Up9adCN7AKO6f7tRpJXs0LvbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZ/f9MG8+qsmFrwLXcotGcFklHa3g3MOP6kEoHvsuByixgUsS22Q9wlPAtWe2uoMUOYqj/wu5NpIZtjk4yN/ZCy0h8j7qC9W2dddWmeK9JRnodqxnJnnImuxeMfy+3c/aKOlJgFdvAZgEieaX8lZSHTOzR+SyN5lU/y2efvadrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N+fZQ/J9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3091fecb637so14221951fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740710450; x=1741315250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivKSxnQ8DB5AtKJZbKFIHtIat0403ancJcDyUvz/X6g=;
        b=N+fZQ/J9ZjspHSKmpob75uyDE7Gqfyep/NbyJCKakZEI3Q3UioSwZdRvhKai0Tivtx
         px/ViNbnNm9SeDlJ1yWWTmhllU0g40XJWyG3ygEhuLG1u6ALHpX9cYw45G3LNyi6b0vi
         pJrU+TH3WhaeCSh/NrXQw476eK6xSPpJYqJYWeQFbZCxyrhkW9vB+jUOJGu6CWBF93J+
         M3o19XPFyCw6KnhV8s34D5L3Gwg0U0lxJLhB0ZGXhqYvZPGxydNgiAR91VIcpbUDT9mw
         0oDTgkC623xe3FMRNiwfj/Z5Rv9xKhsOvX8Or1YjUaTrV6RQWSUVfp56y78yVWXMDoSX
         7HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710450; x=1741315250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivKSxnQ8DB5AtKJZbKFIHtIat0403ancJcDyUvz/X6g=;
        b=apm/FIQDjJVFH9Vo8GVLWfM0+RTSf7Ezloh5wLDkoUJN9jJ18SGGMxvzmtQxUgRw4S
         XAUWsTC/Z6c0Q0ZJzex6dZKpJfhyneKwqBgxqqCRBdCKaXIujQf/FICuoG4zwu+YSlo9
         2cN/rcj/p0+eQoQaQVcqK1XE16LHmd/FWdmc0zdaUO183XzYEbSP9QBOfzDZClH/4W7L
         cz8hmufYzMGI+pWCAPpBpjKDUhMlXdjpBZzUep4lh9EP7Z887ZbAcj1+dQF7T7StORpU
         V1i39yDHtFugZnNWLef5tDvwQSxa0EtWub/TwFR+t3RC78QhpweNRo4+8ENxlURb1WtG
         af/g==
X-Forwarded-Encrypted: i=1; AJvYcCXP8tgfXyBlvWWjm+mQz5xifqnltQvXNdBNPNLl86et33FUiFmn+3ikclKnaBhJNw1K3KQlZ/BJJBx7Tys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybp0ErldTxtYDcyf1Vdam2iUBBIWB3r9r29yq5tZRtj8mDyw3V
	nxQM+ke/uROeCHbT8kSbJHOyv9dPFkk/PeSIT3C02DniVTTjvNI8VAwLrhtqZ/k=
X-Gm-Gg: ASbGncvGV5ipLZIkz7zLgccYV48Q2UO8C4SISNj59QPjEa1+LRvXqdSsq1uqiY2if3I
	Aoq06iSHCGj6h6rLDBnJsOjXJ+9qYNNTlomdIRgOs/DvobKg3fhhDuiP9c3R/twiVchSHbv/oqJ
	evFTPl5TONwlqDIUozonenbL0CTyOwADrcXMBu74LVkULP8YZLv+WNdc4vZZI5YU+UrcMyoUM+d
	w3gEPQwUzN7sX6KiIMiGRitL8J9Chns5MxF5I8CZpFW12+rrpyPbfnDXnB3C9/WzjCVwgf371Eo
	ADUOxBxmRKcbZ3eNx6TRqUYTnYbKhuKwCg==
X-Google-Smtp-Source: AGHT+IE/VW7ZgoJU2q0xpHj7pO/LeLZ/mYSQfo8wBTmKbg/dVc3r8HWfV/LWuQdxsmOFJYHvOL8c+Q==
X-Received: by 2002:a2e:97d7:0:b0:307:46f3:4e92 with SMTP id 38308e7fff4ca-30b9330f002mr4041901fa.32.1740710450233;
        Thu, 27 Feb 2025 18:40:50 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867a7403sm3493881fa.17.2025.02.27.18.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:40:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 04:40:40 +0200
Subject: [PATCH 3/4] drm/msm/dpu: remove DSC feature bit for PINGPONG on
 MSM8953
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-fix-catalog-v1-3-b05d22fbc2b4@linaro.org>
References: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
In-Reply-To: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Bwi+iwgQ+Rb+/es8x9Up9adCN7AKO6f7tRpJXs0LvbM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwSIot0dlLqcggIIEO7ccmseCO13JHyvnyniPc
 KESL6DNx4mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8EiKAAKCRCLPIo+Aiko
 1TM3B/9mVqc0uvziUX3Tfx76243xUbsqYZITOi2QiWPJ1rY12KtI28dI38UK6LtJWufHmCVOv6U
 K3AteEANOCQhfsWEAcc2X5OoZLxbhOC0PX5mWxhIa1fBooxOZ3qJ0iTaAvLiM3N4eMfpexuwqKQ
 PiYlKCoUFOrBG5pX6W8t3ttXhit7FqPVEl306MqBHnMqsFPpLiBkkXxgGuSJN/xSFooM1RyAyHf
 oYvC6CZso81Yl2LlxQUj9SRozPVfA0EWn3N95cWaO7sxGhw26E0x1MWmFvAroeaQoSOOeiq8PGm
 +hajaiNPw/XEAxGFtru1VBOvp1FxPigWInofMvhvbmctpgb8
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM8937 platform doesn't have DSC blocks nor does have it DSC
registers in the PINGPONG block. Drop the DPU_PINGPONG_DSC feature bit
from the PINGPONG's feature mask and, as it is the only remaining bit,
drop the .features assignment completely.

Fixes: 7a6109ce1c2c ("drm/msm/dpu: Add support for MSM8953")
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
index 14f36ea6ad0eb61e87f043437a8cd78bb1bde49c..04f2021a7bef1bdefee77ab34074c06713f80487 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
@@ -100,14 +100,12 @@ static const struct dpu_pingpong_cfg msm8953_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_MSM8996_MASK,
 		.sblk = &msm8996_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_MSM8996_MASK,
 		.sblk = &msm8996_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),

-- 
2.39.5


