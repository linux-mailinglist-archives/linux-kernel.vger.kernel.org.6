Return-Path: <linux-kernel+bounces-407281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB609C6B45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E697E1F25336
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4A1C8FCE;
	Wed, 13 Nov 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrYVoPT6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749F1C8776
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489292; cv=none; b=gYYYsiGCKdEgmjpLbDqq75TjKg4dqShOTguAq4inWapCNCM/Q65he1GW/WmOrOcqgiC9KOdF8QjYaYQBBVirwIh2ElGA1ReiVb8tpU7TiVd1Iub6A6gqpXHKtZzIdeIrgTPdzMmGkoVK2+6mI42aZMqrlnsYXY+OyyZCjwememc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489292; c=relaxed/simple;
	bh=0R+6XRenndLMIJM9nY3chba05E+5sqc+/i8cxpXHfIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw+5cf+mJT2dDXSk3NhPsyqfotcSfP1ttIDkWb9JEv02viDbVWKgA5j+raqd4G9Kp5SzkLM/S/Sat66rrTn2d88sPyVQ5I2c7RJjgkOKjxrQ8D1ptG4y4J+kDzJR3mRr1LEwdhcp6VuSYbXBdDBrUozAQOedm5IGpWpuOn7tMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrYVoPT6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731489289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bo+a2oJM/DzF7/2w/lozMNF13YjGxFBwuRsrvmeNqLs=;
	b=YrYVoPT6TQqpojTbn6vEbqtB2yERhIZBAhIv0a/75bezwKstf5e0TMq8TZPFTvOWLM9/TF
	c1lQW+Zgnku/wU0DneMoI8qoa4htaKkeinLU3JXHF3NC75HFlwvd4uamc3xRl0WqtaczFE
	nlNsqXJ+wbW61qNLR1zyKuWyjw3u+Mo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-jD876l14OXG39oR5VkOZvA-1; Wed, 13 Nov 2024 04:14:46 -0500
X-MC-Unique: jD876l14OXG39oR5VkOZvA-1
X-Mimecast-MFC-AGG-ID: jD876l14OXG39oR5VkOZvA
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-856a0a4f3f7so786803241.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489286; x=1732094086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo+a2oJM/DzF7/2w/lozMNF13YjGxFBwuRsrvmeNqLs=;
        b=T+HGB8rIER96PF2EmApVlMC4TvG+RemFQWm7E13lpOUj/dyLDMvFt4jI/NonDa8cRj
         9yAzukhvEvf711llHVLvJ9w8yK8XydxPBZVLLsUPbE8YB3RSvdmq9VxAGLvm5vo13HX+
         vdt55vaYQqmV6Zzm28XrCLrjberfBLyeYCbhlXy1wg0ppsT1J3Zk1kUcfRaPc8ZGF6Tq
         cfOtfbZZD90dYbqZBHIS/+qmBksyxxRGjpci6UG7EP3Kb4+MRbrqNpBDxeElKXcYt8nG
         MIy2iXYuLoX1e5DhIIQaXyEjHR3iKdGeyMeZGTLWx0yKcXgqTflr1EQcMbw1vpL6/t5P
         yrCw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ivNRw+D8qT9+F5E3CFCflFh7IfRFvUvb1I+r7RXmOhrYLPpMxAv1xLBR1Wn9G4j9AM7k6BilCYroxYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VT0Vo7dCpIG7h5AW+v5Dra+QqdqDBQkZ8YfcLW5hwz27gKZ5
	LMChWUEPHgX98/8pnMECVFYur1sQeZvDki9ypxIec+FP83+Lvb+4YJxpPSgKPdjAISPgw5JgABj
	0O3q5wWHvz5KF4712hUpxG0dcUE/+Mb+T6MwOv9PFujCsOlumTsa+xdYakWLWX+UuqMdD1pFvky
	CyuwSr86h1Dytu+PxySRL3IQmmZ8aKoWJziJJA
X-Received: by 2002:a05:6102:3f50:b0:4a4:92f7:3611 with SMTP id ada2fe7eead31-4aae22bf83amr16647601137.12.1731489285754;
        Wed, 13 Nov 2024 01:14:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOl+1geTz+2YuwUXdn5bVXsVX5Z+UuowifTsSD86yBEMAnagBRJMr3rM3zLY10n9GT2KGtLlMIc44W6KxLIHg=
X-Received: by 2002:a05:6102:3f50:b0:4a4:92f7:3611 with SMTP id
 ada2fe7eead31-4aae22bf83amr16647598137.12.1731489285487; Wed, 13 Nov 2024
 01:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67336557.050a0220.a0661.041e.GAE@google.com>
In-Reply-To: <67336557.050a0220.a0661.041e.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 13 Nov 2024 17:14:34 +0800
Message-ID: <CAFj5m9+j=KNhaRruRZ7p0Nnt6PiqOVQN00vhgcwEgfKji=rJEg@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
To: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 10:30=E2=80=AFPM syzbot
<syzbot+867b0179d31db9955876@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16b520c058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D75175323f2078=
363
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D867b0179d31db99=
55876
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11b520c0580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/dis=
k-929beafb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinu=
x-929beafb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/b=
zImage-929beafb.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7589a4f702=
0b/mount_2.gz

...

>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git
 master


