Return-Path: <linux-kernel+bounces-304707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BAD9623C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F3E1C2385A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C5166F20;
	Wed, 28 Aug 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZawe9ng"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968215ECD7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838105; cv=none; b=XnqNMhwgERGpvPGiXcxj9v59TAp8TxwEAcj9u+WrMRsrixs4q0n/Tnua0Xiuf/kxxpIKBBv1QAWnFDYzuuqn5XWbZ9xXl7joGwP4diEq196G4aJMj8KQu+t3bLu8Kx7odFV/VE2sPRYYlS7EgQUgaM8R3talwfdwYtay5W0TXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838105; c=relaxed/simple;
	bh=skkSnuW1MdIFXy8IcxAkvvYsGPzYX4vwyzMcTyh0szg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCwQQCtK5AKYKQgH8HNNqfChqMeMdKLj7xnxl+UyFG35LdxXvFOZCGHmwO6ipbczuUU9wvuqOdwv43K02PzY04uBgNJvoNItjfu5GZeURAC0kjMfvhjE6gJd4CcQYKesPzBnEknqhzfdqjQrcVbAQhag0AzFLfuXyjSTTicGsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZawe9ng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724838102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Yd3rFzmS9qQQpG4ioW+kWZ7R6351lz0USRC/qcKN5c=;
	b=RZawe9ng8Tbczo4wnS65omy1f9PtjwlUKjeoJEM0RPYIycGEScaKVqUQwR+q/50xpEeFdj
	2ifQb3k0oz8YqXW9h1tjDrzCZ1Kf5asZibMgPyB0n3L2pfICeW4TkUu/ibOBYFxDas4rX6
	TlRgNHryCYLoXz596VEQdW1xEHmyxc0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-48oZGhKEN_egsH5NK2OYSQ-1; Wed, 28 Aug 2024 05:41:40 -0400
X-MC-Unique: 48oZGhKEN_egsH5NK2OYSQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6ad9ffa0d77so144970417b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724838100; x=1725442900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Yd3rFzmS9qQQpG4ioW+kWZ7R6351lz0USRC/qcKN5c=;
        b=Vej/anLoxAhDNYkpWAMoSNUmHTETTuBjrYYXwwP/vibMfGz9IflTevktNuSa6g8b2t
         tome06BU7+9ATiI/vUnuiHIS5jk25zl8oRbhuZTh9RVr+EuyskqbOU7g2lNwGt7qpjMc
         q/+1PysXcPI4fAV7BOGk0Hxjqj6IkzT4sFZEIqau81WD5rR4NHATTpAuDJ1sJEAOddp1
         UbXrbuUqUb/HxeS8Av3oZse/3052XK5Gm88u1/R9JvEZLnmEYR4goZLdH+UgJX8XJ6m2
         yf5w21njcRwUw+0IN3L1E5M1WUBu86PdRL3qKeU9ikutrUTTQ6ekyPiR63q6ASJOzjVm
         qucw==
X-Forwarded-Encrypted: i=1; AJvYcCV176bSrBWuFto9cnylyIQH+YMXJLWpQIykA/2Ee92LOQruHENYtDpdXFU2KCdDFdRnCQOuXNeuzYg+6Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtqs4UFtEXjnseCL2rN1v8v4aA6eX88bTNCZ+59b+SWf3bEp1
	by/3qUEStIdmWUdTdvTdjlMlHfoARSI2rOhstRwu2mBmswIanRPSAaHejk5dAw1qFbXnqgBbGcM
	qkzJpcsEBITkOW3Q+uwxjcg/Y3+C8mUtD3OKL1YQDzaA1eGmkU1pOJEIFgzBR6Q==
X-Received: by 2002:a05:6902:2213:b0:e0d:d525:86b8 with SMTP id 3f1490d57ef6-e17a8c1fbebmr17013008276.36.1724838100381;
        Wed, 28 Aug 2024 02:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/k/O8mP1KK/+YqegEJ7jjal4P8Q4yMJPU52PdUhYvO/Y3VBXKL4kEvKC3od5OT/8wxcjfXg==
X-Received: by 2002:a05:6902:2213:b0:e0d:d525:86b8 with SMTP id 3f1490d57ef6-e17a8c1fbebmr17013003276.36.1724838099982;
        Wed, 28 Aug 2024 02:41:39 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d6548csm63220746d6.68.2024.08.28.02.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:41:39 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
Date: Wed, 28 Aug 2024 11:41:33 +0200
Message-ID: <20240828094133.17402-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
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
---
 drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 356c30fa24a8..b0c8ad10b419 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -806,6 +806,14 @@ int drm_sched_job_init(struct drm_sched_job *job,
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
2.46.0


