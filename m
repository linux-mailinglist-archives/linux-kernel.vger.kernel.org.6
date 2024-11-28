Return-Path: <linux-kernel+bounces-424751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B5E9DB8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08AFB23181
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2241ADFED;
	Thu, 28 Nov 2024 13:37:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964361BD9C5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801025; cv=none; b=of+6dvpt0Pl9b74MvpEgI50b1WNrz93trxO/qHBWtDzDJNN094ItMgHkm/30pe9tVIBU2uKd2VdmNYl121NRjdHDtl44Mi298660HzO944NyuPaGaq8bODmYmWlO52cKaWhf4EhdLdlp33KT7ICit2POuDFiV0qGuHL75rdO8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801025; c=relaxed/simple;
	bh=XN/pWww1KYMFPEUqakw6q0Gu207GWAFYxWG+i89MrSk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rPiKAMqzoLFNIxe4PjY+ujYTUSCLqHDuZvYgxB6rN51cmKVB9DqW1h0fVf+utOSUNCL4XJ20afbWRY856y4aRJPjSga1X6Xxevv2jHFgX5y0TZduaLveglr/IEzV45Qb2fHNd3+SP9g1hkUaiN/hyaM1W8DDKRMyPT2fIw6d/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8419946e077so74740339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801023; x=1733405823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpTkeZ0dzsyfQHaou+QVR1aBUXNmjkHRhq9VDD2c1AU=;
        b=Ese536p7AT0zFT4/bpDew/yhC3S1F+JBGR5UY5EKfg1CIx5FVJWkCifotZl51kcNrq
         kkQc2huXGRobyJNqSbony7pJWdTGXT4oVtj+uTMTACeM1OYyMvwrbWmaZnbhUw/ZfP93
         9SBzTU2LgitSJTPhaU6OTR9Me68Y8T/emKU5b1h5bj78EHoSW6oBTAzVIX2f8toL98qT
         928RrvArkoTNzjzRAxwUZI6ZEdOsmjfjmiaTt/eimM1uutSK3UnCPQV/1q+II1uWBUv2
         Ii0Do0hMXSHDVpW4qKJtY8wBqiBzHxxDqwGkzKJIFu6fssx2cImAwXZznWQpXbe8FO14
         X95A==
X-Forwarded-Encrypted: i=1; AJvYcCVMlJT8RueyLTspYs4aZxzrAHy9S8BaTZC7M2DZEdM4tA0TvhLQ/7HNuum+i9gAPo2QQ2uSJbBQlcyMgis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITh5YUBmwNsAZ0kMWwo6VyW0ZF9Ft0dtI///nPfW/5CHq8vqw
	oBvX+hAyy7Emz2dqvW6/s2bIRruKElIA8bY1sDxFPPDPWTQ2sKTUxwEUYSkQ/KaciBzoDnCm7/e
	T/KODERaQq/brGWIGGcbbJlXLpj2LUxks5zwWh+kCtJsjV1bPvh50cB0=
X-Google-Smtp-Source: AGHT+IFJfU/AK/E18ZU3olQ6wY8X9x6unYG87ldDZnfWNusKAuxCEfSYNQC6HOkuO6CGY9sNjghX5BIPEV7Dyin9kVgmJSHEJSqP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:3a7:464d:36a5 with SMTP id
 e9e14a558f8ab-3a7c55f0fadmr74371565ab.21.1732801022801; Thu, 28 Nov 2024
 05:37:02 -0800 (PST)
Date: Thu, 28 Nov 2024 05:37:02 -0800
In-Reply-To: <20241128130340.2021-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674871fe.050a0220.253251.0086.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: david@redhat.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
Tested-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com

Tested on:

commit:         b86545e0 Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14400d30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a5fdacfe3dee51
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1537200f980000

Note: testing is done by a robot and is best-effort only.

