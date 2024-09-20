Return-Path: <linux-kernel+bounces-334684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC4D97DAA6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199F91C20E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6418DF63;
	Fri, 20 Sep 2024 22:45:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B515FB8D
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726872322; cv=none; b=ESjH0bNGOiHhSj5Szqm1VZmsv/CZNvyx5u4Z3PjZ/iw86ox3FQWSGk6DQ33buoF5awNfWXO4Ha9UCTJ7fOm1Lyv2ga6PUtTEkWqNlboWVcN61WlFTf5pa00GSAID85lUIX/1DKooSQGBbLCDPz74sk/cIMBXXfuI8VSRxGMz9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726872322; c=relaxed/simple;
	bh=eta5Fc9Y+6a/5oMPLsomajKDvYS1cKOPfTjY1UsPG6A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mkXgRquXH9Wcsp195yBoTdbFeZr/G05riiaKAWjs+pNGUmpnjIc2KhT6878Lp034+R7wMvVRD0q8aJZGFO90X/oBGRlIFUNkayzXxXfxPrL5Rp/ja/v7SC/TSVhTj3xDaX+bn6pD/0LgxgnIc9SOGpHh48fcHikMRn4KmhDNk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a09aecb414so29951275ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726872320; x=1727477120;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joh3pehkJFQ/sQ2EiiPr8j4k+Jc50WReW9rhSgTJIrs=;
        b=YOtYanakAk52FtAyQ5HngRuU7RfIjD3vQz0x1oOhpY4lNM+qN7ays5D/tJpAIvG90f
         XcUTB0VlktD9BfvMUX92mTkMKAEoJA8A3lMZZtU2HOGY8ZBAb56Vd+lMPUaoQSQ1VOIB
         S1gqdVTNKtkfedgTcVb4oshcg5yfFt9DrTLu/4ypeeJlEohYL5LgyJzwWleGUxg4TuCM
         XwhXDXQHQKiAABTnLrSiB0YYqBhB4CTdt61cqXH0kMY36o75dj3AdvE+ZP6VPibAms2S
         XQo0iLZQiVgWHsSdbS9+w3UceK9e34/BFjtexfcXK8viDZHGEwcnEVUoTMuCyW8eksRU
         Q7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUzzpxoYM42IHyyIY/wZBOVybwLkR8vkrHejJmihlAqicRPGIsyfaYjth8fNXZ0oXfHRNgra57FFet3X3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsn25UrChBBVs308iwZJIqsOf+os+W/OzyYYbC4n9vobPuMAP3
	DGVfs2LZeTdNpekLbBHkCDrVwctXyXvllyGMHO5NwEFmxHQ01PX/DdJCXui3bFA4ySPwYoTD4UF
	SUuUaZZ4SmI6XXXbMyNH0RaF5mZPjkSTKUkgDl1NOMVMiuOl1aW4xjlQ=
X-Google-Smtp-Source: AGHT+IGsinVff1sLKMdNLDGhsqC03PzSGBwOSCgbfPCA79JmMGWFm/j+SeqrDrSI6ffXqOtgugebWHvl+pcWMvg+l9jc5FsoxQSx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:3a0:a71b:75ee with SMTP id
 e9e14a558f8ab-3a0c8d13104mr47938005ab.19.1726872320312; Fri, 20 Sep 2024
 15:45:20 -0700 (PDT)
Date: Fri, 20 Sep 2024 15:45:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edfb00.050a0220.3195df.0019.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Sep 2024)
From: syzbot <syzbot+list888f35116218f9d000a7@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 776     Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<2> 4       No    possible deadlock in obj_cgroup_charge
                  https://syzkaller.appspot.com/bug?extid=57765728d598e67e505a
<3> 1       No    possible deadlock in refill_stock
                  https://syzkaller.appspot.com/bug?extid=dfd0410e573d2afac470

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

