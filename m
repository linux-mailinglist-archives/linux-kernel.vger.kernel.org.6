Return-Path: <linux-kernel+bounces-235155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773D91D0D3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808D5B21086
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769912DD8A;
	Sun, 30 Jun 2024 09:33:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D518282ED
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719739984; cv=none; b=tb5wxznZ9d4VgDjtmp5HenpfxWesapMShoeuKThK4kjMbg96G3ymMj//GzqIDwmg0NWiVzsIP0Njirbf4cBLlttzFu8VQbslh5/T/dsYEVTqkqcNZ6ueZMMUHn/1PVGmDuGvsSeWinVQX6aNgx8X9dLKo7WbevcuJsD4GZP5qF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719739984; c=relaxed/simple;
	bh=0IoZT0c3L7MF/qyJ3BuhcxrkqOfVnY8AHMCmsRUXlaU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FIJyXXmkP9ncYbRy6fvv/Dckj4zG/RMKgk6WMF7hAf9mP+pe+/oiadcmiMwmMbmK68JjGfaAFjwzJ7e1XCmn1yZYKnY8w2Rf96bNCidkuMHF5alF2AySgm5NaGm0MvUdtgDp3nNECN6p9HgQN9rYtuaUxT1Gf/tkgOIosqUyZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f6200ad270so221481239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 02:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719739982; x=1720344782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFm/9ZXsB9e8tSPAg8CmTIlEdCpRRuUoLvsONF6LjYE=;
        b=by0aI/u0icMq1UyYgis31++UotQE5pT+YE+/rrQrcgEDobb4ZWuA+pcD/Dfq3MloZj
         EJRijvVwP/PfxTXI1ftBCl9O1ZzVTst7kOu4oQzbu3qXuqrgsLJjNeMWk9sHj1QFfOE/
         23sI2+0eu7rBPe13u7udOsl9IB1sxIGFuRy7rr4+yHu4mSZ6yovZD7DI1N9k3f04ouzw
         0Ttp8bnD4dGOvqmvZdpvylTvC7TCb/qzTfEniE11Gu3KszHqxAbpnlpswRICcKYK05LK
         8IIkTYOTLXk3KMEOhM++O5LGo0Kgt7Qn0O/LmAjG9SzPUQL0VblerU/5BDnZs9ZTjIfC
         QRyA==
X-Forwarded-Encrypted: i=1; AJvYcCVssftyb0Gs5GrvghtflRIGLsJuuX6FHdVrKHjRQ68oUe62vtzyNCzqRHXVNBtbcs+rGtaFL7OIb6rNZwWgx8r96EdWW5CltJeyp9gp
X-Gm-Message-State: AOJu0YyQ/af1d+DSk8rifuGNaB2I8x0I6wjVtWdRPRnTpYlrJtelwSF0
	kQUrr4UHIrtA5Xz1vv/YKo3EdX+NTFUhOgTKXMwyq0OrCjyGJB4eMQUQao7zfhe5Dw5ldTWLZwR
	8RUlbjDcnN7pc3672SpO93cJYVYPkKirl9t/BkiISg0CzMGKcYwpcmEQ=
X-Google-Smtp-Source: AGHT+IFH/GwS0WaNuqfkdbbjEhmj1EPutKlDILbXsAS4ceNyPsRZ6BQh/1FAv56lWoxEiSjSvupEmtvbzIYke9/uneKyxiYI/zJM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc9:b0:7f3:d89c:6030 with SMTP id
 ca18e2360f4ac-7f62ee88d1dmr15325939f.4.1719739982595; Sun, 30 Jun 2024
 02:33:02 -0700 (PDT)
Date: Sun, 30 Jun 2024 02:33:02 -0700
In-Reply-To: <tencent_17CBBA43BB47335B9E931B5D4BD11B062508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4d507061c182a87@google.com>
Subject: Re: [syzbot] [ext4?] BUG: unable to handle kernel paging request in do_split
From: syzbot <syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com

Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16bb8761980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67463c0717b8d4ca
dashboard link: https://syzkaller.appspot.com/bug?extid=ae688d469e36fb5138d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10754c81980000

Note: testing is done by a robot and is best-effort only.

