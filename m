Return-Path: <linux-kernel+bounces-214540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C8908629
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDDB0B2502F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9061718FDB7;
	Fri, 14 Jun 2024 08:20:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAD184135
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353221; cv=none; b=Gc01v5XhhbM2c3AA+2gVaoSRe8Tt4gERtk0PhtwV0r5LJlonZBTpwGetYKa7wyTjN9Z9cJrAhS41DSF4w0OKmV8MOW9GELSfKQxbTWeN7n3A9EcUL4ppqkhrWNsRr3ADN9yPtJVbBPA3CakiUejv6XQNGGCimR6mb8hdSRdCw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353221; c=relaxed/simple;
	bh=m8XdaqtXI0w6HM/U1eVRx3knXpS9a+JdhIoBK9Geo8k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ISDGYoR7FS46rGk7IoJORZUF561RWqa2PEznYiiXZ91uOR0TXVNe1gERXJrJcN2Etmt8AlWUjqXcr4VIXhmwxLQguthQUs/YeZcUr8CV/G4C8UrT/v494UPn8mkakwFeWW8K73Y4DdgyyFOWsfmsAFv2STN/0ZWDZF970cy6qeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ead7796052so193860739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353218; x=1718958018;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mw/gmD8zfhhWz2Q5eb6Jk78puOClrPRzMXMX9i+PUck=;
        b=N6PIGP+PMFeVoO5sKMR7HttYOmvfvu0Hxcv+Grlr1YhH4dsgSKcFmJnBUw/pb5ehNW
         jKvVDCpARTnfl72p44WNMb+c63lcCPyAMPh5uKjzOwvElhzvo3l++FW++jx2NDYpuOmR
         dUAqNmIksMWCToyrMlcbhoeQKev6fw2RMYlzFhQ5X6eO6DZyOSsFUlNLTyZSBs9t0eft
         vKWcGcTN7t4dGgp21Vco3rRhBQeK/BwdmhSljKSNYO2vyEbcY6bdwMfuofklQm+d8Rcv
         3TIvcJT2z35c89RWvCXMsaVFhaKMd2FaKsyOzIIe50Y9u2gPWaemoOiMZZSjjUMBHnb9
         4UEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1zckGqLaSS+yrmHxCYOJv0c2UzX64WUhD9cHDGIILul4pCbVaLfTJ1E5xmlD6xUM5eXF9c/Z/dmSvi9rcmSPcOX/U4TjSNuzPYmfI
X-Gm-Message-State: AOJu0YyVys9Auif3Nah/DIW7qSY/ZLag07nJWqoRB+7vVkUOMojda7u6
	DzsIO4AmVzZ/n6+zHVxGhWw0zg19CJDlNhayRkUSnxzHe3nTxeQrC2symsHiKsqSQgIkr76GI95
	UwSq7OvS4LdDArGWZIYlvSrHX5kUaUYcpSphgiA9WuiOSfvFXOstD5yE=
X-Google-Smtp-Source: AGHT+IHB18E+8kcUAwZff/xbzCuJF99fWBw8Ydni7ix1UtZ71j5o875OuOmErMVjsVk5mz+02kXiI2NbYxq7lQqOkylyU3hzksdw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340f:b0:7eb:7e0c:d172 with SMTP id
 ca18e2360f4ac-7ebeb644af1mr3718739f.3.1718353218699; Fri, 14 Jun 2024
 01:20:18 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:20:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003311d8061ad549c8@google.com>
Subject: [syzbot] Monthly kvm report (Jun 2024)
From: syzbot <syzbot+list25a0ec62c55b4b714cc3@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 117 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2960    No    WARNING in cleanup_srcu_struct (4)
                  https://syzkaller.appspot.com/bug?extid=6cf577c8ed4e23fe436b
<2> 197     No    WARNING in srcu_check_nmi_safety
                  https://syzkaller.appspot.com/bug?extid=62be362ff074b84ca393
<3> 147     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<4> 2       Yes   WARNING in __kvm_gpc_refresh (2)
                  https://syzkaller.appspot.com/bug?extid=fd555292a1da3180fc82

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

