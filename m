Return-Path: <linux-kernel+bounces-389279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D369B6AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F0DB22EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E121764B;
	Wed, 30 Oct 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmjxXRTL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C245217643
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308839; cv=none; b=GRmPXohMLsRVscRCLgqn4lqh6KjIewoadp6n7uv4loLw+S630gNz9/cizfxIfhE9+3ztobDoi7rhOVHHcp+/infpXycNxEPhUMkGlfxCwIibYeDPhDw02YJMzPKQDZf3L7Re43TZz3GtT8olS9x+QIYl9R9YEK91eJ8/eIvOijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308839; c=relaxed/simple;
	bh=QTzPrNt1y6T97+ODSV9OoOTpzB2mHMaSvyY3ZTsxpps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QxfYgcsivePj78kNJWhBGb9HaqwVTFPEJAMqv4l7aBlTXv6lEuWPhEqhT9CJVKc2HdNBfBXicjoLBKJ08N6IpLtjHDT4d6wrpfFBzDQv1taQBsWSrpZh3hRs0wnsF/pJ2Wmrd77Mxm1pfd/bXbpW1HZfA57XnmtQmdSXPQedz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmjxXRTL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9e8978516so312267b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308836; x=1730913636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZAFMBfP9RmqFDPwMaII3ttBs8mLcPx4x5R9BgFxh0w=;
        b=tmjxXRTLP2Vl2GPReGLFYiYtkodsu5kN9JfQInojCvqUVi7UXx+5QIaNbhT8Fr0dYX
         AI4vsXULuyM/69dMA/ziJsweWOUv5Azuan8kvpJeW1g4pvSifZuhp3f7MbVeHsUQZ4oV
         yoTgnORtjaOm7bfPLd/x/XAXDM6j0xI3vukrCbcC2Axj+FyuOnZij7WOKOsQcAUQNddh
         fLsWfOkJ9x36nW80wLNRA/xov4o93KLCeFJzyFwI6dwjvNCVRAoVesMCTZFs0RY3xkFX
         B5rP5ooVTGla2ERouu/5Y0aViTja84tXqq4C/hmzE4d49+xjP7e4n9kCjt4IQKNGZtFD
         M4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308836; x=1730913636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZAFMBfP9RmqFDPwMaII3ttBs8mLcPx4x5R9BgFxh0w=;
        b=baUkWlT0SL6YV2cBP8/HsH+9X6aAAXyD6+1BLzFD/U5tGJ7SBL1FlskLJ2KYT6aO0+
         Upf981Sw24ZKFxvNgp6kHBmv4volqiLgT76wbZJDdLzTCfiZH/ky+efg2Ah3qhH2NNDw
         peI66YEgFAR3EzDOofsHU15PeWip/m7X8xwRQzxUHLWblysQL0pkeFDJbtk8Nosjwy3/
         fjdpK7F/MuMP9U+onpDi/D42zk7YXgDNaEO4DzWHUDnokBQfTVzQeRL3pYgpVHEdzz7L
         23/LZxblP20aylJs+Lbi38bUNul1tiAFz+AayShFr6Bd+ZESj9VDwC5oVCKiwUGqCwOz
         g9Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU3rEJ7tCMCb20ShtvQXWsF2olyKtXzXinN+xkyxrxtQ7ShvE1stGDP6lgHZk7W38IhwLwTE63EaVpePgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyYHtPg43bld2B77qjwAVnO47PAC6bJjTWD6Ayp21nGBAZmwY
	EZAhZgDUM700Al3absqQyHWpd+JJCqD8zT7K0RcfxV6RwD/0y1ITyuwbbQFp+USpehTvOm2lZDs
	ePUOQlbKAdKh9Ur5StSIkjg==
X-Google-Smtp-Source: AGHT+IEYSmUkID7i8uqW1VtyqeMAIz2uHzC1/pRBGdIO+y1PZ8usLvkHF+cASenUwYotfQQpqQ8YfyDG9pTXBDFoCQ==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ad9b:6cde:2e57:6aff])
 (user=kaleshsingh job=sendgmr) by 2002:a05:690c:6383:b0:6e2:ad08:4924 with
 SMTP id 00721157ae682-6e9d8aacb2dmr10879167b3.4.1730308835646; Wed, 30 Oct
 2024 10:20:35 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:17:48 -0700
In-Reply-To: <20241030171928.4168869-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030171928.4168869-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030171928.4168869-2-kaleshsingh@google.com>
Subject: [PATCH v2 1/3] tracing: Fix tracefs mount options
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	sandeen@redhat.com
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
converted tracefs to use the new mount APIs caused mount options
(e.g. gid=<gid>) to not take effect.

The tracefs superblock can be updated from multiple paths:
    - on fs_initcall() to init_trace_printk_function_export()
    - form a work queue to initialize eventfs
      tracer_init_tracefs_work_func()
    - fsconfig() syscall to mount or remount of tracefs

The tracefs super block root inode gets created early on in
init_trace_printk_function_export().

With the new mount API tracefs effectively uses get_tree_single() instead
of the old API mount_single().

Previously, mount_single() ensured that the options are always applied to
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

This means that the mount option get ignored:
    - Since it isn't applied to the super block's root inode, it doesn't
      get inherited by the children.
    - Since eventfs is initialized from a separate work queue and
      before call to mount with the options, and it doesn't get remounted
      for mount.

Ensure that the mount options are applied to the super block and eventfs
is remounted to respect the mount options.

[1] https://lore.kernel.org/r/536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com/

Fixes: 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
Cc: Eric Sandeen <sandeen@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Update the commit title to reflect that all mount options are
    affected not only gid, per Eric

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


