Return-Path: <linux-kernel+bounces-268410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6894245A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87FA285DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD2110940;
	Wed, 31 Jul 2024 02:00:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89451DDAB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391205; cv=none; b=HobHzk+Oj0bIp4nS3GEN/JMosMREnKShsLa5wmRCtstvRoSyIXcd6vapLR3KQVBLipTwN8spYxYpMVUGvGKAXjktCIq8ZFMj1I+B1MX3TsZd6GUuYG0LF5eaJkFZKKCVuSJ0RiZSjnZhEEzIJvSCq9eNvrBCfo0XtLeRiPTijgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391205; c=relaxed/simple;
	bh=K1qOC5tHUaMsNZMC1TjMJaYf6RAeKSo/0m0qrGDii54=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ghf2jZAc20j7QtP6QU2yXYwTqENrl4i/8kxNA/VKMqFffLcF2PvL9saE7CZfspv0I9TthLydgXXydjfl2ufAA+0l1MKE2EwsMgLZXUnLKpgrt3Me5xUCoNzWcappMqJCZG1a9jSQ/RSDoPibwpjxTaptpiqTcAsKRmH+zkiUi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a1f627b3dso86552495ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722391203; x=1722996003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oifXDfDa4Pc0Sdv5gbrkS91BTKOjBFXuRwSI5Vt+woE=;
        b=E8i9PyWGUAih4E6rkjZGzbmvZWnzRFaVuB7ioHaESi3AvfCFihIoMNlraW0Lm98d36
         yv4vbkgaOXSD/ZpfMHu5ZD6kR7s/8j7hGG6ewTtk/PXuPBJuhBSIw+fXGZ+Gm3izjkz6
         gEOx4CW22aea2e1nqXPYa/tnRjpicQCWmVKwwcnMRbvVM362vpEPBeOYrUqRBANeyRh5
         iXgwQjJNFJt9SYpWaGwDhDbt6/tnrBIE1g8bs8UHH/2UfqSqUAL5WB1JX2qwtEQaJDni
         mbL++BwSGwdo9/j3tKDFf+WhH/uwshbqOxiuRd7f4e/g9f7XSmk7fVa7Xv6XShNV9xAC
         G5nw==
X-Forwarded-Encrypted: i=1; AJvYcCVyOF3UryQTAJTtHlmsRARgkKqyh048+9AqYgitZPZTN/xpCA/vtO0iTEYClwP5HorqN9D92Sy/ZnvuANZ30BM60ha3O5jnIiNYrWsG
X-Gm-Message-State: AOJu0Yzo9u9ug9ds3lg+Uk1Czeq4HT+tiI6nzrlAP5aSKgOdn5yucbOw
	jxQNLzz0dH3HljryRcOx/B+9n7wTiDLdCVixzLj8qqNn0gGXxltCzq5+7CeQGOq14tBgWjyfLsX
	1/gcWAJkBXqbrM1l8xlyVWBF//OKoYbuTtYnzTLawAGk/X+5ww0oERJs=
X-Google-Smtp-Source: AGHT+IEc9c926Yi+AT5PgUKRiu91sAVFQJ4tCQhhgGVLxxVCE3cfKmVkDEp3A00yLNByqBX3a4esm6+HSw2f3lbDf8KogXFJ5U+M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39aec448e1cmr10502905ab.6.1722391203729; Tue, 30 Jul 2024
 19:00:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 19:00:03 -0700
In-Reply-To: <0000000000005dc7ce0611833268@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dce735061e8173dc@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una
From: syzbot <syzbot+5b3e7c7a0b77f0c03b0d@syzkaller.appspotmail.com>
To: cpaasch@apple.com, davem@davemloft.net, edumazet@google.com, 
	geliang.tang@linux.dev, geliang@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb7a0d334894206ae35f023a82cad5a290fd7386
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon Apr 29 18:00:31 2024 +0000

    mptcp: ensure snd_nxt is properly initialized on connect

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c8bdbd980000
start commit:   4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=5b3e7c7a0b77f0c03b0d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc9c8a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d0cc1c180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mptcp: ensure snd_nxt is properly initialized on connect

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

