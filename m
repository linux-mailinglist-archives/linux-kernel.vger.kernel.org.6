Return-Path: <linux-kernel+bounces-337104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0F3984567
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193E7B23F22
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E421A724B;
	Tue, 24 Sep 2024 12:01:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F01A7076
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179268; cv=none; b=ubxTU85lbXbVMFXBQtrlRvpeNgBZy7AjUj8Q4ZzNQ0yvPBffIzuSCwW6eQOI/ld6z9Zgjsa3oTNQYsvttTQUMe0wiGzUj0omXwjq7FLdqgrp6oszGm43yOl/hP9KH5VnFmkxh8Kb3mh3hetW2zLv3hSLft/GGolzUZ7TZcWMcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179268; c=relaxed/simple;
	bh=cObrgCUSvHW+ygJ1FqkY0+Tz/uCqpy6uPK5t+gWO+j8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vw8s2D2G4bbQFxA0ZJxk0sZz/lMELqOErgA+G+9nlGhuYrgCA8U/wDIZ+z36dcho1lKcq5q4LnroKW2q69O8FtQ/w20U2EhxQuPmMuBZtSKq1TwUgKNHsBvOdaePR/ED3w/VxuSeyzAUJwlr0U4CbXb7FWjtnbskjRfh1rb8u+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a19665ed40so20051415ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179266; x=1727784066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6XSwTL3/zFm9C67RW1I8K+Y0nZgbXlIR8uoPmui7Ow=;
        b=D5je79D18wC6NnJPMztiWS13tr1FHL20XDKOGiHlTuIhbe/6kLtjfk9b8etkaVNfYg
         mMKsiI9Jx44l7cp+1U0sTntNMRFgHBNfGmSU83Wl/6QcOMf7EUVG62K0JMWnhb+/8V51
         ds1QBvGwMMorC6U3WqXeTWWrD9wsloPDWToe8VyKiZ4uBbjOezIYCEDVzFvvpoq2auBw
         1nCdGgbXTQC+UY894/UvmyRBV52y+uQu+S19fzoUSvlb27RfSEqgoriaZctjc78KopzU
         VmptOiz5fH4XohhkvEyQ3lXREpTzghM1vbbBFasxXDo/Qc69KSf2a72c3rib6mBTki/1
         qxsA==
X-Forwarded-Encrypted: i=1; AJvYcCU92pTTmVQlLcd0HnydW0eLEbAbu+H7v/OC22cVbsWfdOmNYYOCndmQ/KcwBhur239E9+cnhEUyqLDTRvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQb41JA+HWNXD+uQFrERFntxEkF8l9CDrzfimfCSPPtApBy1sE
	7dBGHGd5Q/MJVVZ+M/MTGhUh1m8VqK9TIC7zWVpTrEJPc9SB2werDcMz4KUJEJR0izFDsDLX68O
	x30+83or7s7yQnuAo3TaQ9e3+jk7fbE1asp9qBcYvxOB6fkfhyz+Vh2U=
X-Google-Smtp-Source: AGHT+IHrOmvjiLzvF7jwvN3hI5LzS+Kv/KB41hVRF7f6fcdWg2aKQjwpw0ahz2JHQBSNt2sFKNFZvypTChxKfYan2ZHULmNIvNPZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:3a0:ca91:2b4e with SMTP id
 e9e14a558f8ab-3a1a2fd73ffmr19734095ab.3.1727179264991; Tue, 24 Sep 2024
 05:01:04 -0700 (PDT)
Date: Tue, 24 Sep 2024 05:01:04 -0700
In-Reply-To: <00000000000020c8d0061e647124@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f2aa00.050a0220.c23dd.0029.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in addrconf_dad_work (5)
From: syzbot <syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kerneljasonxing@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103252a9980000
start commit:   af9c191ac2a0 Merge tag 'trace-ring-buffer-v6.12' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143252a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74ffdb3b3fad1a43
dashboard link: https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162e9c27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1123c107980000

Reported-by: syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

