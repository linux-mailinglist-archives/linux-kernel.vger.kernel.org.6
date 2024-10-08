Return-Path: <linux-kernel+bounces-354746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE33994204
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1647A1F277F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D261E7C36;
	Tue,  8 Oct 2024 08:01:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832C1CFEBE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374465; cv=none; b=hDGpjZGt+P5sHuTBRyzvLHspHMpm0q9Arf3zRnZn/xZk7kQdicxVOl4n1Nreo8svqE1fg02trGvv8TXkDdk4P0X4jkEQZcmx5/v3eZnA7HRomaOtqkvRoWG3a9VQaN6ILX8ePeNDObFXk2AuKY6C9NKl/+dTrO4ZZlYe4EOI/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374465; c=relaxed/simple;
	bh=zaqn/4BWBa8znHx+usI7iAHvF5fLJcF/phhcQWMjI7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CcdIBPdnLWiNAF2MZAvlv780LEeZpUoC1QSsVBcDqqByyJy1Cyc7drGLBPKnqv1UI+tXFgKseMdEYUUZ5C9hfUsKx8HzHQEZyXmgBOPiTpGloTxxj1im8TRbYWOIbWuB4FFS7TaMjnDibX0CdjVdpfKo+XOOoGiub3DIScUiqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82ced069d94so508060739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374463; x=1728979263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDNHWSHOZdjwVEfcyQmlbbyQc/I10wYUWES5VqEhcOw=;
        b=NRgt8XJj6XIULrvy3yD7b85MrzKfWgEcVBA2Qe+0xaVPpc2x+j0geHa+HGWnzl7h0e
         kEs2l8tqbnezgCRO06nFLmjduQwvWsU3j4ImDZ/QPbnTmkGZ0dNjCouvhPvXSeqcyjKH
         GETIufCz2sG8Mk3qh9WyDttinhvnzNbj7KSY9XybW8oTH7e1w6OKErACJBvk7myGDNOy
         Tme3R4xG3hA9RT1/0eGCwRKTj95y4HqhfZSpBdhFk6T49DMuSZUMKug9QC3Ln8VBeZDM
         DRCZXolqDg5uDqZctibECoZZtGaGLwEGuOWLvFyGorH0s9+y47WxC8vGNGhe2kT/X8Bu
         GN6A==
X-Gm-Message-State: AOJu0YzPpkqlLHjxJxjur1o9yhg2DDq3myhbK919PK4aXFgHWSb4eaq9
	LFd/LlLhA+c2DFoYG4DUk5hM0178HzAxJQOcQUVF8Cq8d7gIn0kfPqL9Fm8yPmcXvSMKjGaBF+C
	nUAMBMZAogPGDzoMfJzx0maFcOswJQvz9tCPvvPSvKAmK9wX7+z8ueVM=
X-Google-Smtp-Source: AGHT+IHJnWUvOuBvxztOHgHxCI0oKfYLux3nIWkEm3F9lYe4El4+Q4MgfsvqYFxGr9Tm0uMiFiYydp5er1gVgztAb6cuvuNH7a27
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:3a3:4477:e2f0 with SMTP id
 e9e14a558f8ab-3a37599ed9bmr141776505ab.10.1728374463264; Tue, 08 Oct 2024
 01:01:03 -0700 (PDT)
Date: Tue, 08 Oct 2024 01:01:03 -0700
In-Reply-To: <f21baa3b-8214-4fb6-9932-4912fb1d3d20@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704e6bf.050a0220.1e4d62.0085.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbAdjTree (2)
From: syzbot <syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, niharchaithanya@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
Tested-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com

Tested on:

commit:         87d6aab2 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1459a327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb28c205c377e04a
dashboard link: https://syzkaller.appspot.com/bug?extid=412dea214d8baa3f7483
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d08f9f980000

Note: testing is done by a robot and is best-effort only.

