Return-Path: <linux-kernel+bounces-255722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D7934433
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF70028579F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2118508B;
	Wed, 17 Jul 2024 21:50:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238284688
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253008; cv=none; b=du+bjo/w1C9b2tSzHkvjCF1IarB+4ZiVBRIpWvvdyt8lV/73toChmbLsLvtlLRIprtni4LxdW6Xt7xUPk13RetOk0BIx0grNcGo7Y2AfBqUw05G4sdbZ8UTGKz5nNXnvmerY7yKIzGEXh2cXZXYfQR/z1LsmI6M3JaxTCIeMaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253008; c=relaxed/simple;
	bh=+eBBro3PQBsaMUtY7gcfw13AQa/817gonWAehx2e80w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c8omu2UVWOH3O6x0Lr8hzreFhVcjJSP2G9j4JHH4jsSjvBGTqaZJnyAuNMK+KQC8X/+QaGCOf4haVpLPPoPU5qDEZNQFnCAkObzLZTLM4+vKQq3pFbtRZENUakFvazII8pCHF0SzUSr7fM7H22FUneQI3rxjNce83FZaaZTY79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-385872df1e8so1493925ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253002; x=1721857802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKaySf5AjxLqJonlmsRKw21apjeXy69mObr15pBPZBQ=;
        b=OTJ+4vMQCql4Hxl4sKdjbJxBT2z2KLxZZ24claTv56KW5aorgtD8+bbdwNmFw3saes
         jOIzMAJm1tunvl+H6bNyaEQ4+gxS+wWlix/zCKNomt/gLBsn4or4sJ//Svzc13dVjdwS
         WuUWUvs4vhFPvgDwIG70G0fVyVE5oJM8jXw8RfLruCFb88ZkS6Z0xvRmx6yUjVgFmoPq
         skl0O56nTZkwIqJhjp2P8mT1Ed6Wd87yCydLu9qS8hzz7YF6trqpw72+XIjmt4ltSxWh
         h0znpswNjDzueosfk6Mhbgd2kw03EB1PbXOIMjj09gdqjonboC9yf20evWxLuBYHgiR/
         12KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWROHZybC81RuDFiMFch9/kA5qxjv4kUhHPEE5TCu1DyStXqPcquF+Bq2aMa/3Xj8gqEWUEaLIj3nNpg9IsWRKSjg2lSLcwDEHYuArt
X-Gm-Message-State: AOJu0YzUIFUSdylvvgSHqQv+/eTaWDV3MYqQwM+NpqLij6mYSN2AtlCE
	sn1cNNCwvH01TaCRg/akSB3ZFpln31brJ0J9ZqTMbZVvRAI0XLigC4wHUzREhKcU7obzZm+2+pt
	b8quO7C+Zk+dWIuohw1DNcA4rflWXalnZAqNyB13P8jGk+pnC+X1UB8A=
X-Google-Smtp-Source: AGHT+IGwoafUWDMauyRcfROevGgQsnU+wvph7AWbQdniwcZfPnBIMlVtgkka7T6s7yIUpIpV88FRhVB/340BQ+CEnAgcBmYn+Qy+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:380:9233:96fa with SMTP id
 e9e14a558f8ab-39557dbe6bemr2085655ab.5.1721253002273; Wed, 17 Jul 2024
 14:50:02 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:50:02 -0700
In-Reply-To: <20240717204111.1238897-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4f9b2061d7871ce@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in bch2_checksum
From: syzbot <syzbot+dd3d9835055dacb66f35@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+dd3d9835055dacb66f35@syzkaller.appspotmail.com
Tested-by: syzbot+dd3d9835055dacb66f35@syzkaller.appspotmail.com

Tested on:

commit:         e2f710f9 Merge tag 'ata-6.11-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ba82f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f87f8b8afcec45
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3d9835055dacb66f35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139decf1980000

Note: testing is done by a robot and is best-effort only.

