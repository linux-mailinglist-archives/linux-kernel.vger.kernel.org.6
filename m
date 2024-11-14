Return-Path: <linux-kernel+bounces-409626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B589C9046
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4151B2E04D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13D15573F;
	Thu, 14 Nov 2024 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ng2HbV9o"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE1262A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601111; cv=none; b=Nv2Oizkgt9xcRdb8ZvkFzkAYOWTggjHv8TPRjHvSBBddr4vSVbZwPfx3vnKUiw2tBoersgnRfU4AcEoRxWRz61ldqrAOJGf9w74y7QyvxwcRTHPwSm0zFsLrjtC1qo0Xojf84SC8HjSPmHIpgKI8XJUfGXdQECO1YfzXGj8eSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601111; c=relaxed/simple;
	bh=IXa20kPovf1Y/0KCLUo928WvlTZb0nwEJ37O8TBNUqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELEJpC5aRPfSHFHaI2212/rQpw4plMxKnZQK14rNFHMPjxjvNt1Ow5QETKxnnMS94jVoAj+2H2uDi9wo+9nzli1ZJhvEpq3VOV45OYP5Iw3b88azkjGdav0TX3YCEgO91+ot0NS6Yqv/0jBAV7U0CNG7iF/MoAWMZQFWt8FshRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ng2HbV9o; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=60CpvTS8y28+G06qyIsEsZ2zgscU9EQI3R4bXZJMd3E=; b=ng2HbV9oGrlnpiOiJSupabDi5/
	qyvBEzqieb2GvNdM6bQfELzVedcCFzxu+e+4TjR7gBMTsyy8zrQouFSxnhmmWOgcVnmqCvzkAaKbW
	9YcRE5TP6m3D/O2Q5IJf9APa/t8ng5NfYVocKgRm0b9JZnP9uzi6MUlqur64tH3SytDkRbhK6CFkZ
	fP+N/zdnpHdGaaM48K4sal05CLu+fGxxhtZW/4jdKGanzziKYApxs1frumXPj/rzRJEeGfUV12soh
	A2miRyUy8wQW0GLm4sBqnGUuaLR7gxFy0YdWMl1ac/ihwCLIVlGHmaMUwqiAET+GhwP00kRoXWLOk
	UkcJcTVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcY4-0000000Eyhp-03AE;
	Thu, 14 Nov 2024 16:18:24 +0000
Date: Thu, 14 Nov 2024 16:18:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] erofs: fix file-backed mounts over FUSE
Message-ID: <20241114161823.GN3387508@ZenIV>
References: <20241114090109.757690-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114090109.757690-1-hsiangkao@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 14, 2024 at 05:01:09PM +0800, Gao Xiang wrote:
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -38,7 +38,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
>  	}
>  	if (!folio || !folio_contains(folio, index)) {
>  		erofs_put_metabuf(buf);
> -		folio = read_mapping_folio(buf->mapping, index, NULL);
> +		folio = buf->file ? read_mapping_folio(buf->file->f_mapping,
> +					index, buf->file) :
> +			read_mapping_folio(buf->mapping, index, NULL);
>  		if (IS_ERR(folio))
>  			return folio;
>  	}
> @@ -61,8 +63,8 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if (erofs_is_fileio_mode(sbi))
> -		buf->mapping = file_inode(sbi->fdev)->i_mapping;
> +	if (erofs_is_fileio_mode(sbi))	/* some fs like FUSE needs it */
> +		buf->file = sbi->fdev;

Would be easier to set *both* ->mapping and ->file at that point, so that
erofs_bread() would just have read_mapping_folio(buf->mapping, index, buf->file),
unconditionally...

