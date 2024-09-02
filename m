Return-Path: <linux-kernel+bounces-310759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2B89680E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC3D1C21EDC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF529176FB0;
	Mon,  2 Sep 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="Tgga4mPI"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348415688E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263203; cv=none; b=gnxDFTBdc6G9XADT7QTuGOPtLoPeNFp89OfJ1UMLiTL4zPO/vubQOORBerOLcH2bYP/PzDDT9bkXDNXJE2XNT721mBv4Khc2uj+JfAEo+fvRhNPm5hj4ek5dPxqaanHJ+XMkL547ncruXcHbi3lVZCj/wC2V0PWVCo+psSgdyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263203; c=relaxed/simple;
	bh=WprL5RVcjUhl0ehm3M+XVmwNDO6O/AMbjzvIUFtgQnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9GYKP/r/rNMCDLywZA0jVJ4H/+TaZW6NC85XgH6mzmWYk2gIV4zM2VxXcIG+SUV6J4o2e92pTqRrxB8br8Q3C0TVBHCu5czsj69t8Z4WR2jbtQxq2tYLfQlac/eu/vD9NfOFI4CP5jW+nalB3Ah3jAE/IBSbm1oGXVSp9DcSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=Tgga4mPI; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 773D5697AA;
	Mon,  2 Sep 2024 03:46:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725263199; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LU82ZRnbNG36KcEB2cwtYaBM+0PeNRrwjU7twoI8AUc=;
	b=Tgga4mPIkaqw+cvxchA9OIX6PIR3zgw9gt7iryTiSylTJfuXCV5KT3G3bRFzxAcow7HPdw
	P9nkrolNQGj2yxQRdLCKfHZpr0J8c+5mSMJ/9SU0qkVJEeYWhlQEPXkPTnlaBFtQDgoogv
	yZYe8ajqCdPMoI9GnvUt2QyjUej5wWeGK3Q3Gqk2Psfh/cmHffAsm+5d9afJmlUvycFqC8
	iOQnOzhEDYmVsjRaugefqeeg/TrDxZwxVDwStNGdq4Tb1F/p3k0V+qspdsuLby6J2SJGGV
	XwaR+VcAP988/o41eYSphQgieLNYz79BcF/WW+kFzmLam2ElNOacKyp/750m9A==
Date: Mon, 2 Sep 2024 15:46:17 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Message-ID: <ql2vdd74fzsfzgxixa3hymagvo42dfnawpr53jgximuh7cwra6@2gn4skmbqkhz>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
 <20240902070047.384952-2-toolmanp@tlmp.cc>
 <bfcd83f8-87ef-4282-b9e9-700c45fc3302@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfcd83f8-87ef-4282-b9e9-700c45fc3302@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 02, 2024 at 03:11:45PM GMT, Gao Xiang wrote:

> 
> 
> On 2024/9/2 15:00, Yiyang Wu via Linux-erofs wrote:
> > Remove open coding in erofs_fill_symlink.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> > Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> > ---
> >   fs/erofs/inode.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index 419432be3223..d051afe39670 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -188,22 +188,20 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> >   		return 0;
> >   	}
> > -	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
> > -	if (!lnk)
> > -		return -ENOMEM;
> > -
> >   	m_pofs += vi->xattr_isize;
> >   	/* inline symlink data shouldn't cross block boundary */
> >   	if (m_pofs + inode->i_size > bsz) {
> > -		kfree(lnk);
> >   		erofs_err(inode->i_sb,
> >   			  "inline data cross block boundary @ nid %llu",
> >   			  vi->nid);
> >   		DBG_BUGON(1);
> >   		return -EFSCORRUPTED;
> >   	}
> > -	memcpy(lnk, kaddr + m_pofs, inode->i_size);
> > -	lnk[inode->i_size] = '\0';
> > +
> > +	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> > +
> 
> Unnecessary new line.
> 
> Also I wonder if it's possible to just
> 	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> 	if (!inode->i_link)
> 		return -ENOMEM;
> 
> here, and get rid of variable lnk.
> 
> Otherwise it looks good to me.
> 
> Thanks,
> Gao Xiang
>  
Yeah, it looks good to me. Fixed.
> > +	if (!lnk)
> > +		return -ENOMEM;
> >   	inode->i_link = lnk;
> >   	inode->i_op = &erofs_fast_symlink_iops;
> 

Best Regards,
Yiyang Wu

