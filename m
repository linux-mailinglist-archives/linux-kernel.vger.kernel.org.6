Return-Path: <linux-kernel+bounces-204714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537918FF304
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2162B296E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B9198A0C;
	Thu,  6 Jun 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LCzVh+sV"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A73224D1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692129; cv=none; b=s3CO3vyeDzYTcXqgMmbXkniSixyshY/NDph3HSNjgXyCvoPWQ5eIKFZLHt98eKbJlnAoWhLPjKpZ79ZTzbHg5aMqHrWkEWmo/e8TCIz/TjhvVJPAbAV4/lrLVbL0uIdfnt8YNK7pIk//Qp/ZTHHp8bBTt/4tFoc0UF4W0FJgVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692129; c=relaxed/simple;
	bh=ZRNfyg/9QgeO3gss2GzH/5lgQLFM3FF9Hna9vq7/wuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPtF3Mh1cQ5RxfeQaL6iYqRoaMWzW6cqYD2QlnzacFjhcdJQ/FXRJlAhcbyzvDsnNf8Mst8eIISNvB29l63VW2Tar1cCtnBKmeMp+uh0nyWz0ljHkQrSKz997wuLAdC3lxN9TaCS2CTxggacSPkQq4HcRWFoAcon/GnF0SUhhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LCzVh+sV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68e7538cfaso159685966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717692125; x=1718296925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KWNindFIaZB1HTMS5OMX0T5eIKkBoU4yCP7CEwF9Bsg=;
        b=LCzVh+sVi4j+dFc5vM+617+Ey5nt535/Z3ZfEcFCt9YOm5AD4gv7nteljTsXANoazc
         3tn6k9481ql2El2XSV824BW7y5OEaT9nAukscsOQMG82Sxnr1SUJ8mN14ZxPtDHzRKhG
         SIh/yDkow1TUNIRmMjbN71LHKuvavqrYUGU/29djsogQ8zHoqTSXLuF6YhI4OQpVa6tA
         zE0wFubbrfvli++xgVaQgFcyYMKI7djIvmosjsIyBW44FWEhMeSteeAQVgJA02wdpFoG
         5+3+f8ibQvmvE+Ch22WY9aMWvRJ3p5rc7dDy22spDB5V1uXYeIExQyFj4ZlLrmIjQLBX
         cP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692125; x=1718296925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWNindFIaZB1HTMS5OMX0T5eIKkBoU4yCP7CEwF9Bsg=;
        b=BdMAbi9yvppx3JHla7JqqtX9Ky5IZY8aTw+D8kdE8ltlMvhne9tHlH6zrjHtGqet6u
         eqmf+GhFN9m30rGyoYumjcUIbyp1Wzi8AUDb4reFA5RXHxUx8rs1n6uIdBCXW9SnyXyP
         DQbePrRivZdLqT9OI/e48ctq0iFDHMXXRyhNv+HP02G82P4tGERajvlL4/1dXmak2jkG
         ggXGkgsyKE3qFzLf5n257Js2jRIxk9UMnLs4IAfXqLEvDI6vSUFZw+KpvvuyOI/bJKbb
         pkyr+4UlX0AaMkgYBKCeW3VcI90iuQmcCzu3VgfOZCWK1UAhskee2VXAWxj0y8diYi5N
         2ATw==
X-Gm-Message-State: AOJu0YzDwFx+DJvfXsqqOledIMq7/fY4rj74rZ6hgrqLKEXFrRCDjjdR
	maf8+GmMmDvtL8mo1J34YoqMBE1o2f75EV6dQzw53OtPnkiMm14/my5ivdLr6MJ8ltc53wYBF/m
	KBtY=
X-Google-Smtp-Source: AGHT+IGezYB/CP2cKfOnUTPtY92b+O/1mJo3K5LLRIqQOWwVekjh9HlCAC/3Rn7sQArIvZjoyd3fGQ==
X-Received: by 2002:a17:906:fb0e:b0:a69:1137:120a with SMTP id a640c23a62f3a-a6cdb0f5646mr6187166b.51.1717692125468;
        Thu, 06 Jun 2024 09:42:05 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f0efb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f0e:fb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eb099sm118003766b.102.2024.06.06.09.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:42:05 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/mds_client: use cap_wait_list only if debugfs is enabled
Date: Thu,  6 Jun 2024 18:41:57 +0200
Message-Id: <20240606164157.3765143-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only debugfs uses this list.  By omitting it, we save some memory and
reduce lock contention on `caps_list_lock`.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c       | 6 ++++++
 fs/ceph/mds_client.c | 2 ++
 fs/ceph/mds_client.h | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index c4941ba245ac..772879aa26ee 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3067,10 +3067,13 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 				       flags, &_got);
 		WARN_ON_ONCE(ret == -EAGAIN);
 		if (!ret) {
+#ifdef CONFIG_DEBUG_FS
 			struct ceph_mds_client *mdsc = fsc->mdsc;
 			struct cap_wait cw;
+#endif
 			DEFINE_WAIT_FUNC(wait, woken_wake_function);
 
+#ifdef CONFIG_DEBUG_FS
 			cw.ino = ceph_ino(inode);
 			cw.tgid = current->tgid;
 			cw.need = need;
@@ -3079,6 +3082,7 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 			spin_lock(&mdsc->caps_list_lock);
 			list_add(&cw.list, &mdsc->cap_wait_list);
 			spin_unlock(&mdsc->caps_list_lock);
+#endif // CONFIG_DEBUG_FS
 
 			/* make sure used fmode not timeout */
 			ceph_get_fmode(ci, flags, FMODE_WAIT_BIAS);
@@ -3097,9 +3101,11 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 			remove_wait_queue(&ci->i_cap_wq, &wait);
 			ceph_put_fmode(ci, flags, FMODE_WAIT_BIAS);
 
+#ifdef CONFIG_DEBUG_FS
 			spin_lock(&mdsc->caps_list_lock);
 			list_del(&cw.list);
 			spin_unlock(&mdsc->caps_list_lock);
+#endif
 
 			if (ret == -EAGAIN)
 				continue;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c2157f6e0c69..62238f3e6e19 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5505,7 +5505,9 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
 	mdsc->last_renew_caps = jiffies;
 	INIT_LIST_HEAD(&mdsc->cap_delay_list);
+#ifdef CONFIG_DEBUG_FS
 	INIT_LIST_HEAD(&mdsc->cap_wait_list);
+#endif
 	spin_lock_init(&mdsc->cap_delay_lock);
 	INIT_LIST_HEAD(&mdsc->cap_unlink_delay_list);
 	INIT_LIST_HEAD(&mdsc->snap_flush_list);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index cfa18cf915a0..13dd83f783ec 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -416,6 +416,8 @@ struct ceph_quotarealm_inode {
 	struct inode *inode;
 };
 
+#ifdef CONFIG_DEBUG_FS
+
 struct cap_wait {
 	struct list_head	list;
 	u64			ino;
@@ -424,6 +426,8 @@ struct cap_wait {
 	int			want;
 };
 
+#endif // CONFIG_DEBUG_FS
+
 enum {
 	CEPH_MDSC_STOPPING_BEGIN = 1,
 	CEPH_MDSC_STOPPING_FLUSHING = 2,
@@ -512,7 +516,9 @@ struct ceph_mds_client {
 	spinlock_t	caps_list_lock;
 	struct		list_head caps_list; /* unused (reserved or
 						unreserved) */
+#ifdef CONFIG_DEBUG_FS
 	struct		list_head cap_wait_list;
+#endif
 	int		caps_total_count;    /* total caps allocated */
 	int		caps_use_count;      /* in use */
 	int		caps_use_max;	     /* max used caps */
-- 
2.39.2


