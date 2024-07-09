Return-Path: <linux-kernel+bounces-245712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6092B71B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6A8282CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA5158861;
	Tue,  9 Jul 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgIwMi49"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB600158A29
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523978; cv=none; b=NUhen0jy3FG8us+csoi4CoecgcNk5ck8DnAnAnqCmqxTvk7p8UPOU1FlxQqEDxAWAspl5I9dGuETBbjj1P+hYA9kS6gaDm+o3A3wH3vs6iif3XGJ9N/QUbAvRQmRPZjDItRKiecpYoGKnnVPU2aZgaexMvwLtKbFaqnu7tr0Pb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523978; c=relaxed/simple;
	bh=c6/xDqIBUH9kZJ3dSSFqPpC8zcL9m+9ITWVHyL9+N9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ3rWVrv4PoSB+9i2hH2duRswEjcD2958/Jn7gDXrPdVG7wa2wy2dOdhFnH6FnqKI0t5YZXFyH9No56Cldbj+fkM9YO0qbAG4l1hI5FWucG6MLLho0vDo3hYt9B2n7fqReBjLwsbLe2BzaGhwCP6Twxdv9D+3s+xmL39Zgb7DKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgIwMi49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720523976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9cY1BbeC8V5UfvyXbcs6HntSp+BaCe1he0FDoMTU60=;
	b=QgIwMi497S+YGtfYvURDy+l7hl9YgcuzK1LMeXz8zCfnBOUwn5Xqj8wj528w0/wSO4OIBL
	8oFI6bHu3sS6lQskxzmP4Jrci2ruNmWn4w8E3BtwtU8QZnd4FmqMq1pc/u0poeqteZiPdf
	ccMb823OcT3mG56DWb0D1b/V5CbXEWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ALSKBDhjMdeywrPshb4HGg-1; Tue, 09 Jul 2024 07:19:33 -0400
X-MC-Unique: ALSKBDhjMdeywrPshb4HGg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42674318a4eso5406535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523971; x=1721128771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9cY1BbeC8V5UfvyXbcs6HntSp+BaCe1he0FDoMTU60=;
        b=hniY33kAVlzX8O6PnIs46a+gtcoH4CvwVba2HJrIMlZeYWs5eRRml4A7kDE6oz1w2A
         YwCUtZgH4J+j0nZRnSfbH5v2sa1RmjS+Pyq3Fb8xcx+uswJ+aHA1CueL9zA+U32lwouo
         oRJklEnVQb0/MvWIDxKLKu4+0o3XgSb7azfTgxE7qw/7whVuhfI+jD0HMttsq7VFvsQG
         Y1Boz8V75l1U5+raEUxUBkjmTapkvK1lw7ZEsD6Bgl158LXqYX1xrt6gvp/DJYgQl2Oi
         kx4tQn5bGvg7JLfyjRt7tyztb2fwPrlSnvNebDkgTnvfwfW8XvrowGMInP6pnPBjKhf4
         VJSw==
X-Gm-Message-State: AOJu0YxefkxrISzGh807Jbz0XzKYGNAlwe851CsamBd9DeOjY0eAbuxk
	4wlOM/9Fcj/OuiaODJ+oAf+dKv5HE3mPtlr93aeQWGYQa+Rzz3UZ7WkXp5TEniLaJjxUwZyY5yx
	gm+4LGyVQ8ozLc3lhZy0XiJrV0aT+AixwBemTas5S3xlA47P/eoNYpImsaRy5nOl9L207OrlUqd
	osvp0gEeBQYJ2JdkjUP2/2wa/nkzZdqSFSFrotiSZUY98=
X-Received: by 2002:a05:600c:4aa9:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-426707cea49mr20583105e9.10.1720523970729;
        Tue, 09 Jul 2024 04:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrv6eA6i9gD88/LrJNrSNZthLrsY3bNl7E4tsBwJPh0TpR+xUYGQAK1zetmlYXCP/zrmOVNQ==
X-Received: by 2002:a05:600c:4aa9:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-426707cea49mr20582835e9.10.1720523970311;
        Tue, 09 Jul 2024 04:19:30 -0700 (PDT)
Received: from localhost (p200300cfd74b1c2b6d9a10b1cecd2745.dip0.t-ipconnect.de. [2003:cf:d74b:1c2b:6d9a:10b1:cecd:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab106sm2254684f8f.103.2024.07.09.04.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:19:27 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Hanna Czenczek <hreitz@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 1/2] virtio-fs: Add 'file' mount option
Date: Tue,  9 Jul 2024 13:19:17 +0200
Message-ID: <20240709111918.31233-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new option allows mounting filesystems whose root node is a regular
file instead of a directory.

FUSE itself has the more generic 'rootmode' option, which theoretically
allows mounting filesystems with an even greater variety of root node
modes.  There are two reasons why we do not let virtio-fs provide that
same option:

First, with FUSE, this option is supposed to be set automatically by
e.g. the fusermount helper program to match the root node's mode, no
user involvement necessary.  It is easy for fusermount to stat() the
mount point (whose mode must match the filesystem's root node mode) and
fill the 'rootmode' option appropriately.  In the case of virtio-fs,
however, mounting is often done manually by the user, there is no helper
program; and I as a user find the simple '-o file' preferable over the
more cryptic '-o rootmode=0100000'.

Second, inode modes other than S_IFDIR and S_IFREG have limited use with
virtio-fs anyway:
- Device files are host-specific, so passing them via virtio-fs from
  host to guest (or between different guests) seems rarely useful,
- FIFOs and Unix domain sockets currently do not allow communication
  between guest and host (or between different guests), which is really
  the only reason why they would be used as virtio-fs filesystem root
  nodes,
- and symlinks in general do not make much sense as filesystem root
  nodes.

The more generic 'rootmode' option is therefore not very useful for
virtio-fs, while being harder to use.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 fs/fuse/virtio_fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1a52a51b6b07..ba1a6ac31000 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -107,11 +107,13 @@ static const struct constant_table dax_param_enums[] = {
 enum {
 	OPT_DAX,
 	OPT_DAX_ENUM,
+	OPT_FILE,
 };
 
 static const struct fs_parameter_spec virtio_fs_parameters[] = {
 	fsparam_flag("dax", OPT_DAX),
 	fsparam_enum("dax", OPT_DAX_ENUM, dax_param_enums),
+	fsparam_flag("file", OPT_FILE),
 	{}
 };
 
@@ -133,6 +135,10 @@ static int virtio_fs_parse_param(struct fs_context *fsc,
 	case OPT_DAX_ENUM:
 		ctx->dax_mode = result.uint_32;
 		break;
+	case OPT_FILE:
+		ctx->rootmode = S_IFREG;
+		ctx->rootmode_present = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1401,7 +1407,8 @@ static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 
 static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
 {
-	ctx->rootmode = S_IFDIR;
+	if (!ctx->rootmode_present)
+		ctx->rootmode = S_IFDIR;
 	ctx->default_permissions = 1;
 	ctx->allow_other = 1;
 	ctx->max_read = UINT_MAX;
-- 
2.45.1


