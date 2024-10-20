Return-Path: <linux-kernel+bounces-373298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73479A54CE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB92D1C20E53
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5321940B1;
	Sun, 20 Oct 2024 15:44:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CC19343E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729439047; cv=none; b=hSw5YlK+9mFpkVcv2+yV78VoEApkr4/3D6tdh5tkzUG5G+kagBg3qr/4UFT9KEaM+sVibYaIj7Gm2sKcDu2Zf7t8bpk1bdWErBx5maI7Iq1fD9YjmKxVUi2W04qCKGliL1BOAAAbEzsnjhOQ5iIEvRpIglAHnSABkcYpjgtjfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729439047; c=relaxed/simple;
	bh=W1smtNTIQF8E7bNILu/bBmulpzl57my9RBsB+OPJ0Ps=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ly2AS78ylG71FmrljW9fctesSoVh+VO4YRFgz6dhhNB8xLvucC95OXLSTdQZzkKPF9Ugc9fluvzeEOGVzHmVDgGDnva9b2079C4D6St1/E30qElir3Rm/+tHCCwkRLKwGvGP89jEb1n/+608lnxyNCl4lTfTAyaXhmtrn4xPkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7b13910so34613755ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729439045; x=1730043845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWwmyItpIXv65oYz9xFe/GGYaTuyNB6nSVTRCDR6EEk=;
        b=hZVOS3KKSHWoUo1LPGU8k6klpO1Gs1uKMT1n7lWGEAKIVJindlfRuE/+aEGqIUPFWD
         KQ17CJniCmaOG0lBSNiNE7vl97G67W8e+QcVTCHilSOeygRTIIcDbCV68GIuux/40cOu
         msZ1GPwxS7wnRkXd4697cB+qlEPDYCaa0Hh/ViNEp/uw8O1qtQMI7/5wjJNTAEud+lgG
         /CdlIg7kuSAAjq56ECDgR0GCcwzqhEJ9q8Oa/ENUk9h3tK2L+a8lZLapffCfbU0GJLaE
         mOpN9Mi0KefpLMzibkYnQUVmRf8woVp7EfmbixyI8Jx3QpOPivES3f0aFTwhxUZbZhN8
         QVzA==
X-Gm-Message-State: AOJu0Yzjd8/sx7bRweo6lnmmJW26bmGIwl3xpZ7KUjk8ZWnjbDMqH6Dp
	qursyNBKxLVO44RyIHvHWr8/7P1AQs2KBmGvbeVdghxs4upR9Xjai0t054vMYS7/EZ0ZEbw13xG
	jMvf0Cybd0+dVOIevZHqDVdNLdS4GuFORuORe/JpJZ9uL29uBnKQykd4=
X-Google-Smtp-Source: AGHT+IHOlyxCs/qX1/OHGU+UidtDP6SqxL3LLepOg5j+06VJ3bDtAXynPo6523d5kAlgyRgv7LzeJm+vNBnH/0v6edAGpjFJBIGc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:3a0:4e2b:9ab9 with SMTP id
 e9e14a558f8ab-3a3f404580emr85220985ab.5.1729439044726; Sun, 20 Oct 2024
 08:44:04 -0700 (PDT)
Date: Sun, 20 Oct 2024 08:44:04 -0700
In-Reply-To: <rKlLbfCLe5qEsfZ4TwH_eOdju4cwug4dACGLemYC5dRwYv5U3VdjfKzPIbXADvaDMKCJ3aI4gbg4KoYzwRZOSrZkFzhE6w59CUOTakduIUo=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67152544.050a0220.3d9749.000b.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_bucket_alloc_trans (2)
From: syzbot <syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com
Tested-by: syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com

Tested on:

commit:         715ca9dd Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d38c87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78db40d8379956d9
dashboard link: https://syzkaller.appspot.com/bug?extid=2b6a17991a6af64f9489
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1431a0a7980000

Note: testing is done by a robot and is best-effort only.

