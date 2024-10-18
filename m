Return-Path: <linux-kernel+bounces-372455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436C99A48C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D011C219D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045118E763;
	Fri, 18 Oct 2024 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHK5sr5K"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A918E348
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285842; cv=none; b=eiS6IpAUVUAZUhyziBJb0ClEnYZ0MnufQm3uuQf7SxbJmGQaUDgpQ4Glx7VL8GMqIfUVH4GqDJC0Z7GcBZugRndalK3ixDO8ptCcnxlxHVAKH0ynnbbnI+wYmfjkY66C5/wiyrvUYwAfuZbsjm7WHH94muQUy3KzDPGYgCWtiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285842; c=relaxed/simple;
	bh=A3EGjKxsej0bqYegaiMoauAyA0UdndhPqjQLZupQTLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fYX1Xbe+U3J5lynLyIXQ99pIPZgCZgHggnbV2CxxTSbsT55wH+4wQmlzkt9nIcxCjNzjqYkeZ5HzyBUl3t6D5IeKvEpFjEzEqelarCQOQkrNJo5AWFKvTwTiGX0QgJanUY2ikLB4TqCO3FLhz+fm7u/T/q7+QE+PFYtDAoC/9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHK5sr5K; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f1292a9bso3347479e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729285838; x=1729890638; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foLEB3IkBWHubF9wiB7Qykhc/Hfy+axzkwl74pUgfCE=;
        b=zHK5sr5KKUC8d9D9cB8XC4JvBuhsA4S603f17pk2znELYDiL9W1BkYmvbhssX2vPdz
         M8PTSm5itZA6I3t/fCmeUHSq65ZPpA5h70w3avQhAFEk0LzqzKIFCLDmiJkrWVhyekmw
         atgXClwqGCGAOAA4LjzakAqrF0fUkttWozAoRey5tKL2W3jBAldK2A6ZRyqpbLEvxnul
         Gaz+FbfO69LqW6+n4qsCmyCg0HXHCIskxDCM5qV9HTzIXtD6xNJXEoSvbRSaqKAUBT/R
         PYNjtkkro5elKwSn+S8lm6jXcmBo+lwAmY86QqaAfq1ORmTs38kKgeTfvXYGyA0j451h
         /yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729285838; x=1729890638;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foLEB3IkBWHubF9wiB7Qykhc/Hfy+axzkwl74pUgfCE=;
        b=HobeqDH/8+fCSXVU7Rk5P9KzITjbG3kBOR1fI4ijSmSAWaRQWDe4p2+w65ByJzKwcT
         MxcqJkLbj3KZf1uqtoXfQ0x2sJpsxheMbnEcL9xyd4eFZ7gfVkm0zElvwwRy5iPiuKC2
         g1IWPhJqqX/OzQ3b633eszZ66XeEXYY4yG53toWMiQffb3ZP8ZBAhov3/LHe+hCGUGjb
         mt3peXp5fPsWtdCJKedyj2TE0Bn1SMdD17iNoNc+iLFo3qNLPYJNw/nRyRYUfDB0qWLc
         JMXJ69AmGN4i69u1hsPWW/eI2bszHjbfk25HKrPd3zQ+6SItzwa2dPL0fnz3pEO79hsQ
         AZSg==
X-Forwarded-Encrypted: i=1; AJvYcCXFeC/35upwMnzJVrRGW50LGSpp2dq+6c0A7ZJ3Q34SIPovTTJwdk6Q3VdWcP9mtuFkJ7xB4RfpJ34/1Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTCbOVqTCiOVXjq90+gnUePv2i2F4Qm9ehY4ZczMtLng0oxtN
	glwMe0uH27DidJmrDxj9Pd4RJe+clhZEY0RLa5KOwYd/DyvSPwYAERPjdhJ9faA=
X-Google-Smtp-Source: AGHT+IHt9oXi+IhTVxmWhRKS1ReTT9GguWan85tSMWRnx+jNu82vXpqvZtb54V0dm69fu8rQ4ETTRg==
X-Received: by 2002:a05:6512:308d:b0:539:e6bf:ca9a with SMTP id 2adb3069b0e04-53a1534117bmr2562285e87.6.1729285838429;
        Fri, 18 Oct 2024 14:10:38 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b0312sm331171e87.51.2024.10.18.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:10:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 19 Oct 2024 00:10:34 +0300
Subject: [PATCH] drm/msm/hdmi: mark interlace_allowed as true
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-msm-hdmi-interlaced-v1-1-03bf85133445@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMnOEmcC/x3MQQqAIBBA0avErBtwoiC7SrQonXIgLTQikO6et
 HyL/zMkjsIJhipD5FuSHKGA6gqMm8PGKLYYGtW0pEijTx6d9YISLo77bNgidao3ZI1eFg2lPCO
 v8vzXcXrfD8wAgRVlAAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=A3EGjKxsej0bqYegaiMoauAyA0UdndhPqjQLZupQTLg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEs7LQ15JYU+h+GvmmE15FMjj+jK9vWjszep76
 N/7j+DnGuOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLOywAKCRCLPIo+Aiko
 1auUB/0YiI8y9HJuL2UVQt00hcYEtprQ2lks+FUovYIMXsYT3iNFlLzGN1WTCFLxQwr8VpzZ1vN
 2QnReFAchDkQYO6NFgzHfMiNbdveVL5z2kZiYMNosWQ6rdrC8ki5r+b23vz2LrOv6tF8Ptyw1Mc
 qd2SHhcz6Z9I7eg7Mtw/RbBcArn6IBG+LHyQpdtJl/D3Z3YYgJNQJkRd/h/topE982IOE97TJEY
 nLkPs0YyQEYv3/dx8Dpa53BZZeeuFtvCHV+3pnTvCeZLMCAxh9Cf1qgslr5pwP6P1wU9kn5PJzp
 0kFUCqj/sJsnbNnlvwoEviCNWc3PYYhNMP/j7yHCqWaFyXv0
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM HDMI driver supports interlaced modes. Set the corresponding
flag to allow interlaced modes on the corresponding connectors.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 4a5b5112227f..643c152e6380 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -336,6 +336,7 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi)
 	bridge->funcs = &msm_hdmi_bridge_funcs;
 	bridge->ddc = hdmi->i2c;
 	bridge->type = DRM_MODE_CONNECTOR_HDMIA;
+	bridge->interlace_allowed = true;
 	bridge->ops = DRM_BRIDGE_OP_HPD |
 		DRM_BRIDGE_OP_DETECT |
 		DRM_BRIDGE_OP_EDID;

---
base-commit: c4f364c621d0d509190d673d80a9b23250607b4a
change-id: 20241019-msm-hdmi-interlaced-1508c1dc9bb9

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


