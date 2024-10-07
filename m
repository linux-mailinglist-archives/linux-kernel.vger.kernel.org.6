Return-Path: <linux-kernel+bounces-353975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7249993576
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4833D1F253C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D111DDC01;
	Mon,  7 Oct 2024 17:56:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63911DDA2D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323764; cv=none; b=STwpQHdqcyV4RXOdA/A4pQ+jNc/ZnifQQd4cvyN/AqXXcOJzQmBqXbSGUekOiQMb05yMz4vEpWP0OfyppNh3Dr58eTtEYEdz4YrB024qP0pbzFBOFo3BelY816igA1x2BubhuOMZEQJf266sfcrbp3eSBzJj74zXZZwSAFFHBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323764; c=relaxed/simple;
	bh=1kXXgQ6pXFLsqmPCedpWDBpYPB0MB8bjAHTS0Z3nbXU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aeuurLtP6QitlM4gLLu9Vn8od6iKhuEFjCVJYWnYOq6s+z6279HSCYtuzfm6DQnE4jkSu3zO3s+jAoGRtsDCLElniWhQwigHNsq7DWOJF1QbG5JoJPPKcAF8mcXyRGnWDuGDsVp6V0zzVXbdMmafUfjrUgQ7NIDOdozZV6EXxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a364ab1eedso42152625ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323762; x=1728928562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPE2DlXlQgHtF9R1VoWf7KZY7YtyqN7X49j3CJzC6fk=;
        b=dFWtzgTU6bccI8B2FwCMHFp3FeTJHkXFBoM+Fajfotp0d7qyMZVe9XHAoxy9cwIUmo
         +3a+5W2iZqCz2cLmZPRaUo6fDUlPE+09b3p8G5AWsHUldWiIqnmtqm2XaG+go9awrBvo
         fwNY6zz/kb2dmjPKkBJSu1p4/B+/rRTyOxVc3Fx+CCI/Pu5DhFQ20gA8AmRxMD/7kyCV
         7HCn0ELEq5fKY+rIBHW3YfDbxcCul9StFPFkLXZKWM9HyppnEYsPZ5lGzgxH3oWtnlNp
         AZ6DOLFRYtgSEelW+YLr1ioq5Gfxla4t9+sKPaCn5kdn2Tc4wAgjuiyddZT6A7yjKkG0
         O+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWU/J8/FuE/RdGltN9tGDcBZdz5LuLQpnlywFKSlEbqXLmAgoI3QF7qw8x3FdPbhyaFDl8qgUPUCBcoo4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ihZUNkul7djoBJjX03ZiNOzqZ0eE5VWqWS2n1hrkinGXTILQ
	bt651ImYF7DjcO28eAONApQd5uxVABZ43U2bZmCPqUsqrexW7bUr7dO6plUws/1gx1wUK++a5xO
	Pp4Umi9YxYjrrZ2Gf/3RInmudNNexvMbxtS2f88rZDWcKVcsSxIINGZU=
X-Google-Smtp-Source: AGHT+IF9H447R8v+BBuaDt2xdDzaKWwWRKSLnQwhLFFn3CFWOf3XiPZWcCDVgpY6zJveMbhEXDU7Mc5XVBqA1K2iCj18ZVOXQ+bH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a375a978dbmr123384115ab.10.1728323761813; Mon, 07 Oct 2024
 10:56:01 -0700 (PDT)
Date: Mon, 07 Oct 2024 10:56:01 -0700
In-Reply-To: <66f7eee8.050a0220.4a974.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670420b1.050a0220.49194.0514.GAE@google.com>
Subject: Re: [syzbot] [mm?] [bluetooth?] INFO: rcu detected stall in vhci_release
From: syzbot <syzbot+46c3d1706c2d2688baba@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, edumazet@google.com, 
	kerneljasonxing@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132af79f980000
start commit:   abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172af79f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a8c36c5e2b56016
dashboard link: https://syzkaller.appspot.com/bug?extid=46c3d1706c2d2688baba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10564c80580000

Reported-by: syzbot+46c3d1706c2d2688baba@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

