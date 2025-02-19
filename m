Return-Path: <linux-kernel+bounces-521333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDF9A3BBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6B43AF345
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FD1DDC35;
	Wed, 19 Feb 2025 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CUNKKQZk"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352BB13FD86
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961541; cv=none; b=lgt0y2Qq5O6IkDkbQwVjlCt0UFDP2ht7sQ9Gf52D6P+2K9cgbLZmgzJjlHdNucHrNtZdLJjyiuAy/NBrZW9HmWjaO3JtmOJoLVUBBnzWhwXPjVEIwOnVIrZHJ5Ld+8vGnjmeBscdBr16C9roQZ1IrncEASzxN+b6Aau8iN2xROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961541; c=relaxed/simple;
	bh=Mtm1hnKyjCvKfCcON1DcJ7kuaN+5SUyq0XI2UO6Aass=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGhvSBWhAqHXFTrNXRpt8kpRJSelhIqOML+HiXIlT/7GGat23A2/tY56UcCpzs81vJevJilNQARBtA0o/hRAy5QuhNDlppfpL/MR31iTQS/h1U9ZzgfYpLcXk/tUjXqAyRuj9fPq8KtQGTVHVLCS0QTZKn5xB2KHKooCMpFJmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CUNKKQZk; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id DA89B40777D3;
	Wed, 19 Feb 2025 10:38:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DA89B40777D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1739961529;
	bh=zjgeQsz7/p1g7niY9RKs+VeS1ek73XCgN0EtVLw+AO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUNKKQZkNxRoniJFILfsEOusbi2eYxqB5sXZ6JlcrGjei/hq94Ynrixuefq+uWIJl
	 7/tRfChbMvReUEiGEM0HPm0/D8H5HQA6wYKTQOhLIHY4CKYZtlM/N0MNcP6Yp4u13g
	 hlsdED+MQQamzpWFaoa8GOAJqwud4EW+g4ej+ucI=
Date: Wed, 19 Feb 2025 13:38:49 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Dave Kleikamp <shaggy@kernel.org>, 
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	voskresenski.stanislav@confident.ru, deeb.rand@confident.ru, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10.y] fs/jfs: cast inactags to s64 to prevent potential
 overflow
Message-ID: <v3rsldvzq4ujgcxamjwcmmfm62wgdgjscg25c6t6xph3itjedp@sbuayguprw2i>
References: <20250219072504.1655151-1-rand.sec96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219072504.1655151-1-rand.sec96@gmail.com>

Hi,

On Wed, 19. Feb 10:25, Rand Deeb wrote:
> The expression "inactags << bmp->db_agl2size" in the function
> dbFinalizeBmap() is computed using int operands. Although the
> values (inactags and db_agl2size) are derived from filesystem
> parameters and are usually small, there is a theoretical risk that
> the shift could overflow a 32-bit int if extreme values occur.
> 
> According to the C standard, shifting a signed 32-bit int can lead
> to undefined behavior if the result exceeds its range. In our
> case, an overflow could miscalculate free blocks, potentially
> leading to erroneous filesystem accounting.
> 
> To ensure the arithmetic is performed in 64-bit space, we cast
> "inactags" to s64 before shifting. This defensive fix prevents any
> risk of overflow and complies with kernel coding best practices.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---

Why is the patch targeted only to 5.10.y? It should go to the mainline
first, no?

Please check https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

>  fs/jfs/jfs_dmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index eedea23d70ff..3cc10f9bf9f8 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -3728,8 +3728,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
>  	 * system size is not a multiple of the group size).
>  	 */
>  	inactfree = (inactags && ag_rem) ?
> -	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
> -	    : inactags << bmp->db_agl2size;
> +	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
> +	    : ((s64)inactags << bmp->db_agl2size);
>  
>  	/* determine how many free blocks are in the active
>  	 * allocation groups plus the average number of free blocks
> -- 
> 2.34.1

