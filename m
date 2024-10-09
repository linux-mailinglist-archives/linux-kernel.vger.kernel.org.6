Return-Path: <linux-kernel+bounces-356996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84322996A10
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306701F23D61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80D194C95;
	Wed,  9 Oct 2024 12:32:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5161922E5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477125; cv=none; b=tNf0Wiq5qLOWKmgqeygc8zaUrrGYlX2WI0KBL9skvkoVlOmrlYOTv0TiM0gcUM1fi6CsBETSzqjuIeHq9fqWBAuhEIgAjZdXzj5ZcI6BqqsLlWodOzxQH/x+H53442F85N5P1Oplcu0gzIjcJFU62LaZwd1+xll6S4gMKdSmqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477125; c=relaxed/simple;
	bh=lfXEWTajvrvkCCH7NIIw3Dpjl02gTiHWFvvJkaWjYc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KCx906Gh9fEQAE8IkUjqHRifyJj+vy9hURq/UD7l1fqdhMlleqilyJ150Zeiag3esYHyBZteUJ9qHolhqWf/H4Xj4utoQ0J5VTDxI0BSxHsQTWmXez+VZkd9iREUd1MIaXD2v9bdff5t75G0s3tL9DPxZqjWLGTG2U1zv4DinzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a364acbd2eso59103825ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477123; x=1729081923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XEtDE41DijOlaDO108xIbZtcFN+7xIdjs3DBklT5+A=;
        b=qVOQrmEPVtHwRfUoM7DuCJS5i+gSgc4Q1QVCeJFt244T3V9VQfEeWLDlKXafddsVwo
         N0Y7lt+KTiE3zKJt01aC2iwSRzTGRKVSGqxXr+HuugnroWC0LuSE53/1WpvUH0M+LuMj
         HVnmWJaxF05Pap1U3gKb/x2ivc0q5+1sFvBMlXXSHdsVg3rLZ1GzTM4bZQo846N3CPm0
         1ewrHOAkbI9pqqfaXLfLih4B4yDCUvCtSk6/DJ+zndUWaQRxO7a3v0B3i8QEQLXia2/G
         mWU69lUQBoH+T/oY/mErT+0e0bYNoVwfZdq02nT9cIHZAs69wqdazVgTZefUIhBpZqYe
         EApg==
X-Forwarded-Encrypted: i=1; AJvYcCWLe3/usWOJlujRM8axoSotUs6X6MNvNRyjoIkYQiLSyClKR1JlP69bgVi/oWSq5E4tUQLrcPzIZ/bRUqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10cThvi08Q4OvPHViTCg4QtZzTcfaog6p3NqpdowPxH7/ceDP
	YR+f58Oh4PB4dtinxSCB3XA/JFIpDWv6b8ie/n+xVXuQQVpobPCR0RIfhOmVDYZ2s0CFWB3V4iD
	yEuFj/veKsernRP5AM+gA1yvkSlR0kvKlBP0JkWXVGjTr9s8BU/wvowE=
X-Google-Smtp-Source: AGHT+IFKLroh4TrPfI9wLSsRGzIh2g3eqt4u64q7LcQxlgGxukn09r3sqZ7xI16ZY2QabrRcR0rHh5PErHqjywTMtDD+eCwIu78h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:39f:51b8:5e05 with SMTP id
 e9e14a558f8ab-3a397d106bcmr18298975ab.16.1728477122970; Wed, 09 Oct 2024
 05:32:02 -0700 (PDT)
Date: Wed, 09 Oct 2024 05:32:02 -0700
In-Reply-To: <66f98a80.050a0220.6bad9.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670677c2.050a0220.4029f.0000.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] WARNING in jbd2_journal_update_sb_log_tail
From: syzbot <syzbot+96ee12698391289383dd@syzkaller.appspotmail.com>
To: jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	li.kai4@h3c.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a09decff5c32060639a685581c380f51b14e1fc2
Author: Kai Li <li.kai4@h3c.com>
Date:   Sat Jan 11 02:25:42 2020 +0000

    jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166bd7d0580000
start commit:   5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=156bd7d0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=116bd7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=96ee12698391289383dd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d0d7d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14351f9f980000

Reported-by: syzbot+96ee12698391289383dd@syzkaller.appspotmail.com
Fixes: a09decff5c32 ("jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

