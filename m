Return-Path: <linux-kernel+bounces-194776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DA8D41DA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527B91C2147E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A4A205E0D;
	Wed, 29 May 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLuJjRBG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9020012A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024356; cv=none; b=CkGd64GAM3Qu/aYC8a+1JpoQ1JigkiK5x7Hkn6Kk1c9uB7hMcs/drLXX/vVULoznma+sdaR0Llv8caY1E+z4bmWK9y6wsYfbSwB5QzwQOJ7SWL4q0rmPI34+cHhdhRFKbnrawCpPgQTrvFpQweBx7ij2g6W90q24RPg5hJysSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024356; c=relaxed/simple;
	bh=JXbaAkUfXwOLePC7VJ3jRbdq5WguoXJxRCdZfMDCGD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JaDDBfmlosd+rQzGBT+YTEE23vTUfqsAEvpzNV7k9M5hY/Y9wBX+MfEgYm8jPWUsgal8tF9S/Jlt0kDofDxfuZTTckDITHT39pviMYK4xH+LYihcovzGuMciW8dsbSlIy/J/6wMLAzdy2SAWriA+iJDQErfHVP/hFO0c51iiKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PLuJjRBG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ac0c4b62cso303108e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717024353; x=1717629153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkMzRYwH0rVG++I7PNZai1lbvWhZpzJwskrcS26a0W8=;
        b=PLuJjRBGozU7FmlnuSZWd2Y8/nOUobrUgg08Nzpa036aR3blbWo4hTdpyBj94/Meuu
         fCkOpA8tu9RBlHVkVicn+bNRK4pg7chq6RNshjNy7YoIWe7cPgp/y8LdMKvCCY5+PUi3
         p3mVyrnaovqN2PT3u5EnLkIeIzhs1Qp9ZuspsNbm+tcQcC8bRkeNpakU3gM5QtF5kedu
         7h4qT2hSV7H0qDVOuxhcP72VJZpLSGHzWNTerJCKy6uUR6LTrPprE4XFs2pxzhk6VRYc
         XR2BwdZ+iFCxkBfRLNtqWfmSNOgW55ZdgdmY0NeCK2zz5hf6ok05/r2oB6uBV8cpJn32
         Vg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717024353; x=1717629153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkMzRYwH0rVG++I7PNZai1lbvWhZpzJwskrcS26a0W8=;
        b=osJCCLPpI5QJLHuLwf4+IfbzleaRCmoOZ//9Qd+HJEBl5aTXcewC4yej9riv3G8HjO
         WrKxJwk10WUqWtdsavvOXeaeKjZw/gF+h1dSTZqsjM+2patewFuMfavA+T6Ab4hcXxdX
         uSbvAXrL0sG+L+M5QvLq9KI8eNhLGbiuyJqYzSTJKd4HGJZDkJJFWVk6flt0jdy5lXNj
         GA1Z8FbYUL4zqCA+0JhHab287SkiORQHBgZg6nfDNDzAV6cU2EhvYVDmoLnUbNef1uyn
         J2VQgWf+VmrlgjJvFK4zk4IW2R8xynQrmAHZYKWU6Ou/Pw4YmRkyBzoL2lxdQVYNsBUt
         YWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBxh5Oqk2y/XP+M+9dKjeBsBuZ1/tgvKGJ5mlZGSEpi1bSniLTs/vakz/50fbeSmI1Kd48AX0t9wAMagJchuiLtIc+VIymOh2R5gFJ
X-Gm-Message-State: AOJu0Yxe1sC80SNBI6ZdlNI5G/JCkaxSd+Z1ZMO/KUHNQ4hI5LdaVyA2
	nXjXNulFapF8lRE0mF8zAuT8+rKFT7cyMeVVtk30kIQIlB4KAvq/gXi1qVAg1Ok=
X-Google-Smtp-Source: AGHT+IGmn4vLOr1MpA4C9QZUwUHy3hAdOgzgBEcF4Qehtqq74DHO6cH6XT1OjA7Xg6kiavbvMjoCdg==
X-Received: by 2002:a05:6512:48d7:b0:52b:51f9:a37d with SMTP id 2adb3069b0e04-52b7d48dbaamr287163e87.56.1717024352703;
        Wed, 29 May 2024 16:12:32 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529acea1ea8sm1015998e87.276.2024.05.29.16.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:12:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 02:12:29 +0300
Subject: [PATCH v3 6/7] drm/msm/hdmi: update
 HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-bridge-hdmi-connector-v3-6-a1d184d68fe3@linaro.org>
References: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
In-Reply-To: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=JXbaAkUfXwOLePC7VJ3jRbdq5WguoXJxRCdZfMDCGD0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmV7ZbQzkUf+QwXevZVgVGcnoXh6v/BnUkVpyoc
 TiWtOs/RsmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZle2WwAKCRCLPIo+Aiko
 1aJICACGzEbeaqCcKTsoSOiXZTVsNiRuecSSJPWPE015VnX/qerF5K3/E+W4puR/itA39pQ+bcq
 XkmAGajulOanAgaEFLW5+CgQs/hK19qo2bLZ0VI1iB60zzfsnVU4feOKWnKvESKWOpDNhVhsVgB
 M0Feb0yG+pNYFPlh8uYHaU2PONT8HFdj3kzXJ4drgba2WdWRpUG6zR0BcfrkWkRlAkkVr4nAidl
 ZC2F20SCwLa6EsGFmKm0XbHJayCT52ncDPTRcpHGdSpwUo72VagG341Lyerufqww2nTTO3csU5t
 gcLLxlZ7++W071qCfiOGgJ4h2YcoefYvJPvuv5MuyJklXkyh
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The GENERIC0_UPDATE field is a single bit. Redefine it as boolean to
simplify its usage in the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/registers/display/hdmi.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/registers/display/hdmi.xml b/drivers/gpu/drm/msm/registers/display/hdmi.xml
index 6c81581016c7..fc711a842363 100644
--- a/drivers/gpu/drm/msm/registers/display/hdmi.xml
+++ b/drivers/gpu/drm/msm/registers/display/hdmi.xml
@@ -131,7 +131,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		 -->
 		<bitfield name="GENERIC0_SEND" pos="0" type="boolean"/>
 		<bitfield name="GENERIC0_CONT" pos="1" type="boolean"/>
-		<bitfield name="GENERIC0_UPDATE" low="2" high="3" type="uint"/> <!-- ??? -->
+		<bitfield name="GENERIC0_UPDATE" pos="2" type="boolean"/>
 		<bitfield name="GENERIC1_SEND" pos="4" type="boolean"/>
 		<bitfield name="GENERIC1_CONT" pos="5" type="boolean"/>
 		<bitfield name="GENERIC0_LINE" low="16" high="21" type="uint"/>

-- 
2.39.2


