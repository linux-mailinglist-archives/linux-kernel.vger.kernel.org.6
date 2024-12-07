Return-Path: <linux-kernel+bounces-436180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5FB9E8232
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81081281C3E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29524154435;
	Sat,  7 Dec 2024 21:19:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03414D2AC
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733606344; cv=none; b=beZV/8zpgNbbKquIJUbR8o/IcuQISExahX4GkMXfWKrxvo4ry6eh3NyiozD2Z64SE9+J8KdLtGvc9iRbLUZwT/qHPfrFuyY9DOTG83ZWewE+RUV2Lk2maMLUErsc597OK/xuUb+Jg9616LrA7Es7tlqm2TH9P3JO5SFeRZK43Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733606344; c=relaxed/simple;
	bh=FMIUywsD6BCdNHXqsx2rB1AkcC+ChpdHANj/6ymPYLM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ubfdut9ml01pMxoB+cpxwbXARPBIQvUNTxXm1IOoqHERJy4A/zPE92hWVMGdZRPvs9HZv8E0BEFAeF76aX046pMukKwsQ8i2IFmqkyxN5CqKyO1KGXkaQklSI/pukfOsDYy3M+YqAX504O+PkJNOYygXgR3wo2U7JhBYKxAx0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7cff77f99so63486465ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 13:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733606342; x=1734211142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TACK5pe3U3sms4+FnoEsruiFfAkP51ZCsu2HoWoxAKw=;
        b=KIbLEa25bgmK0ooLjWa+nE55N/d9iNBSFcQ+aXzOMUMEU+ifDZfeSWOr3wAprg7OGs
         mO86khR2B+1j1K1h08SmVpbboG6WqJPl7eMZMi5WQ1+XqSdtTcS3k39+HGICB2Bsvb3I
         SvuiYNgY7V6/bqrPW4Uwa+cWKPN22Exud3O3OvxRTwcFxkj5aG523SJHnchtJzeXlEj0
         EkPDAj/GbGRa2hAnaH5mCAm1OlqMZaGt/2Z2utbEY/r/ia6FGQc+eeeEpKZ0Vwa6n9E1
         Nxg+FHTEVguzjZ172yjQBovNlnYjjitV3s6AMHm0D/1FE1c2IuuKoXc0svwtA45r2xt9
         uXew==
X-Forwarded-Encrypted: i=1; AJvYcCV48AE6HCprbU3RS27SCOLLXc+szYfDlKpsCqZpmpJXZplTb5axkY4tjJwZxw710JjjEfiK2VF7Ul8s+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fBv6WhZt3bt1s/MPk+RcxD3NudDkhlUFLTx+QGKZftRDxtbS
	GLQtcrq907bIUyPVEXxj/xVsZMDP0EQJDYLtwib1PZ5Q51RzJ5jjyufrOBnCQwxTGnOjIAT/TIA
	ODD+3BwFYnNPtcqb4YHrlgW88Aq30CWM6Jzjej4n/xJyVGvWzbCz22aA=
X-Google-Smtp-Source: AGHT+IHyKYo95enYv+cXbnv2h7yInUYVMBPtelLCH+FT81932eKhHsfNTZxNljXWtcxj8PfK9XOFWPCT4DBItiXr6Z5NZoOrgyT6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a66:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a811d94a1amr74900655ab.7.1733606342306; Sat, 07 Dec 2024
 13:19:02 -0800 (PST)
Date: Sat, 07 Dec 2024 13:19:02 -0800
In-Reply-To: <Z1SiYXv7zgdh0lnj@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6754bbc6.050a0220.a30f1.0166.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in lru_gen_clear_refs
From: syzbot <syzbot+67a21f2b4c8e9e650adf@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+67a21f2b4c8e9e650adf@syzkaller.appspotmail.com
Tested-by: syzbot+67a21f2b4c8e9e650adf@syzkaller.appspotmail.com

Tested on:

commit:         6e165f54 mm/page_isolation: fixup isolate_single_pageb..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=12cd70f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3884fb5fa6f2533c
dashboard link: https://syzkaller.appspot.com/bug?extid=67a21f2b4c8e9e650adf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133a8820580000

Note: testing is done by a robot and is best-effort only.

