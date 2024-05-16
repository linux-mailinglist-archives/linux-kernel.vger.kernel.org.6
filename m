Return-Path: <linux-kernel+bounces-180556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D22138C7020
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57FE0B21AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1E4138E;
	Thu, 16 May 2024 01:53:37 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DAEBB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715824416; cv=none; b=YC/SUTOobVAKeAA41LSaFC4PIjzo6g4SUSkz/xjBuXFcveZ7zTDqnt4HH4I9rrbCbqyBwLkBLImfiAovBG5EDV50rkREnf+cFFh4dkw8jCM5cPyZBjDJ0dhvZPZKnyyBbgHT8ED/sWeG15D45F266CsEVw2qh+nm7FskoXcCAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715824416; c=relaxed/simple;
	bh=rOKdQ3N+F1PGXNs69n/ZNxCVgWVYh5ZQiDFu0EJptgE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qDQziqE/v5+y8/wVN3L4Xw2ovaDiK16Srbhs4Motzl4VtHy1Qafn7PJ7tg8KfkRRa4VWXT7FoVucr4vt/+VCy6h5VVkEWHerWYkYXAOqHta37/Lm2ncpscsOgTcR7cMpTF8kwmCcIxNNQ05k2g4BL2sCF3BhChhS/U0l7akGpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b1fda4c6dso89602705ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715824414; x=1716429214;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3b5BLJERYWCwDqY37mhWSKVY47KPE4N4nHJwRLSECrI=;
        b=qbZ9z83TGfSIU1FEKcgYKTk6ATXIMqWFhRgggRlwv8J0s2uNwFIz82XaasVo345Whl
         JBTHuvtrXkiDS2TFxoCdVUxT8EJlIxcG4Gk2oSnGcg2UoKt8EMkel2GaIbNBcpU+w9sU
         adzVKYYVnX0BbXazKb/U+Dy9scvqhDm+rX4kyY7U9JRRLC3nde3DedoT8RN91azvDDY5
         b3LmqXNdtL7Rdq8GzdAJWlbrcC7ihX97iV1P6FUS8pKtNoD4DuNNYUexSJ9EeSxgKg+x
         lf7b4u1hYG/06IUUTo5qVv6zOf+K0x8oqJ/RGk+GAGIqfpGneMIIcH2cQP2te7clC9cm
         laYg==
X-Gm-Message-State: AOJu0YwV7oEApv9E7juluQb1bSCkKyMRjz7daTrdn2CzMYderxEmG3Xg
	cXkgRu64ntKDPxtRH3SuCfno4xcUBzUpNTM/5Fd/uyFi3e8rxLHIunfMmq0wSeCE+0gI/vOPzKT
	kWN6dD7ZkHP/XmsRTDNcRvlzarpVPL8j1knteJcCpK9pM/jJrSaADoOk=
X-Google-Smtp-Source: AGHT+IF4AJw9960il03j5cg3S3Td6DqRua8f+gTBAwB9irQHhNGcRyQD4QgJI8oUMnwLvFq7Clxv6DOp4g1MBO88LqK6vDOp+3B8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:481:b0:36c:8135:8d5f with SMTP id
 e9e14a558f8ab-36cc1437ea1mr3006595ab.2.1715824414650; Wed, 15 May 2024
 18:53:34 -0700 (PDT)
Date: Wed, 15 May 2024 18:53:34 -0700
In-Reply-To: <0000000000009bc5fa06185a064d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb836e0618888015@google.com>
Subject: Re: [syzbot] [PATCH] bcachefs: fix last_seq and last_empty_seq in bch2_fs_journal_start()
From: syzbot <syzbot+10b936c5eaee2819b49b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] bcachefs: fix last_seq and last_empty_seq in bch2_fs_journal_start()
Author: cam.alvarez.i@gmail.com

#syz test
Values were left as the next possible sequence number when there were no
entries.

The fix involves updating the last_seq initial value and
setting last_empty_seq to cur_seq - 1.

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 fs/bcachefs/journal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index adec8e1ea73e..3835c458eec9 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1196,7 +1196,7 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
 	struct journal_replay *i, **_i;
 	struct genradix_iter iter;
 	bool had_entries = false;
-	u64 last_seq = cur_seq, nr, seq;
+	u64 last_seq = cur_seq - 1, nr, seq;
 
 	genradix_for_each_reverse(&c->journal_entries, iter, _i) {
 		i = *_i;
@@ -1256,7 +1256,7 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
 	}
 
 	if (!had_entries)
-		j->last_empty_seq = cur_seq;
+		j->last_empty_seq = cur_seq - 1;
 
 	spin_lock(&j->lock);
 
-- 
2.34.1


