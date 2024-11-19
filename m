Return-Path: <linux-kernel+bounces-414382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9B9D272E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216052842BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2D1CCED0;
	Tue, 19 Nov 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFVDvEAZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D51CC175
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023794; cv=none; b=Hit8nKK6lGtfkr3ZsNtSJ7iFSYEPfEEVuGmxWCBmT8nbq0xRaVDgmrhYyOibhHmhJgSaG1+pJRNPlA+onTdJ1DOB2kMIScLf9wo6aF6VnmOs69Ph5bYQgVOhQYSQ2rgR60XbMvTMNVbLsvb2yNvtWNDagLjUOta6BxBrEky1EuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023794; c=relaxed/simple;
	bh=QHeKvcwAvOVKhNB2yYkfgSZ0ELgZAHJ0oLd1swKAoYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXuVHQx6KBSFqa5IUcUhe+p0GaXI1Q3FK33gwU1ivA6vwYFdiqhf8k8aqBbtfChWFcPUqY6UzxuCUYtKSn1UXdSVCSnHfDPqlgKUtzUC/FEpV6AWFcKvJLwtjRT+guxIeutQAjkDLJWq1DhsnY/E6X2PTKaONqT7tU1c102LVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFVDvEAZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732023791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IM6q7lPHlKw7C8MOy/l7XDFqHINGkT4HlVPOzeoZ1E=;
	b=MFVDvEAZuCXGriL5T10IUdm4yO1TSO0gIoGsezY3hpEkb6cVs2PV9wofUKIX2CtYUKTtTX
	lNmYoxDBVwzdMrmTscMf5UOiEp3pZKmMqwy7NapaFPfWzGWYJfAaokF8I9bVnDjX3lyVOX
	OJlWSYKHfop59242vgRzYyrp691S1JA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-E9o1A39fMhehfmwSiEWhiA-1; Tue, 19 Nov 2024 08:43:10 -0500
X-MC-Unique: E9o1A39fMhehfmwSiEWhiA-1
X-Mimecast-MFC-AGG-ID: E9o1A39fMhehfmwSiEWhiA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b35758d690so675548385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732023790; x=1732628590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IM6q7lPHlKw7C8MOy/l7XDFqHINGkT4HlVPOzeoZ1E=;
        b=GB5xN8XJWg+FJfNDMsWFW8etcc9CJ3yJiheWIWwrkh341M/IvfK5yt1oDCxwCCEoQ3
         wjXWAsiqASizGAPq/0B9ezaskCgrHLoLT24MG+GYoKLnsKzIwcVXOkzNzKVibzKmNFMH
         53nwccF3BZjTIZ1+brUzEc5OQFpb2ys1sXvcoN1knJOLc2YqLJxEJON+uUT1GRp3K/4S
         Zji8A+uQ8wlEmVX4JC9dpI+WMi5Y2cgU84TVawMt8RLQDaSmvwZjJItT0d5WRxCn8658
         3yNIV+vCSGkL0Ova0TLK0ApingV35FWEo6vxIZWPCn7CrNHNgKQTv5SOn79kaGlQDU7Y
         0RGA==
X-Forwarded-Encrypted: i=1; AJvYcCWSeUIMIwZnxlGkLaCDjQNW10B2uREKlIf1fTREJeE8w6DKBDNYRBczjcEuwXBG66Q5bYxBfXDaMheUyMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ct+E//MM2r1zzJW19f6DompwhK2AoETnuqVw/0MQ26px4M9J
	cOQ36vIxX47Xg7Eyi11FsfjzAaI5+iY+UE0v8VFGuz4Q/pCOU1wpqzRfzv23gGsfs1hVNjknNh9
	U2D+UtqhI8Iytt+6RKw7SbdnA86ATF72Rn7M4uTvm3JwZDMA3TiRMcLBLI4f29A==
X-Received: by 2002:a05:620a:269b:b0:7b1:51e9:ed77 with SMTP id af79cd13be357-7b362295753mr2552954585a.10.1732023790160;
        Tue, 19 Nov 2024 05:43:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG/xwFaUxOxPW1wDrOOSo9UtfbQeOA5GrZcLn6I8J8cQ6ka6/q58utbZ7HRC+hOW2oKPOs+Q==
X-Received: by 2002:a05:620a:269b:b0:7b1:51e9:ed77 with SMTP id af79cd13be357-7b362295753mr2552951785a.10.1732023789869;
        Tue, 19 Nov 2024 05:43:09 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a8aa02fsm92513685a.128.2024.11.19.05.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 05:43:09 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/2] drm/sched: Fix docu of drm_sched_entity_flush()
Date: Tue, 19 Nov 2024 14:41:23 +0100
Message-ID: <20241119134122.21950-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119134122.21950-2-pstanner@redhat.com>
References: <20241119134122.21950-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drm_sched_entity_flush()'s documentation states that an error is being
returned when "the process was killed". That is not what the function
actually does.

Furthermore, it contains an inprecise statement about how the function
is part of a convenience wrapper.

Move that statement to drm_sched_entity_destroy().

Correct drm_sched_entity_flush()'s documentation.

Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 16b172aee453..7af7b448ad06 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -270,15 +270,12 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 
 /**
  * drm_sched_entity_flush - Flush a context entity
- *
  * @entity: scheduler entity
- * @timeout: time to wait in for Q to become empty in jiffies.
- *
- * Splitting drm_sched_entity_fini() into two functions, The first one does the
- * waiting, removes the entity from the runqueue and returns an error when the
- * process was killed.
+ * @timeout: time to wait in jiffies
  *
  * Returns: 0 if the timeout ellapsed, the remaining time otherwise.
+
+ * Waits at most @timeout jiffies for the entity's job queue to become empty.
  */
 long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 {
@@ -290,7 +287,7 @@ long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 		return 0;
 
 	sched = entity->rq->sched;
-	/**
+	/*
 	 * The client will not queue more IBs during this fini, consume existing
 	 * queued IBs or discard them on SIGKILL
 	 */
@@ -359,8 +356,11 @@ EXPORT_SYMBOL(drm_sched_entity_fini);
  * drm_sched_entity_destroy - Destroy a context entity
  * @entity: scheduler entity
  *
- * Calls drm_sched_entity_flush() and drm_sched_entity_fini() as a
- * convenience wrapper.
+ * Convenience wrapper for entity teardown.
+ *
+ * Teardown of entities is split into two functions. The first one,
+ * drm_sched_entity_flush(), waits for the entity to become empty. The second
+ * one, drm_sched_entity_fini(), does the actual cleanup of the entity object.
  */
 void drm_sched_entity_destroy(struct drm_sched_entity *entity)
 {
-- 
2.47.0


