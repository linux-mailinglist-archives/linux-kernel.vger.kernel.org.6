Return-Path: <linux-kernel+bounces-294100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A6958927
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B751F2272C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029C618FC9E;
	Tue, 20 Aug 2024 14:23:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFBE383AB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163784; cv=none; b=Oz2qlMTrRXNwIxFeCScNzKPHuL5LKD1qRoXVJrNbHYQH6hmuArQFmm2tG5A6YrRn7e7547lgdjtNCbbYCUntrieqncU5ZZftWgmx9viVKo8tpG86nsAQQbjIL7lPz0EF2vE5JL5AOp67G2K4aUn9rzYtf0AoaxehMp34p1wJpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163784; c=relaxed/simple;
	bh=gLUPsuWdSTXJTb7WUNyOiFbA7COIzIkvwM69A72ng2Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DE9gpqUytExw1h1cY4mG7W0LOr7OkNzI6RPY+gblA64wlbmKrkk9sAotCAB0jTpWYTEzQGt77BB+3h2lCSSjud71k9r1Hsxe3zFIcABvchFQCAhCFWnM3uls8S/un3zbhke307gPrVR8TKC31SJOktkoOaR8875qe1uHn+5/Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-824d69be8f7so507850539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163782; x=1724768582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYjN5/oAhwhrXBgTjU/FX5dzLOB+Fl9k99kdXwpqfh4=;
        b=MBNKtdB3PnDutJ8DSV3QUsGS8+3VgDeFvDoicaGkQHUCnn28TcN4gKUqPqpdPERV9n
         nyciXguCMCenwDhChl2HqkJY3WDzVvI31feMu2V+4xmr7qTlOGLjsDwFCBXqqEfJ77cJ
         Da3r8seqJ2Wi/XKkRmrMWRwsXE1XiSVgFr0p7tlExQZlwvtaeyr0aq0tkoYibnrc6xm/
         1/FAWfGXbYyJv40r137BKouV9HGn/eYx86LdnvzEKXoloGVPxIRqnEcuRCO4pwofg1gy
         g11SH89KB5/L/cRwVMVTQiuCQJSQKR2SzHS1XPNz80qtKPo9ERykbVhbNjSnaTcgywHR
         Z5VA==
X-Forwarded-Encrypted: i=1; AJvYcCXkm3fkwEwBjUwFSIkZqLK/DG8wsphEawn7H963Hlw2zkrHxMNJrT/Omm0ESqfl5f7PKKdrRScBsxpwGX636154XmjtUPw2IynJVIzR
X-Gm-Message-State: AOJu0Ywiltj985qb7Yw84iNVlH2t1JUs86KLGfEKBZrOG0bo3cuz1QHm
	YOgUVE6/rOWFeqpjYHeUVGu0/8l95B9eLLgoSX1hsUv0m19r/8BAkv/jUXkT/EZBAxE+mbj9LB3
	YeoA+82ymwjGoAuqI6mvMfruDEZKVlAunNOGJZ8pLF7iRffdrim3lvuw=
X-Google-Smtp-Source: AGHT+IHu4ZkUAJ3FI1u8kEFYnwHpSsm3j2LHBI8asJ1P5KcIq195yEeFNPZMqP22Swuy1epC1bQwMwsnfLF7cqSDFyQEUIk3UsuO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:980b:b0:4ce:54dc:fa44 with SMTP id
 8926c6da1cb9f-4ce54dd01eamr146141173.1.1724163782330; Tue, 20 Aug 2024
 07:23:02 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:23:02 -0700
In-Reply-To: <ZsSh4NUWT7MlvlSL@quatroqueijos.cascardo.eti.br>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7d90606201e2917@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir (2)
From: syzbot <syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com>
To: cascardo@igalia.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com
Tested-by: syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com

Tested on:

commit:         47ac09b9 Linux 6.11-rc4
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10631a91980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=0c2508114d912a54ee79
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163ed3f5980000

Note: testing is done by a robot and is best-effort only.

