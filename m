Return-Path: <linux-kernel+bounces-186302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066B28CC27A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056231C2274C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7462513DBBD;
	Wed, 22 May 2024 13:54:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA11E4AB
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386047; cv=none; b=Vi8YWUlh/6xaYFlSsLN/nb5vkXqACrwm3Bal+Hc46YjvB6ni+PwDpEIzsJzFHMENQOaFJ7DA4YdTU236cpiuaOQ5faoHmfJEmQiZB1yWdYRcHJ3YBBMJpf+nyKuTW3dqNKHRQlb3okMeKl3PA07IJ1XROGElzwjhOqL7DjsP3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386047; c=relaxed/simple;
	bh=2rj7Q76uz40fzhtH6PsBzzexu3WXgF6kxsgNdBuboZs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aWfIgyXkB+0nRX2DTI1zXzHkkSXRUDpshi2r9N8bI2ICXfsPpI+uLEQm4BZWoPsNc0gZbuANCrna/aG6AotGDpZiBMfwm5OngZq5h8MV3Sz9jUCriH8nSmzXJPmDC980DwiX5MbO8bDqhM7wVQ2elaQOmFZjD3Zd6v2Y5CjjbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36d92a840abso7769285ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386045; x=1716990845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4pzzxhrcfA/LyyXqVy8XiALL3FLxQJOgKH7W9GkJ5I=;
        b=ABEx+brdCsOkmUyreE9qM4KfyItU+0db16VT+2bqO6pXT1wQVzal8JWNp7QEo+LxEX
         UWUIzqKkrup6dy1m6vM6IjORyTerAo50g8L0tiSczBHBPn3yzpiT0RSz50rNQ6DjAzoU
         lkdO+eRTt0/RqHSGnL/qT+cowrtUBd5PCDnq52My5rdnZ4w+Jn2GVoYdoURjYJ2X3aEA
         nThLA6MIF8KwtauGWZ6TsMvvd3L0e2JHczJjQW0FTlXB17CQ88QdMKV2vvum7U8LH+IB
         ZvpaNVeqq/GZQ9aZJomR+bE1hM0aU09EAXTUit88AYnfdGBeyZ2CcZ57X7o8kXLhdngG
         vBuA==
X-Forwarded-Encrypted: i=1; AJvYcCUvx9i/PXvWe1VtyMX9e/Lwo8wnVwSAmZ+CCGgCZz3VNvkIY/szndJ1X89Ug3mb8JBW+hFIXz8GbPJ3nZfJygvm5w8uU4YBf9w17S7M
X-Gm-Message-State: AOJu0Yxqb9S5PAyHTarTdN8EPu6UhwUjNO73/UcqVnBh9S9tmy/g4OCz
	8MsrMlynp6MAs3pbIgfwewtSWfZY6ZFRqSas+PjawXisHeNmIj/XPAtQCIG87q60n7exiEFepPR
	/U5ge+Zs3R/hvR8Tnj0JT3yGxfa50dYQ6VwYTirhBu5osU44F1C8bby8=
X-Google-Smtp-Source: AGHT+IFKfzYG/rYvvgD/VcD1rgiakhyXTzNA5Q+pnHFC2KfpxN/1Q5TH61qn37vtKTpbIafR+gXRSo9MQH/bXGoZdWJ0//rzRN9o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-371fe4fbab5mr1940025ab.6.1716386044940; Wed, 22 May 2024
 06:54:04 -0700 (PDT)
Date: Wed, 22 May 2024 06:54:04 -0700
In-Reply-To: <tencent_E4796C489550EB0EEEEACD6C797A6F1C2E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081a38c06190b44a3@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13612b3f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15794fe0980000

Note: testing is done by a robot and is best-effort only.

