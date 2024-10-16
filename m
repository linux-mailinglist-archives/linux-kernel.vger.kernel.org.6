Return-Path: <linux-kernel+bounces-367919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5F9A0866
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0860A286521
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979920607F;
	Wed, 16 Oct 2024 11:32:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1718C33F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078324; cv=none; b=RnliMlcyD3KX/XN9d8tgnX2Xxo0/RmPfOz1z5/955dGkIjOm89HGHERgUkvuyMWx7wdiqeAxmrB8y/i5m2GomZct8CR6eHC9HEPwUR4kpG73KrYDyE39CJnGUZASU0jTfs39SsWJzawilHmiGtPZyVRESZZetgNzMVuAdtcvASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078324; c=relaxed/simple;
	bh=fcC8xvGyh3niNvSrIbnwX8I1nHh6g1RQ82pVzCKwcVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aHsfYpjkX71tjTNuGvjy9Qppoy7yX++T5oWVKrkbXHllli7ItUqyeeq/boVoPXfkXM7SnRNhuiyzWLFx9cL5lvEgW08XFq80xcMSPB/iS4Hm/Wt3g4MyTnHXBmHhFi29TCAHkmqPeq+EEgiD367fkEmMUn/EL7SVCImf6AzNEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83a98ea8e2aso71524239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729078322; x=1729683122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvJYFCud4jXaKKQLAMqtZmQNzk/JP+RehKfMmFrCkLI=;
        b=FrOFp1wqbowa6LoD9L8kkYk1UG2DVp8jsxtalDIo2ckl3YWDMnoWrA/utsTQZT0Rls
         jro2U+n54h7dYJCKUIzO5IhoS+lQoeqDZb3PSSW5GUbwrd97NGmwhfliwwF9HTC2DaO/
         lrj8QgMIf0RRqJYNv1H4E0E24CvFRilJuAxBh84feJvA5F56FJVVAcjwsQxEVGjScV27
         V6e+C4Y9p4Ej79PAbFRKI71I7WEfdvqyYDDgY7AsqoJXoTtuFVOmghEAlyxjLRTP6wID
         OjX0PhaMmQQahqmKJ7LNRHgw7ds5fA6YfNyAEVH3Vx4nfPnUK4EHZJdwHm3kl9RPw67W
         Enlw==
X-Forwarded-Encrypted: i=1; AJvYcCXHxJe1CxFYqss2nCWEnF6d/KMkdngc2uYF9vUM8N6Oh9rAG3a5nk0pv5gqDzUb/mEDcdjqaX4lTZEQpGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmF6SEqjh613QqLOUuG4gvM3YGwnK4fWZm+izD4lwKq6yA6Dh2
	fFQSk8ClZ8IAzQaXtBdgGBO1OzvHuYiAtJhn5TkQ3Qqn4go3vfGa0x1l980ndJkgYMP2MvxDAbT
	VjUqSy919Y/gsJpXUN/dD8tszQnRYq4R8fox/Jen75HLaqBZ7Lu0nUO8=
X-Google-Smtp-Source: AGHT+IGGm/As1zjwdwhQUUkUDog7/KBQ+G6/MT9zO8Pqkj7Vlx73yXeIrOJ1u5naBk3JwOBfknv9y4Z+/p/lmgZRBpFrgzO9eHaH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:3a0:8eb3:5154 with SMTP id
 e9e14a558f8ab-3a3b5f1e1a9mr168808175ab.4.1729078322583; Wed, 16 Oct 2024
 04:32:02 -0700 (PDT)
Date: Wed, 16 Oct 2024 04:32:02 -0700
In-Reply-To: <ddcf93e3-df0d-442c-a490-f6607f313fe3@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670fa432.050a0220.d9b66.0167.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in mi_read
From: syzbot <syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com
Tested-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com

Tested on:

commit:         2f87d091 Merge tag 'trace-ringbuffer-v6.12-rc3' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e1945f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

