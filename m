Return-Path: <linux-kernel+bounces-446237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A909F2191
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 01:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E86166106
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E4A23;
	Sun, 15 Dec 2024 00:07:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E94193
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734221226; cv=none; b=jv/zUlQqwtkw6OLeqxjT2n7xw/m8ebMrYoRGihKEQPXDt0Vem/Oq3EO7zp1dFcY3VaSs/98FxiTKgTne4C6GXnt7ukSa4PMgRLhReNAWAZ8vgyvwtC30nA19iJRLjeEUia86mC/5zdShxPbu87e02568weEmmtAwhfX8vVKZaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734221226; c=relaxed/simple;
	bh=uZZrthGLZNzK5Oh4plmT0/IPq/4yxm3rkQ18bMATI9I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GF6Mgme36N5k/QNekFal+DSKWCRozjpX9MtjQP9OVO9yalmg/C4eDcButHmb9yMN/lzVGvkPkdJ/3aaVTW6t6CciJrEPo5cA21NzGN57SqKYHINW7AfPjRnUR0/P4zhrnZLQNDVv3PgYo+SOaNW1Lroqn/tfPrxTLtSVRBIEwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a815ab079cso61587815ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734221224; x=1734826024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGiUyga2mg5JNSlHrY8MMllNvV4UweqJDAG74MooPro=;
        b=BUrALQvYtaHml6R22F0slpTQQmNJZaG2l5arGkqfbbH9XsXiqA2UBwcjXIub88IYEA
         H26fHhvo+QTkzl4Gi2chlHtXQdOh4N3D6zbe5kj+i6Ohe1mjxYWMZczVKuvoaMFAWTy+
         iIG+6VAM+YczwqE62gUznOXlHV6ZIbbxVO+gdYbMtmH5EcW39RYw3s3pG2DhSkerUAJh
         b8cl+TVx7PeoyAFHFI6SfihZiOpLgk8/BK5U3VrtfwGtnkcwA6peVaENV6f1OuhKwn7z
         3LAHJ3XaI+vFWrR1BEzAuljPRgTpfvp6fHsLiHnMGr5El+fEWpneShlYSXk8KQ6p8iEf
         mZPQ==
X-Gm-Message-State: AOJu0YxZf4UAIURJvtryMYbwYOl0dViZ0OyAlMuK74dYTbDIG3kXPZ35
	WRn9DaflP7U1ZcxCkc5bS1YhwPTLZ6/BTywYAmWXrnQ1z+2cCHUCYGkItuAV687tC800+Coh3ah
	pAfT+31b3yQ1gIGdwI8OGQGtFe//vXLs4VHBM3wLB0qwO9EVm6HimNqk=
X-Google-Smtp-Source: AGHT+IHT6gZ1V0b5cimCxa9DxhuiHEUMdJ8edBQc0J32LkmZIRC0FG0Bfqi3JY3SQWkhLCICsjYo1luItm6xYfXMQ6e4tlPlAY9R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3042:b0:3a7:8720:9e9f with SMTP id
 e9e14a558f8ab-3aff4619d10mr81437765ab.2.1734221224070; Sat, 14 Dec 2024
 16:07:04 -0800 (PST)
Date: Sat, 14 Dec 2024 16:07:04 -0800
In-Reply-To: <D6BRRF7DFZ1I.MUKMVCYMW0T5@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e1da8.050a0220.37aaf.00de.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KMSAN: uninit-value in ip6table_mangle_hook (3)
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Tested-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com

Tested on:

commit:         a0e3919a Merge tag 'usb-6.13-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c84344580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f52f17eef5016d2
dashboard link: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1063a730580000

Note: testing is done by a robot and is best-effort only.

