Return-Path: <linux-kernel+bounces-214854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAEF908B21
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D851F2402D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27936195F03;
	Fri, 14 Jun 2024 11:57:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99B1922CF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366224; cv=none; b=PSXnDup0XthzuimVZCppcPLmtMTXWd8cnVeGT0llCDMbxpb+mX6x7XvqGu1U08CNghU93wpnZkLfOlRFYJ9Np7Dif0lKwTZry/XIsANV2pUqXm3nwbEsdmUUiq82Q+ALtJyKqv6qZJ4L8fJqVQA7xOnYDbbjmb7VO9Xu4HFucqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366224; c=relaxed/simple;
	bh=urbahdivYtQJRwE/+cQ+h7wkqRGiSdS+Fmf+rzf+Mgw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D+5+xl2ZXxPsB0b2GcAIJVMciS70gzooW3B5t2hp66hkcAGWAc2T9iJXbJlblV/8/Ttq6Nj1FWlzt470imlNkQOss90jP2LKymiiL/GKjVvTKIlRqOzjCK+v9+lkN4Q0M7dumciLsX/uDs8SDZdiPkkrH4VGgqjN1Hkc6AtPU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-375e96f5fb0so1089455ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366222; x=1718971022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UG26BZIp8MHuUfFMN7rTR0qynA+yQoDq3W/Fgy1C5rI=;
        b=xCXOC4jKjeXqHS01VrFi+yce5C+vvO11MnCesMdvMnftPfpgMGxWt674srfiEWdfto
         khdN1kI2YT+EsxUfT7YksfkP40DqLrisxFmVch8k6G4TYWRKdnd3+jjdeZP1pEJriqK2
         w3n2bI9Z2nGutIgyY5+kis670cG6QhcPf58U3Hk74HgBlSnXpGnxHRR5ezBlCMchGGil
         MYDXSCgwS6rt+eZ8oBb8laWfvLm8vD6+UDSZ06oQ+uKOtAAxUSHMUy0AOEWhOgpCinBs
         zQV6yfHzTnpKfstAyPNstvvCPVyMr158U7rPCpKUe/MAyEWH7j+LJuoFz1iYCxI7HY53
         twfA==
X-Forwarded-Encrypted: i=1; AJvYcCWuzqOAHe6G/DBbvOYVEK0ltCfUY5jKTtEyju1JFh50Eya1RteY9uA8LMydW/TC7uIJU+Ubx42dcL3kXZtozY8M4vp266JQBETvbqsd
X-Gm-Message-State: AOJu0Yw6O5jLfieOjcDyIASE4DJDC6DFJoG+C5waUHsGmk01vNpY36Fd
	hEzKiYV26516Yw9zfuUPF2KMmdMnhRsKmq9ZbMSjdyg9vL++mGltF15XvqDfU75unQgKEsbC27/
	GdqqMffvLHlVBj+BDRgxuDEtV6cTZjhc1KGHXo+R6DoZHEgWR2h430ZU=
X-Google-Smtp-Source: AGHT+IFLydEWn6llCrXvYAkie39Sj8mceqrYrTQ/qB1eKtQAhQtxnHhDA8VzBXZs0VITn07dp53yGjhDqAbyMHFjetvsWeJPX5Si
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c268:0:b0:375:8f93:bbb1 with SMTP id
 e9e14a558f8ab-375e0fe4c22mr990335ab.5.1718366222533; Fri, 14 Jun 2024
 04:57:02 -0700 (PDT)
Date: Fri, 14 Jun 2024 04:57:02 -0700
In-Reply-To: <20240614113224.590-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049d431061ad8502a@google.com>
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
From: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com

Tested on:

commit:         83a7eefe Linux 6.10-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15239646980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12217302980000

Note: testing is done by a robot and is best-effort only.

