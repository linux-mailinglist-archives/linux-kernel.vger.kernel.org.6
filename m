Return-Path: <linux-kernel+bounces-287743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34AB952C19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDD01F2482C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454F205E0E;
	Thu, 15 Aug 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WQbp65R9"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D120125A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713901; cv=none; b=LswvVM8AKLEgw0clJDfa5kmvNVhVCQk3+X0bpz94N/6qT5Zvc/uiQ8Wm4PCXpl2iG2QTGQ+oCbn8y8IepkkeiEKlaD9mcta3wqW/R2oqGtv+urW4DQZuVCzAz74MKMtMFsIF6PSJi2e/wGLANvvOg/dstN4oIho33fPc9jtKILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713901; c=relaxed/simple;
	bh=ONyUrWrgUBZRJvO+nhcwWS/g3zi/w0z15wLOTv3nesw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDNTFKX/gyAYnS0X5D3pVKQvJVp8m7ZilfPKMudMWHZlX02msZ8PeUxoJKhloNj63oYj+JOuJNiEiRjEzlAPGhTlUeweyQvF1djGvoB0fJfRUPcNbDo3fLEoKsTKonGZzt66Y1gfOGLD8SKJVy/LJRdaIOtwPlkCwHqj+icbeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WQbp65R9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B29B3F1EE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713898;
	bh=+wGAYIUsqVxDBSfRQAij7GIIUQJC7PY8L940f+LK16E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=WQbp65R96KUqMq2tQQHAbqCR5RPCIB/wA8HBBObPm/zqYgr/CKsvdBqUCfVTWd0aG
	 Zy1SMf/Xcl50OFvzBcAnmboTuEWWFsJY8DdNz5+OXF6SbHTXndPsVoh+YxUrscscS7
	 xLZEwojxqawnYpaHCQzpcnmOQmBc8R/Ex6bOVQAekGxBY4RWSkkxhYBxBNjz0H4VvX
	 bDTm1lTZLF/1tQ/2rZzKaoWrSMLHDZa8XCYocp0NlcjcMGoKZFU6kBGPAu1sE9kCR7
	 g+RB2AAGtpA+kA9FJa7IGVQaeDfd0zFQIYBrbCWYuyuD1j2kpqFZTD4MJq0xMj8dcx
	 Lq3VHpnp0bFig==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7a979cae97so72621266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713898; x=1724318698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wGAYIUsqVxDBSfRQAij7GIIUQJC7PY8L940f+LK16E=;
        b=fle4owXX94ELZHgwYlngLRWELKwIhHE+ToMMw14vi4KaQJJ9lYYfeanXAE3WUso0hm
         2zaxCIFCOQPLgBn0evqSDs0LcV9efj2xwC92N/oM4tygIRKAC38KsPVIXXSP7uoDvVAD
         r7hVTqHx5JqAtlmqspBV3SUNj94zc0Bc0A+w0C6kUHRBQRj0pwBWDzEa3AuldrmmxdiU
         FZqbsWAXnZemSw1/s8mPE+RvMpz7p+YAhfxTXF8T/GhJiAOog5HPHsqy0hp6SoDM7Pr5
         5Ogv+VPpthtFmdLaM57PQ3auCOORBg/RMUQn+XTzPJrjtwV9qM12NSbTQfwNcZjvnwCJ
         /OBg==
X-Forwarded-Encrypted: i=1; AJvYcCW0FOWOhA0KwAMKZ+G4mZF1VObMYPJBCGFP/1Fls0JzMTEIOIPu3E2k2jCYFe8uv4paA9cFDm8fCuVlf745iwP3I6odKJ4vqy62pWAA
X-Gm-Message-State: AOJu0YzuWYQ0hWzR3IT+4eNjPzquHoTcFjlZ0wMjSvNC9wsN4aZHtgGG
	7UUpzA0mzsS7slNqKQS7T2CQwEp7bjFOgQY2Vo+5uWkNuDwCt/WUz+ZvpdJZiVin8N9b6MLiTq4
	p4Lwb3Ywoyqz73O8VU6Iwfh4c9KGTCcSrFYkCAdapMcEeVBRaXjgwTuCHnQxsj8hGnUilM5/4Wq
	yzcQ==
X-Received: by 2002:a17:907:c7d3:b0:a7a:bd5a:1eb2 with SMTP id a640c23a62f3a-a8366ff3a98mr420619266b.54.1723713897815;
        Thu, 15 Aug 2024 02:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuKDZsZwogroqc1dsjEpW71XEGxJgIgeq15px+a9+tIq8OenSZ6u8PMrp1qdRVRLS8F9toSw==
X-Received: by 2002:a17:907:c7d3:b0:a7a:bd5a:1eb2 with SMTP id a640c23a62f3a-a8366ff3a98mr420618066b.54.1723713897408;
        Thu, 15 Aug 2024 02:24:57 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:24:57 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] fs/fuse: support idmapped ->permission inode op
Date: Thu, 15 Aug 2024 11:24:22 +0200
Message-Id: <20240815092429.103356-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only cover the case when "default_permissions" flag
is used. A reason for that is that otherwise all the permission
checks are done in the userspace and we have to deal with
VFS idmapping in the userspace (which is bad), alternatively
we have to provide the userspace with idmapped req->in.h.uid/req->in.h.gid
which is also not align with VFS idmaps philosophy.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a5bf8c18a0ae..cd3b91b60cae 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1567,7 +1567,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1575,7 +1575,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 		if (err == -EACCES && !refreshed) {
 			err = fuse_perm_getattr(inode, mask);
 			if (!err)
-				err = generic_permission(&nop_mnt_idmap,
+				err = generic_permission(idmap,
 							 inode, mask);
 		}
 
-- 
2.34.1


