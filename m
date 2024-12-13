Return-Path: <linux-kernel+bounces-444696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C69F0B32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BCE1648B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481771E009C;
	Fri, 13 Dec 2024 11:32:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935B1DFE34
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089525; cv=none; b=EQgeE0ReDgypHleJQv68GTwV/FFFwlsuEHEGoGuhSwWlY7yF7V2OloKN6FBZ/94o+okFSCLTQIVM+9eOdjUbZN+nD06ya2yN1YAqGxmqyshSyDif5zIalXOI++6UL1aRyjIql4pryCOBg1J1wxicp6twv/fGgBoOQUXvTuvPcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089525; c=relaxed/simple;
	bh=UlBVfnHOQhfhrIWtRxL9FPBVQZ+b17FLVteFuw/B0Ps=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fZDwtZTJGm1zjQyL0HTrPddY05AU68HbKO0bVTUhS9r75VMInHO07G3PGUvBke4BA0bkCXOOdScp8DqW6uQa2qYE+VWBZuAfuIPdxKBpo/nITaSlPiS7+bFp8H2lTP2PZ1+Opbnvy0AMBzFBuLmbyOuBwGD0lOnh+JV/HF5zUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844eac513efso33369539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089523; x=1734694323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M2whBLftejeF8a4BvJbIP3P805WYUeDyMbF+6ThAtI=;
        b=jKb26bU/ENJMBCdZ4xUQiv1khJbTEByg29fJ1sgMEbQeR09iJph9D4IokP6/gYxVqO
         PIyFgG0VdmygkSVcuXYjQ6reeo9MXdeEAw9UlCMX3n0z3tZbWsS1hHeFq1dKnClEKt8w
         cn8soH1G2rgorWHNzHnm9dtSPQhR/LzPl5yb8DjmcdO4EH55Zhfv64SvbHHik2Y7kbY1
         AAvD9YCGLY0wk3Y7iaGJmOwkjjKuCKqVLX+dNF/pn9Nba7ZzUPACdDy1CD8Lthu2JD/i
         8HJmSD/cQk5kKQ5HwjYIGIOQ8zUUuK+uaREtA3CJrai6coJ7jEgfDXuLZpNSINryYypz
         QRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB9Zsn7hbkQatAmcvXQLBYNwFFm5pevYD2sA+DNEcflSVmFbO2Bl1KFiThAYvKeHpMI2cTHlkJxe2GQg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6tPyxW4USr0lZlYiEQMHJ829/acVT6cYolWZWlUOGmgIkAB1x
	GCzOy/oNSHsCwTj/T80fsdO7iGCINFjSazTo8dnBAgKn+kblBT0qOseBoYk4sohemRp8yO9jBVR
	Y3Gv6zAKET/F9retUCn1GqwUdMfBy4Vj3CSzzix077Bk4QyjklSpp57c=
X-Google-Smtp-Source: AGHT+IEYoFmE5BG/wfAUTVJPiY3bCDLJp+xLZp3wvELFeqcyEwd04wyuEZ2kj80Af1Rp8o7zEHFjkup2wcKjZzVTmiBq85HgOKCU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c9:b0:3a7:86ab:be6d with SMTP id
 e9e14a558f8ab-3affac565d0mr24554265ab.16.1734089523536; Fri, 13 Dec 2024
 03:32:03 -0800 (PST)
Date: Fri, 13 Dec 2024 03:32:03 -0800
In-Reply-To: <20241213110305.1839-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c1b33.050a0220.17d782.000b.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in enqueue_dl_entity
From: syzbot <syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com
Tested-by: syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com

Tested on:

commit:         f932fb9b Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a12d44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42226445f75136a
dashboard link: https://syzkaller.appspot.com/bug?extid=00a022dc9979d67df050
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1567c4f8580000

Note: testing is done by a robot and is best-effort only.

