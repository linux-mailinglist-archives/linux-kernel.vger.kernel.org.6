Return-Path: <linux-kernel+bounces-249619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278492EDEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61FD3B21398
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163916D9BC;
	Thu, 11 Jul 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ur5z5g7v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E447F7F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719371; cv=none; b=ge7S4Wk/m9SgrO9UpjPGxxZ6+jiW5h6IoybJGwH4p5UuD/PjqDR9lcKs1tB7cqGJpneRIIMqqbaGsDDCOO6i93EU1VlSH1dl4w5Shxp76mZ5OVO6GSSQ/7BhO+TKCFHPba0s+Kxgm3w3K7f/GInVyukVHqHTKS/JS2/JrJoFA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719371; c=relaxed/simple;
	bh=qgnDUmxmdB7sDyrvknKXFjaBh7F9m3LBqmnRIfkwF3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhUPSD9ZB9UfN2tSWJcsncxpp/Z+ZSMSlAwRmjLDiICz2z5V6ndsS+C//hR2i9nKFFU7NFTY4GJD4YnDSjTDj3YRahp5PlmZfsSwxtas8pxAVJi5HSdtMVVRogPFIZiaNVHxGYs0aFBi437MgCVRxt9iyEfR8KT8uq7IPFDGhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ur5z5g7v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720719369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PqZ5Lq7rcqKvViuzmKy6ImpdE7S1OOOZU2S6RM0SUzQ=;
	b=Ur5z5g7vK5QgSyL2HXSHfgF6TqPMWSyshL9zpNtcY3phj8KlpG5SOsH8s+Bgvt6zhTqdZv
	6w2hrkEypdn1i6qkhpiqJhwaFHDY3Lw7hvyU2j7pLM2ob+dAk7VtHRqi9E47VxlT6qiAjR
	thyy1ld2orOqsK7f9jRg93Q2YqAj9xk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-dCoNFGvtMIiFF6F1X3SULg-1; Thu, 11 Jul 2024 13:36:07 -0400
X-MC-Unique: dCoNFGvtMIiFF6F1X3SULg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4266a2e94e3so2193985e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720719366; x=1721324166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqZ5Lq7rcqKvViuzmKy6ImpdE7S1OOOZU2S6RM0SUzQ=;
        b=lmKa75X3sg/tbmWwUfBdwGR8bWvVTrihPT9EyJPBZdOTvbKvA9k019eIHY+a4D8zbO
         8P5cCh52MLLZDXgj6YnRpKerC5PQQ3Y1oHN0sDZxRP6wBQvWd3roDrhRgSEDNT/JKJvJ
         Xl6rBjh88G8JcqdwvbGgZ+x9gVCMWBBMhVYLRhwYTc/Ka1ZeGFLglQg+co2bZpGSD+Na
         jYzZMFL9DEIV/0RI61MuKivn1gNDSwm+2x9fUn08SEUd/ZwO/dD762Rd8TFtvQFA5ZND
         ap5oUCATXqijNLNoMS2R0+H+fSpusK9LRR6Bw5cuGTI/NC9QfbAXSL3idKdJuRrtxmHS
         Sl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHYX0EUMVPLsK86BD2hXZU2HbCkiFOTwbePryX+HupfGn0vV3E2WizbI+QpuJn6+Z6Uj4PRbwZQa8foKAFrHoIC6x0ZCFW5lx180y1
X-Gm-Message-State: AOJu0YyBx5d7l9AesAIiey8kXmUYVzUd2n5NMjCCByrHeEvKVzNFimSf
	DBiYhmDqT1A7w9P5PXRNZeFbV5r45P7nSSA6b9NbojINj0U7ZmMCEZ60/5mXMHzQ3p/hipLzumG
	MS5nYogDEiXAxI0rhh6NiaKpk8oPrKqNcnr1ad39+oHB5OduJEmkKV3M7LoUA/A==
X-Received: by 2002:a5d:6489:0:b0:367:9614:fdf7 with SMTP id ffacd0b85a97d-367f0545ecdmr2325014f8f.0.1720719366378;
        Thu, 11 Jul 2024 10:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMfYTkbrTlZRWFy2Gd9pQVj1zME06oiFKdU2+UjDpE1fDMi5oLmElwlTGgF4rW+HmuC4lNjw==
X-Received: by 2002:a5d:6489:0:b0:367:9614:fdf7 with SMTP id ffacd0b85a97d-367f0545ecdmr2325000f8f.0.1720719366016;
        Thu, 11 Jul 2024 10:36:06 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e19dsm8242836f8f.15.2024.07.11.10.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 10:36:05 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] drm/nouveau: Improve variable names in nouveau_sched_init()
Date: Thu, 11 Jul 2024 19:35:51 +0200
Message-ID: <20240711173551.76148-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nouveau_sched_init() uses the function drm_sched_init(). The latter
function has parameters called "hang_limit" and "timeout" in its API
documentation.

nouveau_sched_init(), however, defines a variable called
"job_hang_limit" which is passed to drm_sched_init()'s "timeout"
parameter. The actual "hang_limit" parameter is directly set to 0.

Define a new variable and rename the existing one to make naming
congruent with the function API.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 32fa2e273965..ee1f49056737 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -404,7 +404,8 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
 {
 	struct drm_gpu_scheduler *drm_sched = &sched->base;
 	struct drm_sched_entity *entity = &sched->entity;
-	long job_hang_limit = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS);
+	const long timeout = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS);
+	const unsigned int hang_limit = 0;
 	int ret;
 
 	if (!wq) {
@@ -418,7 +419,7 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
 
 	ret = drm_sched_init(drm_sched, &nouveau_sched_ops, wq,
 			     NOUVEAU_SCHED_PRIORITY_COUNT,
-			     credit_limit, 0, job_hang_limit,
+			     credit_limit, hang_limit, timeout,
 			     NULL, NULL, "nouveau_sched", drm->dev->dev);
 	if (ret)
 		goto fail_wq;
-- 
2.45.0


