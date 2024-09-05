Return-Path: <linux-kernel+bounces-316680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D996D2AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781641C2269C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C41946A9;
	Thu,  5 Sep 2024 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1OrZjpb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EDC8F66
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526919; cv=none; b=Q0zYjHcUdvQzfN+Z6T3gLumBkLyPINLsPZC6beQ0lTZWkYLt6kfAaOWltSYIxEiYcTOguxl5CNmSlxU97+G6iQ1dv0f0DF8Vv0Z+Q9NVTz8oQb8xQeNv6jG1MTPkL8CCKtVq16fA67o/JFU/qAda1G6oJ7cgDs52g2u6s3hr+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526919; c=relaxed/simple;
	bh=9eLCwQNtlK46nPt5gDq1OgBgEmNnuWgHpS7qPp3OJfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBmhYUO80+MqXvcrSgxjaLIdpz+gHIJl1R0u56orKcA9+pY5B+jLNwoor6Kpr3RmrDGG+JjceoiMbFX5OKT06EDr5V7jzpmymIf7AU1nQR5NP50qJvZDu+6e/fQnchTWA3IPIBCrfmDEoYCXuJ3NtmnZO/PoWeJfVMFgALxaVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1OrZjpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC9BC4CEC3;
	Thu,  5 Sep 2024 09:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725526919;
	bh=9eLCwQNtlK46nPt5gDq1OgBgEmNnuWgHpS7qPp3OJfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1OrZjpb5XQac/QIYhlv7Qvy9CXoBCug0CHfzhBvi6KWkTb65Y2H87Q+mQnvEyBxp
	 +WxWgSTaTi9JieenyKR/W4LA7TRg86PJyCmpBGrysOappYXZPPYn+/QFAOFDCQ1FzE
	 t+Gcm2SD2zDricftyBT2AOZ3JjIqMxHrYC25rR3rCk6ip5FwXheJrBZ9DBUWrNqTWY
	 pj05r6/RjMI4obW1eLvwSUUc4oqFjet9NhPbqvC4dzn4TNEWy8iHF2dgC4L/MX+5g6
	 1einkL/q4CcWfmNySuhFCIjxlQKVBpvJs1opttqeSSgun+PG5hF18oeIXuGkHwZm/i
	 rsWFW517xytoQ==
Message-ID: <64a8c756-3cca-4e34-b907-b737569d7cec@kernel.org>
Date: Thu, 5 Sep 2024 17:01:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] erofs: support compressed inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 11:28, Gao Xiang wrote:
> Use pseudo bios just like the previous fscache approach since
> merged bio_vecs can be filled properly with unique interfaces.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/fileio.c   | 25 +++++++++++++++++++++----
>   fs/erofs/inode.c    |  6 ------
>   fs/erofs/internal.h |  8 ++++++++
>   fs/erofs/zdata.c    | 27 +++++++++++++++++----------
>   4 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index eab52b8abd0b..9e4b851d85c0 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -23,7 +23,6 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   			container_of(iocb, struct erofs_fileio_rq, iocb);
>   	struct folio_iter fi;
>   
> -	DBG_BUGON(rq->bio.bi_end_io);
>   	if (ret > 0) {
>   		if (ret != rq->bio.bi_iter.bi_size) {
>   			bio_advance(&rq->bio, ret);
> @@ -31,9 +30,13 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   		}
>   		ret = 0;
>   	}
> -	bio_for_each_folio_all(fi, &rq->bio) {
> -		DBG_BUGON(folio_test_uptodate(fi.folio));
> -		erofs_onlinefolio_end(fi.folio, ret);
> +	if (rq->bio.bi_end_io) {
> +		rq->bio.bi_end_io(&rq->bio);
> +	} else {
> +		bio_for_each_folio_all(fi, &rq->bio) {
> +			DBG_BUGON(folio_test_uptodate(fi.folio));
> +			erofs_onlinefolio_end(fi.folio, ret);
> +		}
>   	}
>   	kfree(rq);
>   }
> @@ -68,6 +71,20 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
>   	return rq;
>   }
>   
> +struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev)
> +{
> +	struct erofs_fileio_rq *rq;
> +
> +	rq = erofs_fileio_rq_alloc(mdev);
> +	return rq ? &rq->bio : NULL;
> +}
> +
> +void erofs_fileio_submit_bio(struct bio *bio)
> +{
> +	return erofs_fileio_rq_submit(container_of(bio, struct erofs_fileio_rq,
> +						   bio));
> +}
> +
>   static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   {
>   	struct inode *inode = folio_inode(folio);
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 4a902e6e69a5..82259553d9f6 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -260,12 +260,6 @@ static int erofs_fill_inode(struct inode *inode)
>   	mapping_set_large_folios(inode->i_mapping);
>   	if (erofs_inode_is_data_compressed(vi->datalayout)) {
>   #ifdef CONFIG_EROFS_FS_ZIP
> -#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> -		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
> -			err = -EOPNOTSUPP;
> -			goto out_unlock;
> -		}
> -#endif
>   		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
>   			  erofs_info, inode->i_sb,
>   			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 9bc4dcfd06d7..4efd578d7c62 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -489,6 +489,14 @@ static inline void z_erofs_exit_subsystem(void) {}
>   static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev);
> +void erofs_fileio_submit_bio(struct bio *bio);
> +#else
> +static inline struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev) { return NULL; }
> +static inline void erofs_fileio_submit_bio(struct bio *bio) {}
> +#endif
> +
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>   int erofs_fscache_register_fs(struct super_block *sb);
>   void erofs_fscache_unregister_fs(struct super_block *sb);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 350612f32ac6..2271cb74ae3a 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1618,10 +1618,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   			if (bio && (cur != last_pa ||
>   				    bio->bi_bdev != mdev.m_bdev)) {
>   io_retry:
> -				if (!erofs_is_fscache_mode(sb))
> -					submit_bio(bio);
> -				else
> +				if (erofs_is_fileio_mode(EROFS_SB(sb)))
> +					erofs_fileio_submit_bio(bio);
> +				else if (erofs_is_fscache_mode(sb))
>   					erofs_fscache_submit_bio(bio);
> +				else
> +					submit_bio(bio);
>   
>   				if (memstall) {
>   					psi_memstall_leave(&pflags);
> @@ -1637,10 +1639,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   			}
>   
>   			if (!bio) {
> -				bio = erofs_is_fscache_mode(sb) ?
> -					erofs_fscache_bio_alloc(&mdev) :
> -					bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
> -						  REQ_OP_READ, GFP_NOIO);
> +				if (erofs_is_fileio_mode(EROFS_SB(sb)))
> +					bio = erofs_fileio_bio_alloc(&mdev);

It seems erofs_fileio_bio_alloc() can fail, it needs to handle NULL bio
here?

Thanks,

> +				else if (erofs_is_fscache_mode(sb))
> +					bio = erofs_fscache_bio_alloc(&mdev);
> +				else
> +					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
> +							REQ_OP_READ, GFP_NOIO);
>   				bio->bi_end_io = z_erofs_endio;
>   				bio->bi_iter.bi_sector = cur >> 9;
>   				bio->bi_private = q[JQ_SUBMIT];
> @@ -1667,10 +1672,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
>   
>   	if (bio) {
> -		if (!erofs_is_fscache_mode(sb))
> -			submit_bio(bio);
> -		else
> +		if (erofs_is_fileio_mode(EROFS_SB(sb)))
> +			erofs_fileio_submit_bio(bio);
> +		else if (erofs_is_fscache_mode(sb))
>   			erofs_fscache_submit_bio(bio);
> +		else
> +			submit_bio(bio);
>   		if (memstall)
>   			psi_memstall_leave(&pflags);
>   	}


