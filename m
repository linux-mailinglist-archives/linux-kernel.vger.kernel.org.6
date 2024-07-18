Return-Path: <linux-kernel+bounces-256129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C5934974
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5AFB224BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00FE77F10;
	Thu, 18 Jul 2024 07:59:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24EE75804
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289565; cv=none; b=HhUk0OUsL2awvsnGWqXumsAttN8GGxTa2PIBaqMOC6c7SPQ9/1tj7tJnUlGOVs0cGy2EpzFggKUsE/Sqhw74weP3b6hmKbpgqiMMGJh+9p+svDlXKaYFH1Y2khzCmrXiwEcDkH7QEiqhXSmb7M/9IUh8Pihv1aOJ+Vr7g7XdmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289565; c=relaxed/simple;
	bh=iHJvg5p6ljjkOIDgZWQcmFfi0Y1NKHZvbW7p0qF04Qk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EkHnwyhVpRd37zlySL0KGXpPWOoK1HzRRWXSkoaYlajqYyWYfpSBMkna90Shp5eow4mPbIRXgd5uHIrdTIHK0WKMahaR6/B/tRDnhjB/RRIfE1AVWrpFVGjFoTgqY/MZSyrXPM6UMLkVCEcZj/n+pJ/EH62VocAvFctuFDvKLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-395e9a52c93so6135595ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289563; x=1721894363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHV4zKfzs5x96MeKzOONV81pwLBbmFsAPIuyFbuSkKc=;
        b=ZdbNAa709INw8y0WLXjY6sW0ue/XKJUJbRVY/8nMHyaoRDXXvIXDB6RhCv/pW93dmr
         DJLLD/RiagJNQ4rh9kvbfGnzmUrPpNEcOb5mgYZk/lm2wL4LQ3d8Jxv+cI/8dGFBJ6Uq
         aMFPJ0OM7DH9blDb8j5pJZVAbbrlXr7xt7xssBbB8OQwnKjdCur1KwRFOkorXCSrkyUw
         0Dh2HMuEBO614AmUHxK8Stomc3oX7uCjRok0F/b4+XxG17LCpRMN4x8FQMcfP0kijqHz
         7qm16k2M1leJb/enpqBeTeq9M86zqzSg2bs+9oGwj6fa1th6VyA472/wAdjCuRpeXGfl
         UiWw==
X-Forwarded-Encrypted: i=1; AJvYcCVA8709gFu67+dfy11TJrZYjtHRAqTat86Fw2YtQcVpsM9Vme654n6gd0qcFUy4dPtK7mif12wqaAt5Zu8SxXCUKJ3wZspR4JQILNhZ
X-Gm-Message-State: AOJu0Yy57HuBP5qiaAkNUl1t249VvraSf0MXiZ0X9Qir31qKNAMoK+Zn
	xPHrm65T6mYIJxTu2zp1Fs813FYRJMmKIb+ndC3SyLOlCf5OjmbbZs9CnY0ugT/Rp31olF+59r1
	btR6sDxGTKvsbFMPVdtvGOWG69kOjTQHQ8eqDfAUqTiESG95hKj0iEpA=
X-Google-Smtp-Source: AGHT+IGFvLmyMLdMmeI+i8Xzqf7GwFhBg9/Q7LokY8RMP+e23aQRukE1B0UdVqIn74NMtdfxMgVjRFcbqnzNaMYm26Jq5arsXEvJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:381:c5f0:20ef with SMTP id
 e9e14a558f8ab-395526d992emr2867015ab.0.1721289563027; Thu, 18 Jul 2024
 00:59:23 -0700 (PDT)
Date: Thu, 18 Jul 2024 00:59:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5cb0b061d80f4e1@google.com>
Subject: [syzbot] Monthly fs report (Jul 2024)
From: syzbot <syzbot+list44baf210a6a389320a95@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 4 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 349 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4025    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<2>  2605    No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<3>  1138    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<4>  1094    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<5>  825     Yes   INFO: task hung in d_alloc_parallel (2)
                   https://syzkaller.appspot.com/bug?extid=55f124a35eac76b52fb7
<6>  575     Yes   general protection fault in iter_file_splice_write
                   https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
<7>  445     Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<8>  349     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<9>  320     Yes   WARNING: proc registration bug in bcm_connect
                   https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a
<10> 295     Yes   KASAN: use-after-free Read in sysv_new_inode (2)
                   https://syzkaller.appspot.com/bug?extid=8d075c0e52baab2345e2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

