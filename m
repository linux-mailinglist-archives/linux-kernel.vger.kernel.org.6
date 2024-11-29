Return-Path: <linux-kernel+bounces-425330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D59DC0A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD1AB22706
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778B166F34;
	Fri, 29 Nov 2024 08:41:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12322165F1F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869687; cv=none; b=S9l1V39pniFQQ+8qxsZ1vpybWlSw6mdUWyzGe3oV1S5OimItlk0m/v8lP71JRbQvkYH1D8TVen32Tdnb4pW1gh6eEiCj+ZQU5W75+zqpweJgg0R5/QcdythDekShO9knQI1RxoR7WDjKZUjVC75WcQJ2GFCb4/2l7tyySEKm1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869687; c=relaxed/simple;
	bh=SNdU0PEn+cuYgXF44Co+Rge1DK841us3OBlD4TvT318=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CEqDTmydyKIinu9IOQmlQ9BxsOoepZxlr70hguGZTppU8e2t/xASuSbV4dAbhFwgZJaW0ASRxZ1J/Ktv6H9JM+erqEFlbBSzNdgE8ATlsD2OdcmxU6WWTDpKWLj9499TSerzWcXWQOWqfyQQiL3Ybza0YPE4Wevas57bv2ktR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841ac3f9391so139176339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732869685; x=1733474485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9+YNKS/fHWT9ol9oL2UFpxQXZ6Ne6p8vFn7/Foknxw=;
        b=LYM2c0/sh726GDCVSZUfL8+n1m15wK+xtw5r+te5fqKuxBv5Nnvj/+QRZiLAsxdLZr
         xPWzp9r735vKiZCQ0GKfCrRdeEaLZgbn1tbYmxppEJO69ogf1F8OfXMvnDE0udZWrBBC
         xu4y67Tg3UdgR2cKO7Z+zpqc9OiDXYNtYjamrC8ac1+IR2vaoDy0Wcweey2FmICOsZIn
         lJTL2fbZ5t0QcYdhDfxjIGW6s5u8xYlqIgrHJHioyLyn7mpNJTHzzDhXgGVejZMkUeQs
         mAbkEQ4mIZWe5USxaMbNoRcEqwF4uMBHl69SQ11R7Bo6JAfz3hBIkKojIdg0T4xZW8nT
         zmGQ==
X-Gm-Message-State: AOJu0Yz1214Zd085kzLqxHZWtsy63SI/jcnLro+jrPg2oZFc+3aWOWwY
	TizF6O05fdO7indg2uiih3yBcf+CrDnE5Wz6/ZOauYfZlrz/mPGjZZUOe01PwWnVvR8V4h1Bjxr
	Tnqay8Ii1yjQbOtjbfSnQrHKfoFzbUByfLgAYL+2Am924vp0cqOYY9Hw=
X-Google-Smtp-Source: AGHT+IFZsw49BIXLKk9Mgiyl3hH6vs28SPLtwIsb3vPZYfofueOXzmZt1JIv4hGPhPGZcELgNEFwM0iKtqrEjw+iUbuSwnBU3W2L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13af:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3a7c555eca0mr110749945ab.10.1732869685146; Fri, 29 Nov 2024
 00:41:25 -0800 (PST)
Date: Fri, 29 Nov 2024 00:41:25 -0800
In-Reply-To: <674773cd.050a0220.21d33d.0027.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67497e35.050a0220.253251.00a6.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in gfs2_quota_init()
From: syzbot <syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in gfs2_quota_init()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7af08b57bcb9ebf78675c50069c54125c0a8b795

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
index fea3efcc2f93..18957afed91a 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -532,7 +532,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 	first_bh = gfs2_getbuf(gl, dblock, CREATE);
 
 	if (buffer_uptodate(first_bh))
-		goto out;
+		return first_bh;
 	bh_read_nowait(first_bh, REQ_META | REQ_PRIO);
 
 	dblock++;
@@ -546,11 +546,10 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 		dblock++;
 		extlen--;
 		if (!buffer_locked(first_bh) && buffer_uptodate(first_bh))
-			goto out;
+			return first_bh;
 	}
 
 	wait_on_buffer(first_bh);
-out:
-	return first_bh;
+	return buffer_uptodate(first_bh) ? first_bh : ERR_PTR(-EIO);
 }
 
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

