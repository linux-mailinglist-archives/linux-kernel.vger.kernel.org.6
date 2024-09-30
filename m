Return-Path: <linux-kernel+bounces-344756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20A98ADE5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80676B240A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45E1A256C;
	Mon, 30 Sep 2024 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw1rCGsq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2F199E8C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727260; cv=none; b=evwDPi2lwNhZ7EBu2hF7myJRk62EmJxFV08ga+i+NwBpzsR8vW9mGjdqq5YiYWrkU/wslhHvNL/SYMzQL+BuahZZ9m8owPyNsctiYxwvmI421/qt1PsVTsR8kMmfjOucC8Up7zafu/uzsJdT08FFkrIx+8Eqh9iM5p9ANzByheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727260; c=relaxed/simple;
	bh=7+E295+fTdtFYJE7SO/shAHSrnEGhOeeX5vu6OAwvNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHpYkMOvmzx5lFyYRTLjCjp1ml2YtfjC9cGF0PEbMJIfQvBRqmihaq7NmwLWrmbWLFxfavPH2Is0g9Poji+2Ump+A4bPl5Rixnn/ITCRJxFYlwgIlA6FrIGZ+2FP2G9oR6oOTgmHivSLZC//99AMfkostHPjjHZ7XHS8sC+qXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fw1rCGsq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+k9OgWsKdKtc2JL0VLbtqiJHf8Tzgl+WMY1WPT70Ug=;
	b=Fw1rCGsq+X9PpH67rL9D3TjtiiLF5tgpU0Bp8iElA5TCljgcDUwG9n+6iGIRZzkqLzaC2Z
	S9LDdjuif94q0ar6P7GhOFKOTqFcOOhnLrXTU619Nqu612A45B+duO8au8xAHPZwLrSb7b
	TJzCLQE9ins6E/vC9Zuq2LWgdItoHJk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-IIx2CHq2NJ2ZqCw6aEiNow-1; Mon,
 30 Sep 2024 16:14:12 -0400
X-MC-Unique: IIx2CHq2NJ2ZqCw6aEiNow-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 909B3197703B;
	Mon, 30 Sep 2024 20:14:08 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (unknown [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FFB61955DC7;
	Mon, 30 Sep 2024 20:14:06 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	vvidic@valentin-vidic.from.hr,
	heming.zhao@suse.com,
	lucien.xin@gmail.com,
	donald.hunter@gmail.com,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 01/12] dlm: introduce dlm_find_lockspace_name()
Date: Mon, 30 Sep 2024 16:13:47 -0400
Message-ID: <20240930201358.2638665-2-aahringo@redhat.com>
In-Reply-To: <20240930201358.2638665-1-aahringo@redhat.com>
References: <20240930201358.2638665-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A DLM lockspace can be either identified by it's unique id or name. Later
patches will introduce a new netlink api that is using a unique
lockspace name to identify a lockspace in the lslist. This is mostly
required for sysfs functionality that is currently solved by a per
lockspace kobject allocation. The new netlink api cannot simple lookup
the lockspace by a container_of() call to do whatever sysfs is
providing so we introduce dlm_find_lockspace_name() to offer such
functionality.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lockspace.c | 18 ++++++++++++++++++
 fs/dlm/lockspace.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 8afac6e2dff0..00d37125bc44 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -238,6 +238,24 @@ void dlm_lockspace_exit(void)
 	kset_unregister(dlm_kset);
 }
 
+struct dlm_ls *dlm_find_lockspace_name(const char *lsname)
+{
+	struct dlm_ls *ls;
+
+	spin_lock_bh(&lslist_lock);
+
+	list_for_each_entry(ls, &lslist, ls_list) {
+		if (!strncmp(ls->ls_name, lsname, DLM_LOCKSPACE_LEN)) {
+			atomic_inc(&ls->ls_count);
+			goto out;
+		}
+	}
+	ls = NULL;
+ out:
+	spin_unlock_bh(&lslist_lock);
+	return ls;
+}
+
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 {
 	struct dlm_ls *ls;
diff --git a/fs/dlm/lockspace.h b/fs/dlm/lockspace.h
index 47ebd4411926..7898a906aab9 100644
--- a/fs/dlm/lockspace.h
+++ b/fs/dlm/lockspace.h
@@ -22,6 +22,7 @@
 
 int dlm_lockspace_init(void);
 void dlm_lockspace_exit(void);
+struct dlm_ls *dlm_find_lockspace_name(const char *lsname);
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id);
 struct dlm_ls *dlm_find_lockspace_local(void *id);
 struct dlm_ls *dlm_find_lockspace_device(int minor);
-- 
2.43.0


