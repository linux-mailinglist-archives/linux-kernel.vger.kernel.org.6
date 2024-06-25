Return-Path: <linux-kernel+bounces-228782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA249166B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C907128CB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1EB152780;
	Tue, 25 Jun 2024 11:58:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3F14AD24
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316685; cv=none; b=gy6c3Bo3t02O7C4CpC2+BghNMNlQcxRQ6ZFaWqsjwJQKUajDngEqIv6RWmXMlkpisCXQx+5hqJ8qkwccMekGZjtUhFxB+tsaGQsbqbwbeR4eK/C817OpABLcpliGFe0lGTSzqLLZrRXCn91pSJUVN5diGh7Y8wvYv1zc34G8DRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316685; c=relaxed/simple;
	bh=0f15n8ma0Q9Mpzfd1+X3vqQiq3EkG7Lb13nsN85k3yc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nFTdEtj58ld1Dd6Li8gVtw3tSSGLVpDKQdlkSQEn88RILnEa4BFlKO8HwsSKnLMPuvJ16EfWFunwoF1/KmxtuVsfJH+mD1YIUfrgri+uQjoR+A2Rm0737giT9H5QWGhyU/vZf3iqtC+XxXeYoC7rPl56MeaPhqZ2RWKUD0kMQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so751617139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719316683; x=1719921483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xetq9jceR+ywtf2s5NLXm7q53h6udxfHF1HBrH/NKzE=;
        b=aygJxDYXkJKosJvkY7vta4BlGHHMq1MXoDCOFbIB0pzWlCEIFmOSTuEcgBLjPv6Bns
         p1ENc+PFGB+l9JSK1p0T3xWA0iUufGT/nbO8VHv8d19a+LZaow6sHvV6IP+ghTQRZqra
         3FJj8kO7J0bj2YuNObxH5wKjRUlQgkh5JnVmMeQzVMjxbgBL0jCye7tKWWyc2lvWm4qs
         BfxPm/NkcqQTFA8gWvQ/nRnOd1gb9iq/Ro6dyI9D5Wgyt3EM7qPfi6pdiNf7SCGNfuUz
         6R/TuQfRGayQJB+8ZUib4Wl/LPcziXIoWu+hUor1wyP8z9GGqK75DqAzRAQigU4zSfvd
         tBzw==
X-Forwarded-Encrypted: i=1; AJvYcCUQx90C9VjXenOSCqVj4KmYRQRFx7ATOnE2ZB6iexLpHsGWIJJCXuLrWBfEZJsJIsxAUyFecABNVGF9q/h2dfOwGcuYMj28Agy0Fjv5
X-Gm-Message-State: AOJu0YxeqXJX3Vv8LzbCPEKU0iJKq8RD3dUK/JFwuCVyK8Xxd3B2IQdy
	Yb4kNZBpDufnXeaiRi1nCTwU03gUmQbnig6Xd2SUwWwDfc5Yr3PBbCKSxfhniIg5p2Zm9hWUBI5
	R5iXJRzJDCFXNdarDHT2U7cbRXswUi3MMOPrmE8mSu9Abdke6lmzUaKw=
X-Google-Smtp-Source: AGHT+IHy900GyA/6Nh8mg9c2NeWOMmgouP5pIH731lkx8ELXk/A6fc1GOPSre8tDyscasugvkpZFrTRB/MoMxARaZdULUraSEADm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1688:b0:4b9:13c9:b0fb with SMTP id
 8926c6da1cb9f-4b9ecede8f9mr522106173.5.1719316682963; Tue, 25 Jun 2024
 04:58:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:58:02 -0700
In-Reply-To: <20240625104012.2056-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000250dcc061bb59cf8@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sk_skb_reason_drop
From: syzbot <syzbot+f115fcf7e49b2ebc902d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f115fcf7e49b2ebc902d@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=175a07b6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1437ab35b9d90e65
dashboard link: https://syzkaller.appspot.com/bug?extid=f115fcf7e49b2ebc902d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f1f389980000

Note: testing is done by a robot and is best-effort only.

