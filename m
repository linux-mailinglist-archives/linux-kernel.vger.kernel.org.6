Return-Path: <linux-kernel+bounces-548508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF5A545C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB5316BFBA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D732080ED;
	Thu,  6 Mar 2025 09:04:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7F202C4D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251846; cv=none; b=hmJtKD0fVMTiYg6/c5oEbJTbi02w43ElYDmUJ56nQ3G8o0KxFAPFzhq+0+cxq4kh51dOnRKujfotYMZvm+YNO9vvGSUZ9TM7Uo5Tg4xkj+p32ckyRSFBgVSmaS6WH/xkT9VXppblR7eHkSoMKSqRCVOrgPnWNVfA0hIvfPWXCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251846; c=relaxed/simple;
	bh=ruAfKKuJv4D//haITjZ4loefKlVdbyEM29MI7QA1oWg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oViZGK1HNcOx33YVyw/bZKWBoBopg92SGXVIDWZPo+sQUdAu8fZDBLgmoxZ5rM6KoLKQA970nZ9mDvBoC3ZbXCUOFgIHGRgSf+9t+FULDN/BiIzMflpWsRJ0GkdpG70ydA2HDIc9uJQZzQDdpnWKr3eqGj3h8XOuL2eVl3ybrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d054d79dacso8483195ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251844; x=1741856644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PlUf2EDtc8+GWdOxIDmfUU+aGd5sbW4hhN7UakkYqw=;
        b=fOK8y+lJYTRqkmIjoJvkYqeQGlNj6BDN+4datFRy6aHhmY3JfOyffiXB9e2q/Aryyw
         DjjOHfWOty1W98nrWEf+pEZgOs+EO0iREjDS1Vup+mFWmFap2JuyFNom2LCBR+8Cvtbu
         2HrzIh/KU03qCy9mQ4tJF1K3AU7DhtVBu4oAf/RnSnKKIqZv5XNDbWLZiUwMuYKTtfoA
         x7BRszLXPilPZ8UxIM/p8eZtj8YsvBprl+kVeK7XKyQiHKbEBeI1puuuStzObqfSNpZP
         WAx/ooFVQmjq4TRr0nIRpivA7mhHuDcbk+1ly07yGd/3nUNe3KeVz6TX6m/0h/kvr/4I
         FB0g==
X-Forwarded-Encrypted: i=1; AJvYcCXi2Y+QujPzeTpoIPVogutOIlCmUoI4G4UX8QAgR2V0NfQv1/O/WL9xjSe9Wy7smR1HETtuxHLbuz8n75g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3V4eubPUHPcFmQIdUOF5eOfCV2RCWiOz2owLpk99O0bAkiwd
	OtJpKO9yEQFPC5QOyf2xgV0DnWhh10t9F0h1VtrNR7wdCZ44cO7QSBbODAfO1YpzDyakkrnQgKP
	tmzI52PnjoDj4KCCq4I1b61VdxZKcASm+MjzdWkq2ScXilcIyGVpm9rw=
X-Google-Smtp-Source: AGHT+IGTBLARltXQf7oengpyI6p3Xjnj/feG2ACDCutrMgIXebFL36ZwMXTWYi4jeppRR1zG6cu4U/sqPkb1QpRrtRzIkxgmvrIo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:b0:3d3:e09d:2a9f with SMTP id
 e9e14a558f8ab-3d42b891005mr83529435ab.8.1741251843985; Thu, 06 Mar 2025
 01:04:03 -0800 (PST)
Date: Thu, 06 Mar 2025 01:04:03 -0800
In-Reply-To: <67a11d8a.050a0220.163cdc.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c96503.050a0220.15b4b9.0030.GAE@google.com>
Subject: Re: [syzbot] [udf?] general protection fault in d_splice_alias
From: syzbot <syzbot+a9c0867e4d1dd0c7ab19@syzkaller.appspotmail.com>
To: amir73il@gmail.com, asmadeus@codewreck.org, brauner@kernel.org, 
	corbet@lwn.net, eadavis@qq.com, ericvh@kernel.org, jack@suse.com, 
	jack@suse.cz, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	mjguzik@gmail.com, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 902e09c8acde117b00369521f54df817a983d4ab
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Feb 3 21:16:09 2025 +0000

    fix braino in "9p: fix ->rename_sem exclusion"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d77078580000
start commit:   69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a6d4df5fcc342f
dashboard link: https://syzkaller.appspot.com/bug?extid=a9c0867e4d1dd0c7ab19
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125d0eb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a595f8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fix braino in "9p: fix ->rename_sem exclusion"

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

