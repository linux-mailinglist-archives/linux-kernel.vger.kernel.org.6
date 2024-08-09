Return-Path: <linux-kernel+bounces-280644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF17694CD3B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F7D28320B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD03174EE7;
	Fri,  9 Aug 2024 09:20:11 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4616C87C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195210; cv=none; b=qSXS0UDeK94aTsCrnxqQBmqOQ/iBO+heGXQsx2Gimp8JTbZUAqdlSxiIimNvnZ6td8kpGrKPejm698k9j6NEC+HB0l9Qn6xBLn6Lm4O2uLUKD1fcogLnPbubNW2zO32pcfXYijOrXLR3E8WXwuX1rExJ3qSDcWV1lGws/yTTKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195210; c=relaxed/simple;
	bh=XuYf+FkiIRQDv6+nihGzh4piyaI3rk9/N5j0bXrW0DI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zti/Rp5YjEP0gaABpJr0zFKOe2OkNRecyvm4vPUX2nYDKNqYICLOanZ4A2EYFpwvGT041kUHM0XDnjZWr4bnWXVwyvuY2olGDTMMpWlSnQCzp6QZlqBq6Uq2OG0hy0zVBhCj4OIb5I/KO6ypapxOUTQG0AdHbng/bN6YGlX4S0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8223c3509a9so242575439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195208; x=1723800008;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2+ycnOEIVqf60Oyev3imHG8B7xcdVffnxvlBFtf4wU=;
        b=lLdC0dbs3eyuW9RSBqVAc5d5LuIG9rnrHuDod0fkUOhAzxzoCOcmcy6PlR9nGOEriV
         4zTKm9/k31ZdU8fAKUkYQ9Z5F1eS/hxoVHWnihGBBc6S4VS+jRHTbnZ3EB0H0Qpjr2rh
         YXheSf/d+p5My5Wq1If8zaxt1THyv1NwBUc7zg2oPwK2YDHM0IulJDMCVfWbTvtNsFWR
         LXHqa0Vamth+cAzq4I0AVupecrVDQNzGKJ1uSfyN1E6bo0rG3Ze5Oxq9ch7Ijhsp4aFS
         T9tDaQDIp6u7UmNCE02avZy047GjkBVWzfbjV9PXSQ0BjTky4wn2QTMaDnAbE5sHF5Te
         Ov6w==
X-Gm-Message-State: AOJu0YxQQ6q6dnDJC3ULVcbqloZ3rWYG/aR6l7WAER9dgkUz2KO6kNWn
	83+BVRevQJzkJa4ZVqmqGC1dU1jzNp/pXjgofmedxs7Y3Uh3md2mkzZC6cY8qbIH2C1cfm7ETAr
	wCv4wpWL2V0vz6SQHUIHx8n3rX4Wg9fnU5FGur4xgcPB7OScU4gDplBo=
X-Google-Smtp-Source: AGHT+IGB4qwWfWTxCifA0XQ0LfYtbHVscPg7bVyrULaL18mbrjCF1gZAVX7unHcEv5c3yYywRYZDB4iIMhSbgl6hwFBV/LQtY0wn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8405:b0:4c0:7f0f:b42e with SMTP id
 8926c6da1cb9f-4ca6ecce25dmr39498173.1.1723195208422; Fri, 09 Aug 2024
 02:20:08 -0700 (PDT)
Date: Fri, 09 Aug 2024 02:20:08 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046e7f3061f3ca6fa@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

permission not granted 

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..02cbc93ece5c 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
+#include <linux/security.h>
 
 #include "v9fs.h"
 #include "v9fs_vfs.h"
@@ -44,6 +45,10 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct p9_fid *fid;
 	int omode;
 
+	if ((file->f_flags & O_RDWR || file->f_flags & O_WRONLY) &&
+	    security_file_permission(file, MAY_WRITE))
+		return -EPERM;
+
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9fs_proto_dotl(v9ses))

