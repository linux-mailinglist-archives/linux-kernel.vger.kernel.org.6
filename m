Return-Path: <linux-kernel+bounces-355466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D089952A3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDD61F266E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5E1E0B63;
	Tue,  8 Oct 2024 14:58:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED41E04B2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399484; cv=none; b=GA/1wqIx20OBWL4YDza8ubKzHXDmYX9a39ZC6qKWZZdLO7bThQaz4xtZZcrzL2tSGIyYNMiYNB5gRLXznqeQZ+l8/i3HEcQLiXJXZMKpaOhfyT8X+SWD4zrH6A23ANZdP2JtqJgz4OBwSgOWE5dRNhdt4DPH5kxVNwGbxGYPfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399484; c=relaxed/simple;
	bh=nOwVle6Stxv3v1afRCHltJokfacn4AR/Tx+Mw/jcOxM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M2UXdRehy/2LHL7PPSzm5gxbJXBVllmB6p3RGmUVKW1UAaElenheRCICzT+1ZrPsAcFf3bEj1gzmjX8XajOBUt8Ogg2rlyFqLSSGcvN/isJNnT/+GwUhbBWnuaG3Z0DzGUa6KJ1MyMvDuVL9yweQgBkJoftuLSnPa4PxWOCNoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa4678394so837085939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399482; x=1729004282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJeGD9Y8jrgl/oXElrMR31OMURMD73DY4O53Q4xsm4E=;
        b=u4wUii+3HrJq7hhSENulEXtsO9UV8d18SgIJ4R3g/eutwGWxa8ScAMrCdEHFTjsTZl
         h0wf+SyNAzXWu0wqVFTrLpz6AcZRxEaq6WOOzs1WQ3btrniDWzxD2dd/4xjuwqJqi6pf
         PsKEV6tPNqHl2XcOt01Xgj4O7VeCJsWETMbfJ1i3bIAT/BtnJ3HWnzOzYMKQYLnbmdmp
         +/w5i/UWlV5YP/05ta/TltsZjdEN19JrdYT6mLBBCOtoXOauWk2GdHdyIkcGew86FZ8M
         t0r0yqjHq1OV1rKsfD5K8hpGqA76yMZL3fX7zdBiTvmHje0uVdffkVbyJ+vsNio06+pQ
         NwjA==
X-Forwarded-Encrypted: i=1; AJvYcCWkvvDNSfxJUZmPaKcJ8a70tA2jRyy54giT8FoOjgpoYP0NUJTWFp+k6yf1PmSNZAqBMy3xbDol+NZOgng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TxLsglC5sNvisnher27DWpqJNeZGJCa0rNMltC9vXgHCpPhA
	8/RrHsgI2jT6RWW/hSdsVvI4okCAl/Fyl0PDgSSG6AJapIWLda7YAtVtONi+fMEdt37CoUq8dgL
	DytjOViTLJOTlIWWVGfIHb/Pz1KvfXrDwEOQ9L4XuCYDDEY1OZR6eVas=
X-Google-Smtp-Source: AGHT+IGX4SuMzVSoQiQAHj6OBoBlstm9xuwOTUA9Kerj7ivq743kOGItuXZZrlQH7lZ/MZN+dlztP2lAzxAhHOtHA6s7fBdkeQ/x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3417:b0:82d:581:8860 with SMTP id
 ca18e2360f4ac-834f7d7804bmr1348258139f.12.1728399482375; Tue, 08 Oct 2024
 07:58:02 -0700 (PDT)
Date: Tue, 08 Oct 2024 07:58:02 -0700
In-Reply-To: <CABBYNZJeFv3a=WuKpN0=6KwvELtWXOoRn9HrGhxnVVg_TVaa-Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6705487a.050a0220.840ef.0005.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
From: syzbot <syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com>
To: eadavis@qq.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com

Tested on:

commit:         87d6aab2 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bf8f9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f41780580000

Note: testing is done by a robot and is best-effort only.

