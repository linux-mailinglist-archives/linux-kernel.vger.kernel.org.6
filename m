Return-Path: <linux-kernel+bounces-510247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B6A31A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0225165466
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8150AD5A;
	Wed, 12 Feb 2025 00:12:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962F5680
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319127; cv=none; b=eUiAQD7QSnZNrb8utbjP7nlcauWi1pghCLmCTxMXmUJPQOhP9yIrg/OUYfUiviwkyYbZYd22hdwMbo83B2830yN3PDsEqODUIZwrk8gLoRyzICFFgt3qBBVJwRpTgR8JL4digmKv+UYE9+GLvmHZMQn4mEQ9iTE0agZ7yWH0+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319127; c=relaxed/simple;
	bh=lTNFf4Jx0DppvCTHNRWXbbX0IlUtAkHFNtcMNoyLjuA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ig6N5EBmldVgzSLv51ZpMGwrBVW7sGG1JGi9nsspOLLyb6vBWEDAbkf2MGMJt9lGVFdCZSjrMWr7eYlI5pfkS77bOk1UMXlyZunhz1KaESuUxLZzGgwyPkGcY9oCaeLAaCGZQVCxVW0U+RZrrs+CS1ImI2/E7VuvYqstfr4fnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d14950ac9fso89937005ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319124; x=1739923924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcby8ZU87RNOZKSbgTgPZzvARbN7NcsN2AvvMArHDO8=;
        b=IHKlt54HvjacGwdVhECfOVyCiVqi6d8ezLQjHLjNwQ9snA/pzLygkjVOfkuWd15Xe9
         fOACb3bpWHc4DJb4fbg7UckwLFD0OEKX765EaY2uoDQsusVuMpJuqi4OdSPvoe1nCyQx
         TpWqz2pAEpK3Kw75VBnQTM8+JPuE+wdk0FQW//HOzASj87DgTeZPkvfOXZTdKejwkxUW
         40LCjhFEkZTbJV1Px/Uf7SbPszjFHMEaWpsQ/KqtIpjLqxftt/wG9fCk/W7zwk9roU4W
         6pAU4+vLjSrSj0ygl8grFbOaaaUcWlzI3DOaeG9Lky6Jpl81brrdj8A8r1krm44D5rXE
         tV9w==
X-Forwarded-Encrypted: i=1; AJvYcCUkEN8RElBZEjJ4MuIGvu0/IX30y6I33pugyTkFx0F1wE3H2mjjlrQ+Us0BLJa5JR98MHRlOpm0Z07TBmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3m/nSeTP/+zUOYsCTEa5yuqlTNps435x9hcR7Wgd+cdlk9x3d
	8LbYZDGwKkB3YzhwzuuUdHZyiwVY+On/Y6v3mz0Ys3G9L/ym7JI5o2gkWyiNeP+dEUOYjrBWKh1
	hA0yEAVyLzjb7CWSjpaTZoWfIeCM4yiRPhyDgCEP0zXjNtscRj1GZpYQ=
X-Google-Smtp-Source: AGHT+IFQw7fOY0zdY8DtNJHfAdT70+GKEMvEgw1UEPaZBMTu8krdrmGiVArsyuWS9dDrIANfBKIJW2a7sy1tjmR4nHKItSnXXVqj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8a:b0:3cf:c803:1295 with SMTP id
 e9e14a558f8ab-3d17bf4afaemr14924365ab.3.1739319124092; Tue, 11 Feb 2025
 16:12:04 -0800 (PST)
Date: Tue, 11 Feb 2025 16:12:04 -0800
In-Reply-To: <67a8cd8f.050a0220.3d72c.003f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67abe754.050a0220.3d72c.00ae.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in h5_recv
From: syzbot <syzbot+b5691bb559396b262064@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, hdanton@sina.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c411c62cc13319533b1861e00cedc4883c3bc1bb
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138cdbdf980000
start commit:   df5d6180169a Add linux-next specific files for 20250210
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104cdbdf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=178cdbdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cd616b6e736ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149c78e4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129c78e4580000

Reported-by: syzbot+b5691bb559396b262064@syzkaller.appspotmail.com
Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

