Return-Path: <linux-kernel+bounces-541667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7DA4BFE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7329F3AD881
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138B20FAB4;
	Mon,  3 Mar 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXwRC8vR"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5020F082;
	Mon,  3 Mar 2025 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003518; cv=none; b=jBCazSf4CiyGDP7/2j29uxSao52RI6sDI4dVc0K5u9BneUEyRXRx87Qtje/NtInwqo13bAlEwblbHQGUyasCM5L5/sdtH4rL5XooYgHGH/zyBEijv2qxYGYx1mU+0uSUIqnWTf/7cuHyn2v2BoN7VOvUbGv3VXTfR/szQ9Cfqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003518; c=relaxed/simple;
	bh=CGhXW5tXeDv53QOS8bvvPoirWCGA2+4uVX2vcW7fVz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhuSz9uWXLivsNoNe1Oal3bXZsubLUtSNtSW/FHes/HQxfnTLMYAFE9gkFqtk7BgjHV9m/NlOy9LtA0CdJG6ynGISR5jUpSyduJPh4UcJqyAmrCdC7iTs/ltbHD+seyg087gWKU4X3dUU/J7LWwAacOmscZzKjtdMli0rooaMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXwRC8vR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54298ec925bso6594290e87.3;
        Mon, 03 Mar 2025 04:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741003515; x=1741608315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QAnF6RQJWxSSGLUa+yOoR8YIWrn+p1dbQGhI+0L21k=;
        b=gXwRC8vR67nkE+juUIRvwbTg7OBxLic/NW/7f2HjNNsViKNm5JIRHeeT7WDG5iMCyj
         jM+c2DpAjzMKCRa8ovTnaHAqRdgGtIOClRWs7UyMxLOimkuuZ4jc67HQdZvLHdL5ImYj
         X7VGs0d+PLwoIxaNLgYayL9FMVP1SGYV2TYnwETsRO2qwF0Z0KAGDQRfZurMJQtSDcV5
         NPTLAytJiuFTIBw2tl73r8IRdMeRj0k2J7Oqgxz1dFs2Qd5Sj1cUYZ3sjvBt97eX/u8m
         pvTrxb3X6P+/JKYevycj2t8zcnCg5PVz40r92w2GORtGin9QeV+NkR7hmcG35p4sD5zs
         gdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741003515; x=1741608315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QAnF6RQJWxSSGLUa+yOoR8YIWrn+p1dbQGhI+0L21k=;
        b=s5pi01GTAnd9m+evfElzRLuFdsO/k2BJ3busUwzGDeu53bFkFKBGfVhkzesKHCgdhF
         kiH3PDQyP5JTUvBxRwzxy3RcrV7y/blKKvY8EnoZNZvR75SxIFabtmbVeOh7RWaNkBjV
         IHY6Knk64S9DGUar/Yhuvlsy32fTlvVyVR8ReQas1LlaOuTTB6x+pw1l4vw1L/GEp/Ci
         K12g9JFBb2HS6+2Tj2Jrca37dH42FbHufFi8r3GQUWaGibP9eWLzOnL1UwOBHD+RehFa
         TP3neO7we3fCImntJxGtA3sbqc3xKy0H1LPAzVCmiNxW9CNMZYiyuBfQkdovkSbcYhhA
         yqOg==
X-Forwarded-Encrypted: i=1; AJvYcCWoxOPw9/0gkB8o2fn3+GwIwR5l2OZDHrA+DGCA5oBTx6+skAb0iID98Z0BIgP7DGNpUPtOINPLbe65@vger.kernel.org, AJvYcCXpliEU3bdTRzCLLR5anTxiZKsAihpx2v5dQ5qj8lbRehorOnm9u/RDXbgaGO7wqQHBFypDVMUDUiUMCujv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LrGnOMOlXn3i93NEt8xz8ZwFRgRgJJPicbxxGRAjkxz+DO7R
	y0Sv46H77kEU12uD8nuBlTmtMgZ3UjT/aYn5By2SC1m8SVrsjglP
X-Gm-Gg: ASbGnctEDUgMWLBruYlPem9UkZx8KPSKU+nBtSJC2eGP4k+VqkIElehqiTp2fxNzsen
	aChGVjF1YcOeWkUtu6vsnhCEfy9pf+1iRi5HTAZBTSaBwdwTk12wmo1/ACrRn4Mya2kN9XpCuXz
	WCnTrb6POpQRB9owIc/uaggf8bcrNodsk5Hv98y0rQrueDlTpSu1SQNQOMI5ZPU5YxVYqUMYx3f
	ZZa1/8A0h/3oWb5rGZl5gBGp3OUwrG/ccM8neR0icmtnJU49hbjFu+eG6pKe2vPeFHZBg836KqD
	o93RYsmPjPo3SZkxpn1K5GGIUVLbHjmzGX5K
X-Google-Smtp-Source: AGHT+IGPG9b9iOwWJgfgUYhvGwxh6t/u8yLGFycXLMXLu8hbCQSS/cBxDVOzJPoM9NjK5sJrWRu1MQ==
X-Received: by 2002:a05:6512:281c:b0:545:986:1a0e with SMTP id 2adb3069b0e04-5494c332d96mr3966260e87.40.1741003514670;
        Mon, 03 Mar 2025 04:05:14 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549576b88d9sm869095e87.12.2025.03.03.04.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:05:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1
Date: Mon,  3 Mar 2025 14:04:55 +0200
Message-ID: <20250303120455.90156-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303120455.90156-1-clamor95@gmail.com>
References: <20250303120455.90156-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Schwalm <maxim.schwalm@gmail.com>

A simple HDMI bridge used in ASUS Transformer AiO P1801-T.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index ab0b0e36e97a..948300378cb0 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -260,6 +260,11 @@ static const struct of_device_id simple_bridge_match[] = {
 			.timings = &default_bridge_timings,
 			.connector_type = DRM_MODE_CONNECTOR_VGA,
 		},
+	}, {
+		.compatible = "mstar,tsumu88adt3-lf-1",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "ti,opa362",
 		.data = &(const struct simple_bridge_info) {
-- 
2.43.0


