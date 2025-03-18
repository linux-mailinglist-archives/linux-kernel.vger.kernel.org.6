Return-Path: <linux-kernel+bounces-565868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E59A6704A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04A23B60C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371CC2045BF;
	Tue, 18 Mar 2025 09:51:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AA204C2A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291469; cv=none; b=JP8+K6NacrwLHcNj7xxYpmh1YZdHPsqYyuKGbiyVbuQhzzPLuFQBZrsyWcFyJiF3wb2RWyqaMfAlcjnv+CJ3hI7SiZKQ1dvBzULYQitzznnru0RtJnwvvwwIl5qdFoP63GGgSifK5TIqrafmWaxLQx20dZbuwFiku6P+WqfkWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291469; c=relaxed/simple;
	bh=NjDeiUFkUdLnYKBjXu9i7Iq+VQqvTIy/xfEHD7UxqOg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pX/lJLY2OXRw0KTrF4tQckXLBRpie2t0cOYJPy2JjPYnSKaVR4uA+q2r040m4ySfP1xTsZBGD+Gg1iY4/qUkaAncCh1hT7NfQSeCxDDt/e+7Ms/lBiDTWRdG8lJdurPVrz6QA9jetopLB0JLmrVwceCOwMeYIOgLSBkBV94SN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d44b221f0dso105468465ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291463; x=1742896263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc6rJ5rZqC0CfnAdWBjB60YGqaOUyEo9rxFas/xm5vw=;
        b=UHE678AnVl8tP/BrCMynPqEamjMX/nw8KUe1xmTW3WSp3nBZ/wWA+IJ1ux34oakQzb
         oESGoM607d9WXeTiozvvN+2tAKCd+lx5tQxheVWLskp5X5F/ic0RmVw/ZZBX9gserXKW
         cLUQAHInnwVok0tp8NwesBOmz2ebo4l08C1oCaN0vmwg5w9+Hv94/nNMIM3H6tQoSWPw
         27mu2KqGpLgWF6BfZrGfyGuucJoPaiREw/qEgoNCVAOq/bOqjFplU5RSZsO263u0mlSC
         udxfIQnQtfs1coLovjuJ9PzJ/APi3sGQHyduQbkm2Dbg/sMAJAh7kR0BhFyVbULSnybz
         zyGA==
X-Forwarded-Encrypted: i=1; AJvYcCXc/j8qr9sePSuorVcs5cIXYP+Jwy9lKf73BTlguhCld9OKEtK5hmXrAJwW0cfYiBv5BEJ8DjjyeTsktk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2h+kB5pQH7LmFjPvNiu67Fwhwbeutt6ujiLYCVxBrIwhQQJt
	wB4XCWgnOr8Y63gb+1j+ywg8zY+9WaSQG4Z+zgJ8AS/z5yecdaEHsop42zprOE4E+2UtrnspRKE
	LNdWZYgJgVN5lxKyNrXy99lgKptPU1QCB0IVobs6S8e+EDj+4kXbjt3A=
X-Google-Smtp-Source: AGHT+IGJQoXReMe2kujDe9yYeMt7pksQigj8HMvUj0V/wuWwWxAPLARxPQRds2keze5ScvaMtdVd4z2W5mZSiNgvW2aGwAlRKf4R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0f:b0:3d4:3ef4:d4d9 with SMTP id
 e9e14a558f8ab-3d483a70a1bmr148606935ab.14.1742291463781; Tue, 18 Mar 2025
 02:51:03 -0700 (PDT)
Date: Tue, 18 Mar 2025 02:51:03 -0700
In-Reply-To: <tencent_DE79B66C942EF56F989538EA7EEC32CD3C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d94207.050a0220.2ca2c6.016f.GAE@google.com>
Subject: Re: [syzbot] [afs?] general protection fault in afs_atcell_get_link
From: syzbot <syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
Tested-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com

Tested on:

commit:         76b6905c Merge tag 'mm-hotfixes-stable-2025-03-17-20-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1188f278580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=76a6f18e3af82e84f264
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173145e4580000

Note: testing is done by a robot and is best-effort only.

