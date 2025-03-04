Return-Path: <linux-kernel+bounces-544623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB187A4E3F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC778A1B43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251CF27CCF7;
	Tue,  4 Mar 2025 15:15:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F925334D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101323; cv=none; b=COdXMZEjkxEvLlWFSwWfvUgvk75bNE4ASw++mwvH2+YXfMcOwdA5sRSYfu1dzWFzz4tByCNUimLhKu1aBZpEXnAgPxB5aK04HAZTear3xbEezdxZDG1968XleH481cfmE8j6RXxCnqR/9ZxUsCBiExQ28oTCCnCWNhCt0QwnBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101323; c=relaxed/simple;
	bh=chcXcvuikcBH/ICfxxyR4lmX86zFuuGpphD4P71zF5I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t2H94PsORVm4pl2jWXePYNUR5spt3hGxVeeFf9HV2/kAGd34i4fGFQmk/Hzd3fqIN1snNFrMYTXUMdiL8CYAQcjZSUwgI2ntA5sNwXYXANY1WsaAev9dNsqA2XoyA1Sb39XKF4npJH//HiKKBmcbzrr0yD7iDrV49I8sKgG+6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-851a991cf8bso508393039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101321; x=1741706121;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVPHum93vQ+4McdAoIpqqn3xv9w1jDzlp0vknZoAs9g=;
        b=Fzg9nTg2rV0V1nrC5y1yeOTuMW+X7DsJKAv9X2F9x2giHQN4iz+2gO4SjhPejbSEuF
         XGCjJlsEQQPCj1f5h2CEYtZZs6x7w/EJMP4nIWapXklGRtLHJSQOmQv0qojrbReCLoib
         Dwn2LkImIqQb4NyVzsvlYmp9sIxI9V0DSJ4l09UowVWCj32BHAp+dZWAMSLsHrYE+DlR
         fAwGd1dgYIfgtm8pQYr6Prijcnz+0pE8t46GLIuQQDjVCz7coyA+Uws0yRBjU5qFhJiZ
         S1hdYJrnfd3paRVlnjpua9s+lArKFHBf8ZqBYbcX7OKoB28LdfIt78rskeM7AE+o+IJl
         hk1A==
X-Forwarded-Encrypted: i=1; AJvYcCXjn7YqOCxjJbaD3de30LjCXj2GetZ0DTVPHBC0is5oE2Bng6Ov60jaD168IVOuceCi5iBp6D1y3JwSNPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoNilNs0dlsfuSkTPoDKxvYYemAjaorv7axY1AU3Np+SH4t8t
	3HwRN//3/1GJoezAnjcKNEi8xmCvZOEgsSRpJE6YzK0LlJrTfG3ecSGH8o0VGsKyM2hSdh3d492
	7EQidiOKQ/PQoLRVDbUfT69HAvC2NbcaNX8SY+GQrHLZaCoyYFlGgKYc=
X-Google-Smtp-Source: AGHT+IHZp2JcDtWVHVX7r/bgLgaAh0PsvtXXDIjy4+ah1maw+gtJ8gs943tSME9f2/ECI+Hsgg8a+zimyBITtUygXNuKchIhWidO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1708:b0:3d3:fbc6:96c6 with SMTP id
 e9e14a558f8ab-3d41dba3f60mr37768485ab.1.1741101320904; Tue, 04 Mar 2025
 07:15:20 -0800 (PST)
Date: Tue, 04 Mar 2025 07:15:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c71908.050a0220.15b4b9.0011.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Mar 2025)
From: syzbot <syzbot+list6e31de9aa6d237da5d04@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 34 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1131    Yes   WARNING in __alloc_frozen_pages_noprof
                  https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d
<2> 40      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
<3> 12      No    BUG: corrupted list in p9_fd_cancelled (3)
                  https://syzkaller.appspot.com/bug?extid=15a08eabe3d3838fb641

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

