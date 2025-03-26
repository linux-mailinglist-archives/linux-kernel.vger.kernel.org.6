Return-Path: <linux-kernel+bounces-576409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA88A70EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00AD189C605
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8CF1624DD;
	Wed, 26 Mar 2025 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="KkSoxwZv"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5B15CD55
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955349; cv=pass; b=bLGHW0XIDTNA3eVEc5rP2q2LVwaCVnIlit2uMqbw1Ag/3J6aXrNH5nJNhsYY1fPFatfo0c0hsjA5Pg4a6xcXpkTC18GPphiRcNKsfPpmNYNjipVHMbUiIbEWs32PAxusrZuEVZDxBQIJ5Bs0dbdQ8VmUP+NKkmH7bTxjdbWczaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955349; c=relaxed/simple;
	bh=iM1qsPicsgX+uNQdbCM78DokVmsZ/ASl3A88DUNBMH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9JsoaSZFZ1ab5OdzvfCf/8f7bCM1gl+Ye5mGc5VIurCXWA9KQzdqQiGy997blCqTZoPXPp554fiwTegGC+6ncGJ/Pv8tLgmpta8BkYoPPVX0KUN/P7QHYBvfMe0Cx/Sd+fLVdNEim18AhdH9izJroo5uwWbpteDgI5UfTIZrcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=KkSoxwZv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742955331; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=APqRv5QSeNXNQcwrL/Pvn8A47UhR/9Ptx1Y1pOHuWcMfZfUvn/vsQEKwz3LRJ6YhrlGQew0PB+8RoeR89ca+L8AtUiX5EpH2enM2qB3h2TJZYxGjLeHgqYCIUwsvifROCdQeyzmwI1Luc1oL1BWgURZUoAUFDgmiXySdwuAX10s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742955331; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GGLDXR9qBTP8e0YXcd61U+HKCSx3eRR1MnzILCHIPbo=; 
	b=bPS50hydls3tSOJWzXXi6LKpVaSbUHDbpY/TcEHDdstZz/z6TTp7Z4eK5CUalYCdk9Csr6r7o2A4aNdmnkM7m1F0rru1spUZWnWwFSjmse84F9rWcImq1YkJHvO7HLzroem2TSFVDVbp0COt0dt6Pj5InoSIK8phDFr2+RRd9+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742955331;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GGLDXR9qBTP8e0YXcd61U+HKCSx3eRR1MnzILCHIPbo=;
	b=KkSoxwZvVTXwxFllLdJ9d57fxsPJZFqq7dw9fFe10P3qF2ZHsiyL5Q8fiPlm8Cmw
	xdq0U7C2f/PyW2ardRTotiU3wxGCOxqmM+x+7OkxNV4tgEWGExXslq8Dhgeaghqs5vD
	KHGTGm4+eD+NkkHCpkGAeflDSNsyYO4OD8y909w0=
Received: by mx.zohomail.com with SMTPS id 1742955330853789.2493136203924;
	Tue, 25 Mar 2025 19:15:30 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 6/6] drm/panfrost/panthor: Take sparse objects into account for fdinfo
Date: Wed, 26 Mar 2025 02:14:26 +0000
Message-ID: <20250326021433.772196-7-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326021433.772196-1-adrian.larumbe@collabora.com>
References: <20250326021433.772196-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make use of the new shmem helper for deciding whether a GEM object has
backing pages.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
 drivers/gpu/drm/panthor/panthor_gem.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 0cda2c4e524f..2c6d73a7b5e5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -200,7 +200,7 @@ static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj
 	struct panfrost_gem_object *bo = to_panfrost_bo(obj);
 	enum drm_gem_object_status res = 0;
 
-	if (bo->base.base.import_attach || bo->base.pages)
+	if (drm_gem_shmem_is_populated(&bo->base))
 		res |= DRM_GEM_OBJECT_RESIDENT;
 
 	if (bo->base.madv == PANFROST_MADV_DONTNEED)
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 8244a4e6c2a2..48930fe7b398 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -155,7 +155,7 @@ static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
 	struct panthor_gem_object *bo = to_panthor_bo(obj);
 	enum drm_gem_object_status res = 0;
 
-	if (bo->base.base.import_attach || bo->base.pages)
+	if (drm_gem_shmem_is_populated(&bo->base))
 		res |= DRM_GEM_OBJECT_RESIDENT;
 
 	return res;
-- 
2.48.1


