Return-Path: <linux-kernel+bounces-387038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8A9B4B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165BC283BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41919205132;
	Tue, 29 Oct 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6yVprjS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D610BA50
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209148; cv=none; b=AGOA7ZqvICtP8G45r8f8ex51k3rYjJbvLXt86YXfWEMYz4HQdMTk+nG3Jp1W3mfDzD+VUGVnyTor2cA9FR4QCVRE+NMFNq9C40Z9ENXmIQ597UjKGwhWHzk6Tpo9urmRrS1GQIKcqa77Jq+GhTA34I1a4nPeF+FpluNogh9lf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209148; c=relaxed/simple;
	bh=QxD4aAnCWjzxJID4yBlGed9qmJcBYBtYhkuNpY/62K8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9yaJmymXXnLcL8oM9hxkxxtXcutWOmxiktiVRYicIIuLfRGyYFhjIRkAPVMMA1pxQsg0zRg0Oqpgn//q8SvbuvkBQmP5+A+19B59DU67J0KJdkIb0PjJtCZccuhtnTkAEpt7RO3i3O8w34kbnCf9PDSMuA2EOQgxOl/S5FhjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6yVprjS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730209145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d9Bml+ipcFmRE9LbTe8J9ZN0xa8/xqfAjwsu2bf7Us8=;
	b=Q6yVprjSfCKHV+Njg5M5kKDXG0ZJSYMkHDB2odjsJNUvaz7RL2PQ3lQ2HxlA71jgznqhSJ
	LlbpIf7aU9sMTtNxNExGVgyeLqmo5MHcsO98ID/qjsSw8t4o5dzQCU/yronvHhs3HiitJ/
	FaFaUVM7rqupOKxqtsshSXSY+3P+0v0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-AnVPeLL0ME-GxVaPWvO6dg-1; Tue, 29 Oct 2024 09:39:03 -0400
X-MC-Unique: AnVPeLL0ME-GxVaPWvO6dg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so41810985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209142; x=1730813942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9Bml+ipcFmRE9LbTe8J9ZN0xa8/xqfAjwsu2bf7Us8=;
        b=CAdGjiFKizDdaHDgQhAkrmk0/4iY0K0SYQcOXeogECO9Cymc8CKslFWFXtpH4c4+t4
         Ba5MiVPJmko1PV+TDX5OjBulBMNCO/SMI1snOxNSvq5n1o8VeQCmlsaOak8pc2duBToK
         lAaKw3mLUd6oftYAKIUDrhkqAKje8UKvo867aTxhjDliq71+matI00d74bQPtUyGfLuW
         qapSNeS1n87knxzyrqMWKPBuh4ShEPGqDVT+s+he6pB/b+aYYl+9M4VKUxrveWy2I5zt
         RSngto+IEIk/bOUbef0OBk+wykvUNDH84Ci4jYItp3N4wSZmgFegHVQjEYKLfKRFHWWq
         1t/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXB8j0+gZhcOI6QpgFRYNfHOrbpAZ00utWX2d6uRh65zy0MYvW1A7NnY1GiH1H8XanTzrVah0I+8zk10jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygj/jHRpEUJwP9NmUzv5pgEPgEm9JtX/RJwFhP7u4Rl0Bik8Mn
	PlUFFnvf9pEPZqeMs24Y3pK5hmJ9NMF4aG+TqgHMv3/H6MuvHXDsmG9/+fy+lGnmEv4cu2ZyCtv
	c2r9hkZIMlXoT9ajbH3NpNpaUrJ++lpBn5HOtsuSQczLTG8JVC2464fSeALftJw==
X-Received: by 2002:a5d:42cb:0:b0:37d:4d3f:51e6 with SMTP id ffacd0b85a97d-38061128d8dmr9109492f8f.14.1730209142662;
        Tue, 29 Oct 2024 06:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnNYQdmX/Cf1HAHGYsP3YDXheGvJlNwRqZ9MpjvXIiGh8raR74zxJw+aczFFjgNuCclCWScw==
X-Received: by 2002:a5d:42cb:0:b0:37d:4d3f:51e6 with SMTP id ffacd0b85a97d-38061128d8dmr9109470f8f.14.1730209142246;
        Tue, 29 Oct 2024 06:39:02 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b713f0sm12525299f8f.75.2024.10.29.06.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:39:01 -0700 (PDT)
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
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Document purpose of drm_sched_{start,stop}
Date: Tue, 29 Oct 2024 14:38:20 +0100
Message-ID: <20241029133819.78696-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_start()'s and drm_sched_stop()'s names suggest that those
functions might be intended for actively starting and stopping the
scheduler on initialization and teardown.

They are, however, only used on timeout handling (reset recovery). The
docstrings should reflect that to prevent confusion.

Document those functions' purpose.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index eaef20f41786..59fd49fc790e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -601,6 +601,9 @@ static void drm_sched_job_timedout(struct work_struct *work)
  * callers responsibility to release it manually if it's not part of the
  * pending list any more.
  *
+ * This function is typically used for reset recovery (see the docu of
+ * drm_sched_backend_ops.timedout_job() for details). Do not call it for
+ * scheduler teardown, i.e., before calling drm_sched_fini().
  */
 void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 {
@@ -673,7 +676,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 	 */
 	cancel_delayed_work(&sched->work_tdr);
 }
-
 EXPORT_SYMBOL(drm_sched_stop);
 
 /**
@@ -681,6 +683,10 @@ EXPORT_SYMBOL(drm_sched_stop);
  *
  * @sched: scheduler instance
  *
+ * This function is typically used for reset recovery (see the docu of
+ * drm_sched_backend_ops.timedout_job() for details). Do not call it for
+ * scheduler startup. The scheduler itself is fully operational after
+ * drm_sched_init() succeeded.
  */
 void drm_sched_start(struct drm_gpu_scheduler *sched)
 {
-- 
2.47.0


