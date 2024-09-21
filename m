Return-Path: <linux-kernel+bounces-334812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C794F97DCD0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 12:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB81F21E34
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A7315573F;
	Sat, 21 Sep 2024 10:10:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49337171C9
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726913404; cv=none; b=SzldF+KHSeDgSPHb8nf8Hhq0T389WDCubg0GpnijLGZm/GxDBWNuzFk2EKxqX9ei6gXT8/3/MaLjPzTQLYUsRQD2TKbShH6yCIteb6zC8NS7l/5AM/DXyuX7N+JhNtD/xWYKuzZSlj3ShN/79+W0tATui4dpXtIyWIVMQFyKSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726913404; c=relaxed/simple;
	bh=zgzjFH+30r8JdN/b3svV48cG3o3q1x864kFUSRSkVpQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CsG/SK4/IEPuUM9ReO6m/NF1edCGUVqqGn/66aJzh9mUmjR3jD5AZUl1zNTI2FupC9MhoOwAzliagN8PAGxd8/H+imazue7Vj6gpo9rOC22IOwbUvvw9k3yGVfaVa5pEDtBfkycePn8Voz5DBYRiBfY6bWaH/0xt4DAnBf19kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa467836eso511047939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 03:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726913402; x=1727518202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgUJqnn2mEX448eRrv1Ga7y7KNXabZljQEenAAc/dTU=;
        b=HVjrg5zxdmli9sI21fUtZ+MRUNcEZXMWJ8lrn9u6PG5/GUjDzDPmlmpVztaCRURWwy
         Yx7dIrblfmgmHYghHQAkVKT3IzEX4tQ/ukQ18Go7egNgXNwi4b2TAH805kjSRJa+CQB0
         cVKuIzXu66NGs3NWjx06TAY1aSfLgK+uQkbSg/NUAUUnq9JLSRGAnyz1py2pGTssn1Un
         l2fkVD5el5do/5SIljcuRov7UJikg6uWq4MAdf/Vj6XYt/fooe/AbZoMDjgA+i+SfODj
         f3AJS8tobdyYaFHrAXq6w1EV58Dn3jo8HACAVuUjR6DRGkoeoRTtC8iFuQRxAYC1ZWDv
         3YIg==
X-Forwarded-Encrypted: i=1; AJvYcCUsJPh7JO2yUEr0WL8KktYAWbRJ0DhRyyvUnODpn19dack/LYiKqF+lvrOBusgbNmeQf4ZL2pQC5gOMLHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLryYJoZBuQuhpSEVRA04Lq7R4rVdel3k7ipxe5PXOLTj5QfD2
	acUhUgyPtD3CiVpf8snvA3wj3S1NiD2lJJledkmNl8QP414WHQ8vsOMvyNVP+8tZjLFk4jQHptd
	ihIwVbEw5J1V/RcY9dFbTYtffjlO7QZKx/6RXu6sGG1Ko7FvAUXYXD5c=
X-Google-Smtp-Source: AGHT+IFgdNeWyNLSkArQwW8UyOVedACULK6yUayZWcdv4I02Ejx2qaEX0rg3imuwkTVWJiTAC7O+O5WcwRZorbFhTPyqcEEc27Vf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4d:b0:3a0:9a32:dedc with SMTP id
 e9e14a558f8ab-3a0c8c819f5mr45325455ab.6.1726913402370; Sat, 21 Sep 2024
 03:10:02 -0700 (PDT)
Date: Sat, 21 Sep 2024 03:10:02 -0700
In-Reply-To: <20240921092547.968-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee9b7a.050a0220.3195df.0049.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
From: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com
Tested-by: syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com

Tested on:

commit:         1868f9d0 Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156e6427980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a0a1caedf9d578f
dashboard link: https://syzkaller.appspot.com/bug?extid=7c48153a9d788824044b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13e66427980000

Note: testing is done by a robot and is best-effort only.

