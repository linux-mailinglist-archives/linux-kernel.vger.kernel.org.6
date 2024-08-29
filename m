Return-Path: <linux-kernel+bounces-306830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8641964449
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5752866DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95146195FE5;
	Thu, 29 Aug 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Fp+90MHl"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751318D63A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934124; cv=none; b=ZLurQhf0KJir4yT31rLeiHGiZdXkdbZv8+4PVX0pbAIXbDRJUZFT2/m+k9AR88gAl+TJLPsRmsrhNCb/1PzzJW6eZqy7E2nvtcXCLjHon7/b2C+FB4L1SCnlESGpPtGClJRQlpb8E+EmrE8FDjIJXPrZbUsfBsFBKCDM1Hp4LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934124; c=relaxed/simple;
	bh=h7IDSYAQydykreAp3+pvcbQEF5019MRHNEBnjuv11fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RN1vHrhCW4ILt7FbuNjQ+KVn2/QKZSIenTzl+ve2zxZ0GTkk1qcvQThshPKOj9KbNd+IZjFQ5hLFPmGaAiEAH9+tMqbkUrMidsDTh9CyNF/n4+NuQ7kLeEYR/bZQ5rjWKiWDDr5u0UVIhESAmHEB55FvWuPjAKDLYIuPlSCGB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Fp+90MHl; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 523DF3F63C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724934121;
	bh=7qlMKnlG19yoapUMIHs1PTakDfSSoLT1Ahia2jJ2HUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Fp+90MHljlyrjse5qZxaaQvfTmmN7WprbDXYyUtLbaY7TTFTq8sE0WzHq04M7TvKH
	 PdkfWnN7TQSfB3kDzMYNF2i/l2dNYCW++JSR7/x7n/wW0JJX28Tq104S+s/Bx8NGld
	 TUSqOh7xaw8GhHUBQk9vXcR90SngOdU/514FIT2NMbw1MfHNredkNFt7NS9K0nZoTe
	 WUwXGiucyjAktyilo67whhVJEKKxJgtxKlC95PzVvBSvGwNx4rJ7Ky63Oc5f+f8ryJ
	 wAoLI+bvVV9hE0Zbmdf1kePAGc/9SS+JuB066lCkAmmtO2CV6P8Jtcn/WFaCSkf9dE
	 SSRFdFGjDPAOg==
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4fce6e3067bso272778e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934120; x=1725538920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qlMKnlG19yoapUMIHs1PTakDfSSoLT1Ahia2jJ2HUU=;
        b=RK5oeeYtBF5qEYds4rlZOM0tjqUuv6H8Ctl7db3+LwzngND2G6nykWlv5jDS2T+67t
         jaXSXdyO4mP5kf6QJeZTv2+Aad8uYR+lFHClzxWfu0qFlGo9jR4JpeleafEFXFdMm+Wh
         do8LA7YbZmaNpFHnjIDUTok+UqG0e9v7TDn67mgQov4DIKILer4rAAT8h/ylziLvXKB7
         AOTWJUxn+ypUC963eyBOv8EHWjFYXomVZqzKvmGHUsRI6cmo7F2C+04oxuXNTKqJEHkb
         kR6fQQ7xv+iTnO2saiIefxDQVN7flitbfBRs2s1LJgVjvM8nzqOn8c4pB1T1zOwkDuw2
         X6RA==
X-Forwarded-Encrypted: i=1; AJvYcCW4JVPyhzFQ3JZsfk4YW18+ZYfGzNp9nCoefGu/vqUyf7ZPY5kNG5WyG+gZNKQmN7IXJuaoRl2zmdoVDJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3w3s/tshvEK+XMKyAI2eOzcSz4GoOp7uATrp+mZgy2nPL/BMH
	YKF1ITWf0cktx6s2OKJe1eUm4mgSBjz+uvKEkN3e3TjBzkDRYE3MOqx39xjw49tsAssaO66NmXa
	U5GbiCXZNUQlVjloei5hKImi8PXa6paqMVUiFqZ2f0+2KXDmSmzoL280juKFlCG8uKqUZ1VpkQT
	PMAqPSJeAKmKSJrWsdhfgC4UrhlsuirEymm6KKdenkXa7K3vcQMrMe
X-Received: by 2002:a05:6102:942:b0:494:5b9d:529e with SMTP id ada2fe7eead31-49a5af76165mr3157206137.26.1724934120068;
        Thu, 29 Aug 2024 05:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6PMGmdgrxq/HwjXlsfmlr6/NtQqSnyVyF+AnqA/n4ibuUaSLZ6cLPzJWT+cYm7FXkrCaRFiSeKqKlaRrHODQ=
X-Received: by 2002:a05:6102:942:b0:494:5b9d:529e with SMTP id
 ada2fe7eead31-49a5af76165mr3157182137.26.1724934119701; Thu, 29 Aug 2024
 05:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner> <CAEivzxf1TLUeR_j8h5LfkmLOAKzrenK55bw9Qj4OV0=7Dkx9=w@mail.gmail.com>
In-Reply-To: <CAEivzxf1TLUeR_j8h5LfkmLOAKzrenK55bw9Qj4OV0=7Dkx9=w@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 29 Aug 2024 14:21:48 +0200
Message-ID: <CAEivzxeSmWPiAHbPoXZWhfavKOoX4vp8VPrPs8uNh-P_ux0-0w@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:17=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Thu, Aug 29, 2024 at 2:08=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Thu, Aug 29, 2024 at 10:24:42AM GMT, Miklos Szeredi wrote:
> > > On Thu, 18 Jul 2024 at 21:12, Aleksandr Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > > This was a first Christian's idea when he originally proposed a
> > > > patchset for cephfs [2]. The problem with this
> > > > approach is that we don't have an idmapping provided in all
> > > > inode_operations, we only have it where it is supposed to be.
> > > > To workaround that, Christian suggested applying a mapping only whe=
n
> > > > we have mnt_idmap, but if not just leave uid/gid as it is.
> > > > This, of course, leads to inconsistencies between different
> > > > inode_operations, for example ->lookup (idmapping is not applied) a=
nd
> > > > ->symlink (idmapping is applied).
> > > > This inconsistency, really, is not a big deal usually, but... what =
if
> > > > a server does UID/GID-based permission checks? Then it is a problem=
,
> > > > obviously.
> > >
> > > Is it even sensible to do UID/GID-based permission checks in the
> > > server if idmapping is enabled?
>
> Dear friends,
>
> >
> > It really makes no sense.
>
> +
>
> >
> > >
> > > If not, then we should just somehow disable that configuration (i.e.
> > > by the server having to opt into idmapping), and then we can just use
> > > the in_h.[ugi]d for creates, no?
> >
> > Fwiw, that's what the patchset is doing. It's only supported if the
> > server sets "default_permissions".
>
> Yeah. Thanks, Christian!
>
> That's what we have:
>
> +++ b/fs/fuse/inode.c
> @@ -1345,6 +1345,12 @@ static void process_init_reply(struct
> fuse_mount *fm, struct fuse_args *args,
>                  fm->sb->s_export_op =3D &fuse_export_fid_operations;
>              if (flags & FUSE_OWNER_UID_GID_EXT)
>                  fc->owner_uid_gid_ext =3D 1;
> +            if (flags & FUSE_ALLOW_IDMAP) {
> +                if (fc->owner_uid_gid_ext && fc->default_permissions)
> +                    fm->sb->s_iflags &=3D ~SB_I_NOIDMAP;
> +                else
> +                    ok =3D false;
> +            }
>          } else {
>              ra_pages =3D fc->max_read / PAGE_SIZE;
>
> So idmapped mounts can be enabled ONLY if "default_permissions" mode
> is set. At the same time,
> some fuse servers (glusterfs), even when "default_permissions" is set,
> still have some UID/GID-based checks.
> So, they effectively duplicate permission checking logic in the
> userspace. We can not do anything with that, but only
> fix fuse servers to stop doing so. See also my PoC for glusterfs-fuse
> idmapped mounts support:
> https://github.com/mihalicyn/glusterfs/commit/ab3ec2c7cbe22618cba9cc94a52=
a492b1904d0b2

and yes, latest patchset (v3) is here:
https://lore.kernel.org/all/20240815092429.103356-1-aleksandr.mikhalitsyn@c=
anonical.com/#t

>
> Kind regards,
> Alex

