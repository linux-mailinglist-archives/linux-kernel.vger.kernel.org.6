Return-Path: <linux-kernel+bounces-431156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3976D9E399C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16739161C38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D451B6D1B;
	Wed,  4 Dec 2024 12:13:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE01AF0A9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314385; cv=none; b=KP8YjIQtQxJVvzjpG8Dzr8Ncidwe0wUVeY3v6JLdr/oo6N58LXM31YKvFV1ciqRi/z6WPOAD0OSjk8t195O7Tf24MDRjMeQTKI71eJfFDRjN6wxFJyIsHSDCjGFrVzeJEsfaHL/LQs7tYcTHRJBEmxJ2Z2OnivHM7VJAD09OJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314385; c=relaxed/simple;
	bh=7Wr7j8NJl7yH/Id9hAwQx3zNOdL+mDe6gpgz5RFCbe0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EAsu9tq5TrvDtunazm7L2WJGteuGymegR8+IFKV1LEuylEWH3IanNjPV2rGv8fALzvLERSmiSH+pWuvODuP4LBWqgmqn14EEvJFTRfZlA93xTD+ZHMdWSIg7WuNpOxUkoBMSDCA1/eOceTn1i13bQzwVkay7w3pEY1XilyQ1cPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7bdd00353so76205685ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314383; x=1733919183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jYlZntUHQfZR8Ti/Oy30Lg6lXYz7L4AZRebu6qEN18=;
        b=QFiRTXCqDen6hmiC3dqHoYtl4HlUSemDvAMDKU1nF81bQT1tUfnpzHoDwyC4naQSRb
         mbPteV7T/7e0Is9YXqeI4MKIQm5zxCn5GPwXzn5Gzy6PlfpB5h9Nc8RqkEjQEie1siDT
         jL/u5xj5L1Dd0vWprAfPVYmTOBU3wqNwgzD7pocZkn2O9hFF1/oeHUJv/PWQ/9BMP91l
         KadLnwtiTGKyxPKZJCRF0nSpBC1L982wOXsAhjyrDhBjPoh+ebGtOKZrKTq17FNDOA82
         +YFgGaQ72890GfG81igmf7B1gyGWRSdRnmIzZG0V7cwtU0HIoAX9MEG6px0w+P30F6vA
         8SiA==
X-Forwarded-Encrypted: i=1; AJvYcCWU60KiCSOekZ3J1YevpBcbj96X9VGL+IKikuTE5IfZBTZHUcJUh7UJsDlEM4EQGj9K77kfWgZiIW+db0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEm32hIcL82/BKeFyfZULO30HNLiZu+IfL26+xOlUoP+1pGQ+
	Nh/PNw91OyrhOJ/HMSuwuUr033/2oBYGABQ++wkSViFhhBdH/8v/sFCSCY8Wfadi+DLcn3G6nOp
	T6VL8K1vo4OAzPtCVIN7d1BJ3ZX9vrXvHiNlwCUWwjeABWQEwsejOVZE=
X-Google-Smtp-Source: AGHT+IFRL7j8it3So3AnD4li1g0JKoap/HeO6o4CdQOgNWYBqFByN/4LadKu96BXJbANgz7pqeBIyywqKxAALyHos0g/PSKt87/D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c84:b0:3a7:4eee:b7b9 with SMTP id
 e9e14a558f8ab-3a7f9a55a07mr71574355ab.13.1733314383337; Wed, 04 Dec 2024
 04:13:03 -0800 (PST)
Date: Wed, 04 Dec 2024 04:13:03 -0800
In-Reply-To: <tencent_D17D8971A3AD2454377A176446C8B37B8305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6750474f.050a0220.17bd51.0065.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rmdir
From: syzbot <syzbot+9260555647a5132edd48@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com
Tested-by: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com

Tested on:

commit:         89e182ea nilfs2: Preventing dirty inode
git tree:       https://github.com/ea1davis/linux nilfs/syz_0163
console output: https://syzkaller.appspot.com/x/log.txt?x=1035840f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35f1fa828fe386c2
dashboard link: https://syzkaller.appspot.com/bug?extid=9260555647a5132edd48
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

