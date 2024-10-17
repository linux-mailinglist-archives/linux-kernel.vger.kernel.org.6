Return-Path: <linux-kernel+bounces-370063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87879A26E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E51F25F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3581DF270;
	Thu, 17 Oct 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s39LKMOP"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D31DED51
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179344; cv=none; b=PoXqM3NclybTY97vb92bGRGIJVOPMfpMhN49/fzSR8R6iY7jTEexKoRVSzmkiNQWhKLuT8E8297mxzleM/cz61qY/RKcD9mk8ib++WLHjYywg39oS4fFesuW40Jk1Tlt/7fseh65aW8LNEbNvx4vojikpm5CQd4WmXB+W1FmHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179344; c=relaxed/simple;
	bh=h9uykyfO7ScfnJqg9/bvlXoGMVQ8+VTobz4GllhZUUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gx9+H/6d+7Q4tCTOSrKEbw+C+EhXdwKv1FP7Qgat8uO7cWgs38Fqu/I1wStpZdNEVy+67hNj0Cn/2rz4VE61qMHyg8qUSJ1riHI0p7iI90qq2ZGb+QYrp/qWBMIwIEdjk+g0ASNLXWSDtoIeVhbO6vL9/JMnyd26HSKDYGH1IA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s39LKMOP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d518f9abcso813458f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729179337; x=1729784137; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqbcP7dK2aMJ0XNQaLg26ntovAXTjd5n1xguqyfCHr4=;
        b=s39LKMOPTxNTyXl+/TBnIMx0ybrM/OIX3IBLdB6rOOmJJnvTazrXd5vG92hNlTR2d8
         J8CCXi37eOdHaXS1zWvVS4Luzltb+QOylkWxNKk8QDUg5qmkGlJ7aI5DX0e+b4EPvEXf
         CVJHhTPm8NZuHuKJ6HyYXpmB1oeNpXdjw1j75PZz1a6WetJ58tRLnVGZ7nclGv37EWtg
         lunfrdCN6IcvogBSIU8ul4yIPT0Xc1aZXwlZ3w0HqlSfEYVS6G0qLaQmhmjotjH4tH5Y
         mwqCvKowCHTpAGY3NRM6SxdPXrs6JI00k8O5DfXr9B3CVLFqz6ji7P3DUM+bkFfrrL/u
         Z1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729179337; x=1729784137;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqbcP7dK2aMJ0XNQaLg26ntovAXTjd5n1xguqyfCHr4=;
        b=eCstb5RG1yjJzHr1VRhm0M1/u28Iq8z06jqikqBeNGp7L+Y1lTxHeXn25Bj5z8hnO0
         EVDh91ngTcqZak77UiOtOSn0APKe2aowkzVg1odHaQ64m17W2J3LXo0SgHOW5FojXdTG
         2q7zJxKcIkRwhcoN2YKdeT/sOETCGpOXdnjnG2Nz+Z8ij4UaWI2ea1wbGCrUtsTc/bjc
         X59yA2Obs0sh7Wos1MhypYLxrief7EywehoKkcgRxOC5Aim4e13tyWivfNlwvVxkhOly
         ks5ptivayVP34AHLaGB2Uzur06w6GH//NJBRo9PtAxdGfjch98yZgQ2Ic/L6rSAtvFTz
         A0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV2u5+k7UZ7cRaF17qbDwp8o+HFDsfloHwolFukEeQ4pOPRuYsp9M6AcDDFGPvopzTimF9Ts+74w6Y7oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4h0bOHhh4SHG4+iX0akLD1HsXOiJZrj+aoT1miDR6vsnmWrl
	xwSAVi33/AMA+jIB063vpEr1M3fFKELhzVCqDCOCxVKK6yUR70xxFm9voZhd6RE=
X-Google-Smtp-Source: AGHT+IGjWzA1J/qNb3pu7nTg6gpRfLQvB/Lxros9VoMUt1p74jGUDKAkWTtuNyFTXTsTiI/qZNI/RA==
X-Received: by 2002:a5d:5192:0:b0:37d:51b9:7f3b with SMTP id ffacd0b85a97d-37d86ba44c4mr4689309f8f.11.1729179337047;
        Thu, 17 Oct 2024 08:35:37 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c359casm29796145e9.8.2024.10.17.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:35:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 17 Oct 2024 18:35:26 +0300
Subject: [PATCH] drm/bridge: Mark the of_node of the aux bridge device as
 reused
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL0uEWcC/x2NwQqDMBAFf0X23IUkWKT+SukhdV/aRUzKBosg/
 rvB4zAws1OFKSqN3U6Gv1YtuYG/dTR9Y/6AVRpTcKH3zg8stnBcN36bSrNLtJlL4lwEbFgrhO9
 TAIbepeQf1EI/Q9Ltmjxfx3EC373dpXQAAAA=
X-Change-ID: 20241017-drm-aux-bridge-mark-of-node-reused-5c2ee740ff19
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=h9uykyfO7ScfnJqg9/bvlXoGMVQ8+VTobz4GllhZUUI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnES7CiAGU32p57bHQLiiz0jEimNZ5o5hlcba3q
 uMdixGM9pWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZxEuwgAKCRAbX0TJAJUV
 VsUuD/9Lyl7mb7MVnlV/bdmPb2jofWDLNNw990TrN25CZMT+6Xey4jyj66fPIsAvCQuOuLGK0cw
 tntfPGjUDUKhTwEprWx1ncGs9YHR/NPVE6yf16bCFovaMaPAKb4V07nzSq55Hv+outtijYjqVh3
 MKcmL9wmvkFSC9B89girNOV2SCH/oW0/oOCZ97UVXYRLsMx3MJ5+bEQSBgNj6VLrfrTAkSbvbZ4
 t5T3IPRbkj490bx8dTMNK8+HwmU4GehktikcASgWXIrc3x7pUU3D2Ilak8K6DBp21981MbZyNpN
 pzodZcrp8lR2peDAYGvKpSLLydwZQOTx/ZjTxt4w4dQyqmiiWzs4mCtniOhoZmX7a+zZgr8kKtO
 GZlJh0CRlnQuBcTmwH6oRd59m2ELukq7l1L+FTcPFdh0ZDixsOvwuxIsJzvfHObX+0ATZOWA635
 XQuGVKb3GM27unPpOoeiizlZ7zIVYmQcvsCfdBiPG/lGg2wuHa6TDK3jqUvEWzMv4aCMb1ci3D9
 JUDjyre3uERimQLS2TgbX7na7WfyqgW+0ClRAgLJO860ee9Bi6R10u/aYsHl1zxjmYtwukx/Rqi
 eCxLoyU458FrWNEBAoVUjWAhRWKKcXeUHOZGBrwT+1pLCEGlza1Q9dmsa2sHaXkntxwTuzpsAFK
 TxMqU3ZDBr0tLVw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

There are some cases where sharing the of_node renders different resources
providers confused about the same resource being shared by two different
devices. Avoid that by marking the of_node as reused since the aux bridge
device is reusing the parent of_node.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/bridge/aux-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
index b29980f95379ec7af873ed6e0fb79a9abb663c7b..ec3299ae49d6abdb75ee98acfe0682f1acc459f8 100644
--- a/drivers/gpu/drm/bridge/aux-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-bridge.c
@@ -60,6 +60,7 @@ int drm_aux_bridge_register(struct device *parent)
 	adev->dev.parent = parent;
 	adev->dev.of_node = of_node_get(parent->of_node);
 	adev->dev.release = drm_aux_bridge_release;
+	adev->dev.of_node_reused = true;
 
 	ret = auxiliary_device_init(adev);
 	if (ret) {

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241017-drm-aux-bridge-mark-of-node-reused-5c2ee740ff19

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


