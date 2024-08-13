Return-Path: <linux-kernel+bounces-285561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB4950FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49137B25064
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DA11AB507;
	Tue, 13 Aug 2024 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrX6Or5f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BC1A7054
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587858; cv=none; b=kW2py64N5NatV32ZHjmAMWD0HIt+GZXcninFPRSjF92pZHaUrHa0H3e13kuERwFsNVBVrik/59s4btdcxd0rw1Hjj3jB5Y7dunzfP/sDyUpi3fpFNfMFj+H/Rq89Nmc3DfkkbvMWbw8/fNCNDMSrn1K7nVtNGzmOxi5Wdgai/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587858; c=relaxed/simple;
	bh=FISE9M2iXKBizsZDyLHfPlfGorD8VjeOKo/Zy+6/20I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOhVUA8vCUXNiJaOpsnxVVQT0bLm3hx18e1v6h5IGq+eNy4TrA7ANK79osferqVmzQzL9qQ4bKbFiG5BKWOd3rGrTvxR8sICnH7VbYshkABkm100ksEYvvH+e+8/zM1GrBoARD5enskk8+MXgBYRmuercu6+I5aLz/o6hnXV3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrX6Or5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F219C32782;
	Tue, 13 Aug 2024 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723587857;
	bh=FISE9M2iXKBizsZDyLHfPlfGorD8VjeOKo/Zy+6/20I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrX6Or5fRLw/LYLHscOX0JQUcI40kv592n4OIBAuBU1sARxo8BAgDYUO9ByT5ueVX
	 Xg+iHRjn/f8a7RNapmXmh8ohboE+K/WjixGgWGKK+7Ab3RQV2Fv+T7ncq7zPyXToHR
	 ofotxbcA5DCI/xF4Kz7eFvtVTKrOWFwKmnhpPUY5ilumanY398kXaL/4GdayuiNJpv
	 UpTbgAcY0XCCCRChYciEoFenF/9P1Ht34xlxY+oR9nLBi7fNEyJjPXF3aPED74h5Ef
	 E2+Wu+I6fsWOOPTa4eQ6JF1ZK/icx+16iHQkTD8wI2WO64RPRA7huO12p1KQHZQyK2
	 vQEc2AWnXeynw==
Date: Tue, 13 Aug 2024 22:24:15 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/9] f2fs: convert f2fs_compress_ctx_add_page() to use
 folio
Message-ID: <ZrvdD6EVJAik1b5w@google.com>
References: <20240813141331.417067-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813141331.417067-1-chao@kernel.org>

Could you please test this series? I hit kernel hang along with refcount warning
in f2fs_put_dic, when running fsstress. You can reproduce it quickly.

On 08/13, Chao Yu wrote:
> onvert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 14 +++++++-------
>  fs/f2fs/data.c     |  4 ++--
>  fs/f2fs/f2fs.h     |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 990b93689b46..eb5cd1457ffc 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -160,17 +160,17 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
>  		cc->cluster_idx = NULL_CLUSTER;
>  }
>  
> -void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page)
> +void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio)
>  {
>  	unsigned int cluster_ofs;
>  
> -	if (!f2fs_cluster_can_merge_page(cc, page->index))
> +	if (!f2fs_cluster_can_merge_page(cc, folio->index))
>  		f2fs_bug_on(F2FS_I_SB(cc->inode), 1);
>  
> -	cluster_ofs = offset_in_cluster(cc, page->index);
> -	cc->rpages[cluster_ofs] = page;
> +	cluster_ofs = offset_in_cluster(cc, folio->index);
> +	cc->rpages[cluster_ofs] = folio_page(folio, 0);
>  	cc->nr_rpages++;
> -	cc->cluster_idx = cluster_idx(cc, page->index);
> +	cc->cluster_idx = cluster_idx(cc, folio->index);
>  }
>  
>  #ifdef CONFIG_F2FS_FS_LZO
> @@ -1093,7 +1093,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  		if (PageUptodate(page))
>  			f2fs_put_page(page, 1);
>  		else
> -			f2fs_compress_ctx_add_page(cc, page);
> +			f2fs_compress_ctx_add_page(cc, page_folio(page));
>  	}
>  
>  	if (!f2fs_cluster_is_empty(cc)) {
> @@ -1123,7 +1123,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  		}
>  
>  		f2fs_wait_on_page_writeback(page, DATA, true, true);
> -		f2fs_compress_ctx_add_page(cc, page);
> +		f2fs_compress_ctx_add_page(cc, page_folio(page));
>  
>  		if (!PageUptodate(page)) {
>  release_and_retry:
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e9570f4e0f21..100b6526717f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2429,7 +2429,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>  		if (ret)
>  			goto set_error_page;
>  
> -		f2fs_compress_ctx_add_page(&cc, &folio->page);
> +		f2fs_compress_ctx_add_page(&cc, folio);
>  
>  		goto next_page;
>  read_single_page:
> @@ -3161,7 +3161,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  			if (f2fs_compressed_file(inode)) {
>  				folio_get(folio);
> -				f2fs_compress_ctx_add_page(&cc, &folio->page);
> +				f2fs_compress_ctx_add_page(&cc, folio);
>  				continue;
>  			}
>  #endif
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 51fd5063a69c..df436dd3aac1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4322,7 +4322,7 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
>  bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
>  				int index, int nr_pages, bool uptodate);
>  bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
> -void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
> +void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio);
>  int f2fs_write_multi_pages(struct compress_ctx *cc,
>  						int *submitted,
>  						struct writeback_control *wbc,
> -- 
> 2.40.1

