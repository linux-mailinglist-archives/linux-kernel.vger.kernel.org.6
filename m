Return-Path: <linux-kernel+bounces-447182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E59F2E88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBC47A1909
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F89203D63;
	Mon, 16 Dec 2024 10:52:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC76A41
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346343; cv=none; b=MLoR2K8MmKKQ8fILBeFdPa2NafLfkswUJIYee8oPghP/Xy+CMUOpBLDoF+TzINP89CW92Qrki8T5/eDadVhlnMggkRDGBrSfgSQdGdtP9Fx1yULARDUi/ngjv3Zcs+2UA1XbNd7mBtAuPOgLH+J2mt12DtKpcOzprINUbjGb7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346343; c=relaxed/simple;
	bh=BkMPXCioWzGpk2sN21LnuHPHtdfF5FcFZ+MB4Afto5k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aFq5VSiY4elShky/nx+aFWAG3CyoIaBJa1/aeCUtbk7IXfb0trQ1+1O28wzGEBc3qKk/TEOl7WA3eybfvYPZx0bZsYO+cbiOCkgbs10RdmomrpG4/BqCmvzpaFXj/MnavqROjte61jXgqWufvr3OqD0uw13w9Qym78EoILBN77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a817be161bso36796735ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734346341; x=1734951141;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvtS+ZKe3mfPqTmP13z3ksFp2Zv9YNlEtjnurcVWiRc=;
        b=YqyFxYPIX/eH2Q6FvP0aX5lHhJ0RnIk4mmxZWGC009MhoBy3b33YwUyjG61OAtNp2g
         EmFdoKPk3yoUZJQh+cjrtyTTMyx/sUvvVaebZM5DwMaGYDYMyYea6ZJ/+/ihMYc0XFj5
         3xcYFxu+JZ+P1SAgdnozc43RY+Skrxb6r3VArShupZ5Dp4UOx88kzXX8QFqyc42ltRYS
         oEK0laYpXn8IUy8B3KOjrDDZHkzYo1iRkBV9ykPLhSaVfDx52/ErVwX78MQzhXdJTcSy
         faubqRB9TNfYSwtGhdDP1ARHHizdNk6h2mzv7tDwoWrQtSzoNp3aSvFNgg0NMFX1hKyv
         ONXQ==
X-Gm-Message-State: AOJu0Yyo/Wi+YAxVQvcgGxMjdMI7tpdDbZgb5mYatB7ZAvtkjB5A2gC9
	Ipr5ogQ95Jg/dnnthDOnuBrswEefNOnlC2n52RqWnG22EBoXMwKtXuNcVg/tzz9DUL1LJ0n2SOm
	E3gXxnZ2/lwcpImJ4FACY0XLnoR532Ysb8gMwuaHnDxemi9DFCP5+gTE=
X-Google-Smtp-Source: AGHT+IH9PO/yLLNk/BxycbpyM3lLlMQf3FEcvyJ8/Hia98QqqVooLojKtXyR6de8l0sT0RB7IDKZnMltEws2hVLYebRMkkXVO1zK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cbc8:0:b0:3a7:7bab:33f8 with SMTP id
 e9e14a558f8ab-3ae660ac4d6mr99944885ab.12.1734346341382; Mon, 16 Dec 2024
 02:52:21 -0800 (PST)
Date: Mon, 16 Dec 2024 02:52:21 -0800
In-Reply-To: <675e5ede.050a0220.37aaf.00ed.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67600665.050a0220.37aaf.012c.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in ocfs2_commit_truncate()
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in ocfs2_commit_truncate()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next e25c8d66f6786300b680866c0e0139981273feba

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index cd3173062ae3..551cb8fb377a 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1052,7 +1052,8 @@ static void ocfs2_delete_inode(struct inode *inode)
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 	/* Skip inode deletion and wait for dio orphan entry recovered
 	 * first */
-	if (unlikely(di->i_flags & cpu_to_le32(OCFS2_DIO_ORPHANED_FL))) {
+	if (unlikely(di->i_flags & (cpu_to_le32(OCFS2_DIO_ORPHANED_FL) |
+				    cpu_to_le32(OCFS2_ORPHANED_FL)))) {
 		ocfs2_cleanup_delete_inode(inode, 0);
 		goto bail_unlock_inode;
 	}

