Return-Path: <linux-kernel+bounces-370627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA659A2FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D65C287DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D221D5ABE;
	Thu, 17 Oct 2024 21:32:11 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2818133F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200731; cv=none; b=QrcdozUa07Qu0ogzRc7zQA9gN2X6T83DlXPQJWy/N21ZBG2pSuju02XXZwVgqXZDCpwD96Z4vicqgZqD0lVl2jELjqXZTBlNGBMVpSOSTr/vb2EBPDHYRRscNWtYEog13JP3SG/g1GTwaYec//93Twri8GNwDFKM0CFvpplHKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200731; c=relaxed/simple;
	bh=3HDsHXSjIdZeVogNJWq4SAkWjTtkBvF6SmzMwjkTids=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P2ZLNRwjrW9mrTBAgIvH7xBhNvqxpmFfxyvmMIJjSnjzCdd1Z+TSPyiF9lL4jBSkx/y7fTe5CjT365iuBy+BnTgyE5s4lUPM8f802vuUsP7EhhOyuJm53tIznnZ+gn+uXtNuls1Juv0zJ5UhK+eLlLwaK3tS0aCdo6vZlHO/XMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso15130875ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729200725; x=1729805525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBBPEonM0tV230IdDYXpzydo0V/QfTUZsgKonxOfyjM=;
        b=AMCbWhWPqUSy9A141OQpixL9Oq5JM0VwfwA8g/e17024bEKi4fTOP0dJzbVAbmE5uZ
         LwL1y264VSpcnGgv+oBm2wFhDB1I9dTKEevHJCHOBwTRwgy+q8bjH1iqSn93voqW22Lh
         Rr9mkEh6k87+pzE9hBMF73TaUEEi/rEvNn3J91rpXlgXZOJuuNjt0wdgbEZgCPKTlXhZ
         0abeg1liBXCyF5ooU0HlSZFU2grZkWxikmgAynL0FTV4iG5DyHqMBh/bHJAyPP+GW7fB
         hkdyvfGcdjHWewpG2AgGJ3uuol4ba8K6MyUclXDprnhqe6feSoSbv2Xjd3TSExzd5i1B
         ct8w==
X-Forwarded-Encrypted: i=1; AJvYcCUYxJDGbH4//qNfR46J/Oc0D8btLQZkZEfF8hLV6faq3CAKsJSYRds8DvbgWaW+6WI0Uawynz9uHhqRIvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RAFEcy172jOA1EkUJarBeiBIp+V7DUmCbnt5NN3kb3vtippV
	zPqSJjaLCTrXFiAJiRIs8IXxsofOImZdfEc+AlwUe5bhHmhXVEt+sz06CtQV0vuWxC4WkXOZUO5
	XaVQzmEN3bIgf5thnsvcwrvyGJG8uCkH0+kGpAC50e8SJ2F4B0S/ncC4=
X-Google-Smtp-Source: AGHT+IHL6TbDTEQ66a/mdBDHg3xJblYzJvETW+4up7Ak85EJz3DPktxyMtzL1HO6Q7WFs9bn7f00Jsf5XLBwSS8JqukrDWNib8On
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154c:b0:3a1:a293:4349 with SMTP id
 e9e14a558f8ab-3a3f40ab52bmr2654725ab.18.1729200725433; Thu, 17 Oct 2024
 14:32:05 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:32:05 -0700
In-Reply-To: <CAGiJo8ROUTr0vSZp_Ma_SaiKc3H_4aseaxf9N334zeJDE3nk_A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67118255.050a0220.10f4f4.0005.GAE@google.com>
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

commit:         6efbea77 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12dd8240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bb2f27980000

Note: testing is done by a robot and is best-effort only.

