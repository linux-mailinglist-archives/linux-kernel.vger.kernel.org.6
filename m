Return-Path: <linux-kernel+bounces-322835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CC97300F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1597E28862D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5388518A6D2;
	Tue, 10 Sep 2024 09:57:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FFEEC9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962227; cv=none; b=pthhO73YIaQLfUKxpnvZbthdaeFrGA4to+sWoTj5FfGB80MlAh30VNHVK4xqaDOnDPkTIeEZX30s/PnxF3f6LIP5ebJhRCkvE88srv8xHb7hcvs9ogsPxT+JVGTZs4KIHidmv4TznhBMhAVRg8JYNSj71T/mw1oDemXIQNk+KxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962227; c=relaxed/simple;
	bh=Z7p7cYr0P94jl+/CBtnvjdmcnpTdI6ldYgL/Ei6ZtPQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QGvQJJS6KIoIJzW2yyCXPgLI1iWnBIUV4gWscxG2RfkG0f3Q0cTrUGjKNyjehO2W+NdPQiECZYl3XXgEzCO9r5rWsfOLj8ka08A+HzX1/0JBqX89jvybIa/lKIOkmYlwMu9ZOyDk34w3GnrA6hD7Gs13ugDIhH3NdMpLlRHIup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cdd759b8cso395497139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962225; x=1726567025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOLj+wpV9tOv481WB1hGzb1GDAh4NnOtpedgaJw3Um0=;
        b=xPVy12+o63bhlByGtVG021dn9dABhkifAwQGO1/ROEE+pAi8jNdsUu/cZ1ftTUOTB4
         OwBnEuuI7n7UaqWZAkoz41kzNnm56spAkvaH/NOVmN0uBgqAEv/bOCK0XM/GnTLvZfsH
         T9H31ar+jEUO/vr7WNErBQcSwOyoEoj2TprIWQc20eVGuw6/B6Zp904VitcDVx9W4lSA
         Y+mRxdGqzdJk54qL7OF96/Mw+2OKLQxkl0Y/LpCj3p14LjDOrN1vl73QtEmGZfGiiATc
         WNDSTTyyfDaY8Lqp4OqQ9n6we2LqhNdroZluuYoejBtFGHA4tsBL/mYNC5yf3+Rl8Fym
         eeOg==
X-Forwarded-Encrypted: i=1; AJvYcCXKlihxGJ7yBVUpH9eqP3parM6Aka9/+j6/4SJYh164bbKC9QVq4aIjn2KlJ10js80NA/CRifBOvwNEBqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcFtFd5fOIOPxatC01ve8ZuQgGXbR7qLRGFscyqUMtURcnWEo
	uL1GTn+fAJN0kAmdljFEJ/tx2jSEWNgqjkewWfI150c4snihbq3ouFkIL0a+tVvKJCdzIeGkvWQ
	OlvlqA8WVW5zHC2x6ecpnIAtaTDC/yknnuaT36+tOZl6GfG5wW69E13s=
X-Google-Smtp-Source: AGHT+IGoG9iPn34RpVW+UCBDPxK9g6hgaDkM9O1vW86HEd0ZbJyDW/QG4TCKPLEhqCMGb8nxdlc5+q6UCE/HKBW+Zn9qks+x1Ns6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15cd:b0:7f3:d85e:476f with SMTP id
 ca18e2360f4ac-82cfb055bc5mr216512239f.6.1725962225405; Tue, 10 Sep 2024
 02:57:05 -0700 (PDT)
Date: Tue, 10 Sep 2024 02:57:05 -0700
In-Reply-To: <tencent_39E577CF66F23C93361697B036464B627409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057689f0621c0e5d9@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15a27bc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173c6797980000

Note: testing is done by a robot and is best-effort only.

