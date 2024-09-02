Return-Path: <linux-kernel+bounces-310775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27516968119
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491931C203BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7F176FD2;
	Mon,  2 Sep 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="gcFEFHtz"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901B182D2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263847; cv=none; b=R97OoujlIb006YytJ7iImQHGpcOJjPJLKCtRivOFr35XD0WHi9yTh7Chh0S1OaNvLbiAVrvZwaBZbjwXIDp/4/PlzeMXZa7UR/wbj0ycjRXA1v3bXZFND1ApLJ3trBGsX5dub9blJVXQZ9FUz5t+a03ozRXQ7er3rYK2keyw5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263847; c=relaxed/simple;
	bh=k4Hy8FC0VaK07pAeOJgQG/g7DZWasyp68I4VcA0Zyxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWi4aaJ/1JGqu0bnOjS9mdpNpU7xSfFi3HmqTJyQc9n/bwXdhkSWH7PCFwXnL0sBhTXra0Vz65wtIeHjl0DXHdzfKZACZHGO2jYMxBXPR6b0wIzMCdRjBcbHJfQzY+ahIcGnxId08cwgWERVIjSHtYdmUJpFNEMzwhoVBlCkl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=gcFEFHtz; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B15B69840;
	Mon,  2 Sep 2024 03:57:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725263843; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vFg7frQZFwf8sr2E7jIEdq9FvqRSKuqpQbVH+tIiz2E=;
	b=gcFEFHtzUx81lI4ANpjib9RaxtJt76JdX8yt+3bJ2QQrHaFLMlvwFxQkvchSdZ9eljFAZi
	cKH1hufcOstX1zvSPqc3k0pA71xYQi60FtIMqwoN6pKBeOG1xJdXyJFHN6s3b9yr9v2Moo
	q/CU6zhjVdma+k7+fEITRGoFNr0blM/oYS3xMqV248euzNxlsmGgKfWokouXUG7YvU8wjA
	sAFVaTraW0mig5xnCURLydegWJwUoyqDE1c19RPW5bDY/QHWpxmqpYMQT3dFmuv3oon7dT
	NqDtFuMrJTxSAw6fbvZUJ7/A5Cb6Dvrg9s40dyPT5Tc35QTrCnBX3/sRBNCd9g==
Date: Mon, 2 Sep 2024 15:57:17 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] erofs: refactor read_inode calling convention
Message-ID: <kcqmmpzzd3zr244dceocn7gbnvltrlyhqbku5aj52nnimoxzfu@eyj26z254w4b>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
 <20240902070047.384952-3-toolmanp@tlmp.cc>
 <1067fd19-495e-40d7-9acf-bf2735ca89fb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067fd19-495e-40d7-9acf-bf2735ca89fb@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 02, 2024 at 03:18:54PM GMT, Gao Xiang wrote:
> 
> 
> > +	m_pofs += vi->xattr_isize;
> > +	/* inline symlink data shouldn't cross block boundary */
> > +	if (m_pofs + inode->i_size > bsz) {
> > +		erofs_err(inode->i_sb,
> > +			  "inline data cross block boundary @ nid %llu",
> > +			  vi->nid);
> 
> Since you move the code block of erofs_fill_symlink,
> 
> I think it'd be better to update this statement to
> 		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
> 			  vi->nid);
> 
> As I mentioned, the print message doesn't have line limitation.

I just simply cannot tell the difference here. But since you put it
here, I will change this in the next version.

> > +		DBG_BUGON(1);
> > +		return -EFSCORRUPTED;
> > +	}
> > +
> > +	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> > +
> > +	if (!lnk)
> > +		return -ENOMEM;
> 
> As I mentioned in the previous patch, so it could become
> 	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> 	return inode->i_link ? 0 : -ENOMEM;
> 

Looks good to me.

> > +		if(S_ISLNK(inode->i_mode)) {
> > +			err = erofs_fill_symlink(inode, kaddr, ofs);
> > +			if(err)
> 
> missing a blank:
> 			if (err)
> 
> 

Fixed here.
> > +				goto err_out;
> > +		}
> >   		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
> >   		break;
> >   	case S_IFCHR:
> > @@ -165,63 +202,29 @@ static void *erofs_read_inode(struct erofs_buf *buf,
> >   		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
> >   	else
> >   		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
> > -	return kaddr;
> > +
> > +	erofs_put_metabuf(&buf);
> > +	return 0;
> >   err_out:
> 
> I wonder this can be unified too as:
> 
> err_out:
> 	DBG_BUGON(err);
> 	kfree(copied);			I'm not sure if it's really needed now.
I agree. copied doesn't need to be freed anymore as it's already freed when error happens in the first switch block of inode format part. 
Will be fixed in the next version.
> 	erofs_put_metabuf(&buf);
> 	return err;
> 
> >   	DBG_BUGON(1);
> >   	kfree(copied);
> > -	erofs_put_metabuf(buf);
> > -	return ERR_PTR(err);
> > +	erofs_put_metabuf(&buf);
> > +	return err;
> >   }
> > -static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> > -			      unsigned int m_pofs)
> > -{
> > -	struct erofs_inode *vi = EROFS_I(inode);
> > -	unsigned int bsz = i_blocksize(inode);
> > -	char *lnk;
> > -
> > -	/* if it cannot be handled with fast symlink scheme */
> > -	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> > -	    inode->i_size >= bsz || inode->i_size < 0) {
> > -		inode->i_op = &erofs_symlink_iops;
> > -		return 0;
> > -	}
> > -
> > -	m_pofs += vi->xattr_isize;
> > -	/* inline symlink data shouldn't cross block boundary */
> > -	if (m_pofs + inode->i_size > bsz) {
> > -		erofs_err(inode->i_sb,
> > -			  "inline data cross block boundary @ nid %llu",
> > -			  vi->nid);
> > -		DBG_BUGON(1);
> > -		return -EFSCORRUPTED;
> > -	}
> > -
> > -	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> > -
> > -	if (!lnk)
> > -		return -ENOMEM;
> > -
> > -	inode->i_link = lnk;
> > -	inode->i_op = &erofs_fast_symlink_iops;
> > -	return 0;
> > -}
> >   static int erofs_fill_inode(struct inode *inode)
> >   {
> >   	struct erofs_inode *vi = EROFS_I(inode);
> > -	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> > -	void *kaddr;
> > -	unsigned int ofs;
> >   	int err = 0;
> >   	trace_erofs_fill_inode(inode);
> >   	/* read inode base data from disk */
> > -	kaddr = erofs_read_inode(&buf, inode, &ofs);
> > -	if (IS_ERR(kaddr))
> > -		return PTR_ERR(kaddr);
> > +	err = erofs_read_inode(inode);
> > +	if (err)
> > +		goto out_unlock;
> 
> out_unlock can be avoided too, just
> 		return err;
> 
> >   	/* setup the new inode */
> >   	switch (inode->i_mode & S_IFMT) {
> > @@ -238,9 +241,11 @@ static int erofs_fill_inode(struct inode *inode)
> >   		inode_nohighmem(inode);
> >   		break;
> >   	case S_IFLNK:
> > -		err = erofs_fill_symlink(inode, kaddr, ofs);
> > -		if (err)
> > -			goto out_unlock;
> > +		if (inode->i_link)
> > +			inode->i_op = &erofs_fast_symlink_iops;
> > +		else
> > +			inode->i_op = &erofs_symlink_iops;
> > +
> >   		inode_nohighmem(inode);
> >   		break;
> >   	case S_IFCHR:
> > @@ -273,7 +278,6 @@ static int erofs_fill_inode(struct inode *inode)
> >   #endif
> >   	}
> >   out_unlock:
> 
> Remove this.

I'm not sure whether we need to remove this becasue device inodes do not
need other operation bindings below and still needs the out_unlock to be
early out. Another solution is to use the early return but i deem the
goto solution is clearer.

> 
> Thanks,
> Gao Xiang

Best Regards,
Yiyang Wu

