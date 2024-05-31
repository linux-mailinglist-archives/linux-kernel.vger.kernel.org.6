Return-Path: <linux-kernel+bounces-197291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560DD8D68E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10C8289703
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D23917D350;
	Fri, 31 May 2024 18:18:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33677F0B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179485; cv=none; b=OiyWHUlPDxzgRmYLv5Aob2vxO9LAJUsSPbUfa2wmcpgIAwCg1Kv3wvGyFiJINS8IUvZxq8bXtrjcdeKXgGiSHOW8Or+6jlYeAE4GpKtsZ2fj5oUHnpFJudLH+XjoxG1Tdf5ZvP5M7R7C3ZJ1L0NKAcs55jdaaIlmZMbdkX8eIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179485; c=relaxed/simple;
	bh=x/xD+RD/fEtRRy5ZJ5szYhqgRGyeXYQv9Nd+Zy0IN9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rAWEqgmJ117mP/G5l7s1A0T9UYDPrdEfMTCQRK1ZoBpL543Ada+CHuCpvBmHYmHyLCRDIQhrsvke1hLofGXw2SucS3PpkXasyRbDMmfrKolAEkGHXxFc3e1QxSEHgpYa8MX7x8rwoCXAqysL1lH0H5svPE3QjyQRkayNm/Jn5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so309818439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717179483; x=1717784283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GRhgLtCUdgxzZtHxjigWDoXPdq3UPpeSA7MyZlRIYg=;
        b=g+EU4ZjPukTqnUK+PbvOuAkNIB7jOr+yw9xtbnCwII1CJfw+aDjKJapOr267+MpQgZ
         Yn5eFVG9WqIQG5sNDKkNPGdJzvLrAznBeHwkbdVg5hJJ7bG/mQ6ORXi0jHXzg0Kilik/
         SjNJicL8wfLfwdVRdS2u1NK2tKS/n3p/S1gARwPRJ8YIegC0ezDauRaQjhPgSvOJPCeP
         oaT3ftJJhaeqad2vfWrDRAZ0tjmZ9ww3N2OI4bTK6SyZa2u33OfchhxPfZ15UizxguVo
         Kh1bnVqJDxRdAu5+ph4nRIQrEs03OfBeV0Bbjt5aHETyZBt51iNCT2FiDBnQpnqlBwTl
         wMpw==
X-Forwarded-Encrypted: i=1; AJvYcCU73zfxdOiacmMRFFhlkOxa0RZ6QMYIV0c92zXGMaTafRvyGjZypI++usNCJSd15BABuFxqt2YiaFyWL5LS7kkyZm6q5TbiIytFcbMy
X-Gm-Message-State: AOJu0YzImu9gOg2obrIhDUue5CzyJTiZDcF5ujGEwyx14CNukGonD4Po
	O1heai+8M8ltAQcc13Jg/DrrNS62vhR8XeE9EClJXkIPAux/JAWIY3xsY1g6jhnH+Aw3TEU6RNK
	ON/8Xvwsr7abkWTGkFJJY9MJJtyoyIxQNgWJisQ9GO36EFjSsVKzHeQM=
X-Google-Smtp-Source: AGHT+IEsG5uycYxAOP0edOINDS3b+8ytfx88JJz4U78YY9wMc3Hen9zzAlHPZZMLH1i4lJS6mm8Lqf3L7PdWpEwGCSbkjEFI8eHv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:ac98:0:b0:4b4:5d22:e7d3 with SMTP id
 8926c6da1cb9f-4b541d656c1mr43894173.1.1717179483077; Fri, 31 May 2024
 11:18:03 -0700 (PDT)
Date: Fri, 31 May 2024 11:18:03 -0700
In-Reply-To: <20240531110652.8845-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ad3710619c4018d@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
From: syzbot <syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com

Tested on:

commit:         4a4be1ad Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f8f016980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=13e8cd4926977f8337b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1001cc4a980000

Note: testing is done by a robot and is best-effort only.

