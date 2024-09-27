Return-Path: <linux-kernel+bounces-341508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABCA9880F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074F12822D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBDE189F56;
	Fri, 27 Sep 2024 08:59:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071C18893F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427546; cv=none; b=RjFfoC9KOJY2xV+KW+xD2VdZriFTC4X66WvOybMSuR9n2oDNrRwcJH95uTrqPvLo4uBC7SGYXOiMAfZCmoo3IAQDSW/+27J081STnL3UM/HgAaln4pA1t4JHp+O2zGaMvIttYo0SYbVmicGQSD5sOkwYjwQjs6qql1iPS1jPkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427546; c=relaxed/simple;
	bh=vh1wYAF+kc+HTxM/G/citDCdJQ8zATeIDO/s4Oi+gHk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zl2jJHw8024amIt4hCXvF/LjgWguAjmmD3pmchdiH2S1C9L+nkESozzVv4F+syWc8dMEjRKAtYAcGHVFmwVNry3Dql4+xwfhyyBVW+kXh9EziskaBz69F2y4qGddlskwPL8yjL63L63a7afoc0d3ddnbhhQtSyN1KL4kHnuNboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a348ebb940so2100665ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727427544; x=1728032344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvND1OumJaSV1S4zDkx3t0bAVWve6u1ecGn/IYHnScw=;
        b=Oy4Oq3OKWBU3R0LYE0PChX1D70N6xwoBTboaOUFJl6566DihqZzftr1vNu8zoq91gX
         MfN+wq3pfi77Im/xHgV6TwyV8Z0G9XsCPUYAmlyfgqN4sT10TQodFchrCUSUVBXhMxkB
         a0+TBJ9nb0/QIlMXmYoMFapZOT2s4/trtvxC611gww3N+5tN2jjUFGD+y6TZkyV1Yppc
         CXZ5NMuVAFs8ZSIEB42nob+nBkBEkR0CL6SzmuTU5MlYB7UMWEzDhAP3srPdNGGDIxVF
         9MNdGH+hOgsgVlVgt3epj23vfvQ87jSWB53BvTcC9zLoNZahqH/JS1GA/4YnTVvOwEwP
         HChA==
X-Gm-Message-State: AOJu0YxGTkNnf0wz1Qvl3ueIZAwX05bstHpfrKaMzseSwvNxJ5XZkcpO
	2AkIuplK5zo3yVFTEm4d62I/xOwVmEE59I+ldLpgEklY2cgVd5Qy4ndBW57AYwA0YgBkPEwyuqJ
	ywT16F8fGlXxDvFgZkv56l0itLnuhhTJVZb3lU4/9tUjmxy9ZOIvXHA4=
X-Google-Smtp-Source: AGHT+IHBML4j3KKYAed6evcTX7DlExV/t9himFQB0CXEhvOImPrLVv67+BLgS7OoN1wtsGQnATfJg3p8SE5P488p1Z/qagKmJXZ0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c83:b0:3a0:8c83:91fb with SMTP id
 e9e14a558f8ab-3a3451bc001mr20992025ab.20.1727427544142; Fri, 27 Sep 2024
 01:59:04 -0700 (PDT)
Date: Fri, 27 Sep 2024 01:59:04 -0700
In-Reply-To: <20240927083836.37037-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f673d8.050a0220.46d20.0013.GAE@google.com>
Subject: Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
From: syzbot <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com
Tested-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com

Tested on:

commit:         075dbe9f Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bf9e27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f49dd07427b3bf8
dashboard link: https://syzkaller.appspot.com/bug?extid=c679f13773f295d2da53
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174f9e27980000

Note: testing is done by a robot and is best-effort only.

