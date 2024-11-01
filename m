Return-Path: <linux-kernel+bounces-392867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874B89B990B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93A31C2129D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DA1D1F50;
	Fri,  1 Nov 2024 19:54:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8CB1D0B8B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490844; cv=none; b=DRsbpjLeYaeQD+7yKoZG2k/kMMCP/2RBDN/rmwluyXgiykiklcnS0gRd+Vn89V/cx1Ng4hN/vjwuCLSMEEviZmCjc/FmN7dEVnX3a+I5wy/3kJZKBTa4hr7NcQ38GPlNUP7JBuW4vyBfPA8YTaS0GZpVX8GwaRVrxB9Mbnw3Pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490844; c=relaxed/simple;
	bh=8T08c4ViHxdRdt04IB93lbUJebJH1g6DSv3KJeWcAP4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JR05ikmbdrrDX2cIzIDJ45MJ5wEvdUCC6YtmZiIYUFSN0ovTrgU1jQ5KNOrU+GbSY5ZIFJhHbqgikb6epVRyr5JLnVVJpd7chET0uA46OwnaFG2rej1mS7jUlC7Luy3VUYa0+eGzTEf537ZRlN6C13Q0QsT1rGrFI8MOY72Ck5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3cb771556so20882375ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490843; x=1731095643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+8s9jsg7kj56nWZSY054okfs/Xt14HAbQYJwRRp8F0=;
        b=G/PqCr9Gmre4T/XSzwYu9X8TzF18mCtGtzRr2HGCRzeLu5RhHfP5WAxsnHjxTCgKco
         74SOCZdvJWJI1wfSacJtaQegZ70unF8q8PwI9buGivnMlDOIwxbSF1gr8Un4lkCKb2sl
         PNX98RvRCUcQfIGtJalBKpMfnzPxthTnReSdZeWURmj5tS6ZKV+5oFMgS1wON1rzRQGQ
         1SGZsqrYANh6LvNLK895gDCfF2LM6tslFR2e6JLZyKxuvIeyPKilEWh08juPfeyVtZ0i
         NBmAUOGsBPD5G7EegAKl6GHZF+t4h/C7PTkoxizVVTfkWLfvsxDM3jZHDiBVuaM7bLBE
         Pdbw==
X-Forwarded-Encrypted: i=1; AJvYcCWzJxkctdZFI6oHXZPhFrkimsg4nP9CZCImOGqCX1rGofTsK2EsoPiYOfRsl81FIybWq2FgbpATQ+wMis8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XroMfCZJi/CQjNmt/Ezl/otUxIJOphlYrPFhNEw4vQgtTt0V
	0bFEAoxn6P6dTQBMN1IWqPL/gWdPyKpGv1f6IHdb6HaQgdNiCzI/C+wCPGqXOjxvNCkQ/TDlgkX
	WDkjoilbTuU7ZCFkNF9Ha6EJvhPTPBMciSOKk+73Sqx15IZ2pxifcMVQ=
X-Google-Smtp-Source: AGHT+IHpNLh7R0kkqJ6nQR81kFDOSR6qjieoRchkxeJRrR//riJWj1+JRQRt/TaFMUzMizLp0I89dPSh5s0mKAOVLPKrwZfvVeCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a6b032b0edmr50789745ab.19.1730490842700; Fri, 01 Nov 2024
 12:54:02 -0700 (PDT)
Date: Fri, 01 Nov 2024 12:54:02 -0700
In-Reply-To: <CABBYNZK3cVQ1nZbRDW2-VRTwOsJOW7hoRQEV26Qeh2juDjnMvA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672531da.050a0220.35b515.0178.GAE@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, lvc-project@linuxtesting.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Tested-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com

Tested on:

commit:         c4264568 Merge tag 'acpi-6.12-rc6' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148ad340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cf68159adbdf217
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1122d340580000

Note: testing is done by a robot and is best-effort only.

