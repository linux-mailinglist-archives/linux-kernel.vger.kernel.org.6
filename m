Return-Path: <linux-kernel+bounces-425926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 369179DECA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E64B21A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9331A257A;
	Fri, 29 Nov 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8G+dguj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DE14831E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732911670; cv=none; b=rQcCC7fL8UNbBMWiiyWTGK/jwOmS2ZlWIIVSG8eXGW+hQBJs7k8/Hr4BSgCDF4UOHKuuM6bUOg2hY7+FERU06nhslNviTgTIl/uJ/KCgATeFR6xAWCP97UXL+wxIE1yCA0no+6VaQ5lVRtQx6wdhjQKDWYCOsZTyMJRqCA7A104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732911670; c=relaxed/simple;
	bh=JZt1xhhD7Qu08qFRhwhStGDrSMhFX3epjExTSkyrU0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NVuA8GfDSoGsommV7wZjLxLdNg3w5fqxnDnzwlm5Wo8/L0LUiUkCgEI4pIeUoOabiBAAJRjQtx/+V2Y9XCEZpEbpy6kahkI3Hk50lYy6B30SHq29NOI3X7uHtSTG0wEwZOxBGwMTOnuiUidaNRggB+zOJV2jX9DCudK+UEXAJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8G+dguj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349c7b6b0dso124645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732911665; x=1733516465; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyrbLAnl0TdHKLL8jWS1SK2mXM/sjKt2Cf5HncFAblg=;
        b=o8G+dgujL+dLtveEhvtOGLKixen53y/c+M952q0XH8I/fXVCZbq3g86OhbJd3Ozp5y
         Ju54zlMXuLz7y4ARP+2rIicdqJRPmOGZAGehsT9moFrxH9IoiVuIbbJ9VPfE66JLqdtI
         AYKERNDYv1oUY+RRNdp/6QNMnQBDQ5EMy44U2snDqW6tbdB9rjs0Y940uuhoCVW6lq20
         z8wS5hMX4QHIpQvspTaCbwQ9w3lJlhvaxNgdi9m20bY5HOOtpkir9nsvy19VFklUg53F
         sT8sYBCQF/Pf0zOo2+GmrcsAiJN3gfre03qj6NgcCshWIeWfgJ30RKTVpGflPUYKx73I
         XDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732911665; x=1733516465;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyrbLAnl0TdHKLL8jWS1SK2mXM/sjKt2Cf5HncFAblg=;
        b=f9aPO1y082nwbhy3QUk6JrYbyOEtpgqBGWMxok0IeeVbWWiMkpVppcJoITejn7558m
         AnfqAExmF1tcSd0e+s2c5ZuLJdoUGuWfjhu6W6K1H5iksNArfP/KWQllP0NLEyOb6kEJ
         wipqR4WYcpxFC/cX8ejQNIoT8y6Z9SVlgRHU83tPHTozdY3ZdzRfhF7wZlgdPB9hqZRH
         pmxvTbTweDM57JXXxjYHXvc7uRtElwDMVSk70g6RL72DcuMzt6RqR//uVh0Vf8p8zLWO
         65sXRuSHq2FqsIIroUg1TUZHkjf05dhzTuFYwpv91Wmd8BJ1XpuVdErpy4adlFUfUJmw
         7VwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiZXnXBT1L9SbgYnoohmyliy9TWQPgzaJnZqj8iKsojrnfe0MHLXmQV6GtY9zJIwvvDPb0QTP36/wXsUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90oUd0Uedtq9Not9TPIBOA2Fkw5AD2geISslcBfW1XSyLAGkK
	MJOTBoAwbsnQVJnNPU7ejrkw7kJ7Edln0ClDXWSiicnQhZWQhCdI0N/aJLDClw==
X-Gm-Gg: ASbGncv3k1MSlZbEExugPhQUjrMmDFTtOmTvILUJnX4ge44pBloFUHQ/31nVkR1cRxL
	/wYWh05LNhjktHy3i8y98xTKlMUVEB0M9wRt/nR7m+PHE4/Nr9kCe/hAbwHy3oj6xzW6GtAk85H
	HLO1QmX2z2PsA+cN37wXqfIqRDMFddvswOofx4w8S4+2Spg5Ls8CaYXFDgFsGKCY+znl97uHfSb
	V/7l7FIZ6q5MPwbP7V8lb39VQN5Zpi0kjM9i3k=
X-Google-Smtp-Source: AGHT+IEt4Q7FJHNdfMoxIBg+If7kcvf5wjR1bP0rwcY43kz3QcFlyr1t1lwAuY3RSkOcX7PuG7ifnA==
X-Received: by 2002:a05:600c:35d3:b0:42c:acd7:b59b with SMTP id 5b1f17b1804b1-434b04fbec5mr2693795e9.6.1732911664994;
        Fri, 29 Nov 2024 12:21:04 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:cff0:98a0:ec45:c778])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e1f3f2desm693911f8f.87.2024.11.29.12.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 12:21:04 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Fri, 29 Nov 2024 21:20:53 +0100
Subject: [PATCH RFC] ext4: don't treat fhandle lookup of ea_inode as FS
 corruption
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-ext4-ignore-ea-fhandle-v1-1-e532c0d1cee0@google.com>
X-B4-Tracking: v=1; b=H4sIACQiSmcC/x2MPQqFMBAGryJbu2B+RLQVPMBrxULMpy5IlOQhg
 nh3g+XAzNwUEQSRmuymgFOi7D6ByjOa1tEvYHGJSRfaKqVrxvW3LIvfAxgjz0lyG7iyxplKm6l
 ETSk+Ama5vnFPv66l4XleBZJ3sW0AAAA=
X-Change-ID: 20241129-ext4-ignore-ea-fhandle-743d3723c5e9
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732911660; l=7593;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=JZt1xhhD7Qu08qFRhwhStGDrSMhFX3epjExTSkyrU0Y=;
 b=PpA2dipV4r0TIcRYNL+ShpxMDKPk6o71CzZJwi93s4nLy1xVelCFEg/qA7vq9gsBzAi+1XmFi
 4tHIasvvB5fDzpK5WlcAVGJAowsX0/kFWGnVsNgLr90PpnN3K5AeK29
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

A file handle that userspace provides to open_by_handle_at() can
legitimately contain an outdated inode number that has since been reused
for another purpose - that's why the file handle also contains a generation
number.

But if the inode number has been reused for an ea_inode, check_igot_inode()
will notice, __ext4_iget() will go through ext4_error_inode(), and if the
inode was newly created, it will also be marked as bad by iget_failed().
This all happens before the point where the inode generation is checked.

ext4_error_inode() is supposed to only be used on filesystem corruption; it
should not be used when userspace just got unlucky with a stale file
handle. So when this happens, let __ext4_iget() just return an error.

Fixes: b3e6bcb94590 ("ext4: add EA_INODE checking to ext4_iget()")
Signed-off-by: Jann Horn <jannh@google.com>
---
I'm sending this as an RFC patch because the patch I came up with is pretty
ugly; I think it would be ideal if someone else comes up with a nicer
patch that can be used instead of this one.
I'm also not sure whether it actually matters if we call iget_failed() when this happens with a new inode.

The following testcase demonstrates this issue, and shows that a filesystem
mounted with errors=remount-ro is remounted to read-only when hitting it.
Run this as root.

```
#define _GNU_SOURCE
#include <err.h>
#include <stdarg.h>
#include <stdio.h>
#include <sched.h>
#include <stddef.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <sys/mount.h>
#include <sys/mman.h>
#include <sys/xattr.h>
#include <sys/stat.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

static int systemf(const char *cmd, ...) {
  char *full_cmd;
  va_list ap;
  va_start(ap, cmd);
  if (vasprintf(&full_cmd, cmd, ap) == -1)
    err(1, "vasprintf");
  int res = system(full_cmd);
  free(full_cmd);
  return res;
}

int main(void) {
  // avoid messing with the main mount hierarchy
  SYSCHK(unshare(CLONE_NEWNS));
  SYSCHK(mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL));

  // create and mount new ext4 fs
  int fs_fd = SYSCHK(memfd_create("ext4-image", 0));
  SYSCHK(ftruncate(fs_fd, 1024*1024));
  if (systemf("mkfs.ext4 -O ea_inode /proc/self/fd/%d", fs_fd))
    errx(1, "mkfs failed");
  if (systemf("mount -o errors=remount-ro -t ext4 /proc/self/fd/%d /mnt", fs_fd))
    errx(1, "mount failed");

  // create file with inode xattr
  char xattr_body[8192];
  memset(xattr_body, 'A', sizeof(xattr_body));
  int file_fd = SYSCHK(open("/mnt/file", O_RDWR|O_CREAT, 0600));
  SYSCHK(fsetxattr(file_fd, "user.foo", xattr_body, sizeof(xattr_body), XATTR_CREATE));
  struct stat st;
  SYSCHK(fstat(file_fd, &st));

  // trigger bug: do fhandle lookup on inode of file plus one (which will be
  // the xattr inode)
  struct handle {
    unsigned int handle_bytes;
    unsigned int handle_type;
    unsigned int ino, gen, parent_ino, parent_gen;
  } handle = {
    .handle_bytes = sizeof(handle) - offsetof(struct handle, ino),
    .handle_type = 1/*FILEID_INO32_GEN*/,
    .ino = st.st_ino+1,
    .gen = 0
  };
  // this should fail
  SYSCHK(open_by_handle_at(file_fd, (void*)&handle, O_RDONLY));
}
```

resulting dmesg:
```
EXT4-fs (loop0): mounted filesystem 13b7e98f-901a-41a4-ba59-4cc58d597798 r/w without journal. Quota mode: none.
EXT4-fs error (device loop0): ext4_nfs_get_inode:1545: inode #13: comm ext4-ea-inode-f: unexpected EA_INODE flag
EXT4-fs (loop0): Remounting filesystem read-only
EXT4-fs (loop0): unmounting filesystem 13b7e98f-901a-41a4-ba59-4cc58d597798.
```
---
 fs/ext4/inode.c | 68 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89aade6f45f62d9fd6300ef84c118c6b919cddc9..8a8cc29b211c875a1d22b943004dc3f10b9c4d79 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4705,22 +4705,43 @@ static inline void ext4_inode_set_iversion_queried(struct inode *inode, u64 val)
 		inode_set_iversion_queried(inode, val);
 }
 
-static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
-
+static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
+			    const char *function, unsigned int line)
 {
+	const char *err_str;
+
 	if (flags & EXT4_IGET_EA_INODE) {
-		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "missing EA_INODE flag";
+		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			err_str = "missing EA_INODE flag";
+			goto error;
+		}
 		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
-		    EXT4_I(inode)->i_file_acl)
-			return "ea_inode with extended attributes";
+		    EXT4_I(inode)->i_file_acl) {
+			err_str = "ea_inode with extended attributes";
+			goto error;
+		}
 	} else {
-		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "unexpected EA_INODE flag";
+		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			/*
+			 * open_by_handle_at() could provide an old inode number
+			 * that has since been reused for an ea_inode; this does
+			 * not indicate filesystem corruption
+			 */
+			if (flags & EXT4_IGET_HANDLE)
+				return -ESTALE;
+			err_str = "unexpected EA_INODE flag";
+			goto error;
+		}
+	}
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
+		err_str = "unexpected bad inode w/o EXT4_IGET_BAD";
+		goto error;
 	}
-	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
-		return "unexpected bad inode w/o EXT4_IGET_BAD";
-	return NULL;
+	return 0;
+
+error:
+	ext4_error_inode(inode, function, line, 0, err_str);
+	return -EFSCORRUPTED;
 }
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
@@ -4732,7 +4753,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode_info *ei;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
-	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4761,10 +4781,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW)) {
-		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-			ext4_error_inode(inode, function, line, 0, err_str);
+		ret = check_igot_inode(inode, flags, function, line);
+		if (ret) {
 			iput(inode);
-			return ERR_PTR(-EFSCORRUPTED);
+			return ERR_PTR(ret);
 		}
 		return inode;
 	}
@@ -5036,13 +5056,21 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
-	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-		ext4_error_inode(inode, function, line, 0, err_str);
-		ret = -EFSCORRUPTED;
-		goto bad_inode;
+	ret = check_igot_inode(inode, flags, function, line);
+	/*
+	 * -ESTALE here means there is nothing inherently wrong with the inode,
+	 * it's just not an inode we can return for an fhandle lookup.
+	 */
+	if (ret == -ESTALE) {
+		brelse(iloc.bh);
+		unlock_new_inode(inode);
+		iput(inode);
+		return ERR_PTR(-ESTALE);
 	}
-
+	if (ret)
+		goto bad_inode;
 	brelse(iloc.bh);
+
 	unlock_new_inode(inode);
 	return inode;
 

---
base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
change-id: 20241129-ext4-ignore-ea-fhandle-743d3723c5e9

-- 
Jann Horn <jannh@google.com>


