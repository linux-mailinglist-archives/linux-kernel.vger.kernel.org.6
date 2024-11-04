Return-Path: <linux-kernel+bounces-394107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32169BAAA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E931F210CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727321632CF;
	Mon,  4 Nov 2024 01:56:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B77F3214
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685365; cv=none; b=MJjlvHMTpydUh4NxEY8BfrViAK1T+XpDnO8hWXGA9sCVcwS+7tPPtQ/k+4n8cFKI6JMANzVOH4rUzP0onSxoTxTFsG87iaZ8EtHoUzoUCWaRS5PLd7kQUkz57puN4DPvbwb+WRAque7o0IetG7dUfKkAVtY1NPOqZLEgpn/JLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685365; c=relaxed/simple;
	bh=LgWScZ8vi4mYIge2r6YS520vHhCGF7Tdgn4xyr89GDI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mzwFSRKVsnx0IlbWTyHy1IxUKWgeK2AjNDfu1o3gt8P6mqtZx2tvwpYovy0s544yvnF+zVOKqoJSTI16BQNkkZB7YOCOdWMntNOOCTX7wrLTOHEVUzDjDtUgadk8UbP7r+GgZDYsESy9QKpXGSYMNoOEFjn5yBrWLTHf9NWTbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b7974696so21872065ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 17:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730685363; x=1731290163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QBo4Ps22SljwE9WLuUl7wap+qWl1oPiHeQAgIKD1+o=;
        b=QRJnf1yTQnS+NpH2Gb2UkRrk8959/FNBhpLFLPKbhVjtK92vvdFH6lFnUozgmSkshO
         LWTMPPRhZS63BhSAzQnySvp99KX27xvBi0FZ2kXdAeykP+QtEuM1tUMxLA9KVHA1DqpD
         Wf2hH0z1tTO5oS9cLb+f2/fPPkGzpvSCVQieIwWoUV+zW4umjkkT9Z6hZHeDgC9uS5Rf
         gWNfrHibh1pzsS3sMeS6/AhHFNYt5AT9A6bh2/ns+gDrMPsiCEAD5QlBptJKv/GwR3hg
         SitDYI8eCQ+CrSomJRqB0FQXCHpue3KNb8PGYI0mhqvncLJl8NQ0+dbIuvS+G9rZART+
         V5CA==
X-Forwarded-Encrypted: i=1; AJvYcCX1pfvgRXO/rs2qD0Ru9WVmru06/qJpZCNsj97NtFRBt+pnqzuW2KwKe7WLHV4lOA5C6TwGqApqMkHvKpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv22TU/9MVL8BvmeqmTVvwX4YaOg40v2kqyFiFK4KmdIGegIgP
	cBw8v1pgQptVeFHWHS6nOlcqdorWLiNf3oBzWbD/5DwliS/X/OPfvlWZj7wzn2hWlNXHlUzS1+6
	zzXc2iuyKxXNambRICll0bR1fq9ELC2fjDXG0Pvam5As8/lAUDcVleeA=
X-Google-Smtp-Source: AGHT+IFSXqYhyKTjlCVZsuUDtm8eJoN+X8QF6bMX5/KbzOkqgwuEE/r1u5wZ5zSxOchdFagGlxUS21uBScoAF4wUE+4MTHUSNrkv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a6b031a257mr105648955ab.16.1730685362826; Sun, 03 Nov 2024
 17:56:02 -0800 (PST)
Date: Sun, 03 Nov 2024 17:56:02 -0800
In-Reply-To: <20241104013708.3134548-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672829b2.050a0220.3c8d68.0ad2.GAE@google.com>
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_do_readpage
From: syzbot <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com

Tested on:

commit:         59b723cd Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15127630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=0b1279812c46e48bb0c1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10827630580000

Note: testing is done by a robot and is best-effort only.

