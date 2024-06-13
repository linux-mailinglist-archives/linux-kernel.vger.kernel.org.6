Return-Path: <linux-kernel+bounces-214093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5040D907F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E016F2837F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0235D14A4EB;
	Thu, 13 Jun 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="boo91uKw"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0C811FE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320646; cv=none; b=StySSX6AeSELkuVKE0ifggnF0Sh6fyPqErvxzWLh3IbmzS0FGEyxUFQDw3rSYV15rrmQdtwZiVe5VDd4OLRr1LxYAmJNVZJQkLh5uBMNVPpp2rHny8KWCSTy2/jPgcT8LvNUPQb7/RblvRKR5WsXrWa53AkuEMyycE/N96C7VUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320646; c=relaxed/simple;
	bh=zuC4Tps2N29j0mj3POGsHDd9NSKVcD6+rcvSWhIDGiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awifZoR4vLYnMVPzc8Sa8j+HIP4TMUpPhG8t/MRhyJWYx+C8CqKw0mzehA9es7NAzUQg/d9yvWkiP8hg8wKQqaAdpoUoEB/FV6cRlUfb5K3gXxEU28WKzFIqILCgp2GbqMDhC1s04JxT6tGtTot8suoObz+9ARTr299s+Sf8YXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=boo91uKw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QBFRrP2xBXdRdBs3ftxDHpFBT4wHaIEB3ObJxP/910A=; b=boo91uKwTlCvzSo1d1D/j/ACx8
	ZhF0aoXGBCp/QL5t1uad8X6655h87Fe1HGclwququMP/5sfIuhDY/g8vXCh8kA/CgEgOEhUCFbJ4f
	+EGrZ5QoHgY/iWGAXiLVxjybePWcgkwCM6wKLhvNQCmMv3XN48g1T3aemHFH9BhkXW/o9b9F51V/U
	+2JNzuuDYcrGhU3DL1owrXoqbOdG7nO7CR2F+saJveHKi2qBJZnkpTEeEuEPj8gsiLWCb+ISQk+K/
	bBEfVxCGBs+h4ewOxxpAXdkT8nPrEDRdDJ2KrLlzUk3SHJKHhNKUUNspGXKLV1P31PyZ912O02dhd
	QgqhcBlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sHtgz-003wpj-39;
	Thu, 13 Jun 2024 23:17:18 +0000
Date: Fri, 14 Jun 2024 00:17:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: dushistov@mail.ru, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] ufs: Add table lookup to set d_type based on mode &
 S_IFMT
Message-ID: <20240613231717.GK1629371@ZenIV>
References: <20240613202650.39739-1-jain.abhinav177@gmail.com>
 <20240613204047.GJ1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613204047.GJ1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 13, 2024 at 09:40:47PM +0100, Al Viro wrote:

> should've raised an arseload of mental red flags.  That loop is
> bloody ridiculous, even if you don't bother to check what other
> similar filesystems actually do in the counterpart of that logics.
> 
> "Table lookup" does *NOT* refer to that.  What you've got is strictly
> worse than the original switch, and that takes some doing.
> 
> NAK.

Note, BTW, that for DT_... values are exactly the same as bits 12..15 of
mode_t.  That's not accidental.  So for valid mode values it's simply

{
        if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) == UFS_DE_44BSD)
		de->d_u.d_44.d_type = (mode & S_IFMT) >> 12;
}

The 'mode' argument is always inode->i_mode for some inode.  Two possible
variants: put validation into ufs_set_inode_ops() and make it fail when
the type is bad (note that init_special_inode() will already scream bloody
murder in that case) or put the validation in ufs_set_de_type() - that
would be

{
        if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) == UFS_DE_44BSD) {
		unsigned char v = (mode & S_IFMT) >> 12;
		switch (v) {
		case DT_REG: case DT_DIR: case DT_LNK: case DT_SOCK:
		case DT_CHR: case DT_BLK: case DT_FIFO:
			break;
		default:
			v = DT_UNKNOWN;
		}
		de->d_u.d_44.d_type = v;
	}
}

The first variant has a potential weakness - you might be unable to
unlink() junk on corrupted filesystem, but then you really don't
want to do that; it's likely to be not only thing that got corrupted
there.

