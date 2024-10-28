Return-Path: <linux-kernel+bounces-385841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3605A9B3C76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADE11F22B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93871E1049;
	Mon, 28 Oct 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBUmn9j9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108418FC75
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149541; cv=none; b=WjPL+y1bGoyAOI6MrOd6WLN0VAFrLErPnUi70Ylyem9DsokOeRh5kMUu6krz20tlyak8KldvX0KTPUu//PceA1wPk+4QspOvB+HizOoDq2e4J/uUmo/aQFEVLIYUlZBUOt3cANZ/ILrWyY06EF7RM6ZIIXARrsDh8866e92tDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149541; c=relaxed/simple;
	bh=jSREJ7Vl/o+COTD1EEPwv67TR+VkaOCYrWUpvL9ukks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncjIcER0W7ulYba2JTpQ/W/ljcf/3VPMI/X9vYNMCMeJr6KMkbSV7lN/iNe6OdJMuPtAfPVbKZs6rfhK0heJ04tunE+U159nsJcaiABSmY5KgRetmcayKvg+CHaSdqNUeJzPkoq0Nhz3/jwggZ1oa30P5zsOn0er3mN0xf9WLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBUmn9j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3440AC4CEC3;
	Mon, 28 Oct 2024 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730149538;
	bh=jSREJ7Vl/o+COTD1EEPwv67TR+VkaOCYrWUpvL9ukks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBUmn9j9Y+PRaVYQCasQncMKxmL+hWaAtwv+egQ0g6kcZ6hFFjEFIhVHx9CFoAUt3
	 EigaqFyJCHORXAatM5pOdygAa+d80mA3Pdeid45b8co8LnBoUM3DuleeHRb8yRsTgK
	 SZG++pY1owDVpgA3wRxYnsayqJbkPD8IJigeXEEgnWRWUxdRvxbUElMtYoMdJddQcg
	 zuF3h7tgxKpMwMxGPk0Dx9Fs0SgSxoFqs2uUZ3a8ZP2F9JJjUVmJQIylZY/g9TJOaQ
	 omHKQ7BwvoGb8jnYElL0AqhF0K//6gFAICjcXmpOGKfSn+pFa64lslrKkaMAB4FI+o
	 LuolpX99WNJxQ==
Date: Mon, 28 Oct 2024 21:05:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <91d9f81c-b971-4764-8f21-4011023628c0@sirena.org.uk>
References: <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk>
 <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <a1ffccb8-3f53-4486-a250-282ddc7054dd@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="30okYTcXzfb7tVuJ"
Content-Disposition: inline
In-Reply-To: <a1ffccb8-3f53-4486-a250-282ddc7054dd@lucifer.local>
X-Cookie: Remember the... the... uhh.....


--30okYTcXzfb7tVuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 08:43:08PM +0000, Lorenzo Stoakes wrote:

> +/*
> + * We check VMA flag validity early in the mmap() process, however this =
can
> + * cause issues for arm64 when using MTE, which requires that it be used=
 with
> + * shmem and in this instance and only then is VM_MTE_ALLOWED set permit=
ting
> + * this operation.
> + *
> + * To avoid having to tear down a partially complete mapping we do this =
ahead of
> + * time.
> + */
> +static vm_flags_t arch_adjust_flags(struct file *file, vm_flags_t vm_fla=
gs)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64))
> +		return vm_flags;
> +
> +	if (shmem_file(file))
> +		return vm_flags | VM_MTE_ALLOWED;
> +}

This doesn't build:

mm/mmap.c:1595:1: error: non-void function does not return a value in all c=
ontrol paths [-Werror,-Wreturn-type]
 1595 | }
      | ^

with that corrected:

diff --git a/mm/mmap.c b/mm/mmap.c
index d1ab4301c671..cea051c5fef3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1587,11 +1587,10 @@ static unsigned long __mmap_region(struct file *fil=
e, unsigned long addr,
  */
 static vm_flags_t arch_adjust_flags(struct file *file, vm_flags_t vm_flags)
 {
-	if (!IS_ENABLED(CONFIG_ARM64))
-		return vm_flags;
+	if (IS_ENABLED(CONFIG_ARM64) && shmem_file(file))
+		vm_flags |=3D VM_MTE_ALLOWED;
=20
-	if (shmem_file(file))
-		return vm_flags | VM_MTE_ALLOWED;
+	return vm_flags;
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,

the relevant tests all pass for me.

Tested-by: Mark Brown <broonie@kernel.org>

I'd have expected arch_adjust_flags() to be something overridden by the
arch headers (probably like arch_calc_vm_prot_bits() and friends), but
if this is juat a short lived fix it's probably not worth the trouble.

--30okYTcXzfb7tVuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcf/JwACgkQJNaLcl1U
h9Cc7Af/aNeZKhCpi9WJcdYq9a3seoFWXO0Wh8lqOYlCIQBfxm+Y6ccCbS6kLiGc
f8sGnyhIrPFULEy32UIKW/+4j3V9hrOiSLzqxwZPhFk7jiiXyeUiB2+ysFlwQBQS
oM3cpTjdRGJh0KbskC9tV6oSr7lI2lZDQen5Uca/ZLIY92wT2cJpyXl5967J2T8r
7gH7ft7wtwHPc4BLdaVinER6exeKFc8ulT4DvgkLTEoWIbKY1cvPGSDLKgzp8P/Y
1z591P9PPF/CeSW2pyv40Oz+o0ywyAQAYYpRypIV8ClNn+y1JUd3wGPiNSYQtt7G
j2jMvOVNQ0ArYO32KNoj714a1Uz1ZA==
=pBTn
-----END PGP SIGNATURE-----

--30okYTcXzfb7tVuJ--

