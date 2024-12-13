Return-Path: <linux-kernel+bounces-444400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC489F062C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2AB285487
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE72A192D9D;
	Fri, 13 Dec 2024 08:17:16 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1987DA8C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077836; cv=none; b=G/sNiRgGkCQ1MIzI0yq+HwudR1SL+1YjCSjUejUkL+58L1npxW8IvgCbRi97HTjKcfRz5QlmIkPb9yhYxGa4u6NOHQbMUbi8XpqhgRsEwRGyvNFSFH72w0+nR9ICCC9eFEQWjxR2mCG7eFywZEqyP7YmRk9nwm/Kk2gfNPMyshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077836; c=relaxed/simple;
	bh=EAcphqu+2hN5IwBjI29BS1qb7a7RnbLQ8JKXwbaGLiw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bsrJZZZ1ZjQwtuPH/fSt6Ptpk5jJ/eecdNRvdJLwwUCHFct4vyPH38rqyioA34l30g8ZqG74sdroFEAS4IPTmuULM7Y4ma1Ir8mjy43G0+bx6D++YzE81rPG7IJ2qAx8Jq0cDJ1FXEaqgVrdv4ny9PpMvpFnJcYQe4H/FndN2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844dac0a906so144418339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077834; x=1734682634;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J15Gq7q+dYou+UJgEXbgzSgJ5VrfU+OS+eAKYU7XP5E=;
        b=niKCrHEimzoCMW3sDcAMYQ5VlUbRgr7G9excOhC18a00/+LacjQLJ1iDxYoI6mZv7e
         12GhiCuPih1ZLsxlppdSKDZ/v1ru2AGjsyfbM8bpyE6Z+8HZ1iRxzaFIi/qf5Dug4ufb
         6/BJWAD+NCh31uuylw4gv08vmOsgSPGX9UHAXlWm7qmhpejyqhawUbA+zCdz2+uaM0Bd
         G1Zznw8k2ST/fNIO+FFbaiJTlS0V8XgZZ3qki/0mG5Z7RSRy9+0AysX87PuKwnKd1dza
         8wJorGWxBgNP/6JwonDnMzf+5maVGNgEyI1fxnN1gc/4XlGzpNk8EgN7GCnv+KZO1+2P
         zazw==
X-Gm-Message-State: AOJu0YybC2uYsYRC58+LPTIOBX6Q4tPq17kgHNwckABI1kXnQROFo4D0
	1imiqyfvJIPknO3xe+m0akPWEOrBawZ5VKxzi525iWHQViLhLrYrpDyvKQBqx8qLdOS+o1B7x3z
	21tVLrWYXMMn24y2gRsB1IKIA3a/cZdZT3Rrr4Ag3MJXeqxroRjMg2ts=
X-Google-Smtp-Source: AGHT+IErTFUMIwk6c7W5sQ5SXn5Z4fzIsD/Py5ZOy9AbAcUDtA2LCNErVHh1iQOkCtvSFTp7xK12G/TJszJ6asJ8pyJ2GxhVlFF5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2408:b0:3a7:c5a6:9822 with SMTP id
 e9e14a558f8ab-3aff8c9255emr20495645ab.24.1734077834008; Fri, 13 Dec 2024
 00:17:14 -0800 (PST)
Date: Fri, 13 Dec 2024 00:17:13 -0800
In-Reply-To: <674f4e43.050a0220.17bd51.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675bed89.050a0220.cd16f.0042.GAE@google.com>
Subject: Re: [syzbot] Re: general protection fault in exfat_get_dentry_cached()
From: syzbot <syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: general protection fault in exfat_get_dentry_cached()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f932fb9b40749d1c9a539d89bb3e288c077aafe5

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 97d2774760fe..c356bde623bf 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -329,10 +329,7 @@ static int exfat_find_empty_entry(struct inode *inode,
 			EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
 
 	while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
-					num_entries, es)) < 0) {
-		if (dentry == -EIO)
-			break;
-
+					num_entries, es)) == -ENOSPC) {
 		if (exfat_check_max_dentries(inode))
 			return -ENOSPC;
 
@@ -395,6 +392,9 @@ static int exfat_find_empty_entry(struct inode *inode,
 		inode->i_blocks += sbi->cluster_size >> 9;
 	}
 
+	if (dentry < 0)
+		return dentry;
+
 	p_dir->dir = exfat_sector_to_cluster(sbi, es->bh[0]->b_blocknr);
 	p_dir->size -= dentry / sbi->dentries_per_clu;
 

