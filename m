Return-Path: <linux-kernel+bounces-533375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F40A45943
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5618971DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFEE238179;
	Wed, 26 Feb 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TabCXKOo"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEB238157
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560384; cv=none; b=AWAzVKOqm0Ifwh63T1+rzlEU34RoKrMIVZST0lCtO9BM1whV+l6EKRxdxDVb9MX/lRObm/2xj2m/ePKRQx/3xdmkRDcVaGPkbvWBt6dzGys6OIp4wYPDnp1KXZ+3343PsKhbFJsUcPOtsK3W55MgKFkIJZ3i9RsO+Rifr9+ZjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560384; c=relaxed/simple;
	bh=KlCjBmWN3HQI30P1/iEnVtV7zXNb45CFcF9NRTzfcWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkesaxEA1Hs2IpN4p5AGuDbW7hCYsXtlIds8CY2uU6tQ3PvMZSWlf48YFLtAN/SXaAFG2OVLcvv6JCKnpo55U4afSpP+OFavigivCGENaig9Ni1m9xSWGdSzqJpa/XIaJ9YE83MCWr5eJdJqggROXkCx+7BGrpnbNp8PEnmavkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TabCXKOo; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a2f240156so68600701fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740560381; x=1741165181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHcNOzm1hcrclCZti3P3V9XcVq0n02C20x1XRNCo8a4=;
        b=TabCXKOo6cTMFHArUU4PqFzzcG9vtPem5ac4jUtUSHQptsT9bt1t6dJaTEmPnfzPXT
         nejdbee+Ri8uGhciQFhbpENNr/k/b1v49sSe46GyEAnULJDyT/JpsK1MTAo2CLRKiaNm
         TcoZeBXGJy3ucp61rxdhJSHaRCDcIWeKWSF35wKLeo5rS2PWtBG2HqVaOWd7NdeTN98b
         hQObmtUz87AwhG0fqduqwFwpacmCTsHbKbQaN6xalGgj1skKcx+OBcTHyB11FFOTEHxU
         B/6NHGCzMn1NxBMUga3GOxtHregOJGzMzIwBXs9zGTS9UMuzxAWC15HPtmoo0Rs5I78i
         9XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560381; x=1741165181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHcNOzm1hcrclCZti3P3V9XcVq0n02C20x1XRNCo8a4=;
        b=pFIkPosezF64zScCea4aZ2e6HBjfZhSLbSbLmTK7gKnOiDQua0A/MfJpC3dVxHxhmd
         SVWks6u+PgJLn+ymq/A7zeBVxZEVLtOvyY2JvwD+EcU1yYvwaUOfwmJEbsSLHth/4VdX
         bKdNOUedv1ykClAPIb+cqILEzJceXivvX8MtyLO8eokpcA6aJUOs9vzKDQL5HhpwDQ+x
         RdmnwDP1kiz2H9aQUIv+z7RSGaUKmDzCVKSnIsmNAF1YZUW65p+MNqOhOLOqrtIAHbYt
         HwS5jDKG+0EmBen9wvA3xUoZ66f2IyJlm1xDxenEbNfO7bFuxeXRcBCXWrS457MAyiXU
         FLSg==
X-Forwarded-Encrypted: i=1; AJvYcCUMPG48XXxuhJYonTsSBsgs9hbL2TFrG8Opnnuc8I0nhPRyWcAiR0gu1MRRqLe+4o5oJDrZPW6USjAD5dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypDedYBC8IiXLSFiy0hEjBMyrs9YrPcb5mwRWPJnwm2noUcUdZ
	xuRHUOtkqB06/EY+URw9RL5i6EWuoikbNIbzUqasR7MieC0Wzy3XK3CItAbNUu5e2ZH/46VGBzB
	HFHk=
X-Gm-Gg: ASbGncumNc4AzuPyj9jXqP1bbmm/+wbfpqRsy+U+iGkhD3XJ788mlrw0L1X+3d1IItX
	Px6OXU9RJh96R8NZ1jFymb/Dvgj/T/iFEp6Im4TGpVp4jzTEtePfXDNZsivF8ZB6Vlcv6S+YPhc
	O7aKezm20wfJEA7FtbEEYmJQCUScUlNJqB0J6Gf/nhEGAQbeU9PSoN/uIFtAOP+GhgnXqaGQ4CT
	AhUqMcA4dNkiqt3ZYvd7hE5K+qstihIQ8Ij12k4iK339+cgmvDJv2BXi+JRf4cY0mJkPBPTPEgg
	xgSFhUKCB4b5sQd5/VTp/CJjGMm0H5HWyg==
X-Google-Smtp-Source: AGHT+IFIstiUWb828AgIqSu/ljVx7698UENLpRl0AsY21WG4mplxCihJ20chMJifNN+VTAFh8RwL3Q==
X-Received: by 2002:a2e:b609:0:b0:308:ec6f:7022 with SMTP id 38308e7fff4ca-30b791832cbmr23531521fa.17.1740560380799;
        Wed, 26 Feb 2025 00:59:40 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0c49sm4556641fa.10.2025.02.26.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:59:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Feb 2025 10:59:28 +0200
Subject: [PATCH v8 5/7] drm/msm/hdmi: update
 HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-bridge-hdmi-connector-v8-5-340af24b35cc@linaro.org>
References: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
In-Reply-To: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=KlCjBmWN3HQI30P1/iEnVtV7zXNb45CFcF9NRTzfcWY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnvtftzKFbgYCMbYXDtuTbkps1sLO/1BiE+TJuB
 fQwesvAqTOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ77X7QAKCRCLPIo+Aiko
 1TsuB/4pVV9CMv49UiMTJIEgL+qiw5buub248rfTYgGygTN/itp4QgFwwr0+m/bI+EZhR80wdXe
 SeTxFF6CBjSL+yR+/JP22/h73WF7RhXo+92/5L+l57liwAENoxErqEu+5X19KIwKlbxnXRNh007
 YEA9AUa3SFYTENk9t44L4glEILLtjW15xp5uR+ImONmslyIE3nB2sIKusOUr3VGXTY+AAMCTNt9
 nfPZckgIIHRwEgyAFl55ZRscpnOgLWSI3mLS9pWbEPFqhOL9IPnVoJ9z5jcApJJiUhjuj7V1nX+
 BApcipfWgqtuiNniAYB0g+s54XmYhvEVgrj/okw70eq6ru7s
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The GENERIC0_UPDATE field is a single bit. Redefine it as boolean to
simplify its usage in the driver.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/registers/display/hdmi.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/registers/display/hdmi.xml b/drivers/gpu/drm/msm/registers/display/hdmi.xml
index 1cf1b14fbd919e041fd7ac8a0731d554d4468f4f..0ebb96297dae80940dc8a918d26cd58ff2e6f81a 100644
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
2.39.5


