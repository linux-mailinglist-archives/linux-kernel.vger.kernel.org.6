Return-Path: <linux-kernel+bounces-255705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACFC9343F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951B71F21ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A35187561;
	Wed, 17 Jul 2024 21:33:32 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20701F94D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252012; cv=none; b=tJn/UTqab3TNv5s7qFZGY2vFiq5mi6uQ7tD1QRtjMjzikTWjfgENVJSF4MFYZF6a0mz6ksWJiqbqYbm1RQgiU4ncRiCy9FPeOQI1r/sPh14msNqoCoZDaVnxdzOaFvcvrEI4oJOY9LISPHPj7hAJfElmWj8lxM1fsaKR3N2Z5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252012; c=relaxed/simple;
	bh=zgNPDa40okyKAa9UA7692fVVlFdFXQk/cFySBBWX/3o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ju2CxepwNMQaS9SvzXAHnp54LsGMnFvIZxc78qfR5bw4mUzM6vRmovMnCifirDbQMR5RQKCTQh1GQ5FFHeo8Ma8L0jjsdSm1w1uEPzJSWwPORJJA0kf5S4kZBWyfpe8v/5dxG8QoVJYcUZzh3F1EUxzGCP4S+mbL3JtM2FyyUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8050ce2fd57so15871039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252010; x=1721856810;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnCh+wWmpzTGybjAhBHVLGRbSsaNIlMsb1SpNTAYFpA=;
        b=dLDkkGM+d3hZ53s7CdVhC80q3tbRgUTQz8tX6MPscZBs6UjwxAO2wGs3sk1LFqVcdi
         kdDQz6ejHU8/N3bnvCOPi0o/ie+uQw/5zLscPe5vh4ZngbB1SHrVtPkWd9qEW2sLFMIr
         DoAUIzV0zsz1p1KEOgntg4d4+M+KMMmllmRXvUnmlGL5FC8LWW8Lka+5rcAeTaVT3lf2
         NQHVIoZeL6QFlAodjih7BKpzSTjmygEpm0X3qJuBMCkN/sO/piQqgbxbCYNPmUUdM1Ej
         PitS00H2lGHVLYrvfk2OiMWft6k0Gsqdv+p/02vRSuOCvBTXMHUswv0UtJ8Ufm6Zo5/N
         kHIQ==
X-Gm-Message-State: AOJu0YwmXro+KmLJMS2+4V21EX4ylBOrVDmo4nTH9dUWMOiFPvUqtl6F
	FmSIcjpcX9/IUVNad7swxxXmw1AQmA8NlENZoJtwCBT1fGoJwkWkA5eN6W6LV12g7wJDaRlxtyq
	jXZr+bNDV/CiLdLvow5YWIMoXjWldcaiRn2XzWM9oKuBOgiDc1jriGIk=
X-Google-Smtp-Source: AGHT+IFbQMZs5UUnIBQi2TcGULNU58JsEhzJjXu+EoId4c/yIsUCDEEPsSblYuJ0HuJMs8upNZssYpZHe8B5IphxQTez6MDuln6C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6bc6:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4c21586e732mr86192173.2.1721252008013; Wed, 17 Jul 2024
 14:33:28 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:33:28 -0700
In-Reply-To: <000000000000a7d8f1061d69ebd5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081c3f7061d783660@google.com>
Subject: Re: [syzbot] [PATCH] bcachefs: WARNING in bch2_fs_journal_stop
From: syzbot <syzbot+4093905737cf289b6b38@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] bcachefs: WARNING in bch2_fs_journal_stop
Author: cam.alvarez.i@gmail.com

#syz test
last_seq and last_empty_seq suffered from an off by one error when the
journal has no entries.

The indexes were fixed and an assertion is added to check that the
last_empty_seq is always kept under the next valid seq number.

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 fs/bcachefs/journal.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index 10b19791ec98..7bbbf4b149e9 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1201,7 +1201,7 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
 	struct journal_replay *i, **_i;
 	struct genradix_iter iter;
 	bool had_entries = false;
-	u64 last_seq = cur_seq, nr, seq;
+        u64 last_written_seq = cur_seq - 1, last_seq = cur_seq - 1, nr, seq;
 
 	genradix_for_each_reverse(&c->journal_entries, iter, _i) {
 		i = *_i;
@@ -1209,11 +1209,11 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
 		if (journal_replay_ignore(i))
 			continue;
 
-		last_seq = le64_to_cpu(i->j.last_seq);
+		last_written_seq = le64_to_cpu(i->j.last_seq);
 		break;
 	}
 
-	nr = cur_seq - last_seq;
+	nr = cur_seq - last_written_seq;
 
 	if (nr + 1 > j->pin.size) {
 		free_fifo(&j->pin);
@@ -1224,14 +1224,14 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
 		}
 	}
 
-	j->replay_journal_seq	= last_seq;
+	j->replay_journal_seq	= last_written_seq;
 	j->replay_journal_seq_end = cur_seq;
-	j->last_seq_ondisk	= last_seq;
-	j->flushed_seq_ondisk	= cur_seq - 1;
-	j->seq_ondisk		= cur_seq - 1;
-	j->pin.front		= last_seq;
+	j->last_seq_ondisk	= last_written_seq;
+	j->flushed_seq_ondisk	= last_seq;
+	j->seq_ondisk		= last_seq;
+	j->pin.front		= last_written_seq;
 	j->pin.back		= cur_seq;
-	atomic64_set(&j->seq, cur_seq - 1);
+	atomic64_set(&j->seq, last_seq);
 
 	fifo_for_each_entry_ptr(p, &j->pin, seq)
 		journal_pin_list_init(p, 1);
@@ -1261,7 +1261,10 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
 	}
 
 	if (!had_entries)
-		j->last_empty_seq = cur_seq;
+		j->last_empty_seq = last_seq;
+
+	WARN(j->last_empty_seq >= cur_seq, "journal startup error: last empty seq %llu is higher or equal than the next seq number to be used (%llu)",
+	      j->last_empty_seq, cur_seq);
 
 	spin_lock(&j->lock);
 
-- 
2.34.1


