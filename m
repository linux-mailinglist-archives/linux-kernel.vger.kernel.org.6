Return-Path: <linux-kernel+bounces-209821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B3D903B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F6128A06E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2146517BB35;
	Tue, 11 Jun 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2Kg2GHp"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D917B4E7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107192; cv=none; b=HMw1K0Hjtttz9ME7H6aJJwPxCSHWWu7nhbVFiEg6CnMVvqS9HJvzqwCp+7Vd/0zd51cmVpsDiqRcEQAkNEEva8ZGaJPy+SJbkV+TSUbI4GJhMfJztvndtRl17s4TXVjMHMeYLjbVgqt1VU1qNsOYrmwGcgIXFwOshlQbEcB8WYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107192; c=relaxed/simple;
	bh=4iGuE74BDxwLQsO249KSKAU+HX6bPKIAwO4Q+EsyiZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlJATmDAiDgCT8FmAXvQZLNfXN7YG8wUjJJc7EoAU7Mmx+LCWgOmswydwVt4TOu1KCFTCPI80VZzK632hkxvO0h1mum4qMD1QI7jZNLaDajH0m7T6lwbcwJQcqHdR+qg8HKf8zbZJpvWcqaO5SiZuTf0MtMd9oP5TmpQOeZkjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2Kg2GHp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso11356381fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718107189; x=1718711989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQzSwJnKjLuXJbZmjfDwPRrFFzgmeR6RnIyFdcSdy0E=;
        b=K2Kg2GHpeYuymdgXBf9/uJaDx8sip9eOLWbD0qz0e3YWtikORR6f9eBVIADnFuM3TZ
         5Cyib8l8MGEleG6Mk5bRNBUBtEEBxEZ8yVgcVpDmacNDrbWRnqlBAV/tCWpocD0691Dh
         0xMYdfPJYPl+4mq7SXQycxcZXuPDh5Tz4wwrfLNZeScJ3em1QdLw6rPWcqTQxaSfAE2D
         LOSbHcA9/pSIQ5gGt/6fCO1KWfjhQtJUQployMKNgyR9KyNu+5g+tdCWD4VzuZhUW5T5
         kjkX4e8S/ehecwgKbnIxUEYQL8Vnt/Z99KBrXQy93sa/LGD+smoqUXIOYHoXHA1kLm3X
         JFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107189; x=1718711989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQzSwJnKjLuXJbZmjfDwPRrFFzgmeR6RnIyFdcSdy0E=;
        b=gWP1ATinjb24CBjp1REtTQMdksydEO8rk5abMeiTSMaaAPOnr0iCKHcvyx/7TYjBAB
         QdNcpnNkl9ZviM5zsWSt+wdkaqa2ViXK+tnwzhDnSN7YzMRWKV2cSJGk22ywwO4JXb/x
         99ZyAEe8KoMUP67sHBBxTVS3wHboKQ7s5i70LD09pZ4KFrlESmjHCJ1PegB9fDLgu2cJ
         UQxgmBeboF1XscqqCs3AA66yQV/zQ2GyqnzqFOXECh1dyG3wkAoPwUSR/KpP1xGXfVsx
         GwkL9Plc/r/p+ZjpW37URteXk60UTRZH5cTJZlYDb6qSsHaXYt0nAMcXvYQUF9pI1emD
         z0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXupZl5bqWy0ojfncPSjDbbPN3qidQqQc6Y4JODdVPHIeKmPF0zsFlLP7+ACVOyDj7B3bnKwjV64ByZrmJhH9hIIxcZVGA/8bazFKhq
X-Gm-Message-State: AOJu0YyWxBnn9jFrzg4cHtmdcp78iJCmRvVltVidg+MXGYPqM/+7V8UU
	qQQi4TWn2LI+bRM+wZfllpPbsM5QQSZTxSixeTq9WgPw/cooVf8Ku/x5V2yYSak=
X-Google-Smtp-Source: AGHT+IEiG6bWGoC6W+LaRwRWxsSHZi70nYVqL1c15B6JskQ3SX5MbNBNkF6Y9FVXqPDvhRbcmv3nnA==
X-Received: by 2002:a2e:7207:0:b0:2ea:e5ae:8ffb with SMTP id 38308e7fff4ca-2eae5ae90d3mr57066381fa.47.1718107188773;
        Tue, 11 Jun 2024 04:59:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41b05a8sm21198371fa.86.2024.06.11.04.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:59:48 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:59:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v5 6/7] misc: fastrpc: Fix ownership reassignment of
 remote heap
Message-ID: <xc2ys75plbtrenastitqafadfrtolpd3bjdqcrl3wnozpc6kdo@e6e73ousyea7>
References: <20240611103442.27198-1-quic_ekangupt@quicinc.com>
 <20240611103442.27198-7-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611103442.27198-7-quic_ekangupt@quicinc.com>

On Tue, Jun 11, 2024 at 04:04:39PM +0530, Ekansh Gupta wrote:
> Audio PD daemon will allocate memory for audio PD dynamic loading

What is Audio PD daemon? Is it something running on the CPU or on the
DSP? Is it adsprpcd or some other daemon?

> usage when it is attaching for the first time to audio PD. As
> part of this, the memory ownership is moved to the VM where

Which VM?

> audio PD can use it. In case daemon process is killed without any
> impact to DSP audio PD, the daemon process will retry to attach to
> audio PD and in this case memory won't be reallocated. If the invoke
> fails due to any reason, as part of err_invoke, the memory ownership
> is getting reassigned to HLOS even when the memory was not allocated.
> At this time the audio PD might still be using the memory and an
> attemp of ownership reassignment would result in memory issue.

What kind of 'memory issues'? Is it even possible to reclaim the memory
back?

> 
> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1ba85c70e3ff..24dc1cba40e9 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1238,6 +1238,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	struct fastrpc_phy_page pages[1];
>  	char *name;
>  	int err;
> +	bool scm_done = false;
>  	struct {
>  		int pgid;
>  		u32 namelen;
> @@ -1289,6 +1290,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
>  				goto err_map;
>  			}
> +			scm_done = true;
>  		}
>  	}
>  
> @@ -1324,7 +1326,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  
>  	return 0;
>  err_invoke:
> -	if (fl->cctx->vmcount) {
> +	if (fl->cctx->vmcount && scm_done) {
>  		u64 src_perms = 0;
>  		struct qcom_scm_vmperm dst_perms;
>  		u32 i;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

