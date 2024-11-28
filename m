Return-Path: <linux-kernel+bounces-424817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6215C9DB9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289392822A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8AD1B0F3C;
	Thu, 28 Nov 2024 14:43:18 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48814A08E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804998; cv=none; b=pwyKRAasvr3OSXhevzAzaWpIlRbd7lg9oFiVuI1s6zonbrh7Rn4z7JDMfATpYRy76hcRzXLXIJhmhQ6mhJu02gKde0ZfP0XV9auDJe28D/o/YrzaEqWZpgpnBgFr3a0Iwv6LkmRE3y1yUup0K7GfTgJ0wd+4aNBMGONnJ6q1vvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804998; c=relaxed/simple;
	bh=eCZ7qD7tdOx4S5QX6C7tQxdsEvqFdbL4aIiWTCu0KTo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o83ABTM2eWNS/BmaW2qI/8G9BseL29aO4rpmbY3fszw2axBpxprzBr5Mia2P/U8G4+/C338kIm7KRaH6IQwKp/Gu0U/Ny8Mvy4pmzfQIk93y1iACpZU9MqFtweACNBBMIvcGLk6FPy6y4qExXRuWMRdpKZLHsYD1Fe5qZGsfEv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-841a4a82311so67795439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732804996; x=1733409796;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWsbEcKPr4HQtgLt6+gDXQK6Dga6p0X52a/k0+QpvOs=;
        b=Sq5ywEWlrFTPM9+xbBgapcI6v+jsfwToVyCIfCgQMMKhb8CTpJJYqIazuwMIPdQSy/
         zY8JRVhwlwVYbLdxHetPaK6FtDBT4i8h3Ymoy/d1A/lUYLpKiIBcztXYr+9wNTh3Rtkz
         aJ7YZgvFQ1Z6l8AZ0cvUnYQqyHUyzcPyd1gaYa+5bvGuVctWxLKzPN3RjmJCALXlj/8r
         FZ1SgAFzWXyFGr6iTrbo/Mfok9tqF7hVdD6OpjpGxFGqYLYI/dz5mzzdZNvMjKiZV7UK
         W3PCuWyli1nXs1V2hfFpLdqJ710ltbUdfs3y1isPC5Tn0NNIh3b5QBvzQLwoGhBtmOqS
         TShA==
X-Gm-Message-State: AOJu0Yzd6ImKpzvuw7mgz10Rsnn2o0DjbzoYmt1/Cyb5TNE4AlhRgPE/
	XYVbroGmvtmngWWV8EPnhd466PjaAVoiS/A+3208bSR9Eam73vqXDGSj9KiVxlBKMV2+Ump0Z7k
	DfKP6Z36H0HsL1/HWAj1WZbgz+5rqc+n/MVd8cOKSJWlNzBg1OjC/Izy9aA==
X-Google-Smtp-Source: AGHT+IGhc4JjKNn82XgRvePMk+0KTOcBHYYFG82dmLJRQ9i/O++Jk/xLRS3VAwJBwtqyfRW1AmrMq8an5OBiMN6oFTUin6GvJvYZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ca:b0:3a7:a738:d9c8 with SMTP id
 e9e14a558f8ab-3a7c552308emr79946495ab.2.1732804996226; Thu, 28 Nov 2024
 06:43:16 -0800 (PST)
Date: Thu, 28 Nov 2024 06:43:16 -0800
In-Reply-To: <674773cd.050a0220.21d33d.0027.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67488184.050a0220.253251.0087.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in gfs2_quota_init()
From: syzbot <syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in gfs2_quota_init()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b86545e02e8c22fb89218f29d381fa8e8b91d815

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index dbf1aede744c..85736135bcf5 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -299,6 +299,10 @@ static int gfs2_dir_read_data(struct gfs2_inode *ip, __be64 *buf,
 				goto fail;
 			BUG_ON(extlen < 1);
 			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
+			if (IS_ERR(bh)) {
+				error = PTR_ERR(bh);
+				goto fail;
+			}
 		} else {
 			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, 0, &bh);
 			if (error)
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index fea3efcc2f93..789294f4bf6f 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -512,7 +512,7 @@ int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
  * @dblock: the starting disk block
  * @extlen: the number of blocks in the extent
  *
- * returns: the first buffer in the extent
+ * returns: the first buffer in the extent or error number
  */
 
 struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
@@ -521,6 +521,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 	struct buffer_head *first_bh, *bh;
 	u32 max_ra = gfs2_tune_get(sdp, gt_max_readahead) >>
 			  sdp->sd_sb.sb_bsize_shift;
+	int ret;
 
 	BUG_ON(!extlen);
 
@@ -530,10 +531,15 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 		extlen = max_ra;
 
 	first_bh = gfs2_getbuf(gl, dblock, CREATE);
+	if (unlikely(!first_bh))
+		return ERR_PTR(-EINVAL);
 
 	if (buffer_uptodate(first_bh))
 		goto out;
-	bh_read_nowait(first_bh, REQ_META | REQ_PRIO);
+
+	ret = bh_read(first_bh, REQ_META | REQ_PRIO);
+	if (unlikely(ret < 0))
+		return ERR_PTR(ret);
 
 	dblock++;
 	extlen--;
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 72b48f6f5561..d919edfb8dda 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1427,8 +1427,10 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 		}
 		error = -EIO;
 		bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
-		if (!bh)
+		if (IS_ERR(bh)) {
+			error = PTR_ERR(bh);
 			goto fail;
+		}
 		if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
 			goto fail_brelse;
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index f4fe7039f725..527353c36aa5 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -49,7 +49,7 @@ int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
 
 	*bh = gfs2_meta_ra(gl, dblock, extlen);
 
-	return error;
+	return IS_ERR(*bh) ? PTR_ERR(*bh) : 0;
 }
 
 int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)

