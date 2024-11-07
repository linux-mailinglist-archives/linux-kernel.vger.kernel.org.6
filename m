Return-Path: <linux-kernel+bounces-400654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489EE9C1091
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006741F21AAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83989227B8E;
	Thu,  7 Nov 2024 21:00:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827F2194BA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013205; cv=none; b=evvCekI96r1qMBhKOxuyW7xR0LZBksalF4khL8Hyhc87Wrzan2nplEIdCRD44yQ+8I0juZmauftaYshTdPPPfrQZ7MzpvHNRhAE2t69fm9h4cVXBycQJljXVdEUlIinrM4zBQ1+AHEQLun/Nsc7J6FivhJ+uP4TxovQdJzpETyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013205; c=relaxed/simple;
	bh=evuAZfwARYeCSa2cm2Nesuv6RzOCU1uIBVESmfQXmVQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=URKp7KqFF7WytuQjYnn4fY9lX1Y5vz0yXi9rGZ0LO7yW5pWbqELYd/VDdz9dmzAXmy1eyT6ETSbHUTHfaCRF0CnjX+xtQSyetj/vqf1dbP3iTskW23JEIwl+u+ab8da1BHoFA7gfcQ5bXCYwc1N83EHVoVzarEOOfisti/dsWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso17826245ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013203; x=1731618003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTrEnJ1xflwqCs7uDGssRRRQgcKDE9FD9zPoC4Iw7Y4=;
        b=JF0ruBhyrmaCsA3iK0fsWrf33OxkJ1LZKubATwClfpvoYV5S/QtBk3J6c3lF4OruDM
         S1Wl9gm8ZYJzw/5zkLngPp1d0+sXAXrx980KP+9LlbZmKf+oqILPeTUPWLXW1pbu86Si
         cFSd5bHJbGGXmToSDb02hW3Bvv6S1aRqcyLcv17C49gXYszGvrs6FA1qmnkqJ5deuxAg
         3axpNHsObauKSDpZ4ah/jMQk51OYGA+9b2Y17SNaumrLtl/oujGOonafTqtTCwiz9xHj
         llR2oRbCaFGsMP9uc7FlUfr+PqG+GTbmAjll9DveUmwbZnOXwLFkQ4G4vJl39Hkqfqeh
         XcVg==
X-Forwarded-Encrypted: i=1; AJvYcCX2YkCqo/dfGo0aH/upRoKm0xIwQ3Rhpd6/JJzVh9T1WjmE/db/bsdTCenY5QiWbZ56LL0lmfXcHhGLMyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMgyOJyUxIsBtIIvp5h7qTvSzRuwkj7R4Xx6eZ3UUnD/oglqS
	/tv7+k3E1ZRJ1k3i5IcMn/ahlY4ya+By/H+gt8XGXmXuI/RVCwBEZTcThNHzPxuzvsGbJiFip9r
	1rc+nYR4YN9IgdhTd6j2+RTSTqk6cvKLFnx426RmzvQzJJJzE7ytXtMs=
X-Google-Smtp-Source: AGHT+IGrBL1U6cNT6RMq6kbV3aJN0roXyvrWF8AuSTpL3ICCq+J0m2t4mi8QINXdiS9OI26x/DXouMPb0CEyyz0ge6nm1QVBqTqi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d96:b0:3a4:db10:742d with SMTP id
 e9e14a558f8ab-3a6f19900cemr6935535ab.3.1731013202847; Thu, 07 Nov 2024
 13:00:02 -0800 (PST)
Date: Thu, 07 Nov 2024 13:00:02 -0800
In-Reply-To: <6723db4a.050a0220.35b515.0168.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d2a52.050a0220.15a23d.01a1.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in trie_delete_elem
From: syzbot <syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, frederic@kernel.org, 
	haoluo@google.com, houtao@huaweicloud.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, peterz@infradead.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 4febce44cfebcb490b196d5d10ae9f403ca4c956
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Oct 1 08:42:03 2024 +0000

    posix-timers: Cure si_sys_private race

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129f2d87980000
start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169f2d87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=b506de56cbbb63148c33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1387655f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ac5540580000

Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Fixes: 4febce44cfeb ("posix-timers: Cure si_sys_private race")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

