Return-Path: <linux-kernel+bounces-218966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5190C83D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790EAB23F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451042101BB;
	Tue, 18 Jun 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAePAvtK"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130632101A7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703768; cv=none; b=ZbCHRNsRFkFQrecSW/POaZWdOVzX71Aejq5iqsjQTjIBxa/xE5giXknGe0OYduUC6XxiMELOua9UM7ZLqsDSXI+ZvfAqVQ6R+ZQ4j4wW9L+NNOFDvT69mePmRyzl8/AEZdww1stPF99P1RQehjPmibg7ib+FI7UIlzakSL6BXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703768; c=relaxed/simple;
	bh=Xd/7HLiI5SQS0iwdei3EdV90pqRjwnEJI2YKRm7gZ+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3jN2XVvMrwxV5evVfhMmrDE25Y7twgymKqMBJ6/3WWscgrcbPDsENLRax2yK5PccoxKJpFf0/jtB3rw0C6m6c8cmWU7hHX0W0iYdMWMYU1mM9uSJxQwr0i+HqprNdi5WvvMeNpIbqPaRnDunyigHsuv6W/DU8N+I8W3q7oyxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UAePAvtK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-705fff50de2so1318798b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718703766; x=1719308566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSBvd6UdPXxQAYikzAX9WnO+l3sKpqabC3P6H43CjNw=;
        b=UAePAvtKaxS/CbYalNtM7WQvAYUkpZ1vUZSGUwiQ0D8foZG8o33AuesJH5D4A5dc42
         oZ7N0XXap3G70UUQ/hcmQB32ojyRRdRfHo9fsDnEA+/uBXq50qcUD+nU0Cc0YIck6EiF
         EZHFGZQYdYiwuS+QWv0vZ97UZ1X4T5+8gmcv05RVrKSZBwx5vdsSzg34h1y6bp7JlNoJ
         LvO5j49U4Vo9eRynhOmhUJ7+3BAb2mHdp7nVVgVdL1MfOkIsz4nKs60rMUytoc8JanJg
         e9QhThaxIsviHN5Na1mdRxz/CjuRksV+RRpy9T0H7rlGAXLpTC7H1ir1/CLxoTl7IuKX
         pA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718703766; x=1719308566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSBvd6UdPXxQAYikzAX9WnO+l3sKpqabC3P6H43CjNw=;
        b=bCgNLBxCFj+DTQr91zoqKk4UIqD1Djhb2PIdX4E7ra59O+wi1/cyxCTPlqqGCIDnXI
         Ub+ejZ/zaQMgwHC6jwbnl++qaNCYcpg/+MArbSnqdj520+R7hgCyA3u+5jkMDe2KPM+7
         cRz56axWGZAeOxD//aMW22Ah2hkpqr1PGuv/bIEX5gnNhNNr+GihE8sr09tSayumlCZ7
         YehJE6YiQjlHAGtQDkUiwsAa5LPpZiWLBEH9m/gAcjTMg/9vQ7Fy214LBIpXZT75wpzM
         MSAsBaR9TKqFU1BuVFpJuqtk5UTjdzOYh1n8ix/4Ov8ijuf/ak5npnxztdr4QKOcCS5o
         QGcg==
X-Forwarded-Encrypted: i=1; AJvYcCWHkYSL9S2it0Rz7TQfu4uAWIwWgLfPAuc4HuG9Sk/GTxVGduxkbQFkMHhWM1T6OxnLnKfl7AsxOAf/yCT8/CLgDBbJ9QmcQQryJ/XJ
X-Gm-Message-State: AOJu0Yx1/56gFJ5pjdYnuSkH38Ardin5khZBsOLLcC2S0SwP8s9GgCVD
	JzexjIBrIgY4C/TVo/BnbgdfeR/ZnYPYPOUeM0VvKDCVzCwrjQSagLFEWvRxrko=
X-Google-Smtp-Source: AGHT+IHcl/2RoXVQ+71aHNYVjn3NoTwhv2qPyWAbcWs0ParO44xZQCCVzutKlPjbF2/gE9SyhHgTKQ==
X-Received: by 2002:a05:6a00:4b47:b0:706:1bb3:fb1d with SMTP id d2e1a72fcca58-7061bb3fc6amr3055052b3a.7.1718703766091;
        Tue, 18 Jun 2024 02:42:46 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb92c89sm8582018b3a.213.2024.06.18.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:42:45 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] xen: privcmd: Fix possible access to a freed kirqfd instance
Date: Tue, 18 Jun 2024 15:12:29 +0530
Message-Id: <9e884af1f1f842eacbb7afc5672c8feb4dea7f3f.1718703669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <a66d7a7a9001424d432f52a9fc3931a1f345464f.1718703669.git.viresh.kumar@linaro.org>
References: <a66d7a7a9001424d432f52a9fc3931a1f345464f.1718703669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing prevents simultaneous ioctl calls to privcmd_irqfd_assign() and
privcmd_irqfd_deassign(). If that happens, it is possible that a kirqfd
created and added to the irqfds_list by privcmd_irqfd_assign() may get
removed by another thread executing privcmd_irqfd_deassign(), while the
former is still using it after dropping the locks.

This can lead to a situation where an already freed kirqfd instance may
be accessed and cause kernel oops.

Use SRCU locking to prevent the same, as is done for the KVM
implementation for irqfds.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/xen/privcmd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 5ceb6c56cf3e..041774750e52 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -16,6 +16,7 @@
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <linux/errno.h>
@@ -845,6 +846,7 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 /* Irqfd support */
 static struct workqueue_struct *irqfd_cleanup_wq;
 static DEFINE_SPINLOCK(irqfds_lock);
+DEFINE_STATIC_SRCU(irqfds_srcu);
 static LIST_HEAD(irqfds_list);
 
 struct privcmd_kernel_irqfd {
@@ -872,6 +874,9 @@ static void irqfd_shutdown(struct work_struct *work)
 		container_of(work, struct privcmd_kernel_irqfd, shutdown);
 	u64 cnt;
 
+	/* Make sure irqfd has been initialized in assign path */
+	synchronize_srcu(&irqfds_srcu);
+
 	eventfd_ctx_remove_wait_queue(kirqfd->eventfd, &kirqfd->wait, &cnt);
 	eventfd_ctx_put(kirqfd->eventfd);
 	kfree(kirqfd);
@@ -934,7 +939,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	__poll_t events;
 	struct fd f;
 	void *dm_op;
-	int ret;
+	int ret, idx;
 
 	kirqfd = kzalloc(sizeof(*kirqfd) + irqfd->size, GFP_KERNEL);
 	if (!kirqfd)
@@ -980,6 +985,7 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 		}
 	}
 
+	idx = srcu_read_lock(&irqfds_srcu);
 	list_add_tail(&kirqfd->list, &irqfds_list);
 	spin_unlock_irqrestore(&irqfds_lock, flags);
 
@@ -991,6 +997,8 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	if (events & EPOLLIN)
 		irqfd_inject(kirqfd);
 
+	srcu_read_unlock(&irqfds_srcu, idx);
+
 	/*
 	 * Do not drop the file until the kirqfd is fully initialized, otherwise
 	 * we might race against the EPOLLHUP.
-- 
2.31.1.272.g89b43f80a514


