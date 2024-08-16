Return-Path: <linux-kernel+bounces-288832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF6D953F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E792C284521
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22492AD16;
	Fri, 16 Aug 2024 02:06:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B0B647
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773965; cv=none; b=Tn357JKt2x5bprvQ4agBA875Lpd/phF84S2zJFTLrzlJCkInbn5FZtz0OXjs+lRWQi1YaDNkpPoes8vC/KtOuDjyNRfxEYjnQBuU+m44VHyZimTQxwcrq0SBB0hQvIpHPY87onK5//o4eBna5iEr3QiZVSjT3ckMD8NDB/oZ0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773965; c=relaxed/simple;
	bh=ujh60v2byDGakwcfyH78G2Yl1WOgmlTmuA5+8o6YYLI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WWKU15UJSTuljU8vHeo6OaWU7hchgkMoQIE6EbJKXODuRBxdNc4SbhY/S1wTyQ08Y+W5Xq977t6ITDOnw8iVFnK31Qceqm31sAQiDEbu6iGZKxYonAfzBw8sv3vqTGZGJNmEIf4dNouPiolwa6HTKis77pwpTObopXxzRxHWsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3962d4671c7so17580025ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723773963; x=1724378763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Omwei+3ZiYqhvQnoEhNschXgWrRO2lQVN5wNqX1kao=;
        b=kZIwBVBsfNwnQrDG4DOkf3nxRsuHr0st77ik2xzdYdEvCp06vVAnCIQUVHSOGZ/g3W
         DjGnWi3tlZVhiS4VvMYNr2FxiZqguhtip5NkVkXUzTp6Y/VcuQy1UKrDscyabqLCgnoD
         3IkunkJ1QwA+3F+IlkuSR9RL4OJPP1PHiQySxCeS2EpN2pRj9v2DhdJi+C7SJBG/LCjJ
         3W5BAoTzapxK3cOj/wLmCs0np0wWf7N+mIlkCP55ZgqNsl9Ii8w65iPzYvIZtr2A6qmZ
         Gs13xu/vbwBgefyziI/aT9nVGJw+NW01bpIJsXvTApRYly7GB+8mX5PXiYae/KK4JVA+
         0arA==
X-Gm-Message-State: AOJu0YxrjeWjQ8tHdchz4e/L+Uxo1xzq4bqj8GrzxyfC5RY+whNcVlQ0
	N5Hbg4hdBM6sQoaBJ6d4Yo3IYf69EU+HRAZRI55XCLsalQwA7rztJ42A006VpBuD1jvAC+8cFWy
	hvh0AiJsD20GYeKF59SPgYOU1Qleyd+oOPmPlomj05TBEhZuZhveAAUw=
X-Google-Smtp-Source: AGHT+IFHW1fIs4JTji9haTMMHFgPeDHqFXSORy8hI3M1MBdSYa4lw1IXqeTET0VFuj77xOW1TUx+BTcqJTCiMu9NJs1e4lVAUKQ8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:397:fa4e:3df0 with SMTP id
 e9e14a558f8ab-39d26d5036fmr1392145ab.3.1723773963348; Thu, 15 Aug 2024
 19:06:03 -0700 (PDT)
Date: Thu, 15 Aug 2024 19:06:03 -0700
In-Reply-To: <Zr6twHVzY8DoqG8i@hostname>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2379c061fc36630@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: shift-out-of-bounds in ocfs2_fill_super
From: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, qasdev00@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com
Tested-by: syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com

Tested on:

commit:         d7a5aa4b Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a1c35d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17841a91980000

Note: testing is done by a robot and is best-effort only.

