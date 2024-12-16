Return-Path: <linux-kernel+bounces-448263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BC79F3DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7378D16AC66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999101D9A7D;
	Mon, 16 Dec 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cm/rg9ZA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602511D61B7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389688; cv=none; b=Ukiddf4T6rJCWm/wshImZpygreJEKr+JEC22tA9q0nodGwSmvOnfI/G8b53cBDchAL2DvvXzqfwyN9fdL7fi2MhM+n7Sm5lDopajE/vVqomoeLO5okWZk1aqj+kRUASdH/wRWlV5RxEikjHyeopcUO5A8ihDsKWT1iV0ida2l88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389688; c=relaxed/simple;
	bh=3Yv9HXZbZ6qFS04G/TTVkzxJkRaupXuzYL93ruy4RrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttSXheHkkExBCzmTlk5YY5pu4pJJxf0PLeOn7J0NTNTS3iTT/Ov9rV5k2FKxDCIDCP0CNABB1yH4rOyqE39HDxrRR2JrkiuJjnG4hZs3zfRk23GBdWLAGzuq5uCZPGMphao5s8Cr6R0V7xeBlBVS2bVaux1sbeIp3LBPLAc4ltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cm/rg9ZA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734389684;
	bh=3Yv9HXZbZ6qFS04G/TTVkzxJkRaupXuzYL93ruy4RrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cm/rg9ZAzJp+Ba1aPf8zhm6N6tEvrGa7bWdhx82EL9brhfSMaNLqMzq2Gf5m75ZKb
	 KtIDHWGlU0DSStagLTq9FqzCcb91NnXLb6TRVBUXr25MEsvkFa4D4iLRcg5rtaZmRA
	 fn2TQEpDbbptzge0WpqiFDX5njooUt7ZplzdoaYvw+GpvPGVfHTwsa3GOrGqCMNiLK
	 DtpA/ZEe/eplP1iJ0BOn90d3q6AORm+YGfUfL+ojwyO8uzezYlyCmYFqF5Oqzv0aKH
	 /T8iqlWbamMhK9y3YoJlXkdxe81UzalQt1QH7MDw4zh1bC5WDMd9YGAk+jQLJcwVsV
	 dFQxiP23D/sGA==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 41D1717E3834;
	Mon, 16 Dec 2024 23:54:44 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 17 Dec 2024 00:54:08 +0200
Subject: [PATCH v3 2/2] drm/connector: hdmi: Validate supported_formats
 matches ycbcr_420_allowed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-bridge-conn-fmt-prio-v3-2-3ecb3c8fc06f@collabora.com>
References: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
In-Reply-To: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Ensure HDMI connector initialization fails when the presence of
HDMI_COLORSPACE_YUV420 in the given supported_formats bitmask doesn't
match the value of drm_connector->ycbcr_420_allowed.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index fc35f47e2849ed6786d6223ac9c69e1c359fc648..ca7f43c8d6f1b31ef9d3a1ee05f4df930ecffac4 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -507,6 +507,9 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (!supported_formats || !(supported_formats & BIT(HDMI_COLORSPACE_RGB)))
 		return -EINVAL;
 
+	if (connector->ycbcr_420_allowed != !!(supported_formats & BIT(HDMI_COLORSPACE_YUV420)))
+		return -EINVAL;
+
 	if (!(max_bpc == 8 || max_bpc == 10 || max_bpc == 12))
 		return -EINVAL;
 

-- 
2.47.0


