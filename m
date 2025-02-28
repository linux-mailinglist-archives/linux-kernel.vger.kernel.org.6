Return-Path: <linux-kernel+bounces-537752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE46EA4902C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319AE1892AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28451BBBEB;
	Fri, 28 Feb 2025 04:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRok49+7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA71B86E9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716064; cv=none; b=VR9oSCczUQgVejBLomIqHlhfFaMvrL4xCul8GtkYiK3AZGUaOvGF3qrBRjKIwhGlJ5l1nHVCnTjYa0WUaVfZ2ba2auOpjebuvivXZB8geP5fxcfRWfjp7I377JDUv/IDmgDKAO9R1uMuJWbYeePA/9jNYIh12Mdie7e/wUZ69jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716064; c=relaxed/simple;
	bh=GhhCZJjEajy0jFOjY9R54kVOCzIOaWWu2XrVcVmmfhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lfx7DI0I9PaG1Iabndm+jsiOsH3vN+xe95P7QOgUQ16NUID+UzKGf7vn5dO0CwRb8iRg0VldPCgK6odX8cPl74Ac66ZnD3JNtioa6qo9QCsToS6qvNcTPIT7OKIQfY4xlN61pKjou1xqOzz1ZOL73cB30mYnqHHYSkaEVOpi6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRok49+7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54843052bcdso1481762e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740716060; x=1741320860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlvs3krFui5VM4RI+RTWfvb2I0najIuzQ1OGaYdSCdA=;
        b=pRok49+7H8OF5oxlOpXg2skncqCNCTPs2FpgMyCIP2zqOHoAwL90Le8rtAvV7n2Ru4
         Bxq36MtWC8Ei1F06OPVuRIPaub3tsufv4hRcZQ1tif0FvxnkOEZvpC9IRm5yX62ZZKDq
         bnSaOXZE2dD5wJ8qH6IXHWsYx7uWkTRFsfMKwgcut5TjmUbY++Imy0ZkUB3zWZN46qNX
         rvUBA3TX6/FDHY3rWiLr/qb34PGHd4LrDapLn1QEnm2A7/VhARdCujqfTKFhe7viNv8O
         6cqKHEMjWEQ/X11OSpWiR0wkOHzfwgjcNHtoh50kSg2Sx8JzA542yDyyUpItSv83OgTL
         nY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716060; x=1741320860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlvs3krFui5VM4RI+RTWfvb2I0najIuzQ1OGaYdSCdA=;
        b=CXv2douhBewrgSJS58NSqPfZB3//WnVnEIJUJxCEeAAseU8RxJzVvgYQorXU/DapkF
         Wo1xEOsZtpO19OCkkcegbsRJ5ofVfDU3LzvpWmrNTWJ08mizt9iAh4HXzWGLn51zmH6r
         y97tj/FCiUoegAFHqGsf1zWxaT1jjJxJebtW7kCC0s6Gfo7rsAoBKbSarfcUQ1Pp9HnT
         x7uFllMKp2VGlIygTBsHd7hNxaK0cdopeu4lkIL0yhGPpf2GdXUlxbTy7eRwsRNnpFI1
         krVcWuBGiyDJWb/ccg5pcZ5N6y8bIuv0RdjbrX6S5oYx35Y5VqJd318aEkyq0yDAd90v
         kYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSoj87TZCKhUqPbCqLTyd3KMQxEKUwYrJp22iXbXZ+SbaIf5/uvIO/VfAjv0PEU8ASsdJ0xfezVihM2Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtuB1x+0zi6T57WMM6dxlxia4Xz1hATzrXJrIFyB1R+97qUfG
	Wdhxg0mvdxYwwwOj+VQqiydtmko6Mrfvi7zpFpl+WQbO5lOke1jnX9QydOidpXc=
X-Gm-Gg: ASbGncv2Td/KASHOv4SpoB2N7BFP/xVZyMzcR6fH009IUTFesF2FRf/kMErmSeNwPHD
	iGrR2BNR32LU3ffLmunaTfFzyvtnGE6s3OJKT+v4n1s58RpNf+cXoruuuddSXVH1/NNI3DeTjfX
	KKHsGAN8chNuZIBaBaHTNEyRJQKv33BwWJO4QTI3q+ZuJ2YMunK8k/3s1bbMKCsZvNh+mIoJlzE
	r+HANe1Us/O43XqyQxHP6HE5P2ErtdymPQ3iC9k/lTE4GGilaV4HOkO6dNcfwUzblREIacIHmW9
	NdWIDWSzSOd/SLXKHKCbpJq89IEHSURPDQ==
X-Google-Smtp-Source: AGHT+IGrnEWMPE2WkcbT7JIvexF88rB0I+CKgbkhNnFe45kc4J3u2IM/i+GrBzAjghv03i/XJfxOOA==
X-Received: by 2002:a05:6512:3d19:b0:544:e61:a1f1 with SMTP id 2adb3069b0e04-5494c11a280mr714153e87.14.1740716060111;
        Thu, 27 Feb 2025 20:14:20 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441262b9sm361101e87.0.2025.02.27.20.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:14:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 06:14:08 +0200
Subject: [PATCH v2 4/8] drm/msm/dpu: use single CTL if it is the only CTL
 returned by RM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-active-ctl-v2-4-9a9df2ee5193@linaro.org>
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
In-Reply-To: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GhhCZJjEajy0jFOjY9R54kVOCzIOaWWu2XrVcVmmfhQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwTgO3RF6v4/ky5eEIRQSKeqiOSPOMFzE4bKwP
 7MT1jG0WbSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8E4DgAKCRCLPIo+Aiko
 1T/vB/0Wymc/HhBvJljvIgyIsJdh3NY6aNpzKXKMO+cdPwVsVqJkFWOoTCpDCbEllSIJv/TrwyK
 WnWQr9oOj0lTApx3SG/Of/mzx9UBElIAhdwyjiY3oM/fkG94DGyrhD6xmyjbS4O2GOY+5QlJQkN
 vVTgDQGjqKD/L8hzGzztmeVG734r9jCkB9iFgm4vJ3ktwPNfuaUjrID44OT0gEyAcbrkgu+mgKO
 6Culz7HEx40OG9eOecbTfYuaAQh5QI8agbkpVzh5HLjJPVYH9sRGA4H5cghPbPnxNQFJe0tczyJ
 T5fIyQQiSunfcEflM1qHEgna8v1MdyyQHqUUMaCplzmV/w9Z
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On DPU >= 5.0 CTL blocks were reworked in order to support using a
single CTL for all outputs. In preparation of reworking the RM code to
return single CTL make sure that dpu_encoder can cope with that.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 32992e9525530ea4dec2f46643fc06d40d3bca7b..e7dad94d91a7b6e99adb9aadb48aa8cd164babfa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1288,7 +1288,11 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 			return;
 		}
 
-		phys->hw_ctl = i < num_ctl ? to_dpu_hw_ctl(hw_ctl[i]) : NULL;
+		/* Use first (and only) CTL if active CTLs are supported */
+		if (num_ctl == 1)
+			phys->hw_ctl = to_dpu_hw_ctl(hw_ctl[0]);
+		else
+			phys->hw_ctl = i < num_ctl ? to_dpu_hw_ctl(hw_ctl[i]) : NULL;
 		if (!phys->hw_ctl) {
 			DPU_ERROR_ENC(dpu_enc,
 				"no ctl block assigned at idx: %d\n", i);

-- 
2.39.5


