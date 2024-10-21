Return-Path: <linux-kernel+bounces-373878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB49A5E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46F31F21C43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC1C1E1C0F;
	Mon, 21 Oct 2024 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BRbq5AcZ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFE1E1A2C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498421; cv=none; b=MmwPs857WrVDkVNj/WyuZhhD7MLMwZsESAEg5GNPfvakAB/zxQ6hK4uHza6DRwIchdtDxDVoSAaC/6tbyeEnKFj+kPBGXW7Fu8xlw4QRrpuGih1Yqyr/z66/69dy3ywKh3DNTWpznRDJOHVnRTLsUVcUNaGvnufc3RlfxdvP4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498421; c=relaxed/simple;
	bh=h0dSRN5aVnaI/bTvz9JTkUaXVI7M0yMT/ZQG/CoBhtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZAYNyau2gN6gSUdrkZZ59llMVv0LbozZlljLgAz/+QD+YYg3BzeLSpSTTnVbR8Yh7TN4VkK1SRzJaG9enfjTBvZotqyW8t3/v2235HlDd+spneCDa/9nWQWJzuPqlC6JgbdUSCpkqiEa1CZcOr0yfqZUQDHABAcdQBoQjY5EOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BRbq5AcZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso566036066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729498417; x=1730103217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZWxmndYcOZZ85jYs10Ky2hzEF5qsbgDei3uuETVLRo=;
        b=BRbq5AcZwt307ydYlAK1vnEwpqZuVEr7cXOEkT/ZkQvg9zjLCCn9AL/j++Ain5CUWl
         o5iXGE+imu3bILgR/tV1BQ99KDVkEFhixDF29gaNvHpPhjn3J7tHy2gYU75HKS9cet+U
         eoVLquCiZI7kG/cFtDQi/4y0foZdMs4IGE/4XYoYnTvvTgalsf4u83Rmf8LZG7T0zfDf
         T7+ZP0WeFxEMZ+Hz+gTPjBI+ns8Sb8eq76fbu2v7+yF/uTQPt1ahljxw8jiQqg7NVOZG
         msllpod0jK32G1LlrS8ZxF5Gq1nTYrJuRfaiaay1c38LN2/3lkvSEQL/awuwDbM7VXe+
         bmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498417; x=1730103217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZWxmndYcOZZ85jYs10Ky2hzEF5qsbgDei3uuETVLRo=;
        b=k68z7nnvwDhGvnqr12MUwO1jrliR9UoMNw9jhfxOEQuMCtR50fPlD98JVlzL9WzOp1
         j/UwkA4jh0hr0hwehoYlzIrvGQxLH+/3XxjxxgXjej/SkITjq89+4YWlPWvjWQQNWZ8i
         ryMPVdDd8jPtJFPhhpU1OBCtHsLh+IcjVhcVNYw0ev88Rai8Zfp673sfharYQoUrrQ3f
         UGH2EQZCB4/I/NAzsfoAD8Niwe5GS52Ixkbcrnfpp0UVXb3EZdr9BMDG35zQ1+7KT3D+
         rIsdRqrbo7TXYwqKLV8/g4DVlbHh07r0lTntWFe8tyY/h2U6SN91wN2cb9Dm3HfYLrON
         e5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVpK2v4dkYI0y7PiDOoi8QW7USINkYfcYrH+rEuD4JgOwayNOggthW1/SiSOCHGj6mDXplBU+5v7VDr2yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWKgh1xG5uvAozTdRwDgon1ryYYXeF03tEZ7AsawRu0tZ3dW0
	jFnlcm1FEUOhrUZT7o6J2wtINwa4ObNgUGxuOA4nfiScufF0GqhRB0O5d3G49RM=
X-Google-Smtp-Source: AGHT+IH6OUZvSau7zYJilrQ3BnOA5Jyne3edpM2fJujY3GAy9NDR+atmzAursD7ReEtWUYn2DtdlHg==
X-Received: by 2002:a17:907:1c24:b0:a9a:6d7:9c4 with SMTP id a640c23a62f3a-a9a69a63af8mr1163073366b.12.1729498414640;
        Mon, 21 Oct 2024 01:13:34 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370631sm173355166b.104.2024.10.21.01.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:13:34 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:13:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
Message-ID: <ZxYNLb0CiZyw31_q@tiehlicka>
References: <20241020051315.356103-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020051315.356103-1-yuzhao@google.com>

On Sat 19-10-24 23:13:15, Yu Zhao wrote:
> OOM kills due to vastly overestimated free highatomic reserves were
> observed:
> 
>   ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
>   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
>   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB
> 
> The second line above shows that the OOM kill was due to the following
> condition:
> 
>   free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)
> 
> And the third line shows there were no free pages in any
> MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> 'H'. Therefore __zone_watermark_unusable_free() overestimated free
> highatomic reserves. IOW, it underestimated the usable free memory by
> over 1GB, which resulted in the unnecessary OOM kill.

Why doesn't unreserve_highatomic_pageblock deal with this situation?

-- 
Michal Hocko
SUSE Labs

