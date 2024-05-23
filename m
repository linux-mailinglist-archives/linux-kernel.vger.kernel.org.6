Return-Path: <linux-kernel+bounces-187511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53688CD2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F7E283C46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46D14F9FC;
	Thu, 23 May 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YEppVM4v"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1414F136
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468584; cv=none; b=A/9VI7eZq05MMWp+URXEq3EaZ8ElAw/wqDVgjMOPVV3jtSYkuJ1N5Q6yqLQrwo2rgFdGLIdKv3HPuY0GyfuTrDgXNmDoUd9pLwSjeyM+n7KhN4W4FBkunBMHriVpuw8L+JNe6ZbleoVnQXYkutUbS2lvGIEm+oEK8GTemWtFRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468584; c=relaxed/simple;
	bh=/0McRX6GoM2+nGIkWn2jaKs7S924L4q446vEYfmzgP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snPXm4b3p6Tzf6Hhh8uZfI0LE2/P+GGL9pBIe1ypZTCu2tR+osfBiYIiyR89p7lQAV4cL66F8u/LwezGmdFqTfVZnS4+bCXV7RHgGASWsKPa5MgoDPRLTAcHTgdyKllUJohqTeWfjfIMYEEh7I/2nBxz5GKNOyQTwOwngVzF2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YEppVM4v; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354dfe54738so1384338f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468581; x=1717073381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28zbSoB8+Zxd+IxXtMzgHHKE2gbwNBphtmm6Xt7tCzg=;
        b=YEppVM4v+NgHGBpi/QcQPRfZhw7NHTJFguLXdr+fm7OSjJEeJqAJPtOJByCUBwRpV2
         bchQhC+4w1Cdsgob4F6SF46M9ipDYXxXVLRoB227EmHQd9p7uhpfnIpRm3ABCCQVgYib
         STUg5wbCQEMsdquS/uaTslrwdLjPg8V8RyxxPe4N/Trc8sSM4TOCP2AOHg/QxspT+QCl
         raUTPN8KMVd7VfHOSdqIL/CJouvSEJmKMP6TvGdt+T+7avrOkYtvn7HnPNwNltPT0Nkg
         9EMIC+KYEzi6OzkwU3FlIDn3XJDIPRe1+/5Ex/kiEQ0V6+gQgTPHi2FcgZ/fFsAf79qF
         iogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468581; x=1717073381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28zbSoB8+Zxd+IxXtMzgHHKE2gbwNBphtmm6Xt7tCzg=;
        b=CcCINNBlW5be6qslStlwHrfW3u4LJDUa7sQj9tbw7VeAbYyYVDvAFbvuVH9DgOyGre
         PQx8pa8QwlBspkzl5sgNl8+hGTFzosKxn8/pungEjufjhi2myrfp8KST85azZet8ezr3
         fP2SYQJdeEswv32TOKaPpKoswqlALhjm8tKkE3JVOlFG1tloOUGoOTn/zARhu4Tsj9Di
         HOI7qNABCSW26tovnCzzuqeftt3k+YwOesVmxGXoSs3Ols6y1IMUUeRziUoVO5gsFu5r
         MojmlpRTlIw7bIfoSuD3T57A9tRs+hxbegnyLa4pSWYj7MyBDc7IY4Mk/DMM5tIAt7ET
         cr0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFx1wZQ85ujp+qqHSgm/ywnYIi1LaL13TtObdN/6+LB8TEBpVuFzhWN4LeNyVSZFpM6d+QqErqRLFPKdAxwFBGyY1sxOIvRXL6M4CT
X-Gm-Message-State: AOJu0Yxv6G/nfcwFM5BJxlXXe2o6uE++1esmxd21/o3BibMeGlERFHcl
	+rwzf+ik6rcyx+qWkpMZZ9TOcuHnOwEDVKUuMzxneS09BrfPViogDsPpvOGPk5u4Fb0i6TecuKZ
	/DuE=
X-Google-Smtp-Source: AGHT+IH9I1yKELxeEkwniF+9niwDJ4iWhtTnG+NlRhabW9VWGojLsvUwjFjxu/LmyLyU3/BR1jPY+g==
X-Received: by 2002:adf:e586:0:b0:34d:963a:12cc with SMTP id ffacd0b85a97d-354d8dbc8bfmr3661763f8f.53.1716468581288;
        Thu, 23 May 2024 05:49:41 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:40 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 14:49:24 +0200
Subject: [PATCH v4 11/15] drm/mediatek: dsi: Improves the DSI lane setup
 robustness
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-11-ed82eb168fb1@baylibre.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=/0McRX6GoM2+nGIkWn2jaKs7S924L4q446vEYfmzgP4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTlpUBxrslkpM9KkVJFXYtjbSrCv5t3TWgUxI5
 XUvLM5WJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURWb4D/
 9wTBNeGwtAKm9fDQEgY3KlVoq3aw7N/I6ggPNiqm7lu48cT3alLmUEiAEH9cxr+ooYaOeF6xddtH9N
 Avqu+Na9+0o38iHIVyjOU/IB4Nrily2yDRjDJA1hvhAiygXW4A1rr7erHlTrJKuA6b2//3of5lwcpU
 C2WinPN+uvFvTf8s76ZBBRDLcMwz1YlFJDVcMZtHf9E+dCO1TDJ/LJ2LpyUQzYxDFC7dL9ClMU7bDh
 aRUcvXBSGYj02LWSk2KUBxbt8uL0pLsU5egoPTh0lwNl9Q/okAbJ31MY9AXCM02DXK/fha8WOx3xTw
 JhcIVPZo1pHFDMBCXeO00MmXu5eMyLfszMWYIpgAVBUZN7zkaJTlpoGza91wmPCNW7lZPpZLunm67n
 EjdgwfwctDV8gmmcaZagkU1NzGw/gQPe1/Nq6L/Xvp0LLsWKkYd7IlR/WS8XGhf3akmBJ+njq09a50
 DygPcXf13zXLX9yQoQPT499tok9k750eiHUe7iwpZRUlxp//nSGY7rK7GyWBCNjVD488SyNYYHpOxd
 3ZvRpJi4DnKnKauaFbFvyIFAJZDd7xzJn7haovlEAzvWt1bhVWvKVhImKpOcepGVrhBx73DT2+2SkV
 LVMKKq0yd/o08BjawyKMV9I+MVYefWOReRhG1sp/k3yb1r9aGKSO7tNJcPQQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Currently, mtk_dsi_lane_ready (which setup the DSI lane) is triggered
before mtk_dsi_poweron. lanes_ready flag toggle to true during
mtk_dsi_lane_ready function, and the DSI module is set up during
mtk_dsi_poweron.

Later, during panel driver init, mtk_dsi_lane_ready is triggered but does
nothing because lanes are considered ready. Unfortunately, when the panel
driver try to communicate, the DSI returns a timeout.

The solution found here is to put lanes_ready flag to false after the DSI
module setup into mtk_dsi_poweron to init the DSI lanes after the power /
setup of the DSI module.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index e036d9394c23..cb546a9e9419 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -643,6 +643,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
 
+	dsi->lanes_ready = false;
+
 	return 0;
 err_disable_engine_clk:
 	clk_disable_unprepare(dsi->engine_clk);

-- 
2.25.1


