Return-Path: <linux-kernel+bounces-272021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F29455F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E76B20F45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4458EEC3;
	Fri,  2 Aug 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="eh6MzRPN"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE1C156
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562184; cv=none; b=TJrDJa/nGWdfYD2/08BN+3PT2hZ7TrAch1MqldNMpd2CxUdjQSm9qtiQGkgjDNwFeO/XeL4dIPvIvXKIK8ILLS9wa+U3AAn7lud3HLC+rkDU2Hj6jB/WoF6wpU5lkwaZXL3PvJ9ITlRKfVme8xtMaJPGvDxyloO8CiWXOMQTV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562184; c=relaxed/simple;
	bh=cXfnnHg0MCCq+fKFe+0m7q2PKhq9Szwaz+UI7/C5AZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzMqa8K5llZ9TJ/eAhYj1ry+JBaoHQuh7iLvSceBdErjcirMa2pkMz3jrcwQvbNZ4DaAx+GzOQZGeRIZS6rIddh7u8/3imNkFQMDS2fvJvCc3d8sNYfMEaTuOQRXjbTE/xMOqCzFwzj1yqNX1A7ioB+SDt5R85ismhgSlUx1kEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=eh6MzRPN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WZpCb2Dptz9sZP;
	Fri,  2 Aug 2024 03:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722562171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ax6yBhQb5nn9mwiW0JMiC2p674yh6Bm5awl4VBnC6JY=;
	b=eh6MzRPN/JfHCw6b1VGcEa0qoQtLD2B4veHfduLM2yxkE8RwKiF5YSvkSkE0x2uCtib5Wg
	yC8uBGylFt7naNPFN94d5kNPVEgJ/3nrvnH5ilexsoPz25W92BiSOD2pmK7t4T20/QWpQ5
	UN6OlltHLAaHA1aWiMM5RPzv1z6qEnQuKECkayegDef9ErIEh84jJhBHyBg8Qi++ZBz/GU
	i13swS5YthLrs0gyYNYPeCX20K4RojMfq2X/Bmf5Jm8Ovm8ptABk7u/ytJW8tDolCCniVO
	+xtUdhO8LycMWNZkZhWD2bplWp2EQ0TNH5vK5czx+Bq6asgna/SanSfBpG1Rhw==
Date: Fri, 2 Aug 2024 11:29:19 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it, 
	Alexey Gladkov <legion@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Cyril Hrubis <chrubis@suse.cz>, Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	=?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@rtone.fr>, linux-kernel@vger.kernel.org
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
Message-ID: <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rzl3iorkuep52mxl"
Content-Disposition: inline
In-Reply-To: <20240801165756.GA1526142@pevik>
X-Rspamd-Queue-Id: 4WZpCb2Dptz9sZP


--rzl3iorkuep52mxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-01, Petr Vorel <pvorel@suse.cz> wrote:
> Hi all,
>=20
> > This is a patch-set that implements fchmodat2() syscall coverage.
> > fchmodat2() has been added in kernel 6.6 in order to support
> > AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
> > There's no man pages yet, so please take the following links as
> > main documentation along with kernel source code:
>=20
> I would hope that it'd be at least Christian's fork [1], but it's not the=
re.
> I suppose nobody is working on the man page.
>=20
> > https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
> > https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@=
brauner/
>=20
> > ***********
> > * WARNING *
> > ***********
>=20
> > fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
>=20
> For a record, it's fchmodat2_01.c (from this patchset) which is failing (=
on
> 6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64=
 VMs).
>=20
> Andrea, I would personally just skip test on EOPNOTSUPP (that's what we d=
o in
> LTP on EOPNOTSUPP). The question why is not supported and whether is goin=
g to be
> fixed.
>=20
> Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for=
 flags
> different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it =
looks
> just accepted behavior (glibc returns EOPNOTSUPP on symlink):
>=20
> +  /* Some Linux versions with some file systems can actually
> +     change symbolic link permissions via /proc, but this is not
> +     intentional, and it gives inconsistent results (e.g., error
> +     return despite mode change).  The expected behavior is that
> +     symbolic link modes cannot be changed at all, and this check
> +     enforces that.  */
> +  if (S_ISLNK (st.st_mode))
> +    {
>        __close_nocancel (pathfd);
> -      return ret;
> +      __set_errno (EOPNOTSUPP);
> +      return -1;
> +    }
>=20
> Also musl also behaves the same on his fallback on old kernels [3]
> (it started 10 years ago on 0dc48244 ("work around linux's lack of flags
> argument to fchmodat syscall") when SYS_fchmodat was used and kept when t=
his
> year SYS_fchmodat2 started to be used in d0ed307e):
>=20
> 	int ret =3D __syscall(SYS_fchmodat2, fd, path, mode, flag);
> 	if (ret !=3D -ENOSYS) return __syscall_ret(ret);
>=20
> 	if (flag !=3D AT_SYMLINK_NOFOLLOW)
> 		return __syscall_ret(-EINVAL);
>=20
> 	struct stat st;
> 	int fd2;
> 	char proc[15+3*sizeof(int)];
>=20
> 	if (fstatat(fd, path, &st, flag))
> 		return -1;
> 	if (S_ISLNK(st.st_mode))
> 		return __syscall_ret(-EOPNOTSUPP);
>=20
>=20
> > According to documentation, the feature has been implemented in
> > kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
> > on symbolic files. Also kselftests, which are meant to test the
> > functionality, are not working and they are treating fchmodat2()
> > syscall failure as SKIP. Please take a look at the following code
> > before reviewing:
>=20
> > https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0=
fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123
>=20
> I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fc=
hmodat2
> selftest") [4], where fchmodat2 failure on symlink is simply skipped.
>=20
> Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Do=
es
> anybody work or plan to work on fixing it? LTP has policy to not cover ke=
rnel
> bugs, if it's not expected to be working we might just skip the test as w=
ell.

If I understand the bug report, the issue is that fchmodat2() doesn't
work on symlinks?

This is intentional -- Christian fixed a tree-wide bug a while ago[1]
where some filesystems would change the mode of symlinks despite
returning an error (usually EOPNOTSUPP) and IIRC a few others would
happily change the mode of symlinks.

The current intended behaviour is to always return EOPNOTSUPP, and AFAIK
there is no plan to re-enable the changing of symlink modes. EOPNOTSUPP
was chosen because that's what filesystems were already returning.
(While this is a little confusing, VFS syscalls return EINVAL for an
unsupported flag, not EOPNOTSUPP.)

The benefit of an AT_SYMLINK_NOFOLLOW flag is not just to to allow a
syscall to operate on symlinks, it also allows programs to safely
operate on path components without worrying about symlinks being
followed (this is relevant for container runtimes, where we are
operating on untrusted filesystem roots -- though in the case of
fchmodat2(2) you would probably just use AT_EMPTY_PATH in practice). So
an error here is actually what you want as a program that uses
AT_SYMLINK_NOFOLLOW (since the actual operation is intentionally not
supported by filesystems).

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D5d1f903f75a80daa4dfb3d84e114ec8ecbf29956

> I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fc=
ntl.h,
> but AFAIK it's not related to this problem.

Yeah this is unrelated, that patch is about clarifying how AT_* flags
are allocated, not syscall behaviour.

> Kind regards,
> Petr
>=20
> [1] https://github.com/brauner/man-pages-md
> [2] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3D65341f7b=
bea824d2ff9d37db15d8be162df42bd3;hp=3Dc52c2c32db15aba8bbe1a0b4d3235f97d9c1a=
525
> [3] https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/tools/testing/selftests/fchmodat2/fchmodat2_test.c?h=3Dnext-20240801&=
id=3D4859c257d295949c23f4074850a8c2ec31357abb
> [5] https://lore.kernel.org/lkml/20240801-exportfs-u64-mount-id-v3-0-be5d=
6283144a@cyphar.com/
>=20
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> > Changes in v4:
> > - add SAFE_FCHMODAT2
> > - Link to v3: https://lore.kernel.org/r/20240724-fchmodat2-v3-0-1dc7cfc=
634b8@suse.com
>=20
> > Changes in v3:
> > - removed fchmodat2.h
> > - Link to v2: https://lore.kernel.org/r/20240723-fchmodat2-v2-0-e658a98=
b113e@suse.com
>=20
> > Changes in v2:
> > - merge first 3 tests into a unique one
> > - move fchmodat2 in lapi/stat.h
> > - add test for error checking
> > - Link to v1: https://lore.kernel.org/r/20240521-fchmodat2-v1-0-191b4a9=
86202@suse.com
>=20
> > ---
> > Andrea Cervesato (5):
> >       Add SAFE_SYMLINKAT macro
> >       Add fchmodat2 syscalls definitions
> >       Add fchmodat2 fallback definition
> >       Add fchmodat2_01 test
> >       Add fchmodat2_02 test
>=20
> >  include/lapi/stat.h                                |  16 +++
> >  include/lapi/syscalls/aarch64.in                   |   1 +
> >  include/lapi/syscalls/arc.in                       |   1 +
> >  include/lapi/syscalls/arm.in                       |   1 +
> >  include/lapi/syscalls/hppa.in                      |   1 +
> >  include/lapi/syscalls/i386.in                      |   1 +
> >  include/lapi/syscalls/ia64.in                      |   1 +
> >  include/lapi/syscalls/loongarch.in                 |   1 +
> >  include/lapi/syscalls/mips_n32.in                  |   1 +
> >  include/lapi/syscalls/mips_n64.in                  |   1 +
> >  include/lapi/syscalls/mips_o32.in                  |   1 +
> >  include/lapi/syscalls/powerpc.in                   |   1 +
> >  include/lapi/syscalls/powerpc64.in                 |   1 +
> >  include/lapi/syscalls/s390.in                      |   1 +
> >  include/lapi/syscalls/s390x.in                     |   1 +
> >  include/lapi/syscalls/sh.in                        |   1 +
> >  include/lapi/syscalls/sparc.in                     |   1 +
> >  include/lapi/syscalls/sparc64.in                   |   1 +
> >  include/lapi/syscalls/x86_64.in                    |   1 +
> >  include/safe_macros_fn.h                           |   4 +
> >  include/tst_safe_macros.h                          |   3 +
> >  lib/safe_macros.c                                  |  20 ++++
> >  runtest/syscalls                                   |   3 +
> >  testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
> >  testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
> >  testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 114 +++++++++++++=
++++++++
> >  testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 ++++++++++++
> >  27 files changed, 255 insertions(+)
> > ---
> > base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
> > change-id: 20240517-fchmodat2-5b82867d71fc
>=20
> > Best regards,

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--rzl3iorkuep52mxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZqw2bwAKCRAol/rSt+lE
b9OYAP9NFsWneBqeKl3bEqKtMJsljy4EjkRgFFrZMU6xVknFKgD+MdghCPr5KLVK
EbxvV7J5H6LYOOEMhgzWew+P9vgZdQ0=
=/ewX
-----END PGP SIGNATURE-----

--rzl3iorkuep52mxl--

