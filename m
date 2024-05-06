Return-Path: <linux-kernel+bounces-169578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE648BCAC3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD552812A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336171428F2;
	Mon,  6 May 2024 09:36:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58314263B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988166; cv=none; b=O1NokQBQgTvx5hZ8xDgCakajCd9iN4O0JdMUIUCsbzPpiN5BRBVVoIZy9ztOMhZ2n+FR58aXJPQ3LRwE0hQGtbV6YiCY6BRTe3azl0DdItipkGbRi+3vyvK9BFRSZLNEP6xjY1eeU0Meo6m4o8/34dH7BHODgZtJbPS7PuIdEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988166; c=relaxed/simple;
	bh=AnhUQnMdGrRZOxXZdeozV6MOrXgYCXG31theF87blOg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=czfg8nCHTL/engccWJe/Y77DcjzvZEHWJue1c8ijBpPMcLPXSLd/2nM7zkhRHVoU9Ny6LFlJe+DZ5PZlOn1pck31ZG/LqZkF6Tmu1oW4++df2mhjL6H0HbpXjK15BR9hXgHQ6eTrFc8Ievx1fCIia0LURJqUpwDYKXK3QLfygBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da41da873bso282761039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988164; x=1715592964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv5x6Nmy7t07YX+YnaK0VGIx5sNBuwgtq9Vcfuj51bA=;
        b=rlyyK+CoBxQsmQxnbRIKgORJc2tzPgTwwEeQRpIt+Phy1Ld0EHlSEPcawzjP/Yclvu
         Lyma6OLt7Q33bDslohs0Gulyydk40uvaEaih/TXs3etfvAxp3f9UoEInYnPXroSO+jwl
         QpXvH0RicY1fS+K5jwTnJxWLfYAe7g4xUAPQOc95L8soHg8VIagx5R5ON6mn67frTXQS
         bql+Jn8oIijBqgR6Ipx5ih+ebqDvcPAGS8tUhWbsFIaFGDuo31IPfB7u/76k3UnP9WnT
         SlTz/f7M7H4cqnZWaUtOqdTk1vB/L4q3iZpiRGXyawg/yIljLegu8o0QH64XNRP/Onf6
         +xdg==
X-Forwarded-Encrypted: i=1; AJvYcCWnHowFNWC/zwo5XHIlL6LKWve+cPWyvcLF8U0Xs6X//J9S6dJ0GvOjYxvKhviXXHufwehovgP2m5bexamedJy1yRobM6POtpA8MDnp
X-Gm-Message-State: AOJu0Yz+EKc6oBkaoEU7OwqgvPGffxlCwcDdNKuomxjWyrj0YNckeNAd
	j8E/YW/6nuk9IuDkMbXX00fZm70YTg4RpePRNs3djl2h1SGXVje5x1domYJ1yl8WKKinYTsu6I1
	MYde/s5K4nyJx0bfEY0QkYs4rDL0exgiDDQcn5a+zeUiGpvw9YesM1fw=
X-Google-Smtp-Source: AGHT+IHO4idvgpUvaa9A/19lxtxEAU+Qg+pRM/VhI3hOV9Bck/gnw+u3jLIrwc8UwbOl8L8uFiEpCXGD2usdmZFcNGsYW9LgrsS7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6414:b0:7da:6916:b435 with SMTP id
 gn20-20020a056602641400b007da6916b435mr353342iob.0.1714988164735; Mon, 06 May
 2024 02:36:04 -0700 (PDT)
Date: Mon, 06 May 2024 02:36:04 -0700
In-Reply-To: <0000000000005c46090617b917e7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a730f0617c5cc76@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __bch2_bkey_invalid
From: syzbot <syzbot+ae4dc916da3ce51f284f@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d789e9a7d5e2799f4d5425b0b620210d2fcad529
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sun Apr 14 03:59:28 2024 +0000

    bcachefs: Interior known are required to have known key types

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1070e9df180000
start commit:   b9158815de52 Merge tag 'char-misc-6.9-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1270e9df180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1470e9df180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=ae4dc916da3ce51f284f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a910c4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15490b54980000

Reported-by: syzbot+ae4dc916da3ce51f284f@syzkaller.appspotmail.com
Fixes: d789e9a7d5e2 ("bcachefs: Interior known are required to have known key types")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

