Return-Path: <linux-kernel+bounces-316521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1796D0AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66816287CCE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE937193411;
	Thu,  5 Sep 2024 07:46:03 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E006156C49
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522363; cv=none; b=LeZ5lGDWtMdgUGj4906eN06FU/Lv4N8FQ8YV4b91+sO8eKX0OWgINqcQbvfa+gEX9SQtL2lKxLds+jzawcUQdPbnplQlq9F4QJF5J7tY6NE2AiwWyVxqDdhdtxUP20B44GQK27wjI3Tj+75GK4iwm+SzPikxN7dU3h/yu6yDQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522363; c=relaxed/simple;
	bh=SyxsvJtcJVqaiQHgUJLuRt7j3v/axmlctYI2RnXBQtM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LV3GOaxJa3hBlwqPp30IUO1IgZvQ7W/xrxMW5bRg+vfGc+yLGhLXsukV/Mul5vpflYBVFn7QUqxwKaDQakLfYjtkTsWrcMr5X+mkf8lPijMEynksRpMR8ztgZNCpQgM9umo2tqFv3slA0MRx73q40Of3dBTbe/7SuC72bNIYEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a72792dacso78996039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522361; x=1726127161;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0F7zeBTWaDC3bvDb+oeW8Ic3uat3Aamdf19hls7iZw=;
        b=CmRViez4Es+fg/0yzNZLe0LDcgJoOhjHfG2wVM04PkO9NgJA7mP60zv1XbXASYN5Ji
         dskE51Gf4LkgenmoHs5aWxdJXbx7TtUeHEF+YMCAraKj4HtTZvDXELj89dvtUCDhBufw
         LHCf08Nj7lZPpppOAIVW0khQLpKDeTaL74O0O+qKgVJBan8nahXs5m0jNEggr6q2FXQ2
         5yv/8R4GBlLABbyuGXpoq9xcOX+vpoWgT9rOXr+LVKi7m9YPdTakAVeKtwQWM/uTbvaJ
         luNYGyBagjHo7ayBqqXSZWS1mifZxsS/wXRdVgN5myHTmAHqc9kt40Eu3s42ZmfMvjJb
         TfOg==
X-Forwarded-Encrypted: i=1; AJvYcCVkUR5nH+E73ycSgt3bkOncDNTCgooQYR6b3HS1ulbI9GiX2sfgFnnQD242IZa2zmJ7iA15dsEgP5/TlS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Yh4QBcPQNqM4wMcuq5LHGEZG+2sXZLwLzf3SGbqL7crFq+65
	DoAQgkiZxq3JXsMyYGEJisVDK5JPxeiSlH942TpwnqJ/7U2HVk0voEPLrlPvz40d+Wa+CuVrbDd
	jM7H7mfcwgFk6b6CJRUAL1OYLUapwLGNqooJHSeNMLYDZCTMtU01fsn0=
X-Google-Smtp-Source: AGHT+IFO1js3UnJdsjfFeMrqPiMcPXUxGOhgj6RWXAEOhvugYQxMc8QlA7TiXBcCt6c52xeAwAEA4qdEkGnc3o/tMwhQxJsyEH/3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c7:b0:4c0:9a3e:c259 with SMTP id
 8926c6da1cb9f-4d017eecf15mr966608173.5.1725522361247; Thu, 05 Sep 2024
 00:46:01 -0700 (PDT)
Date: Thu, 05 Sep 2024 00:46:01 -0700
In-Reply-To: <20240905065955.17065-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064fbcb06215a7bbc@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
Tested-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com

Tested on:

commit:         43b77244 Merge tag 'wireless-next-2024-09-04' of git:/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1582bfdb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d22d63980000

Note: testing is done by a robot and is best-effort only.

