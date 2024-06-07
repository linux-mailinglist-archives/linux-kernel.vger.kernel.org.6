Return-Path: <linux-kernel+bounces-205558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F78FFD6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B0B21DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92F156F2C;
	Fri,  7 Jun 2024 07:45:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C5156C5F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746305; cv=none; b=eZLsd3Bb3IjzWzz6CfTL2SplQ7vqZKLhbnaJ6a9kF1sBLnoQqc7fQY78raRUaMhyuTsFg0J3aGrsBXkKG744hmvgvfHdpOiT0ef9cW9Whq0nkQm3Yme6tIVVvngaz/ksZf+tjRsa52yGv9T6gl++36CLbGYurGpFyMmi/aXeOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746305; c=relaxed/simple;
	bh=+qureJeLsixHiOVgTio0byok9eQjL4VazkH+76AQUAE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hcmp9Y47C2HeLLoCWLPh69uMjvdqW3acFjColBPw58H4FluwGVY73JFFyoXTCNlKUHjNswpjdFN0HsYXOhuWVZ0dZuWm6ZczcUqoA68R+zC2faEAco9i4/RUGJygFEMNcAfbal7tvy3LgR8j71Du1Te81hDzgB+7liQ/tTzPklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-374b2adee08so23845205ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717746303; x=1718351103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTpDa9IZlxHfoXb9bsOLair+EnvzMUzvHAoezzaGPX8=;
        b=KXVs612lXjoyugNfWNgmY1xj+FvWN/Fq6NZJwTkIwg0z+Xm6oCVdHbzmr1IQo0yzLq
         JUsLf0VA/NzyVCcDzwbWJQ6yS6/boLXwLrSAyyM03LKuhHmk9Ixebon9eJgWaD/S4aJb
         AcVTWA5tvWIq//HlqtvNKM6HUkzjdoem0FlL/tia81je87BoMbY4Psvf2QkN6pM/XkZ9
         q+aWwPKht+dTU7dv3IRMydNquCJZ6TyWTe/9U/2pVjerOw4V6r6DEOlUoOxVUyfTFVEo
         bkQs2Q7HXY3830r00ALo92krEEn0tk6ZIiYCKf8vOXpuh714wVOxb9AXKyx3zaHjb9Ai
         gsCg==
X-Gm-Message-State: AOJu0YyjE0rS004n5mVGRO5bIQ2wAzyF30JFLZm5hRQGKINJwIoR77v3
	dSRU2zSikTl+FMEcSEgMgW9ip73iaNSiyovUYV3ZQxM7B/l9rr9qtvYLUhafjpcgWOgWlc0S2KK
	eENkxeaFiJt2x8g+ZObeS0N+M5kmyygRjJd9/3GmqTy72TNUcZVPWntE=
X-Google-Smtp-Source: AGHT+IEJ41sIl3W5Y6oGjYljcBuDfuMbBzju4/TIgmj22LSIPonDghGLCs1golLKgMvi2KkDPQlDu2A40qosP5wKBS6fnZfBn8+u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:374:8cfc:4160 with SMTP id
 e9e14a558f8ab-374b980f6bamr2673575ab.3.1717746303038; Fri, 07 Jun 2024
 00:45:03 -0700 (PDT)
Date: Fri, 07 Jun 2024 00:45:03 -0700
In-Reply-To: <PN2PR01MB4891E7B8CF9B3C1531CB9ADEFCFB2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035168a061a47fa38@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com

Tested on:

commit:         58fa9471 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=10e2e6f6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

