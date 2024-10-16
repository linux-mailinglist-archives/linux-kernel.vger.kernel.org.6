Return-Path: <linux-kernel+bounces-367505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008629A033C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BE5286BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE21D1F54;
	Wed, 16 Oct 2024 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhaTvycV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E041D131D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065252; cv=none; b=T1+p1ZCrZLfiMbxeP94vSruuan63l8EN/3AxWF1vVUq+q0nBAi1E27afusx2mDwHQsAI1mzAReQonhKN0KaQvsobd+WzU89f0CDwxyXvNyU5BXLW1WBp63I3oF6LMnsLoal9N9vlkKPn93dG+iMitS4p+bwnT0YzNaP0wmiSAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065252; c=relaxed/simple;
	bh=OSwFL9mlnhjJaXGcg2Cq/PchumX9pUvEZoNUhnGlojE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bB9WPLf981bdwdNRrndcVos1lw7FspgNDBq6YEdn+v6h/w/jK6jLUB1WYRou2KzVY1CRR+mE9hHFKD/aesL4eUtlRRZ8BnGzgnM3cS//00IXtSkifpdUpiYE6MECJsnFV62tFAAqtcM3i73bnh4mJyYrCyjDAmG2Rv64dtcCZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhaTvycV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6965DC4AF09;
	Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065252;
	bh=OSwFL9mlnhjJaXGcg2Cq/PchumX9pUvEZoNUhnGlojE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZhaTvycVF+SuSaGailU+cxW20qvoL4Jo/5hPU23XDs+Hy5N82L8ZPu+19WHAgKUpj
	 syrHCX0F+Jf785AbUKCj5vSdZOro5jU4pOk0s9CC3Gn5hZSTHBfIt1ITEmt6Piqdkx
	 H0aNJLtmlYZKWycF4UUmUbfHzrVO662bLjAhXoURb9y5P6t7ryDyuVE0Qw1C3uDm+W
	 /CuCu0UjBRis+p+fXm2o99p+KnNx/Ov+9aWy0GFpH8wnBDyoYZY33bFJ1S6ynXFojw
	 +Beay6b21sJxsGeN8SYC9sZGb1S9UBFF6Z10FykTAcFpnID7FVxHILHpJxYa9fMpj5
	 GNmnDXT4qZsoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B92D206AB;
	Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Wed, 16 Oct 2024 15:54:13 +0800
Subject: [PATCH v6 01/10] drm/bridge: it6505: Change definition of
 AUX_FIFO_MAX_SIZE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-upstream-v6-v6-1-4d93a0c46de1@ite.com.tw>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
In-Reply-To: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729065263; l=842;
 i=Hermes.wu@ite.com.tw; s=20241016; h=from:subject:message-id;
 bh=/GxCXKfDVzA54tJySiQh9RTDiRxXSmoD1seNualt4Bc=;
 b=Iav1qrUpaoLa1HrMvzluz9qcafJhiQ3CBIo3wUzLV1IaZlQfhspjaHRIMQvIztFRr0yR9i6TI
 jrVHvH/4iz3C929mC+TAU3Rf/G3EJrH7Mil1PMQEdGL+2X97RwC7L/b
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=kV18uQEXox+1WccdQceCbMlJKN+BBNUk3N8VsoULcQ0=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241016 with
 auth_id=250
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

The hardware AUX FIFO is 16 bytes
Change definition of AUX_FIFO_MAX_SIZE to 16

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 7ff17aa14b01e4d9f626424e065131ae2b195c62..3272ca6951f2585f9592834869de23ac50ce41a4 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -300,7 +300,7 @@
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
-#define AUX_FIFO_MAX_SIZE 32
+#define AUX_FIFO_MAX_SIZE 16
 #define PIXEL_CLK_DELAY 1
 #define PIXEL_CLK_INVERSE 0
 #define ADJUST_PHASE_THRESHOLD 80000

-- 
2.34.1



