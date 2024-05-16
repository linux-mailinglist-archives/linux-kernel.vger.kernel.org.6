Return-Path: <linux-kernel+bounces-181049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0B8C76C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DA21F2204C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C79C146005;
	Thu, 16 May 2024 12:44:35 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98182335B5
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863475; cv=none; b=QWv4I8b1zoPvTMjgGF4XdvEnWPr6ihnhFO4DYORIYhFB61ygd9O74LOtQ3WznD7TeR6Ltvw74+QUK7NVq1Dmor9NM/L4mL/qJc87KwWSnPyIoA+cyeLj8z+8gW9y+/Ai0CNzT/HGwU3Qd0njPOVl5NQMnOF77UKUvi+NAD855TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863475; c=relaxed/simple;
	bh=JqWWX2hy/Fdn+0A59AbDorqmyZZtP0tcKNltVEt33Qw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nTATKyQLqUQ/wniHdZQgTGRM3G1b0B8lf+iaUCTFIA5YmeSryqS+op2f25jQtM1IDW4tdOABRxP2JM3hNdxoOr2+qiR4+StZdptFgjyVNFP5zVK0H6/blPuigUqJKILvHBeV+PGrBqgWB4KLGQpWdx8z/VCDegpbItMl5Tsi5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e17a8bed9eso786548839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863473; x=1716468273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRwNaMQsPTmHLjomIgA9uFH3GtuMZTBSHhedZoUpFGo=;
        b=O6aQo8lKSt2+9/41HaUozTSXnaUNnOG7Tt6AuGOW5TikVghBNmASDc9kPSZV17ua16
         18Mb9r96atYafPMzVrvp3dtOUlyFETmFrtIRCOPG+x0r0e2SA8YkMD47/IM/eQzHZtqy
         /Vr0uF17NuWQIv9E5hOjcguG39UVoITlZdVd5wxF3Hj1ONFTTy2LP8F+f6AwPF5qC/Mh
         7PsBb0+Q5KlDAPPEcCtukUpLce6jSzOyFAXtYU9RyBda0RaeXmgU6BhWZkxmgq94cw7t
         aCs4eaUAl0oa1eDlFc9y6wlbV5T8zbZz+zJtJu4qnCUDQ4R17Lik+N3W6qKuiyJulRWj
         Syrg==
X-Forwarded-Encrypted: i=1; AJvYcCU9r46cuHN0vdbF6xHP/GoRlcMg8xvj1tah4ZoNSLooUX1Mam1ocgkhnl/eqYU7q61FSVMlAELbt6cggEHtFrz4UP/j6zhrDCQHY6PN
X-Gm-Message-State: AOJu0YxTR6vHW3bRP2tiqlvEwVOiDIeuDpTaa0KW/ATv9NeyMPMtEeMv
	w+CB2axysKme8gp+RHj06qz8s9W7n0x0iaEkHhVHv4+krhzvXr+nVPlbpFKuay1EtleBBocwpkR
	sMjsnojuO89LS2CkTAF+pkp55sLpXMhOX+6DvI/E7SlZRfYK5C8LXoNo=
X-Google-Smtp-Source: AGHT+IFc+t0/Gyltub/EaQjO0BxplnBpjXnpbmFn+uaATFXJZox20R2LkW56zT2m5+K15ZUD2A+MW3E5pcQvuS4oUlqsqzpeCMew
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-48958694bafmr1329243173.2.1715863472835; Thu, 16 May 2024
 05:44:32 -0700 (PDT)
Date: Thu, 16 May 2024 05:44:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c81fe70618919881@google.com>
Subject: [syzbot] Monthly jffs2 report (May 2024)
From: syzbot <syzbot+list0f6d40430f0d17a567b7@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jffs2 maintainers/developers,

This is a 31-day syzbot report for the jffs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jffs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 1 has been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 730     Yes   kernel BUG in jffs2_del_ino_cache
                  https://syzkaller.appspot.com/bug?extid=44664704c1494ad5f7a0
<2> 13      Yes   KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass
                  https://syzkaller.appspot.com/bug?extid=e84662c5f30b8c401437
<3> 3       Yes   kernel BUG in jffs2_start_garbage_collect_thread
                  https://syzkaller.appspot.com/bug?extid=61a9d95630970eece39d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

