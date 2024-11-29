Return-Path: <linux-kernel+bounces-425263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C122B9DBF98
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6177EB21241
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581515853B;
	Fri, 29 Nov 2024 07:00:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD36155A59
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732863605; cv=none; b=jKUQ9sicJuZMlrj+42P267Gqw3He8J3jxBbotvl/l39Z3roDgF/2dyqsWGf1NiKua3ESafMjym7xN1GSj3lR7+ToiTA9I7EbLMttAZPMt3fR+7bmubp/tRsLHwpUWAvC3txbhphXcHPZisDQZ3T1lCLMummqnOP26deHvNp9Auk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732863605; c=relaxed/simple;
	bh=OTnsXcTFOSk4pX6ATOXr/FBbB1ZGPiO0Bg7kRdMMFOk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SajYO9hBLWRrpTN/pHDXtqEDk/AVreJLBM9pRFxtYZ1EMWUdaq0zu5AqWQmce7BzS4o8tjTkFBztDKvWrGmhccEQpKK4Vi4XCa/nqJfx8/L3fiyC8Gwt8s161wWsezb1xc34+3bxH7/mgNiICUqJzEZplLxFgWOci830HSGuoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a787d32003so14926285ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 23:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732863603; x=1733468403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uFra0YN+yna+dFAYGRTHBlUgOuZ/rd2jDdrEmkswmo=;
        b=k7/Z1ePHdrxuojUAEcTqLqD6OWDZo3xPvPoqNCUSISV5XI2XbJ1MTcr965OdJSQxit
         oM3oy491h0nHE4GwTuQTTNb/tEn34QWFU4IQ34P+5SZpFKf3pGrEqePZLyH8HvLh2fv0
         s8Lqej0ZtaikOqP6RJss3LAAFafKLQOs6Fm2JW4OYuzCqWbdQBCB0DzWNLOHyL3Ny/w+
         tNzkakNirX4vEHTF8WLhkCXFm+DWI87+6u2D2YTTEHdMOWpNF54Eldanvo9lekBFKUmT
         l0iDiMgCsX3KT9/ShhAbp0rBVSIvm3YCThgejhkDWjHzQGnAUe9E6Y0y8I1IF4ydRrP7
         a/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+M3YzaOvbt2WgbOwYVIMYALXTnTya1xI4phhkaVWVDDJTSt/R0jmK3MU2CAAIBW0VlKyBiC3DC2mMD80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76p8WIpnsdc63BPrl3DD4pUW1DHxYVKsRhkX4uv7nIl1+Hlt5
	UsDkyzM9IRQ/Z4FiFCmM27+UaqQbvYnyExLEZpq+8gUmUq7KWC2sIWEvCR5MIG4bTVQbosV7Ebv
	ATlEEm8nAThXeucdRuldFoTUGuD0urwmXKIIM0Ku/g1PZ+7NPkM/+Bp0=
X-Google-Smtp-Source: AGHT+IFdiUwM6usNyDCkLi/if2XisD6w3B0PUJMgYfQwjzXBmtMFTye+l/jlLwYTFAMwLA9+B7LxNQeBaYvKgU653zSV2doKUl21
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3a7c55d49dcmr113095305ab.18.1732863603171; Thu, 28 Nov 2024
 23:00:03 -0800 (PST)
Date: Thu, 28 Nov 2024 23:00:03 -0800
In-Reply-To: <67475f25.050a0220.253251.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67496673.050a0220.253251.00a4.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_do
From: syzbot <syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Thu Oct 24 17:18:08 2024 +0000

    fuse: convert direct io to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1648df5f980000
start commit:   445d9f05fa14 Merge tag 'nfsd-6.13' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1548df5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1148df5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c44a32edb32752c
dashboard link: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fd43c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cf2f5f980000

Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

