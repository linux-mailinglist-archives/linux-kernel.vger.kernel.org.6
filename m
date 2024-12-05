Return-Path: <linux-kernel+bounces-433197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3A9E5500
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D291883DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B4217F38;
	Thu,  5 Dec 2024 12:07:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652F21773E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400425; cv=none; b=lVx/G2otB0Ght9JSB+3rTaokjf/3zUrnpukUcJxW6QtJoy+eNRu85Nyh68esTWwP1ZzXtUq0pLflzzkUHtTbDibqCQUANYIB+yYti0cWaG4vW7mMKdPjEeff3LCOOjg5Bhu90z8/9cRJ3KqIZ/s7q6bAgkoY4vAAbpFkn6dFzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400425; c=relaxed/simple;
	bh=MJjQKu0CodsYV8YjqvAvup5McixA/hVWjKjJBp/q42M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YZ88qwlmUM3R0N99d76WbhoMQcqd0xbiMjNX7d0nbkbPxebqeW9j4YtxZdzqobBQFFuE6lAbJFoKFN0KLQzCtTARtI/VvsX4/oAVVmK/SrgO9qfc5Sih17NlFX5kYqhOusLkgND0Sg0nxZyLS3BpBf/D0uwlYgS8pReKyhZ4UMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77d56e862so6402125ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400423; x=1734005223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GC/GpZTgVRZai2kRrfhnrQjwJw8Vad/oPzLTsFRt5t0=;
        b=wzH1iFe0tCJ3uj2uK7xYBNM9HDqssOfbQWawZwj69c3W1+GIEp0UhW5QNV7Fa/4R6e
         9VZ+3LfzQqdQ94z4nNQIXyC/lqMx6dy7tx1iQ7/fYi91EZ82F9V6ubawtGuxwJckMTIZ
         yYHQLgRFXKVja/nAIi+LtPtkQNTt0sBTLzV9pmdI/C+X+P4EEW6KiYesKayevyBgLxCe
         jJ+RRe771eYmKqH8fM2SH9GAfxwpVkMDpsIxEwS/bEHDBCIv9pwjV+kKHZWfu5WtOOWd
         NDJyxRZe0hU7sbSbTyZAboXXvGPkKQyZ3DmY5OWE7vYMFQuHVspn+fYIW2tRH6IiJq5E
         Mg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhGkiuVqRTkS2WltQJ5CiiWR5oVjFn5/aMXPjSd7w/49Lu9cWDy3mR07VuZ2SQ6beUYBowysO2gHX6AII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOtm6V2VJbiWkdDjAnEiUk4keMuTK9ribYNs5cRvIo00dMubt
	QWWcm/anoOVUKdSeSGPAZt5+1duNdgwGZATqpi8HPinHVhD5sCiDT8ha4TYhw0Ebp9xjKgQu87z
	Jvw4ufXyqbEO2PVNKIme9ovTfo65BhJamPeWcty3MlnxUn2kqHbL26k4=
X-Google-Smtp-Source: AGHT+IF2YhafkfrKTUvt5hT1eS8P8NVfvGiiXt2BspOMsCshI9Ras4qx1a/B7WPhMf72zrRnabdeU0xnsT44MEfZbKUbl6zj4J4G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c86:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a7f9a4856fmr118874955ab.10.1733400423207; Thu, 05 Dec 2024
 04:07:03 -0800 (PST)
Date: Thu, 05 Dec 2024 04:07:03 -0800
In-Reply-To: <tencent_A85875C576B566923DD537C696D037284B09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67519767.050a0220.17bd51.009d.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rmdir
From: syzbot <syzbot+9260555647a5132edd48@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com
Tested-by: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com

Tested on:

commit:         22aa0501 nilfs2: drop the inode which has been removed
git tree:       https://github.com/ea1davis/linux nilfs/syz_0163_v3
console output: https://syzkaller.appspot.com/x/log.txt?x=13a68020580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35f1fa828fe386c2
dashboard link: https://syzkaller.appspot.com/bug?extid=9260555647a5132edd48
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

