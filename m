Return-Path: <linux-kernel+bounces-373165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9BD9A5330
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF5E1C20E4D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A886739FD6;
	Sun, 20 Oct 2024 08:54:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC01754B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729414448; cv=none; b=k5KIFddDZP7hJ5KCmV8b84Kc8ekCy1OeIqAFftnpf6/8CAyCVcWGxUrQZPW3fM7IewN5mWf+T3rRWVzev4P5BWnmZXciqqA0MAns01PmQjwYEbAL1O9LuC5KS32K4I/UmdU0uKPyY1N9rLtfhqUoZU0N0a4so8lLqPgpqk3uHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729414448; c=relaxed/simple;
	bh=vQ9lojtvYSC55T6VujuN/PjFssGMXHSxkbqgp41+U6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EXJgXT2TQKAm18+szqr+fwwOyem+ba3S1bdcCnGWdPQwLPph0nJdQTgOHwnVgs6MrNIwMqUnbXs8lx1/dwQxQwcQs1sN1nESTEJxfr+2eeZE3nedbfIDXMz1aPnLitRUfeebq6dPInoiZzOufsUOWQE2XnKM6xqsoH3pjnuwFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3bb31e3cfso31152085ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 01:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729414445; x=1730019245;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSCARb7keecuFTwpVfxUIPQnHbUul8QSoVKzrcuWYF8=;
        b=K3EQ/ObZ4MSYRKM5yr7chHf6M9ulwyh2QySaGp/tYnN83IH4AD3EJua0r+MgvHHFf7
         39G9xzAEZC5Qr2q42nDpoFlvcMNsfy6lnpWOhQLCcEsdldurMHGB7cvPOzmu1NccpQBz
         cKmBgJtBMpzyeR5+bN7Qh2L+QuG6kPGNDpIHbuIVHflmE8fJJn96Du5XgrE9Z8D69jqP
         y8l+i+kTgNbZu/TL8moKFfmAkqR3Buwj48sCeSNuAa82ni2n7PC6/fmk1vZ9cFCTlOd7
         SMeeLXVlpAWP8AF7upwneMdWVJWj/Jle8GhzVShQkYotMbTRvjBPKBhL+ifQ6WPY/CuV
         pMYg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Zs31UzAcP+ooUmNxOq3I4SQ9fkKohFAklY2R/6Xdr0u589QsK9kflMyuWR50SfqUq557a1Aptq3YVs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BJWwSJghpLkNswnePAkZ9/QQy6YJKuiUgmWWu2KsJSioGT95
	9hFcsEOgaAGuxlt3G+ZpcA5yaJGC/hR43Ih8WkOjmXsaOMKTpZp/r+kPB1d2mKXwNJcfPbCZdsZ
	DfbOHX3vzZSq6StGIcfVLU16PwzVHr8CgsuD3RkoIv0WJJ29Q0PiLxJU=
X-Google-Smtp-Source: AGHT+IH7RWaTdjALE/T2LyD+fPeiOqSziovJONV4fkMR0W2+pqZGSbuQdKYrnLBrGbEVSW0icfXK4C/aJw6CsczbwQ2t4lhxhT5q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:3a3:b256:f325 with SMTP id
 e9e14a558f8ab-3a3f40a8446mr71237375ab.20.1729414445583; Sun, 20 Oct 2024
 01:54:05 -0700 (PDT)
Date: Sun, 20 Oct 2024 01:54:05 -0700
In-Reply-To: <27386470-ef9f-49dc-a3d6-6c7f428737ad@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714c52d.050a0220.10f4f4.002f.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Tested-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com

Tested on:

commit:         89e9ae55 IB/hfi1: make clear_all_interrupts static
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17bc7240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125fb240580000

Note: testing is done by a robot and is best-effort only.

