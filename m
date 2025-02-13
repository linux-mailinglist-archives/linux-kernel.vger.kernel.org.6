Return-Path: <linux-kernel+bounces-513197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F577A343A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0A6188D121
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC71662F1;
	Thu, 13 Feb 2025 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyYq4q5n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DE153598
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457906; cv=none; b=JhtaGXHkCgcwBp8+T0Zn9nMMqos4WLx5xnkHDNOFOl1HbQ7+Kb1AKbmsgJnp0idHdrZlwvjGUCKvpPgBqBtcCeYU0d/OlTmTAsS/MT1X+HKPDez8NYIufXCcJJw0yxnEZcXBg2At6HJByBcQUSlaZgqLVZdk8MD7lu+AepvmExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457906; c=relaxed/simple;
	bh=gFRcGFvjH0bWMkbbVnrkKaXw6Mi4hkjhor6jplmqh6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e43ZJ/Msw/+nM0rVhiZ5oh1v7fLs37vZHuBh4kb80YMzW3+FMizY9GSc9lJJd6u1nKSANj2xT0VJeDMWGzg8VumEtxgRqK+PdoM3dDhQroqFifJeo5KzmhDo2UT4Jq/AU0dEvFvcAeHY5YYx4cT4htNHwKIBsVpj5jX+7pF95SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyYq4q5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFEEC4CED1;
	Thu, 13 Feb 2025 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457906;
	bh=gFRcGFvjH0bWMkbbVnrkKaXw6Mi4hkjhor6jplmqh6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dyYq4q5nfydIAW1y7gN6j/ezodOhhsdvXWDpAbjbCP4YHEnY0J1X1OrOzuFkCxoh9
	 Y5IjTAOH7LqlW+lcajRQYIgn+4J9zLN1Qhd/CDlf7yT7EvHtACpm2QGU0i7VD840iD
	 Z6CGgpUSuzEJF/98btlQu+J7vpBzdxFVNwjZGAbLWraC1zsFHbji42gwVMRGPwOGD3
	 v5bfQb69WmmAaCb55VNXhZ3kftUsnM42k7Gj3pT+lqNQO4sDV64HmlFD7EI1ZniDdg
	 /Sw8k3LfkwAg2ny8I+JCNWChfsn0StktzoTIipABaY3IGuPO+40D93IgVc9yD7ynNF
	 eS0fhV3x8cPLg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:45 +0100
Subject: [PATCH v3 26/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_wait_for_flip_done()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-26-e71598f49c8f@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2600; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gFRcGFvjH0bWMkbbVnrkKaXw6Mi4hkjhor6jplmqh6E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWBU3szxfceVRkKH9hC3lM4uSD7yxagmSPeToMGVLu
 Zc67+PCjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR9mmMDW3n918seRBRdHCt
 +Yo1BQsrFfM5NTT/rXCc99sjL+rZwxBzA2OtjIPzEx/PjuR6rWb9krG+IF7iEe894UD1RLVoM8v
 MRx//9KyZ4NcWVtnP1vAw71r/9KD6V4rrzTIPzuEIvOK0YioA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_helper_wait_for_flip_done() will wait for pages flips on all
CRTCs affected by a given commit. It takes the drm_atomic_state being
committed as a parameter.

However, that parameter name is called (and documented) as old_state,
which is pretty confusing. Let's rename that variable as state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index df07923a57be5e0bdc135dfa5752645ff30e9827..5fbaf3707f39d77a85a80d89d2183bafe7806c0c 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1726,11 +1726,11 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
 
 /**
  * drm_atomic_helper_wait_for_flip_done - wait for all page flips to be done
  * @dev: DRM device
- * @old_state: atomic state object with old state structures
+ * @state: atomic state object being committed
  *
  * Helper to, after atomic commit, wait for page flips on all affected
  * crtcs (ie. before cleaning up old framebuffers using
  * drm_atomic_helper_cleanup_planes()). Compared to
  * drm_atomic_helper_wait_for_vblanks() this waits for the completion on all
@@ -1739,32 +1739,32 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
  *
  * This requires that drivers use the nonblocking commit tracking support
  * initialized using drm_atomic_helper_setup_commit().
  */
 void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
-					  struct drm_atomic_state *old_state)
+					  struct drm_atomic_state *state)
 {
 	struct drm_crtc *crtc;
 	int i;
 
 	for (i = 0; i < dev->mode_config.num_crtc; i++) {
-		struct drm_crtc_commit *commit = old_state->crtcs[i].commit;
+		struct drm_crtc_commit *commit = state->crtcs[i].commit;
 		int ret;
 
-		crtc = old_state->crtcs[i].ptr;
+		crtc = state->crtcs[i].ptr;
 
 		if (!crtc || !commit)
 			continue;
 
 		ret = wait_for_completion_timeout(&commit->flip_done, 10 * HZ);
 		if (ret == 0)
 			drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
 				crtc->base.id, crtc->name);
 	}
 
-	if (old_state->fake_commit)
-		complete_all(&old_state->fake_commit->flip_done);
+	if (state->fake_commit)
+		complete_all(&state->fake_commit->flip_done);
 }
 EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
 
 /**
  * drm_atomic_helper_commit_tail - commit atomic update to hardware

-- 
2.48.0


