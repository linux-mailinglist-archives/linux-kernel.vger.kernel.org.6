Return-Path: <linux-kernel+bounces-415793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087029D3C90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36D92837D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651881A08C5;
	Wed, 20 Nov 2024 13:31:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830A17F7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109489; cv=none; b=ZNMmvj2Dzqge7X8gfi8vl1Y+t1DgLH+cvq09Ob4bJQ5+TFlyWZLk6PpAR2CkC7o6PRAGGP9q7vzk1FmAoDeDioEuNnaligiO17ZY7W8MO0WQ/VVUi1TN8NsT7ARCWddH+b/DpoEGqhZSE5EHVTeyHzGSMiZbl+nnhL6+kRpzM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109489; c=relaxed/simple;
	bh=MU57nMisx/6DEWDRufdi0/bsONzbPtV2fDCpEnmn7FU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KI2d9IG0WCoP31ghuS+IfIeh/PHJrOHex4kUeAkLKWbgnyIq31enb6H8Oqcq4wWl6f4oA0i2KR7oBYZJJw3Oriiwt5CmUjHrNCDAfeYO2nYbSH7kTTkp2z+8o0h5WXsj4f1qLpUSFqSi9mE4MhjgK66t8qlyF8kbHbsYVyeRcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a78b04470cso4884345ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732109486; x=1732714286;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/BK3spmsTuxEzWm9e/Iu6YJGilsWDZvSEFFz5TUplE=;
        b=p9DPrapZoDKhHVSgcRLi9w5C2yyV9Mk9Xj+LPdelNf1w1aUJYW7useAerasu2rwFEw
         iVZTS9EiX0q9R7tH+s4ySEWnJDWP1N2sktG6/cSGYDfbuZ/a2OPMZyL2WQYi9LDFjcnz
         nzmCC8jv5FopSjN9wWb996FkrvSjxnV3Qo/2pvECP5bOiNBX2x68+dIt7XYGWoRMjrX7
         KQxjIM8ioT0yFueMwhm9e53idQ02szy/RFfUh2tieVjdxKTE6OgiCJ4JPAIndJndvuEE
         MTcxGhvp8edt3uaVkTE1ELXZMJ/puMbKbt2fPhAyIEoywOVwbmWnnsTi5eHtpOSxtVpN
         x98w==
X-Forwarded-Encrypted: i=1; AJvYcCXD/t0atMt12XK+oD6WYaG0bTuR0eodcxGFz045ade1o5D6A2jamahhM0dObyBmjG9w5VqYt7BCAnNSdb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0I5V+x8TXi7zmw7VPyWYgg7fDY0mBq7vo3iKJWc7JKPTnXWA
	v2ctx++JvcrgW4TjG2eD7nj54EQfktp/9eOeSNtOJcV5KLrdt6r/vgaET03OQYs1ZjGOfj4Slzy
	FaehqlPmNXodRgUMCv/hYzybywxAzwEGXNKSLOHn3XGRij4v7fFr7018=
X-Google-Smtp-Source: AGHT+IGNkM4FXQLC52rJnBBrgYZ9hMSrVqlzi9r0gSGenJtqsEGtG1gV/hn0Rixsya44TSqnTcavRAE0WGshWuFspPKsCC6vq7Of
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3104:b0:3a7:8cdd:c08d with SMTP id
 e9e14a558f8ab-3a78cddc108mr12190545ab.4.1732109486630; Wed, 20 Nov 2024
 05:31:26 -0800 (PST)
Date: Wed, 20 Nov 2024 05:31:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673de4ae.050a0220.3c9d61.0162.GAE@google.com>
Subject: [syzbot] Monthly overlayfs report (Nov 2024)
From: syzbot <syzbot+list777de70fa5f0bf9080a5@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello overlayfs maintainers/developers,

This is a 31-day syzbot report for the overlayfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/overlayfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 130     Yes   BUG: unable to handle kernel NULL pointer dereference in __lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
<2> 4       Yes   WARNING in ovl_encode_real_fh
                  https://syzkaller.appspot.com/bug?extid=ec07f6f5ce62b858579f
<3> 2       No    possible deadlock in pipe_lock (6)
                  https://syzkaller.appspot.com/bug?extid=603e6f91a1f6c5af8c02

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

