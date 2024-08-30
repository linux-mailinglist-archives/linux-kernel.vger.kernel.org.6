Return-Path: <linux-kernel+bounces-309563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD3966CD5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2890F1C225B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7318DF77;
	Fri, 30 Aug 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUwKCxWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911716D4E8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060094; cv=none; b=qGejVc1iUAoR3/LZq0OJyexFBo0Ze9eJ4xqEZvFp1KBYBLKt5y5Y43joP3LhP1O3r2DUSqoHqO8aJWZu0rrxyPWvMF9ymG+i1fDq1O0s9K5o+lh5PpZa8d2n8G9J4+w996l7jOKe/okngnqFpBip39bJ3/O6MBsBg0BSxHvj/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060094; c=relaxed/simple;
	bh=5kQ5XAoyoKFTewRRACml0pmLhqwmlzoDXNmRegMVqYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/Up4c44bvqHwxZiz3Fy62C+4sJTqlGvIX+dBnVjupfcIqeBGG3Q2i0qG5qCpIP7UnsPJhUD3Y4yZFz5t8QCLrkJ+qh0xy0iqmI2Z6nRxGa3jHyC9T7tEd62WIiQk2qrcOyfQmvzPJ7r3ajfBFFbV7YyWXaNk2NNsyDXBtAQt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUwKCxWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B72BC4CEC2;
	Fri, 30 Aug 2024 23:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725060093;
	bh=5kQ5XAoyoKFTewRRACml0pmLhqwmlzoDXNmRegMVqYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUwKCxWr00OtFL5EyPVrZ+OEr9fAJiP2GLXqwBc44RH3A60QVfmsyvbsbjIzTlpz2
	 lDg12/LbYrtbM/a/zli50B2dj64iVWMZc5oTOUj+vqtcmiWzC01D2qMHT2BQsl97I4
	 RRYajFDqySVHC9jU7QDMl1wyuxUryv6lbTCt1HS1j5W0tJIbefOIw+V2rzCp+cg6Un
	 NVDnNk7OknJaSdxONiAkLXvhKmzkZWDjTvk9EtWu+eyqlKVluCtY1OovQOQFLbuVzh
	 2vgchdbJxMg8DnC/EwG+RPedwfOWELvxm4UFrjt1byj+229QlRNLTfuG2AgC48eTYV
	 k+d8bQrNhZaFQ==
Date: Fri, 30 Aug 2024 16:21:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Hugh Dickins <hughd@google.com>, kernel-team@meta.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm,tmpfs: consider end of file write in shmem_is_huge
Message-ID: <20240830232132.GG6257@frogsfrogsfrogs>
References: <20240829235415.57374fc3@imladris.surriel.com>
 <20240830055244.GD6257@frogsfrogsfrogs>
 <97ba80061354fef89349a70e1cb8eb34dd7730f3.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97ba80061354fef89349a70e1cb8eb34dd7730f3.camel@surriel.com>

On Fri, Aug 30, 2024 at 09:11:32AM -0400, Rik van Riel wrote:
> On Thu, 2024-08-29 at 22:52 -0700, Darrick J. Wong wrote:
> > On Thu, Aug 29, 2024 at 11:54:15PM -0400, Rik van Riel wrote:
> > > 
> > > @@ -196,7 +196,7 @@ xfile_store(
> > >  		unsigned int	len;
> > >  		unsigned int	offset;
> > >  
> > > -		if (shmem_get_folio(inode, pos >> PAGE_SHIFT,
> > > &folio,
> > > +		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, 0,
> > > &folio,
> > 
> > Technically speaking, the "0" here could be (pos + count), though for
> > the current xfile users this isn't likely to make much difference
> > because online fsck's index building only appends small amounts of
> > data
> > (i.e. not larger than a PAGE_SIZE) at a time.
> > 
> > >  				SGP_CACHE) < 0)
> 
> With SGP_CACHE, won't shmem_get_folio simply refuse to allocate
> any pages beyond the end of the inode?

Yes, though we're careful to i_size_write appropriate beforehand such
that @index is always within EOF.

--D

>         if (sgp <= SGP_CACHE &&
>             ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
>                 return -EINVAL;
> 
> > >  			break;
> > >  		if (filemap_check_wb_err(inode->i_mapping, 0)) {
> > > @@ -267,7 +267,7 @@ xfile_get_folio(
> > >  		i_size_write(inode, pos + len);
> > >  
> > >  	pflags = memalloc_nofs_save();
> > > -	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
> > > +	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, 0,
> > > &folio,
> > 
> > This 0 could be pos + len, since the only caller is xfarray_sort,
> > which
> > runs much faster when it can heapsort a large folio's worth of data
> > at a
> > time.
> > 
> > >  			(flags & XFILE_ALLOC) ? SGP_CACHE :
> > > SGP_READ);
> 
> The same applies here.
> 
> > >  	memalloc_nofs_restore(pflags);
> > >  	if (error)
> > > diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
> > > index 9bb2d24de709..07bebbfb16ee 100644
> > > --- a/fs/xfs/xfs_buf_mem.c
> > > +++ b/fs/xfs/xfs_buf_mem.c
> > > @@ -149,7 +149,7 @@ xmbuf_map_page(
> > >  		return -ENOMEM;
> > >  	}
> > >  
> > > -	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
> > > SGP_CACHE);
> > > +	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, 0,
> > > &folio, SGP_CACHE);
> > 
> > The "0" here could be (pos + BBTOB(bp->length)) since we're likely
> > going
> > to write there soon.  Granted, no current user of xmbufs actually
> > uses a
> > blocksize larger than PAGE_SIZE, but in theory we could someday turn
> > that on.
> > 
> > Everything below here looks sane enough to me, but I'm not that much
> > of
> > an expert on mm/ things outside of the pagecache and shmem.c.
> 
> ... and here.
> 
> XFS is no using an SGP flag that allows shmem_get_folio to allocate
> a page beyond the end of the i_size.
> 
> -- 
> All Rights Reversed.

