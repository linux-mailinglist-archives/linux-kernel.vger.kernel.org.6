Return-Path: <linux-kernel+bounces-198473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB7F8D7903
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72F728122F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A827D3E6;
	Sun,  2 Jun 2024 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uwHb1KUx"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A4770E6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717370560; cv=none; b=rDGtREdgABMiqR7G/+vJ4wtFaTIzk1Q6XpSbiq9e4IiBOuchgoaCquvgRc1vGmRqwLHQ4eFOwwUMDidPiMRHbZZleHJifQS1OF996wcRSC2rufTFzQkyhau10+Pg3JvgerpfezXZBPlds8Ud3UcuS9mQPqe0R0VIhNTyDFf78zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717370560; c=relaxed/simple;
	bh=BCauVUfC8uXO3rNkcLkFyjigTfVZ/pWoopZn06saXKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ/nWqRLY2ICuvb/AB8zGvYPhzjSjJC6+wiG2NtQBlj7R3WR/vILcgw7RP6r/aWAPNt23A4KIeuYhRdRVM0gpgJmO95CaD92taSB22iiBduGmlpg8EBbLSRMgm6jv8/4rlIuQtTYjjg0bQyeZzxejLTpCxM5ISBfgE/W3NpPFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uwHb1KUx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70259bdcf7cso801984b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717370558; x=1717975358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMZz/hfMDPMeBm9TTQvgkTSQG2xm4Pd/LaSyXt2DrG8=;
        b=uwHb1KUxNCu20iyc3uJzW4W9vlaCaXkyBNvr4F+FVofX7BVWdqCgN2AC81hy7c4S4h
         XlpvPNaEuO+Xf3wT3JFPvpccBjDMJjxO/zJyiXp/G0IdBB6T0d0npvp/IDdyKNEpjkT2
         00qw8gXEFwkYdyP0heWr0SF3+8fkKGxckpg4aKy4KHr0LDFHyrC/x0i+gNp4BjPdrX03
         84vZBi8nC4RKDE5R2eGjnWG5i5T3Uq2p5fXtjSF6MKJFLFbo3BKdfoz3tVqLepH0BHv6
         NKd6vFZ6YIcqZJTjhh3108nnCUk5G9E6DaDulKYEpShQoeTUXXbrJOjA3aaYnSYctyo0
         sfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717370558; x=1717975358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMZz/hfMDPMeBm9TTQvgkTSQG2xm4Pd/LaSyXt2DrG8=;
        b=Jgx3JQr8XJVEhymIhhlWlcsAW07C7hJU9hAFoRKxnkp585jXcM3eifvDY6kj7Kbb34
         OZzST8KS3CBUwvBTjBCFpRb7Qot0mz2bJOYpW+RkX2v59xrVCS4ZIFJ3r6K6/WIMMvjF
         RJsrCY+QhJwuAx6oCkbYyrAKJLKGFFNLAxj8mBXvK4hJOfdFMOD/r/8o98vpf6Q+CeWO
         yv/hf86RTp6xulzHgbqPCSYnqYFHrpTB5du7ZBdQITkJm7rRyOjhdk45RYVl7UkrZRLr
         IRmIjQbYc2VbWnxaMrvbcA74FXGRM/DmoHaBI+PtOckuINIQNsuUmJmi7GJDIM9+in3G
         ecrw==
X-Forwarded-Encrypted: i=1; AJvYcCV7kGOxOP6cxi+4aokCyEnu8iXr0lW5bZsjasGxrXD1/9AHElIeErpfWxrlT+wwGrKiA/dYnUwtkfpQ3rUIVUODH0VuJS2mISVdw0XW
X-Gm-Message-State: AOJu0YyssfNwKza3Kocksztobm7VR2vWmMOMiFhqzeLBczTRt0XuEOL2
	XHA9mxRAExGUg/aH3XL+92TGLri79rR00A/fzQT6e3gGvJq12XSaZajYKaIU8KI=
X-Google-Smtp-Source: AGHT+IGpRpKITHqY9FQ8NaSVtN7UtSeOVKDshRosxLiBJXgm9K3AzmnrJgeBMI9D7eZ56TtOGV2AnQ==
X-Received: by 2002:a05:6a00:847:b0:6f8:b262:5b15 with SMTP id d2e1a72fcca58-702477e9f67mr8377508b3a.11.1717370557986;
        Sun, 02 Jun 2024 16:22:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242aea324sm4633288b3a.109.2024.06.02.16.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 16:22:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sDuX4-002DDg-0z;
	Mon, 03 Jun 2024 09:22:34 +1000
Date: Mon, 3 Jun 2024 09:22:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: chandan.babu@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
	willy@infradead.org, djwong@kernel.org,
	linux-kernel@vger.kernel.org, hare@suse.de, john.g.garry@oracle.com,
	gost.dev@samsung.com, yang@os.amperecomputing.com,
	p.raghav@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, mcgrof@kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <Zlz+upnpESvduk7L@dread.disaster.area>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-8-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529134509.120826-8-kernel@pankajraghav.com>

On Wed, May 29, 2024 at 03:45:05PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> 
> After disucssing a bit in LSFMM about this, it was clear that using a
> PMD sized zero folio might not be a good idea[0], especially in platforms
> with 64k base page size, the huge zero folio can be as high as
> 512M just for zeroing small block sizes in the direct IO path.
> 
> The idea to use iomap_init to allocate 64k zero buffer was suggested by
> Dave Chinner as it gives decent tradeoff between memory usage and efficiency.
> 
> This is a good enough solution for now as moving beyond 64k block size
> in XFS might take a while. We can work on a more generic solution in the
> future to offer different sized zero folio that can go beyond 64k.
> 
> [0] https://lore.kernel.org/linux-fsdevel/ZkdcAsENj2mBHh91@casper.infradead.org/
> 
>  fs/internal.h          | 8 ++++++++
>  fs/iomap/buffered-io.c | 5 +++++
>  fs/iomap/direct-io.c   | 9 +++++++--
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 84f371193f74..18eedbb82c50 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -35,6 +35,14 @@ static inline void bdev_cache_init(void)
>  int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>  		get_block_t *get_block, const struct iomap *iomap);
>  
> +/*
> + * iomap/buffered-io.c
> + */
> +
> +#define ZERO_FSB_SIZE (65536)
> +#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
> +extern struct page *zero_fs_block;

This is really iomap direct IO private stuff. It should be visible
anywhere else...

> +
>  /*
>   * char_dev.c
>   */
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c5802a459334..2c0149c827cd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -42,6 +42,7 @@ struct iomap_folio_state {
>  };
>  
>  static struct bio_set iomap_ioend_bioset;
> +struct page *zero_fs_block;
>  
>  static inline bool ifs_is_fully_uptodate(struct folio *folio,
>  		struct iomap_folio_state *ifs)
> @@ -1998,6 +1999,10 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
>  
>  static int __init iomap_init(void)
>  {
> +	zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
> +	if (!zero_fs_block)
> +		return -ENOMEM;
> +
>  	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>  			   offsetof(struct iomap_ioend, io_bio),
>  			   BIOSET_NEED_BVECS);

just create an iomap_dio_init() function in iomap/direct-io.c
and call that from here. Then everything can be private to
iomap/direct-io.c...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

