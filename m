Return-Path: <linux-kernel+bounces-530124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94808A42F68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAEB3B0DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202FC1D5159;
	Mon, 24 Feb 2025 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XZDplTQP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06331917D0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433548; cv=none; b=HK9A4gNXe/mmFQVGbnKVLIXMbxWWNApeh1TB8+/P52fXPEicFPqSWJ54msnQwk3wyIDl8d9FtF0cIdMtvD2hG4H/dk8MJUl+Sig7ixidp4gp3RlfGF33pdk7lvhmZ+x90H/lgCPBi4u7/SOEN2R2p54NBvmAaA1NDA7v6PcYRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433548; c=relaxed/simple;
	bh=B8Um3eMk3hvqma38jKFiyIbEi663Dt3UgWX5h5sXLl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q406t4wEvD6dGNZnixWbGiz+QnNbNM7M6m5ZOfTRPGQqh5rFsQSPAFWpmomAE77s8INdAJ+hn4GHaeYIma4jaotkig8BU8QdlP28oPjYESQYcGUfTVCU5CDcg8AqkgPrj1gVDU5+fH2sZYQZLaBeKUaAPZwsTZCgUhL6PuvrV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XZDplTQP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220dc3831e3so92319645ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740433546; x=1741038346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baQcd4BlBbeci4pq+lkQS7gSttZ++rUKJi5374wmvuA=;
        b=XZDplTQPnT2QE+FR9MkNOp94a+o/ES4Ftkv3D99+hGCxy9U9g5/Ilt6ay0cHDhy9FX
         0m8cGAwuyTrwC3nEffFU7eijYtsAvsAql6LnIrmsao+iOfbmyx51POIBF4howRhzRMmb
         I0QkrjL7KMy74GCknt62ju5VLWfA908YhZxP3J3dvMVlAgmOeMqMwWjNo8Vl0vZ8Plh8
         EbSwK60l4YkLB9q2Bm2UsFSAs9Nq8cCQbYPUXmE6Uf7INaTG7mf9cb4L8eeWO3M/HFKL
         lvfJdJnpy9v5nBmUXFg8XlT2fob7WkHwx1OuO9bGkdoPB7+1ypSksihpX7ivHZbGpYk4
         ycKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433546; x=1741038346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baQcd4BlBbeci4pq+lkQS7gSttZ++rUKJi5374wmvuA=;
        b=Ve+2518azZTA4Z6nuvE0XxVjCs0DlZqCR2IbQrf+HqMKAY4KpOfInJmTKMyUQ4Sucs
         r2CKDgh6nzcuNRjM72hC/rbLsJBtcoAUv+he3h1D/U8TG+g2dHAwFuxkLj/DuVO90S4H
         3dmlaqUFEn5GE/jJrI+J3T3Cm0twn5qCxla6mNSmdYsszqK26SHnXWLpk+z6b1cx+UzT
         lrZk1wCoVWkm9hKTS1P5HwnKrIBCfghNQBWvQtBfurhefvftYVKlsBPeJOQGtfq6/pdF
         D1zYUnV5IeAaVownBurHNiys6sTcjQuNnSSgLcpFaI8DWp8pdKAkumXIPsOwdmbTNb1g
         rHBg==
X-Forwarded-Encrypted: i=1; AJvYcCUqLG8V13oRqhRqfdVfryPz8IK4fkRqypuMcVm6Rkvq/E8iDmpLYIzp9HAbpRyWeNHKQe4BQgKDQ+MPj6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDnamuspSKDXlzqGcLWLPOlHtIzl+cS/NTfQCSej1CMQMadOSc
	KLcmZyc9tiSa4DPu4l2v4Sgx5jXAp9ju6geEL+WtECeXRXxG5T7WTd/Z5t3S6XE=
X-Gm-Gg: ASbGnctE2zYrbOb768RyaKVUFz5i3GG/RAJe5mYlTGvWos+1eOdpRdhyAkRnjKJNvXi
	TwRzzbXMi3e3BzaoKKX9jwn8HfpZVe5HM6TORhMUUJOyEqkbCkqD4o1YNRIMFDwB++mYsmzSDiM
	xXeGd+/No4CaUMAio6+1dqRYpH0vS/1t3p7rzigDlm67LPG8wxtAXpxtHOyqf4lsbisjPZENw7C
	orefin9C3es+ctfaAGY3MTOMQCKJMGyaPEM1VzmdrtmjXlyD94ID2tfNbYK67whhvBubYfa+5CR
	hMVm2ycIT0cejYgISOLkMs8soQk1oK/rP2noDJ7Pc4/Htjij/y6+7QEprlILgRUygl0HeEgKTTY
	H6w==
X-Google-Smtp-Source: AGHT+IF1kivAJK+5XJv15nd3N2xNPfYMjBaPhJULgUhbrdplw1aav3juq/XyTUOTjPQZBXSn8PmxHg==
X-Received: by 2002:a05:6a00:3d0f:b0:732:61d2:8187 with SMTP id d2e1a72fcca58-7341411d7c9mr30371600b3a.11.1740433546051;
        Mon, 24 Feb 2025 13:45:46 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aeda8384d1esm114878a12.38.2025.02.24.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:45:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tmgGk-00000005Vo4-2uVO;
	Tue, 25 Feb 2025 08:45:42 +1100
Date: Tue, 25 Feb 2025 08:45:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/8][next] xfs: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <Z7zohueO2E3ZSpfj@dread.disaster.area>
References: <cover.1739957534.git.gustavoars@kernel.org>
 <e1b8405de7073547ed6252a314fb467680b4c7e8.1739957534.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b8405de7073547ed6252a314fb467680b4c7e8.1739957534.git.gustavoars@kernel.org>

On Mon, Feb 24, 2025 at 08:27:44PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Change the type of the middle struct members currently causing trouble
> from `struct bio` to `struct bio_hdr`.

What's this bio_hdr thing? You haven't sent the patch to the XFS
list, so we cannot review this for correctness. Please cc the
-entire- patch set to -all- recipients so we can see the whole
change in it's full context.

> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure `struct bio`, through which we can access the
> flexible-array member in it, if necessary.
> 
> With these changes fix 27 of the following warnings:
> 
> fs/xfs/xfs_log_priv.h:208:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/xfs/xfs_log.c      | 15 +++++++++------
>  fs/xfs/xfs_log_priv.h |  2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index f8851ff835de..7e8b71f64a46 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -1245,7 +1245,7 @@ xlog_ioend_work(
>  	}
>  
>  	xlog_state_done_syncing(iclog);
> -	bio_uninit(&iclog->ic_bio);
> +	bio_uninit(container_of(&iclog->ic_bio, struct bio, __hdr));

This is a pretty nasty conversion. The code is obviously correct
right now - the bio uses an external bvec table, so has no
associated allocated bvec space and so the bio isn't flexibly
sized.

Making the code more complex for humans to understand and get
right because "the compiler is dumb" is a bad tradeoff.

I also think this is a really nasty way of fixing the problem;
casting the fixed size structure to a flex sized structure that can
overlap other parent structure fields really isn't a good solution.
IMO, it is a recipe for unexpected memory corruption when the bio
isn't set up properly by the caller or there are bugs in the way the
bio is iterated/processed....

>  	return;
>  shutdown:
>  	xlog_force_shutdown(log, SHUTDOWN_LOG_IO_ERROR);
> diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
> index f3d78869e5e5..32abc48aef24 100644
> --- a/fs/xfs/xfs_log_priv.h
> +++ b/fs/xfs/xfs_log_priv.h
> @@ -205,7 +205,7 @@ typedef struct xlog_in_core {
>  #endif
>  	struct semaphore	ic_sema;
>  	struct work_struct	ic_end_io_work;
> -	struct bio		ic_bio;
> +	struct bio_hdr		ic_bio;
>  	struct bio_vec          ic_bvec[];

But then there is the bigger question: ic_bvec is a *fixed size*
that is allocated at mount time. The fact it is defined as a
flexible array is the problem here, not the embedding of a struct
bio. i.e. we've used a flex array to optimise away an extra
allocation in a non-performance sensitive path.

Hence if we had done it this way:

	struct bvec		*ic_bvecs;
	struct bio		ic_bio;		// must be last
};

and use another allocation for ic_bvecs in xlog_alloc_log() (similar
to how we do the separate allocation of the *ic_data buffer that is
mapped into ic_bio at IO time), then none of the code that accesses
ic_bio for IO purposes needs to change and the compiler warnings go
away. That's a much cleaner solution that requires no extra
cognitive load on developers to maintain in correct working order.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

