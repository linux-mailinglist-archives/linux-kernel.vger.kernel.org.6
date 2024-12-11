Return-Path: <linux-kernel+bounces-442373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25CF9EDC04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFA91602C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1C1F63C1;
	Wed, 11 Dec 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgvC1m8n"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B91F4E3D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960515; cv=none; b=B2d9sMuXOMo+KLCoIm5UlOHawaJOLX/xYPFNBzOKZ7D0qLGIRI/NEs6wEqdBY9D2pWni8ObMCXBa2l0qqPzGxFc5NniG/WGUdvhpCwGEIju1NsxpKjxP90xagtMY66vA3Pv/SljYn45zmGRrhOmoP97Y0rMwi3k3aLptWOlN5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960515; c=relaxed/simple;
	bh=LBDq9dTy0DOxlRiv3jpt/Rd85VVmGCc+rFm7abUVNTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjB5HuCRgITcxyhZ8yyC0rubTutjaQ+JXSGM2P2JGOSOl60Gc6Ehl54aJPOM8PpoLrMDj2Wsg3wH7AVlte7GEh8OsZA6CPh5xbM5WcFlXrBQZ1aaLSGuQ62qAOwmIYibWRe1wILJb4xMFHwdaQ6iKwS3SF5KmQ4tvaYdN6wXTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgvC1m8n; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30225b2586cso12268161fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733960510; x=1734565310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHlgw7iUBFM+rdSv9p/feyEV8lTt3noMeNdx9ahcPGs=;
        b=zgvC1m8nA8/SWVR4vapd6vuUdZKudcaw2tXlFNUuzBjKjyOl6MRhgnL4IKzHW8NU3D
         jKW+2mYxydD09gGfZ87kVtmTItc45OZAEGriMBRDY3eVITtxPGoNFhVBjI2FMpAXHljM
         9hQyUevdwBrCckTPFbYBMspSbPBMdtopZWmCLQzk0xaYFdc7dz3WSNtEj0L6ZAR0l3K6
         r9Emc62uaSGUAnJA3Ww8fu/WFnFQK5cy2xM64WidgTvyyXYicSy/5U3UGn+PSz8HuFRr
         nXcsc9Kc2uPJ/R2A4YYIoEddVgZyw+TGTW/KOqDJCcLl3yz9XtiF6ud1zY5zD3WcYVLS
         LJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960510; x=1734565310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHlgw7iUBFM+rdSv9p/feyEV8lTt3noMeNdx9ahcPGs=;
        b=U3uUl0GasoGS6QE8lbA4rbULpM/WtypLc8242GwUO5Cmw24kbzA5mxKkFUS3NmXPQ2
         whlNLAeSWzeWrq6fNnB445Le8okjRz5zmyCpETBzV3oBB6Z+HXdUqWZS2iCQJZWz0k/J
         PYd6LDFz/dj+05gJqmbABQLsFaA8Yrrwz4X1fnwAwdBuZqD0aWRs0bePZ/FR/2Atu7K1
         xxJCbL6C6eOin3s5HbuRtaNxryCKLXrMrNLfMEgyHUYtEOWmlyEgLU9GhTwCkMYKsKwg
         /+qdP27E3/zfCsMDg7hvHQ9UHWwwwuceRlU1UKfLm8/hmdxlysQHUDNImtAHhPTRo+fO
         V0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZJYzaONaR0r8W5VEFNqK4/+rEY8vWhNcsbKSy1JbhcUVo9W6tpVBs2WtMCV1/dP0KFOOdJetSSiLOwBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjLCxm3BooTcy5H1rmos8q/dVg20jacD3jNiNo8Na1bXKGdD2
	F92bBokaRvGvRvK9/ut8MGquz2cevp+YsU5KTMr/pDgjCshdj5ZbTFlj+NtbRjc=
X-Gm-Gg: ASbGncvEM/K9g9K3BQrz1QcKKFxNB/RHqDqQIKi3Bqlj62VO937YPPb+e4b+oPLb2mc
	8C7ZKTnQVsKmg93MHMN9YTcGrv5f2GJB5Srou2fck3MBvhknCSIVET+1SmRYKSmbl5f9QNGppaA
	dCzLKq1LrNCVr8o8gNPAoeulByZl6lFyznkgX63sB2rJUKXFKTNFZLZZoUS8KNsJt9tMybUY8zC
	HE+OLYnxsB7wrBJ46WWQ2RfCDRlPwK20YuWS6+gNqPbGDbnb/BJ/wch5IuRcQ==
X-Google-Smtp-Source: AGHT+IGLZruVnHdmTYclHw1ZlfaHU0nRcZrow0QrWzRIjs7hRZq8O+mQVj9gR8FjZc9UdO1Ewapdug==
X-Received: by 2002:a05:6512:3b82:b0:540:1bc3:1061 with SMTP id 2adb3069b0e04-5402f96533fmr370626e87.11.1733960510529;
        Wed, 11 Dec 2024 15:41:50 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401cc76909sm1222207e87.58.2024.12.11.15.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:41:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 12 Dec 2024 01:41:36 +0200
Subject: [PATCH v3 01/14] drm/msm/dp: set safe_to_exit_level before
 printing it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-fd-dp-audio-fixup-v3-1-0b1c65e7dba3@linaro.org>
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
In-Reply-To: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=LBDq9dTy0DOxlRiv3jpt/Rd85VVmGCc+rFm7abUVNTU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWiM3jCuKKj3zGknTJDllEMvmNanhKlf3tuvon
 j4/uxVgHdCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1ojNwAKCRCLPIo+Aiko
 1d/eB/4kyZzY6bSyBKDGs78I9tbZCJIBNlibHzxBEZECigDxPCoBpCmODNEfx8u3bMOVW/bqt2f
 zeyIIMf0+Z6cJt6tHApkIiF5A0SH6DHiPvAWI/SV4DYk0Q4s+VAX9TiWb/GzLYttjcYkxJyeWIk
 5U5UmUmrEWMf/dYpXYdpelPt16zrlNC+Z5kONm6YF4DKt0RLFxioEQbj9rwKFPPTnUrzwAY4HRg
 zaoO0x4oKx5fTU3zgmWlDPIFgeoSAADkg5sr1e4THD1Xpzex8uNt8Gj3cDQF68gCKKl6T8RHwDh
 bNkFAVSfOJHYd9dlfxpTRrHELiVYWOUQoljM9jckVPWaPeLL
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Rather than printing random garbage from stack and pretending that it is
the default safe_to_exit_level, set the variable beforehand.

Fixes: d13e36d7d222 ("drm/msm/dp: add audio support for Display Port on MSM")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411081748.0PPL9MIj-lkp@intel.com/
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 74e01a5dd4195d5e0e04250663886f1116f25711..5cbb11986460d1e4ed1890bdf66d0913e013083c 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -329,10 +329,10 @@ static void msm_dp_audio_safe_to_exit_level(struct msm_dp_audio_private *audio)
 		safe_to_exit_level = 5;
 		break;
 	default:
+		safe_to_exit_level = 14;
 		drm_dbg_dp(audio->drm_dev,
 				"setting the default safe_to_exit_level = %u\n",
 				safe_to_exit_level);
-		safe_to_exit_level = 14;
 		break;
 	}
 

-- 
2.39.5


