Return-Path: <linux-kernel+bounces-385957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766409B3D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36D51C20430
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFB18FC67;
	Mon, 28 Oct 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzAlhRyX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896AB1DF25A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153180; cv=none; b=eks+uAllqDURNSqRvPpWljgNdHqF8MC4gmZKUh4DL/4kfg3xSVnJJw2EkCik0rGIDQ9dnCSq8M3dv2ft0ZoPm339GaUQxNqfCQk7p1+DW6ayyciKqlp+yLTW5Q4fUynFEom31GaWP5lSUtASRUdYRU8mQ8YI7fXShDRpUkaAm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153180; c=relaxed/simple;
	bh=lnNh2MyW6k3PPWKeZ3lkSphmqc6oZlzuJG2jDdoCDuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJrCK75779l4a/haKizjvzjOtl88xc/2GDcT7y1gZyqfltWg8uQF1+GJtkEmUriAkDwJ0kloIC84v33gutck3UmYIaZ33rNF4Khifg42KClS+G2ucP62FxAXITRznpYBJPpTvGrSmXXcsIq9IuWbsBR1CPnfxQYOzrMEtzAcqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzAlhRyX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e8436adso69740287b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730153177; x=1730757977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOY2vgqJ0KtVzbKcwr3dZPfuHJS0Y1wX9dhGpLmmysU=;
        b=XzAlhRyXDt0IKtNwkAaZzgCReQ5z9gGMXRlpYyOcbv/yDhp601ZroIh90cW7z2oleL
         PnnSDR1CtNDuegX5Do3uZpJweqKdDa1pgLKYP5rYL5uT0UW9A2xi5IR6LRQteerYcjSp
         xarBu5PuG1rXsYEckqswbikk+Pzz/Qy5x3/N3FqN3gxEpCc6AbNJF9xmbyeo1H/opSke
         SpFifHzlrVSGMO3AmFWr6oldlytnMYL48QItnldGPMwGA3Y8rMtehV1l3+lpwBJ8io5q
         HzZO/pb2IcslBZjMLGBOhoqQzzHybdY6WY97Z0qSPjIB0SX9DMp7HCxntTQYXP4gEcSL
         MM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153177; x=1730757977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOY2vgqJ0KtVzbKcwr3dZPfuHJS0Y1wX9dhGpLmmysU=;
        b=Z8trMN3lkq5uYjjMkRUsT0o23/9G3mM+7VLMyz0gsDDtTE6riahQI/3MP+XzYU7NH9
         +sRVQD6INEx7fi+YVcHzOiU4MISu7vN54O2u4O602VSqcJk6ZfJuY9RyfbDzqoprPG9T
         RhSl8ARV2tYcNjVBTJJpbLUEK10En2oZ6P6dXlpw2MwxXAPVpX06d4cmE5vSCWIlCPq4
         wGDCQf8yBZz4c05dEakD44s1G5rageFbyDrXk3PPg2/ibsNF6P9FWBHeJjPzeZgtCBM/
         eXyX2oDHKUxUEYjSGqJsCkxQBmL0twn5M8siKJcOLi585FjCnuGshJkNwRS19chuDiub
         wg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJBwe1Y/cbvzjGGruCzKr+usNlI7Hd94HtOr+XI1Hrlogm4Y13cwaEd3+GLFDbGK71cNvvLWSJHEYkQgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvbXjby5rWe3hLZlsh5k3uUArfK0Hq/XnwgCn92fZKnEwoDDP
	XBaiMb3fRAlHNOjCNJGCWjw5qELmdK5giJPanmiQTf1U7Rs4jdqGqwhuScOBHNQtFqZtKuYyhJe
	i8sueRfiYaCZlrxeGEm6fsQ==
X-Google-Smtp-Source: AGHT+IHJS7A7yrEb37MadLUrxRTDRexnft6XJqKZL6BE/v5PEF5d2AuI0hKlTnaiOAdoLKFKUc2XiD9OoW2teZTugQ==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:dd17:1d2c:7822:7fdf])
 (user=kaleshsingh job=sendgmr) by 2002:a05:690c:9682:b0:69b:c01:82a5 with
 SMTP id 00721157ae682-6e9d8b89f8amr7192987b3.7.1730153177563; Mon, 28 Oct
 2024 15:06:17 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:43:59 -0700
In-Reply-To: <20241028214550.2099923-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028214550.2099923-4-kaleshsingh@google.com>
Subject: [PATCH 3/3] tracing: Fix tracefs gid mount option
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
tracefs to use the new mount APIs caused mounting with the gid=<gid>
option to not take effect.

The tracefs superblock can be updated from multiple paths:
    - on fs_initcall() to init_trace_printk_function_export()
    - form a work queue to initialize eventfs
      tracer_init_tracefs_work_func()
    - fsconfig() syscall to mount of remount sysfs

The tracefs super block root inode gets created early on in
init_trace_printk_function_export().

With the new mount API tracefs effectively uses get_tree_single() instead
of the old API mount_single().

Previously, mount_single() ensured that the options are alway applied to
the superblock root inode:
    (1) If the root inode didn't exist, called fill_super() to create it
        and apply the options.
    (2) If the root inode exists, called reconfigure_single() which
        effectively called tracefs_apply_options() to parse and apply
        options to the subperblock's fs_info and inode and remount
        eventfs (if necessary)

On the other hand, get_tree_single() effectively calls vfs_get_super()
which:
    (3) If the root inode doesn't exists calls fill_super() to create it
        and apply the options.
    (4) If the root inode already exists, updates the fs_context root
        with the superblock's root inode.

(4) above is always the case for tracefs mounts, since the super block's
root inode will already be created by init_trace_printk_function_export().

This means that the gid mount option gets ignored:
    - Since it isn't applied to the super block's root inode, it doesn't
      get inherited by the children.
    - Since eventfs is initialized from form a separate work queue and
      before call to mount with the options, and it doesn't get remounted
      for mount.

Ensure that the mount options are applied to the super block and eventfs
is remounted to respect the new mount options.

[1] https://lore.kernel.org/r/536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com/

Fixes: 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 fs/tracefs/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1748dff58c3b..cfc614c638da 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -392,6 +392,9 @@ static int tracefs_reconfigure(struct fs_context *fc)
 	struct tracefs_fs_info *sb_opts = sb->s_fs_info;
 	struct tracefs_fs_info *new_opts = fc->s_fs_info;
 
+	if (!new_opts)
+		return 0;
+
 	sync_filesystem(sb);
 	/* structure copy of new mount options to sb */
 	*sb_opts = *new_opts;
@@ -478,14 +481,17 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &tracefs_super_operations;
 	sb->s_d_op = &tracefs_dentry_operations;
 
-	tracefs_apply_options(sb, false);
-
 	return 0;
 }
 
 static int tracefs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, tracefs_fill_super);
+	int err = get_tree_single(fc, tracefs_fill_super);
+
+	if (err)
+		return err;
+
+	return tracefs_reconfigure(fc);
 }
 
 static void tracefs_free_fc(struct fs_context *fc)
-- 
2.47.0.163.g1226f6d8fa-goog


