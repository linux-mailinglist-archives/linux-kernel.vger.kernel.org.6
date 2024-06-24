Return-Path: <linux-kernel+bounces-227733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CFC9155FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB76CB22FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E31A0703;
	Mon, 24 Jun 2024 17:54:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2821A01B4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251644; cv=none; b=O93Zs6u+nx3ak28VohjoBw+tO76OoWZGCmNhEY6T1zvZPkK7RJtYKYkT3d2xrEtBz8qypDVQCl0eb3WrWdkZ7rIS6hP5CvgjDL5s26eFSKBZ/xNOheteGSiFnJQXfwYwE0VxQOYJ6ZBWezgzdc99+TxWjk4P43y1ymwmL63Y8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251644; c=relaxed/simple;
	bh=BFZTOS+6UUxcIsopT/PSSLG5gM/kaNsm7fOq8uT2SDs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I1vy5Sy6LD+LiNhKifuUxJ986apKRtiCik7nljoPvKOqrRSxupyYK3NFLbfXKzzjf2w9uBrkllROjV2SWvCs/jpOaEvArUGEN+NyfvNTR4z4+5zQZ5JXe4jZVGM30clESDHT0Q+RraeKnhc9Xa2ZQTTxoGZrNUmBxqLp7Qf+7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ebe8016637so662401739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251642; x=1719856442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzCKyK0zAE0pyal4RPcwORnN1X/VtugtKH06mEuQykw=;
        b=Rcp7B24LjKjMKiNja3lSyTexEcU+ucAXvWORJaoOufQNXJ/EGKpLfFcCSHP2Frvk7J
         VGIgn6aHRZyTau0DJKqqlvybli9ITu/O1rtjpHOvRFXhFHkdCwmG91pc9CG86WyIceOp
         E6ftWhXuqVnJh0JCwXXX0pfGmMjdRX7RHEN084A8fbcj6ZQZmwiChD39ZPbtNXEdgwb4
         fKg6jDN6MdCrkHCdXiOEx/6eiJ2UqKakfsfYA8MNPppoO4kjljNovguNZM0PDh7ATPmk
         rxS3cZExY36sLZo9ThqB277VhLmkHCRQNGknZ6So7Wl37v7IYzoyhmvkZPvTbKxKL4yf
         iGNw==
X-Forwarded-Encrypted: i=1; AJvYcCUAAH3sapBFLFoLN3KMTUjGB6IXff1AH6YBZwvA+oehviGjsjDk044S7AWzCiBRMT+TAEWdYgURL8qyKPCFhez/gzdILuiVN58Wi63l
X-Gm-Message-State: AOJu0YzVxEUhML1J3Z+xLdgUn+xItVhDiK4xltTmm0Hhslahuq+Mhofk
	CTCAl9VicVaQHlGc7p5q2Yr20eYS/Q1HHYh7CTZAQP6hC3JJSH/DU3M9jj6xfmd2/7M0ru5w08V
	eAkRyRJN9oIb7lV8+EgRXRqQbTZ08yd96eblrMJmo6XRkYMtW3W6VpcQ=
X-Google-Smtp-Source: AGHT+IFvlUCBRcqMRnAMMzQZCF1nxnRlu+ZLYSY5fQOEYrcnpFhzGgam/jc53s/GdBXuorTslpc96gfIFHBQgkljdpPr4HR2/pmn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:376:4a18:a4ca with SMTP id
 e9e14a558f8ab-3764a18a6b5mr3045875ab.4.1719251642392; Mon, 24 Jun 2024
 10:54:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 10:54:02 -0700
In-Reply-To: <00000000000026100c060e143e5a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cb461061ba67748@google.com>
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
From: syzbot <syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com>
To: James.Bottomley@HansenPartnership.com, airlied@gmail.com, daniel@ffwll.ch, 
	davem@davemloft.net, deller@gmx.de, deller@kernel.org, dianders@chromium.org, 
	dri-devel@lists.freedesktop.org, eadavis@qq.com, edumazet@google.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, jernej.skrabec@gmail.com, 
	krzk@kernel.org, krzysztof.kozlowski@linaro.org, kuba@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sunxi@lists.linux.dev, mripard@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, penguin-kernel@i-love.sakura.ne.jp, 
	samuel@sholland.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	u.kleine-koenig@pengutronix.de, wens@csie.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 487fa28fa8b60417642ac58e8beda6e2509d18f9
Author: Helge Deller <deller@kernel.org>
Date:   Sat Apr 27 17:43:51 2024 +0000

    parisc: Define sigset_t in parisc uapi header

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17038a61980000
start commit:   acc657692aed keys, dns: Fix size check of V1 server-list h..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c882ebde8a5f3b4
dashboard link: https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103698bde80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1617e0fbe80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: parisc: Define sigset_t in parisc uapi header

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

