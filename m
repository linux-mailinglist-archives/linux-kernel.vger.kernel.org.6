Return-Path: <linux-kernel+bounces-374145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66BF9A6574
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAA31C221EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FEF194A74;
	Mon, 21 Oct 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv+tDCn+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB61E47A8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507871; cv=none; b=pVF6TPIj9dNhIox6wMqMVr8H6BMWvF4S1DHLdLXQpsUxjxdwKMFcyMm3/myYv4oFOhv0tE61xiKW9s8werNIfXqNEFNgQzTuzFuc38zF/3CQSu61X3uryjDbhd+0hF7PvnppwLl+Rf7u6V8Y3VMwKNGgnn9aRn+OYCH/7PDHVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507871; c=relaxed/simple;
	bh=G4z1uFFF76iBAoQjh0APb/UqOcliiaa14kUIDLZI8DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWqmlHnmL2NtHK3E5kZ0kMe4/ibzo/Gd83zT8cGkqGS7q0CsAl51Ik1WC0mh+m4WRW5EoeJfIgB8Yw9A9UX7Gk+B0h2ONauLkLnXVlbm5PTIqHLcagH9VFOKY2jJvia66bK1KCZcuHP22xMtgz3OP7MLqKYi5bTPrnrQN6R2whI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv+tDCn+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h2ciBpbcKEJEKHld76VWMnvn0NitnUmbu3TROV6N+1g=;
	b=Tv+tDCn+jhORNtolt32B4iVycLXlRlTImiiFpRzrXGJbmT088fvae5jKbfhxWZkm19LLpo
	6xOIpOTr0iMjLVwjwQ2mOHIyVyBhPRmZ5RGFmJTRObFEcVnVJUC06cLiqCOqXCfCqqHJK3
	FqWMho7u79cKU2F//LLmajTY0aIFpYA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-y2r7-k-dMoGt91DuIcx9Cw-1; Mon, 21 Oct 2024 06:51:07 -0400
X-MC-Unique: y2r7-k-dMoGt91DuIcx9Cw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43154a0886bso31047175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507865; x=1730112665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2ciBpbcKEJEKHld76VWMnvn0NitnUmbu3TROV6N+1g=;
        b=SauUou91+DhNmzqQ7+1cmmki4VF9Q/XZKjIXF0SOGRHCsIuflLL33tGVi83vl79G7d
         7CQ3rruSJEUW81bY4eAjxgibWZ+IO43C3WGeyE4wsDSWiqF9Cc2T54FtV96yAAk8AXfl
         icOgX3kWC4jcFE8DHKg7cy1yQjPd5fH92IOmgmffyyFm2vOEal4wV6zrhZdIKAv/QeOV
         5Q6z7mIsHowwBMmfog/zIB9XRVu8Ha8s62L8u0srAdeSE2CwVeW/HtE4pAPyzPKPuvwq
         a4mdGOaWknHFiVD76g+A1M7ifpifgnXzLMFhcd7adb2SZn9/AeDXHwfL51H8CWFk0H7p
         1ibg==
X-Forwarded-Encrypted: i=1; AJvYcCWVbbSVBDVqocskX+Gfr2nr95o6d3Z7zgGzblu0+AolJPORj8sZK8ZM/RJkFoTANekf9za0/URXaIm6xiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcsvhihieWQOmRuAMy8FcX1R6wKFbV2DA/VphTME+BSz+ONLa
	MN1Ssp7DtGbK4vXA0H0HI+BYwpKBo0CYP1OajNBO9s8DR/EDqyHTQOWqHskusxILsmQf7QpOEVj
	94hi1sV6zZ1HN/P5XR/OmI9yry4JjT/ZKtcTOIL8F3cQ+W35Ql0h5ikYYCuxC9A==
X-Received: by 2002:a05:600c:354e:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-431616a3a15mr83928925e9.25.1729507865499;
        Mon, 21 Oct 2024 03:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoDq0zpTx4/a8pJZ3ce7VUx/vHA7i5tc7ntMyJG6ujE23KLHEQO3J1ivFPoUl4rZrPbQ5gBQ==
X-Received: by 2002:a05:600c:354e:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-431616a3a15mr83928585e9.25.1729507865021;
        Mon, 21 Oct 2024 03:51:05 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d449800aee93296d73e68da.dip.versatel-1u1.de. [2001:16b8:2d44:9800:aee9:3296:d73e:68da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fdb2sm53065615e9.20.2024.10.21.03.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:51:04 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tvrtko Ursulin <tursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
Date: Mon, 21 Oct 2024 12:50:28 +0200
Message-ID: <20241021105028.19794-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_init() has no control over how users allocate struct
drm_sched_job. Unfortunately, the function can also not set some struct
members such as job->sched.

This could theoretically lead to UB by users dereferencing the struct's
pointer members too early.

It is easier to debug such issues if these pointers are initialized to
NULL, so dereferencing them causes a NULL pointer exception.
Accordingly, drm_sched_entity_init() does precisely that and initializes
its struct with memset().

Initialize parameter "job" to 0 in drm_sched_job_init().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
No changes in v2.

+CC Christian and Tvrtko in this thread.
Would be cool if someone can do a review.
---
 drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index dab8cca79eb7..2e0e5a9577d1 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -796,6 +796,14 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		return -EINVAL;
 	}
 
+	/*
+	 * We don't know for sure how the user has allocated. Thus, zero the
+	 * struct so that unallowed (i.e., too early) usage of pointers that
+	 * this function does not set is guaranteed to lead to a NULL pointer
+	 * exception instead of UB.
+	 */
+	memset(job, 0, sizeof(*job));
+
 	job->entity = entity;
 	job->credits = credits;
 	job->s_fence = drm_sched_fence_alloc(entity, owner);
-- 
2.47.0


