Return-Path: <linux-kernel+bounces-438698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08969EA484
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D3F282842
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B85A60890;
	Tue, 10 Dec 2024 01:52:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F222E40B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795525; cv=none; b=eXFXSjJbW5haY2OIgT5RTAZpXwkdKG0DBe22S0pEsKe5cYpwa0XTFlEtRUdYe6j91kQA8kU819Ei4jydFeUpm9vKg5OC9Swu00Gg78jyT9IYGVtsyNmW+ACgxZd8LmSZRP7rbVys7MseDVRP4NyRPmQ6zf69/pDgez83IpdZW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795525; c=relaxed/simple;
	bh=XZ5rJZdSSeDMXe+njg5X+TJnA0gJBrDHN6wGaImNUao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rnr5rlHM7B20GI8u/JGIUaZwmc8CGmywvKTcSCBgbEk3PZvkqAMJT3dZ1q+9gO9PnkJDaZgqSZa5Koa5Kzqt+koE368xdIIC1h+ZiyPVlkhnmMfmG8CrcgtrbW6Hrh0tSMdWpaCzmkBQ13BaegCILym6XiaxXGCOhxIsbfzdg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so79016045ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 17:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733795523; x=1734400323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snfkp8/PsE5XILyGuktmVfT1OY7S5wn8en360NLQ4BU=;
        b=GCHfWFGq7rcy5E+9TLbDDYnRv5Abt+KGAhT00N6FgqfcKS54MS6Hv1n0wMqZ2QARB+
         8VRLWzp3mOL5yPg+uX3FeMrL0Mvk8zoicMPLuNUej++cdzk63MLAvOffcElgVzvAFM9Y
         LK0XxrZorTyyNzUwps9fHToi077saRavPX7IB9ajo/nNvBLUJUNyAE79ZeSgVYt19hHA
         D9X58hE9h4/0SJ0+mvza25iTkn3xjcbK3RbvIOso0Z6bHg9QvP8C8a7Zv7b/4+9RzvLz
         MpSKnThg19/5CogBPImAUvMdupZJo0kZenuH3muzJe8ktCeOx+F1L7TUYSSgLFdlcaLX
         mbtg==
X-Forwarded-Encrypted: i=1; AJvYcCXU/JnoVdfSpkwEFxRaRqqvfHEpiFEyfP76qQV6C2hnAZC3yQf4VOXEV0Mw9sltlcddxsQmwrlsr++G5Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxto3wUxJ6OK43YlgW1GZzmrCVbdkyAnBEJQi1gBnlsmM6zCP6L
	wSyL6rCDbG1feGoEj+8Gz9mWMTCYkGunaBBQFQAZAhiSRCj/RU3Ws0ZKvfVLEnFpWCSfJ0eWdkY
	f1uZcvTdDwGRWymGs7FeU112zFM9TF67LMt/n2IpjjybeZnCi/SOjnMc=
X-Google-Smtp-Source: AGHT+IHaXhXtGLORd4uMnI8CuwdNBXP7KKtMohCt3bY/8LWZhhFtWwo0HMhl938d1SqhovhcS9UxES/Q+uIEnx+iQHuYFHgVlMWV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194f:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3a9dbac589bmr27629895ab.9.1733795523286; Mon, 09 Dec 2024
 17:52:03 -0800 (PST)
Date: Mon, 09 Dec 2024 17:52:03 -0800
In-Reply-To: <67571760.050a0220.a30f1.01a9.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67579ec3.050a0220.2477f.005c.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in lru_gen_add_folio
From: syzbot <syzbot+7d6336b144d8db5ad602@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e8597e91699a67c27ef688640b4bbb702e0a2848
Author: Yu Zhao <yuzhao@google.com>
Date:   Mon Dec 2 03:28:23 2024 +0000

    mm/mglru: rework workingset protection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110193e8580000
start commit:   af2ea8ab7a54 Add linux-next specific files for 20241205
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130193e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=150193e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=7d6336b144d8db5ad602
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179d14df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13be48f8580000

Reported-by: syzbot+7d6336b144d8db5ad602@syzkaller.appspotmail.com
Fixes: e8597e91699a ("mm/mglru: rework workingset protection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

