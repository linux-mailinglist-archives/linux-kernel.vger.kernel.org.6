Return-Path: <linux-kernel+bounces-447093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F59F2D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F561887977
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D4202C5A;
	Mon, 16 Dec 2024 09:45:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A720102A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342326; cv=none; b=QwdNgDmt6wIY378eklyOV/Uca1w7CCE54QG2FRJt5CrUTpTpPt7MWGHhROG0xdlP+wE5SlwNshTnjna3qAd3rjGDMLyIJf4tHv4R3D1scpA4/Ns0WyGvuHmwd9gRhAvW3Sg+mwBMTEJuWWaJyN7bbcSRUuLmtfx/2MxoVB4vuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342326; c=relaxed/simple;
	bh=8mtxzrWV4gewRcK71MhxjCFiKSHPwB7UxiiQc1sf8Ko=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WmvD/DMNxRovyC1SgfwRoZ9eEnINZV/zLPiH8j69/QbZP3GW9ZpLcAwtQX8KrAXOrAiXd6Z0WE1HIwvuSu+VL4TB6RD6JhjtPAQ7GgOQriJ4pExHd34n6Bfuam2VZRHVoM/iXPJHkZhZdkWb2xnDSXojHvgpV2I/ljiJAvAIvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso36129845ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342323; x=1734947123;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMzVsBAaxz4G1X0acZCRaYr/sYpeNPkFz7MQrq+3vj4=;
        b=e/kRPubdoqLJyCTtDz7MoRtG8J9LDGQvyzVrB4jxaYz/ZqQQuTEYR4UHlPfydTwh1l
         4YyjmdPywt9Pe+O9BmIHh1Cp6x3vEahTxMcYrapOMOM8ofiC1W/cp1CXm9VMwIN1lq3H
         31l3ddksn+bQ5j5b7ZweqL1dFKSfhjarduCIvP0wtAZvJhI7AfqMUH7Jxf73oaLn/hp9
         nXeTVn6A2e7Js/zYb/yGjWul880DxXkx9hP6cFNlONGOXtSiezGn46MQDnGMeqHO2phd
         bAUvGb5dI+BVadulbBGt5MeHn1wVkuY3lVIvkpGKzQmHAjqUlB1BXcSF9V1+8mZT5slh
         +t3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqVGqpEN59LiK3k45AKuoPE6mP/3RKI3CzH3MnvnYVPvDhUCLHMD7/aggPjmRMaUYO7VY31ArvM4SYNms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6Wm1BvPPUCXa/HcXX59kf4PilkK4KVP/jrV+XwIiXZnXiGAU
	MzKySSr7di6/0nshNAcJBQIYDcLIClric7+ThbQLDYRiUur3ZKDguk4qUSX/QR6EoTyIzrE5USl
	7uPOPkK/DudazPaRDvTeIpT3FshsLiXGCnJOYSEynwAtK4IxZWtHWJiQ=
X-Google-Smtp-Source: AGHT+IEp6IecTjPnXdiY0kfC4wTydw2PyX4iC0kaDv2/zdYsJx/UpbptRIFAprzDKEY2ZSf5bK5Ma2LWOdyjz/TXxT9mL9z08fSx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:db48:0:b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3ae62c90bd4mr104509675ab.6.1734342323627; Mon, 16 Dec 2024
 01:45:23 -0800 (PST)
Date: Mon, 16 Dec 2024 01:45:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff6b3.050a0220.37aaf.0126.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Dec 2024)
From: syzbot <syzbot+list6f489e4466839f688ee5@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 37 new issues were detected and 0 were fixed.
In total, 108 issues are still open and 110 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  24764   Yes   INFO: task hung in bch2_copygc_stop
                   https://syzkaller.appspot.com/bug?extid=c6fd966ebbdea1e8ff08
<2>  6585    Yes   INFO: task hung in __closure_sync
                   https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
<3>  3362    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<4>  1635    Yes   KMSAN: uninit-value in bch2_inode_v3_validate
                   https://syzkaller.appspot.com/bug?extid=3cd97352d16f0e6066d9
<5>  1283    Yes   INFO: task hung in __bch2_fs_stop
                   https://syzkaller.appspot.com/bug?extid=6d3e28b33490b3085412
<6>  924     Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<7>  904     Yes   BUG: Bad rss-counter state (5)
                   https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
<8>  547     Yes   INFO: task hung in bch2_journal_reclaim_thread (2)
                   https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
<9>  487     No    possible deadlock in bch2_symlink
                   https://syzkaller.appspot.com/bug?extid=7836a68852a10ec3d790
<10> 427     Yes   KMSAN: uninit-value in rw_aux_tree_set (2)
                   https://syzkaller.appspot.com/bug?extid=ed52fb987e4b52cbfad9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

