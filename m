Return-Path: <linux-kernel+bounces-448762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6659F4534
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9338A1889600
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D4519F13C;
	Tue, 17 Dec 2024 07:34:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4611684B4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420845; cv=none; b=W6ySLyBtzEF9olmN6OZtZtVqy0QAttF0ZnCeN7s8j6ZChVg/otMJfC66UQGH2WmFb7+VvfHrumrcDs1P63YPc214Fr0idnm3Q67I963KByYeoyZQtz9qZUZBWEJisiF1MAxoT9bJ81/v6pqInx4DahBhewJgv6R4dgAomJ/otF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420845; c=relaxed/simple;
	bh=2qbBA8dB9rghq4JU3RMGDB0GWVpw/hyRn2QQ2R0T4xM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gZwtf6gu/aPZ8bMBYI5kam02AIs+I7btPdZxAjE6c6UH2t8shmemGHhtIkVHsMETCs1n1juwBgsaQCgahhKcmX/JlOEPsfT1Wc/p7deBrcTqzl6W6h0wyduRdKKL26SE/y+33MWWpZUmlCBEl/4epri+xrTUrDqgCMslNjaaCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9cc5c246bso55289405ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734420843; x=1735025643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuLku8nskRpw3kzYQNuILjeVKhjCyFHGbFaT7HP2LrI=;
        b=mndgHXL1FSA1dA6G1+slpyhcS9PEaTF3B8XKM/tdmtaSKCVUZ5PHkwFxPKxlh1jCo4
         OKtv9nimQU1U2kn9c4NkIVlA3Zr2fSY6YJmwkBbMB9XjmqgaUCqSPajrk/S4gwrVYgnx
         dP5GHRrVr/kC0W5XwXxmwPw+sgNl+SLzlYp+Z+HvtNGDXJbb8QMeal3NSPZk/BV5w1un
         Bazw13stZ5bgwbW8QnxO+5POCNy7+fjeUwkEDvBaQrN3jpGAUAh6VkJmHxCAioYUpHh9
         U2f8kKPtrn7NG4uAkcXcrbmapQNnRoZmRaobT7svPMCnm+Mim+Mz3/wsxuk9fOZQPTxF
         Ihig==
X-Forwarded-Encrypted: i=1; AJvYcCXfGpg0q+O0l1sasTX7BX3iLUTKoj/E1rNPHB09C6v7q4nfOQAGjgdcRLY9Cy9bz2TR6pBK56F+WZ8UmYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyivz7WAIom6bOtVxiwwNrEOnZfKJT1232/82mZ+6AQF1kodmt6
	xQCEDDPw9nVwjS3h8BUINVi2vPUsQ0AYJ+OnM0C+aC2VLz9gxQ9qdkSHWAjctYS6gytNztiKefm
	u3jHw//hV5yKES+tqP6fjyOGkOdmY6lWotYe4/N5WsdeRQ3o83GpSPr0=
X-Google-Smtp-Source: AGHT+IFo/TPCM5xWBSv33m9vYQP8bmdBxGISBsKlat+NgM/LZ8KwcEUmUrH0UbBkstxz0B4kVTnwbnvSX+gQ93bUJ+Fn/RSKeiIg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2408:b0:3a7:c5a6:9822 with SMTP id
 e9e14a558f8ab-3aff8c9255emr154827615ab.24.1734420842901; Mon, 16 Dec 2024
 23:34:02 -0800 (PST)
Date: Mon, 16 Dec 2024 23:34:02 -0800
In-Reply-To: <tencent_A3A5C98D8F1209DDBF5DFD997FCFD38D8507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761296a.050a0220.37aaf.014f.GAE@google.com>
Subject: Re: [syzbot] [gpio?] general protection fault in gpiolib_seq_stop
From: syzbot <syzbot+b95d0c98f01e7a95da72@syzkaller.appspotmail.com>
To: brgl@bgdev.pl, eadavis@qq.com, linus.walleij@linaro.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b95d0c98f01e7a95da72@syzkaller.appspotmail.com
Tested-by: syzbot+b95d0c98f01e7a95da72@syzkaller.appspotmail.com

Tested on:

commit:         36a3a495 fs/seq_file: Exit the subsequent process when..
git tree:       https://github.com/ea1davis/linux gpio/syz
console output: https://syzkaller.appspot.com/x/log.txt?x=160a8b44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8d97faf7b870c89
dashboard link: https://syzkaller.appspot.com/bug?extid=b95d0c98f01e7a95da72
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

