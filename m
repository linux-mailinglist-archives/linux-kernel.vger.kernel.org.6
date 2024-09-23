Return-Path: <linux-kernel+bounces-335363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73CB97E49D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496FC1F21629
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED610A3E;
	Mon, 23 Sep 2024 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XNREdPqP"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32944C96
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054708; cv=none; b=mtaFxmuD9HxMRWOazt5YQIYzLjqU4dTRg0lAtUE3PDeBOFBpovxqt24muw8mwUPsHHp6hfcfshnOyhBSSHj5GEIMz5mLTg3rVU6WzhOZKQfTgq7G50rz/vCHfCpCt2fPw4FZEOpzWT1oVJcJFCPmEJ+QgUr+xt/GWqRlOtQifO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054708; c=relaxed/simple;
	bh=vx67FaFFHL0J8P5QVA3Fl7RJIX1MzoaS07CJZQ9msTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fli2WphhUgzq/4CLAOkWLDiZguTVto3NUYXffO3BRhP2OlZtLyTGT+xSzrMSKh7FiPlq3qvWVtfWc6O1EctoFSmLYcomC3ve/mqnt7ooY+qTEEVZZ+qPojueu2onlLWyiogWPdi41j8102SVyrPnUiTw8yCdS87pzTJYcweToLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XNREdPqP; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=RbW0B7/5rNugvdLyZ+nrDMXy1OSjf8esLFsIFlk4SaA=; b=XNREdPqPg3t611FP
	eWZ4S4Pe0jSM6ci+g1uS1gwecjVTVII66a/IZVPjTYYWGRvxJwU9PpzJF349zO73zQ0K66uGnV0nQ
	jAlE7m+wXPpuf6X44guwJL5Zl8+Tg5N4g/Efm7402eQTd+3DPBl0XFsAn99uLgek4iiNR3myyyhUX
	2vm/UAaoTvlzDOeHLfpBBs/5izYWNvVEvSFoVd+Z1uwitX06DYysq9dIXXJiDsjQA7jGfgajzEPfZ
	fPl1EyWT+1IM9UaXpDUhKJ97eECtZWef/0nZZSvKNJpPWByqRzHmWuuj05HvEJxod85nF7cTqAGvy
	sVhtfh4WQdXosiaW9A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ssXou-006k2k-27;
	Mon, 23 Sep 2024 01:24:56 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/5] drm/amdgpu: Remove unused amdgpu_device_ip_is_idle
Date: Mon, 23 Sep 2024 02:24:42 +0100
Message-ID: <20240923012446.4965-2-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923012446.4965-1-linux@treblig.org>
References: <20240923012446.4965-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

amdgpu_device_ip_is_idle is unused.
It was renamed from 'amdgpu_is_idle' which was originally added in
commit 5dbbb60ba61e ("drm/amdgpu: add IP helpers for wait_for_idle and is_idle")

but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ----------------------
 2 files changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dcd59040c449..c654668e2a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -365,8 +365,6 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
-bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
-			      enum amd_ip_block_type block_type);
 
 #define AMDGPU_MAX_IP_NUM 16
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f4628412dac4..dc4679e53463 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2169,30 +2169,6 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 
 }
 
-/**
- * amdgpu_device_ip_is_idle - is the hardware IP idle
- *
- * @adev: amdgpu_device pointer
- * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
- *
- * Check if the hardware IP is idle or not.
- * Returns true if it the IP is idle, false if not.
- */
-bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
-			      enum amd_ip_block_type block_type)
-{
-	int i;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].version->type == block_type)
-			return adev->ip_blocks[i].version->funcs->is_idle((void *)adev);
-	}
-	return true;
-
-}
-
 /**
  * amdgpu_device_ip_get_ip_block - get a hw IP pointer
  *
-- 
2.46.1


