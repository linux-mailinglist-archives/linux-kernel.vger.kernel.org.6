Return-Path: <linux-kernel+bounces-179320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E778C5EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039A21F22131
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E58493;
	Wed, 15 May 2024 01:26:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7579C2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736367; cv=none; b=Cp4BLt/nPQ6dpt53888J99NjJ0gPgz2w5m7QbHRliXgYAx4boeOT6BxYAM4zKq1FOsCc8XVzJT7EvGPnYUWyYN7ojjVGv+vbSVATNAFj5AdDSthJk2CkHnp3E/Y0e+Q4v6pffoT1v9lALnrkPnPfcfOD2tNwFyoiA0ucyWr4pQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736367; c=relaxed/simple;
	bh=KqedpD8xfbv4Oo0MVIN2TL1Ut79j6Yz4AF0sCn9HRmE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VbC6ExQrYkb0u6AlJqLKKXBSzuDTpDNwPYn18k8dGvUZcLVD/oe0JdCil9MFq34NzFGWyzklPRkvlvX+UouWfG0U6i64eUrEZuwODv30UNfnjnEXXpjNHtnbhq7RcK6zkAqDV2PhH/BleyeJxnZ7paCwCtXym0+0a+B60mF9OYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da4360bbacso770232539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715736365; x=1716341165;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eu/7agIRsX16G/eKFz8gLh3sRtt5Oof3eN1Be02CY3o=;
        b=mQ4/fDsueqif4d5sVd9RECQctIXGRp/XIAT7S871oIzp1b+f1vqegENIL8tXLYidZ3
         3xXIGPlRzmqZ2tfOFngx1wY76DjartrwRGZOad6RfjQbRUY/B4n8nRAs4LIDQWGrWxoS
         m9FYmbhkoawHoeM+k96GPQcn1NzLUY2pHDJHp7eESvWSUt2iXV/jMs6vdOhTpUQ6rqqh
         oDIrxn4+gwz9iXC2Z7FvMdwakryIL0X0Wh1R2dRjANjxEmnrz9n/VuHtZqWCrZt+abe0
         kJNBHuYSbndOnCiM2VA+uOR5TeujCfnpK3Jo8tzJ4OrbotQ2kfZFAq0wr5r6kzYWOotQ
         lRwA==
X-Gm-Message-State: AOJu0YwEHKcG9Acd89/OVEIWlq9chfOCe6XM3Ghj6GonflYDQWgiKVq5
	+O6IG2Xv8Q0mgfHVwcXunobjyfUZ3082TfUN02Y5RAKFaeHUS/bbfOFHf8Giw7/Q61CIEaxgK6d
	IPkLNuvkZbAbtsIpJm8b0oMm4Gr8XLRZ9b6lcS2pQXEmU7qgp1FJG47Q=
X-Google-Smtp-Source: AGHT+IEcdj7ctieaYOLO+MpmoD3I8m0VzJwkbXy9pNnL4nc4cYJkopfXFvf0hUNfc/IsmAV+4uD5mgRLQVk8UZ8Zqg3yNlhQAnGy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ccd:b0:7e2:b00:222d with SMTP id
 ca18e2360f4ac-7e20b0027aamr668339f.0.1715736365369; Tue, 14 May 2024 18:26:05
 -0700 (PDT)
Date: Tue, 14 May 2024 18:26:05 -0700
In-Reply-To: <000000000000ebf2e0061866b102@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096207606187400e6@google.com>
Subject: Re: [syzbot] [PATCH] guard against unknown r->data_type in bch2_sb_dev_has_data()
From: syzbot <syzbot+249018ea545364f78d04@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] guard against unknown r->data_type in bch2_sb_dev_has_data()
Author: cam.alvarez.i@gmail.com

#syz test
Shift is perfomed only when the data type makes sense.

Fix a missing guard on r->data_type being known.

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 fs/bcachefs/replicas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index 678b9c20e251..0fa91d0bf951 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -1006,14 +1006,14 @@ unsigned bch2_sb_dev_has_data(struct bch_sb *sb, unsigned dev)
 
 		for_each_replicas_entry(replicas, r)
 			for (i = 0; i < r->nr_devs; i++)
-				if (r->devs[i] == dev)
+				if (r->devs[i] == dev && r->data_type < BCH_DATA_NR)
 					data_has |= 1 << r->data_type;
 	} else if (replicas_v0) {
 		struct bch_replicas_entry_v0 *r;
 
 		for_each_replicas_entry_v0(replicas_v0, r)
 			for (i = 0; i < r->nr_devs; i++)
-				if (r->devs[i] == dev)
+				if (r->devs[i] == dev && r->data_type < BCH_DATA_NR)
 					data_has |= 1 << r->data_type;
 	}
 
-- 
2.34.1


