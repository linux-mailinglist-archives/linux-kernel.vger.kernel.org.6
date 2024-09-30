Return-Path: <linux-kernel+bounces-344833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9198AEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493252838E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49B1A0BED;
	Mon, 30 Sep 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="0NSLaR9E"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F20192D6E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729700; cv=none; b=ct7ziiCfC4hUVYOEPREfEo8yIFGeGC7lQjNvvDdgjsbPfSuRTtprBqPGs0uouo7gfPZ1WD1r8zi3uK1xnKrpPOcKYmvGRHLySNVUlXHHwdZI/Ms+gQ9dhTjzKLWG2l50vMbzrnm88SjdNAwVvUXbBOgA1YQiAzcW69yVs4Ap2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729700; c=relaxed/simple;
	bh=ZHxu4C8/w8jPFgEhcxKtkGhA8TVNZY6PlG+8GJjUOQw=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=KYwozjfwFJh8y9f/yhj2zjQqwzPUgTXlvNMksk75uclh2+l7dAB1vx6UPD+yJ6iVW0RYwJ9IpTvEJzPA7/v9ciAFihGxflVlwKkwMqz5URy4HulVdaBIJ32thu2Hy+86dGZ5GnRL0PEj83EBPzkCFBq4k3quEVH3mEf+GdMXAbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=0NSLaR9E; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6bb2aa758so1868604a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1727729697; x=1728334497; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tgue5Rg11dHn4d+bT1qvKMjl0uHcOQJ3nuODcEVQvE=;
        b=0NSLaR9EdP/pLAAkb+e0En1Vzjfng+pSBhQPDrppNh+7TsctgbKIOe1WokFJuORQ3p
         OUPExz5NEITApqxVgkVp6vnY1IUL5Vt3QY0/EPVjOMTSqFANUT5AR536ni2ZL0A48fdN
         mL7FKBsrFABmu7yd/VPeYgDb+9sEcRpnOSpSRNpQKWpAhdeIodGI9C545ZjPIagYgnVG
         ExUx6q2oMA3iMmLLPbLuu6NeqrsGYWaPCASh5Igc0GhoinSt/yxRYtJ0JbIcqL2eTzC3
         nBlYM9O1Wqf+NAMyqYuhjSOjZrHN8xGVCNvVxyqb43AhcowneyvEK+CtwIeXVonnir7O
         0+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729697; x=1728334497;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tgue5Rg11dHn4d+bT1qvKMjl0uHcOQJ3nuODcEVQvE=;
        b=NmqXfPUa2gMJc0C2hb+qXvZWE8Bil7YdVcz7Lt4BDszMVCaiScQpelaLYHtmpzq9if
         yjWOsu3gPpaOfA58boZ68ISBhwC5AZOqLkg935tfA09bNUiA6DejZuDA5s+Jv1XIx+wz
         R4H2uwZNZNYU/3YEWP74ld04LpKFGX1E2L28XliafYOPMwa9lhHg1oH8ZBPNX/QxOiqL
         kTy2pHUpR31uRjyqNn8v5bcBRcNOoKxGkHcwrrSKgAioAdxSiUnnkYNwpAlmeNlYV4sv
         nBL1jpz/7mzWXFbRsf1GI6SHinh3xv7mtvjy3c+0ORaBRn+bAK3ckEGu/+T/cQTRhzpZ
         eB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTUUNDDMcjLR4lOWIRC0Hvu2djWdlkbW1fwPBGttI6uIouyjl86hGPuQ3Bs+WqintdIpNbWRSjETziiE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GIwRsNIEKZB2luwvpUF93tuN92/ZtuCQEgjCjHfig5cRXt0M
	LMIPyqJOvr7t5c+1BedJQwhtql4qvqq+MbxxBGLrjwFJZmUjZIFhbOGJKSx7mV0=
X-Google-Smtp-Source: AGHT+IE/I1s/URvp6DKXYunpuaXhxZ2mqhIfPSDZs2QgKZmSyES5BJcxw1E57y8lLXz8ZVyTbctEfw==
X-Received: by 2002:a05:6a21:3a87:b0:1d3:1d42:3f57 with SMTP id adf61e73a8af0-1d4fa7d1639mr16792263637.50.1727729697429;
        Mon, 30 Sep 2024 13:54:57 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265181f9sm6659890b3a.133.2024.09.30.13.54.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:54:56 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <C833DBDC-CBEE-4A98-A42E-E39CE2333037@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E727C58E-19F8-4168-BC58-C6CCDC2A9357";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: prevent data-race that occur when read/write
 ext4_group_desc structure members
Date: Mon, 30 Sep 2024 14:54:54 -0600
In-Reply-To: <20240920150013.2447-1-aha310510@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 akpm@osdl.org,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
References: <20240920150013.2447-1-aha310510@gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_E727C58E-19F8-4168-BC58-C6CCDC2A9357
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 20, 2024, at 9:00 AM, Jeongjun Park <aha310510@gmail.com> wrote:
>=20
> Currently, data-race like [1] occur in fs/ext4/ialloc.c
>=20
> find_group_other() and find_group_orlov() read multiple ext4_groups =
but
> do not protect them with locks, which causes data-race. I think it =
would
> be appropriate to add ext4_lock_group() at an appropriate location to =
solve
> this.
>=20
> [1]
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set
>=20
> write to 0xffff88810404300e of 2 bytes by task 6254 on cpu 1:
> ext4_free_inodes_set+0x1f/0x80 fs/ext4/super.c:405
> __ext4_new_inode+0x15ca/0x2200 fs/ext4/ialloc.c:1216
> ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
> vfs_symlink+0xca/0x1d0 fs/namei.c:4615
> do_symlinkat+0xe3/0x340 fs/namei.c:4641
> __do_sys_symlinkat fs/namei.c:4657 [inline]
> __se_sys_symlinkat fs/namei.c:4654 [inline]
> __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
> x64_sys_call+0x1dda/0x2d60 =
arch/x86/include/generated/asm/syscalls_64.h:267
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> read to 0xffff88810404300e of 2 bytes by task 6257 on cpu 0:
> ext4_free_inodes_count+0x1c/0x80 fs/ext4/super.c:349
> find_group_other fs/ext4/ialloc.c:594 [inline]
> __ext4_new_inode+0x6ec/0x2200 fs/ext4/ialloc.c:1017
> ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
> vfs_symlink+0xca/0x1d0 fs/namei.c:4615
> do_symlinkat+0xe3/0x340 fs/namei.c:4641
> __do_sys_symlinkat fs/namei.c:4657 [inline]
> __se_sys_symlinkat fs/namei.c:4654 [inline]
> __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
> x64_sys_call+0x1dda/0x2d60 =
arch/x86/include/generated/asm/syscalls_64.h:267
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> value changed: 0x185c -> 0x185b

I see now after you sent this patch that all of these cases are for
read-only access to the free inodes count, which doesn't really
matter if the value is racy.  These values are only used in heuristics
for block group selection, and if the value is wrong then creating a
new subdirectory may be in a different group, but that doesn't make
much difference.

It looks like the write side of all these accesses are already under
ext4_group_lock(), so the code is actually correct and not in danger
of two threads updating bg_free_inodes_count_lo/hi inconsistently.

We probably *do not* want locking in the read case, as it will cause
unnecessary lock contention scanning groups for subdirectory allocation.

My suggestion at this point would be to go back to using READ_ONCE() and
WRITE_ONCE() in ext4_free_inodes_count()/ext4_free_inodes_set() like in
your original patch. but *only* for functions used by find_group_*(). We
want to be warned by KASAN if any of the other fields are accessed =
without
a proper ext4_group_lock(), since READ_ONCE()/WRITE_ONCE() does not fix
_lo/_hi tearing.

It probably also makes sense to add comments to all of these functions
that they should hold ext4_group_lock() for access/updates, *except*
ext4_free_inodes_count() can be called to read the inode count without =
it
if the result does not need to be totally accurate.

Cheers, Andreas

> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
> fs/ext4/ialloc.c | 27 ++++++++++++++++++++++++---
> 1 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 9dfd768ed9f8..5cae247ff21f 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -500,11 +500,14 @@ static int find_group_orlov(struct super_block =
*sb, struct inode *parent,
> 		for (i =3D 0; i < flex_size; i++) {
> 			if (grp+i >=3D real_ngroups)
> 				break;
> +			ext4_lock_group(sb, grp+i);
> 			desc =3D ext4_get_group_desc(sb, grp+i, NULL);
> 			if (desc && ext4_free_inodes_count(sb, desc)) {
> 				*group =3D grp+i;
> +				ext4_unlock_group(sb, grp+i);
> 				return 0;
> 			}
> +			ext4_unlock_group(sb, grp+i);
> 		}
> 		goto fallback;
> 	}
> @@ -544,14 +547,17 @@ static int find_group_orlov(struct super_block =
*sb, struct inode *parent,
> 	parent_group =3D EXT4_I(parent)->i_block_group;
> 	for (i =3D 0; i < ngroups; i++) {
> 		grp =3D (parent_group + i) % ngroups;
> +		ext4_lock_group(sb, grp);
> 		desc =3D ext4_get_group_desc(sb, grp, NULL);
> 		if (desc) {
> 			grp_free =3D ext4_free_inodes_count(sb, desc);
> 			if (grp_free && grp_free >=3D avefreei) {
> 				*group =3D grp;
> +				ext4_unlock_group(sb, grp);
> 				return 0;
> 			}
> 		}
> +		ext4_unlock_group(sb, grp);
> 	}
>=20
> 	if (avefreei) {
> @@ -590,11 +596,14 @@ static int find_group_other(struct super_block =
*sb, struct inode *parent,
> 		if (last > ngroups)
> 			last =3D ngroups;
> 		for  (i =3D parent_group; i < last; i++) {
> +			ext4_lock_group(sb, i);
> 			desc =3D ext4_get_group_desc(sb, i, NULL);
> 			if (desc && ext4_free_inodes_count(sb, desc)) {
> 				*group =3D i;
> +				ext4_unlock_group(sb, i);
> 				return 0;
> 			}
> +			ext4_unlock_group(sb, i);
> 		}
> 		if (!retry && EXT4_I(parent)->i_last_alloc_group !=3D =
~0) {
> 			retry =3D 1;
> @@ -616,10 +625,14 @@ static int find_group_other(struct super_block =
*sb, struct inode *parent,
> 	 * Try to place the inode in its parent directory
> 	 */
> 	*group =3D parent_group;
> +	ext4_lock_group(sb, *group);
> 	desc =3D ext4_get_group_desc(sb, *group, NULL);
> 	if (desc && ext4_free_inodes_count(sb, desc) &&
> -	    ext4_free_group_clusters(sb, desc))
> +	    ext4_free_group_clusters(sb, desc)) {
> +		ext4_unlock_group(sb, *group);
> 		return 0;
> +	}
> +	ext4_unlock_group(sb, *group);
>=20
> 	/*
> 	 * We're going to place this inode in a different blockgroup =
from its
> @@ -640,10 +653,14 @@ static int find_group_other(struct super_block =
*sb, struct inode *parent,
> 		*group +=3D i;
> 		if (*group >=3D ngroups)
> 			*group -=3D ngroups;
> +		ext4_lock_group(sb, *group);
> 		desc =3D ext4_get_group_desc(sb, *group, NULL);
> 		if (desc && ext4_free_inodes_count(sb, desc) &&
> -		    ext4_free_group_clusters(sb, desc))
> +		    ext4_free_group_clusters(sb, desc)) {
> +			ext4_unlock_group(sb, *group);
> 			return 0;
> +		}
> +		ext4_unlock_group(sb, *group);
> 	}
>=20
> 	/*
> @@ -654,9 +671,13 @@ static int find_group_other(struct super_block =
*sb, struct inode *parent,
> 	for (i =3D 0; i < ngroups; i++) {
> 		if (++*group >=3D ngroups)
> 			*group =3D 0;
> +		ext4_lock_group(sb, *group);
> 		desc =3D ext4_get_group_desc(sb, *group, NULL);
> -		if (desc && ext4_free_inodes_count(sb, desc))
> +		if (desc && ext4_free_inodes_count(sb, desc)) {
> +			ext4_unlock_group(sb, *group);
> 			return 0;
> +		}
> +		ext4_unlock_group(sb, *group);
> 	}
>=20
> 	return -1;
> --


Cheers, Andreas






--Apple-Mail=_E727C58E-19F8-4168-BC58-C6CCDC2A9357
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmb7EB4ACgkQcqXauRfM
H+BW6Q//QAcANtiUgP6xjrr5Dx/8Tpv3LFfO5qgC7jJIu0S04302mPMSZGu0g6s0
nAFWDpnO6tcQ9/tqUF5aPuaTfX+KxCJ14nJGlfy+IUeqSfjrNLkbIJzXSwQusPRj
CxN0XuWQvfpi4kDov+g6JtFpWu4plDcLedr64fjlEbykgb4tAXxAMNrsEEfXHvPv
8bg8pKHDtH2puwgxfJGI6tcRLUI80I/PrPSO0/GPBaUmNBKGnMVvEmQffX6ZWfJM
/Zf6eMNzMn9oSCdlTfgi5XzvgAC1Q8PHZKnZqwWStPrVag9LzASIkJFE0zXifiBS
d+ABku+/4/gv3y5a2GDAfEK29KEEzvX9GT5vMIQ4425wmcS2mqpVxLq4VxIQb52O
QGOeRLnnaafc2oeiuhmEA7xxQLLcFc+VuwxSC/q1JKXcx2JSqAaLNuAZ2GDD5wcy
gpaBsk8omXb6FXISYrBli1hk1Toyl6KBGlGRLgZ2TYr3vRN/xODtx1DcVAllx4vs
ZLuw7EinzlnmKwYUy8PT92xkgioJ4a80ocHKjL5VTJSdbvTO1riFpuswR020v7+S
+vfZvaPsCkY3ru220Bc4//PV3m4CGiLq9ABZRy0ZXBZtwKU6XXRtHMFwUUg1wp2s
2IcIr8sJs5FwALnxU6Iu/fGLh/CkPouFhie6DI2XChxcplcZwKw=
=4uax
-----END PGP SIGNATURE-----

--Apple-Mail=_E727C58E-19F8-4168-BC58-C6CCDC2A9357--

