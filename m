Return-Path: <linux-kernel+bounces-279323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E9F94BBDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAF71C20C64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4FA18B460;
	Thu,  8 Aug 2024 11:03:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844EF187FE4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114985; cv=none; b=qD7j5tAq+3RDLTGn1/F1b1Qkp8tuOZ9pEX99OV7V4UfMO/Vfpnwi/E560hU9eRUMGGTB07SChdtHxTWXrUF8mFxYyhF8h4oMAbVIi0pkTZwwzqWmaFSnqpdeFFHr6ZGJ+Z4GIQTLvMVWGesChBgfl9UdLp7uQ173nnu5nxiLvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114985; c=relaxed/simple;
	bh=Ok+dZk9SstegenVqbnAQRN6NWf1Fam24wrC95Gyx7z8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=czfRYQ7I9RRA7PiYJYdowAL4P+vlu0fxWS+DkLBm/YQNYZR9ZvpWmN/19AYYNoAEwGON1xj0RVlqZ7AHqr+2GUH+0mxlLx5gfCelR+YvMNyAgNbNqMSGjjCMD155t1pJB2TDS+nWQVLZUA4QT/2Cdxl6fV9xRNJKOvuZlNnuCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b3b5858e6so10555645ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 04:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723114982; x=1723719782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njYrZI2KAenj1tRYEV1B/WyO4YVNlDOY48s1Oi9rOOw=;
        b=tzUnaAQXi+FkK48ozpJfXOf6DW6/TyNPHTcbnjpQ/ZkHu1z8Ux/yZk8wwgBeO2CZ1J
         4rHUEj7zTZ3S2H+BUMwq9EDal3E1UgNCTVf9tBFu2osqx9q3+sFp92g8i87WeAaD9EyQ
         rerqKxcQZXCfU0/btcyo1aILDurzqTsvnXP5fYlH2v01vTDvAynPLLbdn0s9UA7T303E
         chAiI7y0ftuUmUr0GaushD0DXhalIbg/4GnpbCraybf3+c85Rf1mWOdxPx7eg4kEMYBa
         w/i1BOSi7VYP4KdSgQ1IU0m16V030j1xBzwoXJDaNvnn7XnZrrgbNZErx4vIdLED+VBq
         DZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxs2R45VOQJkMH7LA8669ixnlp6tsQdSe+Kik7p43refhW8GAnETtTlJPrEektVmG6qWr6vDeSI4FGjQU8EjzADTjzQNvTWzvjOl7C
X-Gm-Message-State: AOJu0Yy61sDEhVDUS8wL4RszDVxXEuSRXuidYmdkiPPL936Zft/pqfYX
	JpxBVCLKkpyr5484gOWD3Js2yS/MYxfi2i2taERqrtQHP7Au1a2NaLmUcTwH0lXePvggMuNHHVO
	bEI9O/gv7EBKJWuYuxet0Rpvk9LL4d2ZslIVNfACjYISlTwUTLIWISCU=
X-Google-Smtp-Source: AGHT+IE563ij+gekVscxGZzfs6EJqcj+1X3TmLCDhC/vmiiDnRfFQpLPrgC04GgGJsEn4UeHI4k+7X5clLTXlOlpcUEhyZXG8ftJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2b:b0:39a:e800:eec9 with SMTP id
 e9e14a558f8ab-39b5ed6c734mr1119185ab.4.1723114982649; Thu, 08 Aug 2024
 04:03:02 -0700 (PDT)
Date: Thu, 08 Aug 2024 04:03:02 -0700
In-Reply-To: <20240808103754.2783-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072c34e061f29f8c9@google.com>
Subject: Re: [syzbot] [pm?] INFO: trying to register non-static key in netdev_unregister_kobject
From: syzbot <syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com
Tested-by: syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com

Tested on:

commit:         6a0e3826 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11eff061980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73b1a61cb77f73e5
dashboard link: https://syzkaller.appspot.com/bug?extid=27c3c57b78da2a0995d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14872e5d980000

Note: testing is done by a robot and is best-effort only.

