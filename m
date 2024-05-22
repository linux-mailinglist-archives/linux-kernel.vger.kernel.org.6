Return-Path: <linux-kernel+bounces-186076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2FD8CBFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139E928335A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA797839F3;
	Wed, 22 May 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTCcRXrD"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DEE81AA2
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375066; cv=none; b=ZHscx7SW88m/0fUSwLqLc/0UFcKLQY0ebflNurVYwqFbcmG/e2LgGm9ThoAX1YTmMr/mmQL24IEAUQtLVQoJqxwKA4H9m/GTA8KNLXZyyulKj5Ic1AkPgKhAsN+mygeUv822hJYboFapbIMAfP6/EbNsLqkf6EMyciRwQtMAvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375066; c=relaxed/simple;
	bh=GHqYh/OpnADzbIGNQTWljjAqbsvOTUqyL6NzDNpzFls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oT8lpQdMRvDiOxSswmNd1D6Oo0YcYQGnul38IgV3Cr9u0KvXlLi/SmLD7KfvJaIK8VJ6O90V68C5HanUqcR7/42ARQ/x5jbTD4iSWdxiBovIOw9j84bQQd2ZMTFX2SCId0PO8iIAcLruxwBfWabsSDBCJp1/4+UCYf3T1Ny9w+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTCcRXrD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e716e3030aso44425411fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716375059; x=1716979859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03lZtK/lY1XEVDdKgvI8NPNMNTf3HunLZingl7OzXps=;
        b=QTCcRXrDWWkAGiBd93rSVTXvPVTdcRUsUwkBju4f5q6NldPXSpJerIOvr3ma4lAgD6
         8EVeyoI8Fiw9mLltCiJMsYkwrGNgysJssKHmn0oiKxE6kJ6dWNMF/+8AC75vA2NfXc7Y
         6VWC3Sr9ZtUiTDIRnMdRXQMV8ZoMteQwyQhbGibglXeZIDI703bnVLAO82+XWiG3kWHq
         N5ccLY3FGL6/FcY4CbJ3ubz0cmLe9T4c3yAz51vCZFAeNh+nFYLsMhvzNerpwylLy/NH
         7mKMlrKiC5NznviCOwa6XBs0BrGN4w4CpLEat6VhtN9M4lXU5kSuW1BOJN5BsWV298lr
         JIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375059; x=1716979859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03lZtK/lY1XEVDdKgvI8NPNMNTf3HunLZingl7OzXps=;
        b=YcxN89fl08iyoTbzX7zpUWzhcjEBh9SxbPyy3Dqg+/WHHwBic6J334XQPBfKYYrq/s
         rwuVIjlO+bf22xTCWRcRDomf0dls1EkZf7SvDR2X3TuqlBDxEhQClPAplFp80hrU4qHL
         qECAM+tv/2gCrJrzE4B5escvBgN7SRfTJ+zfHs7F8vL0N5faemqxodc5nGNOJGCT1fz2
         9S8S/gRKZsDAzs3l3cWEi15tXQMTEfZ5O9QPNz4ZLaNAo81WcogHY39pEcPROfMCanWY
         cOmC7xZXL4HexVEGA0LH+ZfEUHNOBxThMKcO+wXdNsnM9jss5FVIa9LrziJKhT4ImsnV
         20yw==
X-Forwarded-Encrypted: i=1; AJvYcCUXb/fbbdkwJjZ3xNTeUIeaFSRt+Uzbe9OGHLWCAfqS8T9IDLAAe9mVpkPhDzqaZbBfYMtf4sHtntRE4ZIPWlUj4wWwcfFgK/KhtfJI
X-Gm-Message-State: AOJu0YzzbUAIYQUCsEbK0um06hy85GVkVQ9lpYXJsDIE2pho8tuw93tE
	LRSpbzF2Bd3R4bTiZLLWSAd3RNe2dQKJIVgHfIM/DQ8cE8UOD+18mcAsDQNupdc=
X-Google-Smtp-Source: AGHT+IFjZBlFB63a+RCudEv/MwFQ9Q2bCole0thkPnhyzMY0Oy8BRRlACoKsAdrqd0TOgwhv6ucLQQ==
X-Received: by 2002:a19:ca05:0:b0:51d:8159:598 with SMTP id 2adb3069b0e04-526bf35cb35mr855189e87.19.1716375058977;
        Wed, 22 May 2024 03:50:58 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52431778ec8sm1279126e87.194.2024.05.22.03.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:50:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 13:50:53 +0300
Subject: [PATCH v2 01/14] drm/msm/hdmi: move the alt_iface clock to the hpd
 list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-fd-hdmi-hpd-v2-1-c30bdb7c5c7e@linaro.org>
References: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
In-Reply-To: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GHqYh/OpnADzbIGNQTWljjAqbsvOTUqyL6NzDNpzFls=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTc4P+BDWacbqmwW114/XMonajf8PabUyuJ9lv
 2ys/6u9ObSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk3ODwAKCRCLPIo+Aiko
 1e3eB/9uYYVb14/WnhhBPj+AyebWjWRnP0iG8FjY7dT+zHqyaHXAWZqh22kKOrvTdAFImY8ih1Z
 Lgk5naB5PAau9KARHCmo4xvSVORJHkEmzse2OCD3YJpxoS/3fZb9pqaQabxdi6zrbj2t6rksnwi
 vtvaSz0tlomAzHIpdZIAxeU6XnxshDfgfnf+44edFQ29Tb658R4vIir+ysKkGeI1qTta+6HQUlB
 EUZc/mqgBdxzKfBc0YlF+Xz0SayBG8YJC0DtMpEDdBJ4uZjmR45AZ7ihrMm57eZ5P1bkEoS4Chs
 91rAubNr/uUXsHn4+bZ3HmPH4dnNKqIfyMAvTS3WyHxqrxzv
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

According to the vendor kernel [1] , the alt_iface clock should be
enabled together with the rest of HPD clocks, to make HPD to work
properly.

[1] https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/e07a5487e521e57f76083c0a6e2f995414ac6d03

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 24abcb7254cc..108c86925780 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -235,9 +235,9 @@ static const struct hdmi_platform_config hdmi_tx_8960_config = {
 };
 
 static const char *pwr_reg_names_8x74[] = {"core-vdda", "core-vcc"};
-static const char *pwr_clk_names_8x74[] = {"extp", "alt_iface"};
-static const char *hpd_clk_names_8x74[] = {"iface", "core", "mdp_core"};
-static unsigned long hpd_clk_freq_8x74[] = {0, 19200000, 0};
+static const char *pwr_clk_names_8x74[] = {"extp"};
+static const char *hpd_clk_names_8x74[] = {"iface", "core", "mdp_core", "alt_iface"};
+static unsigned long hpd_clk_freq_8x74[] = {0, 19200000, 0, 0};
 
 static const struct hdmi_platform_config hdmi_tx_8974_config = {
 		HDMI_CFG(pwr_reg, 8x74),

-- 
2.39.2


