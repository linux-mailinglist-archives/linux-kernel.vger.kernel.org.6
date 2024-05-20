Return-Path: <linux-kernel+bounces-183358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7998C97F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443C81C21474
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17B9457;
	Mon, 20 May 2024 02:34:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6617F5
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172446; cv=none; b=o2BvlfOlCgqobjt2D8cdfuzWEB3Y9IWkxpWhTnXHQEoenQ59G1WhuTDQbzFCQFvsaHzJVuo70FAnWNLntfBpi5N+DISVDiVQWm/f+AwgutlLaeYWadC3rvNVbIhx5n3tyWJOynIBn/tmXhIuEE9pr5pRV7YqxsN3ybeMCNOvqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172446; c=relaxed/simple;
	bh=Dmc6fQr/uOyAizhvwYUpEDjlcqM/tVpFsTAQ+URioI8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=po+jR0HaxkCuVQd6KgLjNcvjMaruuiResMgi5frzMG7QMfiykRmXAHtsgxBJRfGBvJUzC9b9VaSjS1sIpDZBWlGAGywsEvLgt7Sowq0hcqSx+PLfqFhIn11nClivFL9CKzTWtHxSO/ffft0gNZrOUJ1H0BWgWGyZV8Y/xHxOOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1d3e81a00so954857739f.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 19:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716172445; x=1716777245;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdf2Pb1gNaJtVYhh5mZOBYEG4go1WS6ZMGBpSdQ2gSA=;
        b=uvICndjvBTaoGO6k3/HCsrW4gh0svJjlY5vzhFvVl3evVmnuiN6pUFeA+XZ1N8YrgG
         BSmVwA7CFNBzldMACnfAoeaYyhOv9/kafVDGOgI3kOKn2p0G5LnGouWGy4thaXl63Ijw
         wAocSHBYbb7b4CH1eKC8C9jNKWsXn0cRKV7p9P3d1G3QJuY3ALpFcZEJdry0pNtnAwjj
         DM3E4vKX6pjgo5g1qAKIy0SzWBc9s/8qwmQxi0cLAq1sDIfFdJ/POrwsDha/MfyJuRws
         CPnhcr2sanlKsHZ3UMFK9/WXVWDw7q/D7mjzZ6AL9SMkeg7z7aXSQRuqKx+MjEwgy3+9
         JraA==
X-Gm-Message-State: AOJu0YxY+4E0h4ZzQ8ySP3gpLISOphQlV7zGkmWXrUCYW4PP39QhGVkS
	Ym/YrcdjLI6xUxcovU2KnOpi/qRqvr55pUgtHQHeZTRekfLJt2NrdGp6/LFoo9Ff2pQ7Q2wgf5O
	B6FJFRZUqA/CyC7oh+g8I6XVVdQdFG4BlYRbDkzTrVocdV+OEiPyWI+c=
X-Google-Smtp-Source: AGHT+IG2OABbLOH0GWDxUZ8eYzb6s42dPslOmBx2FeJ3+llV3mXXwtY78h8ZUFchOsF3rR6b32tLyrbyYi9tjX2oWUmNcAAP81nY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8625:b0:488:d668:d201 with SMTP id
 8926c6da1cb9f-4895856f59emr1476718173.1.1716172444828; Sun, 19 May 2024
 19:34:04 -0700 (PDT)
Date: Sun, 19 May 2024 19:34:04 -0700
In-Reply-To: <0000000000009bc5fa06185a064d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f296e50618d988ff@google.com>
Subject: Re: [syzbot] [PATCH v2] bcachefs: fix last_seq and last_empty_seq in bch2_fs_journal_start()
From: syzbot <syzbot+10b936c5eaee2819b49b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH v2] bcachefs: fix last_seq and last_empty_seq in bch2_fs_journal_start()
Author: cam.alvarez.i@gmail.com

#syz test
Values were left as the next possible sequence number when there were no
entries.

The fix involves updating the last_seq initial value and
setting last_empty_seq to cur_seq - 1.

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 fs/bcachefs/journal.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index adec8e1ea73e..99fc32f0382d 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1195,8 +1195,8 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
 	struct journal_entry_pin_list *p;
 	struct journal_replay *i, **_i;
 	struct genradix_iter iter;
-	bool had_entries = false;
-	u64 last_seq = cur_seq, nr, seq;
+	bool had_entries = false;	
+	u64 last_written_seq = cur_seq - 1, last_seq = cur_seq - 1, nr, seq;
 
 	genradix_for_each_reverse(&c->journal_entries, iter, _i) {
 		i = *_i;
@@ -1204,11 +1204,11 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
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
@@ -1219,14 +1219,14 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
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
@@ -1256,7 +1256,7 @@ int bch2_fs_journal_start(struct journal *j, u64 cur_seq)
 	}
 
 	if (!had_entries)
-		j->last_empty_seq = cur_seq;
+		j->last_empty_seq = last_seq;
 
 	spin_lock(&j->lock);
 
-- 
2.34.1


