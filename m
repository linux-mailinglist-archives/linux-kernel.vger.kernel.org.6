Return-Path: <linux-kernel+bounces-176970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7BA8C37E8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C976B20BDA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59D4F895;
	Sun, 12 May 2024 18:21:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03BA17753
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715538093; cv=none; b=sB0Quc+TKrqI2O3UpdtEe0UxJZJxXwASWOKaucYW25+ZldqsgWjp9dEOEB9BZBZlxS4UeLQqpq9+3/JXtB9YuMOJ2mz2yXHLEelaTpfumVl2tNG0XGh1pZc0BbxpDmY3t1W9hlGEQJaoqDr/UijziwfsO4fxfoz205TfGFrCS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715538093; c=relaxed/simple;
	bh=Z1dxgRSgSw21sFEoRbnEzMBi4lV5wK4arJNzpkqlIzw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cliDI798z2dhVYh2VqVsmWD6gFKBvDpuG22KEL0zJ42VbzsY9DsXR9sR2PIlP8+Zsu4ClbYcZHEV+9d5D2oXLGBVPxLQk9bPfdmcqroScQTuhKgA99Sw61bhv31SX765RumI0YbVskGQqhVsKXRZfHdIvsnVnaJ41lDU/runBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ddf0219685so483514339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 11:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715538091; x=1716142891;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zg/i1Uh9jeuvq6DXh2wIiCSBD3oLjlDX5rdLNSH0cxQ=;
        b=hn9fOdhx8zW+MHDa84bPgXxGCCy8Yd4GEV82nuFVL9L5XZhZ9dlFFR84o4V8AHSdI/
         ZmFn65lMzhoLKZcJBuQt0qOgkYK1GLvRpjZPaqLLrL4DNFhen1uBKpvuD1ohxQuxBBjf
         ZMkVloq8RhWTt6oBKLoFBNwC+MxE8HgMjkvi0COAgChP8I5U7dMV3Kj1tQDYnNTJYMKy
         hmROYQbxNu4QXvTCkIwn3jxvTjMjFKmxdYztSAc34UasKem4DMGTNbWDf51905HBuQx5
         j/YDQABOZVIzYCgnW3jhJqseQGx1eh3aH90wwL6fH6Pu449eZM1LV+EfY/OVtTjc2Wfj
         vSQA==
X-Forwarded-Encrypted: i=1; AJvYcCVe14yDZw/zS6ZUZO2aoYEorCkMdMkF2vxYbY4GMTrue3W3+myrtQfIzoZzlTj/j9P7RvHznl2Zs7B+DRU1xbPv6mcgFXFU1SVkWuNL
X-Gm-Message-State: AOJu0YwfWl4peRV1Yz48wg6YiHJtGkSy24IgAFU5Jdou7WqCwE0Ud1l/
	mhFisavy96FPePJkQzjz1uNQFUBycWHYChNakHgPwSEmj+iNIX2+5J05fUCGSx1lprD79k7cbbo
	AOFkvGDp4JhEtd3jyJBtGZLcCw6dXCUTz8iJ+fLzW4ESH2/+8LSPWpCg=
X-Google-Smtp-Source: AGHT+IHsL1W9S4OvdtjQYMqpLCP+hp93w6/7dpuf5KgxIqO4Sy7RdAl+hsGw6avC6dI4fgAEcyCtiv4XtykLSBlq6di0b6xI7B/1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8427:b0:488:7838:5aba with SMTP id
 8926c6da1cb9f-4895868b41amr725485173.2.1715538091293; Sun, 12 May 2024
 11:21:31 -0700 (PDT)
Date: Sun, 12 May 2024 11:21:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087c944061845d62e@google.com>
Subject: [syzbot] Monthly bpf report (May 2024)
From: syzbot <syzbot+lista9d8cacda29a45932ea0@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 13 new issues were detected and 2 were fixed.
In total, 44 issues are still open and 238 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  52469   Yes   possible deadlock in console_flush_all (2)
                   https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2>  15516   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<3>  8620    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<4>  6553    Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<5>  1615    Yes   WARNING in skb_ensure_writable
                   https://syzkaller.appspot.com/bug?extid=0c4150bff9fff3bf023c
<6>  496     Yes   possible deadlock in sock_map_delete_elem
                   https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
<7>  241     Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<8>  224     No    KASAN: slab-use-after-free Read in htab_map_alloc (2)
                   https://syzkaller.appspot.com/bug?extid=061f58eec3bde7ee8ffa
<9>  137     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<10> 107     Yes   WARNING in sock_map_close
                   https://syzkaller.appspot.com/bug?extid=07a2e4a1a57118ef7355

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

