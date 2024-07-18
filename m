Return-Path: <linux-kernel+bounces-256524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC3934FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20889B23B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BD71442EF;
	Thu, 18 Jul 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5AJb37v"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB213C9CF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315427; cv=none; b=ebeyJYaNpi6Tz3KQqQdsty3O15vr/+Xeh37GdRFdrCmRW/Jzj8fzo4mxQmkrsy3EIoLhc9VFYzO2YD7jnwIzambHlKhWG5tCJ4AxjwraI/LWtCMpk8Efnq7ah3HPNscYJAu1s7RfbKhkPKI+IrZSHwb8FKNYcJ7qODCnW+a7uvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315427; c=relaxed/simple;
	bh=/Rob65fM3+aRaB5LrNu1u3X92itUJ28DXou6slgyftE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlzlIm86pnY5mUQCA53gu1AQ0QnjS7rsvbe5/o/MBDD9sMjNIhgRpbxyoVqJ+XW1XsxXQ/eCQvbO3PI5Ov13cK8BobdhWdwbCQErZahaYmpH0zozo5puMbJV/Tmx/csqzAWQeug2v7v7zdeLOGvD+Tq+nu8xPSJ0cx55CdOaZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5AJb37v; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b796667348so7377776d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721315425; x=1721920225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NuZKb+8fjUNjlnDoDMU26Z6gLE1hV8BUCclUB3ih1w=;
        b=r5AJb37vVrZi4LgFjopAUEuwxEATA2KA6cO/VzXIr2ShaygDYKF4IyQLd5z+9+QThp
         0ElMStobUesaUtVB2EgrhwARQO6KgGuMlkOCWfLi4ztFXPZLF3HJo5METMNR+bwheUcs
         dRRT2pPJZZOjTtP7Fv8qti3iQopijnT28FrIk/K49nQbmceGhul1TxtDNg5YZ3eDzoRv
         PxC5skOt+d8q+oFZJRzfrQ8maCsMcuxm63OfHu4comP0zbhD6ZUITcqjHrhs6/e3cu88
         8flsrZsluWZftHzKWsMsIssQC2eHL87J5dX4NXYV3oC0KKfmg+9mUhtofcmK5anfSv3Y
         VzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721315425; x=1721920225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NuZKb+8fjUNjlnDoDMU26Z6gLE1hV8BUCclUB3ih1w=;
        b=UscJ4SLUYDBYNMQhBgFhV8/IE9SZKXp6CNtlDGUsogaK+Y/C7ryjYZyMtG2Hm7xbIF
         rdT93IzcbfPMwxp0F+SEiZATpP2hTK1/5fw2n4ozAusamhofnt9nLNE+U7S15bEPHD92
         qgoAhAD8BxnlfWaBgslvHhUnwbJPmYHFCtuPf2TiKzyuaTgvQk6iH6ycNM0XIsniTMwS
         pR8ltXLa/WYEguoDgcDluPZkFCbg1LXuY7kf/49fX9OnNiz5Gq8Cogn3nMEPw0pqwHD/
         uXBznYdywuYcUVdHKlN3aWn5V37srKBvAkb60z3ZKFjFETZL9avjg9IUsn7LkQzm/wZB
         gtAg==
X-Forwarded-Encrypted: i=1; AJvYcCVkV1xPf0a8wkQv2mer5GedKY/yWFqtGED8aVNIG+VpjGRYLKMm2oVLooWkfj9y+wMjS9z/OBvfy3GAKkH0n8cTm/zwotO6bxRgf8w2
X-Gm-Message-State: AOJu0YyjlH3BS5N8mBE/EP/1ra7iJCZrVYYGCyLAiXysNfGRpY6+weGz
	zHX8gnioc9zJMBR15/8NoSLG9dcclyPevyhEOW//XlTv+qBhf3oxjJGaF0m8Z6vcoKWuDvK4YVZ
	CTe5K9Rg8UJmCc42nfofdO6fgxU7MRrL0J8YS
X-Google-Smtp-Source: AGHT+IGoglnoNYVfOL8Zm7Oker3ocuUgGHrDYu2Yd8e/L3gvhmhKE2vl+5Nw7A5JdAXyAHYVQ7/jKIhl4nx2VrvsuJs=
X-Received: by 2002:a05:6214:2462:b0:6b5:82e1:f89e with SMTP id
 6a1803df08f44-6b79d006d80mr47186406d6.9.1721315422332; Thu, 18 Jul 2024
 08:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000df3f0b061d86c48f@google.com>
In-Reply-To: <000000000000df3f0b061d86c48f@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 18 Jul 2024 17:09:42 +0200
Message-ID: <CAG_fn=XWBP_b+fhquq9PMoN+vC7TXBWmvicvaJpOnbh3djaxRQ@mail.gmail.com>
Subject: Re: [syzbot] [arm?] KASAN: invalid-access Write in setup_arch
To: syzbot <syzbot+1aa1114f144c4051c1dd@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:55=E2=80=AFPM syzbot
<syzbot+1aa1114f144c4051c1dd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9dafbe7b06a9 Merge remote-tracking branch 'kernel/kvmarm/=
n..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvma=
rm.git fuzzme
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12fd98b198000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D25f90809fb74c=
5a4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1aa1114f144c405=
1c1dd
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.

I am afraid this is an invalid report caused by me shooting down QEMU insta=
nces.

#syz invalid

