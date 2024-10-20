Return-Path: <linux-kernel+bounces-373094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D479A5221
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5536C1C211AF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD04C96;
	Sun, 20 Oct 2024 03:52:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297A440C
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729396327; cv=none; b=WJuV7ogkg3mNzTDgGs0lg0CLPMj1Dhupp1OycNOXJFQZgJi5IxECQhx5Hk1PbYCcHPSM2jRWlwM6wj355imxEdk5cDJkpYIbN44o2BdYIupt63hmN4xM/TYs+SkLcK3l3TkaqvGLdTTvR4MhkAXbdyG0QiYdO1ajbe+J5Q2WdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729396327; c=relaxed/simple;
	bh=ppbqJnf3dvhSdYjE1AqZwDzaciF6UAEfAsSU3v7WQuc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ElrL06OXJ0s+J4H4Ylf2i7xAxOGR7Z6xkLSBwjiu5/FzFND4OLCaIHK1JCLGXhQGBx/S52d43qpadtufBnU6zDpoDnfeDAvxJsVejZ8n0/TKyYLGbKc2wZNmR1UXlmbXubBNr40TNGk2CI25JPgnu0cjvk/4QUSg5wK7aME5Z8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae775193so35489545ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729396325; x=1730001125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMq6plSP/ge1E15yjeMI7UZaGTNEUM0Yn2LOZx5bJ/4=;
        b=To6OP6LlH2J+LTSv2xESGsGrJVPU2+kLkDn1lcvKm5DGhDKsmk8AX0PkNoQwwGLx0o
         wYNOHTfe81MFaVeVoSgjmiUA1YtCWnFM97Vixz+vEzW9J9/RuakBB9LECK0sBlS+tAfG
         PyHNt9c64ZzvzUmpU3TSpae8WAelSGrjlsgMHYpVpao4OyNk+RImneDxwIz45sxcNUMf
         tIIG2AHRScxMsKsBQhkgVxQMD0J4yNg5D7yRqKlR7sBgjY63IGKB9+5ppQptt4B7Svix
         74w1f18rok7bglrteR0ZA1l+vCDa+/aEV1AVl5GWq+W+iC7RfaZvPJLB/Dsl5Lb3qEYI
         61qA==
X-Forwarded-Encrypted: i=1; AJvYcCUywQli71JW/ez7DeGHD6KBNM5eUMr8tiF/PmwV7IwVgQfE62EagkypFaIrc132hXrORhZZP7P4yZFbomc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGF9nQXCxBitFNj1+tM7QDLeHuwFQdust6HgSlBSOiW0bxc6UY
	+yxULPfxAUc+Yey/R6vD/3PWsdy0mNqf+SFGlnxop0tb5bjvjzAfvBOwpjPBkG5XFU0cnKSXQzw
	GilZ0BpIv/MtT/+KXoStT8dSOWqTj7h8UrTqj+ex1JhoN1n3MofzuZ7I=
X-Google-Smtp-Source: AGHT+IEqVpBw2PNnAgXSzDo8I3PADm+uDmYIod1gK8tdSJrM21f0hk+2IC413cQPUYUZXin9iK11u/xopD4/pYLTlJIcFgETxIV1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:3a3:983a:874f with SMTP id
 e9e14a558f8ab-3a3f406fe3cmr59751405ab.12.1729396324991; Sat, 19 Oct 2024
 20:52:04 -0700 (PDT)
Date: Sat, 19 Oct 2024 20:52:04 -0700
In-Reply-To: <20241020.122752.543927907848385586.konishi.ryusuke@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67147e64.050a0220.10f4f4.0025.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode (4)
From: syzbot <syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com
Tested-by: syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com

Tested on:

commit:         715ca9dd Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1450825f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e543edc81a3008
dashboard link: https://syzkaller.appspot.com/bug?extid=9ef37ac20608f4836256
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148e0c87980000

Note: testing is done by a robot and is best-effort only.

