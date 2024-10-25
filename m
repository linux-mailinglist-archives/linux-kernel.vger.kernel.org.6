Return-Path: <linux-kernel+bounces-381124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955EF9AFAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48511C2208F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4C1B0F14;
	Fri, 25 Oct 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SgUUsyph"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1E18B46D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840169; cv=none; b=nV53d4EUfmmR+p1kg1kaqVPbvaQxx8/bg+J4SYsuj4xJEYHxQjoYS/RX2/pmlZK/0SM0VPqQpyqNc+yh2p4ennJdNWhhReyhSGN565qHMg29frXKQJDnP1esz2B2Sc90cr9GMnnvxEIX4g+iiYhVCf1ixdldLwRHnhsNO5g6X2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840169; c=relaxed/simple;
	bh=v+d+yOPP8wYvkjtoYov65gkr8gZMoo34pqrO3+iI9cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1YicmU0TjqGSk+SPtmAktk4yLwaAPA1/Pq49eid85qnheEtX/JtYGrZXxi/60oGlUXl13MAQGEDgjvH+XfycHsNBhQec+NUdH48k7nAWTH9RekwL9MK+UxfqpX51aGtJQHNkA+WH8CRmN5nTfRUAY1gWAFXmnVlXRDsRU06J+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=SgUUsyph; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1329851b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1729840167; x=1730444967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Il81+fKWvc3sFrEb/oXL1PU3sWta77/4Qv/NEUSwTPQ=;
        b=SgUUsyphrP+ac12Lz5euYzewvCjOH5hBpqcV0hWfuXNRr4k+RJP/yy2X1BC915evzA
         HdLD20m0hDCpaBXz1XHBKMxJdkPmbx+/+Oic4Gnt5xFIZjw5nmF7H7AR8MjnSKcvk5sw
         Uvzt9JdwL3cjkmAeCFFz5CwMB9Wc4QFrxardq1+YKCKA5mStSYQfZjDI4GLDTv3Htrrz
         mnNrsWCWaNJAjXgryFeT7crcQomI0nB4vPevJx3MySrU9r///mBwb/LSWg6X1yGOAdAn
         LmeoALONfRdeYPVqLY7xJ6826pXtE5BAZdI4n7ap68A7cEGR2vbBOYLqWo3k1jzFCjwr
         oS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729840167; x=1730444967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il81+fKWvc3sFrEb/oXL1PU3sWta77/4Qv/NEUSwTPQ=;
        b=QdL3WAHtHZinu/vavt/OFbYBIkFu2EyFrPIO+8zqtUvyU/IuLfuMSAdVAD1HfSVHHg
         hY1Dl/fpIQeEjTHSjWecdJEpGBwc0nhYQMEbEt7bGEERBuNTmH5dMaCBb26bpSRw4F3W
         I6c+HSyzNloBmZScL6A+hSTNkkMPgPsJOrbslqith6zf7gooPb2DVEZMAIuRxLhGAyA0
         fH2eRC+vSDdz0QF1QXiaOWCnfW76++wK/c2J59wZ2t21SMI3khQqeRGlhucLMAiGrv58
         ZMEh9CNTd8GqERkIsnr2rDGR64JvMCWgKklvPKYP9FAkZHgPVmiwb/HbqUaOhwmbVoyC
         PTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM5+Ve0hQrZB+oljpu8dvzc3OvcJrNFuPeHKr4/2pN37Uot8zcUqLD6w2xwTic2sXCRMnm0e4b4KKasO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/F1dwK4sP94jxPW54t4T+SlVvQ1LdESS/DK79KWzgFacKStV
	9G80845FPCqrr0rfaETyDP9+xLmAxdrKUoCnojTEQS8RDGQp3Qt6r8XxxFL+YA8=
X-Google-Smtp-Source: AGHT+IEunfT3jydLgKIpG/C/BUgRgj/e/o46LsP4/ImmpwMbVJFvTPS4/f0H4xVYWORV9p/v6jIWrg==
X-Received: by 2002:a05:6a21:394c:b0:1d9:2659:5da9 with SMTP id adf61e73a8af0-1d989a99601mr5824967637.18.1729840167168;
        Fri, 25 Oct 2024 00:09:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793190bsm475502b3a.54.2024.10.25.00.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:09:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t4ERo-005U5W-0R;
	Fri, 25 Oct 2024 18:09:24 +1100
Date: Fri, 25 Oct 2024 18:09:24 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chi Zhiling <chizhiling@163.com>
Cc: cem@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] xfs: Reduce unnecessary searches when searching for the
 best extents
Message-ID: <ZxtEJN/dTw9JipJe@dread.disaster.area>
References: <20241025023320.591468-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025023320.591468-1-chizhiling@163.com>

On Fri, Oct 25, 2024 at 10:33:20AM +0800, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> Recently, we found that the CPU spent a lot of time in
> xfs_alloc_ag_vextent_size when the filesystem has millions of fragmented
> spaces.
> 
> The reason is that we conducted much extra searching for extents that
> could not yield a better result, and these searches would cost a lot of
> time when there were millions of extents to search through. Even if we
> get the same result length, we don't switch our choice to the new one,
> so we can definitely terminate the search early.
> 
> Since the result length cannot exceed the found length, when the found
> length equals the best result length we already have, we can conclude
> the search.
> 
> We did a test in that filesystem:
> [root@localhost ~]# xfs_db -c freesp /dev/vdb
>    from      to extents  blocks    pct
>       1       1     215     215   0.01
>       2       3  994476 1988952  99.99

Ok, so you have *badly* fragmented free space. That going to cause
lots more problems than only "allocation searches take a long
time". e.g. you can't allocate inodes in a AG that is fragmented
this badly - not even sparse inode clusters....

> Before this patch:
>  0)               |  xfs_alloc_ag_vextent_size [xfs]() {
>  0) * 15597.94 us |  }
> 
> After this patch:
>  0)               |  xfs_alloc_ag_vextent_size [xfs]() {
>  0)   19.176 us    |  }

Yup, that's a good improvement.


> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>  fs/xfs/libxfs/xfs_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index 04f64cf9777e..22bdbb3e9980 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -1923,7 +1923,7 @@ xfs_alloc_ag_vextent_size(
>  				error = -EFSCORRUPTED;
>  				goto error0;
>  			}
> -			if (flen < bestrlen)
> +			if (flen <= bestrlen)
>  				break;
>  			busy = xfs_alloc_compute_aligned(args, fbno, flen,
>  					&rbno, &rlen, &busy_gen);

Yup, I think that works fine. We aren't caring about using locality
as a secondary search key so as soon as we have a candidate extent
of a length that that the remaining extents in the free space btree
can't improve on, we are done.

Nice work!

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

