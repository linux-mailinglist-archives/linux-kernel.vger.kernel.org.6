Return-Path: <linux-kernel+bounces-385830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA189B3C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4918F1F23DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD321E0DBA;
	Mon, 28 Oct 2024 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzBf1/SJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB01E04B3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148685; cv=none; b=XZBFiIEZ6rR7TtV+oBidsDmNEC1h3hZloyfCpzgLKSiIVcW58rb86nASpwNODm8N5sv+BT5atObbl85d6MoS/yNMe6w4Sf/oKRb4m89Oc6/DJ42oWLDHRdh9AyewaDC7LToixTPy+JCKsggR+WZh2XJ1pK2HF268lbmtlYk1NDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148685; c=relaxed/simple;
	bh=YVImwvRfK5SkCR0Ri+wW4EXpx6zRqJl2vuY6cmlakVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA4NMb6e1fhVDEWdn7ZfBC4bfD0br6ZEQD67tjoWTV1mYBFA3G1SFrtVFMpJVngu+G/QdEjrwTux0x6w/2Femw7OIGDCpZKU93GuGEqztAqq6IR5dEaOgYF2othVwRKy4V+ATaLliLZYRC8tPM8l97y1OwS/AvTZvRmYlTizaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzBf1/SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BFBC4CEE7;
	Mon, 28 Oct 2024 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730148685;
	bh=YVImwvRfK5SkCR0Ri+wW4EXpx6zRqJl2vuY6cmlakVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzBf1/SJXyeqwRAdwQRA5eLFwrmd+2xOAyN2y+115dwiC7KaEjKok+w6qdFBnnJ9e
	 wEPiii/iF6oS9zRIymChTAi0YQ6owStm5c4K35txnWSoZpBht8uty2CnLxWUlUTmpK
	 wFDDqKDnwzPy7aPCkhYw1Q2ijJQ/UoPJg9BzTAZUAnvf+NOnyNrTPgW3j2VjdjYTg8
	 0J0XBvD5qXF96x7F5u6G+YxotYCj2NGtaNliZnIdAdYyd2+ZEeWYQ0fV9lzR2nYsMZ
	 tZzGxZwFgtcdFoh38kLOrOTqEuSZckUL3Qm5aKc6+CtIXmCrolMHSQwu+6DYRSY/TQ
	 iORK8RDRSd8SA==
Date: Mon, 28 Oct 2024 20:51:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <0618af23-dca7-40b9-a083-47de9fcd7e50@sirena.org.uk>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HPJWBhFva0ZUDklg"
Content-Disposition: inline
In-Reply-To: <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
X-Cookie: Remember the... the... uhh.....


--HPJWBhFva0ZUDklg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2024 at 06:57:25PM +0000, Lorenzo Stoakes wrote:
> On Mon, Oct 28, 2024 at 06:29:36PM +0000, Mark Brown wrote:

> > any meaingful detail.  There's nothing particularly instructive in the
> > test logs, just plain reports that the tests failed:

> On these memory allocation failures, could you tell me what errno is? Could you
> check dmesg for anything strange?

Looks like this is mostly figured out already but JFTR:

As I said in the report there's nothing in the logs that I noticed,
anything there is that I've missed should be in the linked logs.  The
errnos I'm seeing are all:

# mmap(): Invalid argument (22)

> >   # # FAIL: mmap allocation

> Interesting that it MAP_FAIL's though. This could be arch_validate_flags() being
> moved around.

> Could you do me a further favour then and try a kernel at this commit with:

> 	/* Allow architectures to sanity-check the vm_flags. */
> 	if (!arch_validate_flags(vm_flags))
> 		return -EINVAL;

> In mmap_region() commented out?

Unsurprisingly given the above and the rest of the thread commenting out
that check causes the affected tests to pass, I didn't check for any
additional impacts.

--HPJWBhFva0ZUDklg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcf+UYACgkQJNaLcl1U
h9CZHQf9FUhFRBSQGkNvWmC10WNDKbe/eWlGst9t5uiegBC++Eao7ztSSeFz/jHE
FkqU4UEL8vgXe3qXhgI9JJD1YqU6g3lWuQPqmMR6g7spS8HDDAvcngWQG7fkZfMj
iabxxefEINHDHC0tQhqXOiPfnAdXKu+q7tCOBbLpx82hkVOybKbJI+Y0lbk+QrQZ
cPXneploajNGet5UF84W8ph/zc9jbyCDAh8zrR4tsalEHhAbyKf52n7Q5GCnr5hf
HSCguShWK5nzbi0Q3ejHEJe0h7G0A28EC1m8RFqGS3YN8VI+HxWOwQUuFXpdxh1H
SmC+WOXm/4ZelGFwPz3DNLXqvDoJYA==
=2rTT
-----END PGP SIGNATURE-----

--HPJWBhFva0ZUDklg--

