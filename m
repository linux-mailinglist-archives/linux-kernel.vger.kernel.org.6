Return-Path: <linux-kernel+bounces-290897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E7955AF1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 06:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52F5B21189
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 04:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBAD946C;
	Sun, 18 Aug 2024 04:36:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337B1AC8BB
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723955764; cv=none; b=mCsPkRYiOggfGzIs+Jd+kJoCWcdfgIUwNZjhJgQsS2KuLhijjDskkkaocmSQpjE1mPSZZGxsXZ2QOAozhDPQf10dGaxPISe5lR6sw9lxqjqFQhPUXcfEq1brudh2djo2lQtNtMYN4y1PTuAkgu78gl/Xi8M4Mhsdg2TBDdcM6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723955764; c=relaxed/simple;
	bh=40gGmdyokFBvxCelSJ88QlILapEFGa++UUEwevJF6q0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=idgb7POgBTIk6U5zUdnriSRABYhEj6eDW9eyZseSZ7hbBLbmcgk1JW7u6yTwoiIwAp35+2D7rmD1d1/g855Pia06IYnyW+44BnHV8OzdHp4q0pRDUALoHOgseUYzINQex+3hlf9bP+rwQvB3GK0Jb0GwQKMluG4iZ7mYVorcfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d465cd6ccso3999635ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 21:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723955762; x=1724560562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBGDucmLSB6SFFjjtCvCnw5DXFy/m92XieUw3u0Lkac=;
        b=OeQt8PPuptZ5E05Cce7s3yrQybesI+EBdql8CBsLCu41rtBUHIog2W9A05Jxsnuew7
         2fICqXT0QRLHe2rleGhWdvbtZ0aEO65yhVvUBs5x3xSmLFCvNWfW+Xaqhfco+5C0GJhI
         7SUqnU/RF8pR74E8YTvD5uuZut2fUCCLOQljYrqYLtiGzXpvbYmeUPciJCiUOWAe3EKC
         ORgyo8ZJVGWeQre00LPYFDrFEZJ70fuLVBf6lF46mML81qSiVdFB38UK5qRWVCEo0NBt
         jMvsajDzxnJDd2Mw8jQP487jd2mqWvjOIa+dE0zkiSD4yVZGP82283HxRwGYPJcjOSV5
         X0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVvgjZ07kyp88ddaPvtrNWcLaDoU4d0DdioZ7FQoG/bGbVUp6mgQIL1tKwlukBGNS0NAk+zzHlMriDeT/OHAnnbeJ4N/MMImyhqy0NL
X-Gm-Message-State: AOJu0YyFRPtf/1vld19gHjbNdWQiezfGl9oCTvHxWD/aR19cT04MUIaB
	GjiDwkLLTmBeB6QVAdcJNcyLBCHIQ0/aFk+Og47VP1xqU2d9sHtuketlssWfXmDrA2t0wjBWY0o
	410qSESJB1ZQepVfGrAP4C4Oqk7/Av2nceXP3HlYc4nxVnnTLDETBohc=
X-Google-Smtp-Source: AGHT+IEWq/Yu9hdLGQwW6k3JHsiI0gqvNTR6cCMXhjpNdSYUh+p03hC5kWy36g2JAFm+WlRduDD8fopasmd5HOtYs73xuvK/+5rO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0f:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-39d26c42314mr5570365ab.0.1723955761765; Sat, 17 Aug 2024
 21:36:01 -0700 (PDT)
Date: Sat, 17 Aug 2024 21:36:01 -0700
In-Reply-To: <0000000000008905bf061fc61371@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9eee7061fedbac5@google.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_buf_item_unpin (2)
From: syzbot <syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, chandan.babu@oracle.com, djwong@kernel.org, hch@lst.de, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3eb96946f0be6bf447cbdf219aba22bc42672f92
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed May 24 06:05:38 2023 +0000

    block: make bio_check_eod work for zero sized devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=178bfdcb980000
start commit:   85652baa895b Merge tag 'block-6.11-20240824' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=144bfdcb980000
console output: https://syzkaller.appspot.com/x/log.txt?x=104bfdcb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=837bcd54843dd6262f2f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12350ad5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147927c5980000

Reported-by: syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com
Fixes: 3eb96946f0be ("block: make bio_check_eod work for zero sized devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

