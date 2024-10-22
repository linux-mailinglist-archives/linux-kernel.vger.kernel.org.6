Return-Path: <linux-kernel+bounces-376895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624F9AB729
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D483AB239F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F991CB50C;
	Tue, 22 Oct 2024 19:51:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200081AB6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626664; cv=none; b=mNmAwjWcFxPygLigwRmhRMaaYz1VotnHl2gd5iWHkRQQjSId5qcGMEqdxfknDDEJJHRjPsk0nf7bIm0sgEGMUI2wPpDk4f9FVHPFSq0Uv/Y91OHd5rEtI1F6n6v7koXUoRKP5OsfFgNURddmMCj+8iQRDNGAuOscHKrml7f0kF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626664; c=relaxed/simple;
	bh=sjKBGkepQUjrvlU2kiQ+Mr0w7TsVxlpRxeeYzwbHG28=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bn9+5PlcsByiIYIPBv7IONKNE8smmq0Dg/kLCWWOkBZbsfnEbB3ENUGMmc3GrL6tijPLDe54aOqepZ2p9YNe3dvy9dmFvhZn+DYLLlwrKfEVpRcHQBSVi4vcvudX6BDr/++Wa3tZgzwx6ftqHxtLFLS8HwQ966N9QmwF2PSvBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c9886eccso54123675ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729626662; x=1730231462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mphveMtRTgg7DkCZcVw8eEGpbXeUtfITv+Yo0YL4T2g=;
        b=oFwHG5/9LyqPaM0NW3U4Wy9sg1smjhde44hZ4RD7Xk+YIZgpuuoARbKD4RFePtozyi
         6nuhVR+haUxTFhoX6xr9NAZkjCJ+aF12h12jLGHUF13Y0Cau+8HvJhx8wBddLDwCz+mh
         gtz74yj/GjOkejDsOWQLbYjmvWGmfWOWfNANv5+nSM9OV+6/Cr5kjHN4hBbOobPgqY1v
         NMthlrDvQmJGhM0lZzK2RY5/BjBP3cKau91FH8LA485Y9Sm/86nSg2+ueMFoTWCs3sob
         fdfIVkwDS2w0tnDj9RCK31c4cS7kqQSk+M68U/9ShAh9ntng5HQ182dCI4/SHm4G0Axp
         3FMg==
X-Forwarded-Encrypted: i=1; AJvYcCVxR6bfshQS0ssNqtx67N3KVxw64CEeLaSbUTBFRlttgJR2kPi+xoLLqLPViJC8aQgZGnUdntO1F7+13hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3QjulGObF+/TUBvMLwqqUrQpbxjxEWrqcUJoae5/pIp3MFyz
	/wdNs9WTVj6m5o5ihw5RO4IGIqGkqNsp0nw9dtEmvqVCqq6vcEs8Kne4A8SGK8cjjv6uO18OWew
	qi/HYwDzRDqHKfaq1surMmMrJXy0YvMdvMNnJWdgH4ea2A4mdplTXp4w=
X-Google-Smtp-Source: AGHT+IEufu1zyaQDXbANIArKoVeb3LwjEWPRlP4EywrHHI6H0O3hBBzbROtbYsrqtHwf4aiB7PRgzCn5DjSCayLfUks1ABPDhrph
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cb:b0:3a3:9471:8967 with SMTP id
 e9e14a558f8ab-3a4d596027dmr2974095ab.11.1729626662566; Tue, 22 Oct 2024
 12:51:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:51:02 -0700
In-Reply-To: <CABBYNZJYtnHH1MjnNFdzfvu6jFOypL6iHjQ1Ujh8aYaycZzjFQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67180226.050a0220.1e4b4d.0078.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a34a5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=346c6d758171538d
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101c0c30580000

Note: testing is done by a robot and is best-effort only.

