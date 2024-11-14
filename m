Return-Path: <linux-kernel+bounces-408738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE69C82E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579B31F214B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061EF16FF4E;
	Thu, 14 Nov 2024 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sLX3Sve5"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8171E4B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731564281; cv=none; b=f0U1/N8UKTk1V0S0V6bIApJ/lTCmdRBJgYlw1PGPDbJDQWCF8c07C8uaSjazHlCYZeHzFjUvpvu5tyeYtYtHgWLvmXsge8OQtmDGDbkirCRzebdpTg9Q07ZHENe/OLAqV+btJ22Pch9VufjekiwgZPC9Tb7VAOZru5ACbhWYf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731564281; c=relaxed/simple;
	bh=/EU2fM38pr38y4iKl4mqE5/0aSWHSDSxHmgvT8Q67Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uagxcrWjmkZ3Qe3HfSxdkt9Tzo6eZihj0UVNCxgAXsUFKiKdJgAOqNy1JY/AjiAT78jtEyOIwJtufl92yYeMoSvJsPm07Dezr6YT5Cfzv+vkcLT4JfN5lEUOX35iOxloKvT1ZyCqiJj5M0AFLAas36mPu0JPUoomRDEd0rzb1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sLX3Sve5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eHTVv/e5b+Y8y37tco4KYG3ZPdpH3pQloJuWS7nPlEE=; b=sLX3Sve5uDc41pHYKLkbvF8axC
	TwKcEN2d9TpWNUq0SmuAWqMB68vRmrqHUWze4UE8GJo1bATwvkf1V1Xfzba+sqI7wf2zb2oLgMzy2
	+PfZEFKOZnqq/da5NEps6txtQ528D2NVfU75F0OWacUv/hVEC4yrhGjFuPaXBbHf0GSPl1e1kSJeg
	jsnIXhUEf/Bjp4kmCvKQjrBlzJLsnmrr/RKrptJwfHtVd2eeU0T06906Qtv95M+mY9U6jAKCrcuOX
	TPruVA69YqogfPGVqeRDMHVUnPuLmZR8UGa2Fdc/y9BggxZztUxDun481DxpKYQlPaBREKSzmoO9/
	JEtoyzcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSy2-0000000EnkW-0k35;
	Thu, 14 Nov 2024 06:04:34 +0000
Date: Thu, 14 Nov 2024 06:04:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Subject: Re: [PATCH] erofs: fix file-backed mounts over FUSE
Message-ID: <20241114060434.GL3387508@ZenIV>
References: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 14, 2024 at 01:19:57PM +0800, Gao Xiang wrote:

> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 6355866220ff..43c89194d348 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -38,7 +38,10 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
>  	}
>  	if (!folio || !folio_contains(folio, index)) {
>  		erofs_put_metabuf(buf);
> -		folio = read_mapping_folio(buf->mapping, index, NULL);
> +		folio = buf->use_fp ?
> +			read_mapping_folio(file_inode(buf->filp)->i_mapping,
> +				index, buf->filp) :
> +			read_mapping_folio(buf->mapping, index, NULL);

UGH...

1) 'filp' is an atrocious identifier.  Please, don't perpetuate
the piss-poor taste of AST - if you want to say 'file', say so.

2) there's ->f_mapping; no need to go through the file_inode().

3) AFAICS, (buf->kmap_type == EROFS_KMAP) == (buf->base != NULL).  What's
the point of having that as a separate field?

4) Why bother with union?  Just have buf->file serve as your buf->use_fp
and be done with that...

