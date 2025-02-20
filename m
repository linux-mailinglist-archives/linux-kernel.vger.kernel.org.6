Return-Path: <linux-kernel+bounces-523339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C014AA3D546
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA3B19C0A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E821F2B87;
	Thu, 20 Feb 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joasB3wm"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8551F153E;
	Thu, 20 Feb 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044727; cv=none; b=O7oCOrz8Y57VI+iZp5Czb7jpksMIXn7vlcBHBOao3DcgWhjaWVxufdSWDD6Skg/vyIvoHvL6YAraOHSdtKm+kRhZ9oLSvc9oRnVxvEpF+m9R2Cb/6whBd7nYv7woMhj1Fz4U36s+CBkESOw2L9dWY/vM/4Cn1fgisMQWbJPsiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044727; c=relaxed/simple;
	bh=YT66WwV2V7Snh39UYf5bvUgHvWgfG3j3TGazklGz8Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4gY0NRdfdPEGXJRIZTBsYht3SuA6vwYUUFV8uMmIcleUF+LeZFtcpvD9fBkHUr2lCej6/wXKbugSSiKGGCDDVkJd/kgK83jcQYjnwoeGM7NXShNv1k+vWPDIWNTzSa8eleg90VITOkvxpplv239WxDaf2nWFvItdVjCMgZBJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joasB3wm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30762598511so6677331fa.0;
        Thu, 20 Feb 2025 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740044724; x=1740649524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygy9fOgk6MRr8NA0et8LD0ypbUW05zgOvC6SdedZlXc=;
        b=joasB3wmNScyyxVZ2jknjDhd53kUN06e44Wq5/r7vEte0Xi8m1D9t6DU7B0wl7WbO9
         2UR0vjaIv/nv8v7V64Nde3EQDF7UjGaUEjD+VgirD9tyOF32uZMmqBP3j0DnsIEHv04E
         /GUNy4T3tbWltJwp3Smesc5F+7XLau4FvJMBQYuR9VUzp2D8sorAH8srr0gaA9aYcrYF
         NecpNDLhKdWKdey3w5VMPTaUcUZFD0u8/6/TrdPY5r5UguiyvaX0wE8L0hz/wue7QRLD
         pJ06q8lV1dRO1rteK57GgrpPnYWjsBq5s2av7PbpK6P9at4bv4wiCy4Q0nrO2CbFmvO+
         0HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044724; x=1740649524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygy9fOgk6MRr8NA0et8LD0ypbUW05zgOvC6SdedZlXc=;
        b=IWMoIjDo64AGUA2YqYBUOea+n8B/xgxoTdi5/HDS+rdgl1DOkR88GzxpBaRt2w6tTb
         6d2YieKENHVrIgsaX2SPFKY0h5CRbvMiCoCSMnpcBIXYPeTs4O07hLx3xsWtH7zM3URj
         8mDrbDvK7oDmPDV6bGM/TU3z3c3TTdN6wrRMaXBr5gOKIZarCBmdhZNAL1kWyn88O1IG
         /vPDtjTXAFD51OdZvTn5boX+aH+17QIRtrH3tdTTiY52N3E9wStbYzxuQpjeAehnMpFk
         rz0LDdBUEeKhADNN9BDkjgbMV27VqWFnTQY8aR6Ifz93i3eaCCHyjVOxvw/+jPO+HuZY
         z+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ldFuv9uC8nzQeCLyjwjjfY0FOuxVvCjvA/Gh7tlrYxog+SCCwS1F9f+9jYHN0UDe7k42T4dj3F7Y@vger.kernel.org, AJvYcCVjpz2gKJHGXt7Ihi1Vzhl+2WpjgghIXeWH5ktUNV58rzWunxN1xZnD4v8hajxAqmltjI4AYdwu6+JrUvdQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzHoPgP94mCSFptGDjow3+TRTe/vwBjFUJvrBs8EJx8PZWQ3jlK
	dDjGM40lfs5CPAFhx228oJRNZNFa9eszlLBFfJSNq6TilS3IAXmZ
X-Gm-Gg: ASbGncsblr3Wn8JRg+GT/PmDkdhfRlj9QhecffTFvq4RTX0mPtteif7FVBuataMcseQ
	8QZCjNA1EKZvZCwQTBiM+ogwKQbh8qvbkQHxI1XjhiQNHJCSzeSSjwibIv/CH3sFuPoRI+LOmOn
	6pU+F8U7VrgcBOdGDBwXfwmlhrugoam/J/DuSJ9UrEI15PuAQFR0Ij9/nUVPqNDBn534sFuezjj
	x7I6NliwdtiYXyINvsj5/Z97BT7d9BkUbcksfCQov9XKzSytPQ6vk7g+DWRiYew2rQujY25/XVC
	6eiZDUU=
X-Google-Smtp-Source: AGHT+IHtiyfeKeppq46ihJyG5+Xx+dlbk3UXHERlc6GLGvUym4f4iISGaaNk/JL7p9AhyTZamk5CDQ==
X-Received: by 2002:a2e:8618:0:b0:308:f827:f901 with SMTP id 38308e7fff4ca-30927a632cfmr61727621fa.21.1740044723649;
        Thu, 20 Feb 2025 01:45:23 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3a0d1c2bsm9574311fa.11.2025.02.20.01.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:45:23 -0800 (PST)
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
Subject: [PATCH v1 3/3] drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1
Date: Thu, 20 Feb 2025 11:44:56 +0200
Message-ID: <20250220094456.32818-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220094456.32818-1-clamor95@gmail.com>
References: <20250220094456.32818-1-clamor95@gmail.com>
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
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index ab0b0e36e97a..c0f1f7baaa37 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -277,6 +277,11 @@ static const struct of_device_id simple_bridge_match[] = {
 			.timings = &ti_ths8134_bridge_timings,
 			.connector_type = DRM_MODE_CONNECTOR_VGA,
 		},
+	}, {
+		.compatible = "mstar,tsumu88adt3-lf-1",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	},
 	{},
 };
-- 
2.43.0


