Return-Path: <linux-kernel+bounces-393918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0899BA76F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF8BB21BDC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1278016EB5D;
	Sun,  3 Nov 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROAzx0iM"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8154142659
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658834; cv=none; b=KqUXjd3Tn7lsLNhxuM4QeOBnwAZONAUJwjO9IMtLfE61fErDj7vpMxjxF3cQffZL009cd2BpcPaM4Oh8+gopFLEL4T2dg8M9h9U8C0C5M00NxTAdQvOCtlTYGDUqaEL/Q56u+YpoXRkt9KpUhTtHBT4LVSRuTmzu+3UEEt8O0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658834; c=relaxed/simple;
	bh=RiJ1o4Nt4Y8IwIm7M8oK50YgzDBq27gsRGQg/qu08Hw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWEoaJJhT2eKeXYXVIBIUg0inJdU4wDPjBjE0qOOhvM/9mH/uNO0pJwVhr5hyKD8sc6CJ7Or4GST/SLrKSzZSgEZIRuilhxsZEnx8Ho5KhoOnMBdpdSWfKuVwg+NkS2+AMTgACDgQS+gKVbamXOtPFUJFO+gSIOovpt+CZZWP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROAzx0iM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso623226766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 10:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730658831; x=1731263631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MXtLD5wRAQ5fWQGbhT/CFY3veAbjs5UfHB13TgmgIyk=;
        b=ROAzx0iMZaAnmEYr2zCuP5cDu2+MAH4fpA6BlCfSW3Jn/EaGEazrWIxqI07SO1TUPC
         f6RWhEx6ZZZ1vXXMJIc++C5erBtkq0roYKFbfEnyOvL/s895xGgfJYhsJkrdiDda/sRG
         gHMwkBVDannPAFKJCQpkhPaw7jHbcAgUMikiOGPnpuUfgUlZeByFqryWjOsCeznmvl4l
         qowpEST9ZbQojwApNdEVzga1QUKMPy8bUV2Gg+yfTYSrzB0QziA5wv6mr2YU46PVsX3p
         LTcoinmRENlpZclAfmWr5EYwPpxSgqj56A+eOUcWnLqygfrztgKQwP1SNTSMDix7PtBL
         uzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730658831; x=1731263631;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXtLD5wRAQ5fWQGbhT/CFY3veAbjs5UfHB13TgmgIyk=;
        b=coKcbeg8YmTc758rbcyVOO10QdGbw31SgnKBkMqO7l++SzDT/hsE3r2Jh7FhAWZct6
         AS972mEZm6mi3MqXf0KN+Qo75CWaROibwZBQLQG1ttyUzFseAg/NBqbMhPVky3Yr5x4W
         Zn+PsgmxoUNERDwdnAq+Ec0z6VjjSgqNvqQVm0U5SYn4Z+CzRSZ18YRJR2oxUhtq7gsB
         Szq/bGsB29o6ycqW8vsBdMjaGdbYCnNmrf7rUHWewfY+GqaFvdMfJKyRV5vzdvs24OD5
         rXIAOZxe+kOaDnPhGSw8TMvmdS+opeRC6KiLYJb8H82hvR2kQ4gQVsnDjvC2mIP5geRL
         d6OQ==
X-Gm-Message-State: AOJu0YzRZY+KkCb6BWWJnwUlLyw3RIuJ2WEljp1zfCxX1PPg448XdqOG
	4SWBIs6H927OKU115YzGmJpE/ejJh+Wcpw+wPEil/QIQw8onXDIA
X-Google-Smtp-Source: AGHT+IGsSbqvvFlU+L8r0cp/QqqIYn5idEILSHQYe6KmlE9XzhTbxbdNJc1wfNLtzDxpjKvG8/8w4Q==
X-Received: by 2002:a17:907:e88:b0:a9a:16b3:7dda with SMTP id a640c23a62f3a-a9e3a5a0e0dmr1699882266b.19.1730658830785;
        Sun, 03 Nov 2024 10:33:50 -0800 (PST)
Received: from akanner-r14. ([79.140.150.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4d2bsm450358166b.70.2024.11.03.10.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 10:33:49 -0800 (PST)
Message-ID: <6727c20d.170a0220.292362.d5e3@mx.google.com>
X-Google-Original-Message-ID: <ZyZVMrgeO4GNEEGY@akanner-r14.>
Date: Sat, 2 Nov 2024 17:37:06 +0100
From: Andrew Kanner <andrew.kanner@gmail.com>
To: syzbot <syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] general protection fault in [v2]
 ocfs2_xa_block_wipe_namevalue
References: <67215651.a70a0220.31b018.c8d7@mx.google.com>
 <67215ae3.050a0220.24951d.0078.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PAhjboQ2frufRKAg"
Content-Disposition: inline
In-Reply-To: <67215ae3.050a0220.24951d.0078.GAE@google.com>


--PAhjboQ2frufRKAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
--PAhjboQ2frufRKAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename*0="v2-0001-ocfs2-remove-entry-once-instead-of-null-ptr-derefere.";
	filename*1=patch

From 8a9998952cc5d493cbb6ae9e6187347787b88694 Mon Sep 17 00:00:00 2001
From: Andrew Kanner <andrew.kanner@gmail.com>
Date: Tue, 29 Oct 2024 21:26:30 +0100
Subject: [PATCH] ocfs2: remove entry once instead of null-ptr-dereference in
 ocfs2_xa_remove()

Syzkaller is able to provoke null-ptr-dereference in ocfs2_xa_remove():

[   57.319872] (a.out,1161,7):ocfs2_xa_remove:2028 ERROR: status = -12
[   57.320420] (a.out,1161,7):ocfs2_xa_cleanup_value_truncate:1999 ERROR: Partial truncate while removing xattr overlay.upper.  Leaking 1 clusters and removing the entry
[   57.321727] BUG: kernel NULL pointer dereference, address: 0000000000000004
[...]
[   57.325727] RIP: 0010:ocfs2_xa_block_wipe_namevalue+0x2a/0xc0
[...]
[   57.331328] Call Trace:
[   57.331477]  <TASK>
[...]
[   57.333511]  ? do_user_addr_fault+0x3e5/0x740
[   57.333778]  ? exc_page_fault+0x70/0x170
[   57.334016]  ? asm_exc_page_fault+0x2b/0x30
[   57.334263]  ? __pfx_ocfs2_xa_block_wipe_namevalue+0x10/0x10
[   57.334596]  ? ocfs2_xa_block_wipe_namevalue+0x2a/0xc0
[   57.334913]  ocfs2_xa_remove_entry+0x23/0xc0
[   57.335164]  ocfs2_xa_set+0x704/0xcf0
[   57.335381]  ? _raw_spin_unlock+0x1a/0x40
[   57.335620]  ? ocfs2_inode_cache_unlock+0x16/0x20
[   57.335915]  ? trace_preempt_on+0x1e/0x70
[   57.336153]  ? start_this_handle+0x16c/0x500
[   57.336410]  ? preempt_count_sub+0x50/0x80
[   57.336656]  ? _raw_read_unlock+0x20/0x40
[   57.336906]  ? start_this_handle+0x16c/0x500
[   57.337162]  ocfs2_xattr_block_set+0xa6/0x1e0
[   57.337424]  __ocfs2_xattr_set_handle+0x1fd/0x5d0
[   57.337706]  ? ocfs2_start_trans+0x13d/0x290
[   57.337971]  ocfs2_xattr_set+0xb13/0xfb0
[   57.338207]  ? dput+0x46/0x1c0
[   57.338393]  ocfs2_xattr_trusted_set+0x28/0x30
[   57.338665]  ? ocfs2_xattr_trusted_set+0x28/0x30
[   57.338948]  __vfs_removexattr+0x92/0xc0
[   57.339182]  __vfs_removexattr_locked+0xd5/0x190
[   57.339456]  ? preempt_count_sub+0x50/0x80
[   57.339705]  vfs_removexattr+0x5f/0x100
[...]

Reproducer uses faultinject facility to fail ocfs2_xa_remove() ->
ocfs2_xa_value_truncate() with -ENOMEM.

In this case the comment mentions that we can return 0 if
ocfs2_xa_cleanup_value_truncate() is going to wipe the entry
anyway. But the following 'rc' check is wrong and execution flow do
'ocfs2_xa_remove_entry(loc);' twice:
* 1st: in ocfs2_xa_cleanup_value_truncate();
* 2nd: returning back to ocfs2_xa_remove() instead of going to 'out'.

Fix this by skipping the 2nd removal of the same entry and making
syzkaller repro happy.

Cc: stable@vger.kernel.org
Fixes: 399ff3a748cf ("ocfs2: Handle errors while setting external xattr values.")
Reported-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/671e13ab.050a0220.2b8c0f.01d0.GAE@google.com/T/
Tested-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---

Notes (akanner):
    v2: remove rc check completely, suggested by Joseph Qi <joseph.qi@linux.alibaba.com>
    v1: https://lore.kernel.org/all/20241029224304.2169092-2-andrew.kanner@gmail.com/T/

 fs/ocfs2/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index dd0a05365e79..73a6f6fd8a8e 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -2036,8 +2036,7 @@ static int ocfs2_xa_remove(struct ocfs2_xa_loc *loc,
 				rc = 0;
 			ocfs2_xa_cleanup_value_truncate(loc, "removing",
 							orig_clusters);
-			if (rc)
-				goto out;
+			goto out;
 		}
 	}
 
-- 
2.43.5


--PAhjboQ2frufRKAg--

