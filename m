Return-Path: <linux-kernel+bounces-374492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D24A9A6B12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28D0281808
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01F1F81BA;
	Mon, 21 Oct 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="XMxIfD+P"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FC1F80AC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518763; cv=none; b=Q3hpKIfRImrP5+LQfyVPXTHQiPyjOU+ozfInVmbj0pMi908KlZ9dKRTlHvu9ZDLekLPfeZF8P5RTA7J867gdccfUJFe5lqhcfWyDmHDS5RiR8fJ1wC9/KuN0lEl2YmzOTfZ41/muH365AQtw3LlmPrM4o4zbpgZ7qwhswnIn3X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518763; c=relaxed/simple;
	bh=mWS86uxMWdC6gVhIz2KdmLhzVCkDB1CjGV9cSCNuTfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSZbZSrspkK9YWO1Bd0AAVM/aMyJ0tp92gySx+UMBMEn6ZKs+/GOcVvbKMTUD2Srjjo4YlDPfqtyCngtELTelzuE4gwZtDI7OUEVOIZ1FZ2RL1MB6mlL00XKcSqdR4GQfpteXBP06HrfxHXWVkZ9oBs4NtYhXVyDxANoWoCMTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=XMxIfD+P; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XXGvz1TLnz9slY;
	Mon, 21 Oct 2024 15:52:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1729518751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qm5H3iVaNzE/cyspTjKRSfgDmWv1EYY1JXmeR3OStN0=;
	b=XMxIfD+P3ISrQks2rwOErN9A6YAYxfM7D0T4pCxnbRmIlO75GEod6Mhh33eBZT+WmukFkp
	uMqRneVZN8q+pD2r2bQpUeUNWy+DTLeucJKnwz/zlCmynBGm6qwkGeYwHbPxXttYvjKsWM
	gvI+6wnCkfxZAaynQicQwB0/Okjq504R+VI/h36p2Do6cI5EQ+kMpSoQTZaq47EkIGE91g
	Zw7razQ4yNqzXXD3Ozei+raosuWEVcITchEPgZZKkeIuxgnKXPljqM0Ejl3rfkUO2sYkZp
	86exRn19aAB62irJozoiI8UjB88qMnq1AQ2aaSSdlABzM86C7JVyxjCPMM0+dA==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: dri-devel@lists.freedesktop.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: xlnx: zynqmp_disp: layer may be null while releasing
Date: Mon, 21 Oct 2024 15:51:27 +0200
Message-ID: <20241021135127.218947-1-lists@steffen.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

layer->info can be null if we have an error on the first layer in
zynqmp_disp_create_layers

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


