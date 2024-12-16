Return-Path: <linux-kernel+bounces-447741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 654249F3690
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8567A127A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD920765F;
	Mon, 16 Dec 2024 16:44:02 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECA205510
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367441; cv=none; b=aWNoWJU+g3hxYENnfE1tpy4onq204KbrVZqwrptkqsM3u9+Tnrt2GYOayH3xWr85DofhIVOAcO3E7y+VG2G81KAoz5v80tB8OLHDXS7LdAYL1F6a7DsdhUrgo3mbQXQ4Fxf9AlX4/AUe1s71HgyiPVPg35FESwY6C1nfC3mRUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367441; c=relaxed/simple;
	bh=RHp0F6UjZX/TfyObz0ZlAnyTx5Pc0w+Qol+a8/W3hFU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eYpZykd+HXxMthvV2/e5dxYkmn/lQXiKfZMlMeCp9kO6FugMiwvJu0CaV9e6YTgrSjXFJEzEIUPgD6hFzSsYaPiU2+NiSczEfd4BoKLVws731ynZz8S7oCApHDZFubEqyY5Z4dPewycaZtK/RxEQ0j9c5dLUaOgj8iTrBH0HUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so52976195ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367439; x=1734972239;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95swBBkO+qxzNMnZEb/hKv1Q6QW2q7J/I3mxU7TPd78=;
        b=AAyn1M6d78y75BQMzpR5NoH7XtccD89CNI/7MjxbDAqCu16So5S0ltq7OhvzWTiFLh
         oUoVv7KottdCKT7W2xmwrHFpie0bIdXqoc850XPUp1hfvOBU4bCDEC0GRLPYXmS/NQkG
         +33znDu2X7R12olfUCqBC/WujsI3TyfSj3tMV0aOij7L2pG3y5hC3dchBDFcA3Xa2StQ
         G0guyE8BlaUaKwahtWs9gxlSfKw6EYYHY7nlN7TWslMmNg8S/ktJDEqbxWvB71ZhsUKi
         3BcelqJM/D327aagdvztXTd2TFJ7H9+f6eo6WkZT81a0se/hPek+Jl4YEZvvdLPInEuz
         9XKA==
X-Gm-Message-State: AOJu0Yx7bld5Q1o9FsDADKwiIexN7j0fHh0fPUagv1wQdMJT63iggSvl
	gzBeEYyd1mnG+UoQ6uf5bu3SHY00YNizThXcPQnhznLPG9JT1c2f6sLU0e7SsfezOLhMMJB5KMy
	56/sIU0ouuoyNwIauDJbSngGgcuxol0ks4WEDKrv0WWLV9sAMbS0vRRU=
X-Google-Smtp-Source: AGHT+IHNFGgpY1KfnBTnebtefSVMKS4eQPvDqp82XM35emy9jw+GRszeSha28lkFSWhoTN/teFRCe9sO7PTTCoj/cSXGWEiTnR8S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3a7:e8df:3fcb with SMTP id
 e9e14a558f8ab-3b02d788a63mr95459545ab.7.1734367439300; Mon, 16 Dec 2024
 08:43:59 -0800 (PST)
Date: Mon, 16 Dec 2024 08:43:59 -0800
In-Reply-To: <675e5ede.050a0220.37aaf.00ed.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676058cf.050a0220.37aaf.0138.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in ocfs2_commit_truncate()
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in ocfs2_commit_truncate()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 395e23920632..deb038e9392a 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7219,12 +7219,19 @@ int ocfs2_commit_truncate(struct ocfs2_super *osb,
 	struct ocfs2_extent_rec *rec;
 	struct ocfs2_path *path = NULL;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
+	u16 tree_depth = le16_to_cpu(di->id2.i_list.l_tree_depth);
 	struct ocfs2_extent_list *root_el = &(di->id2.i_list);
 	u64 refcount_loc = le64_to_cpu(di->i_refcount_loc);
 	struct ocfs2_extent_tree et;
 	struct ocfs2_cached_dealloc_ctxt dealloc;
 	struct ocfs2_refcount_tree *ref_tree = NULL;
 
+	if (unlikely(tree_depth >= OCFS2_MAX_PATH_DEPTH)) {
+		mlog(ML_ERROR, "Corrupted dinode %llu\n",
+		     (unsigned long long)di_bh->b_blocknr);
+		return -EINVAL;
+	}
+
 	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(inode), di_bh);
 	ocfs2_init_dealloc_ctxt(&dealloc);
 

