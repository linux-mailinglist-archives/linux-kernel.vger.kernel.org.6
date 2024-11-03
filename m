Return-Path: <linux-kernel+bounces-393997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC19BA857
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2C11C20A24
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19318BC1D;
	Sun,  3 Nov 2024 21:34:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BE718870D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669644; cv=none; b=ZA/cPDSq66nREFkru3n2brinpUEIiSHwLfsolKPxFXpnVgQgT8PXQznzWYdEyuzpq8Wifly4l6l/5oOOy8q7LHnjmKJxnpTDrUdLK+WwTUf+G4BxVtCGSvDg2riyimjOU910BK7BOVyKvbVlN6Nxfidlmv/6bV65CrNeevDnOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669644; c=relaxed/simple;
	bh=blXg9xGpc16qfDm92tw9O/9aYjZ3AmVz0EK19h8E3Dc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kJCy1SsdxsWo5fTacBq3KE+YvKW6fTvcXFGUZTn3UejZsI6ejVDV6iyncJ7narUyNK/DS9T1K1N0u1xXMdEQmE3F2UdpclqSDBF3zET/RLfrpNWvk1/FVXy16cYt4H6jXVngdsnPWSP+iGLDB6FQMlYwULwEsNz5q+tG0hotSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c427e1b0so8515655ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669642; x=1731274442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgInUz7qNUZLdUgIRTKTAOglEAA5qwoze5+vT6Jq1YQ=;
        b=DvMd9h5s7idF3Wm7oMw4FQYkS9XnONHZm8LCKlwHcberI0U1caamdyCWtufJlRdwfG
         3uC+8Z2NfF2xbnT0HIPft2QS8PPRfPKF4d/brDre3wRi0sV3mXe+1Hdpr0UszkK9Yae3
         jp98W+h628LPKCytZtdnQOFQUz7+QmkdCHnXPPIjvkPXfH/Y5Sre/WCnA/xqp5ATfBcV
         oMkdvnGMaKAseWLVwcJCoV2kXdLnJfqHptbv7j7TsCI9MkT/o+9ZSbUKYwaWiRy7m8bp
         ln5o6yZo37EzCs/PgzP27zT1Wf03H7Glw0f3c4Fs8KIGvUCp2Gue7ETSfYbLx9R2wUJm
         sD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUthoGrvZ4+6QTFys1qYz/ie8THu4veUOm0U2Yjj6oUyZWs5Y9PpNlFPLTcdwFEO+lBb4um/6hmk6kAT74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkdn/AVrtm+SkQuXZwLT40scD64uYZrjU4vjQLpT8XkzsNBQg
	e8MuvgafhJPKS21QBrBk4z8zWiQngiJ1d1vwlsG/ezZX/wEJqbBBtgmHqHgcfypyO8BjncAkwsP
	gQcYmRXbPcWPslUlWxQbf8PBoLYqL7rQa+7hEiTWJrKMkqw3zkEkFIzk=
X-Google-Smtp-Source: AGHT+IFHEMRou1rYHekLU0t1vroRMTKrxb/yKIFNxce8uo+T1r+WKfYT0UL6Y7ouEB8+jCKM9EGjomfeCFpfrcwG6Ig0Mfj72el9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cbc7:0:b0:3a6:a9d6:e427 with SMTP id
 e9e14a558f8ab-3a6aff50f1cmr75215455ab.9.1730669642025; Sun, 03 Nov 2024
 13:34:02 -0800 (PST)
Date: Sun, 03 Nov 2024 13:34:02 -0800
In-Reply-To: <CAGiJo8RPmkhKpg1qM3ucba99Gz66AHor6H4etkD0WB8GQOkKAQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727ec4a.050a0220.35b515.01a5.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in move_addr_to_user (7)
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Tested-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com

Tested on:

commit:         a8cc7432 Merge tag 'mm-hotfixes-stable-2024-11-03-10-5..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1047b630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c11ea7cf15419ce
dashboard link: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16068740580000

Note: testing is done by a robot and is best-effort only.

