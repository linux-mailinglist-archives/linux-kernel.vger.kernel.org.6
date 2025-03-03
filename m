Return-Path: <linux-kernel+bounces-541936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92952A4C39A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188483ABC49
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A52144A7;
	Mon,  3 Mar 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Vawew98O"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B92139DC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012774; cv=none; b=NYZYGeqMPVQhNf39vKbrNWd4gAJBfA0ICCgGLwFpaZ3lFiDTups0BxpO4MyODW/d6ItE4KFN8MAgfxADRZQNpqLluO8tZDiS+LP0oHBaYHlDUD8EHf9343ejqTwDZKALd3OXAkOj1Uy+CK7KKegwhjn2cEn2a9k5gU2puoFYlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012774; c=relaxed/simple;
	bh=Oo9bx0i6Wcsv6riylCg9LyziEli1nqxqvY5u016eLrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8LSPO8VdQLLrZbSPzDEAh0qGCludGZBWjcAQn1CvjVEQcZqqrsNl57d6iZNryA4eSS/6N2B//3mz7fP1KNa8NdVu3aYHyBIiiDyJF0D6OQDHf+8s7rRlTKj293q8vLgJkzMI9aFLcaeS5NxuARpK042Zc7aiamJSQZo6hzg28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Vawew98O; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=om6Pe7ZZ4TBnXEpqWdlBwdRqDe/1mArlAqj9LsmmXJo=; b=Vawew98OoN6iqkCZ
	3SymbqPYpKg9wEpCizX63v5Jpc1MWJgAKrKvvBcrG9/LDsQB+zMiF+7jJrolzuCoYimZ29qwK24DK
	SUzGbFgyEW/fZBmOXt881aEN1Y04Nxk7XdTMzb48hjbzWQOzrSVjtILKDVfQ2yftTk1ZRC/79eb8V
	BHqRigfOfBQ8f9bWEsNFJzRuCulRHUwkkeB0nFH9jBZeb6AvMIm1v/uYqNpCCYL2ctZgDucWgUgVD
	WGd3vdOV163eoWsY5lxSA7zqx2i29qH/fdJCmQA4DJIn1SeuvbWH9DH+yUjIZmEJI99Iq1u/EkiXR
	LfnhT+1PScUJxL0RVQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tp6x6-0028PG-0i;
	Mon, 03 Mar 2025 14:39:28 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 6/6] drm/amdgpu: Remove unused pqm_get_kernel_queue
Date: Mon,  3 Mar 2025 14:39:22 +0000
Message-ID: <20250303143922.36342-7-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303143922.36342-1-linux@treblig.org>
References: <20250303143922.36342-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pqm_get_kernel_queue() has been unused since 2022's
commit 5bdd3eb25354 ("drm/amdkfd: Remove unused old debugger
implementation")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h               |  2 --
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  | 13 -------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2c22e335a02e..bc26a2609f64 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1363,8 +1363,6 @@ int pqm_update_mqd(struct process_queue_manager *pqm, unsigned int qid,
 			struct mqd_update_info *minfo);
 int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 			void *gws);
-struct kernel_queue *pqm_get_kernel_queue(struct process_queue_manager *pqm,
-						unsigned int qid);
 struct queue *pqm_get_user_queue(struct process_queue_manager *pqm,
 						unsigned int qid);
 int pqm_get_wave_state(struct process_queue_manager *pqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index bd36a75309e1..2b30ed0cecb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -652,19 +652,6 @@ int pqm_update_mqd(struct process_queue_manager *pqm,
 	return 0;
 }
 
-struct kernel_queue *pqm_get_kernel_queue(
-					struct process_queue_manager *pqm,
-					unsigned int qid)
-{
-	struct process_queue_node *pqn;
-
-	pqn = get_queue_by_qid(pqm, qid);
-	if (pqn && pqn->kq)
-		return pqn->kq;
-
-	return NULL;
-}
-
 struct queue *pqm_get_user_queue(struct process_queue_manager *pqm,
 					unsigned int qid)
 {
-- 
2.48.1


