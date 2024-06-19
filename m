Return-Path: <linux-kernel+bounces-221323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D7290F1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82C31F21AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9613AA40;
	Wed, 19 Jun 2024 15:14:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EA3FB8B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810045; cv=none; b=KgHy7umB4GPH0nwL49+KFnlBnDmrNpeEHE0/ENu6YCqnE5QLCCr7KwjsHYO0veeJ+o+Op70Pu/TEomOMnX9NH/Gl0P2VSuWgwaalaCR5kIb7uUuFiU8sSzvggJ1F9w4PkKbCKOvH+MyHIqAM9wSrCnATRSm8YbhxN/dm/09cFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810045; c=relaxed/simple;
	bh=Z7hWQdAu+KJ7H84spsT1f+3n7+eUP8ugopAglG+TepI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aCj353mOeufjq/Yo6BzUAFHRKmiLdnWM2tP9y4l0zoO6Q3CbxZjwJt4U8AtaKMzpjciGYB0waV0bA+LeFzChbV8ZGUKJ4huXHkFboIrUnbuwHceItJGcrMm5ZxZ7ZbaHenRORZREq9lrOdobvi50hHGjuhNMICaOSfebvnPGUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb9bf4d07aso856094339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810043; x=1719414843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpFQjHwYFHXRSzZZsvlz8qRiQI0FX2xAT8CcSu6itGA=;
        b=SJ8iEVQssyt9YGFfcd9DmYTCxIb5eBjgTyWY0inMrpZgNaoVFhF3NQTPX9I3fmRcc5
         MRbVqThBmxqj/CLsbN84bpEqNSahfAyycCxUzXJbb3Dou4DRjoy3NnbQsROe4tQQGD6Y
         rXNoNI8w0MhEOfJtJ4lp+DmX+UcwAamBqxU105s/Hy7CEZd65fjz6HYu2BqLM+hUQYdb
         6tet9XjpKkfwdB2ZJ1FOL0Bi1WAVoHc4VoiY8B/2DNTh4baeJgCzDkIMrVlInjbWtp4M
         qmwSTA1kGMu9129lLKNWAh7WzsnrLu7QoHvUwTFLC7iMJQOuIQ/Dqa2TXd6eCh2b0E0i
         XbhA==
X-Gm-Message-State: AOJu0YyitCAppPZ5lSDUNTidwRPLkBwl2XDRDWGjOH+PAvwY2PaWsisg
	i3Jwh/GE1tzPa3uaQPxf+M3zh0cRVC14w6A1+3+wSOeDSwKlHSgJK/UZ+yT4dD7jlh97A9F9xHf
	f8Shr8UE6il/x7pxodpV0rOccacLhKLRDZ2v58C4nCHVi30UpNOfC8g8=
X-Google-Smtp-Source: AGHT+IFE4uUirvMetqokAPLA2ChjZtq04OVJ6C7OUh3vVTIsaX7lfJCk5zZHdR/5/JFSiE4denj9o3jlmMNJSm+HqtW2734jZLX3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841c:b0:4b9:7607:f7f8 with SMTP id
 8926c6da1cb9f-4b9abf79480mr85558173.3.1718810043179; Wed, 19 Jun 2024
 08:14:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 08:14:03 -0700
In-Reply-To: <PN2PR01MB4891B0B970F2651B49799F14FCCF2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f79f5061b3fa675@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in bpf_probe_read_kernel_str
From: syzbot <syzbot+a0fa177e13690b663c74@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a0fa177e13690b663c74@syzkaller.appspotmail.com

Tested on:

commit:         32019c65 x86/mm: Disallow vsyscall page read for copy_..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=146e310e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e23375d0c3afdc8
dashboard link: https://syzkaller.appspot.com/bug?extid=a0fa177e13690b663c74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

