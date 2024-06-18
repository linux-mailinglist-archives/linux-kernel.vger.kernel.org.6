Return-Path: <linux-kernel+bounces-218648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B0A90C325
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1001F21608
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A40182DF;
	Tue, 18 Jun 2024 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NraGMnF/"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E123BE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688945; cv=none; b=tFtEn2IN367liJRpw+prvkSdIDEHU2yMz08N/q5/JZvou23etEQj5IZV8+pYcxSszaQlWiAefcd/MHMAVFqFKgidT3wmf8RVvUffRPjsiEDCJiZ1vrId4ciq9O5oCnjivXkXrXRrHXGtU9n+6OI7N/BhtTOBJ23Lr1euNzcPjKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688945; c=relaxed/simple;
	bh=aLK6p+HjDUBoHdzPXRZEQsdznmBEfMeazaNMkiu6SsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQSgtty2EPwxTn6Qg4IG0FWqw2jO6c7so0A1twbmJ8tEih0UM4V7kfVosKRWs4qXpuZ7saddDL4eZg2G2l8LSNnJiYDLbGB+OFsR4czkuD5g4RDE6snc+/2aIoCQQFsdXCZyJV3sIgTTppC9Eg8trbLKbTpWCb8fxfJXCjqeRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NraGMnF/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff2df7de4aso2445340276.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718688943; x=1719293743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kupaMZjwHwGPpq8vmv6XFER+3ZzlHwvmLFCBqj1l2ZM=;
        b=NraGMnF/LjTVMS/dOroPH15X0BlhJxSKq2NCyMYP33IfeBsQDL+89CRsk9h2D0KRJV
         OF3a+n+/DhsBB2cTXGl5Gioy3jQW8PETmUp03+hKtDrQVh6izt98xyCkT0MBcNR3cXWj
         zp9RT9IzwTOF/SHSW/yd1UnoyOqM8PLy/+8mkhKEGgwygVnRfuWvR/0ikUkzENCH1x7X
         Uzp38mUFcSQ4EKxqt+mDw5Jik3H49TQvE27cgXnOGJh4vVTkw1fEzTZJIGf3AC1il8Te
         hv9d+Ku1wjpgF9Pz7ku0rf1z72ToRnRT+kqkNTXYzBhqJyOYv74Rz0hSIXsgFq0aq4jv
         2G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718688943; x=1719293743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kupaMZjwHwGPpq8vmv6XFER+3ZzlHwvmLFCBqj1l2ZM=;
        b=Sul1Kyl736yzm5gqEyYELoH6phwxIoMwFxq8s7OY5wB+GBOPtOj5yuex+riZfS30dc
         GTDV+sZfOtv29zFt3DEyzEVJCs087/3kbrWwphrlcAd8C9h8hFctofGD1Fu1xCvM7eb5
         5umf2Y9RfLgqal9z8kjahmAh+zLdO35Drlf/HSmkLsfbnvLRavKZgNi7TqsoCDxOACSf
         JXZ15RpFFaw4CjKenM/CtRFB9ui69HMc2BMUSzGmteRtQvyGTypfJriwSKAtOwIolGaU
         28dk7z7lK0akJWFUFmdwBhemJePPMNwqxqKP+tWUh/LxqGZy3kpbnBAotrQ7pZjf4WRi
         vw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUocd+sqOktHJUt9E4Wa37uD2sQUi2QZaP3+1RFpSieOIGa2rY8OW2eXLsKQo5/d+lhM9l1b/ZZ1KDsT6DEXMzG/Y5qIU4QmvHbxqwB
X-Gm-Message-State: AOJu0YyA2pl0Svad2KaQGov7q2Rdx5/6uHAtv49JKec6EzSveIvppvkN
	0acxR6wdfOuQv9LKv344lRLMc0G1Yff4tBxLXO9VQVwE68uXNUz7JufoIRkTkb2LdoshlhweiyU
	MlxitYNkCtOylg0VMEQkoHRNhEGk=
X-Google-Smtp-Source: AGHT+IGR2+/+J1O38YjXz0DDYDuNS80270P0x3dah6/HlKP2GDmZ2LbAoCJK7EF62lLQEFx8CVZaOixf8b3pphDxiQU=
X-Received: by 2002:a25:ce8c:0:b0:e02:b548:1f06 with SMTP id
 3f1490d57ef6-e02b54820a4mr255339276.22.1718688942645; Mon, 17 Jun 2024
 22:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617071114.150721-1-xiuhong.wang@unisoc.com> <04825e07-04d4-4eef-8b06-1e2329880612@kernel.org>
In-Reply-To: <04825e07-04d4-4eef-8b06-1e2329880612@kernel.org>
From: Xiuhong Wang <xiuhong.wang.cn@gmail.com>
Date: Tue, 18 Jun 2024 13:35:31 +0800
Message-ID: <CAOsHCa0bUg3Kam_4G=aiWzQpisn7rAS3nQWMQEPWB04==Sftbw@mail.gmail.com>
Subject: Re: [PATCH] f2fs-tools: fix do_set_verity ioctl fail issue
To: Chao Yu <chao@kernel.org>
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, ke.wang@unisoc.com, hao_hao.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8818=E6=97=A5=E5=91=
=A8=E4=BA=8C 11:04=E5=86=99=E9=81=93=EF=BC=9A

>
> On 2024/6/17 15:11, Xiuhong Wang wrote:
> > When using the f2fs_io tool to set_verity, it will fail as follows:
> > unisc:/data # ./f2fs_io set_verity file
> > FS_IOC_ENABLE_VERITY: Inappropriate ioctl for device
> > this is because commit: 95ae251fe828 ("f2fs: add fs-verity support"),
> > the passed parameters do not match the latest kernel version.
> >
> > After patch:
> > unisoc:/data # ./f2fs_io set_verity file
> > Set fsverity bit to file
> > unisoc:/data # ./f2fs_io getflags file
> > get a flag on file ret=3D0, flags=3Dverity
> >
> > Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
> > Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   include/android_config.h |  1 +
> >   tools/f2fs_io/f2fs_io.c  |  9 ++++++---
> >   tools/f2fs_io/f2fs_io.h  | 20 ++++++++++++++++++--
> >   3 files changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/android_config.h b/include/android_config.h
> > index 05b686e..9c8b163 100644
> > --- a/include/android_config.h
> > +++ b/include/android_config.h
> > @@ -13,6 +13,7 @@
> >   #define HAVE_LINUX_XATTR_H 1
> >   #define HAVE_LINUX_FS_H 1
> >   #define HAVE_LINUX_FIEMAP_H 1
> > +#define HAVE_LINUX_VERITY_H 1
> >   #define HAVE_MNTENT_H 1
> >   #define HAVE_STDLIB_H 1
> >   #define HAVE_STRING_H 1
> > diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> > index a7b593a..2447490 100644
> > --- a/tools/f2fs_io/f2fs_io.c
> > +++ b/tools/f2fs_io/f2fs_io.c
> > @@ -182,16 +182,19 @@ static void do_fsync(int argc, char **argv, const=
 struct cmd_desc *cmd)
> >   static void do_set_verity(int argc, char **argv, const struct cmd_des=
c *cmd)
> >   {
> >       int ret, fd;
> > +     struct fsverity_enable_arg args =3D {.version =3D 1};
> > +
> > +     args.hash_algorithm =3D FS_VERITY_HASH_ALG_SHA256;
> > +     args.block_size =3D 4096;
> >
> >       if (argc !=3D 2) {
> >               fputs("Excess arguments\n\n", stderr);
> >               fputs(cmd->cmd_help, stderr);
> >               exit(1);
> >       }
> > +     fd =3D open(argv[1], O_RDONLY);
> >
> > -     fd =3D open(argv[1], O_RDWR);
>
> It needs write permission?
>
> Thanks,
>
If you open the file with O_RDWR, the following error will be returned:
unisoc:/data # ./f2fs_io set_verity file
FS_IOC_ENABLE_VERITY: Text file busy

/Documentation/filesystems/fsverity.rst has the following description:
FS_IOC_ENABLE_VERITY checks for write access to the inode. However, it
must be executed on an O_RDONLY file descriptor and no processes can
have the file open for writing. Attempts to open the file for writing
while this ioctl is executing will fail with ETXTBSY. (This is
necessary to guarantee that no writable file descriptors will exist
after verity is enabled, and to guarantee that the file's contents are
stable while the Merkle tree is being built over it.)

> > -
> > -     ret =3D ioctl(fd, FS_IOC_ENABLE_VERITY);
> > +     ret =3D ioctl(fd, FS_IOC_ENABLE_VERITY, &args);
> >       if (ret < 0) {
> >               perror("FS_IOC_ENABLE_VERITY");
> >               exit(1);
> > diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
> > index b5c82f5..e55db5f 100644
> > --- a/tools/f2fs_io/f2fs_io.h
> > +++ b/tools/f2fs_io/f2fs_io.h
> > @@ -16,6 +16,9 @@
> >   #ifdef HAVE_LINUX_FS_H
> >   #include <linux/fs.h>
> >   #endif
> > +#ifdef HAVE_LINUX_VERITY_H
> > +#include <linux/fsverity.h>
> > +#endif
> >
> >   #include <sys/types.h>
> >
> > @@ -136,8 +139,21 @@ struct fscrypt_get_policy_ex_arg {
> >   #define F2FS_IOC_GET_ENCRYPTION_POLICY      FS_IOC_GET_ENCRYPTION_POL=
ICY
> >   #define F2FS_IOC_GET_ENCRYPTION_PWSALT      FS_IOC_GET_ENCRYPTION_PWS=
ALT
> >
> > -#define FS_IOC_ENABLE_VERITY         _IO('f', 133)
> > -
> > +#ifndef FS_IOC_ENABLE_VERITY
> > +#define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_=
arg)
> > +#define FS_VERITY_HASH_ALG_SHA256       1
> > +struct fsverity_enable_arg {
> > +     __u32 version;
> > +     __u32 hash_algorithm;
> > +     __u32 block_size;
> > +     __u32 salt_size;
> > +     __u64 salt_ptr;
> > +     __u32 sig_size;
> > +     __u32 __reserved1;
> > +     __u64 sig_ptr;
> > +     __u64 __reserved2[11];
> > +};
> > +#endif
> >   /*
> >    * Inode flags
> >    */

