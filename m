Return-Path: <linux-kernel+bounces-410437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18EF9CDBA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94641F2350B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC919049B;
	Fri, 15 Nov 2024 09:32:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC018FDDE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663148; cv=none; b=IUkjPgRLpSeJtKdrf51D+aMTFBFkw3QDpO9yrI6NxQwfisGt/T0k7tv7SCiTO9M080BpGDYPaM5YfyVyYMbV2cyhmovs3OAKugfrqzqOJygdgmW0l9XGBFUMOB60cngl55MCsMHgA+Qg1zJEd1dRWwYQ8eJXWkyhcn6p2xv5AwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663148; c=relaxed/simple;
	bh=pLEcRY782n6JBEDsQYEF4qteqYuuy8RnY6roI1WU2Vw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BJ5qrUFdJP3J4ntkrELtJGqyLsQ+BwV6VAunRJyXcPDSIrOsCjSOBWLql5qVSNGd4EIQJtLfhD0lv0T5I1idYZIVvXTb3sXLN89s/84cuvUzRH78vZouslyPTtemyA7XRL66RKtkzHuEwitX3SjIbHqn1wJ4gOXMOSryHxIFbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so10393415ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731663146; x=1732267946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/4JedLJscdKRq4iXzIJ827KeB/EVhqHO4lJWwOuHEs=;
        b=d6SnRg3bsZiyuoEj6raABY2SHyvrrDP4XpG4LTCpzxWJASQDsXQ5gwsZALlSIkQjoa
         VSS3WVSr3XHtAArV5ExohZhFnym02h8PYyPpfShODjVOlZCEXNt//n56dAHYojQbkFX5
         wyK9dE9O74xx51zQSc+924G0Z53E7jvzrOtqjogCk8iXj7nrGUb5JpFRo+RWUrYrKRvm
         M7VfMVPatuzFGsT3ZDpRanWl+joYXH4a2b7bAfdLKomCD1eePgYUKjLdSx6TGtqy7JHD
         AMC2uJX0cnopldS9OJoI9fGpyImPQDAs/jY3tPRvlgHwKwKdR8VIQMqM4Q2cVJib92eK
         W+AA==
X-Forwarded-Encrypted: i=1; AJvYcCVzHOZMkXflbYnzmfR7zJwaYOtaETpwHdt+tc6Mf6fdmX9GeSXZhWBlvKxoZUSEL1jVAGMDTM6KOf5rne8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTzmSJz7gmkCbTz9NCgwqrFsiH7SQqLkL/nT871DhXhb7RyzJ
	l3eNVHozoNqQIUjV2+nG3Ypo+d5j5E7YY6+sWqQSOmpEe8soGzq1tUKvLuwaqARzCrgWjbDC9Ts
	tBt3b7XtcH5MYJKsya3zgXp4vUktmfXsZOtDLuDs5kLX1wUjl4w0YLuk=
X-Google-Smtp-Source: AGHT+IFkNe6EY2UatPnRjrWl19SBY6KFPRa82qL/NArf+bDN37oMD9QNRnFcCmaGnthLHYlddNNg1sf4yBsqhf9D+XhJrXlzqckf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3420:b0:3a6:b26f:a5c4 with SMTP id
 e9e14a558f8ab-3a746ffdb14mr17585525ab.8.1731663145709; Fri, 15 Nov 2024
 01:32:25 -0800 (PST)
Date: Fri, 15 Nov 2024 01:32:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67371529.050a0220.1324f8.00a4.GAE@google.com>
Subject: [syzbot] linux-next build error (18)
From: syzbot <syzbot+a521f132f5a83d10ab40@syzkaller.appspotmail.com>
To: apparmor@lists.ubuntu.com, jmorris@namei.org, john.johansen@canonical.com, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    744cf71b8bdf Add linux-next specific files for 20241115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10525cc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ada879778ea11d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=a521f132f5a83d10ab40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a521f132f5a83d10ab40@syzkaller.appspotmail.com

security/apparmor/domain.c:695:3: error: expected expression
security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

