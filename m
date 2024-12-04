Return-Path: <linux-kernel+bounces-432121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B39E457D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA3B284EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D81F5404;
	Wed,  4 Dec 2024 20:18:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0811F03D4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343485; cv=none; b=PmfIsuRTp94WhY0S1Mpfzz39f5rBVffw7yaRdPbbLSZFgI5L2ZKxW6jPbMIxWH/XsWg+eI0mvKPcGLKJyr9tnWeJdSniH8G3cvG0Wpko05Fi2TFwDaff23iDhI+fK9Rc6mh1SCZwUvl3NUUNfaLDYfOWvuSmr6kk+Fq9ALCn624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343485; c=relaxed/simple;
	bh=NNeyfjKy8ZGP7PYgviKBfqCS/QI22FJoxQGC4XnQdu0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m9D9rCzQ1NH3Q4uuYGK6PlujMoI8arXbznqp2W2aXdzSKgnso6XuG2Lou0CtZLYdrmLWqiu/V2RH7GKASpuK9zQvK75Db+QWeXkUA1CvG+Xs8KzJlWb9gCqFssUynDwabAo5Ja9FJ9Iz/TKt94bGdcBzUWEvGVgH0y4Xv9HuLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e1527971so1410115ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 12:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343483; x=1733948283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvYz/F16WGhbDx4cNvT6lI6TdEMFQnM9OQcYijyTMAI=;
        b=ZUcr9F5Tgsxp+ZlLHDJ9FzmoqVWsEF7j4qpYcesxo8U/pKd/nTPdv15bBJTt+KwSPk
         3V0G57nd4QeuAM4oIl+TcFLXkEy+MguxuhAbQ0nUS2b1ThiKRHrpOBvmCVce6wMjtkeY
         MndkFLJsLoFEAi6VtArzVe9CKkigYrn1J3jHu5wILt4O/o6l3oFV0difGerqD8u2KP1v
         DyLI/9RAIp48o+fVYXSdvZQe8KQHokrvHGNOOncPdctJVgqJs9QUfcsnI86815QfWHUn
         XAV5tpZ+LhqCiFEgrB99orotpzf48YJc8aFH27HEDssUi8Z9KESuUPKCyPgMvAUV08ga
         826w==
X-Forwarded-Encrypted: i=1; AJvYcCXHu52RoVpo3cvGcev8kzVGJktKlf04oqcCA7DGVI6MdzD+3B1pm9JDL3uFUc0sL94+Qd7SxUTRAQp/Wqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0TI90k4J1vqKSG0yQe5QejWwjj2I18XfZYgXYXHzDU0vYbFM
	bQ4GlFB63y1IL2C13W4hg+Bs5awzqQVzTStY47EozuoaPQ+85P19S88aBzOd2CcGo0gN18/6wy6
	quAvqrFD4Dtqaz6ffQUppxrxQ3G7/tVsXKRHXLTwrxTGApDA2uc+Q7zU=
X-Google-Smtp-Source: AGHT+IEhH0cr5PTn2QWjKnJaTq5+Nve/ysWwfEdZrM2AyUkDS34xX+n3rmiLxI7NpJNwWzFqTBe2/YDMHcnDgWJGHKQ6KXm6TTL+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:3a7:c5cb:8bf3 with SMTP id
 e9e14a558f8ab-3a7f9a3ba65mr102881145ab.9.1733343483592; Wed, 04 Dec 2024
 12:18:03 -0800 (PST)
Date: Wed, 04 Dec 2024 12:18:03 -0800
In-Reply-To: <67505f88.050a0220.17bd51.0069.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6750b8fb.050a0220.17bd51.0074.GAE@google.com>
Subject: Re: [syzbot] [mm] KASAN: null-ptr-deref Write in sys_io_uring_register
From: syzbot <syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asml.silence@gmail.com, axboe@kernel.dk, 
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, tamird@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d2e88c71bdb07f1e5ccffbcc80d747ccd6144b75
Author: Tamir Duberstein <tamird@gmail.com>
Date:   Tue Nov 12 19:25:37 2024 +0000

    xarray: extract helper from __xa_{insert,cmpxchg}

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17435fc0580000
start commit:   c245a7a79602 Add linux-next specific files for 20241203
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c35fc0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c35fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af3fe1d01b9e7b7
dashboard link: https://syzkaller.appspot.com/bug?extid=092bbab7da235a02a03a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a448df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cca330580000

Reported-by: syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com
Fixes: d2e88c71bdb0 ("xarray: extract helper from __xa_{insert,cmpxchg}")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

