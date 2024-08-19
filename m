Return-Path: <linux-kernel+bounces-291495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1295634C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEBC280D77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F351154C14;
	Mon, 19 Aug 2024 05:37:45 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907814BF92
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045865; cv=none; b=Zix2RZA7cU+p3gGobsUa1RCp7PQZ8CUwZtcyI+NOmSnzMR+NVfULjZh839oELIiOKVG/OPCouMZ2LaBnZdd5m1JgEiytGR62ONJCTCck+pdnwt1q3CAd7ADhToTQZgn8ABuHV1IOou5glqOEfr6dUeKO1UFSJrcsxYD1aYWdPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045865; c=relaxed/simple;
	bh=e+nPnS4XyxuzpYoHA/PrKm6uWs9jfGZZHcWs0Nd5WSM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MzQ/T56iZ1kPvCR+anEV7STIDiCSQdii2jvWFiw0TxfTH0X/mfzeS5/2al42h++UcprWiPK9xIjQfic/+Pf8zdvbNY1YOetLSJyt13JQg2TPt1AP4JbosjyQGaGKffl0D/QeAwj/4Dxkz+X8SekEwpQBXCEU9mORR19fO6EeUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so414837039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 22:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724045863; x=1724650663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZXQ/nH9wJXxO6Ctvm33UDJfvbLkfNyruTtFa/XEzPM=;
        b=H4prvQQhKEtjR1wOP+j2K90yUI+P0G/AvJGfAqsVRKglNcXcY9hRWuOely+kBUh1BT
         1gZQuP7+ztAqFXc2G4g6hnr8VvRwIHoky5TgLlHzwj1eounq5xSqmh2PXBH6verppfFc
         JSF+dyuAg4sl1fn8n0bWoz5Ya+l2JRagxLGKIOimexhy4a1f691DpSGCOfJ9CehWTqUT
         JN1tqHmpH3mM7PRinmp7xJ6nb+qfLRaZj1mXzoF9lTQ+E0g2LZZurq4PytgJkpeU9o3I
         YJZrvam5o9Ik49cfsQ81uJmLEpLDxf5SY0gwsr5vjB8lAILlI6IOvqPyZ5J+MPn1g1og
         fpzw==
X-Gm-Message-State: AOJu0YznFaca4BTW5+xIRK10fIGiJV5Ss1sVrZz//vQDcRwnzv7Kwewv
	9pd1TsF8D8n26HIytcJZJR6pvxo/7lm+7PaI/RwHbstNrH9JtjInibuAiwHeUysuQ5bAPBaifdG
	wDVV0eHXlQDiIxwdvRwc/8Weeff2EFbIF2xN0+iC2+5WOYxpVZfq+xik=
X-Google-Smtp-Source: AGHT+IE+3P694oZIrubRwT7V/eGaHTwR3QOie+JN/yIPocr+fp7vV4UykqR+eo3h0j0AJahxIMYVhduuoudgxOA5d+fIfdME3F96
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8301:b0:4c2:8a0c:380d with SMTP id
 8926c6da1cb9f-4cce1695f7amr629476173.3.1724045862843; Sun, 18 Aug 2024
 22:37:42 -0700 (PDT)
Date: Sun, 18 Aug 2024 22:37:42 -0700
In-Reply-To: <00000000000071b7c5061ff83639@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b49e0062002b5d3@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Write
 in bch2_dev_journal_init
From: syzbot <syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Write in bch2_dev_journal_init
Author: lizhi.xu@windriver.com

two obj are null ?

#syz test: upstream c3f2d783a459

diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
index 13669dd0e375..d6970d834991 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1307,8 +1307,18 @@ int bch2_dev_journal_init(struct bch_dev *ca, struct bch_sb *sb)
 	if (journal_buckets_v2) {
 		unsigned nr = bch2_sb_field_journal_v2_nr_entries(journal_buckets_v2);
 
-		for (unsigned i = 0; i < nr; i++)
+		for (unsigned i = 0; i < nr; i++) {
 			ja->nr += le64_to_cpu(journal_buckets_v2->d[i].nr);
+			if (le64_to_cpu(journal_buckets_v2->d[i].nr) > UINT_MAX) {
+				struct bch_fs *c = ca->fs;
+				struct printbuf buf = PRINTBUF;
+				prt_printf(&buf, "v2d[%u]: %lu overflow!\n", i,
+					le64_to_cpu(journal_buckets_v2->d[i].nr));
+				bch_info(c, "%s", buf.buf);
+				printbuf_exit(&buf);
+				return -BCH_ERR_ENOMEM_dev_journal_init;
+			}
+		}
 	} else if (journal_buckets) {
 		ja->nr = bch2_nr_journal_buckets(journal_buckets);
 	}

