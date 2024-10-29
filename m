Return-Path: <linux-kernel+bounces-387709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17F9B551D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A473E1F23CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9653209682;
	Tue, 29 Oct 2024 21:33:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD220720D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237585; cv=none; b=SgL1cbJpZ1ObLM0MYym6ftz2sZNMxRIXArc0ofBNeN6jNM/gRpqkmqbladdGDAMZCDw0KMsajj5YloZIwQgzEvubPt/6t9eY5XZgNKGJlY+VfxVYAHoz6OKAqM7RsxQNy9ZmkfdeNY0iVK3AYZsXrqGH+yBCUBBG1nzvvilVVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237585; c=relaxed/simple;
	bh=VeJvu9Pkvz0Q1axoDH8qBwoYMovix4Mi5VeqyHoqBSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=efHZNBUX6FIsxu9LgKnTGdhdEkM5t6yBsYsNwKEIXRNuFBdQWwGOmROWY11CGJg0Uv7hK++v8TqQ1WURnashgw48CecSWXlxPyQr6nts2nrz+/oxxg7LscPGiEtG5fuw6ydeCyVXrXFMaZwztAWIeEVziJDrzoLADGvGPfPoSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so55173945ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237582; x=1730842382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52dNbTblZKRoHsNeKZM9928ah3VMeTxHPdRndprncPA=;
        b=IFgkrSYOR+gPxMIe1G7ugGDJ61F8Hq9JlHx79whfMRl9JTHeDXsgoqIuNplNjRfs/F
         f42PZKT3sa4qLIywc8/LwqwhbU0sjceXLIpHRlDyZaYZuB9c2cBHmXW5uAiiyfebeBfp
         OWk9Kux9KdLOHmczp8E7a5O/4i93+StqZHbvzBzrvWbyN4VoHp7XOxPUa1Jig8LFvVVs
         8quZAAnsypQU/eGv1nP1/fV7RY0GtD1lwajIVfCAES3Mirzv+9/DpeQ1kajWvv8qx9Yt
         hW8t2pJifsyZCUnQwDbz1iTqRy44ZoHtTEjZAyi/dPm3hBGHIT1OYr62JOygIHMvLQka
         Wvvg==
X-Forwarded-Encrypted: i=1; AJvYcCXZZrnMkzBEZpIfPSFHbudAuI3TRBLRNc3+FGFb/2avXhgF672zAu338fdt0rCRWt3j6T9SYFSzMTz95m0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4E3Y6HVM3M3tdUuC6HGQH7NqhCHvCB+pjIdT9ENctHAx8Coj
	Dk/RT99gJaCYYBSBiZVD8SIf+LMi6MY+C94z1nv6q8P71cn1YwrK9BvGl8sdd2fy4hkZcQcr7h2
	jHjvNm9oNmb3vWDoM96o4HONkSpP0GIJweS8N1biY/xtI6/nw+rwMTIw=
X-Google-Smtp-Source: AGHT+IGx9vSpZDlzRqdfZWOjJisS50sBONY+503w7BRzuvqYoBx5Fv8wyyTm6o9zRjIw5Bp7ZuYBCqe+zuqWS3AlEXvMAI4l4vG4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a4:ea4f:ac9e with SMTP id
 e9e14a558f8ab-3a4ed30fef7mr128699265ab.26.1730237582732; Tue, 29 Oct 2024
 14:33:02 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:33:02 -0700
In-Reply-To: <8734ked3op.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6721548e.050a0220.24951d.0077.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: Bad page state in bpf_test_run_xdp_live
From: syzbot <syzbot+d121e098da06af416d23@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
Tested-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com

Tested on:

commit:         b6260787 Merge branch 'net-phylink-simplify-sfp-phy-at..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177d4540580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a787ccf76ca91592
dashboard link: https://syzkaller.appspot.com/bug?extid=d121e098da06af416d23
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ad1f57980000

Note: testing is done by a robot and is best-effort only.

