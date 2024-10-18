Return-Path: <linux-kernel+bounces-372492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E119A4939
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928681C2224B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFD191F72;
	Fri, 18 Oct 2024 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnSVngvx"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD9190684
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288169; cv=none; b=ThGTXj2PMWwaZRdGTQJqNoKDMWlZpITmePj2z01H95FW7JHuIqAhFGnMEVY2FJlpzU2w6GNFwfu1jvb/p4npl75mgTrnYcQf1UtJ4bBOHcdhAeBAO0td+uJlQ8MMFS5tyd4vTHtSMaYlaGYTAHp7jH2wTw5OeNX38H6phRgIjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288169; c=relaxed/simple;
	bh=pZFlU5ikCJDIckLBlIAUq/awzCCp0+P63uSXEOzs+Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VR965Tb+OqlCnPJzj+c1nzH7oPlYecvHQC0Ysh4XYCemYdN63BrzqCoNgavq3rFQ2syx9a1qIBeDvDgIjw2xWT6Hr+iUrN8HpCp63xrTn0HHZScFfZagKajUUceyUZzLd+gHVqlFrV5wyY+vhACVfN2cslPEbxUTXCKVbT0sPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RnSVngvx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so30886011fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729288165; x=1729892965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaBPMg1AmxsxPM/D5Hee5JcN9a25p5bXN91ymYiIy5c=;
        b=RnSVngvxN4JjuEjR4yf2LQw34TsyqkI0bb1WsAncHKYRk4l7w+KWJ+wSJyJFPR6cQN
         kRGgWxKxjAeBxmX9Sec8yIegirMdFfFJiNV5XrPjcSadtMn2jXQV6WqU5xRQjSQaBina
         j39cxjpxrDTLyR1UxEp8O0efEldpLfsPdqFj2By6ruH6LzWVHadF1uDST3zNsjGbGSQc
         kNfWPawAX8i30H6tqP0oJJvu+7rX/aHq44TF79M8eHFmd/vTe6iQrxpHHAMadlxXQ3CR
         JFosKo9E677SlKYvurYcp2lZ3Wq00Bb+QKd5TCYF4NtX2Cu0pGK1hYvtslVR8yk0BuVx
         FeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729288165; x=1729892965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaBPMg1AmxsxPM/D5Hee5JcN9a25p5bXN91ymYiIy5c=;
        b=VtHPLquzJ0pnoT4lHys6yB26zbGZd0gsOZjz9wuUHxajRdS10x6mDkXtTnMzPQJ6ap
         JWE1a3uOAcpmm4ynCOWu0C2aXCfeBHfgOXWuZPzmxqyBM/IQU453tjaGsG9Y4GQ0a5EG
         KZfKqEfIDEo3MA6IP+yMPQ3N2pEyx/jMzwQjgv/g/1KVlLNmaqHqxOLOdJC2cEa1tZjb
         nOpTurn2rqeAHV6l5iRoI8MB/e/U4v+UYHhX0F/WbIO1nRgNzqdr1LNS/5eSdgWxL4pc
         zDLe5tq6xpirMrryTYt2ZVdM3H2lPu0UG1I6qLZX4v/g9b4X6vXqDj9Fgepi5EPuUyHp
         4EDg==
X-Forwarded-Encrypted: i=1; AJvYcCUVhukgyUHSsoslI57gJslXRDWoU5U3mYWxqj7PTxVSzMzrrTM8LW3MveNz0yqDQrNXJyEkPnFDBoGJDBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxja9vKtxJMNuqkMC15xK0VxjCy6FTxPKXseZpVLBL7RTFT+T2u
	Ylv4oZsCxNze1OU4RbVg6XfPtCmdXaCqrm+v51a6QqlI3iXh2K4HryWBd/dnAbI=
X-Google-Smtp-Source: AGHT+IEwsp3DJLispc5Uu+bsLkWA9jEEfNgUg2fe0AkZdKhNFZlyKLrQPTa06UtCmputrUq6ijp2uw==
X-Received: by 2002:a05:6512:1598:b0:539:f886:31d6 with SMTP id 2adb3069b0e04-53a1520bd09mr2482354e87.2.1729288165534;
        Fri, 18 Oct 2024 14:49:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0ce5sm332088e87.181.2024.10.18.14.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:49:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 19 Oct 2024 00:49:14 +0300
Subject: [PATCH 3/6] drm/bridge: display-connector: allow YCbCr 420 for
 HDMI and DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-bridge-yuv420-v1-3-d74efac9e4e6@linaro.org>
References: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
In-Reply-To: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=pZFlU5ikCJDIckLBlIAUq/awzCCp0+P63uSXEOzs+Ls=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7rQ9bvcVYyXhH4v2nbOrW+V56fz/nM6Ra8qGUUzfkmXz
 NR4wOHRyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJ+Gaz/2LKWimrkK2V+Hly
 9qLrbbUCO2cI9V7mf7l3qX6f6v9FgsWWBgt90p1C/+yM65wm/SHu3mEdAWNz/tpN4YYiFU5P1vc
 0LNFboKga0HF5U5fM7Oq8he8cZR9Fnt0edGyC6mfnsgcMTi6zmD7rOf7ilxVcwJA4Y4vzC0HHLd
 MPXdjRzXE74Nnk09ndskoTuzzXxz9uDuWW/r9NneNNSYEmx8q/Byp6Pau1Zh6cd+3RXtHmmmmbc
 rM3H4qPaGu5djjsyMtNhm3VfVzLRRbaaseJJq1Zx7iN3yRoqYnCtKbvZ4+qvz/wIeGu38/XHoam
 8w82aNZNXnNxQqlatk+4mN4BlsZ0H2OThUov9TNsDCoCAQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Allow YCbCr 420 output for HDMI and DisplayPort connectors. Other
bridges in the chain still might limit YCbCr 420 support on the
corresponding connector.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/display-connector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index ab8e00baf3f1..aab9ce7be94c 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -270,6 +270,10 @@ static int display_connector_probe(struct platform_device *pdev)
 	/* All the supported connector types support interlaced modes. */
 	conn->bridge.interlace_allowed = true;
 
+	if (type == DRM_MODE_CONNECTOR_HDMIA ||
+	    type == DRM_MODE_CONNECTOR_DisplayPort)
+		conn->bridge.ycbcr_420_allowed = true;
+
 	/* Get the optional connector label. */
 	of_property_read_string(pdev->dev.of_node, "label", &label);
 

-- 
2.39.5


