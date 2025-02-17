Return-Path: <linux-kernel+bounces-518367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA44A38E05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3449A1890C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7467383;
	Mon, 17 Feb 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iSnbtykA"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0219E968
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827922; cv=none; b=dQgh1WS3YhruFJU9N9KBtPfydwwPCcIe0i4CtmKyHvB2PAcItow5AgDetRe8KQ31GYTmh4KquvUGZWn1W8OJhKnjSOOqog6o0UDO/XkCw3nhSH0XKU3imkPW4vQax2XHVwqQYTaV4qXn6yDpefV4uqplCU2GyI50tzAHi6UhkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827922; c=relaxed/simple;
	bh=5Z3w6D6rLKLuQ6zEjNL6ikv+CipM0JHOZMCbXFfqNBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9JLnzs3CcJ4Yrnof3ZVjljeoaxjOKTDsUiyPRpHhlzZnU2eFDaOFcFZsMfLvu4FfzODxpWBOb7uqUBHdAughEDfdujT53BxmI9Y1xd/6y2tLReAc2BL+K1Ndmrr6iNB14hwg746gF6UvmcFygbfIcJWqGa853ydvoUQdugSBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iSnbtykA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso9586748a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739827919; x=1740432719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhTfy1/ybvgYfqGEX8d/5gFaFMopC4YNbC7hGVBL/4c=;
        b=iSnbtykAPgeoaamX/D5Xv39Q6ZYYIHEVE4zgMl66cwZvyQ48oaYzC/IgKLS86w/HD5
         CKBcfACcqxE79g5417jqRYfPLcOSB6GqY0F0IGgHXLJSrAsw+pHW+/BrFDI6sARK9/gu
         Ykml65dgc1/utgt1Fmn5RhHyRVJuUcEvZU3xJchUB3WXLYnbSu+ReTOwGxknLjjSZHeX
         98GJwsv/gTKG2lH8c9qcf91n5QTxQQ0DqQEQLYYDOqXZmgxu6lKi/Skz8q+fHbi/IGsU
         A5VQDVfWr3DZcIo3115AKKu7y5dD6S6IG87n4slcw011eIp41wnUCyXKCC04ss9B4jwe
         KEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739827919; x=1740432719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhTfy1/ybvgYfqGEX8d/5gFaFMopC4YNbC7hGVBL/4c=;
        b=YDKU8HmagR7OSrHZHA9+Ye4a0zHJmXI7mKVoXDtIjIu7+zJnaBOi0/GSWR3CqwXmLt
         wNeJw82zVQ+txIBYiaEN+a1ZuUr1UZVsDhrleclwwIBbYMJ+cjgaIttmqGVK67BwFomY
         8B8vLjlVw4z9D5RpvsIUUb/JmhPQlPm3Q8SwZUxCDq/kYpye3TUoFFv7ex4dibZeUBaL
         MlH2EwwgeCFtI2XIS2Cw5ziQVk4UiR1j4Uct6bdj31uvAMGWpIICen3Sllvj+3XUX34S
         HZGLhz+3B63zdSxcPp9H2p8Ln+gXm8/0hoD+hErvSXjooGSz26ZFEAc93TIgWBIGR2V8
         OtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc7EvACA939WIw8FJXYlgUm/BETIL07NXjLX4cln1HqZfjIOcdqpjQoItOTbJDpXGicEFEdVUVBeB3hII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkrBOh0kktQcWUS2zV1DNTNUNZI4SP7dE1ji0ZZr1nsB+j6N9
	bpu58iXuxdcikIiFnt4DBxUZUusOlZmmBz2tnUz3ZxAKBwbr5c+UXlekaAu5wJA=
X-Gm-Gg: ASbGncsMOjgw298caAvcwSdpZAtdi69WvS63xT9vDYZHEFZWnVDpInj7Y+ZagwUamC2
	DOJCqqOx94FbDuc3/ap3b+qyp2VQ4EJ0jjNBLtY8ySQzKn/B8gamjhhcixgSH1rdpyqjOIS5/KI
	9T/+QK86+0kaXG32UuYU25nbcU6ovGGWjSMAWNDTN1fnQzEvsjzKq0tWKMlqdz3vX1WW/iG2tbX
	M5i14BHNNni+bg8dw5JaNvN5362IftAoIft30k3SPLKQB7c6dtb10bdoKy8K/Kx6mo9is6pYq4j
	Fo+m3Ri4KwxmOv28r/EAfmcEvn0QhzG6nTMW+0tJurmOICwtvjIa9br8Qj92EKJnQCg=
X-Google-Smtp-Source: AGHT+IGWbBJAtL2UtKSWCS6Jd9Ns/0Md8Y1s79IB++xb28sgasLU0+0/qaH46F3zNCw25wym7QqlJQ==
X-Received: by 2002:a17:90b:3b4b:b0:2ee:fdf3:390d with SMTP id 98e67ed59e1d1-2fc4115087fmr15333822a91.31.1739827918683;
        Mon, 17 Feb 2025 13:31:58 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491d4sm76091525ad.4.2025.02.17.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 13:31:58 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tk8iZ-00000002XxN-2C1Y;
	Tue, 18 Feb 2025 08:31:55 +1100
Date: Tue, 18 Feb 2025 08:31:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC] mm: alloc_pages_bulk: remove assumption of populating only
 NULL elements
Message-ID: <Z7Oqy2j4xew7FW9Z@dread.disaster.area>
References: <20250217123127.3674033-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217123127.3674033-1-linyunsheng@huawei.com>

On Mon, Feb 17, 2025 at 08:31:23PM +0800, Yunsheng Lin wrote:
> As mentioned in [1], it seems odd to check NULL elements in
> the middle of page bulk allocating, and it seems caller can
> do a better job of bulk allocating pages into a whole array
> sequentially without checking NULL elements first before
> doing the page bulk allocation.
....

IMO, the new API is a poor one, and you've demonstrated it clearly
in this patch.

.....

> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 15bb790359f8..9e1ce0ab9c35 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -377,16 +377,17 @@ xfs_buf_alloc_pages(
>  	 * least one extra page.
>  	 */
>  	for (;;) {
> -		long	last = filled;
> +		long	alloc;
>  
> -		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
> -					  bp->b_pages);
> +		alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
> +					 bp->b_pages + refill);
> +		refill += alloc;
>  		if (filled == bp->b_page_count) {
>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
>  			break;
>  		}
>  
> -		if (filled != last)
> +		if (alloc)
>  			continue;

You didn't even compile this code - refill is not defined
anywhere.

Even if it did complile, you clearly didn't test it. The logic is
broken (what updates filled?) and will result in the first
allocation attempt succeeding and then falling into an endless retry
loop.

i.e. you stepped on the API landmine of your own creation where
it is impossible to tell the difference between alloc_pages_bulk()
returning "memory allocation failed, you need to retry" and
it returning "array is full, nothing more to allocate". Both these
cases now return 0.

The existing code returns nr_populated in both cases, so it doesn't
matter why alloc_pages_bulk() returns with nr_populated != full, it
is very clear that we still need to allocate more memory to fill it.

The whole point of the existing API is to prevent callers from
making stupid, hard to spot logic mistakes like this. Forcing
callers to track both empty slots and how full the array is itself,
whilst also constraining where in the array empty slots can occur
greatly reduces both the safety and functionality that
alloc_pages_bulk() provides. Anyone that has code that wants to
steal a random page from the array and then refill it now has a heap
more complex code to add to their allocator wrapper.

IOWs, you just demonstrated why the existing API is more desirable
than a highly constrained, slightly faster API that requires callers
to get every detail right. i.e. it's hard to get it wrong with the
existing API, yet it's so easy to make mistakes with the proposed
API that the patch proposing the change has serious bugs in it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

