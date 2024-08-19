Return-Path: <linux-kernel+bounces-291384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A16956170
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB9282628
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4013B7A1;
	Mon, 19 Aug 2024 03:27:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A722064
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724038025; cv=none; b=h283RBBY1Cr7/aCzh9wigJMzdybF1GF/4HV3Id1ZRb1vjs7jFwiv1kb5lNeG1Kv+gsEPe46fLhXLMCcfkuJW1FbuG0Fp9nW6r2ASqxn+H3FMisRp4RR0OmxQIIz/IVqE0qWMPd67pMjSiy3XqxwUtOSSTeg7UDF81knICZcO+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724038025; c=relaxed/simple;
	bh=8QmuNmqm65SMy7JLDenj439cDsItg7rWNJ3Z1rYvUXA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u+9Vw8nNJvChMu/c8Gb2gn3+m0j0GkTs1Pl9WY15XKh49XpbB61Nv3946wwuSEYTxJmHRgH/jTa1qjtUTI+8l8wpMvDocdNeJhyCQ0C8ECRwktXPoulQ84+iZEaHq5b8lohf/JQOL5aZRB69/vPVEtEwc++rIE/+Lio0SqQzvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b28ea6f37so40559705ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724038023; x=1724642823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0y33gPE0WW+jRIq8dDUYGb7EJaVpIvIur5WR3/RbDY=;
        b=CJOqt1Qoy4p9dc1lvbRPi5Ps55Bo3Gmu2X7OesYcw8gpdPp2aBA3o8NoihtkjLARWg
         I34C/t2t5gPV+/jq4Lpzit1qqter+NlqdUYvDsYV1+vLeR0i1j8NqiVKOjxXywKlEA3o
         IPUWZXr6CjSMxN2b/qgl0D2q/23sMNXl9+2XO8joyPYkp3J4d80YJIgT0lPePVqNmZJ7
         MkCPoH8t7h5klCNeGX3bYkOH8JfrWB4ybzUK039ggJW6CQ26WIrBgvm3nma+8Hxmf0xk
         /vwQhfnYYw2fwCevD4XEGTDaVQfuntaD1L+YX8Y8TAILIBnpjC5sTrq+P8YE6ibBqhrx
         9aCg==
X-Gm-Message-State: AOJu0YwzZScx+zFKenHe2cDHHJq6SnrMHFLUzyyu6vI7uYtIMAwDOoGn
	ykZztpBe2IlWrbtsMBvyGM1rTfNgDnXOpItlD+fLWL+GQYion/gEnetZDsI9tei+C5Opiv6hUV8
	hmZ1FihAVeSH5nbWOlwZBHPZa71LOQRlzq1E0pFjOp5uOdx56icQOyY0=
X-Google-Smtp-Source: AGHT+IFeJpHNWXl1XuTz7teEIUbOVoVqlf8mk3/nRygTYgpq/jXzxd7MSXJkiVy7zXLWc3CkqKe1cdy033gDejz88okBXCQzjeY9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:385:ffe:4516 with SMTP id
 e9e14a558f8ab-39d26ce52e0mr5407665ab.2.1724038023334; Sun, 18 Aug 2024
 20:27:03 -0700 (PDT)
Date: Sun, 18 Aug 2024 20:27:03 -0700
In-Reply-To: <00000000000071b7c5061ff83639@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5d890062000e13f@google.com>
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
index 13669dd0e375..1219f921690a 100644
--- a/fs/bcachefs/journal.c
+++ b/fs/bcachefs/journal.c
@@ -1304,6 +1304,10 @@ int bch2_dev_journal_init(struct bch_dev *ca, struct bch_sb *sb)
 
 	ja->nr = 0;
 
+	struct printbuf buf = PRINTBUF;
+	prt_printf(&buf, "ja nr: %u, %s\n", ja->nr, journal_buckets_v2, journal_buckets, __func__);
+	printbuf_exit(&buf);
+
 	if (journal_buckets_v2) {
 		unsigned nr = bch2_sb_field_journal_v2_nr_entries(journal_buckets_v2);
 
@@ -1311,7 +1315,8 @@ int bch2_dev_journal_init(struct bch_dev *ca, struct bch_sb *sb)
 			ja->nr += le64_to_cpu(journal_buckets_v2->d[i].nr);
 	} else if (journal_buckets) {
 		ja->nr = bch2_nr_journal_buckets(journal_buckets);
-	}
+	} else
+		return -EINVAL;
 
 	ja->bucket_seq = kcalloc(ja->nr, sizeof(u64), GFP_KERNEL);
 	if (!ja->bucket_seq)

