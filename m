Return-Path: <linux-kernel+bounces-345265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F89398B3E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06D828312F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB81BB6B9;
	Tue,  1 Oct 2024 05:46:40 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1636AF8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761599; cv=none; b=Zip+1lc5D5PVF5DLhHCSVCo66Q8WA637paqbeDJ2Whbr6jgS7/QjElNN2zvNeKlmOnfrXEE2pGWOi9j8nz1U6AWvld0v94tHY9liX5/uB6BF3esizvQZOXbTrHQA/jl+jUj8Nel1UzqEu0NWVJ1k108mRIFfVCgtiGcg17dY1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761599; c=relaxed/simple;
	bh=Q5KEKQqCsjBp+oa2L0VcLE8Oq4y5l51PJxEkomhJvvk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jAc5nJKQ16lXGst/eY0o91LjTGm/7qqXw8U3mSjrigg3jIZbyDKedX63rLbj6HT0bM4JNuL0iFOvs2c7BtLRLK8Rcry+vjkjCb5WAfMATweco/YgrXv1Ht6zsS6FkWYOOyLG9fWvER/LtK+Kn+qPO0//J2ynJzPlC3s08TBdCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so73845015ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727761597; x=1728366397;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFTt3IUEayUJbS81bjxcptmT7GeK8/AEn5VO30B+WRU=;
        b=xRRYdbZEKooyf1LcK4HkiIHqNQMMm5Cbs5nxSzXBVaIL50cXYNpXotQY8Qz2R3uijk
         eYPQeUDnX6DtDVjHX+CEvVYfJfvG9QRZjSkK4H13Gb0w6eNLndn7AKfP9n/X/gOi2lYR
         enSnUw9r+jGah3U8OmJZv20I8C/n/b9XXVtw+ny1iWZY6jbGSd833dyoXb/qWkZ21xML
         bN/7ivubkviTTMYdK5xGwXpfhto1k3B0ko4sKCqNioVW/2ld8XzERcodYEJODoJKKXOu
         o4aC7HtGOQvGTmZWXyLprFspIbnOmSfPXhYe/3zwn9HPD88ej9QTOWlZtegvC/elgwUr
         VPMA==
X-Gm-Message-State: AOJu0YzCI9XzmpcMT9oGFa7rLiI/MFJX50eOCaRPXbdkk5g6k5iDUwb4
	litGN3AOwti4JIIi11CcexMZuhQOA8YlkiB1VzrRbBAKFQQ6fjM5yK3TYnwHtQ6tC6ZcVXVX5mg
	QF2OFiQb26opG12PA/bzoSts2ftmaSm/ZldVMxuM33jgtVkpNkdu96/M=
X-Google-Smtp-Source: AGHT+IEPGciNtVaxwZmhvPpvkHsnGZ6VLR5p6H9Pgd807wnNmWX6Akb+gX68gAqPVXmKadNbLsm8ILI2viij2AD9eQ/6vapCK2Ox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:3a3:40f0:cb8c with SMTP id
 e9e14a558f8ab-3a3451bb951mr124339675ab.17.1727761597190; Mon, 30 Sep 2024
 22:46:37 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:46:37 -0700
In-Reply-To: <66edaa30.050a0220.25340c.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb8cbd.050a0220.6bad9.004e.GAE@google.com>
Subject: Re: [syzbot] [PATCH v2] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
From: syzbot <syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH v2] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Author: marcus.yu.56@gmail.com

#syz test

Use folioq_count instead of folioq_nr_slots to fix a KMSAN uninit-value
error in netfs_clear_buffer

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
---
Changes since v2:
  - Use folioq_count when putting pointers. This avoids touching
    uninitialized pointer and is a deeper fix than just using
    kzalloc.


 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 63280791de3b..78fe5796b2b2 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -102,7 +102,7 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 
 	while ((p = rreq->buffer)) {
 		rreq->buffer = p->next;
-		for (int slot = 0; slot < folioq_nr_slots(p); slot++) {
+		for (int slot = 0; slot < folioq_count(p); slot++) {
 			struct folio *folio = folioq_folio(p, slot);
 			if (!folio)
 				continue;
-- 
2.46.2


