Return-Path: <linux-kernel+bounces-383863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FED9B210E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9B92815E6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F76188A0E;
	Sun, 27 Oct 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="IjW6bUL0"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1514BF86
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730067999; cv=none; b=JsoOKX9H1gaUwFdctNVvXR8qDyuUT9UI1eGUIu4vCfKKUZBgXRH6k7UN8vjHNp+3nuz1GZM4leonbce6SNCT3C7YuuLDnCl+DDTSCbc+9U1zM8YjgWgT2Mq+5kvUYDZf5oebFcoTgrhn/dVTOOf1TObBI0WLMLtAyTkRdlZWmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730067999; c=relaxed/simple;
	bh=zMgjdlwzIGQ5AXpdeYA4WHxBtuo2laAJNVW4nG/kSKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH6XX5bwmp6kT2ioYYBY+0i07/fax5svRdofcaCOd3nrQVS1mE6tKBIdOhZMt1ZUkssDYo++oWygS9bN7V7YyPQyCL1UF7T61xm/ybUcVQCmRK8WIvpbkuZG500dPp2xU19RtV6DuC/679xnGpN61Mt3L7gHMt81TtGDzmBa8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=IjW6bUL0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2566834b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730067996; x=1730672796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5KLTPWrKVlL1s8NH4uZYFz8Mrab34cutllMbEGsnf0=;
        b=IjW6bUL0w0GP95A1OFoZtgJysmSK+I/YlutjD47ZGavOQkpRBMljk56UkLzQppNFLy
         NSCS5b2oTnbc6focB85L/cPvTl8aWbQtup/EHtoyGyhjD/zU+6dMqvS5464cJZHEzfVT
         YdPbiVD9GzQoN63AEALWVI7nWHv7JU5/rNGdW9t651c1gh5A9huuhP8Bnow3b6XaqagK
         OCg3ubri/hR/BGRapJLMW4T4yuKwJZ0ZKXyxzB/gIo+rGlZUFz123qiTKq5Gsw14VPdj
         I5d4U7tsa86RrwztM9D8lmbRwS7CKfuZPzzltx3ZCjo2CVahXpxWl6hWz5Ykzb7s4Q1Q
         Dcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730067996; x=1730672796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5KLTPWrKVlL1s8NH4uZYFz8Mrab34cutllMbEGsnf0=;
        b=BZRKRZGmK/PPVDJ7o/PZkZcSlfTxrvxt+1/t7EFy7RFoerOqm8OOrSIMwLWryu6kFJ
         CgJ4TqMbuZGS1H+P3V5k8/pExBkxB/aVor92tUbniJCvr7osSJzZGxGGWkHwv9Qe+bLZ
         LLz6FXDbFZic3GwNpramStRa2086AXwoPpZMl9U1C9Q7HZJxZIaU0m+NJ/hQwP7+kMGp
         z7nP0KPQfkPhojn4auQCyoAsZRulAAM5F6Rs5lh/gcHmlnKmM6shSk6osdfphrQa3YK4
         JQK5CWV5NgL+70HLYbipkZ7f5uncDiuveU+IwSu9TxCiZaUtxe2wPMW+jp1Ap/CmDwdx
         jU1g==
X-Forwarded-Encrypted: i=1; AJvYcCWVBK6cuiF0kGEDFgil9ieU6iPQkLm4MlOdjqgoDL3TN1X8MEO3TO9+JCEVjZW2Xvs4tjidT3CftmMRt30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+F3PxL+36ijYonaaipjgsJxTok7BghDAPAmQvoqbcZwKX7bE
	Yk2vMei+cDtXjCqnMfQ2XZsIav5f/vqlRx46YDWFA8WZkqvBwxhuXCSEYO1A75M=
X-Google-Smtp-Source: AGHT+IEAKeexdRAG9F5wrcM3jmaPqrDjugV8ZVU3CGrquy532srSBlH8YaKtAz3ee9RU27iCMWii5w==
X-Received: by 2002:a05:6a00:845:b0:71e:7674:4cf6 with SMTP id d2e1a72fcca58-72062f8335fmr9345518b3a.8.1730067995974;
        Sun, 27 Oct 2024 15:26:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057935dafsm4482206b3a.87.2024.10.27.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 15:26:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t5BiR-006eji-2a;
	Mon, 28 Oct 2024 09:26:31 +1100
Date: Mon, 28 Oct 2024 09:26:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for
 DIO atomic writes
Message-ID: <Zx6+F4Cl1owSDspD@dread.disaster.area>
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com>

On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
> also add a WARN_ON_ONCE and return -EIO as a safety net.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/file.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f9516121a036..af6ebd0ac0d6 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
> -	if (ret == -ENOTBLK)
> +	if (ret == -ENOTBLK) {
>  		ret = 0;
> +		/*
> +		 * iomap will never return -ENOTBLK if write fails for atomic
> +		 * write. But let's just add a safety net.
> +		 */
> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
> +			ret = -EIO;
> +	}

Why can't the iomap code return EIO in this case for IOCB_ATOMIC?
That way we don't have to put this logic into every filesystem.

When/if we start supporting atomic writes for buffered IO, then it's
worth pushing this out to filesystems, but right now it doesn't seem
necessary...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

