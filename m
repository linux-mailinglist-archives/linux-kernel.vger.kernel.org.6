Return-Path: <linux-kernel+bounces-259668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B700939B24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63F5285D99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A614D2B1;
	Tue, 23 Jul 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j69J5RcG"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D714B959
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717385; cv=none; b=kSyZ1CM/BXkEYydnD3nLa9fpEUIgT0Z4Kp5d4/CGFAsQxfd9byI7mwA6RzeL3ybG6zSWU4mtd9mIubGqKohX7CB6PWNHZe4P3IWLwZMEmSRc2LgK0y1rguYn5B6JjmF4DDqh3p0U+UhaLDukxOh2jxhJmIeRZSakjeAQq72F7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717385; c=relaxed/simple;
	bh=0Q5Y0u/59VsSKABp0rrGvwf2iG094BtB/MJhwlXZjN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rG0Dh9VlcKcsha+rQoZAHPT8FqvE2d1B7S1sKNzJ9Ki1ggadYnHJpcksBLB827bLA4xL3Kvvz4T8VeCMBD5bkbKADaUhGFS7YIXLjKre/M0l8ABKJJzsizvm+ZZgROyOTnhe7y8mMBN7sSthqcpeBblCtxbzt0BJuefhuJbas/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j69J5RcG; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 301E63F730
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721717376;
	bh=FZLjJAcXmHbLrd6SXPvE5R1r1QmGlvoXd3SP54bkBhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=j69J5RcGCzLUn5UlZ/qkrBR1Ps94MbfOkcZ5rtUQ5gQWBH9Gr+fVIia2RB7KYjZsg
	 bALczu06VN9yjkRlqhCNpx6DlX61YnDYeRz2UvO8xVl0CF5bd0aYG3oR4zCXIFlh+Z
	 aL1mbnh//8Lr2/s9RZ9RU/5SOoft5TZam0TF05hxSsT+E6g9L6yiVCFbLv/I/PzzKf
	 7fgXigCqXefQX47ITElK9prElTe60AU2alN80mbvY/x/buN6zk2E+YbLcP0kFn42cY
	 8IGQGjFmn2YRCCPFc0naJ2m7/wtdBU2TqYjF/Im3C+v2WgG41osL89/r72eSIDHhnv
	 QkfTrMEuqHbXQ==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb653cb5e6so4514109a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717375; x=1722322175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZLjJAcXmHbLrd6SXPvE5R1r1QmGlvoXd3SP54bkBhg=;
        b=HqD2YolDZzHgyxw8+KV/i/+sHnyLuY39Jo9LXSI1w2cfk2qFJbUvzqWOY2pJGVbWiv
         OsUd66AXacD4SZdkD9SpvHqklEBoiHsQNoFtjqwwkQiU/iVnFSPPSOTVdxqht1khnVqg
         JQrLPHwiARCZ6Nd0avNEvGjLNCd/ngypLo/dDVtbN8BRXqbK3fnhXbNhs0VJ9lAXsJnt
         /hRC50Hjs72OnR06AA9pVgKPQJ48JIPRo2TpFAmezAgwC1JRc+tDzzFlrXsjiC3kcxbA
         SiRHJcM3KUdQj9JhE6GSCr93dPr+8/8LjBe08twlTJgT+8E0Z2b3kD8t7O1+lb5u7bIk
         +OQw==
X-Forwarded-Encrypted: i=1; AJvYcCXJZsTyFhdMLfasJJk3ob+43OwiVqqdof7OiAQ5vexCqPxpb0s/Jasex++mDyW648LpXAjJKA7JK1ybOm6ih+eQVAKco/JN3+EXS/WS
X-Gm-Message-State: AOJu0YwCa+2XcDFnR9OpCW0Zwrfl6x8T6Mvx3rq+o1mJQ3hznuNwx+kw
	vt+muCJ833S6plVXps28Pyfbeyv6E1a4huozwERegJGUOaQC4d33dlDe0VgB7EoTd960Nbhu8/h
	1hvKR1SE1kHuQ+30aaFvIzSmmU/Vg5t348W48cZ7S4/zi4l/Y5noTP8VfTU0yAFpuo+nDCqr90k
	bfKQ==
X-Received: by 2002:a17:90b:1b01:b0:2c9:860c:7802 with SMTP id 98e67ed59e1d1-2cd274adcc9mr4794630a91.28.1721717374741;
        Mon, 22 Jul 2024 23:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyHMUKv6gR8JgkHmVIVGpYTx4tb8B3QCJ9HWDbWwLfpovncTtZcuCPQHfoJdvHkml9CbbRnA==
X-Received: by 2002:a17:90b:1b01:b0:2c9:860c:7802 with SMTP id 98e67ed59e1d1-2cd274adcc9mr4794620a91.28.1721717374355;
        Mon, 22 Jul 2024 23:49:34 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c5391bsm8354749a91.24.2024.07.22.23.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:49:34 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Kent <raven@themaw.net>
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] scripts/gdb: add iteration function for rbtree
Date: Tue, 23 Jul 2024 14:48:58 +0800
Message-Id: <20240723064902.124154-3-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
References: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add inorder iteration function for rbtree usage.

This is a preparation patch for the next patch to
fix the gdb mounts issue.

Fixes: 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/rbtree.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/gdb/linux/rbtree.py b/scripts/gdb/linux/rbtree.py
index fe462855eefd..fcbcc5f4153c 100644
--- a/scripts/gdb/linux/rbtree.py
+++ b/scripts/gdb/linux/rbtree.py
@@ -9,6 +9,18 @@ from linux import utils
 rb_root_type = utils.CachedType("struct rb_root")
 rb_node_type = utils.CachedType("struct rb_node")
 
+def rb_inorder_for_each(root):
+    def inorder(node):
+        if node:
+            yield from inorder(node['rb_left'])
+            yield node
+            yield from inorder(node['rb_right'])
+
+    yield from inorder(root['rb_node'])
+
+def rb_inorder_for_each_entry(root, gdbtype, member):
+    for node in rb_inorder_for_each(root):
+        yield utils.container_of(node, gdbtype, member)
 
 def rb_first(root):
     if root.type == rb_root_type.get_type():
-- 
2.34.1


