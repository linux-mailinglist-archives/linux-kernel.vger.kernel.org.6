Return-Path: <linux-kernel+bounces-225864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2076F913672
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F75282C39
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922C6EB5B;
	Sat, 22 Jun 2024 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGiBKUyd"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B26DD08
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093743; cv=none; b=Mk+AAu1OBft4jMQxdMlwpXxIWWiIZDLu+EGXy83j5zjpp4N6Oo9q78+fdho4m4koal/EYY1OCHp545UuDH3ovoQtcGe4mwpO1QxPXk0xywRooB+TkWu0gJi/u6jKaR2qzdNUAAtl6jqHIywjXz50+Sw2SpZIU61Waruj6R2s3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093743; c=relaxed/simple;
	bh=h0lqf9slPd5eUxk6pPihIhSWYhdShDER4/lwQr5RwCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BspAIggBAluEuTu+TLc/Ok/kW2gFQyWbapb7msJ0lz/hd2asdc8ktJwayrb9rcd/ZzJe5yjD10Bd8tABr3h6ASL8+uMw0u7VkuSAzOv7nTgI+D95fbCz79sqgTLnXxVR7c07Uy7F6VWCnzNGCBAcOb4BwGXfO95xVD59r4tjqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CGiBKUyd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec50d4e46aso15444351fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719093740; x=1719698540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaaD0TUxicSQ9bcBzddmbploW93tWtfw/qjS+oWjoTA=;
        b=CGiBKUydMeXWqPLWpNGW0tW80g4XyuOuiHxWf2BC/IbSUKZHYl7nCt8DwuBDL7fwwr
         dbBMaLkV9Iate91Kk+HQ4JRrWuoehZqkA1VCdrai4tYjEravGXIfWhWP9zQrvmuXP1PP
         tMGwY4khF+FHGYY8UanHqdTmUUwbq3Lp51TnnU+UOY3sKJfrIRLZQ4xwvdGZIxX2DLAV
         2YhPzZ44kEvr/SmkdpmOU58SzWERHjiqEuAL2kqES1hsDwueOof2IV0Kt+pFzYnMcv3o
         hmWgrCkHCxnKZUQ0/9GJtNSlMEC6L7JGm9n+tbycIIp22TV6FiFqDi0S/6C4My+S6WFx
         1+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719093740; x=1719698540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaaD0TUxicSQ9bcBzddmbploW93tWtfw/qjS+oWjoTA=;
        b=QcwR6cHyMyNL59MqEh4mrLA2muodWAktudF5P7XCmBm9cuMYzNlOBbD1HMl4dqXYXX
         VUzLV8ISSrCYxaKv4Tuht+SlPh+0O1nd8EiIEswx68tih5fs0++Hzt+BexsbExVr8BYu
         seyGWmZR1Y3v4iNQKNxb/u//799IJ62jMg3Nh99VRJQC3fuoGWO5nst21MJ22HgHI3+q
         f7RN77pIsz8yZ5mQxxbUToUDZmwbWJ2VtVv1NhEldeLP2DMcHtrWaB2T7kLXjRjXsSen
         2xy4UbaWdjRc1Pbt+Lqch3GvNGxTEpYzFpvYrH0YaC8jDLeqcK64QxzNYmq9yV5Kh0QO
         muVw==
X-Forwarded-Encrypted: i=1; AJvYcCWGcmoLJTElVqdysivNOsAzuWnhR1KhZHc0uWRVyydpe+y/eficCo4fpGTvmu5aXI1A73fz8YwY6xL/Q+fCzUcVa2sL+mNqcYpzdDPp
X-Gm-Message-State: AOJu0YwvKiSp5Yt3WmAeD3IGeD96JZWsOT35ucp8Sy00PQKB3WidWBYy
	NlfBk8P1V/em0P+YqTM68fi6h0yp+PCTEWUE+OkSEdupiDszKAwfBKueqakbR2c=
X-Google-Smtp-Source: AGHT+IH31u6dzIAuNw0VNvPZ2GqCzxLoG78KUvKhD6XvPjNqmtALsT04SfRsx1ap83ri/b4wewW5YQ==
X-Received: by 2002:a2e:3218:0:b0:2ec:5685:f06b with SMTP id 38308e7fff4ca-2ec579837bamr11068451fa.27.1719093740178;
        Sat, 22 Jun 2024 15:02:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec55e56ea5sm2502051fa.112.2024.06.22.15.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 15:02:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 01:02:15 +0300
Subject: [PATCH v3 02/13] drm/msm/hdmi: move the alt_iface clock to the hpd
 list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-fd-hdmi-hpd-v3-2-8645a64cbd63@linaro.org>
References: <20240623-fd-hdmi-hpd-v3-0-8645a64cbd63@linaro.org>
In-Reply-To: <20240623-fd-hdmi-hpd-v3-0-8645a64cbd63@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=h0lqf9slPd5eUxk6pPihIhSWYhdShDER4/lwQr5RwCE=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1q554sXjVmrzHatz+7ke/5WkuGWZkd97RrOzMsB/A6ns
 nNcrB51MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiK9LZ/5n5inesrmwVuLDO
 W6HR11dVtny2II/Ft7CzSpG3pHf7lNnZcXv/3CrsuaRUprmtUs3mJZdH7ZPIOSd577cYtqlJ7/r
 Id/7WpIVspzOPzOZb9rUugdtzLdOmtge6eR9OOjXw1nHp9OuxJCyb3fKWU1HOtWfa4RNGu6M22y
 fkMk+IYDd8sed83ILEhoKdV7kM3WeqqvakCP4523vvy+G3K3d0BDfu1Zwzz3rn8iPzDrY9SGedp
 JC73+ay5m7vuuU6vu9DZfKvs7X1qzwxYAsNvtt0Sij2TsvGbFPTPUvbN6orqR9Y1tDOccq3ceLq
 Ho0HaQv2myd1bNg5Kczjvs23789+NjA+Or3OeX25zlYTAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

According to the vendor kernel [1] , the alt_iface clock should be
enabled together with the rest of HPD clocks, to make HPD to work
properly.

[1] https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/e07a5487e521e57f76083c0a6e2f995414ac6d03

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 8c6c9dffffd6..818c66efdfed 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -234,9 +234,9 @@ static const struct hdmi_platform_config hdmi_tx_8960_config = {
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


