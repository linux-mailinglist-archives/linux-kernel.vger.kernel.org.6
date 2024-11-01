Return-Path: <linux-kernel+bounces-392221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19019B912D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B191F22653
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDB19E7F7;
	Fri,  1 Nov 2024 12:35:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7281922D6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464525; cv=none; b=BupxqulZ7vEgplnmWENi538Mcwwv1osqWMDT6v6f/2DN7xbjWJSSZeZdsbInKcGBPIp7pWeNsxTjpFzUbgoo1X4oqFN9NU3r8s9+/J9NMom8ozZgDrIzpe7FX8y8i7yG+hgNiwiFBjVrfkYlChCfZKi9b2ujBHgi5PczTUOxedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464525; c=relaxed/simple;
	bh=HVB5/NVaiKyBGPvEmmfY/c7p0v/zE5OlN6CpY3SZbBY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZODiQkbN14MkdAujckt6jV4oJ6GvBL/ucG4qDGKME7A+KSDN685CfFwWLuNc3o7eUthuNqZZqloMF3oxXKWamhy1AhpIbY+bvlPmSzhrFCp0O2IhvTmGoNY3J5ucycZ5gBZx8gp9k1qwD87ukCI14bumdnlKP3e1g999ie4WKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aba93c01bso181008439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 05:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730464523; x=1731069323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqxBdgu2xZeKw4i6FxiYHpI4dVZ37OtghOrpbdMwysQ=;
        b=ZK3hCkFxwGcFgHiphj6xoBR8pP7qBQu1BjB0LsiVpr4TXve46RHXoa/6a+EIaqX4WZ
         Y5VU+q3mxgThSsXKzyXm9yGYSNzAynBiB4vp+1vN9adgcLTLLYGFXuozHoR4vRdGoWnq
         FwjNJkQW/ulOwAdrOwYqJrfShHi2lTAJf7BvP2Piugl3DWgnTEy8Q42me+rjg8NEQ4op
         yFLt8bD2s3e09SyoJNrBOk7i0tfNSkE/QKhlpVljYoNQR0I1TFPIy7827yn35JYKKqiF
         JOxCAPGwFwU35eLOeqATSfiGhUSFdeFE09uqOUOgwuDILhTiyVI3WJJ0IlzuSZ3ypZ8F
         9Phw==
X-Forwarded-Encrypted: i=1; AJvYcCUoyjdkwlGSqz6l60AgH9j0XtGR+e9aovwoKTGKZPlccDPrZMeDUpaXVVMAS8X34Rma5VRW3Tml0zF9ELk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWcBJPZJw7b+/YrieasciZEBUufz5kB2VHUhT7zqMfNKP2mgSs
	Fp9vh1esuhxbSOvzqsrUvoWaZjpl+3Rh1mMr1Ay6q/V7MjOU4pLjvadYbPr4sE2rJppQE/tC4rk
	eSbZw8veelm1oaXMd3Iu71hX1zQc8aWVOkvYm/2QeDwOmUAg14dVcBOg=
X-Google-Smtp-Source: AGHT+IFIPth4ymIAQm9ibhbpxBXVRYZLXve0lYxevJygCkAGVPrqxwfn7PPjFPvflXzq1Zwov5RsoyfEpkNAg6sKsITuofe+kgCR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54e:0:b0:3a3:f95f:2dd with SMTP id
 e9e14a558f8ab-3a4ed2e0656mr273595655ab.19.1730464522993; Fri, 01 Nov 2024
 05:35:22 -0700 (PDT)
Date: Fri, 01 Nov 2024 05:35:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724cb0a.050a0220.529b6.00fe.GAE@google.com>
Subject: [syzbot] Monthly kvm report (Nov 2024)
From: syzbot <syzbot+list69ba935a6501a18718ab@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 2 new issues were detected and 1 were fixed.
In total, 3 issues are still open and 125 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 147     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<2> 3       Yes   WARNING in vcpu_run
                  https://syzkaller.appspot.com/bug?extid=1522459a74d26b0ac33a
<3> 1       No    WARNING in kvm_put_kvm (2)
                  https://syzkaller.appspot.com/bug?extid=4f8d3ac3727ffc0ecd8a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

