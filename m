Return-Path: <linux-kernel+bounces-308849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E2B9662A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749FA1C2220D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12CD1A284A;
	Fri, 30 Aug 2024 13:12:02 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F41509BF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023522; cv=none; b=tDDYEszfla+z4KV0daAOmd0u4TNGuaf/Yzez2IZtGMPbasUmP2zA7NOW87+4Bh7YzdGOx55ee43qF/osGcyRSkm086rLntpPkXeBbtgA6tNUyj39TOr6pyBzRkeAJGvsak1bmBD8xwqtXLsgzyNBMAiWmRIYK/NWNcDFk3Cizds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023522; c=relaxed/simple;
	bh=jbY+RbxbP+UY1wnmJ3NpniC49CW4PAlQsPU6a/z4K1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8BpyakhSBiS2La3JFD3Xn/zh3XMbzUcipAiSqxH9Yl51uJPhg7+99myrwPNUZWnHRpv5Yx8ZEeb97i5cOrgo9KgeS9BKcr3blNDuG8Cl6PriUIdYy8lATpMcKdoACYuayw+8ZOVc2Iz6w6FcgwWzgPPKRVCIQW5seRs9IkzoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sk1PY-000000002P5-33PK;
	Fri, 30 Aug 2024 09:11:32 -0400
Message-ID: <97ba80061354fef89349a70e1cb8eb34dd7730f3.camel@surriel.com>
Subject: Re: [PATCH] mm,tmpfs: consider end of file write in shmem_is_huge
From: Rik van Riel <riel@surriel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, kernel-team@meta.com, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,  Dave Chinner <dchinner@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 30 Aug 2024 09:11:32 -0400
In-Reply-To: <20240830055244.GD6257@frogsfrogsfrogs>
References: <20240829235415.57374fc3@imladris.surriel.com>
	 <20240830055244.GD6257@frogsfrogsfrogs>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-08-29 at 22:52 -0700, Darrick J. Wong wrote:
> On Thu, Aug 29, 2024 at 11:54:15PM -0400, Rik van Riel wrote:
> >=20
> > @@ -196,7 +196,7 @@ xfile_store(
> > =C2=A0		unsigned int	len;
> > =C2=A0		unsigned int	offset;
> > =C2=A0
> > -		if (shmem_get_folio(inode, pos >> PAGE_SHIFT,
> > &folio,
> > +		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, 0,
> > &folio,
>=20
> Technically speaking, the "0" here could be (pos + count), though for
> the current xfile users this isn't likely to make much difference
> because online fsck's index building only appends small amounts of
> data
> (i.e. not larger than a PAGE_SIZE) at a time.
>=20
> > =C2=A0				SGP_CACHE) < 0)

With SGP_CACHE, won't shmem_get_folio simply refuse to allocate
any pages beyond the end of the inode?

        if (sgp <=3D SGP_CACHE &&
            ((loff_t)index << PAGE_SHIFT) >=3D i_size_read(inode))
                return -EINVAL;

> > =C2=A0			break;
> > =C2=A0		if (filemap_check_wb_err(inode->i_mapping, 0)) {
> > @@ -267,7 +267,7 @@ xfile_get_folio(
> > =C2=A0		i_size_write(inode, pos + len);
> > =C2=A0
> > =C2=A0	pflags =3D memalloc_nofs_save();
> > -	error =3D shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
> > +	error =3D shmem_get_folio(inode, pos >> PAGE_SHIFT, 0,
> > &folio,
>=20
> This 0 could be pos + len, since the only caller is xfarray_sort,
> which
> runs much faster when it can heapsort a large folio's worth of data
> at a
> time.
>=20
> > =C2=A0			(flags & XFILE_ALLOC) ? SGP_CACHE :
> > SGP_READ);

The same applies here.

> > =C2=A0	memalloc_nofs_restore(pflags);
> > =C2=A0	if (error)
> > diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
> > index 9bb2d24de709..07bebbfb16ee 100644
> > --- a/fs/xfs/xfs_buf_mem.c
> > +++ b/fs/xfs/xfs_buf_mem.c
> > @@ -149,7 +149,7 @@ xmbuf_map_page(
> > =C2=A0		return -ENOMEM;
> > =C2=A0	}
> > =C2=A0
> > -	error =3D shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
> > SGP_CACHE);
> > +	error =3D shmem_get_folio(inode, pos >> PAGE_SHIFT, 0,
> > &folio, SGP_CACHE);
>=20
> The "0" here could be (pos + BBTOB(bp->length)) since we're likely
> going
> to write there soon.=C2=A0 Granted, no current user of xmbufs actually
> uses a
> blocksize larger than PAGE_SIZE, but in theory we could someday turn
> that on.
>=20
> Everything below here looks sane enough to me, but I'm not that much
> of
> an expert on mm/ things outside of the pagecache and shmem.c.

... and here.

XFS is no using an SGP flag that allows shmem_get_folio to allocate
a page beyond the end of the i_size.

--=20
All Rights Reversed.

