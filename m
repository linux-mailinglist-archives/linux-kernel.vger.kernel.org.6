Return-Path: <linux-kernel+bounces-395786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55E9BC2F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABEF281D16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42026364D6;
	Tue,  5 Nov 2024 02:09:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC642943F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772545; cv=none; b=OPhRm06jruLEyblGqpP9KYhLYipsMoN4SRjD8VU7XxEL2nvow8Y3zjVizJuJfHm8UmcguF40xrKA3bD1XF1PkXLnvF9qL7rVXA2JBp2nkSBKPOe/LFc6Hua7Ghqi+Rlz91AamfI7Tyq8dlMYVcxOn3V6frhBM0c5OGRoCTBq9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772545; c=relaxed/simple;
	bh=y7f4emwH4MxN9Dk0nJiJoZuVuQH0g82lOcV2DXxYyv4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pu5+xYG3IXNOGEp14FsoEpczc8ZurFZ93tQOF3jj3raH6aPEr9brFcxfE13eCk3Pgf6Uz8lpz/HXnPPpgneCKDoqoMEXTrnKuDjnFJ5Egb/bKp+rQT1ZXUJyeqC4mWEEVE5ZcHwV5sVHbG24xK+F1yBYjLYh+8WUSObqasINJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c427e1b0so20395705ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 18:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730772543; x=1731377343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHNDfZhIwCuUlXyaUbaOjkk68adelWGd6TWuMHqVT7g=;
        b=AKIH16Z4UcierRK7vtLfU2P1pYpGObh70I0+qBX0vHiSzhPPE60TB5pHhdo0hjA+Ib
         W0bp19azRdFjl+WQXfoqGC1exzum38vuH1gsA7nvtzOz1TvgRhnZ8Hk05dGmS8j3WXuH
         R9mk5fLV+2+/y13e/J6ZBef7fXPUozwnfO/jU8LONsQAdX7S0K7+L21iCb3QHiKeABIo
         EtGFtxQ2oT8lvT5F+4k+CQZMf+8tLMh8mLjJqlvQouCkVwzmfdSoiHv3TIh2X5+Uqdla
         85OyS9NGGlP+Xf469noRfSjdB79hDrfSqod1MjhgMNyqaBPmD1RfLYdCBWsnqdi8Fqft
         lElg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ5U0LK+Hy/7mi5rWi5Dd581JiY/C7OLuKgAAyVT3+Di+MnEiHefsFCCfDDJYFhwCiDvuTeG0xCx3CnaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfR+R1MTVIls4lLRD2f5CAmjgy/SPUB+P/tHwZURP0jMYMyyU
	+UkaNCpZWmT5EyuLE5hTWi2Yjk/aOCmx+vkyV/69TTaUIK4gggH3ayfzymQrhONdk/P+yHfhlhX
	mv62PV9nMT5JjLiFaTzyEtSAi7+VBoiyRkVx6RrHh+bg55zhJFqbCOPM=
X-Google-Smtp-Source: AGHT+IHUOaRGjr6Z7Rj30tI8k0Sxs+JeGMXdFOU1wywHgxh4+nFtHQTf3vwLwRalZBURSLTG839Ea6f146LAOJm2yw3nGVWYdQpy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8d:0:b0:3a6:b26f:a5c4 with SMTP id
 e9e14a558f8ab-3a6b26fa5efmr113399645ab.8.1730772543360; Mon, 04 Nov 2024
 18:09:03 -0800 (PST)
Date: Mon, 04 Nov 2024 18:09:03 -0800
In-Reply-To: <671a8834.050a0220.2eb763.00c5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67297e3f.050a0220.2edce.14fd.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_run_recovery_pass
From: syzbot <syzbot+a27c3aaa3640dd3e1dfb@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f7643bc9749f270d487c32dc35b578575bf1adb0
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Apr 17 05:26:02 2024 +0000

    bcachefs: make btree read errors silent during scan

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11da0e30580000
start commit:   59b723cd2adb Linux 6.12-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13da0e30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15da0e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=a27c3aaa3640dd3e1dfb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e1a587980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bc46a7980000

Reported-by: syzbot+a27c3aaa3640dd3e1dfb@syzkaller.appspotmail.com
Fixes: f7643bc9749f ("bcachefs: make btree read errors silent during scan")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

