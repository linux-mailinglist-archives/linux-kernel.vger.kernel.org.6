Return-Path: <linux-kernel+bounces-385061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D59B31DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814201C21AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE91DB92A;
	Mon, 28 Oct 2024 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="JGmD6ePJ"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3C38DC0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122851; cv=none; b=IJOS2ggAgRRenWtobSzPNTI3+WT9/io79FrOa2Oow5nx+B4+MJFOcLxh2TABJQkkttiCV1lUafOstjqxWIzz4gk95B4kqp2hJeWowZTvMa5w5b6zrE67XET7nI9+F9ozJRxfjYAAPRdPQ03wr2Dr+ot0+Wd87RDBS3js+JdfBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122851; c=relaxed/simple;
	bh=Z3QgBrI30/msXmDPJceTnnyYhSrEPG/2kS8Plg2+sH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORp2xqancw4p9vTbYFS8xkXCs4z5AnNFNGQwTeo5Mz7LNGBoUzyBMh4BgTDmUtU8EeV8kX1rbCIYKXD0KH+rGFfJwGRD7t5vx5AeCCpmw2730R91+nYoQ1vCWS3Fup3a8xaNnl1AMh9IQCED7cw38CNjZQOEQSMNnwYpo6kxDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=JGmD6ePJ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XcZK75skPz9skW;
	Mon, 28 Oct 2024 14:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1730122843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuPaYH7muQ+6E50D/hZ/FPeAmhYFh1B9WY+/CGXP/jw=;
	b=JGmD6ePJLdyNqUmEpNYA5tmL7WTHmkPHpPd+WNxAMn3lX0JLJJmqz0Flwg/0FBdcX9jShB
	ioumr8aoo8JhrZY8ky2obBNuGIDsUiHWFpCYZ1EfSEyBgWSwUdTo9Co4MVuaGpmZWDxdiy
	Ez2ttjEQYEgkqrWs3Uhq+6+lJzQkk/nhGcngAVGinQjCygmRXvPy7NfrU46wDcOlQ7fpo8
	ExjJmnyrckkz/NQocmuZifI2zzGxQReQAFbrEn6W4ameGg7VP+i2qMva9GRuxGPZbw53to
	aSDDEm+W3+sXw9QMMcdOwttxGomeTvwWx0sbjzx1MNIwi6B8wRxobTMN+iXm+A==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: dri-devel@lists.freedesktop.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: xlnx: zynqmp_disp: layer may be null while releasing
Date: Mon, 28 Oct 2024 14:39:40 +0100
Message-ID: <20241028133941.54264-1-lists@steffen.cc>
In-Reply-To: <79aca344-b27e-4b77-aa92-6e4c079486e0@ideasonboard.com>
References: <79aca344-b27e-4b77-aa92-6e4c079486e0@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XcZK75skPz9skW

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

layer->info can be null if we have an error on the first layer in
zynqmp_disp_create_layers

Fixes: 1836fd5ed98d ("drm: xlnx: zynqmp_dpsub: Minimize usage of global flag")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 9368acf56eaf..e4e0e299e8a7 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1200,6 +1200,9 @@ static void zynqmp_disp_layer_release_dma(struct zynqmp_disp *disp,
 {
 	unsigned int i;
 
+	if (!layer->info)
+		return;
+
 	for (i = 0; i < layer->info->num_channels; i++) {
 		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
 
-- 
2.47.0


