Return-Path: <linux-kernel+bounces-174002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB58C08FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84B71F21A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B613C3D0;
	Thu,  9 May 2024 01:17:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699513A3EE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217425; cv=none; b=CjUg+pU8DLVHzrdZIalUoXNa216czcciwWIGzZLA3mXp1tpTAtFqfp7V2J/Sf/YTL1eguJlYuG+Esv7iZel5nGkW81WBeJ4YMJy/Y6G5cuZk/USElTLkDuxET/f3SJ8kEi9d27gCuTXQQNnwOeOszPo4fiUabBAzg7pFGEDsDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217425; c=relaxed/simple;
	bh=ghu4iV7dxEKHYr5FUcqTWc2WoZ7gzqCQuUFJNEIke7c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TSeNISNjC5siLs0wG46wFpyjIRATYMKI0AD4td/eVdZTIrM8LdK9/0Z01Uxbhde7m2FUTtww61DvLHxGMzCENIRMcHajk5yxeYST4Hi1/Wm+i9uk3cNBYRL1+znqyc8lX2A3qY0dKSZbp3ql5fCMgFw2K49xwL8OV0sT+sm2xYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dee502fae6so29306939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 18:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715217423; x=1715822223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oftz16oysfnlKPaQe2lxtZscVIl7+JEIfdhzh74tyro=;
        b=wD2kc/03Mgt/8FcHZnnNJObMPDtKtKAdBCVoU9iLoJEgVlNs8aO2UbeaC7bEwO/mpX
         DS0Hsi91rQNho2yeQTiJxCGPN6yI0CC0HaFCe5JArfwRWvmIKjC3TXPup33gZ4ilfgG7
         NsoWPvGFvT5NsZSpaRQnQnuKfGMIMC/Cdado8Ow+hFquD0ZkzIDjfyOh28toQCgJKZvo
         1vq9sojxX1LQlpUr38w28n7BX0aOAvCGH0SCam20CUrgCuv5cQepNBAMKQn7/BsgrFMW
         +sFi9779TyvVKr9NDNlkRgXaUdX1RMyoZf8bOVysVQLvRr6/KVrgvVUehiyEYjCLYQZ2
         EQ1Q==
X-Gm-Message-State: AOJu0YzNAZs70MBZVCE7VNJHzRGId/cIiIynpU4OsqXXMGMmX9dzIzg/
	32XtbhNL/45aw1kRxMNzOxvrT9aw07C3SELOd7VJASknrC9wlFhdJSDP4GbrL1Vkc6iKnugpUnj
	UeIn5XPb8wCNT2exYlYV9J67wVvkQOYm+nGXTT+fWtp8KtnFi0DmSTEg=
X-Google-Smtp-Source: AGHT+IHpGuFTN5aAm7JsxOfjhe0MclTIcLoglEkqSaG+KYzG8SrpRelR5H692ffQYg1Yee8glg23u6wU3y3T805WillKUIXCtnby
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2389:b0:488:cb5c:7044 with SMTP id
 8926c6da1cb9f-488fdd5568fmr258613173.6.1715217423574; Wed, 08 May 2024
 18:17:03 -0700 (PDT)
Date: Wed, 08 May 2024 18:17:03 -0700
In-Reply-To: <ZjwdgZftuDnkXa9Y@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003eb8460617fb2d12@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         02754103 Merge branch 'rxrpc-miscellaneous-fixes'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1075e7c0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7da3ffba7152e6
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c1a83f180000


