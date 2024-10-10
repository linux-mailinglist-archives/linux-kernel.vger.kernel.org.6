Return-Path: <linux-kernel+bounces-359065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C336998703
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6CD1F258CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FE1C9B80;
	Thu, 10 Oct 2024 13:02:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B691C7B6E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565327; cv=none; b=Ve6U2JptVKjUgQX7RoeoQQAf6025lCgEQvmEalteFFni92suhkpARwoOpNiSx7ysQgv4QhJG7wiwWyxfIKJh3kqJaTlZvssyV+kEdMm6aUjXJYxsSdlparPoXG+7Wc4OPhfHHrdIsv0mNrkpsLfszelw7kWBmW6XuuNEVVdXw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565327; c=relaxed/simple;
	bh=DvHbgqpLU7ICqGWKCGYvq9HX/D/ooIGNcJAe1yUJKvU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UiyKmfyxFfcv7TVC+m64RsZykzhcpVZv+dMKke8nzod1ehZhLIMDHgzs/yuCYLnYvu6nNMb7k9JFnoTwJkiQeuYd51E5g4jKigH4BZFRIkM939GFwEEPrN/M45gM/q9Cu3V9TF71AEGVXg+5ZpA6V9PjR8LuoNP5td7U/2Pj3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3453139c0so12228215ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565325; x=1729170125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlzEZSa2v6vzclZNmLlH3ROi34p53NpNk/Ushgepg+s=;
        b=j+4HN5FzUlQZP/DFjl6ghvWxD29lLur3DQALTN79XbRusSiP8ykOcIK2JCG6cc0bRb
         vh5+OiAs1Gfga98ysTJiSJHgt2emH1J301MZHyjdQ3eFO5GWXPzKhQCYFLHikTiD/lYU
         eQRoZgzCaXYhujygIGAG7Ds+M3qi+rzZSQz+5w9v4hEAKHlCBbGaYkBMYTUCo3m3U5UP
         wVdDFH3Q0H3rfX5mKfVJBWq7rkIptkgZqkgvljM1MKRpoBQ76AEsNjidKJ/R6ddOgIcI
         z0ZRaKK8ZK/zhaiw/6BV1RbWErDStqNoqJY4tHOjqhq+rAHnjw5Wg3Nb2mGY0uKxP67T
         rlZw==
X-Forwarded-Encrypted: i=1; AJvYcCWsaEXFrdzW1yj4r1R7Uva06K6plQX+0uR5LyP64kqVIYm2tY0N0Tntady/umSTf4Ys7Ns4WKLvDh8NpnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyum0U7+W/TTgp6SE3PBYXjKBtyxImkkPiey5LKBxugGbibN1dV
	rE2Z02TmuY4NHvytZjCeR7z3w4KPRpIgq+tma364BV20nSXJtUAEqBdhcp+jaKZhlT6pgjpE+6C
	WUR5/jPRvrmwEF6/OvVySJ6y/tdcZCaWUinXEoBLfh/UccZH3OZ14HyE=
X-Google-Smtp-Source: AGHT+IGDoCqqGxhFLcFehZ6h3fw2iBAm6gSU9FwH5FG3zniTPo/8s7tlixDwcVYGQfxFJ0PAMi4iw537YA3Lz5B3IkXuIEvWHz8x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a397d1d555mr60454095ab.19.1728565325434; Thu, 10 Oct 2024
 06:02:05 -0700 (PDT)
Date: Thu, 10 Oct 2024 06:02:05 -0700
In-Reply-To: <670689a8.050a0220.67064.0045.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707d04d.050a0220.64b99.0018.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] BUG: sleeping function called from invalid
 context in getname_kernel
From: syzbot <syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 94a5b169bf5c7c47d3b1af759cf70bf1ab236ddb
Author: Qu Wenruo <wqu@suse.com>
Date:   Tue Sep 24 03:22:17 2024 +0000

    btrfs: avoid unnecessary device path update for the same device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c96fd0580000
start commit:   33ce24234fca Add linux-next specific files for 20241008
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14296fd0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10296fd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4750ca93740b938d
dashboard link: https://syzkaller.appspot.com/bug?extid=02a127be2df04bdc5df0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112f97d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101d4f9f980000

Reported-by: syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com
Fixes: 94a5b169bf5c ("btrfs: avoid unnecessary device path update for the same device")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

