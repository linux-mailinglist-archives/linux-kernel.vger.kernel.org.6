Return-Path: <linux-kernel+bounces-394276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A649BACCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522BD1C203DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6481AB533;
	Mon,  4 Nov 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P28JK9qP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB318E359
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702647; cv=none; b=UOsFK9WEZy785KsvxgmES+LQ9AlW+0pgIN69hUaotQd0X+AmqeAG4aoi2/RHFnnazJRWH7hWm/c97t3A/knKwvZcq6JuM1TyRgNLLDxl+JdyE4Ei/ub3L3MPtoIpuD2FOspPizjO/M8gDyeQ8nnVAtH5qZtig4vDZy8OahcLlfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702647; c=relaxed/simple;
	bh=H/QjnbdWcGZr/3yVhc6hw87LffyFcEIL677anYJofeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2dPcQBEikPK4sUPUJj2MBTeN60dF/iIsGEIGW6m9uvSDdwQZgNhKyzAY9QARFV679Rec8FiJAMzVT92SI2ummzn7M2k6WGzsuxUErd/ZagToqfnr6KqkA6xyUlygol3yg+ePN1lU+Khh6lfoXSliPpxACRctvRazsS03yil/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P28JK9qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D92C4CED6;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730702647;
	bh=H/QjnbdWcGZr/3yVhc6hw87LffyFcEIL677anYJofeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P28JK9qP/OHZ1ya8bSaFlfklLg0nBFffExIla05U1Q9nhFXjpqGWkZs+BM1q+OWVi
	 Dh1quuYZ62OiBVwytmTo0G0To3xtWFnxCRcInzlc3riG6Utxb+Id9Lc7dYeYmxP/9T
	 Q9sI60RcRsPr+7XbTuxCvvdwJ4GFhbhILMKkASgso+Pzt4eR5/mF7q3oavY5RlYuG7
	 fwrwRaNXR57Xw2keG2u5iUjezZ20NUUyYVeoUjrfpx88m3h+Q0AnmF+NfbboQp/v1f
	 ZIR6LXi9IkMRTJZbrbJcDcRYee752LNZ+leqTSZt0pqEBVINJDBAAnt4EE6+q8mBXc
	 IvKC1r2QzbpRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F55D11183;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Mon, 04 Nov 2024 14:43:31 +0800
Subject: [PATCH v7 01/10] drm/bridge: it6505: Change definition of
 AUX_FIFO_MAX_SIZE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-v7-upstream-v7-1-8b71fd0f1d2d@ite.com.tw>
References: <20241104-v7-upstream-v7-0-8b71fd0f1d2d@ite.com.tw>
In-Reply-To: <20241104-v7-upstream-v7-0-8b71fd0f1d2d@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hermes Wu <hermes.wu@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Pin-yen Lin <treapking@chromium.org>, 
 Kenneth Hung <Kenneth.Hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
 Hermes Wu <Hermes.wu@ite.com.tw>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730702658; l=903;
 i=Hermes.wu@ite.com.tw; s=20241101; h=from:subject:message-id;
 bh=Tyri1iviyPfgpFppBgVRv/Ms7xTN8BMh3eiXrgG9mds=;
 b=lTI2ZtSC6VNL+p4Q4yHm0ZqIiqLYKVMLvEe5vs+1U75vgwn5QWzERYz5K6C82TieoPwrXezr1
 aLR0GAvHkItDoDzOOsSSF660O3ICdtfMhw2y+YikN33AiePmMRaH4CX
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=FOYYbsP2Nlw6mjB3rLFYSLmAiENzj4AWQly5XTcDuMM=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241101 with
 auth_id=268
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

The hardware AUX FIFO is 16 bytes
Change definition of AUX_FIFO_MAX_SIZE to 16

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
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



