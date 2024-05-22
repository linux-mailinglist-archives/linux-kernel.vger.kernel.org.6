Return-Path: <linux-kernel+bounces-186082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06AF8CBFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546DD283A06
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5884E1F;
	Wed, 22 May 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wj/TX9kK"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99E84A3B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375070; cv=none; b=qC52+8XfsxdeV42f8tVcva0i/0aY86EvpWHH5GTQ3E4lXX2Ga8JDu4snE7H8qzbzgH0I5mtrYmVtQRN2/bP4u8aTtiBvd31ll8CbGdvp36k37nt8Dz120LFpnM0myxPJhobWGoTbZKsOAshfCCZZeIbAl+/Ec1T4fFgl3NU+/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375070; c=relaxed/simple;
	bh=5oIxEFONp2G3t75XHmnnmPd77025c+YPgV0mxBOxves=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuhQUUvm5QxVCx1b1hifaaD0RqCZZQiNt8LjgdeDYftQhcg/vcmr82Dpf/lT3mbYg/P2Us3HcZxjNUS1MYNy8xIoEV2Uen9GgWs4VlEh7whvgHPm/DCTMjkLrTBJQ/qlyJYhagZosOkF3L8WyUthw8akT4EEJVEC7/tfphi0/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wj/TX9kK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f174e316eso5817754e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716375066; x=1716979866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sH41O+MLWcEGoOFILncrbRDXVEgD8N3mxfmUHLQKrxo=;
        b=Wj/TX9kKdwRss81wRUIYQ5CRVBcSyNG13UUx1ZSJhnCWBS+bN6Vk9h3aJ+Q8Pkga5O
         0jc5XmQCPFDI39hxSLXQ8msI51vGWyK59XOphMCn8juCIE4/bVQnLv7aGmSkOP3Vs7Pz
         vV4AfxK6o4Ifa9jU3asTDqrLBZlPRmEcz+QnO0ttJru7fIdEkAQQb9jpH6wN9gfbZgDZ
         xBHTcMpf/MiajyJPqvglRjDHJqDJGwPi8YAnm5UXd2wRLxB/u1yA6PhoaSDewaYjedh/
         7ofZXbMpX4yUmuXmdYYFA57wo+tMbtSpYdr1QANySB+JrD4PVbN0kuIhYyJjS6M2dTyq
         +PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375066; x=1716979866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sH41O+MLWcEGoOFILncrbRDXVEgD8N3mxfmUHLQKrxo=;
        b=NTAxbYiBjXdFQWM6J9Kin3dx3oxQLUUrnyr0l5qiamn+QrhP//lLzGyILYQLpAmOi2
         z/mr2PY3TwbngSxu9gkNDk9KvadDCgWb/IyEXGBnwkT2q9eMmZQu6hBL/QJw1eo0EUIc
         HMe2K5WkXsfQRkENxGCPes0ydSUvMxAY8y2bLuEw7CQaOOCwDBLlUtAK+li9HhAfZILk
         4h4Bndia8/kE47y6MdwR3OExH2jBNU1qgX/cL7ijuyfLJNriJRWbQgRlzICPYCNLAGgc
         1mS2t6ALceLFWmYBVRM5XnW/5n0rkhsAP2PklqYlNvA+GMgsL7AQcn4FgLflESAylZKF
         M0SA==
X-Forwarded-Encrypted: i=1; AJvYcCUHGeiaMjTvw/IXRtBSGupAbntsV0aRtD9rjUzGmIDiMHya/AxTeelOMWR0W4qnkMPvC6DuUwRqNmJI1+60pg0u4yemsobHAtdNMp8E
X-Gm-Message-State: AOJu0YzvWF/hhuBqURt8amoiZ9m0HzugmaC4vamhzy823KLF2sICy7/p
	9N8SveHcHqWTUA3Mzqn6/22iw0VighFujRyVtse2ml+c6K20KwxUBHnGbwz1VSU=
X-Google-Smtp-Source: AGHT+IGCxr96bjX8x1MG+g9F95qGyDTdggpyJqocrQW/lh29CygQ0vqX1n7hNrmg1HrGHeu4jOLkDA==
X-Received: by 2002:a05:6512:239d:b0:523:6354:881e with SMTP id 2adb3069b0e04-526bf82d6ddmr1341359e87.39.1716375066683;
        Wed, 22 May 2024 03:51:06 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52431778ec8sm1279126e87.194.2024.05.22.03.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:51:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 13:51:03 +0300
Subject: [PATCH v2 11/14] drm/msm/hdmi: expand the HDMI_CFG macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-fd-hdmi-hpd-v2-11-c30bdb7c5c7e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5oIxEFONp2G3t75XHmnnmPd77025c+YPgV0mxBOxves=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTc4QI5yArcsRgIC1Y5yDdP4FZ3iATW4eltThT
 TQdTVy+bJiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk3OEAAKCRCLPIo+Aiko
 1R0yB/4m6I8/Jn6RfH4DWx6uVdIDZq8+GTkaMxoun5+Z75RRwIBgaFMUeP+IcJTMIJrdQqZ4elt
 DwLqUTU10+3iq8msyPPUrOm168PRnHpiR/R/z9bpquMLQ3folJJy8ss20tOqwdO79yCGJNDm7kj
 /lTzIDraU6Yvjrkzp+lkWsVn50eehgungQNNl/0t695TOt4CfwGMUXFCJKhFNetbYeOb6k/tvgS
 eXkuclZcuQztNyXp+W4JlYGEquZT85pNDH5RtTLW+DcsXEH5J0md45zD9mArVGIgNMMbnHhzvCe
 g5kUTL/W3PO+9QdbjRUczy9tvLveerr/9GEBVQYOASrvtXLR
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Expand the HDMI_CFG() macro in HDMI config description. It has no added
value other than hiding some boilerplate declarations.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 16 ++++++++--------
 drivers/gpu/drm/msm/hdmi/hdmi.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index c39a1f3a7505..e160a23e962e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -223,24 +223,24 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
  * The hdmi device:
  */
 
-#define HDMI_CFG(item, entry) \
-	.item ## _names = item ##_names_ ## entry, \
-	.item ## _cnt   = ARRAY_SIZE(item ## _names_ ## entry)
-
 static const char *pwr_reg_names_8960[] = {"core-vdda"};
 static const char *pwr_clk_names_8960[] = {"core", "master_iface", "slave_iface"};
 
 static const struct hdmi_platform_config hdmi_tx_8960_config = {
-		HDMI_CFG(pwr_reg, 8960),
-		HDMI_CFG(pwr_clk, 8960),
+	.pwr_reg_names = pwr_reg_names_8960,
+	.pwr_reg_cnt = ARRAY_SIZE(pwr_reg_names_8960),
+	.pwr_clk_names = pwr_clk_names_8960,
+	.pwr_clk_cnt = ARRAY_SIZE(pwr_clk_names_8960),
 };
 
 static const char *pwr_reg_names_8x74[] = {"core-vdda", "core-vcc"};
 static const char *pwr_clk_names_8x74[] = {"iface", "core", "mdp_core", "alt_iface"};
 
 static const struct hdmi_platform_config hdmi_tx_8974_config = {
-		HDMI_CFG(pwr_reg, 8x74),
-		HDMI_CFG(pwr_clk, 8x74),
+	.pwr_reg_names = pwr_reg_names_8x74,
+	.pwr_reg_cnt = ARRAY_SIZE(pwr_reg_names_8x74),
+	.pwr_clk_names = pwr_clk_names_8x74,
+	.pwr_clk_cnt = ARRAY_SIZE(pwr_clk_names_8x74),
 };
 
 /*
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 1e346e697f8e..2a98efa8b6bd 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -89,7 +89,7 @@ struct hdmi_platform_config {
 	const char **pwr_reg_names;
 	int pwr_reg_cnt;
 
-	/* clks that need to be on for hpd: */
+	/* clks that need to be on: */
 	const char **pwr_clk_names;
 	int pwr_clk_cnt;
 };

-- 
2.39.2


