Return-Path: <linux-kernel+bounces-513203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF7AA343B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1703AEC29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E71FFC41;
	Thu, 13 Feb 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4St6TMh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8D1FF60F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457923; cv=none; b=RvE4LJdUU9k0eA8OBltGVI6Ekk9BzSuv65mgVxfLw5YfcXM1dvj28xC8zev4dSA6a1iWia8m+CcVd/XZIBWRiUI6NU1Itw4vsXEfDS6z/OAkDTxP2SjgwbbKRS212XMjeP3wN+JU5gQd9PQzDx4L5XjKNBBtOoUtg6V3yhsAPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457923; c=relaxed/simple;
	bh=vZ1zwX+EIT22jLVdxPPeOac2s5CTPENPj9BdJWzzYrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBDV+cUsYBr4A1x6pIVMWVQV2kH7ITPmMWc/XiujAXxgPTQa1Ime4zQsPCEmo7rAJJ00VgUF5sDZ8r9KdzFaQQljdo96fd9xlirHqqPcWi3KNct8nCA6UsHsyznUsXNxBMe32EOJP7TAHGWYkKOJJANzswUvPW1kTnltDmZQ6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4St6TMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55406C4CEE2;
	Thu, 13 Feb 2025 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457922;
	bh=vZ1zwX+EIT22jLVdxPPeOac2s5CTPENPj9BdJWzzYrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q4St6TMhkyhIG6lEgIn9qNLxZbjFXwDd9fSZ6TQXMgtpYHiVcKPK4SInA1j0Wf7wN
	 SHhztO4/8epvX1EZolbSWgW2b1RrROvmL4AG/ktlfSst6N/+Dxx4ZXenmDChf1/u2N
	 zgN0LcjKc05pq72Wv3v4OXuhmYEstVSie168c+3qqR5nyUBkKDaqSmwWatorPUdMdC
	 6YklDE6CbppIPmrSbwVPQf4McPOgVnMTdbLZ2sUQWUyyKlL7GxzeERzYV/rypGfb/V
	 4eSQY69SZCV6Asuubwx2NrB9tPo6t52oa2M3+Ylz7rKebEaSRlzmQCcfCIFEUKuTps
	 UxRpcUCqk4Kag==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:51 +0100
Subject: [PATCH v3 32/37] drm/bridge: Make encoder pointer deprecated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-32-e71598f49c8f@kernel.org>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vZ1zwX+EIT22jLVdxPPeOac2s5CTPENPj9BdJWzzYrU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWFVUXqTGbf4fsZ9lsVeOXKP+i5taP9tlk58bX2LbY
 ZTcs/tPx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIwH7G+oTq2u9LT9XaiTAV
 OL1cctbg4r65/KIn/gadMnO9saF65Zk606Nv5m2e6vdC4UFsul68GWOt8H0OKeNY7a0rFLUuioQ
 +/+drWPJ/vnmnstObKce1vec1CTQ75zy9EPhc0kGkM+uj5nkA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Other entities (drm_connector.crtc, drm_encoder.crtc, etc.) have
pointer to other currently bound entities. They are all considered
relevant only for non-atomic drivers, and generally perceived as
deprecated in favour of the equivalent pointers in the atomic states.

It used to be useful because we didn't have alternatives, but now that
we do, let's make sure it's done for drm_bridge.encoder too.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_bridge.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 4cc12b8bbdfe2b496546607d1ae0b66a903c8f89..a4dd9be13c5205512c2b3441a3d87d557f411bfb 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -822,12 +822,18 @@ enum drm_bridge_ops {
 struct drm_bridge {
 	/** @base: inherit from &drm_private_object */
 	struct drm_private_obj base;
 	/** @dev: DRM device this bridge belongs to */
 	struct drm_device *dev;
-	/** @encoder: encoder to which this bridge is connected */
+
+	/** @encoder:
+	 *
+	 * encoder to which this bridge is connected. Only meaningful
+	 * for non-atomic drivers. Deprecated.
+	 */
 	struct drm_encoder *encoder;
+
 	/** @chain_node: used to form a bridge chain */
 	struct list_head chain_node;
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
 	/** @list: to keep track of all added bridges */

-- 
2.48.0


