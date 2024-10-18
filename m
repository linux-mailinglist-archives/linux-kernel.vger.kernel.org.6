Return-Path: <linux-kernel+bounces-371201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948B9A37C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B51C2596E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6118C03A;
	Fri, 18 Oct 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1Q+yX7t"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BF13541B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238176; cv=none; b=kpurXl8tL+zg8UzRw1/EuSdOMTuv/T3UAA1c5zTw+d2VWk2beCfym3ahRAfe77E2YsPLnNjuUj5BfAa4lG9nGhdBwweEUKFozdoPaD9a5BX4d40WTqJFRicKAeG5C57qp/FL6SbSX3O1F/wyadHvSvuENodUwREKf04L+3m07cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238176; c=relaxed/simple;
	bh=qGHKCM0EJpD8qdnNiLz8pS5lOrUgcjhhtCWD7+5JfD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYCGG/xD0ujghveqrVPGJF8MtjSnjvrz8urlYLG7byEN0sQwjZ9RAwHP0rjvude1M0OLFaWmo/hQH6QSXGNxbrUTSM/8lwWOqsg+HrHuTjRJNgH0JRclhV3RPQgg6UW2B0/WsLMlBfGjZadcu1lPlUnaBXghqSZPN64/1lo24uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1Q+yX7t; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cbcd71012so16699365ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729238174; x=1729842974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFAYxOZA8XPR3YEUP2ACpjVNkL5UpRTrPKZ7qShxEQ4=;
        b=k1Q+yX7tLOdeex4Mx7NkeY2cOg7MS5dnRXLcG3jATeB5T9uLMet6g3Nt3DWZ80bMMw
         ryGTRHkJ9SDtqrP6rEJ/EbB3Gr+9qaEWWrz3UPixxS49mYAbbnJdFePWM32S4Ky4pm6n
         iI28ui4/kQT+Y+rQbMitP4hhgnUpuJqKuODK0RRvdbadQ1kf0H3e7PXR82HEE7meZx7W
         PuuAQd2+hKg5KRmCl/jFZo7l8AXtLRRaMxOBykurhKD6h4+q6KdmE4waXXA8t1Ht/Zhm
         5VTjvMK1lsB59nHzqoN+RaD58zKRxfKi/ugHM3fni70J1XwsnpUsWcSdGiwfPK81pz0Z
         MTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238174; x=1729842974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFAYxOZA8XPR3YEUP2ACpjVNkL5UpRTrPKZ7qShxEQ4=;
        b=jsUheBr6c10SWEUNG/nwJdfnJWk2eYt6AyDLT4VHY5R0ooDGWw5eyPcIIoSeqYgYZV
         iTA6la9QlbEE1SSSPId7QwtuNAJKMWgH/rqWNgsr0k2udnW19JjstOLNGH5BDmwSMg+t
         140ua7CI++ldWBk8n3MVaDPOa54KrX9w/g8e7B6qJWuJsCrkreQBMYfJQYJP637lB0dV
         MBakM9RvZ0VJyp/qiBQ8pSAcw/zkCdDGgVFqSfJqzFJx16IttyvRra1LCVRX03dUpKee
         C1ypuq7RYaYy+z3JJAlLQdoD0ny4ZhlBP2e6knNnJ6BAq//pZ0F4vlleUwbXkLw4nHPQ
         RS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6YH8FsWYTdKKqKuy3oTBnlBFqQWWBCpTKqyUfHsDFqm0w2PIEeTKdjmv/qgK3FpasVKVbIf+E+cLa1wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwthbHfE3flMM36Kjqpi5+zGgbJ6RMKBGzKOPHZ9dHtJsLfbzP
	VHH2fU3GvAy7+CxeHe5a5a0HJy04uVESQ+Yq4zz/9d2J3O/Dm/uUK9ytrPDJXdvFvIjjamGAaub
	cOol57GltmizfRMeMU3pC1zoa/5GiMJMZB4wD
X-Google-Smtp-Source: AGHT+IHfl2rMeu95YQE2q7QFhvYT23TmwsAPFHb6ZBGtuhB27LReQBjsdMm3t79Qp1gkKhBeH69Nz3UfFkcslASi9gQ=
X-Received: by 2002:a05:6a21:1349:b0:1d9:27e5:7c3b with SMTP id
 adf61e73a8af0-1d92c50d962mr2158165637.22.1729238173991; Fri, 18 Oct 2024
 00:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c6b91e0621a312f4@google.com> <670e81a9.050a0220.d9b66.0153.GAE@google.com>
 <20241015153958.df4e735274e389999de60d2e@linux-foundation.org>
 <CANp29Y6czU3c-9FhdcyjfJtWrnaHJZ4o3WyY6TUeGo7TnP0KtQ@mail.gmail.com> <20241016143743.675996b564d269419c129d29@linux-foundation.org>
In-Reply-To: <20241016143743.675996b564d269419c129d29@linux-foundation.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 18 Oct 2024 09:56:02 +0200
Message-ID: <CANp29Y4Gqg6boR+W8i+vZD+DAE23tRM1HdfOwN4Myedq+dYvQw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: corrupted list in add_to_unbuddied
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com>, 
	linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:37=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 16 Oct 2024 08:19:25 +0200 Aleksandr Nogikh <nogikh@google.com> w=
rote:
>
> > Hi Andrew,
> >
> > On Wed, Oct 16, 2024 at 12:40=E2=80=AFAM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 15 Oct 2024 07:52:25 -0700 syzbot <syzbot+30eac43568e2b3d6572=
8@syzkaller.appspotmail.com> wrote:
> > >
> > > > syzbot has found a reproducer for the following issue on:
> > > >
> > > > HEAD commit:    eca631b8fe80 Merge tag 'f2fs-6.12-rc4' of git://git=
.kernel..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14d0845=
f980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcfbd94c=
114a3d407
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D30eac4356=
8e2b3d65728
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16df4=
c40580000
> > >
> > > Something seems rather wrong with the "syz repro" page.
> > >
> > >
> >
> > What exactly looks wrong? :)
>

Hi Andrew,

That is not garbage :)
That's the compressed disk image that is mounted by the reproducer.
These images are often also mutated/corrupted and therefore unique in
each case, so we have no other option than to keep them in the
reproducer. If you scroll the file to the bottom, you'll see the other
syscalls that are part of it.

> I click on the link
> (https://syzkaller.appspot.com/x/repro.syz?x=3D16df4c40580000) and I get
> the below garbage:

--=20
Aleksandr

>
> > >
> > > # https://syzkaller.appspot.com/bug?id=3D6b5f76b3a3783e6b1876d25b2d7a=
981ac0e0131f
> > > # See https://goo.gl/kgGztJ for information about syzkaller reproduce=
rs.
> > > #{"threaded":true,"repeat":true,"procs":6,"slowdown":1,"sandbox":"non=
e","sandbox_arg":0,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,=
"binfmt_misc":true,"close_fds":true,"usb":true,"vhci":true,"wifi":true,"iee=
e802154":true,"sysctl":true,"swap":true,"tmpdir":true,"segv":true}
> > > syz_mount_image$ntfs3(&(0x7f0000000000), &(0x7f0000000140)=3D'./bus\x=
00', 0x19c6038, &(0x7f0000000180)=3DANY=3D[], 0x1, 0x1f231, &(0x7f000003e78=
0)=3D"$eJzs3QmYTeUfB/D37Pu+XLvBWEO2RLLvsm+pZAvZyRalGhJRSSWpFElCQqhUEklEsi8J=
SZKQVEIS/2fu3JlmufOvadf7/TyPOfeee877nnu+94z5ne0ebz25edsGbRISEhKIzZAU50gGSSS=
JXIq9xsfGXYoNmdi/EZ3nV9ttftQreZxZcOVtoxYUXjVUa7/MfEsim+xOx09VOLwp3JT7+MW2vX=
oPSeg9JGHAwKEJXRO6DRw4tGu3fj0Suvce0rdsQst+PboO6ZHQe8CQHoMzvNyz38BBg0YmdB3Q3=
VAHDe4xZEhC1wEjE/r2GJkwdGDC0MEjE7re2rX3gISyZcsmGCqB36jd/H96CQAAAAAAAAAAAAAA=
AAAA4M9x6VLaoX0AAAAAAAAAAAAAAAAAAAC4TDVo3LR+OaKkPWcIQxoRhsxlCCH2L9OlXvfPZdN=
O8qRdoo9yRX82Sn10um/5fuf
> > > <and a huge amount more>
> > >
>

