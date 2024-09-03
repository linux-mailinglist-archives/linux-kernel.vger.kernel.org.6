Return-Path: <linux-kernel+bounces-313213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E8096A1F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069551F26E0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3AB186E3A;
	Tue,  3 Sep 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E8lnVqpi"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125B13E41A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376607; cv=none; b=ro0U3nXqlFqrrMNZXdmjQoKIZod819hBuBAi2dhzMMQsajMpo2ZJjDNeW9EuxGFSKUx3PjwBcLVPWpCIEfb+ExnVL7sroB2Xv9kBNv/w4EdejZ5FGT84Su/oG1y0A4DJtIhq+R/LNrax5xgzcmlOwtR2hiYZok5llNNGJ2haerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376607; c=relaxed/simple;
	bh=UlpGC9zVwuoHnxSR8q1ybWfU6/jvFzxK9E2P8BAoIT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FoSZ0RX9lJlCCrWaO8w2trtTldabMqswo8G3/zIJmVluuLMj/WZqXk/TwII7koPGZXA/ZEp9bT0PgCiHk5oDOdvo5UUnUI5szk23bIArzTAmWaP25bP3bY+62qrmfLYVfXoBjNnpKBunKssvOLZMe3vwM/YgBCJotT0yKWKe1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E8lnVqpi; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4BCE53FE1B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376602;
	bh=nptWKDBJUxg4A7YgqhOZ9Q+wwJnHV+u8b7QNvbLZJgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=E8lnVqpipYm7UC/0ElM5a5muf8cTq6XZYEBbjAY3IrHghlxF5NSlKJvslZvxM96MV
	 gcdTKdIOrKl0a7RVHfVtgtCfe52gKyYpuQd8LQ3iUYjwfGO4ZDfTWZBjEfBX+hntN8
	 05i29NaxsU9ueX0MWh4mRxrbY0IAEcJIDStlvzwkB4Uv9ozDSLs1uECU/OWO1xD0fe
	 bMuLFPQMEsiND6Kjk++Dm0GGojqJ6AnQ9guQiNkYJ2judJil8Q1DOBernwQwRKUrag
	 RpxGxDTow4eWOn3HSIIRffwO6FUloGoULOpQGqtzaTDVptf6pIp/zk8OkeJaX0Xv49
	 2X9Dnx3bcKJOQ==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53349c739d0so1051543e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376601; x=1725981401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nptWKDBJUxg4A7YgqhOZ9Q+wwJnHV+u8b7QNvbLZJgw=;
        b=woU9sGarbl2Und/oj8S6j3AUk9FWpVr2ny3JvUGTvsJkp8V3q/Ww9H0LN9j3Td+3JR
         71RpwLHgoJJOhPW0vmkZirCL9VRfcJw82ofCdvXTJeeVLFNNfRbp8uXKQ+lhykpAfcyh
         h8b2rkVE/+YLnKQImliXyTkygJiI3pi9MuLrwN7asW9gVaQExQXp7Q17oUGmz6n4pwGL
         LQDxgilPBYB5wo9OIDHaXbB0vZSsFEHg9G8oQCbhB2/2q573kU2FehmDBmoluzWxMVLn
         eGdKWXScalph/xWIrkrm9Dq42wP4brHBhYVJpV+VXB3ZZRZWL5UHB7oQJWKmVFcWDyfK
         gZfw==
X-Forwarded-Encrypted: i=1; AJvYcCURE6gEqtiQcJZm+5EX61esHApKTW2b+QWB9hztj91OPP2jdqBlGYgE395ik7oNQWWuEvVxCOkmrMGkM8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzYxNDIB5TaXkc6fcFsyqBdCa2f+0iJeOpJkWBEx3a5YKfHZs
	1mPPx27J8C6OUXs+t89Ye+HeBB3XUIhEBYdLE2EtuVdK6zwzihCikfUpeo6ljw3zaB+nyMnP0al
	jsJQCNOAGSoKTBKmiNGYJOlcshrAe9tTm5KP9wlCVVMZBb7cT7FwQ6mrLJ/DfxhrlHQXOUkltPj
	X5dA==
X-Received: by 2002:a05:6512:238b:b0:533:4668:8b86 with SMTP id 2adb3069b0e04-53546b69204mr10048097e87.41.1725376601250;
        Tue, 03 Sep 2024 08:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErx5r9OfXJe2paALnE06F+/BE9qyLVvSQQb0WsDu9BtQ+UGoNq8rRFc4NriT8PguTFoLyxlA==
X-Received: by 2002:a05:6512:238b:b0:533:4668:8b86 with SMTP id 2adb3069b0e04-53546b69204mr10048070e87.41.1725376600594;
        Tue, 03 Sep 2024 08:16:40 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:16:40 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/15] fuse: basic support for idmapped mounts
Date: Tue,  3 Sep 2024 17:16:11 +0200
Message-Id: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear friends,

This patch series aimed to provide support for idmapped mounts
for fuse & virtiofs. We already have idmapped mounts support for almost all
widely-used filesystems:
* local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
* network (ceph)

Git tree (based on torvalds/master):
v4: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v4
current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts

Changelog for version 4:
- heavily reworked to comply with Miklos's suggestion to start sending idmapped uid/gid
  just in fuse header instead of adding a new FUSE_OWNER_UID_GID_EXT extension (please, refer to [6], [7])
- added ("fs/fuse: handle idmappings properly in ->write_iter")
- added ("fs/fuse: warn if fuse_access is called when idmapped mounts are allowed")
- added handling for idmapped mounts in FUSE_EXT_GROUPS extension
- now RENAME_WHITEOUT can be (and is) supported

Changelog for version 3:
- introduce and use a new SB_I_NOIDMAP flag (suggested by Christian)
- add support for virtiofs (+user space virtiofsd conversion)

Changelog for version 2:
- removed "fs/namespace: introduce fs_type->allow_idmap hook" and simplified logic
to return -EIO if a fuse daemon does not support idmapped mounts (suggested
by Christian Brauner)
- passed an "idmap" in more cases even when it's not necessary to simplify things (suggested
by Christian Brauner)
- take ->rename() RENAME_WHITEOUT into account and forbid it for idmapped mount case

Links to previous versions:
v3: https://lore.kernel.org/all/20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v3
v2: https://lore.kernel.org/linux-fsdevel/20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v2
v1: https://lore.kernel.org/all/20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com/#r
tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v1

Having fuse (+virtiofs) supported looks like a good next step. At the same time
fuse conceptually close to the network filesystems and supporting it is
a quite challenging task.

Let me briefly explain what was done in this series and which obstacles we have.

With this series, you can use idmapped mounts with fuse if the following
conditions are met:
1. The filesystem daemon declares idmap support (new FUSE_INIT response feature
flag FUSE_ALLOW_IDMAP)
2. The filesystem superblock was mounted with the "default_permissions" parameter
3. The filesystem fuse daemon does not perform any UID/GID-based checks internally
and fully trusts the kernel to do that (yes, it's almost the same as 2.)

I have prepared a bunch of real-world examples of the user space modifications
that can be done to use this extension:
- libfuse support
https://github.com/mihalicyn/libfuse/commits/idmap_support
- fuse-overlayfs support:
https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support
- cephfs-fuse conversion example
https://github.com/mihalicyn/ceph/commits/fuse_idmap
- glusterfs conversion example (there is a conceptual issue)
https://github.com/mihalicyn/glusterfs/commits/fuse_idmap
- virtiofsd conversion example
https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245

The glusterfs is a bit problematic, unfortunately, because even if the glusterfs
superblock was mounted with the "default_permissions" parameter (1 and 2 conditions
are satisfied), it fails to satisfy the 3rd condition. The glusterfs fuse daemon sends
caller UIDs/GIDs over the wire and all the permission checks are done twice (first
on the client side (in the fuse kernel module) and second on the glusterfs server side).
Just for demonstration's sake, I found a hacky (but working) solution for glusterfs
that disables these server-side permission checks (see [1]). This allows you to play
with the filesystem and idmapped mounts and it works just fine.

The problem described above is the main problem that we can meet when
working on idmapped mounts support for network-based filesystems (or network-like filesystems
like fuse). When people look at the idmapped mounts feature at first they tend to think
that idmaps are for faking caller UIDs/GIDs, but that's not the case. There was a big
discussion about this in the "ceph: support idmapped mounts" patch series [2], [3].
The brief outcome from this discussion is that we don't want and don't have to fool
filesystem code and map a caller's UID/GID everywhere, but only in VFS i_op's
which are provided with a "struct mnt_idmap *idmap"). For example ->lookup()
callback is not provided with it and that's on purpose! We don't expect the low-level
filesystem code to do any permissions checks inside this callback because everything
was already checked on the higher level (see may_lookup() helper). For local filesystems
this assumption works like a charm, but for network-based, unfortunately, not.
For example, the cephfs kernel client *always* send called UID/GID with *any* request
(->lookup included!) and then *may* (depending on the MDS configuration) perform any
permissions checks on the server side based on these values, which obviously leads
to issues/inconsistencies if VFS idmaps are involved.

Fuse filesystem very-very close to cephfs example, because we have req->in.h.uid/req->in.h.gid
and these values are present in all fuse requests and userspace may use them as it wants.

All of the above explains why we have a "default_permissions" requirement. If filesystem
does not use it, then permission checks will be widespread across all the i_op's like
->lookup, ->unlink, ->readlink instead of being consolidated in the one place (->permission callback).

How to play with it:
1. take any patched filesystem from the list (fuse-overlayfs, cephfs-fuse, glusterfs) and mount it
2. ./mount-idmapped --map-mount b:1000:0:2 /mnt/my_fuse_mount /mnt/my_fuse_mount_idmapped
(maps UID/GIDs as 1000 -> 0, 1001 -> 1)
[ taken from https://raw.githubusercontent.com/brauner/mount-idmapped/master/mount-idmapped.c ]

[1] https://github.com/mihalicyn/glusterfs/commit/ab3ec2c7cbe22618cba9cc94a52a492b1904d0b2
[2] https://lore.kernel.org/lkml/20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com/
[3] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
[4] https://github.com/ceph/ceph/pull/52575
[5] https://lore.kernel.org/all/20230807132626.182101-4-aleksandr.mikhalitsyn@canonical.com/
[6] https://lore.kernel.org/all/CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com/
[7] https://lore.kernel.org/all/CAJfpegtHQsEUuFq1k4ZbTD3E1h-GsrN3PWyv7X8cg6sfU_W2Yw@mail.gmail.com/


Thanks!
Alex

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Alexander Mikhalitsyn (15):
  fs/namespace: introduce SB_I_NOIDMAP flag
  fs/fuse: add basic infrastructure to support idmappings
  fs/fuse: add an idmap argument to fuse_simple_request
  fs/fuse: support idmapped FUSE_EXT_GROUPS
  fs/fuse: support idmap for mkdir/mknod/symlink/create/tmpfile
  fs/fuse: support idmapped getattr inode op
  fs/fuse: support idmapped ->permission inode op
  fs/fuse: support idmapped ->setattr op
  fs/fuse: drop idmap argument from __fuse_get_acl
  fs/fuse: support idmapped ->set_acl
  fs/fuse: support idmapped ->rename op
  fs/fuse: handle idmappings properly in ->write_iter
  fs/fuse: warn if fuse_access is called when idmapped mounts are
    allowed
  fs/fuse: allow idmapped mounts
  fs/fuse/virtio_fs: allow idmapped mounts

 fs/fuse/acl.c             |  10 +--
 fs/fuse/dax.c             |   4 +-
 fs/fuse/dev.c             |  54 +++++++++---
 fs/fuse/dir.c             | 169 ++++++++++++++++++++++----------------
 fs/fuse/file.c            |  37 +++++----
 fs/fuse/fuse_i.h          |   7 +-
 fs/fuse/inode.c           |  19 +++--
 fs/fuse/ioctl.c           |   2 +-
 fs/fuse/readdir.c         |   4 +-
 fs/fuse/virtio_fs.c       |   1 +
 fs/fuse/xattr.c           |   8 +-
 fs/namespace.c            |   4 +
 include/linux/fs.h        |   1 +
 include/uapi/linux/fuse.h |  22 ++++-
 14 files changed, 216 insertions(+), 126 deletions(-)

-- 
2.34.1


