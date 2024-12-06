Return-Path: <linux-kernel+bounces-435691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B276A9E7B04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F2C280C46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09C212FB6;
	Fri,  6 Dec 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zq+cGd8C"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB212212F9B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520619; cv=none; b=aZV+60Aprt7YDyoVACzCNf/OERRLM5Hrnq0LyM2oyc0/Hf7SuQT1M0G1ultiOsynEw3g07CX6XVC30h+qvijlYspu0CoExsFmDIWv4tFzJR08lUvy6RfUMsKGWYqe39EqP+1Jw2jezHSfEzGZk8PRwndhjTRwd1sYbHZkZPh89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520619; c=relaxed/simple;
	bh=JkYGYFzLZtglPFORMwRQgwLy+lFxFzXdZ+w7WzwpaC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjj2wKK5XiFBsW3MTHcQm4Ev6Ak8U28+Ruu/cd+HMEze8LKxE0tF5Lf+EkwQlPo4waEm2w/eseHNVtEfYnMM7JFB/92aSHeH0PVX0pM1XKe9zJHwdRNEZUr7z5mYBFWd3bkIMF1LMf0C0TZRyx6s3E/OJirvkP0DCB7ahxdXFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zq+cGd8C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso26a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 13:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733520616; x=1734125416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kgpYUosD2lb2XE22vygZ7rHIfhQpNZQ3tk37vvCnIg=;
        b=zq+cGd8C+SBzThd5SkIgZoE5Jx6NbtMCY7MvAMELH9RoePbGHMEZ6jjzHJj6nhs4U2
         sOZ9wVzgDnGaFWAdoRHipbOrnocNTxrqATezECj5F99uodKyaTZK8EfWfWUbTO8Nsa2q
         0FymwrX+0yyGZ4srd9THaqFRHZihh9CNCjG7mjjpC0Aczjz3XaZsAzpb0liY2+uYihNn
         L0uiRVU51hP8KstOn22sGQlq44grvcJc37SaT3mhvaMscAOHovIeCbx24P9qY1je76fX
         QdRexkcTjLMPMCb1pYALCIRS2037eX77xvhsk81WyHPUdM049PzYuA0VbWhM7Azezs3r
         pXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733520616; x=1734125416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kgpYUosD2lb2XE22vygZ7rHIfhQpNZQ3tk37vvCnIg=;
        b=s5iObnQgml9C6HXIu8vlNlOb4a0+4pUY0jLBMRaPflPHZD40m1ZeMBSuEjG/y+LUHF
         CVnxBsqCAaKOMNmw5f9FKYzMsNdZZ1nUxmtYuYmuHmEDfjRR1n1bcQX7R/bIL9zGqheY
         sNdspGvGQyUAspKG70ivRdfGm/zathEN4n1J7SCS++XtqYHKrkzMp3h5047An0ItOsel
         z41RCzEkIBA0kMERBq1MdE3VdiJws+gY62KpEg/m5WvusCoaHxtWSts9krJfcS0MBQIh
         6EGs/zMsXQwiYe/5t/O5aK4wMw6+7K5hkUQ7dQaqTHILP3K9hdckqkqs9MR7JfUCmOdp
         mtcw==
X-Forwarded-Encrypted: i=1; AJvYcCWQUkZ40S6o/I+++8W/5X+xdQmMu4s7jMu7r5NQWx8CZ8qSEokOI3dcozc8lt6nqLqn8ivc+Vl0FYRZjOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8DgWEaoUOpXU3tlutPX8eEKzAKQKkuBaxkfz1X+9HpAg/3Ht
	TsYVaVeiSi+V4AyyR5cNvMWZpamckTkFbQiZUHaz2mLu/0aFQC62NSO8ubzl0n7Vrn8o9Facczt
	0eywYLLz1UQXX8gwvEYIdw7G6odeMwPvAXpSQ
X-Gm-Gg: ASbGncuJs7LZDfHxDplATGjH+r4vkrEmxpOujBZuXWmAfydEYlG+55MpvBmv2GyJhbn
	XEBYeRFND/4O77rFAeK/ZlKFkLTodfspD1pULYYQa2UZSuv0QlLS5EV+Ovg4=
X-Google-Smtp-Source: AGHT+IFWnDDQmnmvfkO6/SohqfCNYuLCsZUVTQgItdbQlZHAO7yIWKPb1liIghwjfOO3wQE6bHfeZFVP5pCQXBm7tQQ=
X-Received: by 2002:aa7:d507:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5d3db4b972cmr14299a12.1.1733520615774; Fri, 06 Dec 2024
 13:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67536a25.050a0220.a30f1.0149.GAE@google.com>
In-Reply-To: <67536a25.050a0220.a30f1.0149.GAE@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Dec 2024 22:29:39 +0100
Message-ID: <CAG48ez31brKBFSMW2ANZQAM4P3nzoico3yedtmBv3MK59-eeog@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __mmap_region
To: syzbot <syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:18=E2=80=AFPM syzbot
<syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e70140ba0d2b Get rid of 'remove_new' relic from platform =
d..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1330033058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D50c7a61469ce7=
7e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D91cf8da9401355f=
946c3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D124130df980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10a280f858000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-e70140ba.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/91f313d8125b/vmlinu=
x-e70140ba.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a9bdf286943a/b=
zImage-e70140ba.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in __mmap_complete mm/vma.c:2408 [inline]
> BUG: KASAN: slab-use-after-free in __mmap_region+0x1802/0x2cd0 mm/vma.c:2=
469
> Read of size 8 at addr ffff8880403a6118 by task syz-executor239/5461

This looks like it was introduced by commit 5ac87a885aec ("mm: defer
second attempt at merge on mmap()"), which went into 6.13-rc1? From a
glance it seems like the "vma_merge_existing_range(&vmg)" in
__mmap_region() needs a "vma =3D " at the start of the line.

