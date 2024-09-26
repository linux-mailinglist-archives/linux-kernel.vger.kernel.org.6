Return-Path: <linux-kernel+bounces-340566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E0B987555
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C9A1C25221
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8F214A4DF;
	Thu, 26 Sep 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OsfvrV+R"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5540C15
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360407; cv=none; b=UisK7jzR9fxYeiLQGNsEJvcWj0/E3ZKPD+DvUzm15FRHG0TpcxgHl11a/Cy9uHwCJdAV2JNoG6ftwivRRhAKu9RVPp7uSAdxNNQuBdaVL3VwT17g0Bpj+kjtKcvHX1jCpyjX3BsRsBhs6aJm3fj838LF08n/8+JJMaEHyJu0jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360407; c=relaxed/simple;
	bh=fsBejCLuikqVjJuRyFztdr0Xv2VonpPl0X1UtIzWwQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu4457LA/We/oVi3ceN2YQvzczc/bMOFO3voBJygCSmDDfQNyVXdMD+M2mGX3TtpFYFW9O5xGj4vcIKlj/nxz3vH73KY1np1KWDIaG8DKRqlLBJN/X0ZMF+RzIoi735fEgYAGqrJUN9thoI6g2Qcyfmu+MMigJmCTMAk443FFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OsfvrV+R; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A7A834064A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727360398;
	bh=fL59POmvaFxcf8qmycNokQKGCX9wZGI3HSvbyTNhbxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=OsfvrV+RRu2Qy3dDnveMQlOfUv2oD20urqJWop4eAhXOMp2Znpt+YEjaTPDwBi8r7
	 hd35PYkXgXBwGO6Wfp28Cj75zA2+ctfNwhXoOVvIyOOIAgmgiMV3D7i38SUQ3ipzTp
	 3T7zNXHCvlJ6GQoatfxILCWivWIcaJh8EFvCbnZ4EtzKnPGbQ0ee7L4eTx+rEOu4u4
	 KYMm7frJv7g05+gvEHpdCB3wR0a5AG8JX+DaM85Ux3fRD84fFF8daWaymERyR3CI6D
	 UF+/mbNn/ZBE08Jeg6HfMVJoG7JbJH4HEf661X8Ri58sQ5cnbdvrB/hdzmyrFlnS4X
	 RfpCXlMKOoatQ==
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-502e7eb4e66so236320e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360391; x=1727965191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL59POmvaFxcf8qmycNokQKGCX9wZGI3HSvbyTNhbxk=;
        b=Jd8adoUdjKkQ52/72z8xd7YSJ8MsWW1EOxTsOdPVZl8bbpAFeXNFJzvwTAYgPPwWGD
         IjRtCYnWqqboY+ywz6kX29hnY/wFUKpuWOC8gQIRbH6nc/JY9/7+1t4NTzplCyULN9J7
         vU6oh4Opfwu3lr9CNjfTRLmGHQgxh7JkOw1Ytw5G/QlDN2mP6jcnlk8fhewV7ovA5tyB
         PNb6QHivgumPkCFMlsixDszWk0Di+Zr2e2q8kJaeile177bnnuIIr4c7VU8o73jyiH/L
         q0Xhv0dfsmHl/MM3U9Z73u+L2ThHGkqWMHolV0E2N1dge4r01mIeDkJSMsCemjqOnDIH
         8XoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+vkcOwZGIMbcErO3K3Nxip+ap8DTAmpUsr+X6i417P3f4JJCvOTiCywXQL22Qj5FkmFze8JzFw2anDiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8myGEFbUmmYvNFpPmO70As9UcTu+k3bIkQSDnto7DXPrROQj
	0CNzbfQJJqSJl5o15qkrtQWudbQe1D3wZUV5U7TlbmoaSm7xxwoy9r+SPEbAskZzDy4th7+UPRh
	rOFLQpZyERObszobSmu4Sy0rtD8/1Qhdac+YVq6vgdaPxSknQSasI+ixBn66S3HGL0pKNtE2wyW
	XYdglriZtRZz86GshlwTCGe0EIHwNxQGi9KVZnIfi2zuPqJ2+CE+L2
X-Received: by 2002:a05:6122:3d0b:b0:4ed:52b:dd29 with SMTP id 71dfb90a1353d-505c1d53c06mr5728821e0c.3.1727360390717;
        Thu, 26 Sep 2024 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVXaX4QPQm+moOngoVdPlVhd3WRkw/NbU43aKvdUv71fZhsvtLbbDFgTOG2KujfW9HaeMmgltFHBuD5DMLxWY=
X-Received: by 2002:a05:6122:3d0b:b0:4ed:52b:dd29 with SMTP id
 71dfb90a1353d-505c1d53c06mr5728792e0c.3.1727360390399; Thu, 26 Sep 2024
 07:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3> <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
 <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com> <CAEivzxdnAt3WbVmMLpb+HCBSrwkX6vesMvK3onc+Zc9wzv1EtA@mail.gmail.com>
 <4ce5c69c-fda7-4d5b-a09e-ea8bbca46a89@huawei.com> <CAEivzxekNfuGw_aK2yq91OpzJfhg_RDDWO2Onm6kZ-ioh3GaUg@mail.gmail.com>
 <941f8157-6515-40d3-98bd-ca1c659ef9e0@huawei.com>
In-Reply-To: <941f8157-6515-40d3-98bd-ca1c659ef9e0@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 16:19:39 +0200
Message-ID: <CAEivzxcR+yy1HcZSXmRKOuAuGDnwr=EK_G5mRgk4oNxEPMH_=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 3:58=E2=80=AFPM Baokun Li <libaokun1@huawei.com> wr=
ote:
>
> On 2024/9/26 19:32, Aleksandr Mikhalitsyn wrote:
> >>> Question to you and Jan. Do you guys think that it makes sense to try
> >>> to create a minimal reproducer for this problem without Incus/LXD inv=
olved?
> >>> (only e2fsprogs, lvm tools, etc)
> >>>
> >>> I guess this test can be put in the xfstests test suite, right?
> >>>
> >>> Kind regards,
> >>> Alex
> >> I think it makes sense, and it's good to have more use cases to look
> >> around some corners. If you have an idea, let it go.
> > Minimal reproducer:
> >
> > mkdir -p /tmp/ext4_crash/mnt
> > EXT4_CRASH_IMG=3D"/tmp/ext4_crash/disk.img"
> > rm -f $EXT4_CRASH_IMG
> > truncate $EXT4_CRASH_IMG --size 25MiB
> > EXT4_CRASH_DEV=3D$(losetup --find --nooverlap --direct-io=3Don --show
> > $EXT4_CRASH_IMG)
> > mkfs.ext4 -E nodiscard,lazy_itable_init=3D0,lazy_journal_init=3D0 $EXT4=
_CRASH_DEV
> > mount $EXT4_CRASH_DEV /tmp/ext4_crash/mnt
> > truncate $EXT4_CRASH_IMG --size 3GiB
> > losetup -c $EXT4_CRASH_DEV
> > resize2fs $EXT4_CRASH_DEV
> >
> Hi Alex,
>
> This replicator didn't replicate the issue in my VM, so I took a deeper
> look. The reproduction of the problem requires the following:

That's weird. Have just tried once again and it reproduces the issue:

root@ubuntu:/home/ubuntu# mkdir -p /tmp/ext4_crash/mnt
EXT4_CRASH_IMG=3D"/tmp/ext4_crash/disk.img"
rm -f $EXT4_CRASH_IMG
truncate $EXT4_CRASH_IMG --size 25MiB
EXT4_CRASH_DEV=3D$(losetup --find --nooverlap --direct-io=3Don --show
$EXT4_CRASH_IMG)
mkfs.ext4 -E nodiscard,lazy_itable_init=3D0,lazy_journal_init=3D0 $EXT4_CRA=
SH_DEV
mount $EXT4_CRASH_DEV /tmp/ext4_crash/mnt
truncate $EXT4_CRASH_IMG --size 3GiB
losetup -c $EXT4_CRASH_DEV
resize2fs $EXT4_CRASH_DEV
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 6400 4k blocks and 6400 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

resize2fs 1.47.0 (5-Feb-2023)
Filesystem at /dev/loop4 is mounted on /tmp/ext4_crash/mnt; on-line
resizing required
old_desc_blocks =3D 1, new_desc_blocks =3D 1
Segmentation fault

My kernel's commit hash is 684a64bf32b6e488004e0ad7f0d7e922798f65b6

Maybe it somehow depends on the resize2fs version?

Kind regards,
Alex

>
> o_group =3D flexbg_size * 2 * n;
> o_size =3D (o_group + 1) * group_size;
> n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
>
> Take n=3D1,flexbg_size=3D16 as an example:
>                                                   last:47
> |----------------|----------------|o---------------|--------------n-|
>                                    old:32 >>>           new:62
>
> Thus the replicator can be simplified as:
>
> img=3Dtest.img
> truncate -s 600M $img
> mkfs.ext4 -F $img -b 1024 -G 16 264M
> dev=3D`losetup -f --show $img`
> mkdir -p /tmp/test
> mount $dev /tmp/test
> resize2fs $dev 504M
>
>
> --
> Cheers,
> Baokun
>

