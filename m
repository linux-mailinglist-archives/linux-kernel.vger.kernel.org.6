Return-Path: <linux-kernel+bounces-329337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB4979028
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734BD1C23053
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D81CF2B0;
	Sat, 14 Sep 2024 10:58:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB51CEE80
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311508; cv=none; b=f+7an3Zm9m7jEtHQhlmccsDxKwVJwy+opxZ3wr5y9GK9zbRKWiZnZggnMCDn2GbkTRWJ/Wf5xxhJ0HgXBwlEK2V/7U+KLUIedqqqqGfd4jXCICDsFf0yidp3ewfvob/nH0iWSjlpg3MHgWLTmGwnjtvi+F1cKVbTmSrFZKdFy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311508; c=relaxed/simple;
	bh=8cPaGWVNvaiVsXGhl9BZ46sbtKEhwpT6r7AafzNYscU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tndm/Z1gvzezh+gfNjPRNoZy4zj2EkOZbkphcoDyWqQgUnNSzwlDPXN5RtUesHwKbpYrlzqWubcsQ601P0N4tl9aMUR3VZBLeImSob1vLbat7GwH+dKRsnUbCOKXo66meuEM4IgziZcQzTlXTqmR7pjkew4qlJa6J121oXckscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a08d90c938so42354075ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726311506; x=1726916306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSXhuj3zISCMZB3nnxahyL41R/wox4A+ugF2KROurmQ=;
        b=DweOVUT3dU/swnH6WJnUjqS8NztXaEkzWt71yun9syDcv+bJWLoRhMyMcXENnYXtYk
         9tpGUXB6x7QzN+gqB8zWLbJKR0/UJyR/upC9g5df3zQHZUFhIRhmqDI6ujtU+X0PgKHT
         J9t8D6ct2R2n0FVL/JGh2GsPrTFqkzCUK3A3u1Lo86806T5so2JDqeYahRpEbnA0fz6/
         vx9ddM0BpEU5ivOuIjrPKCWZkLeMYByz6p2G+FVAMr3EcOoAiZGAvgDWl00U/oylMVwx
         itt27DvIAd6+wxv+83r9HHiEAFmmhz9qDyOLxRqWpf2p8nFTG523W3sebkUPpGCyjIqu
         HTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Jw8H9vuS7X5zC5M1wJ72TkPnV78ANWK28I64/TBC0j1Hi9IGjJzORwHIWFR3f5//RlkDS1qfyvWu+ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNE/gsLJ/beXI7UhOQG9eTDT2ubdEasQC5Db97w3dj+IqfVad
	Vikso1nv8ALxdjx6n3lBWEqQ+C4v6TyRVkiZqpS0xly4G6niCBhOIzPcWl+r4BRnmRCIXLtgjT6
	j69erlr3f9GHCmf+zvd2wFFkrzc7w3UoZErtp6CvRbwTZb0yVLXAFw9A=
X-Google-Smtp-Source: AGHT+IEbp4K5Yuh/JujyoRFTiZfkIFNS7LT8IRlV7c50hWWYcE5sW6Kz1S9OHTVBkx3CynhKyyD9L0xgwQU1PGG6lWtwo0a3T57g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:48e:b0:3a0:52f9:9170 with SMTP id
 e9e14a558f8ab-3a0848e5d4emr79133095ab.1.1726311505762; Sat, 14 Sep 2024
 03:58:25 -0700 (PDT)
Date: Sat, 14 Sep 2024 03:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e56c51.050a0220.3a9b1.002f.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Sep 2024)
From: syzbot <syzbot+list5448e58c688bab5fb496@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 6 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 126     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<2> 42      No    INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<3> 7       Yes   INFO: task can't die in nbd_ioctl
                  https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

