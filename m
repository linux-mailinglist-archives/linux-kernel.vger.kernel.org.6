Return-Path: <linux-kernel+bounces-440697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02A9EC306
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C52282AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6277208979;
	Wed, 11 Dec 2024 03:14:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77DCA4E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886844; cv=none; b=FY09ZnwPzXyWdztTT/vbIH5aAaajDIhBJTW+18obew/kmwr1G9CFZwGGvfELvpjDBvWfpybaJiqyuyohHC8UBUrRzWtK2CC7T5y4Djwha38GTwMV+tsLdkglOOFN9EwWTQ7LkQkhZbiB/eheFkB4zNkeoZ7CN/zABTwVIVfOpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886844; c=relaxed/simple;
	bh=uNdsxOh6w/4q4YhOO6WgmJHWeXojlmXswW8c1T2NVtE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dJbNnVsboPcvRM7WR/AlVECUwYWR9hFooMJeQuHoAC9X+gvwqD6T90li8KthatLLkLNhaW0friJ1o0V7yM7hO6J93smXX7qizpttiGyD39cKKQxLQGNyGW0x7d6lR5sqdeobEHGb6+/IZMwIFhbn1y+E+TxB0+zkrJgET0Z82z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a81777ab57so40951955ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733886842; x=1734491642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0W94+kQ3tRQ+O3QZLf8SyKmRW6RQEhoTIJ7U4RDgHI=;
        b=n8oTkvDW0N8Y8neC/EVDWPOu2iYOpFvyThdjMys90tS4lRWFAEeeMons8v/9/L7++x
         ikzusLPEqreRVfGP82jRqLjjhlTmTf6KZGgQ7SIrrUbVFCvrUpDpFbHBdss7RLMCETti
         B0n0prMItjHjjmnOzdqLnm3GO9km6beFn35zvr9hIQEt1Jxkah4jy1hFLfCFKtuJVVeh
         3otl2MrIGTCnS4iF0eT0qjQZ86S9xhsSUX5e778tf6XNGysDfnSrztAJ1GDxDPH3f01d
         29pBMMD8UHFW3ruxULkpl0z+cnH3itQDe0bxEPnYDk5M5Ysb2ghhNMfr+yAQeb7yChYK
         XBUw==
X-Forwarded-Encrypted: i=1; AJvYcCWV32wWdVezCSBU0hAl6bDDJ6t2ZYTV4K11k0q9tU6PN0M8lKXVwAub05/Mm7iqQbxj8wJSRozOtAVY3NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBnWv8FAwska8k+h0+lzJA4Sa1fL8YPQBoDBU6NV2KhvM9BtzJ
	O33Q9enDOVA5vw0FQ59G9Y5SK+sWRskrf5yrk7sPpnNFdpUdcHe2f4iu3xRMYJK9P7319s7g27G
	jbuX2+RhmQfS2RGF9soyAz0oBfA8RISYP8v8aLnxPpTZY6r+sBxYAdjI=
X-Google-Smtp-Source: AGHT+IGIjOZIyxdMur+PVZfSAqXCP92gYPE7/Et8+cFS4YQe79jNleZ88XKKmsCw4p4nuoFGSWy5higCF1W0Wiq3ByYVRpfaL8pK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e08:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3aa08f66f18mr11666915ab.17.1733886842313; Tue, 10 Dec 2024
 19:14:02 -0800 (PST)
Date: Tue, 10 Dec 2024 19:14:02 -0800
In-Reply-To: <PUZPR04MB6316E053BBAA0B434A32A147813E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759037a.050a0220.17f54a.0003.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com

Tested on:

commit:         f92f4749 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12034cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179da544580000

Note: testing is done by a robot and is best-effort only.

