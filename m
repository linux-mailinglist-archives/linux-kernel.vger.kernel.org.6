Return-Path: <linux-kernel+bounces-423050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F08949DA1E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A79EB2199D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7F145B27;
	Wed, 27 Nov 2024 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6Ui+qa2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8513B588
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687172; cv=none; b=mA3Zd3TU8gUFcE/HrCBMWR6eoG8EhlpH/3dDhaLwcHK3DtuadeJ2+ZPeqnCwpSAkGm0WU19pnTUuYN1a81hozUjbnvGfGb04I3tFGChEwWKVwo/4qzxr/7Wkm8KdcOxDEBSOb4G+qgApsvz4TOy7/RVW2GRWQhsi0irmiuBrseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687172; c=relaxed/simple;
	bh=2xLVoQahYDG/Yy0AV3UFbWueQ8rm1/faUzaNAFbsF1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRm156NOYGsXQ8bn/VkUs2pupsv92Dj44sjHlPpvWUCsFS+y0h22gjIf04m2KcKZu0+H3uadBIJbKwDA2h9HGW/WE2jfL1FnJB7tcP1XpGC3F0EdkWDIoUsU+CkasamNc9WjY/59BEhJOzBfR3EKbUJ893XpcAtqXTf4t8VwaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6Ui+qa2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732687169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/fjIUkQ27yd9Z8Hs7Zp53yDHC5wrDnKDcAqHCnJGWY=;
	b=S6Ui+qa299TYQR6gAAH8hidszYvW1Smlo//rvAyzgB4ajUxlR4D6bwFZgIAeaU5tUTlVVW
	6b1GoGclD328zgH3t4BZstTLX2GKyOLZLIU0DbLygJKAbZ0qQ/U8Lm7fRVuKTIRJ+ccO0j
	mpHaUiQo4cj5ZvHlOjOrByQA/a1YKgI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-5Ht_ep4INaqJGg7ITZtadA-1; Wed, 27 Nov 2024 00:59:27 -0500
X-MC-Unique: 5Ht_ep4INaqJGg7ITZtadA-1
X-Mimecast-MFC-AGG-ID: 5Ht_ep4INaqJGg7ITZtadA
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-84fdfb0203eso1055774241.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732687166; x=1733291966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/fjIUkQ27yd9Z8Hs7Zp53yDHC5wrDnKDcAqHCnJGWY=;
        b=UfnqUvyL0ObmUL/yctaYlj2LULI5LRqDx+hyc5LeBTunllnNMXV8pEG6alOJBHraBh
         bu+EyR3ov2VJ+XLIeVM2EgQVuDUCeT1h11gAfWKlWcBJp9ZxNOmXOnF2x7ZTTg0DP08X
         7dbLiQqW1LpE2ydNVNu9KwPUQBndaJOr3N2wN5lBKHEqU86FXZ1uCH6sSY5/bvnrTo+8
         mBHZgHlbGIUq1r7jLKwJX0+R5/tbgz+rAFPPBp1/6tum3XyBhF82H+WKYE2vKldtsJ8S
         ZO01Rj0s0FdepJOp557Xy6p/3RavNJ8PmkUzPum1nrH4BqzJ7s+poGWkAW9QcxWMA4iG
         6O2w==
X-Forwarded-Encrypted: i=1; AJvYcCUTaZ3mkQvu3SU+S0UTBUbkLbK18F+gLZ545HPd8ZtsEfGW7b/iGWVU65kVwS1ZRaDw+FepLEbfjVKf31g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7c6XPphMzQnbarqgOb6H5lVfucbFLeckZ0KkqQML/z6xUgjF
	Wcn79ywhbqw9SxHhN0SSKjR60ezEyj1Tr0J4KUHOiKOR50nbIIgs0oA2SQD6hpeycyGdt4Gmhhj
	bHxTrasrIO1X2w/PbUw761UTF0E32/HDnJI8TET/vFohRsfg2c4oxFSD4pdNnRgZJZ4TpS32qIe
	EYRX9DaGU+D5IHT6t53XdgyeR8CaDLuZyfbqzn
X-Gm-Gg: ASbGnctaMOrTKgdAo1nhM99iYLCThrPyJL53IDkzAH4X5nsoQH15nJQgeSNMY2jFOND
	G71CGdMM5YaSTEIsWnpuQF9z0/Zji3M2d
X-Received: by 2002:a05:6102:f0a:b0:4af:3f3c:515d with SMTP id ada2fe7eead31-4af447ba11amr2730465137.4.1732687166715;
        Tue, 26 Nov 2024 21:59:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2TQ15E4W1Ojy9i9gQaYjKOCM7Cc7smqBFyBhqtgupb5Nxx5IMgBRjxp6hWjbGXcqRPwQNKJwsG7sA0LlUiwk=
X-Received: by 2002:a05:6102:f0a:b0:4af:3f3c:515d with SMTP id
 ada2fe7eead31-4af447ba11amr2730459137.4.1732687166533; Tue, 26 Nov 2024
 21:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6741f6b2.050a0220.1cc393.0017.GAE@google.com>
In-Reply-To: <6741f6b2.050a0220.1cc393.0017.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 27 Nov 2024 13:59:15 +0800
Message-ID: <CAFj5m9JTrOdETvLY=pO=6oXC6NXPumAPa82281qra0sfakjr=g@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
To: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:37=E2=80=AFPM syzbot
<syzbot+5218c85078236fc46227@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D148bfec058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db011a14ee4cb9=
480
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5218c85078236fc=
46227
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-06afb0f3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aae0561fd279/vmlinu=
x-06afb0f3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/faa3af3fa7ce/b=
zImage-06afb0f3.xz
...

> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report

#syz test: https://github.com/ming1/linux v6.13/block-fix


