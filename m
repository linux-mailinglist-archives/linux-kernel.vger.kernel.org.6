Return-Path: <linux-kernel+bounces-344446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5698A9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756342840BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C49192D91;
	Mon, 30 Sep 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="hrWQmKCf"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6D192D63
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713514; cv=none; b=KQ/iypsINKhQHAOXiUpTBbM1fgnXEQCXRCZHFj35LK24Wfw+e5xSZ5xo3JTzVEzL/mGE1s02oqgcsLLnN4w26cDpKdu5OSXMgNYASR6/LjRUgZS/Hy3w1fa8WasUp5nSaYVqy+fy7K3ppmPoXn6AvXgelpIlLeQUGLxfFcB1axw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713514; c=relaxed/simple;
	bh=+2MCILDC1zpNpVBwS/6W6iEVW1NVvpynbeDUB70j9vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6nStav9jgLaxlddLdxSGDolFK785eLrKL3m4E7s9g/OWDWlkGa2WNR8mhI8Hucfl42dCa7T3Y7WiqbQsJn9w2jPs1P0/RZ84/YY7PWPn8XqAwY/669/BFrbKJaSiyduf3+AM5RaqFfQQvAIP3oPLygNg7Lbcer9ibfK9KxNF5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=hrWQmKCf; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XHRHl3KqFz9sw4;
	Mon, 30 Sep 2024 18:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1727713507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lc5w0jjbjYglTEDp5V0W5PElsrzK57Oidg6NZC/yHAs=;
	b=hrWQmKCfS/ANDShdANmZa2k3jBy7MTGHOk5rPDX1YOrog/Hhjr9UkC8+vb6CEOiRp3nlZV
	bIkruqYUP6mP/pkkpMQBaxeHdXtnT8lqz4MLExmZqSCZhX/7PX8v+dE5FSXwe0PMOTF9YD
	QSxiLB4vnsuJ5ws6JTPGliKDzPXmGiw14dZmD6sDlSYikAKlnXHBIlkE/0gZOAOT5BRpiJ
	FWiwmNRFdzdhIivA536/EKK6Hk18+gDMqmuy0a+eceLwLKDIgzu5p09OUp8pGUVk+uxIXJ
	zfXRmtfw7ctG5tX+Yc7SfuGUXfbLVT7UXl82o0UOo61Czv+6VOwMIwf9DHIikQ==
Date: Mon, 30 Sep 2024 18:24:50 +0200
From: Aleksa Sarai <cyphar@cyphar.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1 fyi] tools include UAPI: Sync linux/fcntl.h copy with
 the kernel sources
Message-ID: <20240930.162315-undated.permit.modular.catnip-THGkg7JTJlP@cyphar.com>
References: <ZvrIKL3cREoRHIQd@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3u3exscggjzaaacw"
Content-Disposition: inline
In-Reply-To: <ZvrIKL3cREoRHIQd@x1>


--3u3exscggjzaaacw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-30, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Picking the changes from:
>=20
>   4356d575ef0f39a3 ("fhandle: expose u64 mount id to name_to_handle_at(2)=
")
>   b4fef22c2fb97fa2 ("uapi: explain how per-syscall AT_* flags should be a=
llocated")
>   820a185896b77814 ("fcntl: add F_CREATED_QUERY")
>=20
> It just moves AT_REMOVEDIR around, and adds a bunch more AT_ for
> renameat2() and name_to_handle_at(). We need to improve this situation,
> as not all AT_ defines are applicable to all fs flags...
>=20
> This adds support for those new AT_ defines, addressing this build
> warning:
>=20
>   diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uap=
i/sound/asound.h

Thanks, feel free to take my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/trace/beauty/fs_at_flags.sh        |  5 ++
>  .../trace/beauty/include/uapi/linux/fcntl.h   | 84 +++++++++++++------
>  2 files changed, 65 insertions(+), 24 deletions(-)
>=20
> diff --git a/tools/perf/trace/beauty/fs_at_flags.sh b/tools/perf/trace/be=
auty/fs_at_flags.sh
> index 456f59addf741062..e3f13f96a27c227c 100755
> --- a/tools/perf/trace/beauty/fs_at_flags.sh
> +++ b/tools/perf/trace/beauty/fs_at_flags.sh
> @@ -13,9 +13,14 @@ printf "static const char *fs_at_flags[] =3D {\n"
>  regex=3D'^[[:space:]]*#[[:space:]]*define[[:space:]]+AT_([^_]+[[:alnum:]=
_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
>  # AT_EACCESS is only meaningful to faccessat, so we will special case it=
 there...
>  # AT_STATX_SYNC_TYPE is not a bit, its a mask of AT_STATX_SYNC_AS_STAT, =
AT_STATX_FORCE_SYNC and AT_STATX_DONT_SYNC
> +# AT_HANDLE_FID and AT_HANDLE_MNT_ID_UNIQUE are reusing values and are v=
alid only for name_to_handle_at()
> +# AT_RENAME_NOREPLACE reuses 0x1 and is valid only for renameat2()
>  grep -E $regex ${linux_fcntl} | \
>  	grep -v AT_EACCESS | \
>  	grep -v AT_STATX_SYNC_TYPE | \
> +	grep -v AT_HANDLE_FID | \
> +	grep -v AT_HANDLE_MNT_ID_UNIQUE | \
> +	grep -v AT_RENAME_NOREPLACE | \
>  	sed -r "s/$regex/\2 \1/g"	| \
>  	xargs printf "\t[ilog2(%s) + 1] =3D \"%s\",\n"
>  printf "};\n"
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/p=
erf/trace/beauty/include/uapi/linux/fcntl.h
> index c0bcc185fa48f852..87e2dec79fea4ef2 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> @@ -16,6 +16,9 @@
> =20
>  #define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
> =20
> +/* Was the file just created? */
> +#define F_CREATED_QUERY	(F_LINUX_SPECIFIC_BASE + 4)
> +
>  /*
>   * Cancel a blocking posix lock; internal use only until we expose an
>   * asynchronous lock api to userspace:
> @@ -87,37 +90,70 @@
>  #define DN_ATTRIB	0x00000020	/* File changed attibutes */
>  #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
> =20
> +#define AT_FDCWD		-100    /* Special value for dirfd used to
> +					   indicate openat should use the
> +					   current working directory. */
> +
> +
> +/* Generic flags for the *at(2) family of syscalls. */
> +
> +/* Reserved for per-syscall flags	0xff. */
> +#define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
> +						   links. */
> +/* Reserved for per-syscall flags	0x200 */
> +#define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
> +#define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
> +						   traversal. */
> +#define AT_EMPTY_PATH			0x1000	/* Allow empty relative
> +						   pathname to operate on dirfd
> +						   directly. */
> +/*
> + * These flags are currently statx(2)-specific, but they could be made g=
eneric
> + * in the future and so they should not be used for other per-syscall fl=
ags.
> + */
> +#define AT_STATX_SYNC_TYPE		0x6000	/* Type of synchronisation required f=
rom statx() */
> +#define AT_STATX_SYNC_AS_STAT		0x0000	/* - Do whatever stat() does */
> +#define AT_STATX_FORCE_SYNC		0x2000	/* - Force the attributes to be sync=
'd with the server */
> +#define AT_STATX_DONT_SYNC		0x4000	/* - Don't sync attributes with the s=
erver */
> +
> +#define AT_RECURSIVE			0x8000	/* Apply to the entire subtree */
> +
>  /*
> - * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EA=
CCESS is
> - * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
> - * unlinkat.  The two functions do completely different things and there=
fore,
> - * the flags can be allowed to overlap.  For example, passing AT_REMOVED=
IR to
> - * faccessat would be undefined behavior and thus treating it equivalent=
 to
> - * AT_EACCESS is valid undefined behavior.
> + * Per-syscall flags for the *at(2) family of syscalls.
> + *
> + * These are flags that are so syscall-specific that a user passing thes=
e flags
> + * to the wrong syscall is so "clearly wrong" that we can safely call su=
ch
> + * usage "undefined behaviour".
> + *
> + * For example, the constants AT_REMOVEDIR and AT_EACCESS have the same =
value.
> + * AT_EACCESS is meaningful only to faccessat, while AT_REMOVEDIR is mea=
ningful
> + * only to unlinkat. The two functions do completely different things and
> + * therefore, the flags can be allowed to overlap. For example, passing
> + * AT_REMOVEDIR to faccessat would be undefined behavior and thus treati=
ng it
> + * equivalent to AT_EACCESS is valid undefined behavior.
> + *
> + * Note for implementers: When picking a new per-syscall AT_* flag, try =
to
> + * reuse already existing flags first. This leaves us with as many unuse=
d bits
> + * as possible, so we can use them for generic bits in the future if nec=
essary.
>   */
> -#define AT_FDCWD		-100    /* Special value used to indicate
> -                                           openat should use the current
> -                                           working directory. */
> -#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
> +
> +/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +#define AT_RENAME_NOREPLACE	0x0001
> +#define AT_RENAME_EXCHANGE	0x0002
> +#define AT_RENAME_WHITEOUT	0x0004
> +
> +/* Flag for faccessat(2). */
>  #define AT_EACCESS		0x200	/* Test access permitted for
>                                             effective IDs, not real IDs. =
 */
> +/* Flag for unlinkat(2). */
>  #define AT_REMOVEDIR		0x200   /* Remove directory instead of
>                                             unlinking file.  */
> -#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
> -#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal =
*/
> -#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
> -
> -#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required fr=
om statx() */
> -#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
> -#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'=
d with the server */
> -#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the se=
rver */
> -
> -#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
> +/* Flags for name_to_handle_at(2). */
> +#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
> +					   object identity and may not be
> +					   usable with open_by_handle_at(2). */
> +#define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID.=
 */
> =20
> -/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits.=
=2E. */
> -#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
> -					compare object identity and may not
> -					be usable to open_by_handle_at(2) */
>  #if defined(__KERNEL__)
>  #define AT_GETATTR_NOSEC	0x80000000
>  #endif
> --=20
> 2.46.0
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3u3exscggjzaaacw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZvrQ0gAKCRAol/rSt+lE
b4xGAP9pDQeLYGBhkgIo1Y94rEhJ8eMjOKdXdl5sClNOjbWMwQD+MIQNQnLPuImD
s/e4FiJYJtInH4EyjvJhBYeNlIQOIA8=
=WkkI
-----END PGP SIGNATURE-----

--3u3exscggjzaaacw--

