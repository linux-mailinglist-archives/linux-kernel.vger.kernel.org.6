Return-Path: <linux-kernel+bounces-272387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DE945B1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC928680E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B971BF304;
	Fri,  2 Aug 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="zJQY2hMf"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577B1DAC7B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591346; cv=none; b=n8EJ9yEy+z3WrmXMxp6wGUfqBZ0zsYClXobhv7Rr3B/8smE9cNn8rX+02tzn4R9OGQActcoaXfrX9xQcVmMP8eto3iAj6JQnfAQfP8NJRYmssSNPQmwrHyjOK87i143PHb3mCOerfEq8y8/5yVLy26xJhh8xso/AdTRsPUzKfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591346; c=relaxed/simple;
	bh=gpNnCmWH+MsmC4CRSbor1HBxfe7x1m0y4FXoZ01WsjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YScLetJ4S6X0geuZeyrm0WbsxgqTVUgu3+9/xBFwnBjTqt9gumgZi3yrKzg2Mdl59dSDi7f02Fq7ni+6vVkWmSexeW2KLEdUBSXqS2mqQytqTbRDEQwnrjXQqTJRqhDoz6KtEZ4+TK4B4JQ+x2IMUHCPg/FMoxXw1lV05YhdqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=zJQY2hMf; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wb10P4N2Tz9sp7;
	Fri,  2 Aug 2024 11:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722591333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npGq83IWdjOLH1oTSnWgmGepd/AMm8kv1gIbxRg3o54=;
	b=zJQY2hMf1negs+PDPgnw3C8Gh0D7iWddqsz9UsXT1/TtpjXgIveL5RXt9S5xZYSnlTbmHG
	onElk2kuF3ll59kDxbgaqenagCy9A99oSAmPWHw/32H0gYF7ZXtHkaasdvL93osQAT8+iC
	od+ZL2M7ahM4zrksbv4QNpHF0Wg6eRY5KGioaH+4SGzxmkwR9BLX68W3WgH9Vfm7MxKku3
	k23K4WZQGkJzaMKrJ6cEdXrbvNw9LUoI/xbQznr0kKJg4svTAP87t7/L0NsihWrzG4GG1R
	2+8dIv0+egLrBPTAsMuwHmul8mjlVmXpd3gwvmi4vuY9ZW5s2oGrfELFnYsdnA==
Date: Fri, 2 Aug 2024 19:35:19 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Petr Vorel <pvorel@suse.cz>, 
	Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it, Alexey Gladkov <legion@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Cyril Hrubis <chrubis@suse.cz>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@rtone.fr>, 
	linux-kernel@vger.kernel.org
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
Message-ID: <20240802.091810-fresh.camps.mild.skyline-lIrajRPgkI@cyphar.com>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
 <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
 <20240802054252.GA1582980@pevik>
 <b0de5bc7-2b94-47cc-9610-fbec1347aecc@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ap6ghydj4mtubiy"
Content-Disposition: inline
In-Reply-To: <b0de5bc7-2b94-47cc-9610-fbec1347aecc@suse.com>
X-Rspamd-Queue-Id: 4Wb10P4N2Tz9sp7


--7ap6ghydj4mtubiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-02, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> Hi!
>=20
> On 8/2/24 07:42, Petr Vorel wrote:
> > > On 2024-08-01, Petr Vorel <pvorel@suse.cz> wrote:
> > > > Hi all,
> > > > > This is a patch-set that implements fchmodat2() syscall coverage.
> > > > > fchmodat2() has been added in kernel 6.6 in order to support
> > > > > AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
> > > > > There's no man pages yet, so please take the following links as
> > > > > main documentation along with kernel source code:
> > > > I would hope that it'd be at least Christian's fork [1], but it's n=
ot there.
> > > > I suppose nobody is working on the man page.
> > > > > https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
> > > > > https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fd=
aad50@brauner/
> > > > > ***********
> > > > > * WARNING *
> > > > > ***********
> > > > > fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
> > > > For a record, it's fchmodat2_01.c (from this patchset) which is fai=
ling (on
> > > > 6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both =
x86_64 VMs).
> > > > Andrea, I would personally just skip test on EOPNOTSUPP (that's wha=
t we do in
> > > > LTP on EOPNOTSUPP). The question why is not supported and whether i=
s going to be
> > > > fixed.
> > > > Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchm=
od for flags
> > > > different than 0 (BZ 26401)") one year old change from glibc-2.39 [=
2] it looks
> > > > just accepted behavior (glibc returns EOPNOTSUPP on symlink):
> > > > +  /* Some Linux versions with some file systems can actually
> > > > +     change symbolic link permissions via /proc, but this is not
> > > > +     intentional, and it gives inconsistent results (e.g., error
> > > > +     return despite mode change).  The expected behavior is that
> > > > +     symbolic link modes cannot be changed at all, and this check
> > > > +     enforces that.  */
> > > > +  if (S_ISLNK (st.st_mode))
> > > > +    {
> > > >         __close_nocancel (pathfd);
> > > > -      return ret;
> > > > +      __set_errno (EOPNOTSUPP);
> > > > +      return -1;
> > > > +    }
> > > > Also musl also behaves the same on his fallback on old kernels [3]
> > > > (it started 10 years ago on 0dc48244 ("work around linux's lack of =
flags
> > > > argument to fchmodat syscall") when SYS_fchmodat was used and kept =
when this
> > > > year SYS_fchmodat2 started to be used in d0ed307e):
> > > > 	int ret =3D __syscall(SYS_fchmodat2, fd, path, mode, flag);
> > > > 	if (ret !=3D -ENOSYS) return __syscall_ret(ret);
> > > > 	if (flag !=3D AT_SYMLINK_NOFOLLOW)
> > > > 		return __syscall_ret(-EINVAL);
> > > > 	struct stat st;
> > > > 	int fd2;
> > > > 	char proc[15+3*sizeof(int)];
> > > > 	if (fstatat(fd, path, &st, flag))
> > > > 		return -1;
> > > > 	if (S_ISLNK(st.st_mode))
> > > > 		return __syscall_ret(-EOPNOTSUPP);
> >=20
> > > > > According to documentation, the feature has been implemented in
> > > > > kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
> > > > > on symbolic files. Also kselftests, which are meant to test the
> > > > > functionality, are not working and they are treating fchmodat2()
> > > > > syscall failure as SKIP. Please take a look at the following code
> > > > > before reviewing:
> > > > > https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29a=
aff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123
> > > > I see there is a kselftest workaround in 4859c257d295 ("selftests: =
Add fchmodat2
> > > > selftest") [4], where fchmodat2 failure on symlink is simply skippe=
d.
> > > > Aleksa, you're probably aware of this fchmodat2() failure on symlin=
ks. Does
> > > > anybody work or plan to work on fixing it? LTP has policy to not co=
ver kernel
> > > > bugs, if it's not expected to be working we might just skip the tes=
t as well.
> > > If I understand the bug report, the issue is that fchmodat2() doesn't
> > > work on symlinks?
> > Yes.
> >=20
> > > This is intentional -- Christian fixed a tree-wide bug a while ago[1]
> > > where some filesystems would change the mode of symlinks despite
> > > returning an error (usually EOPNOTSUPP) and IIRC a few others would
> > > happily change the mode of symlinks.
> > Ah, I've seen this in the past. Thanks a lot for reminding me.
> >=20
> > > The current intended behaviour is to always return EOPNOTSUPP, and AF=
AIK
> > > there is no plan to re-enable the changing of symlink modes. EOPNOTSU=
PP
> > > was chosen because that's what filesystems were already returning.
> > > (While this is a little confusing, VFS syscalls return EINVAL for an
> > > unsupported flag, not EOPNOTSUPP.)
> > > The benefit of an AT_SYMLINK_NOFOLLOW flag is not just to to allow a
> > > syscall to operate on symlinks, it also allows programs to safely
> > > operate on path components without worrying about symlinks being
> > > followed (this is relevant for container runtimes, where we are
> > > operating on untrusted filesystem roots -- though in the case of
> > > fchmodat2(2) you would probably just use AT_EMPTY_PATH in practice). =
So
> > > an error here is actually what you want as a program that uses
> > > AT_SYMLINK_NOFOLLOW (since the actual operation is intentionally not
> > > supported by filesystems).
>
> Thanks for the explanation. I also have a question around this topic:
> AT_SYMLINK_NOFOLLOW has been added in order to avoid symlinks being
> followed. [...] Also, is it an unsupported feature only on certain
> filesystems?

AFAIK it was never supposed to be supported by filesystems, there was a
series of bugs that lead to it working by accident and that has now been
fixed. It's blocked by the VFS now, so no filesystems support it.

EOPNOTSUPP was chosen as the error code to avoid breaking userspace
because that was the error code used by glibc as well as some
filesystems. I wouldn't interpret this EOPNOTSUPP as meaning "we plan to
add support for this in the future" nor "only some filesystems don't
support this" -- I would just treat it if it were ELOOP.

> But if filesystems are not supporting it, why do we have this feature?

The problem being solved is the same as O_NOFOLLOW. Before O_PATH,
O_NOFOLLOW would always return an error -- this was what you wanted
because you wanted to open a file without following (trailing) symlinks.
If the final component was a symlink you wanted to get an error rather
than following the symlink and opening some other file (this could be a
particular problem if you are dealing with an extracted rootfs tree --
symlinks could escape to the host and you could end up operating on host
files). These kinds of problems crop up a lot when dealing with
privileged tools that need to deal with untrusted directory trees. (If
you're interested, I'm working on a path resolution library that makes
use of these kinds of tricks[1].)

That being said, O_NOFOLLOW/AT_SYMLINK_NOFOLLOW doesn't help you with
symlink path components. That's what openat2(RESOLVE_IN_ROOT) or
openat2(RESOLVE_NO_SYMLINKS) is for. So in most cases, I suspect people
are going to want to use openat2+fchmodat2(AT_EMPTY_PATH) instead but
AT_SYMLINK_NOFOLLOW does still make sense for this kind of syscall.

Modern VFS syscalls are designed to make sure that it's possible for you
to either operate on a file descriptor (AT_EMPTY_PATH) or to ensure
trailing symlinks are not followed (AT_SYMLINK_NOFOLLOW). This lets you
make sure that you are never operating on a path that could change
underneath you. With AT_SYMLINK_NOFOLLOW as long as the path doesn't
contain "/" you can safely operate on any path (you just need to first
open the parent directory, either with openat2(RESOLVE_*) or by opening
each component of the path using openat[2,3]).

[1]: https://github.com/openSUSE/libpathrs
[2]: https://github.com/cyphar/filepath-securejoin/blob/v0.3.1/lookup_linux=
=2Ego#L178
[3]: https://github.com/openSUSE/libpathrs/blob/de588611aa9a/src/resolvers/=
opath.rs

> > Thanks a lot for explaining the background!
> >=20
> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/?id=3D5d1f903f75a80daa4dfb3d84e114ec8ecbf29956
> > > > I see a RFC UAPI related patchset [5] which touches include/uapi/li=
nux/fcntl.h,
> > > > but AFAIK it's not related to this problem.
> > > Yeah this is unrelated, that patch is about clarifying how AT_* flags
> > > are allocated, not syscall behaviour.
> > Thanks!
> >=20
> > > > Kind regards,
> > > > Petr
> > @Andrea, I guess we want something like this:
> >=20
> > +++ testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> > @@ -43,9 +43,10 @@ static void test_symbolic_link(void)
> >   	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> >   	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
> > -	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
> > -	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> > -	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
> > +	if (tst_kvercmp(6, 6, 0) >=3D 0) {
> > +		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2, fd_dir, SNAME, 0640,
> > +					 AT_SYMLINK_NOFOLLOW), EOPNOTSUPP);
> > +	}
> >   }
> >   static void test_empty_folder(void)
>=20
> I think it makes more sense to filter out only filesystems which are not
> supporting this feature (see my comment above).
>=20
> Best regards,
> Andrea
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--7ap6ghydj4mtubiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZqyoVwAKCRAol/rSt+lE
b+tHAP9raPpf0TO8xhhsOV/iU6kOYfKOIcG/Gak88BGLdzlH+AD+NsLp0Bflihhl
A5l/JvqxFVL6jgAQe2gQTpQJBL3kxQc=
=1EaM
-----END PGP SIGNATURE-----

--7ap6ghydj4mtubiy--

