Return-Path: <linux-kernel+bounces-421364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60399D8A35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A426028223C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B27C1B393A;
	Mon, 25 Nov 2024 16:23:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E261AF0DC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551784; cv=none; b=UkK57xUnb8PrRXhOIf0HH8C4mBn4NiQ1JtY8sdl8Tm1PdwFmef3rdVF/0njuaRYpRGniVvbCu5aRy88W6QTUR4xTajefIGZnso0BOBMjMNNkQA8iohjPuGEWTpqt09vVQYyi2mzFoNadvbJy6L2P7UttGIpII8S+KWso2ggh1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551784; c=relaxed/simple;
	bh=7npni6cuOgv75jnjNETaMFz763fjtSTXZSYqeIF20ro=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TRobwmlb8GIsqzUmF3Q0/gdHsjW0hI+h4QgNiI6xcbYGa2CGpx6xYYz0fqK5aAvKHm4T+w0PGragazSs9k4uYU9JR9V98BOaDW+gwRjGeJppqYugHPzV7NbY1xJ5TWJd5ldr9ShSiyVrEh92FfPtMDmDWtqYA9x+W789ZHlJ6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a79f4c0729so39116155ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732551782; x=1733156582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc6gCtvj9QdIHA63OuJSzPcjtUJBYgM95nm/z9bSdNo=;
        b=s8BBaOjtkPc5GAWU15MXYL6PQZ3yWqyK6mcdmruipEA5KJ8XvYKXUqkJDn2i45cIeq
         0KHmrOoYNLKme19AqY3kNqlh5jwRr/Pn8kvOVPw7MK3h+btqBtcY+93y1por/CFIIXek
         zU3d/VJCe49GfFj9FYVWxiVzQBT517WiUw717httDxBDb3crsmKCfs8W9ltYq8PLW2jR
         5EYU9v0mNCfGyvBtSMWMSX4acdLaM84kkPe51EgUkRLDKwt/YxF2a0QWz0FwrDgxnWam
         7vd0LuFiSOAp7d03P5Loqk/zW2q4As+HHuXDo79YNWZeR+YyeG0TcZMK9QS97nTJcgXi
         Ktpw==
X-Forwarded-Encrypted: i=1; AJvYcCU+jU49MaYMRE1rStKa/YG+Sja4eAuCjgKmFfv9J9k8XQMQEj+5c68tEiWDI/3gxS5ctJH99hUUoscvS+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNvNdttxf+xazZQm+3tdm/zgXEF/JhfUEE/OtCAyAiPuPqU/h
	eIm0D0/eaVy6cuEIE9s6AABHdeNwrKJszeXzTjk5yciiQHxKDlJJmPlZ1sJiuW+ex9lfKHtt//r
	Hytxp/WsF1qv3MD4Yf8sNMeUU+UhjFtumyJwNRe/sgE9QnDDjxiBSSVQ=
X-Google-Smtp-Source: AGHT+IGWq6n4Ib0cQdBA1JdYaTFUW5FIHqJWrr4sE/PPHoVeYMfqhass8dNQRYvsbSbAzs237UnXwXoCLc/rgF87p94cUo8SMtz5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:3a7:6c5c:9aa4 with SMTP id
 e9e14a558f8ab-3a79ad3f742mr141112135ab.12.1732551782383; Mon, 25 Nov 2024
 08:23:02 -0800 (PST)
Date: Mon, 25 Nov 2024 08:23:02 -0800
In-Reply-To: <tencent_C397C636464B74750D76ED66983D37374209@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6744a466.050a0220.1286eb.0004.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sco_sock_connect
From: syzbot <syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com
Tested-by: syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com

Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101b775f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7393f07275e8e571
dashboard link: https://syzkaller.appspot.com/bug?extid=489f78df4709ac2bfdd3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119edee8580000

Note: testing is done by a robot and is best-effort only.

