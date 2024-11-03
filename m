Return-Path: <linux-kernel+bounces-393830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A09BA5EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A10D1F21796
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8C169AC5;
	Sun,  3 Nov 2024 14:33:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA34C81
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730644386; cv=none; b=QPXaeh/aiU7Iblkc/DTSMsXTTTqWkh3JQlW5wxtHLBRhGctrY3mURjI3iAh+YIcZANUGZ5nm7ogBiyXLhAR/Hsc+YJgwEj4aOryA9lMVHOT6ZtNsVQ6bv5YgpjKN45mqbc7qVrkkcZD93hbZEyAvaX15jkBzlS20qShZEkK1KPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730644386; c=relaxed/simple;
	bh=3MMXThTltyD3s2AVHKr+nHvoPa8+9DTeGQ+ofLQFRj8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=brpvcRn+/HRc2M8qalgHU9+yz4rRzAiovGCnovCAsVyVjoqoQQ/ojUJBWtdfQ94s1uWYqfDPYkvN4K8GZ5q+GB8tO+jlXmVv6htotPXEmsBwp9omD4BZlWM7LC2OW0ad/g7fBcIVVZEds4PBcLxk8+RVnmTZb9kkc72djhq+6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so34436005ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 06:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730644384; x=1731249184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4MhLqtyhUoJwvqRHTYgi5EciCyhyTWePOhj4PeFm4Q=;
        b=aGVBPPpHZD8CQ7ui6krddd6zp8hDX95zXEwbUaSkKVK3pkqQdkcDurRMQ6K+qltfbp
         +A402an05S+3YA1UIq3jpWqT8LBiakl7AHRYdJXpsMICJ0jygjKR6+HRO4E/9Sf9MGWJ
         +YI9U66yJfY62MlmPPoqlzPajiZtWHFBEITz6hZuhi1VaSxhYGl6TH/hJ5nrBLMSzp9Q
         uFXT7ngy1MM0iSNTUaE6Mu7jaHpd7UeamhM9+PQ5A8f49qqYkkO8CKk1FozhFC9OKvYb
         zw5Oee6KZVB4oddL5mD6PTW/PoT6o1jEZ+CR95WYggRjcNIlKwthLXU7fcgGzWD7PKpv
         GvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmlSwiumfWc2vJdlqreAm5aKy4Sk5Xw5mIMCyCamonNBh0jpMSX7skg0AytZinkifwkHikbc+o60W8V6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPadiO5kUIHS8ZKpqtpJP+nMzlatEmNCh00lzxAloFkx9qMepf
	BUVGFSewwi3dzdDbS+0ix8ptkErgMxtpOA6swnAaVi8DKnoiVFqTlMIKovuNAv6VS58tSq+137v
	i8QAChYEJAn+xKPW3C7H2qPJQalP+KZ7VINN0PGy3WL6WAEby0YaWC3s=
X-Google-Smtp-Source: AGHT+IF5vT99jFs0woB3oVa5ZgruuX3IFh9NGX6KxSKUdRjjLYtTzwMsy5l9W1Mu/wPvqi/0HuFZYOjn1hrcYrTvyIjRw+lGwxb9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1946:b0:3a3:b527:e809 with SMTP id
 e9e14a558f8ab-3a6b0327357mr82159245ab.14.1730644383756; Sun, 03 Nov 2024
 06:33:03 -0800 (PST)
Date: Sun, 03 Nov 2024 06:33:03 -0800
In-Reply-To: <tencent_A5864B09B4AED4AEEE8CB467D086DB52F106@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727899f.050a0220.35b515.019d.GAE@google.com>
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
From: syzbot <syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com
Tested-by: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com

Tested on:

commit:         3e5e6c99 Merge tag 'nfsd-6.12-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120f6b40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f51a2a34984e4d8888fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fcb630580000

Note: testing is done by a robot and is best-effort only.

