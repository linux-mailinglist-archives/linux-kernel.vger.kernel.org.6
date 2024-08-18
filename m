Return-Path: <linux-kernel+bounces-291012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8152955C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDA31C20A5C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4A650271;
	Sun, 18 Aug 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GupqK+Wr"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0F199B9
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977827; cv=none; b=bQe57TEnBsuAIC9WZU7Wifxs23e/D+RAVMJq7t1pk93h1clZ9hcsIQWre1nRUSmy2Y+xEHqcKSf8+ZvoE6y7tQCkdkLTHk8AxH9by2WuM7HTwTMvFJEnzyzAqi5eLWvuHLqInvzfyRPuNQ1eSZ7Y97kWjpJ0jdzInaeNdS30xMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977827; c=relaxed/simple;
	bh=fKGZWTylCrkUKzQxU1idZr4kJxvtu34DylGKZuIhUtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oICirkFnP6AaXXYxaPdBzBCQ0nEM6rjqawtG+jYBtTqrGJ1PT1uXjfDiQZVK2QvPhmNS5WdFl984W4HqkAcgRfEHbYB3D1Y8tapkuVfWZhkfC1tV9nnJ2wUKF3ZZOXa6zEc5XIest+aJ1fBqZx2WXFjvdft0uMr9FCDuVph1kNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GupqK+Wr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=fKGZWTylCrkUKzQxU1idZr4kJxvtu34DylGKZuIhUtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GupqK+WrC/nHKVQ5eWB9kr93LX9LI6thKXSmKxYtAVW1ijm/f+ffxRvsdc0QgIrAy
	 D1HMYMDaCwnEgcfh2gfd6oKBmUZ6H9Q9vjwQvelhd8rbP77BGxPczu5nq8EBfXdzWj
	 IJX0GZbbNw6KQIWE+p3yo476z/JDy9mF1S7L5wtM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:28 +0200
Subject: [PATCH 04/12] drm/amd/display: Simplify raw_edid handling in
 dm_helpers_parse_edid_caps()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-4-aea66c1f7cf4@weissschuh.net>
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
In-Reply-To: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, 
 Aric Cyr <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, 
 Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=1951;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fKGZWTylCrkUKzQxU1idZr4kJxvtu34DylGKZuIhUtA=;
 b=D+2ZzYzLkZGs1ZeuVCYAu/pTWlUI0ONm5mk0bbsmU6kf5nUOmkTVd8DylIc43uDOMTa63uem3
 UdTFJEirwidAlIhNDuac7hDAswD6GOTLuWTrqVB0QK2uUqayvmPTDao
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Reduce the number of casts needed by reusing the edid_buf variable.
Also initialize edid_buf after the !edid case has been handled to avoid
the ternary expression.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 165e010fe69c..3cc0808f391a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -94,7 +94,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_connector *connector = &aconnector->base;
-	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
+	struct edid *edid_buf;
 	struct cea_sad *sads;
 	int sad_count = -1;
 	int sadb_count = -1;
@@ -106,6 +106,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	if (!edid_caps || !edid)
 		return EDID_BAD_INPUT;
 
+	edid_buf = (struct edid *)edid->raw_edid;
+
 	if (!drm_edid_is_valid(edid_buf))
 		result = EDID_BAD_CHECKSUM;
 
@@ -125,7 +127,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	apply_edid_quirks(edid_buf, edid_caps);
 
-	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
+	sad_count = drm_edid_to_sad(edid_buf, &sads);
 	if (sad_count <= 0)
 		return result;
 
@@ -139,7 +141,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 		edid_caps->audio_modes[i].sample_size = sad->byte2;
 	}
 
-	sadb_count = drm_edid_to_speaker_allocation((struct edid *) edid->raw_edid, &sadb);
+	sadb_count = drm_edid_to_speaker_allocation(edid_buf, &sadb);
 
 	if (sadb_count < 0) {
 		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sadb_count);

-- 
2.46.0


