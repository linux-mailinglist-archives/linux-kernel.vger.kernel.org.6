Return-Path: <linux-kernel+bounces-362793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F599B957
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056BC1F21594
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360151411C8;
	Sun, 13 Oct 2024 12:09:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AD13C9A4
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728821344; cv=none; b=Fk44laPpPjFe8kI7B1MX474x1SpYAi9dWKAkWpSEeKEyxF4yOZfH7BDlswwzVzbHdFySPePM1j1sRp6/81DSf41/gPt2G/6jUz+zqP3Y8ueXOa6IArYUDKtwAJf50K7NxcaaFZ/tXFsYEbOJMhiOzxhCXPKgFO+1TT8WcYL0i3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728821344; c=relaxed/simple;
	bh=1//wjsvC56hpGTmDuUZ2T4oScL4MK6KvU3Wv/21Pn9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bNnneS5TIPo8Dgy72NWNty6vpsuW+iEAl0Y1Xnza1glEwW1lNB3Olz6MAtMYpw1AfCsHBjsogk42HVNFjwBf4/p5Af0u2NSXbFT7rYyHnZ1J6R1UU8uZ5znL2ZHDBxqxIopFqThnAon0ei+1gLkXqcMs4Xy4YtzAycdPDfgcdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c9886eccso1938755ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 05:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728821342; x=1729426142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gH0baQP6BUi4dgqAeAGb6JNew30La5RpjGfm2LRlP8s=;
        b=csXTA0D4SM/nw/zASlgCwPhdw9lQUAAAsOH8o5MJNifaC7pO9d6kQxOnzeRmSC/8Mn
         tFkK6h1sKrNy7QudsAIgJfevznOH6RfDYctyRBnOZSJxs6P5tSrNG6KoEFOtTLAavNua
         wyLe5TYOTWN6i2CprZVT9vSB4RhVmJSMxsFc4hHV2n2f4vgtBTLUBw47kAeWKO9bfXNG
         UYJDP6+NweHHCGR5PLfjbGg8G/l7xUwaiA41zx1gn3qYVDBHk2vplcB945V/DJ6WtLQX
         VO1/m12i+PYhYjSNIVy1Ew472Pzfbh1e94GYCHZMZz34EFQh89Ip5fR+3PjcD5Ulkb5k
         rnfw==
X-Forwarded-Encrypted: i=1; AJvYcCVAFTC6Q/Tojduf3guTW0+OfRreXJDwaayhagSwr0bLelxbxzHINIsX0oHyF7+bET46c2W8MTYjQ8a/0Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXC5cwdE8nWjHLlGeB4rqRmg8tcF+Y9tGUbzuUtI0pme1bywE9
	p7n0J+zJ+AXH7hpLWheA8Q+N7mWUI68hT5uveGQlYoyUXuyQnDnOxDscSv9krQh453D0H3aA4qC
	mrEdAxyNt441wgwIqOYr+az5oRwVHNekpe0iHAqfxKfR/aJn8fdwgorw=
X-Google-Smtp-Source: AGHT+IF/PQtax4BS4UuOZQYDSpFuOwh/Ub4zyOY+zZbI0lfBW9YcyDGFYqECkoz/W0ode9TC7Z9zGRA0iZ3Vf1KoBOKAGXdSVFMo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a3b5f78525mr68063645ab.3.1728821342534; Sun, 13 Oct 2024
 05:09:02 -0700 (PDT)
Date: Sun, 13 Oct 2024 05:09:02 -0700
In-Reply-To: <0000000000004b09b90621e1e9e9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670bb85e.050a0220.3e960.003d.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_path_from_node
From: syzbot <syzbot+0772686ab2731ef3b722@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, takayas@chromium.org, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b6273b55d88539c6a7127a697c61d3f89c5831fe
Author: Takaya Saeki <takayas@chromium.org>
Date:   Tue Aug 13 10:03:12 2024 +0000

    filemap: add trace events for get_pages, map_pages, and fault

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f59087980000
start commit:   8a3f14bb1e94 libbpf: Workaround (another) -Wmaybe-uninitia..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb19570bf3f0c14f
dashboard link: https://syzkaller.appspot.com/bug?extid=0772686ab2731ef3b722
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aa1ffb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b1abc7980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: filemap: add trace events for get_pages, map_pages, and fault

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

