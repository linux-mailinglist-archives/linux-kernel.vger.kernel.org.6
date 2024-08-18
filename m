Return-Path: <linux-kernel+bounces-291261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835DE956000
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F041C20E05
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A915534D;
	Sun, 18 Aug 2024 22:39:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370E610D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020746; cv=none; b=GQvQgz+ipQlM1M7a6PNj+3Y/mmD1iSgF0qdpLGy9q7dy/qUQzoaMs76epKH4tMSDbzz6waAkaXsxcY6wtGkM8GMMxCBuKrdeTilk3S9U/wpBxXvEvU0RdxotiF+CFl1QBmNbsH6fdVyOu0Ken5zzaida8ep5GpUKfpKEnn1XvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020746; c=relaxed/simple;
	bh=uLb7DE5+sb5ojuZ2PVgJ3Q3aZCMr6SWcfdBLYaDKqGY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nSKC6q1ITrOyJJ7iwtcLRaXO/5AQRmZKhWeQKJHpf87ixrWRZvdiF/QKv5yebgneHd6B510Zk1tWuBkkw0TioznyFX1lb1an0k9D/fJ4a7nQPpPvbW3YP0b95LTn2bdA53eA37wboiLvD//T6WDN+JA5RnUHK5puB8hPX7LpCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2c44422eso21122425ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 15:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724020744; x=1724625544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3BTXGhifwOMjDbCZo0d2Ej089WynqAydAc6O/8cTpM=;
        b=iPLEX/Jx2fmwVhWXozJI6Z4Kb5vVZHTJ7MyZzMfFWG8E8EZAZXI8TvGhs1GODW6pFh
         rlCQXBqGC4b9zQllJPI283/7lrB8U9BTLc4RNeh7gPK/HT/3hUodyjUYEPbvCrEV3no0
         XQo19prM10EXsRmp16f1CvTeAS1m2R+GsP9WJ6/+qECfupnf9bG+p38cqYw68XySVeQT
         lFO8nHpPJT1grF//mEfMwY77JMClFC6LfqUjLVPldGWTeObH04Ee6PFwJOz4FezGvfHr
         FG839ayFyqNyunySzXAcoN/vORRYcTR178MO87IShYy6Kbz3hdhn5nOjnG9CN9kPNpDW
         6d0w==
X-Forwarded-Encrypted: i=1; AJvYcCUblJ/8VK6SN/SGyUvnNtrUg0ky5pmyluyuVKIw8oCkn11v8Zd+q1KW5Kb7EgDSTjlsr9x8QhgSM5RpUM6ogeSJgey7edQ4I90BYDtx
X-Gm-Message-State: AOJu0Yx06H6WroDR3kmxqNHXhYnRqsCg0DjIeCkfc0V7TfyTR1An/5mm
	knvfV2rX3mC+vDjubE6d6vSN+Nh0ZaQ0KQ5bnOuHGUYLpQuHbTKQVMqiv+H0mQJ9BTWg7RJRDLn
	0ixfHlZqXzItPz3jeDTLECK9B6Ru7aS/tSt8ilo9CCVsomtbCu01DrF0=
X-Google-Smtp-Source: AGHT+IEUH9iw47JklcMyfGPT+cYEsOHrLiWsHdC2DH7l27e6NGU+vPe/ZB5gj9tT+WjGfQEnrLCCu88B9AcB3sbvZ+ZyJ+vFqmEZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9807:b0:4c0:a90d:4a78 with SMTP id
 8926c6da1cb9f-4cce173107cmr629135173.6.1724020743715; Sun, 18 Aug 2024
 15:39:03 -0700 (PDT)
Date: Sun, 18 Aug 2024 15:39:03 -0700
In-Reply-To: <20240818221048.813-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003cef3061ffcdca7@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in __alloc_workqueue
From: syzbot <syzbot+9fd43bb1ae7b5d9240c3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9fd43bb1ae7b5d9240c3@syzkaller.appspotmail.com
Tested-by: syzbot+9fd43bb1ae7b5d9240c3@syzkaller.appspotmail.com

Tested on:

commit:         367b5c3d Add linux-next specific files for 20240816
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1008f7c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=9fd43bb1ae7b5d9240c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ccd8dd980000

Note: testing is done by a robot and is best-effort only.

