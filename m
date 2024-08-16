Return-Path: <linux-kernel+bounces-289328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6E9544ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208182848A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C613CFA6;
	Fri, 16 Aug 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aLay6emV"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0A12E1E9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798719; cv=none; b=cSvgSc3MlbAF6Lr4Wv5ojIPYlRfEJdfo44hU2zIS4j8724T4srRQZpBo+OOjLarKV2GwiZ5b3irDeIxHJrfGCYt/9mp8MXn2gELKi9DmfKIrLN3HisOVnasyX+CkF5VtgchjAXglCbw0QsV4C1M1TvUjbfC2EphXKlcl69ECp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798719; c=relaxed/simple;
	bh=FzefXXQGvADrPX65XM5Hb5IRP3b/EgwpELN18Ulxmwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtFiixDHz1Zw9/HmzN33B45le6s0pgWg4awcCmF2kTCcmfCi4+b2yVfCJbs9KPQGV74mSrQpcLQfTH3+n6Bg8Kl9PM9nVKFiMRt95vyzzrAb6tUpx40VFH63m+nvQPIsTKOqxDrVplI4KdYwsgDL0FJ92BYzuaS2BjiukxjgA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aLay6emV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 47C723FB60
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723798714;
	bh=yqmTRLvnibvEjRY5HqDeK9lvfyHgdzJpnHG6YayP6Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=aLay6emVLj8qyFVsO7aawsTeu6G9QUICztqP0eJBZQp2tur8Mun+0uHJh9WuNtbv6
	 fKM33aQszMEPCkSYnp0/gYyOho9dgAK4XzufwY3e/V0rqVtekuULZiO5S7u05bMMYr
	 SIDOjLEa2y6Hq5dLMKjclwPFgdd/GFuBXMjvvPkkdJBnSB5DRzsjcIaE9Gvv+rRyS2
	 Yuidy7BKwzpvsvntysKn4O1DLuJIlnNjazZ+0n2cNHMCyoutfsZv0Vu90b59YcSR4q
	 Vyeh4e2keA6mPrNctaYDz3/QkqrfgfTdO+WTNaD3ZAA3PLEeopkYOC/Wzu7J8wXils
	 /h4zhfmMrWLUA==
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-842ef8c3d4fso288385241.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798713; x=1724403513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqmTRLvnibvEjRY5HqDeK9lvfyHgdzJpnHG6YayP6Ho=;
        b=huyGylcaCrx31q+8AEoiAB0blji/3TERHOSgLVH0AriV7slmS49desKeAJola9t9Kz
         q1ATbz9IjA2Q+msrBJlqGTFptF7n8/aIk9Nc1F/wY2vKMQAjIihI8VwGDbg9+tUVeGF7
         soen1zWtVrnER5rTFDqeYNp1dHd6qL7COx41fs41cAufTIJyrD25om9eZkdytdLsuqE2
         R2HyPv6AwNxU804jvXpS//m5hQsiaGj20Gg4KlWsvUQ7FvHzoyaOuO2EEw4gRi7wRhAk
         qKLsGk96s8tpiM9b6hbKo1CxV9aV63n+gzBWXJdmtFyg4G4L+/S2XIniAYCFnZkWzjo5
         G8zA==
X-Forwarded-Encrypted: i=1; AJvYcCWuFepp1f8IAWiZ5OGZPfzZWnxqrU05LyJUK2f9ndKWT9qM7QQVdzav48+biUqCM6XKPBBpsKz0jWV344Trx/kiCe7WEyI2/bjTbpa0
X-Gm-Message-State: AOJu0Ywkot/aHpllDy57TVjQrSLzJH4C598MZm9XvKGKuaqZ+BHvU+IB
	f0p4tza9viWcfAM0moHGj8zUZPue479ngUMxTP2jSnZ42rQ7mou0iiBlT/zM0A6fe7yjF0+cJxj
	xSLHx6EbXWTbaZoFsfehWTRpbkJPn3f7wop2nDoYsS6lb41B9C4rT3OPZzaipoQFe98gK/p9ufR
	Mv0+a0cJPPv6CFYQXAgJxofA/l7wqyWAVbB3rkGHoHy0YPvNgcoI7z
X-Received: by 2002:a05:6102:304e:b0:493:b719:efaf with SMTP id ada2fe7eead31-497799b587emr2756138137.20.1723798713074;
        Fri, 16 Aug 2024 01:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhm27UN+fvyUuV5qkttHqILelIWDdRu2C3dzSzTnUDhviB8NPlkf46skhX5kIE0oEuyi6tM3DeJDok5XJti8c=
X-Received: by 2002:a05:6102:304e:b0:493:b719:efaf with SMTP id
 ada2fe7eead31-497799b587emr2756127137.20.1723798712758; Fri, 16 Aug 2024
 01:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com> <20240815-ehemaligen-duftstoffe-a5f2ab60ddc9@brauner>
In-Reply-To: <20240815-ehemaligen-duftstoffe-a5f2ab60ddc9@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 16 Aug 2024 10:58:21 +0200
Message-ID: <CAEivzxf2qH8XBXA2a+U4bQeeVC+eB8m9tDC08jxT=trFEzLpTA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] fuse: basic support for idmapped mounts
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Aug 15, 2024 at 11:24:17AM GMT, Alexander Mikhalitsyn wrote:
> > Dear friends,
> >
> > This patch series aimed to provide support for idmapped mounts
> > for fuse & virtiofs. We already have idmapped mounts support for almost=
 all
> > widely-used filesystems:
> > * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS=
 (out-of-tree))
> > * network (ceph)
> >
> > Git tree (based on torvalds/master):
> > v3: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v3
> > current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mount=
s
> >
> > Changelog for version 3:
> > - introduce and use a new SB_I_NOIDMAP flag (suggested by Christian)
> > - add support for virtiofs (+user space virtiofsd conversion)
> >
> > Changelog for version 2:
> > - removed "fs/namespace: introduce fs_type->allow_idmap hook" and simpl=
ified logic
> > to return -EIO if a fuse daemon does not support idmapped mounts (sugge=
sted
> > by Christian Brauner)
> > - passed an "idmap" in more cases even when it's not necessary to simpl=
ify things (suggested
> > by Christian Brauner)
> > - take ->rename() RENAME_WHITEOUT into account and forbid it for idmapp=
ed mount case
> >
> > Links to previous versions:
> > v2: https://lore.kernel.org/linux-fsdevel/20240814114034.113953-1-aleks=
andr.mikhalitsyn@canonical.com
> > tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v=
2
> > v1: https://lore.kernel.org/all/20240108120824.122178-1-aleksandr.mikha=
litsyn@canonical.com/#r
> > tree: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v=
1
> >
> > Having fuse (+virtiofs) supported looks like a good next step. At the s=
ame time
> > fuse conceptually close to the network filesystems and supporting it is
> > a quite challenging task.
> >
> > Let me briefly explain what was done in this series and which obstacles=
 we have.
> >
> > With this series, you can use idmapped mounts with fuse if the followin=
g
> > conditions are met:
> > 1. The filesystem daemon declares idmap support (new FUSE_INIT response=
 feature
> > flags FUSE_OWNER_UID_GID_EXT and FUSE_ALLOW_IDMAP)
> > 2. The filesystem superblock was mounted with the "default_permissions"=
 parameter
> > 3. The filesystem fuse daemon does not perform any UID/GID-based checks=
 internally
> > and fully trusts the kernel to do that (yes, it's almost the same as 2.=
)
> >
> > I have prepared a bunch of real-world examples of the user space modifi=
cations
> > that can be done to use this extension:
> > - libfuse support
> > https://github.com/mihalicyn/libfuse/commits/idmap_support
> > - fuse-overlayfs support:
> > https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support
> > - cephfs-fuse conversion example
> > https://github.com/mihalicyn/ceph/commits/fuse_idmap
> > - glusterfs conversion example (there is a conceptual issue)
> > https://github.com/mihalicyn/glusterfs/commits/fuse_idmap
> > - virtiofsd conversion example
> > https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245
>
> So I have no further comments on this and from my perspective this is:
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks, Christian! ;-)

>
> I would really like to see tests for this feature as this is available
> to unprivileged users.

Sure. I can confirm that this thing passes xfstests for virtiofs.

My setup:

- host machine

Virtiofsd options:

[ virtiofsd sources from
https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245 ]
./target/debug/virtiofsd --socket-path=3D/tmp/vfsd.sock --shared-dir
/home/alex/Documents/dev/tmp --announce-submounts
--inode-file-handles=3Dmandatory --posix-acl

QEMU options:
        -object memory-backend-memfd,id=3Dmem,size=3D$RAM,share=3Don \
        -numa node,memdev=3Dmem \
        -chardev socket,id=3Dchar0,path=3D/tmp/vfsd.sock \
        -device vhost-user-fs-pci,queue-size=3D1024,chardev=3Dchar0,tag=3Dm=
yfs \

- guest

xfstests version:

root@ubuntu:/home/ubuntu/xfstests-dev# git log | head -n 3
commit f5ada754d5838d29fd270257003d0d123a9d1cd2
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Fri Jul 26 09:51:07 2024 -0700

root@ubuntu:/home/ubuntu/xfstests-dev# cat local.config
export TEST_DEV=3Dmyfs
export TEST_DIR=3D/mnt/test
export FSTYP=3Dvirtiofs

root@ubuntu:/home/ubuntu/xfstests-dev# ./check -g idmapped
FSTYP         -- virtiofs
PLATFORM      -- Linux/x86_64 ubuntu 6.11.0-rc3+ #2 SMP
PREEMPT_DYNAMIC Fri Aug 16 10:23:41 CEST 2024

generic/633 1s ...  0s
generic/644 0s ...  1s
generic/645 18s ...  18s
generic/656       [not run] fsgqa user not defined.
generic/689       [not run] fsgqa user not defined.
generic/696       [not run] this test requires a valid $SCRATCH_DEV
generic/697 0s ...  1s
generic/698       [not run] this test requires a valid $SCRATCH_DEV
generic/699       [not run] this test requires a valid $SCRATCH_DEV
Ran: generic/633 generic/644 generic/645 generic/656 generic/689
generic/696 generic/697 generic/698 generic/699
Not run: generic/656 generic/689 generic/696 generic/698 generic/699
Passed all 9 tests

I'll try to do more tests, for example with fuse-overlayfs and get
back with results.

Kind regards,
Alex

