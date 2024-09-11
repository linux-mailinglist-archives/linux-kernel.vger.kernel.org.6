Return-Path: <linux-kernel+bounces-324152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9BB97487D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1AB28979F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F2838397;
	Wed, 11 Sep 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BClD5gue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463E1282EE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726024385; cv=none; b=suzivNGA8zGEhnyt0XQ+FGp+rXZWNtvJGcIpP5vn7hAaV1YDQDZ1Q3bfgB8c2ayTUSmF927+9vy2g9Avm15IOFWiYDjZObO9FhGcTfRf47sNbJgZtaWmkqS42sqrEes1P5HG08Z/EyDCPhqKRk8aDxQ6SExJWsccTbTOt2g7ldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726024385; c=relaxed/simple;
	bh=r/VWMEcY649DSLSlsVg09/ckGhtXpJQl4tLw6/IicS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP95xLhKwLI8GxpozJ6xrxspMi8lc8z6VQG73rRvjLcO2hMR3loq04z+Rkz3OD0xQrJ7QeJDj1SrLa72xfzWNTGBSoV8Y41b0JlhGx7ZFGQnWMA+MrPjs//RpeZtokG6rvCEkoWzPYz5qTv4X52ng0frQq1qvn9vEoEM3lVpljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BClD5gue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C87C4CECD;
	Wed, 11 Sep 2024 03:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726024385;
	bh=r/VWMEcY649DSLSlsVg09/ckGhtXpJQl4tLw6/IicS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BClD5guezY3ZzSEZGN/fqRQZCXm/azwSJV60BYnhoyWy7ouXyaFIM2qrnLIGINXNc
	 d2SQ6lCoT6SkEMrJAxHFNol6cqAVw1IYHOmTsKPiZBn2zWlmVjqiNE/RRsakCnBIYx
	 6XGtlObO4iTucHtnsrpCy69/6jL4pWPsiBuri5x4Vm/4DK7F5gv0Rlz7pIPr7r/qUb
	 2vNqdhVcvnrdkvlpIFmcr815gt+aFrNLnxiSstVN7o/UXhnxcVNKmDUXoyROjUJFpg
	 6104nKvoslXoEw8YQdEGU6NXvbJ3q426JqlCcqGNrCyAMtP+HI/gIfGj+idSADlzAi
	 eB1eBXV4OCR2g==
Date: Tue, 10 Sep 2024 20:13:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to tag STATX_DIOALIGN only if inode
 support dio
Message-ID: <20240911031303.GA50432@sol.localdomain>
References: <20240910125753.80502-1-chao@kernel.org>
 <20240910170600.GB2642@sol.localdomain>
 <44f5168e-3931-438e-8a85-3866f797f9b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f5168e-3931-438e-8a85-3866f797f9b6@kernel.org>

On Wed, Sep 11, 2024 at 11:06:22AM +0800, Chao Yu wrote:
> On 2024/9/11 1:06, Eric Biggers wrote:
> > On Tue, Sep 10, 2024 at 08:57:53PM +0800, Chao Yu via Linux-f2fs-devel wrote:
> > > After commit 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
> > > inode"), f2fs starts to force using buffered IO on inline_data inode.
> > > 
> > > And also, it will cause f2fs_getattr() returning invalid zeroed value on
> > > .dio_mem_align and .dio_offset_align fields, however, STATX_DIOALIGN flag
> > > was been tagged. User may use zeroed .stx_dio_offset_align value
> > > since STATX_DIOALIGN was been tagged, then it causes a deadloop during
> > > generic/465 test due to below logic:
> > > 
> > > align=stx_dio_offset_align(it equals to zero)
> > > page_size=4096
> > > while [ $align -le $page_size ]; do
> > > 	echo "$AIO_TEST -a $align -d $testfile.$align" >> $seqres.full
> > > 	$AIO_TEST -a $align -d $testfile.$align 2>&1 | tee -a $seqres.full
> > > 	align=$((align * 2))
> > > done
> > > 
> > > Quoted from description of statx manual:
> > > 
> > > " If  a  filesystem  does  not support a field or if it has an
> > >    unrepresentable value (for instance, a file with an exotic type),
> > >    then the mask bit corresponding to that field will be cleared in
> > >    stx_mask even if the user asked for it and a dummy value will be
> > >    filled in for compatibility purposes if one is available (e.g.,
> > >    a dummy UID and GID may be specified to mount under some
> > >    circumstances)."
> > > 
> > > We should not set STATX_DIOALIGN flag in kstat.stx_mask if inode
> > > does not support DIO, so that it can indicate related fields contain
> > > dummy value, and avoid following incorrect use of them.
> > > 
> > > Fixes: c8c02272a9f7 ("f2fs: support STATX_DIOALIGN")
> > 
> > When claiming to be Fixing a commit, please make sure to Cc the author of that
> > commit.
> 
> No problem, will make sure they were Cced.
> 
> > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/file.c | 11 ++++-------
> > >   1 file changed, 4 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 99903eafa7fe..f0b8b77e93ba 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -906,14 +906,11 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
> > >   	 * f2fs sometimes supports DIO reads but not DIO writes.  STATX_DIOALIGN
> > >   	 * cannot represent that, so in that case we report no DIO support.
> > >   	 */
> > > -	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> > > -		unsigned int bsize = i_blocksize(inode);
> > > -
> > > +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode) &&
> > > +				!f2fs_force_buffered_io(inode, WRITE)) {
> > > +		stat->dio_mem_align = F2FS_BLKSIZE;
> > > +		stat->dio_offset_align = F2FS_BLKSIZE;
> > >   		stat->result_mask |= STATX_DIOALIGN;
> > > -		if (!f2fs_force_buffered_io(inode, WRITE)) {
> > > -			stat->dio_mem_align = bsize;
> > > -			stat->dio_offset_align = bsize;
> > > -		}
> > >   	}
> > >   	flags = fi->i_flags;
> > 
> > No, this patch is wrong and the existing code is correct.  The cases are:
> 
> Yes, you're right, thanks for pointing out this!
> 
> > 
> >      STATX_DIOALIGN set and stx_dio_*_align nonzero:
> >          File supports DIO.
> > 
> >      STATX_DIOALIGN set and stx_dio_*_align zero:
> >          File doesn't support DIO.
> > 
> >      STATX_DIOALIGN unset:
> >          Filesystem doesn't support STATX_DIOALIGN, so it's unknown whether the
> >          file supports DIO or not.
> 
> Above description is clear to me.
> 
> > 
> > Please see the statx(2) manual page which explains this too.
> 
> However, below manual seems not very clear about explaining what does it
> mean about STATX_DIOALIGN is set or not? At least not so clear like above
> description.
> 

It just works the same way that the other statx mask bits work.  See the
following paragraph:

    If a filesystem does not support a field or if it has an unrepresentable
    value (for instance, a file with an exotic type), then the mask bit
    corresponding to that field will be cleared in stx_mask even if the user
    asked for it and a dummy value will be filled in for compatibility purposes
    if one is available (e.g., a dummy UID and GID may be specified to mount
    under some circumstances).

It might be worth an explicit note in the documentation for stx_dio_mem_align,
but I considered it to be covered by the above.

- Eric

