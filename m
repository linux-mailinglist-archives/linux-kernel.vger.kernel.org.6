Return-Path: <linux-kernel+bounces-225404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B4913034
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E8B1F24529
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8EB1422A6;
	Fri, 21 Jun 2024 22:17:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0636127
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008224; cv=none; b=kdepEjMuA84MtMmjzAQxP0pkYVft5L1+7VwZ5i80SlYO/kSzWZtFv7kGGWVoVJaOqBRU/lL8BENxZV7BtxOlWo28FjCN0Mhdzqeon4mwbirQ2RCsO2VpungGdYdvmRIRYCz5h2rePWaP2J4HJi9kWTm5xGF7GVNhfKNaaJTqNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008224; c=relaxed/simple;
	bh=TnSlTjqwUYoXMF7xpWTfy7cgY8IeC4vWp5ZrJq8YaTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jqUv9Ze+X6gT5uz60i9nYiReWVaPfyMyccFy7TuHBAwIReRR8apvDoBoyZVSmvZBLgvxV66m3iMVT3YykrWRWQ79p+3O8EOBePeGZipSMzoRXZ1jLOiwtoJDM1wWtaTHgGKg9DtAzX8oD0st7dKDqr0fAfkk4cqmiVdgPldDhzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375e4d55457so25653925ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719008222; x=1719613022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzhDBRWwJ1VLwa7ll12EcMnW7G2/k0wBlm4KHTSpvsk=;
        b=fFrSI/7ac7uWR77cV6wk7D+qyrQenqi4yXAiT0IIZsjBGAE9bFgc5cIEQYWShzUxc0
         9q/XZVZwzNn9sncZDPq2glkeqXpDBt7OmYx6o0p0gOYC2XDZeaEi1qlutPw5fEGKJPOu
         38bsyrIDZJQ5K1ap9S5R45iyT0XU5QpGf2tIsM3/GXV1ho/jme0TQOxvcfLoAWrv6px9
         GtoPI0QCcXueLleWA8LnXW5UZAXote3WI8lC58CP/h777+l4bMMk5gnE/9x+14mYfOvZ
         jY1DZR+ANHuwry0+qVOpyrwz7hplCmEgh95e/PVofNlwlh0Npd+Wx7M2Q8R5eSZNcoOR
         /iqg==
X-Forwarded-Encrypted: i=1; AJvYcCUzOf/FRVaDDY+kzZMs+I7rMn91AcdLmFyO/7qb0CAXFb4mrxUSohgeUbEP/JKck3KRvnDjZuLcXhtq7iIIudONZI75tNAENiGC5Gcy
X-Gm-Message-State: AOJu0YzJIGfEQfahh1Ji4jN+6OjtvGlEkTkpZ+bHskr92vDAvMePS3xb
	c2U34Nh6S8e4zwQXu7MdnrLML/Ua0QQhMwBVxEdTc0FtcgXuF1o1VrIqrhQIOuTTBLQRpr43CoW
	fTiF+HjU5mx2CFsjlIf8PJM0zB33T5JSeAkIKSHhgP8EHPgp3TIZ0U+s=
X-Google-Smtp-Source: AGHT+IExnzpznCLMVa5YEOvMddL6ZtHebHjevxgzgt+MvgFNjpb8SsfjwEbCP9mvVfe8x0jiJpNhh6ltL+Q01pOnZRQp3BEjIDNY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:b0:375:cab8:f175 with SMTP id
 e9e14a558f8ab-3761d69f09bmr7250985ab.2.1719008222647; Fri, 21 Jun 2024
 15:17:02 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:17:02 -0700
In-Reply-To: <000000000000aa7cb106196f6883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a267d061b6dca15@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in bch2_gc_mark_key
From: syzbot <syzbot+050e797ad21ccc3f5d1a@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 103304021e54bfb5cab9ba04cd5ef0dc2bf33888
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Apr 20 02:44:12 2024 +0000

    bcachefs: Move gc of bucket.oldest_gen to workqueue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162879ea980000
start commit:   50736169ecc8 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112879ea980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=050e797ad21ccc3f5d1a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144f0a61980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cab6a6980000

Reported-by: syzbot+050e797ad21ccc3f5d1a@syzkaller.appspotmail.com
Fixes: 103304021e54 ("bcachefs: Move gc of bucket.oldest_gen to workqueue")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

