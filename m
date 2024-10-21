Return-Path: <linux-kernel+bounces-374171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 243679A6606
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EA91C2200E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3811E5037;
	Mon, 21 Oct 2024 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL0CM4li"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67A1E47B2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509113; cv=none; b=L81IfFglKj08Gj0oVIUhQQkiSXkWKz4DtX4Xt9eeAb10nJJ0SkVBRvLME8qlOVqpETBoK72nayLI9qYsAOrjQtDV+sQd7fWEnjcAoKG/0sLtwlylqAB3kglgAidEl0DGVr3C+R4DJqZvl5PHQtHiCSreRGPzU6fMQl8gC09CVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509113; c=relaxed/simple;
	bh=Si9uBiI7VNrAZ4+UyHCR60bAs5nFBYKN4ZOHMdTtrEo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bAyd14+xwAnbgCbN7Ad6RxXla4M9YF2H4AlLzIMzEyrLobyc/Or+QmiNvRzaCuWPQlYzdDMLhdYOMxBH9iIOf4HusqsB++MwJu0clZPqElPTJnw0Xwgpcpt0rnGA1okcwfAcjhr5fXEiYIR635VfE38FARNPZ0Ha38OYku2H/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DL0CM4li; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729509109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yVOOQRTDPP9EQyCM0BO2Vz41MIi/v/BOtRJeWq4CdzI=;
	b=DL0CM4liGwNqHHFiiJx6GGQ6PVeHWGgGPh4lTn8V+d5bNeDYUHhCdDdFnvKKfq3Th4neuR
	fMcJsn72LLNNbRJ/GqNgK8XNCaHQfMbeB+DyBkjTDuuAdzBPTKrZrq/J6Bv47SpNh4VfMF
	O++ygtHnHWU4S3yCx49NcEmr/qjg+NE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-0Db2WKbVPky42uFBgGVOxg-1; Mon,
 21 Oct 2024 07:11:46 -0400
X-MC-Unique: 0Db2WKbVPky42uFBgGVOxg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E90361955EA7;
	Mon, 21 Oct 2024 11:11:43 +0000 (UTC)
Received: from [10.45.226.64] (unknown [10.45.226.64])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2A6019560AA;
	Mon, 21 Oct 2024 11:11:40 +0000 (UTC)
Date: Mon, 21 Oct 2024 13:11:36 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
    linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
    Md Sadre Alam <quic_mdalam@quicinc.com>, 
    Israel Rukshin <israelr@nvidia.com>, Milan Broz <gmazyland@gmail.com>, 
    Adrian Vovk <adrianvovk@gmail.com>
Subject: Re: [RFC PATCH 2/4] block: add the bi_skip_dm_default_key flag
In-Reply-To: <20241018184339.66601-3-ebiggers@kernel.org>
Message-ID: <2caf648d-73cf-9436-2af4-ad530a966592@redhat.com>
References: <20241018184339.66601-1-ebiggers@kernel.org> <20241018184339.66601-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi

What about using the REQ_META flag (it is set on metadata bios and cleared 
on data bios), instead of adding a new flag with the same meaning?

Mikulas


On Fri, 18 Oct 2024, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Add a flag bi_skip_dm_default_key to struct bio.  This flag indicates
> that dm-default-key should not en/decrypt the bio, due to it targeting
> the contents of an encrypted file.
> 
> When a bio is cloned, copy the bi_skip_dm_default_key flag.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/bio.c                 |  3 +++
>  block/blk-crypto-fallback.c |  2 ++
>  include/linux/blk-crypto.h  | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/blk_types.h   |  3 +++
>  4 files changed, 44 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index ac4d77c889322..5ff0b66e47a42 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -267,10 +267,13 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>  	bio->bi_iocost_cost = 0;
>  #endif
>  #endif
>  #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>  	bio->bi_crypt_context = NULL;
> +#if IS_ENABLED(CONFIG_DM_DEFAULT_KEY)
> +	bio->bi_skip_dm_default_key = false;
> +#endif
>  #endif
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  	bio->bi_integrity = NULL;
>  #endif
>  	bio->bi_vcnt = 0;
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index b1e7415f8439c..dd5f1edcc44b3 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -179,10 +179,12 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
>  	bio_for_each_segment(bv, bio_src, iter)
>  		bio->bi_io_vec[bio->bi_vcnt++] = bv;
>  
>  	bio_clone_blkg_association(bio, bio_src);
>  
> +	bio_clone_skip_dm_default_key(bio, bio_src);
> +
>  	return bio;
>  }
>  
>  static bool
>  blk_crypto_fallback_alloc_cipher_req(struct blk_crypto_keyslot *slot,
> diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
> index 5e5822c18ee41..f1f3d546c53e5 100644
> --- a/include/linux/blk-crypto.h
> +++ b/include/linux/blk-crypto.h
> @@ -110,10 +110,13 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
>  	return false;
>  }
>  
>  #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
>  
> +static inline void bio_clone_skip_dm_default_key(struct bio *dst,
> +						 const struct bio *src);
> +
>  int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
>  /**
>   * bio_crypt_clone - clone bio encryption context
>   * @dst: destination bio
>   * @src: source bio
> @@ -125,11 +128,44 @@ int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
>   *	   @gfp_mask doesn't include %__GFP_DIRECT_RECLAIM.
>   */
>  static inline int bio_crypt_clone(struct bio *dst, struct bio *src,
>  				  gfp_t gfp_mask)
>  {
> +	bio_clone_skip_dm_default_key(dst, src);
>  	if (bio_has_crypt_ctx(src))
>  		return __bio_crypt_clone(dst, src, gfp_mask);
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_DM_DEFAULT_KEY)
> +static inline void bio_set_skip_dm_default_key(struct bio *bio)
> +{
> +	bio->bi_skip_dm_default_key = true;
> +}
> +
> +static inline bool bio_should_skip_dm_default_key(const struct bio *bio)
> +{
> +	return bio->bi_skip_dm_default_key;
> +}
> +
> +static inline void bio_clone_skip_dm_default_key(struct bio *dst,
> +						 const struct bio *src)
> +{
> +	dst->bi_skip_dm_default_key = src->bi_skip_dm_default_key;
> +}
> +#else /* CONFIG_DM_DEFAULT_KEY */
> +static inline void bio_set_skip_dm_default_key(struct bio *bio)
> +{
> +}
> +
> +static inline bool bio_should_skip_dm_default_key(const struct bio *bio)
> +{
> +	return false;
> +}
> +
> +static inline void bio_clone_skip_dm_default_key(struct bio *dst,
> +						 const struct bio *src)
> +{
> +}
> +#endif /* !CONFIG_DM_DEFAULT_KEY */
> +
>  #endif /* __LINUX_BLK_CRYPTO_H */
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index dce7615c35e7e..2ee6a7e570796 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -247,10 +247,13 @@ struct bio {
>  #endif
>  #endif
>  
>  #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>  	struct bio_crypt_ctx	*bi_crypt_context;
> +#if IS_ENABLED(CONFIG_DM_DEFAULT_KEY)
> +	bool			bi_skip_dm_default_key;
> +#endif
>  #endif
>  
>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
>  	struct bio_integrity_payload *bi_integrity; /* data integrity */
>  #endif
> -- 
> 2.47.0
> 


