Return-Path: <linux-kernel+bounces-306827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9F496443A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38766B26835
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24C318DF99;
	Thu, 29 Aug 2024 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q89Cjwd9"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFAB1922FA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933895; cv=none; b=o3QqcSPQN/qVs0MgBpWVzEpwqG334r14R3YxF/P4uPKJnwt1FLxt7Khzex+CqNQdhBGIBLkM9MBpUjGhhhKdAlTminKCkjk9WtiGpIq/RGiuGniZ+xuqsS3wT67dTWRJo3PfTiBBYfISdku5VQjRlgctNl4WRDKOLhKqZeCYkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933895; c=relaxed/simple;
	bh=nPbtzIWPtGgZ8ddKgweGtAo97LnSRzhBtcpnzjo9y6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rA1VDJ4A9SHQ/ef0jncjsgTE24URoEVHNnmBK0p/AWKAcImCg4MN6LD1QKZydv80qS4IfB3p1jhfNYeeJ9CLDUR/IsB21rr9mJWo9nR1uJKzYsHqsI32HLZRVhze7bV3A6Yb4gBdE1sov6mmYsyasZzPtkvdN2o3FknChpoDKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q89Cjwd9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2992F3F664
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724933888;
	bh=agyuHbgeN5G+Glllc9xwF5iz8tsF/j2Kakno2rsBnCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Q89Cjwd9UEkV2vBPQIVfAPD2T/0vHSPCJMuj8bd1H7/Yh7KaQu9XssPRKrHTNI6JM
	 qzYw5A9IiSkUJzxKEAMUPCEA3veAvNPdXAAsAtBQX+R2nv7/0DF8Iy6tA5I3UC2f5x
	 2dsqq9ht5C2YQ36A2UFcF9UkjDsOj1nXZRqT4XulH8Ye1UhtBxn4l31mUAMy/nwTni
	 MnOOvSmlLwQy9kHkwWr0M58sAbhwOvPkH5m+/Kj8ZTaiwWWjMt+dt8M3hdr07aRgp1
	 sALjFP2cwZHMJY2iVVZIZuiiI8ZtsUzEm5xBWSZkt239ha2S0HAh45sVS7j6dW+J8l
	 pBZ7U64i2w5tw==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3db18cf7be8so708130b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933887; x=1725538687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agyuHbgeN5G+Glllc9xwF5iz8tsF/j2Kakno2rsBnCU=;
        b=geEx/MFoo6ysOqodgmNsQLsGf/caCgPHuXiOZDb7lzAqYTXTjBvpjs2R7J+A2nvCBA
         /AbuO6/33GPXNXYtHEd+pLMKqcHsjoKIXJwXrPXZ4SyRp+GWTl4ehHMgZQP6aknLKGF0
         XRZVM1Nu6HMx3dbm2LaJq2ydv0KaevSsw4Yn/9G0xTAmIT9vpiIz+6pLU257xGYFKZG+
         IySo+4TiyhQR2+qMauuEQ2nBv3jXbnm030NOL8uwcfzAZ7w+lGGHoboyuhTPxtwHIQXE
         6x+IgOJSo1SRdfSkDw4lQ7WA0BUSwaa8kIUKz/lTrdkaHigl0ERjsWGgugP/fi4BJi8s
         RT/w==
X-Forwarded-Encrypted: i=1; AJvYcCVkRdm6kp8GX0x44WOzL3QYFa5TOpun2AWYvhdD1crXOJsVpaedneoQwfyd5B433ksfZX8mNQyGczdaglo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHlvXNcqtrnOWFrkTKOYggKnfd/kb/NecBHHJ6DeBEfmiAxkbq
	AE9MK8bfb3QpHO7hRcu3pTGt11dc/EzPkejjQsF0uLZwHS8PNCqO1ABYneXKn/Npd7c1TJCFyDW
	0TQeDRjs2plk2z0YwPOzVcvkjLG5ClDF8MOcMkEARW9R9F/mhMmPj0rlJAB2WzMZUWGatOlFkjl
	llJmx1AoosdXLuAulBZ3ztIaz5BQ1VWSzUihrvzVfKmLLj000Rtrke
X-Received: by 2002:a05:6808:3a0d:b0:3df:dad:10e1 with SMTP id 5614622812f47-3df0dad14b9mr387491b6e.13.1724933886881;
        Thu, 29 Aug 2024 05:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGhWDrBHdruJc4RhJ06FsFQi5d5GDa/1GlsVFtFype7PVLTCKgslSYz+vhfd3O4egbh57iMWClm03kaSZZmS8=
X-Received: by 2002:a05:6808:3a0d:b0:3df:dad:10e1 with SMTP id
 5614622812f47-3df0dad14b9mr387457b6e.13.1724933886565; Thu, 29 Aug 2024
 05:18:06 -0700 (PDT)
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
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com> <20240829-hurtig-vakuum-5011fdeca0ed@brauner>
In-Reply-To: <20240829-hurtig-vakuum-5011fdeca0ed@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 29 Aug 2024 14:17:55 +0200
Message-ID: <CAEivzxf1TLUeR_j8h5LfkmLOAKzrenK55bw9Qj4OV0=7Dkx9=w@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:08=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Aug 29, 2024 at 10:24:42AM GMT, Miklos Szeredi wrote:
> > On Thu, 18 Jul 2024 at 21:12, Aleksandr Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > > This was a first Christian's idea when he originally proposed a
> > > patchset for cephfs [2]. The problem with this
> > > approach is that we don't have an idmapping provided in all
> > > inode_operations, we only have it where it is supposed to be.
> > > To workaround that, Christian suggested applying a mapping only when
> > > we have mnt_idmap, but if not just leave uid/gid as it is.
> > > This, of course, leads to inconsistencies between different
> > > inode_operations, for example ->lookup (idmapping is not applied) and
> > > ->symlink (idmapping is applied).
> > > This inconsistency, really, is not a big deal usually, but... what if
> > > a server does UID/GID-based permission checks? Then it is a problem,
> > > obviously.
> >
> > Is it even sensible to do UID/GID-based permission checks in the
> > server if idmapping is enabled?

Dear friends,

>
> It really makes no sense.

+

>
> >
> > If not, then we should just somehow disable that configuration (i.e.
> > by the server having to opt into idmapping), and then we can just use
> > the in_h.[ugi]d for creates, no?
>
> Fwiw, that's what the patchset is doing. It's only supported if the
> server sets "default_permissions".

Yeah. Thanks, Christian!

That's what we have:

+++ b/fs/fuse/inode.c
@@ -1345,6 +1345,12 @@ static void process_init_reply(struct
fuse_mount *fm, struct fuse_args *args,
                 fm->sb->s_export_op =3D &fuse_export_fid_operations;
             if (flags & FUSE_OWNER_UID_GID_EXT)
                 fc->owner_uid_gid_ext =3D 1;
+            if (flags & FUSE_ALLOW_IDMAP) {
+                if (fc->owner_uid_gid_ext && fc->default_permissions)
+                    fm->sb->s_iflags &=3D ~SB_I_NOIDMAP;
+                else
+                    ok =3D false;
+            }
         } else {
             ra_pages =3D fc->max_read / PAGE_SIZE;

So idmapped mounts can be enabled ONLY if "default_permissions" mode
is set. At the same time,
some fuse servers (glusterfs), even when "default_permissions" is set,
still have some UID/GID-based checks.
So, they effectively duplicate permission checking logic in the
userspace. We can not do anything with that, but only
fix fuse servers to stop doing so. See also my PoC for glusterfs-fuse
idmapped mounts support:
https://github.com/mihalicyn/glusterfs/commit/ab3ec2c7cbe22618cba9cc94a52a4=
92b1904d0b2

Kind regards,
Alex

