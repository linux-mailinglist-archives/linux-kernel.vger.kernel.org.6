Return-Path: <linux-kernel+bounces-340213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B2F986FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9DA1C20936
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8BC1A7254;
	Thu, 26 Sep 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Nck0ynkh"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EBE1A76C3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342626; cv=none; b=uxKdER8SI4W9EFVD4dG33klHnr2LAWou7267ViHLcnIjg7SG2Cz4BV95oa7pBDTP9Pzvfrb8XVgl+37Lz2WaNOYBRVAwk+UMm9f99HcCML54aeTscJJ+lBaYWJtV69OV+u1PQ0Pfuc+x42ypjqRkIl6S7QpehcRTqzZ/8m0iMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342626; c=relaxed/simple;
	bh=OGmxnpcDlZNA/AYOJ/6ULikhRdvi0qFPDR/9HM1/x2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5dekzHAnCKBM2FOqWDEcJzyLen3VgGcScyeaVIRhWDE5+RBlmjPazF/EZ6VtWjzZOiPuJkE0HUohZ/tAkcioKOl/5iWN3nsGgL+rMskDRCQEIg8wpa511heGi5+jR2BqIB4BfYMKMbP+51E4/hjjYKrhwVsUmCK3f/6b7aRC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Nck0ynkh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 936993F169
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727342620;
	bh=VuvXYjjw3CXYdbw9a5WIM2wjLWJmbAUDB5oW3X71uKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Nck0ynkh4DveMSRn1dszXyqbz7J7dusdbHh4MPpSzsg3osexgqcO4j4EYnoBKWy1M
	 Lreh2W+QTRu/e5dbpbXy1OLZ9+HUXzjV1MVSSYscsbNqkq+BqLuHTH8P5T/fDJrGZv
	 +Ws0l8PRz+9AvSuN/TIVzTqgZvbPVqjrUb5ia2ie2l/TfBv2DGXSm897KShyTOzqeB
	 tJTsMDiIIaMJVwbPxDMg+lUakEGNJoFO0VyvPfv6G2renZ42RxT+n/Z8Y86OQV1ov6
	 J07vCvwU9yR+VEXTZR8rm7gtoIEQCcZjFsdXZbMUXW8NAx+BnPS1NFrzdL6FZlrWz+
	 4LNoY8VY/nQlQ==
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-502ca9abb6bso238391e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342616; x=1727947416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuvXYjjw3CXYdbw9a5WIM2wjLWJmbAUDB5oW3X71uKI=;
        b=fnj2CgvZ5JNNaSm+4v/drYpiN9DDe89pTEBy4W+6AorfhQv/UR44rF3rE/9cdcV/op
         J/c4w6KER7K1ucrk79mXI0DLq8tiXgvhhaOHdJmiGZE0li2+0YVfZMU91FK4qWYdEacC
         nEjuoUIf65bD5DGz+mgqyPuWGwBYy4RFwiFJxIBA1jk+jCMuX2u4BlELQ3xpeZ/E4j7p
         GQNvnMsEcx3lfUh9QfMnzuThrpva/I4hE/HFceSQiNOaTlJYQFp96+oVfofO3kLjV1Nx
         HO6izSWtqS0f6LkIG9DrkOPjMQ26A8l7520BOLpX6LeCJirR6PI8e83CICmV2IsuREiv
         hbtA==
X-Forwarded-Encrypted: i=1; AJvYcCW69qSzjjaEF6p7W1Fz75isX5YIaOBNVnlnqBWZVJkHXef7NxW5t4wJCpCXzpElnEDVGy1xFTCEOnykozU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9DylpVY4NaiLb/UBxchGHhCpMjGq5GpAn2bVxBEFgNjgGBHV
	WoOi36loL0VD+23J4TEGGMTuwjyAlOuuHoltQXbLHnOHvzZEs0mU9583ECjrTyzcs7T1krSFMPP
	DJh3I/ZX8qc/v7J2+/kNvF+UzeYVUuKd5G3hynULyWYRs8Ul9VgUxmdRW2NfHEPHB5NV+vzV0XX
	csFvYyctZBmT2WG6oATI0EuFze/TxLhqanG76fA/mm6GkO1LyB5H0c
X-Received: by 2002:a05:6122:2001:b0:4ed:145:348f with SMTP id 71dfb90a1353d-505c20c9250mr4629399e0c.12.1727342615572;
        Thu, 26 Sep 2024 02:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5CdqjXmLGTfMBbg30OzbC8qJPvljC2kVMj5wKnnDPZibQ6RE8OS5y2l4s17+ZabfNSzJgl1eo11+fDbgIx2M=
X-Received: by 2002:a05:6122:2001:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-505c20c9250mr4629390e0c.12.1727342615085; Thu, 26 Sep 2024
 02:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3> <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
 <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com>
In-Reply-To: <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 11:23:24 +0200
Message-ID: <CAEivzxdnAt3WbVmMLpb+HCBSrwkX6vesMvK3onc+Zc9wzv1EtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:50=E2=80=AFAM Baokun Li <libaokun1@huawei.com> w=
rote:
>
> On 2024/9/26 0:17, Aleksandr Mikhalitsyn wrote:
> > On Wed, Sep 25, 2024 at 5:57=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
> >>> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-=
b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
> >>> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 78643=
2 blocks
> >>> [   33.888740] ------------[ cut here ]------------
> >>> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
> >> Ah, I was staring at this for a while before I understood what's going=
 on
> >> (it would be great to explain this in the changelog BTW).  As far as I
> >> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory alloc=
ation
> >> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
> >> flexbg_size (for example when ogroup =3D flexbg_size, ngroup =3D 2*fle=
xbg_size
> >> - 1) which then confuses things. I think that was not really intended =
and
> > Hi Jan,
> >
> > First of all, thanks for your reaction/review on this one ;-)
> >
> > You are absolutely right, have just checked with our reproducer and
> > this modification:
> >
> > diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> > index e04eb08b9060..530a918f0cab 100644
> > --- a/fs/ext4/resize.c
> > +++ b/fs/ext4/resize.c
> > @@ -258,6 +258,8 @@ static struct ext4_new_flex_group_data
> > *alloc_flex_gd(unsigned int flexbg_size,
> >                  flex_gd->resize_bg =3D 1 << max(fls(last_group - o_gro=
up + 1),
> >                                                fls(n_group - last_group=
));
> >
> > +       BUG_ON(flex_gd->resize_bg > flexbg_size);
> > +
> >          flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
> >                                          sizeof(struct ext4_new_group_d=
ata),
> >                                          GFP_NOFS);
> >
> > and yes, it crashes on this BUG_ON. So it looks like instead of making
> > flex_gd->resize_bg to be smaller
> > than flexbg_size in most cases we can actually have an opposite effect
> > here. I guess we really need to fix alloc_flex_gd() too.
> >
> >> instead of fixing up ext4_alloc_group_tables() we should really change
> >> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exc=
eeds
> >> flexbg size. Baokun?
> > At the same time, if I understand the code right, as we can have
> > flex_gd->resize_bg !=3D flexbg_size after
> > 5d1935ac02ca5a ("ext4: avoid online resizing failures due to oversized
> > flex bg") and
> > 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex=
_gd()")
> > we should always refer to flex_gd->resize_bg value which means that
> > ext4_alloc_group_tables() fix is needed too.
> > Am I correct in my understanding?
>
> Hi Alex,

Hi Baokun,

>
> These two are not exactly equivalent.
>
> The flex_gd->resize_bg is only used to determine how many block groups we
> allocate memory to, i.e., the maximum number of block groups per resize.
> And the flexbg_size is used to make some judgement on flexible block
> groups, for example, the BUG_ON triggered in the issue is to make sure
> src_group and last_group must be in the same flexible block group.

Huge thanks for explaining this!

Then I guess it's better if you send a patch with your fix.
Feel free to add my Tested-by tag.

Question to you and Jan. Do you guys think that it makes sense to try
to create a minimal reproducer for this problem without Incus/LXD involved?
(only e2fsprogs, lvm tools, etc)

I guess this test can be put in the xfstests test suite, right?

Kind regards,
Alex

>
>
> Regards,
> Baokun
>

