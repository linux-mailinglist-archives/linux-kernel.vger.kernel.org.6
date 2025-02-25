Return-Path: <linux-kernel+bounces-531935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ECAA446E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB92422365
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818E1A00FE;
	Tue, 25 Feb 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBDctgLe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FC1FC7F9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501873; cv=none; b=lnuW2Aqd8mQE0rp5ABpZ7FGXY3vPmtQFgqaNS2GPTXQ7IOTH1iajH8Nn4EMDLd1fBQRDBR1CmU6LcltKJPfab81OG/lpQfeqie/NMyApSDKw+fDvz6xNYrYlGJ+Ruu99sbcAJIFez/CeObmgwfcS8fOTowQolosi1JRrS98gaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501873; c=relaxed/simple;
	bh=/qYTFXPW6zCODmKFJgfLNKuZkSKrl+xBMfwcF1h+tSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZPBcPkie4G5vJ4jXbYGA1b/oMlHhGukHeXlsg75wVBAYLtGDxZOapbm7jQhDiLxm/C49sQj8xBkJ1/ZgUopiKA6gZ/2jNCfygULOjAsj8pO37wUWTkyAtO6hWNhituyrQQH/tbYAixYdrE2e8CQ5kgVaGgi5gSfo2zowvkbsXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBDctgLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711E1C4CEED;
	Tue, 25 Feb 2025 16:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501872;
	bh=/qYTFXPW6zCODmKFJgfLNKuZkSKrl+xBMfwcF1h+tSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DBDctgLePdsZyZuIagtu1Y7G66OR3UerhOnAnOxk8LfHYQtsGqXvTzGCOkgOF1kcT
	 PRWoveFJYMOuAyS3HzTBpCqNt/q9lyPlPgGgI4vECd29giGul5q3FRgg/bHciKSe/t
	 5C++mT4gNFjiYF5wcuiaKsvKoewGSF6heUrozbKbE/HpZvGH2bk6gL/uysvdLVU9En
	 7Ze8mmIz8X8c6rTZMBzF4uLro6IklOGKcmEXpqgMqd5sBoDY2RbvX7/sR778TmrtkD
	 //VCFXqiAePXzJm1FuYFEQ65h8Sy1MYHg9AF9HDJErwbJFhlVh3SYs/CydAhu8ddMr
	 K/fi26lI/pEXA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 25 Feb 2025 17:43:58 +0100
Subject: [PATCH v4 10/15] drm/bridge: Introduce drm_bridge_is_atomic()
 helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-bridge-connector-v4-10-7ecb07b09cad@kernel.org>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
In-Reply-To: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/qYTFXPW6zCODmKFJgfLNKuZkSKrl+xBMfwcF1h+tSw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOl7P/vpe3o7RaoXp2ckuZf8fhN5bauF/wGVp5+WLP1wP
 XzflqnFHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAibEqMtSJmv16FW+9srpqb
 +GTB1TdRvA+exn1+4ifONNVcJsAld3/ISz3jAOWJdjVCBf9v5UXdZmx497jjoUzqhTyW3zv5y+S
 l3+1KvnTyaebjrMCLJ7/YXUtOvcaa63PcPqHa7Wbr47cL9l0FAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We test for whether the bridge is atomic in several places in the source
code, so let's consolidate them.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index ca894531a2042fc9296c40a1f51a6cdea6e97ed7..4d6a72f8b7d1bd1641d434f9fedbc2f087e249ac 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -279,10 +279,15 @@ drm_bridge_atomic_destroy_priv_state(struct drm_private_obj *obj,
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 };
 
+static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
+{
+	return bridge->funcs->atomic_reset != NULL;
+}
+
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
  * @encoder: DRM encoder
  * @bridge: bridge to attach
@@ -331,11 +336,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		ret = bridge->funcs->attach(bridge, encoder, flags);
 		if (ret < 0)
 			goto err_reset_bridge;
 	}
 
-	if (bridge->funcs->atomic_reset) {
+	if (drm_bridge_is_atomic(bridge)) {
 		struct drm_bridge_state *state;
 
 		state = bridge->funcs->atomic_reset(bridge);
 		if (IS_ERR(state)) {
 			ret = PTR_ERR(state);
@@ -376,11 +381,11 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 		return;
 
 	if (WARN_ON(!bridge->dev))
 		return;
 
-	if (bridge->funcs->atomic_reset)
+	if (drm_bridge_is_atomic(bridge))
 		drm_atomic_private_obj_fini(&bridge->base);
 
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 

-- 
2.48.1


