Return-Path: <linux-kernel+bounces-171199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402178BE103
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722CC1C20BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF015252D;
	Tue,  7 May 2024 11:30:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F714E2F0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081407; cv=none; b=k3j2pXljOP99hrUp/E2su0OybEiVj3r0Vb1EKfNPSnfZyjB3PDhF1lknRJz3oPOwJbRpc04CQ3cqP9qlu4zxZH5pm+7ZIzw2sldDec07c3oLdvHS0ULHxQcUrdyqUV6lDmM/eEW8IQ65FiQCMT/sQEo68IDVqlTkogpa1IV7qIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081407; c=relaxed/simple;
	bh=ouPq1ImQr6BwL9gGhpva3sUJq8ov/1/P2vWzjlb0qCM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AlDp9iAUIOEjN9FoFzuPbVu7VehzvOElQdBYUFEhTmfcv0nbS6eoRjDT6xu0ydO91eGiC4ky1iopyR194q2JL9ueiC2LGSzOJbfkhSnxJD4WE8CbNd2zP1hT2yL+vUd+qlIVHSlMgF+2fJ7IB6NW4EC11AD4aD4mU4sDcaJQmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c5ec76c08so20913935ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715081405; x=1715686205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GUfzj+cOjI3lTKUNiWMDeoLyX1063O2jyJpXjnx1eU=;
        b=xELaGg8Qq2YHwZapf/s5KqAp9rYy3UPLcUnbFLZG/11yBiCL5AAMIrKR4vZKQVcQkv
         jYgsnqYxxJtzeTtdb0mt8xkFi+8mQ5YiX4fpB0DsVNJsdsd3vOr1yCbkUY3lS7p7huTz
         0Du0LTMhNDNnU/uGtvG16SMx3HyEbbmdIoTlkVA20UWTsBN9EMWITKncO/2lIdv+/0vx
         jerfgGW/IdX9JKrqsuzxXMWbPAveCbmUIUb/uebfVkoQRehzcNEIHkuRXnHkPK1G7BZq
         u4g7EOPpcyt+RDsdvzuRcY/5mzNd84eaCYE8IuwUjuUqvhI8MY5txmxnqc0L8GPGnV+c
         o9yg==
X-Forwarded-Encrypted: i=1; AJvYcCVTRfmbYuNonSsZAPVTgebd7J8Xb/9MMbpuOWKZZ04MkGRw0z76ZDwxijgMbHr4MxT/+JYBaxs3IDlDLBgZ6dv1ZsNDpR2rRPy7u0D1
X-Gm-Message-State: AOJu0YzGZjni+ugh52H+mPIFDqVI5e7Tliucir9qFwhWPDYAp7yAgSay
	oGlwhOkEDo0fzZO+d8asz5uuK5a0YvDq/MT8uLOZTkxvZmRy0UAMNtU0HComato/PR27gJ3mHCV
	G3G7tFWFvtS5GAZ6ygpCQ8cv8zJSEjqbdUDVmzidZtNfwpu/ZKFLz8Ic=
X-Google-Smtp-Source: AGHT+IEEu+uyAPb5jfl94XXMEfkVdZKh2KktG1jPdpJKDY6RdnOaOMt++iU0b26vxR+0bwAPkh+Xj0GoymWHrPs9skgHW8bkTELT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:36c:4cc9:5923 with SMTP id
 s14-20020a056e02216e00b0036c4cc95923mr740783ilv.2.1715081405751; Tue, 07 May
 2024 04:30:05 -0700 (PDT)
Date: Tue, 07 May 2024 04:30:05 -0700
In-Reply-To: <00000000000067ff3c0617c603c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f370b30617db817b@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in read_one_super
From: syzbot <syzbot+a8b0fb419355c91dda7f@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149d2fff180000
start commit:   dd5a440a31fa Linux 6.9-rc7
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=169d2fff180000
console output: https://syzkaller.appspot.com/x/log.txt?x=129d2fff180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=a8b0fb419355c91dda7f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135bf574980000

Reported-by: syzbot+a8b0fb419355c91dda7f@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

