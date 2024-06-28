Return-Path: <linux-kernel+bounces-234377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C387891C5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFD11C217D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E41CD5D3;
	Fri, 28 Jun 2024 18:38:24 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B41CD5B1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599903; cv=none; b=eCBs0AownkjSRpg2FJJ3rsD9olzvtq1Z202SzR1bO6UZoD0MzfN5u5EAKwXYqUZi5F2g5JnrFxqN3wjobuQ4Szay0cLOYiNV/zDWqxwCHp0Rzijm96CTAzsIOlO1ewluvSmtVNzJFXNxs3FcrCVTShhowT2fhrHUq+k1BQvVMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599903; c=relaxed/simple;
	bh=WAgvqGSSMUhPpGWuEaYRvYoyRrVFQyKjhyHF8lm3m3s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b/xjaEzCN7lHf+nm0xX9XND5DW7ajKrq7o+Qqqo4Ui9oIiemSg47bDD27rdslO6D13RBzvp/7e20HS6eIAMn0PguWb2tl4L4nzkgRTCzyUOf5qjSABItOeNlMellaPoiMZ8oIzy8xLx7nz+FdtORUeTfZkGc6TSZGEKrGHjr/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-376229f07a8so10477965ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599902; x=1720204702;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAQwFq9UPZbXFZDZdCFdcQuDs/7IHMkcXpTnMEOHaSI=;
        b=cz0obAuqGnFi3UioCLzVZamyz6GkUd86Jt3lOgQMpBgyW3bPjAcw/Z1wsN05Fk9+Vo
         ot9PG2jJNLQTzkm6WXLJFP/7h8WICzk3hBUtYTLxvNh35wC6rVkzWx47zjSnzHANJpg7
         oav9gL93Lz/v5hDfzROtM5BurO089L2rFlL59DOVGDctbE57V52JzGbV+paXq/rrtSUa
         irxjLLSBg/xhxE1rBndCsT/QL8sQlY1u+HSYFheVtyAFT5/3xpJjwyMHwl71dA4oGNcj
         CmS+V4fja34yHqtGW79tsNd48iKxfmhr5guEwdsNMnZCq9Z1cfTQzvddFz5eEEGp6muI
         BISQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9TlgDa/RpA8O5vC6QcxJNnUJjlF4XqynSU47FDNHtMXZ9w74h03hrh2W/CPeSz+fQWdUeHEyPuv+/MGQ96t7xqJlLnJepVb0ucG/M
X-Gm-Message-State: AOJu0YxLVZYVGoelqIGN8InQuEFU+fF36mHQe0lEJkFgcyHNxo8xw8Hf
	z0U8A5CksN4Nfgg9Ft/NiwVCL3nf+NAMDGsjQfbrk8zG0sAsArB8Tzq6fBpYHTOqo/RE6mtXxfY
	z/SnIuofQW0rAMuIoAd3hyLUCezGf5jyMFuSgIGfGWTnpSYmRWUpi6uI=
X-Google-Smtp-Source: AGHT+IFyojeDoOQfAz+WpFDP13ym2ekViaAZ2Ap6ROc1rvqVHqXy6e4NW0dc11phb0kwVSPqpMSaRAWLrRTi/u2q8ChreueD8oNh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168a:b0:375:ae47:ba62 with SMTP id
 e9e14a558f8ab-3763f5c900emr15343485ab.1.1719599901745; Fri, 28 Jun 2024
 11:38:21 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:38:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cb7a6061bf78daf@google.com>
Subject: [syzbot] [netfilter?] bpf test error: WARNING: suspicious RCU usage
 in corrupted
From: syzbot <syzbot+784a3db26e5409459be4@syzkaller.appspotmail.com>
To: ast@kernel.org, coreteam@netfilter.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, kadlec@netfilter.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7e9f79428372 xdp: Remove WARN() from __xdp_reg_mem_model()
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=16956dea980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1437ab35b9d90e65
dashboard link: https://syzkaller.appspot.com/bug?extid=784a3db26e5409459be4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca96920a98d8/disk-7e9f7942.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24f81a5f5d0b/vmlinux-7e9f7942.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31b888945299/bzImage-7e9f7942.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+784a3db26e5409459be4@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.10.0-rc3-syzkaller-00138-g7e9f79428372 #0 Not tainted
-----------------------------
net/netfilter/ipset/ip_set_core.c:1200 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

