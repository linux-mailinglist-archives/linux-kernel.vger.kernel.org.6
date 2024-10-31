Return-Path: <linux-kernel+bounces-390088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C219B7553
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FB61F2158A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FA1494B5;
	Thu, 31 Oct 2024 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSvhssAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0414831D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359606; cv=none; b=SbHQuMtSmupMoTYWwIiwRM8q/qvG8veSex4MyrCJLuxh0f1oE1nCEvtYf3SectzWZXDL5KEtTU3+rYxdU47XYzvRAAhilIrR2QbnYhvFh1tYZY5SQfwYziefg3gYKJ+kPwx5vNGn9Zr38U+RGudp2Dz7awQjLddFvbebSH3M6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359606; c=relaxed/simple;
	bh=R5MrToygnAnWBRaIJo+U8dMwcxWH2k2sEzsW0crF64E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XwweMZkE/YKCjGB9U7JFaCHPmAGbQBCuwG90vxUb4AKq0uGUMqGAxD1NIlYk0G4OuOc4sLR9xXco8I9kLXly3sQDQUsHaOy/u94XhAKN//tPSAsb1SXn4kApq/c83TRWtgKtlk5HJ/XEw2Z+I/caKQ/cdlG0Syb4k0sBNeGmF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSvhssAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EF5C4CEC3;
	Thu, 31 Oct 2024 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730359605;
	bh=R5MrToygnAnWBRaIJo+U8dMwcxWH2k2sEzsW0crF64E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oSvhssApEEiqkdIQnOFF3OUyV6oLukghXdSuqQIJOzy7v7i5GWhGa75tD+yH18pEU
	 l/b+hISBipwGpURQXghWZMVNb50QFGkN346S+doBxFEvq8B+zawTsPsiJCc3TdnvXi
	 F+wtJHLxK0CMtW0qA5EDZ7DLkJqgTaphrXhAhfwRahshtYvATaN8uTOTLGaLuad96k
	 2uongINHyddqj5LVTYwoXu/o+0lpnC/596g+HWDei39NfmNkzMp0HLlgEd0oQ6Z2Su
	 QxQXhS6UQc8qbKmIzglH76+aSn7EaGyRQX6digLy+usfEZjOgRXV+FBRhECMpmTebC
	 7lzUPJtBVtgVA==
Message-ID: <036ed265-23c1-4a16-a1bb-452b90e8cf1f@kernel.org>
Date: Thu, 31 Oct 2024 15:26:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, sunyibuaa@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Subject: Re: [PATCH v2 2/5] f2fs: expand f2fs_invalidate_compress_page() to
 f2fs_invalidate_compress_pages_range()
To: Yi Sun <yi.sun@unisoc.com>, jaegeuk@kernel.org
References: <20241030103136.2874140-1-yi.sun@unisoc.com>
 <20241030103136.2874140-3-yi.sun@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241030103136.2874140-3-yi.sun@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/30 18:31, Yi Sun wrote:
> New function f2fs_invalidate_compress_pages_range() adds the @len
> parameter. So it can process some consecutive blocks at a time.
> 
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>   fs/f2fs/compress.c | 7 ++++---
>   fs/f2fs/f2fs.h     | 9 +++++----
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 7f26440e8595..e607a7885b57 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1903,11 +1903,12 @@ struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
>   	return sbi->compress_inode->i_mapping;
>   }
>   
> -void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr)
> +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +				block_t blkaddr, unsigned int len)
>   {
> -	if (!sbi->compress_inode)
> +	if (!sbi->compress_inode || len == 0)

We can remove len == 0 check condition? Or any caller can pass 0 here?

Thanks,

>   		return;
> -	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr);
> +	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr + len - 1);
>   }
>   
>   void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3c6f3cce5779..d3fe66a93a56 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4384,7 +4384,8 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
>   int __init f2fs_init_compress_cache(void);
>   void f2fs_destroy_compress_cache(void);
>   struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
> -void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr);
> +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +					block_t blkaddr, unsigned int len);
>   void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>   						nid_t ino, block_t blkaddr);
>   bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
> @@ -4439,8 +4440,8 @@ static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return
>   static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
>   static inline int __init f2fs_init_compress_cache(void) { return 0; }
>   static inline void f2fs_destroy_compress_cache(void) { }
> -static inline void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi,
> -				block_t blkaddr) { }
> +static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +				block_t blkaddr, unsigned int len) { }
>   static inline void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
>   				struct page *page, nid_t ino, block_t blkaddr) { }
>   static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
> @@ -4759,7 +4760,7 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
>   								block_t blkaddr)
>   {
>   	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
> -	f2fs_invalidate_compress_page(sbi, blkaddr);
> +	f2fs_invalidate_compress_pages_range(sbi, blkaddr, 1);
>   }
>   
>   #define EFSBADCRC	EBADMSG		/* Bad CRC detected */


