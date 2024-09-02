Return-Path: <linux-kernel+bounces-311603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60FE968B06
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B2E284119
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24951AB6F4;
	Mon,  2 Sep 2024 15:28:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0E39FE5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290884; cv=none; b=bTVul8tDFnQM5K7QDX4rOyatONyVRxuhRVBlkYjSviggnQyIVybhu9+3C7J8WIfv51QLRVT+r5S1w5bc9yv+50JPLPDxr5EoKdrdgghi6jpZ+lyEUXbQmY3tXKvrYCAir803yKAl1wvT2UoCDiMvhqZgDJAzxLSd5Gtv1y/0Eek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290884; c=relaxed/simple;
	bh=fcsvwgJHszrqFYBuVGMJyWBjEoNkn9u8s/Qvo7dREkE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OOQxW2JB1WuGe6yJw+rYIKmGN2x2mpkaFiiY77bqSaOfKw3F+JiMv1eYTnCYMKkwDnleFwNCOmcaG2z1PizuciHtecdPy3t5MkHfEH/AscBQZF1J6Q6UvxpA/2X3myn4s2W3JlukyodQmV4/AfcLfxB8aFDF+wOiabZJphdbbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a217cec1fso466343639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290882; x=1725895682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPWC6U8f2qBdEbiB/1tHLk14BDYkG8mFDHPKIKYsGpk=;
        b=YAKE/gD1li67GvwxR8TsUSWVPfuIzhKT2l92v/e3UnfORjyktZl8lUAPhF1Olbyeei
         /lFJMNprplkOYtv3c8+bUpnzVcUE3TQhhJWIWZ5/G1kP2a+0LaFsWc2VIcazH8ZS/+tM
         vHfqHeDHiGP7j6wli9VAwJfmcOngzyUsrkMzxx67AhTAyAb4elLfnLIgpJG3NhkoUsAv
         IoOZL+nGTu3eyP9UnDdwxtgSNflfTSZDSyvbbEU0vyNKO4iDeHnTG+I/Sz+5QGSeg9Pq
         mX23Fv61lBH9QYnhaTz3VBfEpvi7A/mbPC3YT9WdOYDuq0gjwDayDH0wXq/XzdA6kmhW
         cAIA==
X-Forwarded-Encrypted: i=1; AJvYcCUfP6pzUCxToaCl8zwEzBPoD/gMmJv/y/vIY3M9bm8JooWBIs2fJWbICicko4LUt8pShJV2/GRTGKiW2VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vDNbxvaQVf95F/heaMwhzLOiJRkPJuUwqDqUN5B5el4sGPiY
	cNOQYmjtBBPtETXJa8JE0iE73Zh4Q9Xb1lqLaHrAv251z9qFot4C14CLunW2iXPlfkrKtKQe+bJ
	+pCqdhEWIYlLPgAotxc97sfEDOEnmyuzfODbQevJMPPicY/cWaqFul+I=
X-Google-Smtp-Source: AGHT+IGYE7aRkq1QdG5CqeZumrhss9UwB66VHx1USISJdAEcgiBS8pGvcFiBithIiWwzkPxwiT2pBaJMBi9K1YaRPMlswNp5FSto
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8704:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4d017d77c32mr899228173.1.1725290881918; Mon, 02 Sep 2024
 08:28:01 -0700 (PDT)
Date: Mon, 02 Sep 2024 08:28:01 -0700
In-Reply-To: <00000000000087bd88062117d676@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026b5250621249667@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in page_cache_ra_unbounded (2)
From: syzbot <syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, johan.hedberg@gmail.com, 
	kuba@kernel.org, linma@zju.edu.cn, linux-bluetooth@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e305509e678b3a4af2b3cfd410f409f7cdaabb52
Author: Lin Ma <linma@zju.edu.cn>
Date:   Sun May 30 13:37:43 2021 +0000

    Bluetooth: use correct lock to prevent UAF of hdev object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a579eb980000
start commit:   431c1646e1f8 Linux 6.11-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a579eb980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a579eb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f8f0fb980000

Reported-by: syzbot+265e1cae90f8fa08f14d@syzkaller.appspotmail.com
Fixes: e305509e678b ("Bluetooth: use correct lock to prevent UAF of hdev object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

