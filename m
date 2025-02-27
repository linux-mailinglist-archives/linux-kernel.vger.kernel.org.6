Return-Path: <linux-kernel+bounces-535346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF48A47181
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1083B7E83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F0149E17;
	Thu, 27 Feb 2025 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hmrDqXOH"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E55143888
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620298; cv=none; b=ptzMtXNH0LF7UO5oI+p2jbXNK6/3jMJ+nKBX2qKvw8O9JExbUg2tjksnHK5dIa/r8SZccLaWSqyeWXO37ja9oejbW974UIYvI+o5eglX5dokNR2j0UaQ6U2vSFG9JWGYonzHtlcl7jn8TSG1Fo+M8+vrLQoVn4RY6OojjbrysMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620298; c=relaxed/simple;
	bh=p4OsGioZmuLqVPZzsXhdjWaQ7gH0GU5PolI3OjkwnqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6XL7iEHLJ80CU0Mrxb7PTo8MZ3ZYQbFD77tUCrQRBbTo9spQM8GIx/ppkOWmZ5qTEyb9Ti5PuxD9Fi91ftkltARnvQWaZPV3R3IF0M/F/YcxO/h9HS1RkBKgMnxkWv6uwUnLs1eILd4DFx6jwkpaEwbPI/fmlCMOUBYO7uXvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=hmrDqXOH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1740620286;
	bh=z9DAWos27Q06IuDaa4M0Viia0I6M9BgZYbFd4xPj7os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hmrDqXOHkgsssj53WYqWoYqxhlLc10soLYugSfq+dyj3ngu3g3a823IYRsgrjFGTi
	 O2NNkQZBxsHNyr/i4hu14+ePucnIDTje1XzBcqDsoW16X666Pvu7DaKsBRH25vpkFm
	 anDgBDxc24RSrMW/z7CmgtvworqIztAQrEGAdniPqxI6JyZzTbldd1/9+7pg0IgbDE
	 OtGAG99zzX/zs7BHFczCfl6yrBzlShYUHy3CYfq3XBzbwuY2Z3tLF6Bb8F4Un/o8/P
	 IKa7ESDHpAgrRfakKIY2Zpj/GGGDlzyoRu6dNB/o/n05cpog4SDXh+q5g6rb+XWjFl
	 u/wmW3z9ihwVg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z3DW21qqvz4x1V;
	Thu, 27 Feb 2025 12:38:06 +1100 (AEDT)
Date: Thu, 27 Feb 2025 12:38:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>
Subject: Re: [next-20250226]Build Failure
Message-ID: <20250227123804.5dd71cef@canb.auug.org.au>
In-Reply-To: <adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com>
References: <adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7puLdNAfr4chsrb23DmAgsy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7puLdNAfr4chsrb23DmAgsy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Venkat,

CC Kees Cook for advice.  This is a result of the tests added in commit

  bbeb38b8487a ("string.h: Validate memtostr*()/strtomem*() arguments more =
carefully")

from the kspp tree.

I note that the comment about memtostr() says "Copy a possibly
non-NUL-term string".

On Thu, 27 Feb 2025 06:30:12 +0530 Venkat Rao Bagalkote <venkat88@linux.vne=
t.ibm.com> wrote:
>
> I am seeing build failures with kernel next-20250226, on IBM Power8 syste=
ms.
>=20
> Failures:
>=20
> In file included from ./include/asm-generic/div64.h:27,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/powerpc/include/generated/asm/div64.h:=
1,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/math.h:6,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/math64.h:6,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/time.h:6,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from fs/ext4/file.c:22:
> fs/ext4/file.c: In function 'ext4_sample_last_mounted':
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:418:6: note: in expansion of macro '__must_be_no=
ncstr'
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __must_be_noncstr(dest) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~
> fs/ext4/file.c:869:2: note: in expansion of macro 'strtomem_pad'
>  =C2=A0 strtomem_pad(sbi->s_es->s_last_mounted, cp, 0);
>  =C2=A0 ^~~~~~~~~~~~
> In file included from ./include/linux/build_bug.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/container_of.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/list.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/module.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/message/fusion/mptsas.c:46:
> drivers/message/fusion/mptsas.c: In function 'mptsas_exp_repmanufacture_i=
nfo':
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/message/fusion/mptsas.c:2968:3: note: in expansion of macro 'memt=
ostr'
>  =C2=A0=C2=A0 memtostr(edev->vendor_id, manufacture_reply->vendor_id);
>  =C2=A0=C2=A0 ^~~~~~~~
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/message/fusion/mptsas.c:2969:3: note: in expansion of macro 'memt=
ostr'
>  =C2=A0=C2=A0 memtostr(edev->product_id, manufacture_reply->product_id);
>  =C2=A0=C2=A0 ^~~~~~~~
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/message/fusion/mptsas.c:2970:3: note: in expansion of macro 'memt=
ostr'
>  =C2=A0=C2=A0 memtostr(edev->product_rev, manufacture_reply->product_rev);
>  =C2=A0=C2=A0 ^~~~~~~~
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/message/fusion/mptsas.c:2973:4: note: in expansion of macro 'memt=
ostr'
>  =C2=A0=C2=A0=C2=A0 memtostr(edev->component_vendor_id,
>  =C2=A0=C2=A0=C2=A0 ^~~~~~~~
> make[4]: *** [scripts/Makefile.build:203: fs/ext4/file.o] Error 1
> make[3]: *** [scripts/Makefile.build:461: fs/ext4] Error 2
> make[3]: *** Waiting for unfinished jobs....
> In file included from ./include/linux/array_size.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/kernel.h:16,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/scsi/mpt3sas/mpt3sas_base.c:46:
> drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_display_ioc_capab=
ilities':
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/scsi/mpt3sas/mpt3sas_base.c:4798:2: note: in expansion of macro '=
memtostr'
>  =C2=A0 memtostr(desc, ioc->manu_pg0.ChipName);
>  =C2=A0 ^~~~~~~~
> In file included from ./include/linux/build_bug.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/container_of.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/list.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/module.h:12,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/scsi/mpt3sas/mpt3sas_transport.c:45:
> drivers/scsi/mpt3sas/mpt3sas_transport.c: In function '_transport_expande=
r_report_manufacture':
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/scsi/mpt3sas/mpt3sas_transport.c:461:3: note: in expansion of mac=
ro 'memtostr'
>  =C2=A0=C2=A0 memtostr(edev->vendor_id, manufacture_reply->vendor_id);
>  =C2=A0=C2=A0 ^~~~~~~~
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/scsi/mpt3sas/mpt3sas_transport.c:462:3: note: in expansion of mac=
ro 'memtostr'
>  =C2=A0=C2=A0 memtostr(edev->product_id, manufacture_reply->product_id);
>  =C2=A0=C2=A0 ^~~~~~~~
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/scsi/mpt3sas/mpt3sas_transport.c:463:3: note: in expansion of mac=
ro 'memtostr'
>  =C2=A0=C2=A0 memtostr(edev->product_rev, manufacture_reply->product_rev);
>  =C2=A0=C2=A0 ^~~~~~~~
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/scsi/mpt3sas/mpt3sas_transport.c:466:4: note: in expansion of mac=
ro 'memtostr'
>  =C2=A0=C2=A0=C2=A0 memtostr(edev->component_vendor_id,
>  =C2=A0=C2=A0=C2=A0 ^~~~~~~~
> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/mpt3sas/mpt3sas_tr=
ansport.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
> make[5]: *** [scripts/Makefile.build:203: drivers/message/fusion/mptsas.o=
] Error 1
> make[4]: *** [scripts/Makefile.build:461: drivers/message/fusion] Error 2
> make[3]: *** [scripts/Makefile.build:461: drivers/message] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/mpt3sas/mpt3sas_ba=
se.o] Error 1
> In file included from ./include/linux/array_size.h:5,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/kernel.h:16,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/scsi/qla2xxx/qla_def.h:9,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/scsi/qla2xxx/qla_mr.c:6:
> drivers/scsi/qla2xxx/qla_mr.c: In function 'qlafx00_fx_disc':
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/scsi/qla2xxx/qla_mr.c:1912:3: note: in expansion of macro 'memtos=
tr'
>  =C2=A0=C2=A0 memtostr(vha->hw->model_number, pinfo->model_num);
>  =C2=A0=C2=A0 ^~~~~~~~
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must =
be non-C-string (not NUL-terminated)"
>  =C2=A0#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Stat=
ic_assert(!(e), msg);}))
> ^~~~~~~~~~~~~~
> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BU=
G_ON_ZERO_MSG'
>  =C2=A0 __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>  =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_n=
oncstr'
>  =C2=A0 const size_t _src_len =3D __must_be_noncstr(src) +=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~
> drivers/scsi/qla2xxx/qla_mr.c:1913:3: note: in expansion of macro 'memtos=
tr'
>  =C2=A0=C2=A0 memtostr(vha->hw->model_desc, pinfo->model_description);
>  =C2=A0=C2=A0 ^~~~~~~~
> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/qla2xxx/qla_mr.o] =
Error 1
> make[5]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:461: fs] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:461: drivers/scsi/mpt3sas] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:461: drivers/scsi/qla2xxx] Error 2
> make[3]: *** [scripts/Makefile.build:461: drivers/scsi] Error 2
> make[2]: *** [scripts/Makefile.build:461: drivers] Error 2
> make[1]: *** [/root/linux-next/Makefile:1989: .] Error 2
> make: *** [Makefile:251: __sub-make] Error 2

--=20
Cheers,
Stephen Rothwell

--Sig_/7puLdNAfr4chsrb23DmAgsy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAme/wfwACgkQAVBC80lX
0GzL9Af/U/CJEELhbzkzdLWIY0plJ0XZ+R+ww2HwFW1pLUVcllV4PGRIf9kz9yzY
0RR19gqcx07Fo4j5FvZdRJJ39necHqyKtla3ErO1IQsc1KQ/fTUejQuNPhtjWQY+
m0W3B20+Y+vDy3XuWk59drD2BvDO2g9j5C9lO+6DQueS3eaDzIruLZUBp41HqLzV
hN69eC8b4lBsBnhOv2lWV+fFOIDweJmu8i4BMEHZx1VqXxybnGdek+vwrW33/XZc
qdGZSJMKjfaOu3XfOWxfVXRCYar7l+Oy5SVH0Duf+UzbIgmMk4hO5t4fXOxMBPLI
raROl9gOI4ZjhpxopeduWSYuYDsBjQ==
=dZN8
-----END PGP SIGNATURE-----

--Sig_/7puLdNAfr4chsrb23DmAgsy--

