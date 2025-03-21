Return-Path: <linux-kernel+bounces-571562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B0A6BEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29500189DD5B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7891422B8BD;
	Fri, 21 Mar 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVhy2h5b"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427262236E8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572368; cv=none; b=aGIMsk1FqulldMl7TqhLokywZ2LGjd53w7BRSMuvsUrZa2iG2vG+UxfYezPpJYgt4T7bz+xx7isO4mqli+KDlM3pJUl7Rs8+0O1TWC7PLDHbM+YcKdeq1pcE1+9XSXFey9URzbai/87l58ZY81kEQxDD2ZFbVtlIqKM8zdgWFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572368; c=relaxed/simple;
	bh=xpYgzgHCL4aEs4Sob005xZZC6yqrNkMibisYuCubHz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF+wuvCC8VuB3/CTyoJQ1JEn9mr2yzj5xtvV+s/TynO2BueLaJjKDdtoucy9aTjarjqaA/MvPXtOdm88D7oMAD5SwDIGhInrZB01FKfWiauA/VIy9Veqxuew7UjjcZHot/jrwZXSWg4C8ZuGGCRuTLznqoY2yijIockxE5Hw4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVhy2h5b; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239c066347so50886715ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742572366; x=1743177166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCFz2rwGIAFnKYLAQKQtiSfZpDubMLmmJ+Yie3s1lJI=;
        b=ZVhy2h5bc6N6kGBqvwMhqsfxNopyPNp1bZRvn8lhv6LyKpMrNojbQSw4ci9e6o1GHX
         rudNXM9Yj0dIKG6xeWTVjnJit3vHiZjccYkaQ0FRY12gf5ZCNFuaFQNEU7IBqYXkMHBh
         W8vTqck3okTLw8mS5uvK8T4GSGlfkr8uGXhJlf64FarQCINFAxF7G9kEQcK1u5ybn0eb
         OCIvV2JB5wyV1sRuUICWtFdt2EvlVXbgYBo7F2YpbDJdFuhdrtXcGWrnRBkARWDwFPHc
         qFWEqqwk2s5itoEX+GaM13MuHDVI1yrsUC429tDTp1JiWJoaxfzcNyNGqb5xpEpgIoTv
         XkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572366; x=1743177166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCFz2rwGIAFnKYLAQKQtiSfZpDubMLmmJ+Yie3s1lJI=;
        b=CxB0FRNgNJhs/Fs/5BVtXKVcUvWTyXmrj8YfjeDRBUd4bTSqW3hsWHKTjTMu22y3/Z
         8wSugUa4jc5iT+m4z/A6L2tcEXRto9NI9EluNF2jKTMiFsNb7gehMpnx+zRZKIxb6M4Y
         ogPU4JIZNq4d54+eojeOel7yRWz4ADCNDB/tE34oK0DjbDW5DnmDCD/Oa5RZ/Pysr3UU
         eodGtX2s0ljBFxXtBU+lg4nkuoEmtQWiNoXAiHY8+UMkdgcyxTE1mXnt7kgtDjIKEWTR
         k+BtxuD61OptrEbNM0+00zsyqDUnQDMaSuPaNAiighA2mglw7JoRCi02dCT4vDw9ZOtU
         Tb7g==
X-Forwarded-Encrypted: i=1; AJvYcCUIdoUnZUfGLfGU/pAUpPi90PI10OY4YqRyEAcFgb/i0tto5+G1sI6+RXJAhKanJFCWJgTefn9vATQJ1DM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ktQZk9Vh6yPj0JdzjMPxXBO4rCQB9wYwFJE1PnZNR/qMxs2g
	YSTL3bCgRKpriw7FTaKijVxAJ1QEoBgLDdWHTW8b1657uOF/Ro3vOD0ntDYBCEwnRO8p6mKH43M
	B
X-Gm-Gg: ASbGncs5FB/W1ypAI8YfQ+FYl7omFZTKrFLHHUDLNr1NmdaKDK3pDMP28NxTF3VX8iB
	67ZjVPxzULVxSCHMkHcpZKB7hcFSZyOxciidNClzLyTvOB7xjihH5WtMefXnPKvJNY1PZ9PwdjI
	O+XIIKdi+MwJ060PFTwP+e2VF7K34Rd5lCFpCgUkdRdjXQBNmIodZez2WZy5X3d2+RbKtsvV7Aw
	cocAEQLyFbwlH9iMJvC8F0CWV9bNFDCx2gTigCCwPYY1ls2kcfHtba66sBxhkgQn4+dVgp7DcV5
	JvcnZqKRUU7cMc9b0/9vbQKe2DIswdEmfw/JyCq3aiWjcVIz
X-Google-Smtp-Source: AGHT+IFDoL8HtMQQvWLSLI6uOiwTX+pZ2lnqoCldu1lYiPBXMUuoqLjtzjra8Rpnqa21NHhQvW6mZg==
X-Received: by 2002:a17:903:184:b0:223:44dc:3f36 with SMTP id d9443c01a7336-22780e5fc09mr63627365ad.43.1742572366501;
        Fri, 21 Mar 2025 08:52:46 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:9008:6e45:38ee:5d82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf63716fsm6232763a91.47.2025.03.21.08.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:52:45 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:52:43 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 09/57] irqdomain: remoteproc: Switch to
 of_fwnode_handle()
Message-ID: <Z92LSzOZfp-OCqZt@p14s>
References: <20250319092951.37667-1-jirislaby@kernel.org>
 <20250319092951.37667-10-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319092951.37667-10-jirislaby@kernel.org>

On Wed, Mar 19, 2025 at 10:29:02AM +0100, Jiri Slaby (SUSE) wrote:
> of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
> defined of_fwnode_handle(). The former is in the process of being
> removed, so use the latter instead.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: linux-remoteproc@vger.kernel.org
> ---
>  drivers/remoteproc/pru_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 1656574b7317..4a4eb9c0b133 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -563,7 +563,7 @@ static int pru_handle_intrmap(struct rproc *rproc)
>  		return -ENODEV;
>  	}
>  
> -	fwspec.fwnode = of_node_to_fwnode(irq_parent);
> +	fwspec.fwnode = of_fwnode_handle(irq_parent);

Applied.

Thanks,
Mathieu

>  	fwspec.param_count = 3;
>  	for (i = 0; i < pru->evt_count; i++) {
>  		fwspec.param[0] = rsc->pru_intc_map[i].event;
> -- 
> 2.49.0
> 

