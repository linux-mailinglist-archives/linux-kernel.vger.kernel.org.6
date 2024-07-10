Return-Path: <linux-kernel+bounces-248389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7892DC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8BEB22AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266D153835;
	Wed, 10 Jul 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY5wCLlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731A12C489
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653635; cv=none; b=MUBUfyXGcm4ULgASgd94U0zP/lcf7iQFzArHN0VEw05EibgQKri7evclngJpmFbpSvpmDsXhKtE39LqOYx5fV4Y3KdVgGMlUfriMS9mJqyl2pWHtqMcYMpo/PgIQFERsoZZw2vqFfZnGoEhFf0DXJU9vFs3OusovID8GRpxLJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653635; c=relaxed/simple;
	bh=mTIEDdU6SbNAcW1BkWd2VaA6n34Y1oK9yy9f00SXVnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Piy4oh9iILCvBwqvKwU1MXcSkHchNfWM5UUqahsqP8sBXeUmw6yHiAlSyoqvgI12GGQ2bpjDAQ7iZtbPzoZ1gdTTBDXTAWwBsPeot+so6WA1Lv5sjUhr/h9JLw6TxRdsKhvjysZrwH1Su0IezOLtDDgdSsuY60ZKuK64/inyQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY5wCLlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12E8C32781;
	Wed, 10 Jul 2024 23:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720653634;
	bh=mTIEDdU6SbNAcW1BkWd2VaA6n34Y1oK9yy9f00SXVnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iY5wCLlbOENi6J6y4MEK/XrrY2d7L9WF7bpMK0tMFisNVrlwK0OppQ9DwrEcX/Q13
	 OpVSFLGZbBnC140EJhvgU1rl2H2YAQQEG/PMXcWjbV3cnr5wwnfICL2w4eumMqH9Dz
	 HMybcdfj/xMFk+WAioy+Wv6NxWcsZYHF99WSfQfm7/N215wTFr7FQtJZeI10FoMm8U
	 qj9fft6Wcla49zDXjt2V/eZRce5wL5nZhEI+TjhIGZ+6f4xD9FgbTSRHG47q5CIdil
	 nVfA4cwLSzYqY2FWxZ3QCtMs4xsJnCS9qJangnGBMDXQWntr+5BaKyocZ1YEs40U/V
	 vM77v/4SwtanA==
Date: Wed, 10 Jul 2024 23:20:32 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] f2fs: clean up data_blkaddr() and get_dnode_addr()
Message-ID: <Zo8XQAACHaGrwYVN@google.com>
References: <20240625031604.3587691-1-chao@kernel.org>
 <20240625031604.3587691-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625031604.3587691-3-chao@kernel.org>

On 06/25, Chao Yu wrote:
> Introudce a new help get_dnode_base() to wrap common code from
> get_dnode_addr() and data_blkaddr() for cleanup.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 46 +++++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1f78a39fe7f4..eacf0b0e6b2e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2905,26 +2905,31 @@ static inline __le32 *blkaddr_in_node(struct f2fs_node *node)
>  }
>  
>  static inline int f2fs_has_extra_attr(struct inode *inode);
> -static inline block_t data_blkaddr(struct inode *inode,
> -			struct page *node_page, unsigned int offset)
> +static inline int get_extra_isize(struct inode *inode);

It seems get_extra_isize was already declared above?

> +static inline unsigned int get_dnode_base(struct inode *inode,
> +					struct page *node_page)
>  {
> -	struct f2fs_node *raw_node;
> -	__le32 *addr_array;
> -	int base = 0;
> -	bool is_inode = IS_INODE(node_page);
> -
> -	raw_node = F2FS_NODE(node_page);
> -
> -	if (is_inode) {
> +	if (IS_INODE(node_page)) {
>  		if (!inode)
>  			/* from GC path only */
> -			base = offset_in_addr(&raw_node->i);
> +			return offset_in_addr(&F2FS_NODE(node_page)->i);
>  		else if (f2fs_has_extra_attr(inode))
> -			base = get_extra_isize(inode);
> +			return get_extra_isize(inode);

	if (!IS_INODE(node_page))
		return 0;

	return inode ? get_extra_isize(inode) :
		offset_in_addr();

>  	}
> +	return 0;
> +}
>  
> -	addr_array = blkaddr_in_node(raw_node);
> -	return le32_to_cpu(addr_array[base + offset]);
> +static inline __le32 *get_dnode_addr(struct inode *inode,
> +					struct page *node_page)
> +{
> +	return blkaddr_in_node(F2FS_NODE(node_page)) +
> +			get_dnode_base(inode, node_page);
> +}
> +
> +static inline block_t data_blkaddr(struct inode *inode,
> +			struct page *node_page, unsigned int offset)
> +{
> +	return le32_to_cpu(*(get_dnode_addr(inode, node_page) + offset));
>  }
>  
>  static inline block_t f2fs_data_blkaddr(struct dnode_of_data *dn)
> @@ -3297,8 +3302,6 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
>  	return is_inode_flag_set(inode, FI_COW_FILE);
>  }
>  
> -static inline __le32 *get_dnode_addr(struct inode *inode,
> -					struct page *node_page);
>  static inline void *inline_data_addr(struct inode *inode, struct page *page)
>  {
>  	__le32 *addr = get_dnode_addr(inode, page);
> @@ -3437,17 +3440,6 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
>  	return F2FS_I(inode)->i_inline_xattr_size;
>  }
>  
> -static inline __le32 *get_dnode_addr(struct inode *inode,
> -					struct page *node_page)
> -{
> -	int base = 0;
> -
> -	if (IS_INODE(node_page) && f2fs_has_extra_attr(inode))
> -		base = get_extra_isize(inode);
> -
> -	return blkaddr_in_node(F2FS_NODE(node_page)) + base;
> -}
> -
>  #define f2fs_get_inode_mode(i) \
>  	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
>  	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
> -- 
> 2.40.1

