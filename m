Return-Path: <linux-kernel+bounces-229932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8392917629
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AA81C21E77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4772AF1F;
	Wed, 26 Jun 2024 02:30:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709B28DDF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369004; cv=none; b=LTTnZIF6IkGwiBVgCuKRScGqv6RqvH5doCv2c9MCjgWpURV4ePQBTmPU2I5sfg7CkSEjelatQw1Ski9/IDoYhBw/NrBZmVagr5ujA6h/93ct2HslQWdCzKbzLXb+giDNQXk9jWXtyUZQqZXuH94sozGk4PB1b08Q8x9HXIJV7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369004; c=relaxed/simple;
	bh=NfKw3QLsQyQKyrV9Qz6FfoNyETXxTukRSvZbp9gGM64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BLTbTqCLTsgF5ou5f3LCx/Nuf2E0BotHDS43kuVVgKGSBlzqhyiCaVoi0lpkHAycu2pmZS9szMwfF8J2rWjYH6Q6Kaqu6HRlQ8H3X/v6fv0U7dhQupNWUq66q6QkZl6BhYMFPvxJgWGDPMRdMOZaXwpBUlwJLSB8zr1pMoiAn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eee4ffd19eso883897839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719369002; x=1719973802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnVewDyENMNioIj1j3KhanDDCJ8KuMLCh8kk++cX2jg=;
        b=Qih+owQLX6WrRGwkgY8AuXCeEMG2n2UeU5raxqnDGfyfjEsbqzpYyT3ogd5bVBctPy
         g3OkolM3RRQMkNYB5sTvcM5WN+wlHpSi1ymPehqA3BTaGqat2EhoJDF8+rCDIq3o7zhQ
         K9/vMiz1glq6fMPL7CHl7QZAzdErt48vcaACf5bebRufKw7fMiY0gqd9/sLKpMHD9F4u
         Re1/rxuEZ/cyzaEnvdfhPPkgC4ybeqte24R8nEpmkNzvRhFHOC8ibwfqEv9p2j1xVOso
         M4z3Xbhn2E7ntTD9rG8yIjEZod9Sl3PNmvD+GG6TNa5EutkXCkV6CpzqYLkT61sw3a/M
         M4aw==
X-Gm-Message-State: AOJu0YwkVLgVUGwLWc+2gY4LP0cQlWdBLXMOxfDwOEfuPLVhvoNuaeWi
	wJx3YOhO4JZzAOkbNjFFD7gFBvFG/9Ze6qe4MuOPuHxSRalqGW14Lh0tyEg8jfVoElF3xuU0zGw
	hAw1w0uaxwJepguXn1Wy+gFbPrBGXWD/YtcasxfKQAPC2WP74685uqdA=
X-Google-Smtp-Source: AGHT+IE4/mpR7l1Pxkm903wem7njRdFPjgDSw5I9yFWb+K2Uutv2c0BQd6872xchaCDqGHhr/om2x1s4T0Nv7F0KwQN/TZ70CRF4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3424:b0:7f3:80a7:9ca6 with SMTP id
 ca18e2360f4ac-7f3a15669cdmr38813739f.3.1719369001947; Tue, 25 Jun 2024
 19:30:01 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:30:01 -0700
In-Reply-To: <CAMc0M-_V0ZiMRsmH-A5cqL2cj0WcTwmYA6x6eP0anGkGVphkyA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009964b0061bc1caa3@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in __kvm_gpc_refresh (2)
From: syzbot <syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com

Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122496ae980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e40800950091403a
dashboard link: https://syzkaller.appspot.com/bug?extid=fd555292a1da3180fc82
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14250ac1980000

Note: testing is done by a robot and is best-effort only.

