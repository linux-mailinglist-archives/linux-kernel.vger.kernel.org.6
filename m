Return-Path: <linux-kernel+bounces-228610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C091623B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A40C1F2135F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0AA1494D1;
	Tue, 25 Jun 2024 09:22:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07F145B3F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307326; cv=none; b=r73UcYtQ5USSTOBqgJdlRpj5k38apHm1MkdJoaeyW+JVnjDiYygGV0nnJXTVdWA8vCT2MmBZdeOAXyaQuphvt+Xmm4pG3PzBWPZFZgfZjbEa3XMgyLPvvuMgm70yEknVGeS7yImQ7vXiAFbL7mRXoXkezoTiF//n7ONqzVSq11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307326; c=relaxed/simple;
	bh=uW7QhyvFTfUUqHfJZwsKtI+UOU3dtqA6YzLyg96EK+g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DAkTjW6XyyHMTyCpQaFh7GOMaOjHjSFUEciJ6TgwxEneM8Z6HnAofzFllhORpKNcFvnh1yPcDQsdWys/BtuYQyqS/fnhWYHNwCND35x8/IGI6Bx67Ri3rc+7+z8fbYV2LZHYp3ly6AUEMUHe0hLrfhn+06lmK7q0oBJfakFAUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3762b8b440cso68756885ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307324; x=1719912124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dugU+6/C2QB4JhRZLpBhW8QPRY3SPWfpwZTdLTmHztI=;
        b=FA4iBSCKCRaggaulBxsrIvl4cPYCa/uGAQsmsQN7c2+jSDeNuA9uVWfc/ieTUiuJTI
         68bVzOK6v9OArHlxaLFm8uYMWLXr+n92hpDNwlAEt2BuEB3t+xdM6feO2MZfKrACkuY2
         lN8YpmFwlpUt3W96kttd7aPCrGS0Fnuc2h104Rn8+p2n498gth90SvvRnw+UieNzf7aS
         knE7yBgXreuF//XEKHgPevMb0w8zPrjkbwOQ44AKjLh2jtUf5E2fWPHlngpA57QJixPX
         Jn1JsnGTy+dRsM0grZymZkkNUykY0X4BuGIMb5YDrlgud7gxTQNyklIHRwZyKgfmLOvl
         VkoA==
X-Gm-Message-State: AOJu0YznpSRcmzPSyqk/TOPsTuzQSFDqTIwvThjOcXt+sPgmrlvxCipZ
	907XVJh3mhXtRDOpXDipbs1kGnwYN1Fbfx2DiTY9A/3Up2MbzS+drPKVYzOeColv3qBdikRWT0z
	xXiBZkHJ2+WFb6dah8VxhGdlU0o8m30soFX3oT5Ni31hotPfEU8JwWTo=
X-Google-Smtp-Source: AGHT+IElxbUUnBzY1GgYt6p5Z5cyHy5/HF74MakIK9Jem2YDUFJsHxYzGF42icHDpFxQqMO5y9Hi5TzpjcoQ1gArUidveVuoN3cL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:158a:b0:376:40f2:9b1c with SMTP id
 e9e14a558f8ab-37640f29ffamr5962775ab.1.1719307324192; Tue, 25 Jun 2024
 02:22:04 -0700 (PDT)
Date: Tue, 25 Jun 2024 02:22:04 -0700
In-Reply-To: <b4ace972d8d8125d04851f9961399270fa297747.camel@9elements.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000518a91061bb36e0b@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
From: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, marcello.bauer@9elements.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/25 09:21:37 ignoring optional flag "sandboxArg"="0"
2024/06/25 09:21:37 parsed 1 programs
2024/06/25 09:21:37 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         ea15ac55 usb: gadget: dummy_hcd: make hrtimer expire i..
git tree:       https://github.com/9elements/linux patch_dummy_hcd_hrtimer_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=17f15612980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21b12ee2bb702ec4
dashboard link: https://syzkaller.appspot.com/bug?extid=c793a7eca38803212c61
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

