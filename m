Return-Path: <linux-kernel+bounces-322678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C55972C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEC41F252A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94630187325;
	Tue, 10 Sep 2024 08:32:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC3185959
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957124; cv=none; b=DGWyr9+0LAPLos/eG3iwv9M3QM7CWjBNtmgSnNbURUG0flwHJ+6xGK5yACdruOEZv4MUxe7i/QNTOxncp3YDGqk7vtVPvvvvQDhls92netjUj/2OI9kqXfkUERiVudEKKPMcdjW9Fx8GkxBxj7m9uGM5vpYOXr9dv4x70n9d7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957124; c=relaxed/simple;
	bh=2/vbeXXRWkKthAyj37MvITdkVOeQVbBtvVshN6wR68A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HRJwnhbnXKKCxGWYxcfRmFStO414CHgD8AIM+XB7wq8HdbBwXELlOxWGMbNvfvploZVQDgOv2mNKWb8g+U/LUvfAGK3kQMOUgoUjmKe2ssRy/Z/AhEpxjadT2Gzan1KQzTJepVRm6KyWt2phRSK1Z/4ZqsK41p3/dBEu5dhaGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04eef8ed2so66301995ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957122; x=1726561922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O4qHVrXBBiFMbc3bcIjp73aLAwcZ5lw4CY0Crplrsg=;
        b=aUKOtvwuvlrLzc43vjeG8a/RcoG0vujZspiau0eQ8d4K5EfD2eLtcUOfAjo3OCTqxJ
         +rhMrBv/ogozreP/ymVnwl29CgiGkfCuTq94rWVSgnOnS4W3yXD97qYzukp/M27q9guJ
         jmUC6C/0pLyH4Bxa1aw1zFHZ33qZCHDFf8HrhcNsFJBPVVb5GCAId5JZ1xVATptOc84A
         6RJv598re7BFy4QXdonFY99UhyDgTAsOxFJeD54BeojmblKb8cwcs/JviYwHmxCLQXZt
         mhtQvj3kdbK9uGd9ygZEQvhcax/YcpJneIvZcaLBioojNJpCKWC5DwynSvx5juOW45UN
         cYGw==
X-Forwarded-Encrypted: i=1; AJvYcCWzNGFvNSqgi1nlG16ZgwMju4Lh58Ures5oZC4w9R3dpQnjaZYQZBXvw2cLC0fJem4OIl2JhXRiQkIlkfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+sxcX0MMrAu0QficF4ABmh9bKqz0UDAM1Kt82QArXj/s2Cjz
	Iaw5JtpHo5nu8+tM6m95uRm2WDDkdPbfXiW+wecjThw8rFundowrq5EhxX0b78f8rQLDpcIpytq
	tS7/kVKrceRJtyB9gX8PEX3Y3Kv+R5x1yCjitXTyfBP+/Jh3USTtiUN4=
X-Google-Smtp-Source: AGHT+IGfhiwjZM+GNRTZWN0Gh2NalvxVKaSHtUE5YUhzMkdJw7D6AdnCVz5o9qYsI+UfSEskuaaB0GANZh1SDbhoeCFqiX34ZPLW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6d:b0:3a0:4d1f:51a4 with SMTP id
 e9e14a558f8ab-3a04f082fa3mr147872795ab.13.1725957122033; Tue, 10 Sep 2024
 01:32:02 -0700 (PDT)
Date: Tue, 10 Sep 2024 01:32:02 -0700
In-Reply-To: <tencent_C01BE84B281BB025FFBA45BB0733AC9EC408@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002822f00621bfb565@google.com>
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

commit:         bc83b4d1 Merge tag 'bcachefs-2024-09-09' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151c6797980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c47bc7980000

Note: testing is done by a robot and is best-effort only.

