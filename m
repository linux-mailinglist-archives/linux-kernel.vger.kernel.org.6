Return-Path: <linux-kernel+bounces-334968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE9B97DF06
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA181C20920
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCAA14F9F8;
	Sat, 21 Sep 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kffMPDR0"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94613D25E
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726953293; cv=none; b=r6NfHJ9utSwdePyUFS1TPBKl53dIrBew3zTPE5pLii2a1CF04ctzsUFulssiqaE6PsKK0MUcbcJM5/G5H4IV0uqt5YVm8aMCJzG6oBvpEe5m17EGJ9GA2ti1HPY0DrRFaNeTJFxEdoXsn5/G1aldOYz2oVcoD2Lnc2VRwAZ2Nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726953293; c=relaxed/simple;
	bh=XCA9l6jIuwYih0fkmBs7/+esJ31azn4rphomjgMvutQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ho4tbO4o6RFjgOrBYPuSlJrXUIrO3kjPhc5xysUBxuxAoTdcswm+6ADoarPWzUu+v0qHannz5n/fLMrhlHtycvCNp6Ck5V/r7KL555F5i8TKRGGebSsb/kQBH40PUj3GS2BgHY/Gmxp69Yj6GkBVmcwstAK8+i5YsWBIKV3htrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kffMPDR0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365c512b00so3731654e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726953289; x=1727558089; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sv1Xt51+REJ6qseUldVGpJwkDcR1DsT84Q0fO/g01zY=;
        b=kffMPDR07x0hl9DgSylNTyMbuXvOLBsxtqWpvJqj0YF8uK4o1SdHUnMmlqJhn5Tlvp
         THgNwyI+No2WX6Z1Hnv0fI9jEd9elC7bQ5l/+0WBKYuAcfYyL9QBKpaxRGZ4CAYw+KL2
         rcTUHpqTjIpNyzxBKLmaCK1+JMokq1Rbfo4qHhmH0ecwHYuBMPfJCGrs6Wet+Gzi+VuS
         KWa8O5c67guayaTDisXUqqkotaF6Ge3zms29SWvq6Ou9xPzIzLfrDZc9JQQJvaL/DSvo
         r42T9BC21+TwM4CJCRZMeZPnvLxDy+MnokiCfdAnjGT/k4skb76h2U9vMzZ9s8b2B/3P
         Qd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726953289; x=1727558089;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sv1Xt51+REJ6qseUldVGpJwkDcR1DsT84Q0fO/g01zY=;
        b=t23ItTP7jN0NSyFdihIvTgco6uNmWES1SFbClK1zFO5MsF5supaVeRZz0VEiCPSSxN
         2G+74AWpqkh8pZQ6meimGDEpnnImqY2zL1GqF+YrBkKUiQ8f6sa9E2RguLgiduiG0cjS
         yOlDIufJU//OUfEoal4Br2MebnhXX0yNg+XUEn1RbmOW7EaCQ5WUb21VIxD0T8H/XNMA
         +BEgRTYOwuNGumXUUV+HeaBbzyux/JieV2hdZzollOKGItKdhTQg4AENlvQNh/Yd2Xp+
         c5CjpZ+cRz6FINy+9tFyNKdPeyp5XDrkhLLaQw4y8c4XTbgv3PhF2OanmtumADUyHNj3
         dcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkWdWVFqOWm9YUp7sK/PgwXmp/ScnGHP8i6I0AmFe7wO1gz56mFrJiV1V5SioGBJLM5HppX19qEgC58kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzVioIQO4WdMYJU7+Dyn6YYe0lFPe4MyuPjDUpyp1A49g0WTn
	3HSJBjgPuIvWDlxS9ADmAJb+o92mKN1klbO/RH4JEtFsU5n5qnJciusKWT8NA80=
X-Google-Smtp-Source: AGHT+IHTsq5saqDVm+y4PSRF+njyLcIJFFfoV4sIth84Hce11asUbga8hoCpD/yJPHbn+yr2huGaew==
X-Received: by 2002:a05:6512:2353:b0:52c:e326:f4cf with SMTP id 2adb3069b0e04-536ac2d64c1mr3971548e87.3.1726953289156;
        Sat, 21 Sep 2024 14:14:49 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b4192sm2696645e87.253.2024.09.21.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 14:14:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 22 Sep 2024 00:14:48 +0300
Subject: [PATCH] drm/msm/hdmi: drop pll_cmp_to_fdata from hdmi_phy_8998
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240922-msm-drop-unused-func-v1-1-c5dc083415b8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEc372YC/x3MQQqDMBBG4avIrDuQBmnVq5QuYvKnnYVRMkSE4
 N0NLr/Fe5UUWaA0dZUydlFZU8Pz0ZH/u/QDS2gma2xvRmt50YVDXjcuqSgCx5I8zyPeLxcGGDh
 q6ZYR5bi3n+95XrAJ32tmAAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jani Nikula <jani.nikula@intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=XCA9l6jIuwYih0fkmBs7/+esJ31azn4rphomjgMvutQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm7zdIInNhl3riGlKSk1rgC8g02RdnnV5F20Fey
 jMFqY4jSlOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZu83SAAKCRCLPIo+Aiko
 1UxXCACSlqB+A6P1dzNuIExNPQMPdzpKyXpyMltim4fr71qV920qm+A/pRY94R64jtWm2Wa6r7L
 Hxgo1o6qu+xUMNI5x6OEKefajGLyCUxWkcDxxWsHzL9MV5hXmtK1yvDe1m+kQy0lQoVV42W+3/y
 RNxRSkvxHKSXW3eU39Y1WlPVoMtgIVynk8Tkdlx+ucG2WfTjGu8b3o8MAmRMJEC68KkYOmePU0s
 QZ0k9pV2PpfQrl7+qA/WpBrssyTJgfHzSxdRKlg2lXgTCFF99ayfWgVzewc39xrN5LWou6Z58qf
 xHwspIYPq/YsSXLuHOrl4ytByW1Z50WaBmI9Bfo5Hkum4oIt
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The pll_cmp_to_fdata() was never used by the working code. Drop it to
prevent warnings with W=1 and clang.

Reported-by: Jani Nikula <jani.nikula@intel.com>
Closes: https://lore.kernel.org/dri-devel/3553b1db35665e6ff08592e35eb438a574d1ad65.1725962479.git.jani.nikula@intel.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
index 0e3a2b16a2ce..e6ffaf92d26d 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
@@ -153,15 +153,6 @@ static inline u32 pll_get_pll_cmp(u64 fdata, unsigned long ref_clk)
 	return dividend - 1;
 }
 
-static inline u64 pll_cmp_to_fdata(u32 pll_cmp, unsigned long ref_clk)
-{
-	u64 fdata = ((u64)pll_cmp) * ref_clk * 10;
-
-	do_div(fdata, HDMI_PLL_CMP_CNT);
-
-	return fdata;
-}
-
 #define HDMI_REF_CLOCK_HZ ((u64)19200000)
 #define HDMI_MHZ_TO_HZ ((u64)1000000)
 static int pll_get_post_div(struct hdmi_8998_post_divider *pd, u64 bclk)

---
base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
change-id: 20240922-msm-drop-unused-func-b9e76ad8e0ea

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


