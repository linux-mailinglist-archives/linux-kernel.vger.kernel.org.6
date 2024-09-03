Return-Path: <linux-kernel+bounces-313083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA9969FFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593451F25FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD9189526;
	Tue,  3 Sep 2024 14:09:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C9188A38
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372545; cv=none; b=cJqX7dN9LJA4o8XUdy0ijmyb6sQ7wbzGEDdSYSNC2dUmFUTYVuPP51okLA/1PGwBYOd59VcE8348sKQKSwJFaqLKmQLBs3jMOOWknq6JQVWOe107QW4bdPpKobjuLE6eOc2+kJUvC5WzLG3KLwTNvmwDI9GpwPiBAPFc7wr7s+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372545; c=relaxed/simple;
	bh=+nM8vzoBpqyqjULtHojqOpGPjML6LI9IHdK+S2NGZA0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XWAN/J4KiJw6ScMV8NeLJajIXpk7xiE37P9yb7KlHjBQGX2TOjO23Acgc0XbWqFyFvi6pD3tKWeYajKYyEyE+kM2kxP71ZXo4fCjftXKCi7g21b3vYthVSz1vn6zdm1v+ZsLAgdN7WVc2vaZNjq4Mhkw8YyeujS294PtCqx8eWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so60652465ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372542; x=1725977342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDE8s3sgzOfRmA5IQMPyBRiE4zNtZrkgSCwxEOEBBCU=;
        b=cbtcFEdYRuWoTrIAp8epsKUx43p7GRBIlwNJAJWQ4utEWWRMNOIc/rY8LxNZRby7A/
         +IbjK3UB/rGp51pSyg4+nfe3B9EPHQerp3fZ/CoM+Ofbvz3fbQjJblrxf5CAEdNpVgXQ
         hZLxfwwVuXK1ghELguiUvHBjTw1Ryf0ry6onEgh4Rw+vXHXFnTkxXXfGVyFzvoY4tS1z
         f3m0Rl+0mo/v7krUs1/EThJSfg6AqXDlsKq6Byqyxqf1qTYryQm6WYDTtmMuE8qFTboO
         yp+kjWgUKgMZC29cS7t9P7mDtCskkUuO/tdAngSuf/EbWY+ZCSp4niJw7J/nlykaKxFc
         TFfw==
X-Forwarded-Encrypted: i=1; AJvYcCXPhV1NZ8TtYwAQmIy0G2Uv2+rNKINOVch8xhsdW1XY0wi/X8FR3xxkKmS8Ievqvw5wpVVmCXjVTYsC7S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsbPARn5al35y4VVjojBnI0D2o4cMoemChtuu4YZdHVyDUoxV
	RctrNLc5xXWyDEYh6LYCx4Rr/NtolfT5lfb7r6VR06pdfJnyNjouHP+MvCL2Q1QpxpiGlePSk4K
	Zci8+/UvAq/r/oetm5l1ztJtocNPrE/WSAhRvIM0P+EHMicm82T3QrVc=
X-Google-Smtp-Source: AGHT+IFVmdwfmNhKTBG3smg4iwmVd9uxiV1gnfyI/mRrCyIi9nMfdgl9elif3YCoummMaT42vmbMD0y7Gldmf/JLBLBOrDro14eN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cd:b0:39f:677b:225b with SMTP id
 e9e14a558f8ab-39f677b22e8mr1599545ab.0.1725372542443; Tue, 03 Sep 2024
 07:09:02 -0700 (PDT)
Date: Tue, 03 Sep 2024 07:09:02 -0700
In-Reply-To: <tencent_91E82C456D9496A8EADAEDE6CEC479926D0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f730b06213799ec@google.com>
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
From: syzbot <syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b2cd43980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1512f0fb980000

Note: testing is done by a robot and is best-effort only.

