Return-Path: <linux-kernel+bounces-183012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E118D8C933B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 02:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1031B281F06
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 00:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1F4437;
	Sun, 19 May 2024 00:39:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77368442C
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716079145; cv=none; b=M+z+qq7CPgB2Lwv1PvP8MSWe1R6Qs/hCrd7NdrFHmia4Ax3oUl5/nlclTTgd/FM81sJ3h/Tww39vP/JCU4fFs5wSzbxszIgJcSeuhYELSUoL83Fa8SHU+5roCGfrnEmhAmOJ25IWX9MogKD9k9rjdABv9UkcK69JKUs6FWcQuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716079145; c=relaxed/simple;
	bh=/puHnGrdTrWm9pyZWopubNJNdGjoGIdAy96+IAxopxY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uLiGweXB3m3U9yjbhWuCsOrasioUVMh3qMjwb1IAAakoxi70iuytGf/8eLaLqFRUvVpVq9pQx/cJVP8vcM6OlcSJVl9A7BuwD0OjKokLydO/24wqgLaA0Aw1dCBc0/4kJXg6HNrKP6ZeiOljT7Cu3lHxsNSuU+K70LYboH3bJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e17b6ec827so951634639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 17:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716079143; x=1716683943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs8Yfa+Ys+DFGLJjQmEQ3tsJEaQEuyoRtvRtU8RjGDM=;
        b=dWpyQ94Wn4xXwbWi+koywyafZlGpF2v3v+Z9KoOkTqlGxCFCiLc3gM81D14IX9VNqA
         uGIqVsJJ3wvASZyb2SiNqheldLpkdGSEKDnuznSlcQUCY9R7FJHKoH+vbbvPrRBFNItH
         HLbLaE6pN44+Bjp+w8AlwKirIRtdR84pMBgkAzmEYJJZX4P1AavaPeQY3t5RxqZLss3N
         zIFIiRQMYWk2liwaw1Ze0CAGpnr4+wkCzva+2T9QGOpdEWLmGeYpR7JiH07F9ZTuSOMA
         hqVCENTBEAvkDvslJBNc7ygjMTt1ps4DTm6ULGF+otC8xUFnTAgQq4NYsdXdInDdyHpu
         96eg==
X-Forwarded-Encrypted: i=1; AJvYcCVpjXTm+1rgdCxHyMJwVGb2DBjqk+gIMvdH8fT3HYq3B7M5OsApb1LldoqB6lkoZOFg22mN27aNDc9NSTRCjUIizzFQy+6qUzdsWHEd
X-Gm-Message-State: AOJu0YwEjiMc3gaVdz+iV7wni0LjYAxSaAQhyP8hXefg7HRDXCv4+7zq
	eUBLXXZ53Yh+VPcVFK86y2W2Nqm1mJXCvkbDNnp7qfsc4t63/943fWMK6gkYvQ8rcTS0oD3fLHL
	7EpjwZz3Lg+Ol6jvJFzs+NlvH/UuDiceuNz/jHoXhi3I6AQpWwAXrXwg=
X-Google-Smtp-Source: AGHT+IEtOaaB1+KNdnmdty+lRdQWS5hj5w4Dr0wmHrDPCLlfu+9EKRrrzOyC+yK1VPn5reLriec4LRDptvfsNtg89P/PHyD7AtsQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:c498:0:b0:488:9e3e:56af with SMTP id
 8926c6da1cb9f-48cd548cca6mr89768173.1.1716079143637; Sat, 18 May 2024
 17:39:03 -0700 (PDT)
Date: Sat, 18 May 2024 17:39:03 -0700
In-Reply-To: <20240519001452.1982-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c368210618c3cf58@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com

Tested on:

commit:         ea5f6ad9 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12d37adc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149fbcb2980000

Note: testing is done by a robot and is best-effort only.

