Return-Path: <linux-kernel+bounces-258092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5593835F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 06:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDBD2815BA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 04:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C794683;
	Sun, 21 Jul 2024 04:57:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B264400
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721537825; cv=none; b=TqDpdBl7HkRsu+YykL/04K/DpB+LLaIhFmxAzNHF8LhSP0TQhMZ8AGqfdfgC0VuzFemUcGmm5/ETRpTlP4Qj1f/grY8dZT5p5JyehbBeVZdjbHySxfAkZCCTa5RnK9m7vEt/WREnS9ozAja+PJZ433aaXIq1t1lG6hNg0KP5lSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721537825; c=relaxed/simple;
	bh=RvCwoxQ0RDwvppOJHLWny72GRZilV/WwvSv/YZN5oDQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DfS6WFzULBuizz5uXPRF70nnBi23BZvWUyuVIxM1mJqHOd/TBUFek/vyW8bgnsLRQ64SE4ZeZgetvSkIcdayJoQu0wwdmJamUJ6GFGqUCZb51tov/oC3Rn0FYWCO8swO2HCaRown9RzEzXgR4EZos3GYzfxRS8pnrQ4s5RfIxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39941f4c5a1so15219075ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721537823; x=1722142623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6G8K0MfujHk0ZY8Ig4z13lQZ8FAFAZEBtO3Mv0nroc=;
        b=dQBgMLA3J4rKxSsYfmUHDVZKAOTCynDRjkeGsfBjiC3QyvlOgsHmB0Xo4oGq99baIM
         AOLCyHuij6ztwev5n4mIeFH6S/+cfg9lwVx7nfSpvsn9MKzojxCoF5AaoZS147RJpSKJ
         RQIRRVLZXc3zbNGb+F4aSDwyCotj7SSpPZYU6AAdgtAPAs/8x7qQU/UbyHzRFLZje77L
         NfagUrdPVBUkdbXpha83RkuftJUz60cOsiBsBMY5dS9KPHxQqjxWTAey2QsLcmxEf8K5
         WAfcswh6SvMeMeyHhG48K4XLGO10Dl4+OlgERAw1Pf1GuF3mDYOfck4dmqTAeq4L157s
         Nzcg==
X-Forwarded-Encrypted: i=1; AJvYcCVAEulS0F9UvkHjhWyOL7oRxmCgfPcGskLbLIQbCchb9gxAKjUN8AC6FIWZP3ZPeWgfLXklpKfMdGEPdRI6V6HTokavd5knesTaeoS7
X-Gm-Message-State: AOJu0YyXnMHiui+mR+aceS4AfrZVccYn5X0HqsW5vCno2t9L8kbaJc6X
	WznouD60jfysKbzq6WXSVxevCAN2ZkREqJjuPD3QQup6BzoeSL4r9OkDNsvJCEQloAfCqUYE7PT
	5DT4scibCkuq87f+Ol1/4eImyUlekgdBnoIxUK+gM4OldI8ltCitwwf8=
X-Google-Smtp-Source: AGHT+IG996RctXOnCeEpiTZtyfAzY/miSIhLiSn3H1B3nY0hyAMIwEZ86NEibrKkHALnS7UGrCuYqV2Aroyx26aiAA79c6nFahlP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d19:b0:380:f12f:30de with SMTP id
 e9e14a558f8ab-398e4fa725fmr2742945ab.2.1721537823309; Sat, 20 Jul 2024
 21:57:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 21:57:03 -0700
In-Reply-To: <tencent_9A6EFE8CB8A7FC86C992CAC6744992EED206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d14b3061dbac27c@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in path_from_stashed
From: syzbot <syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/pidfs.c
Hunk #1 FAILED at 168.
1 out of 1 hunk FAILED



Tested on:

commit:         5e049755 Merge branch 'link_path_walk'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1c1b0a8065e216
dashboard link: https://syzkaller.appspot.com/bug?extid=34a0ee986f61f15da35d
compiler:       
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ea160d980000


