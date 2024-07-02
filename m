Return-Path: <linux-kernel+bounces-238395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0979249E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C0F1F2282A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323C205E14;
	Tue,  2 Jul 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gmnxE7WA"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F820127B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955351; cv=none; b=oXsH0k5hfDAOU2DrP7XCtMB2L2ebIpT7WSqPmfVKJKgoHiTyb6Ds556aM3cv0xfBiD03ACvtI5aBGzcGbOVryItoMmnZ45c3EHmMeVDOUH5OKcOHECtGA8zK4iw5pjEjX38uZo/LGY6ol7XL/Po+JZhb4jTqjbFQpKnWrU9bcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955351; c=relaxed/simple;
	bh=jReBJ+R1DJPZTs6QbfOg7CIYwAPBo1Xp5UDSrwNdWvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6AqbQKrzzGABSGty6Po3CiSkJUUAlGvyN2ri3r833TVxsQ3FzRfeEQy4Xx1kF7/MIDRdVnbDARaeRKJKaQlZgCTozKhKR1FagwdKRCNlD6/w2QdXXyjlIrLi4eVXDRINfkSIZ2dOqFDikMYBNqcUCyhEBemhHNMsTjb0tlI9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gmnxE7WA; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8shIziYaH1I6kOcy98r2qE87n4FfKZ/MbO4p811IbiM=; b=gmnxE7WAsdbc4xx6JtWi80SL9Z
	LGNskCrCfY7H3AL/+BS9I4HeVTckf2+bAxMqXbCLuR77S3CW+g7Vi446yKfP17dEvhVzBkA1eNzIs
	YoMem5nCFUfD557HrucmH9/lZ5rms8dfKu/RZnpvZz+KvvDzeZMV/FYlTb/tPwCqRFtq0UebBL3ne
	DPnom9YTBweetrnH0B58WVq7wZw5oVsgchCfUAgiIrBsUC/yTBn9Y1UeIEMPT/lVIpLJ9qe5E4FXB
	9iFK8t4BejDAo5t++rTt1xoM3TqTq8fVxQ8UxbIOy59sG0Lv9VUUTZnBLcISOGOX+BEmL2k0UVCBD
	5WWweOUA==;
Received: from [191.19.134.16] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sOkxH-00ASeG-7s; Tue, 02 Jul 2024 23:22:27 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 2/2] drm/atomic: Allow userspace to use damage clips with async flips
Date: Tue,  2 Jul 2024 18:22:15 -0300
Message-ID: <20240702212215.109696-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702212215.109696-1-andrealmeid@igalia.com>
References: <20240702212215.109696-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow userspace to use damage clips with atomic async flips. Damage
clips are useful for partial plane updates, which can be helpful for
clients that want to do flips asynchronously.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v2 changes:
- new patch

 drivers/gpu/drm/drm_atomic_uapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 2e1d9391febe..7609c798d73d 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1072,7 +1072,8 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 
 		if (async_flip &&
 		    prop != config->prop_fb_id &&
-		    prop != config->prop_in_fence_fd) {
+		    prop != config->prop_in_fence_fd &&
+		    prop != config->prop_fb_damage_clips) {
 			ret = drm_atomic_plane_get_property(plane, plane_state,
 							    prop, &old_val);
 			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
-- 
2.45.2


