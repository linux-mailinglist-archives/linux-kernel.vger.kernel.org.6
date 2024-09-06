Return-Path: <linux-kernel+bounces-319078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346DA96F776
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08D6285D4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468761D172C;
	Fri,  6 Sep 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGdJPyEq"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDC1E4BE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634385; cv=none; b=smG5D/N5pZ3qx0xdhhIYwi0i94CDP0HMRohUUP4KmBVKu5hh9DwycEuQ/7fsEMpnnOrj68WsYzWiHILkViaMUv0TKsP5/PYzEG5usoq2YmHGsyGeJ2PZj8HjqguTq1yxJAWRdlaCxpar9IZBislNYNjd9MK4LvZEUvHo0KXY36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634385; c=relaxed/simple;
	bh=dk7j7j6byNmV/UjZIYvTFa0ALohokNWDE6ElslvwqeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpSHZYYtkaVjB1tDBzoDHIX9rL00dtdrJ41NAbSBkrjwqW5vFnIspMhTFPl16kfPKrAeszfdYcmMx4vAoFeGHSUlB2rQKV0sFmWTj22XfWDlzjo9yJv8peat9dn1aDa55wLRjElsKcYDh3o14uI5G4hAcR2dzVf1wufybuwP6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGdJPyEq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso210932766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725634382; x=1726239182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSKiMfs9aMnFyQyhX6SOjUqLA0h3EptDIsaiVAy0A54=;
        b=SGdJPyEqJp9WpT3e9/CPt4PziPAl87dkNK7f9okkRET8kMfXbDykOB6MI61MXpgCN4
         ammxamHkKMm7wql/MbAnSM/tF7SaM1gyZguxr5HPBU5wk7sclsR1b+4NeXVdiRNUbUa2
         XxXKwOTwFhC4gB3F9ZMVJGWBNQm68edH456Z3/cYs0sSJC3b0NtkG0VybKDjrNTJ0ZnX
         +W92dKoHEiofX2QDArOm9VCZRd2ubqN4ME1JD1nknJz+4CRdL3r+U0eApbPd1CxbC7Cc
         53N6LxOotHySd7OTL3OZn34IB5S61mh0Cqq9yvxcIqZG6Tqdj3n9b8zKVTGyk8Y7duJA
         wgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634382; x=1726239182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSKiMfs9aMnFyQyhX6SOjUqLA0h3EptDIsaiVAy0A54=;
        b=t+0jDyIi40p1wenDNjTfv3TiKz7/aCOjSgmL9gifKbmZSW3hen4nWL6DB/8zEy/YBP
         OIJlA/1HwsniEpsWKFH+dBMem7dB2268kmjFGIgPHybLTp+mM3uUfgEFSUTSUJr4cAX1
         T+a9H0jDWSVYG1ZpVnBEwbcEF7R9b/6HOI2g4AzLLD7MUlmKScKrFklmH9MgMzgVCxfb
         bW+ZJDL+ASTZ2ZQo5lMRkQJl4JdJ7r4i57FdaaxSL7dmaMeOL+gFUqnAafGaH8skxz0H
         puJoaQci2Ojcc3uaColLEZzIUmn8gpa+c0yzkndemJkdu6/NMHCzEXs95/NxVyMQJOzg
         Z+bg==
X-Forwarded-Encrypted: i=1; AJvYcCXHqMHXx7J8iR0+1ZUNESzPcA563xx7lF5fFofLH7AZN/iiAEPY8cykoq/RqTL+/bW5ScabWK8zs+StMy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+/WXNgB8YHZVC0BzKCQ0oiDoUzZQWO+VqdzrqnKnnS6l+7Vq
	5XoWCWw7BalpiqRw4QGPDV3bi5zKDxSVhuwGwWygO3PYaZ8oTcarn3zb3ywqwbBWIRKXa49bPkb
	gGGtg9KSD4bpCBea4sVU1U8ZcwS0=
X-Google-Smtp-Source: AGHT+IGSCYvIyHPy2NOXwx9s40epCDFEmq4coQUJ8uqhiW8V76tMRHqZXafdgsFDVApYkHxpim7eOryrbHt2ZOBK7es=
X-Received: by 2002:a17:907:724a:b0:a88:a49a:59e2 with SMTP id
 a640c23a62f3a-a8a88841c57mr189074166b.44.1725634381271; Fri, 06 Sep 2024
 07:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD14+f2M+C_21h2bV6=GMhNwgWzLVaCL5jv1SQxsuKoveX6P_w@mail.gmail.com>
 <20240906105727.3666561-1-bo.wu@vivo.com>
In-Reply-To: <20240906105727.3666561-1-bo.wu@vivo.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Fri, 6 Sep 2024 23:52:49 +0900
Message-ID: <CAD14+f349Fsx9syBzEtgbOXEts0FRrHWU8vUgbpRO-SJ8DMmJw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 00/13] f2fs: introduce inline tail
To: Wu Bo <bo.wu@vivo.com>
Cc: Wu Bo <wubo.oduw@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wu,

On Fri, Sep 6, 2024 at 7:42=E2=80=AFPM Wu Bo <bo.wu@vivo.com> wrote:
>
> On Fri, Sep 06, 2024 at 06:02:42PM +0900, Juhyung Park wrote:
> > Hi Wu,
> >
> > Interesting patch-set.
> >
> > A quick test here on my daily-driver phone's data (785558 inodes) with
> > both compression and encryption disabled, copied via rsync to 2 fresh
> > f2fs partitions with and without inline tail:
> > Before: 170064928KiB
> > After: 169249780KiB
> >
> > So about 0.48% saved.
> >
> Hi Juhyung,
>
> Thanks for your test. If it's not too much trouble, please help check the=
 f2fs
> statistics:
> cat /sys/kernel/debug/f2fs/status | grep Utilization

# w/o inline tail
Utilization: 70% (42153224 valid blocks, 0 discard blocks)
# w/ inline tail
Utilization: 69% (41949437 valid blocks, 0 discard blocks)

>
> However, it=E2=80=99s more likely that the benefits of inline tail are in=
deed limited on
> mobile devices. I previously evaluated the gains on my own phone, and the=
y were
> less than 1% too.
>
> From the data on your phone, the average size is 170064928KiB/785558=E2=
=89=88200KiB.
> Storage space on phones is primarily consumed by multimedia files, so the
> proportion of files smaller than 64KB is quite small.
>
> Therefore, compared to phone storage, scenarios like storing Linux source=
 code,
> which involve many small files, are more likely to yield noticeable benef=
its.

Mmm.

I do have my own Linux setups using f2fs as well with extended node bitmap:
# Workstation, 2.5T/3.5T, 55602404 inodes
Utilization: 70% (657421720 valid blocks, 902 discard blocks)
# Laptop, 736G/1.9T, 12229380 inodes
Utilization: 39% (190980868 valid blocks, 2887 discard blocks)

I do have a lot of small files here, it'll be interesting to test this
out but I can't afford to run an unstable kernel for those atm. (Not
to mention finding a new SSD for migration.)

>
> However, don't be too disappointed with it, as it can still double the be=
nefits
> based on the existing gains from inline data.
> Inline data:
> https://lore.kernel.org/linux-f2fs-devel/1384096401-25169-1-git-send-emai=
l-huajun.li.lee@gmail.com/T/#u
>
> Thanks,
> Wu Bo
>
> > Let me know if this is an unexpected result.
> >
> > Thanks,
> >
> > On Tue, Sep 3, 2024 at 5:42=E2=80=AFPM Wu Bo via Linux-f2fs-devel
> > <linux-f2fs-devel@lists.sourceforge.net> wrote:
> > >
> > > The inode in F2FS occupies an entire 4k block. For many small files, =
this means
> > > they consume much more space than their actual size. Therefore, there=
 is
> > > significant potential to better utilize the inode block space.
> > >
> > > Currently, F2FS has two features to make use of the inode block space=
: inline
> > > data and inline xattr.
> > >
> > > Inline data stores file which size is smaller then 3.5k in inode bloc=
k. However,
> > > for slightly larger small files, there still have much waste.
> > > For example, a 5k file requires 3 blocks, totaling 12k of space, whic=
h is
> > > more than twice the size of the file itself!
> > >
> > > Additionally, the end of a file often does not occupy an entire block=
. If we can
> > > store the end of the file data within the inode block, we can save an=
 entire
> > > block for the file. This is particularly important for small files.
> > >
> > > In fact, the current inline data is a special case of inline tail, an=
d
> > > inline tail is an extension of inline data.
> > >
> > > To make it simple, inline tail only on small files(<64k). And for lar=
ger files,
> > > inline tails don't provide any significant benefits.
> > >
> > > The layout of an inline tail inode block is following:
> > >
> > > | inode block     | 4096 |     inline tail enable    |
> > > | --------------- | ---- | --------------------------|
> > > | inode info      | 360  |                           |
> > > | --------------- | ---- | --------------------------|
> > > |                 |      | extra info         | 0~36 |
> > > |                 |      | **compact_addr[16] | 64   |
> > > | addr table[923] | 3692 | reserved           | 4    |
> > > |                 |      | **tail data        |      |
> > > |                 |      | inline_xattr       | 200  |
> > > | --------------- | ---- | --------------------------|
> > > | nid table[5]    | 20   |
> > > | node footer     | 24   |
> > >
> > > F2fs-tools to support inline tail:
> > > https://lore.kernel.org/linux-f2fs-devel/20240903075931.3339584-1-bo.=
wu@vivo.com
> > >
> > > I tested inline tail by copying the source code of Linux 6.9.7. The s=
torage
> > > space was reduced by approximately 8%. Additionally, due to the reduc=
ed IO, the
> > > copy time also reduced by around 10%.
> > >
> > > This patch series has been tested with xfstests by running 'kvm-xfste=
sts -c f2fs
> > > -g quick' both with and without the patch; no regressions were observ=
ed.
> > > The test result is:
> > > f2fs/default: 583 tests, 6 failures, 213 skipped, 650 seconds
> > >   Failures: generic/050 generic/064 generic/250 generic/252 generic/5=
63
> > >       generic/735
> > >       Totals: 607 tests, 213 skipped, 30 failures, 0 errors, 579s
> > >
> > > Wu Bo (13):
> > >   f2fs: add inline tail mount option
> > >   f2fs: add inline tail disk layout definition
> > >   f2fs: implement inline tail write & truncate
> > >   f2fs: implement inline tail read & fiemap
> > >   f2fs: set inline tail flag when create inode
> > >   f2fs: fix address info has been truncated
> > >   f2fs: support seek for inline tail
> > >   f2fs: convert inline tail when inode expand
> > >   f2fs: fix data loss during inline tail writing
> > >   f2fs: avoid inlining quota files
> > >   f2fs: fix inline tail data lost
> > >   f2fs: convert inline tails to avoid potential issues
> > >   f2fs: implement inline tail forward recovery
> > >
> > >  fs/f2fs/data.c     |  93 +++++++++++++++++++++++++-
> > >  fs/f2fs/f2fs.h     |  46 ++++++++++++-
> > >  fs/f2fs/file.c     |  85 +++++++++++++++++++++++-
> > >  fs/f2fs/inline.c   | 159 +++++++++++++++++++++++++++++++++++++++----=
--
> > >  fs/f2fs/inode.c    |   6 ++
> > >  fs/f2fs/namei.c    |   3 +
> > >  fs/f2fs/node.c     |   6 +-
> > >  fs/f2fs/recovery.c |   9 ++-
> > >  fs/f2fs/super.c    |  25 +++++++
> > >  fs/f2fs/verity.c   |   4 ++
> > >  10 files changed, 409 insertions(+), 27 deletions(-)
> > >
> > > --
> > > 2.35.3
> > >
> > >
> > >
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

