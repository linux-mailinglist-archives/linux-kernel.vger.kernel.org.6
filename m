Return-Path: <linux-kernel+bounces-568010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3BCA68CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C738189154A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F775253F2A;
	Wed, 19 Mar 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/pYHM4+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE87372
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387469; cv=none; b=nYzSi/fB5TTckMpebDHk8FOxiCm4qaYNAulC0fNWjoU+mzCgC3ffX2HSoDYTbOsxdsGGVrYMlVCbX5A2Ib3znxu7MKKCQ4ltJEHAfWrkCvLfATNrS8pAy9F6s0XJH678Sz0EUPrtrKYRxCRjBDrbjLPw9tSwGpZZvr/e1PfsMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387469; c=relaxed/simple;
	bh=8Zl6EbMiBAInVqz4phQnB5mGB+cjBHeRcD82DosQexw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCiH14oJRT0LcpPk0qvWo0nHwAhVpFi5bcZDjukGPb6PQPT4S5eWPOxFLRJSMElYb4N/ZrbNkwU0XKy9hv0Ie87s8IPo9JraKG5TMkIcTlcORD57rAn47D3jhkVA9jSiLB84Ye3dIqOkDk4EyJ5IzkzCQ2I8KNWhUhFuXqrBQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/pYHM4+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso32409885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742387466; x=1742992266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APw5roZ0SwNdDnAV7zjswJlLE3ojquwnF9XsXaCcy8U=;
        b=W/pYHM4+wpNm2aLeQsDJ+9dDyht9BloZjtFQUC6pVPVEjp+5Pe9fAMWkL3xnx9OtZs
         uR8pvnFGU6xvFre4qhOxhvoyMmufAmw3l/H2bkZfAaOvWqqKZua2mODoSxEz4wLPBNvq
         A+uCogZ4/uyKWyt6Fd2ibI3NcqHq8d1JjP7sQkhlgLlPiTRvpjnobAn8m7iONVADy2lx
         SoCIx7d15Z72AZlbxNqd8GtbuYWtIanyTSGhn8JuI+Kc2esMvaDDVeHMR+8iyYSiQm5w
         dghvDBiTCihe8Chp+h6WDFflCanR636EcvLXoJ03rWTBkwnrt54ycvuoG6qHD1XXKthW
         m1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742387466; x=1742992266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APw5roZ0SwNdDnAV7zjswJlLE3ojquwnF9XsXaCcy8U=;
        b=voNPVjn81D8g+XrLWdwxac0Kq/VvPX3GoM0zoW7OMoTwmoDjTJMqAWFcne6HNXmW3x
         uzJRNVFBdrfaWf25knKRZvCVQWpqGpUpIeAINHP4mjsrYGcLsgg7nsT3KXuAX0YS8wZT
         ZWJEmM0+1I5MPw2HG6ncERN2YH5STXnSRiAIXA5yggNphNsjeauXkPQDY0uIjwo9KVJ8
         5n9i/cH+H2E8BNLBXvqIpGD+aCwlEQx+yzKMiOq2HgSXWnYcIPDUWalHiMOWyQytpruK
         4q7ZgnpT+EPYp3ZH3yaAS6umGp8/izRvuArh0+qkNeJgI9fn13/NXVVekdmSWHCkC4wJ
         TiRg==
X-Forwarded-Encrypted: i=1; AJvYcCVlv8iOMqUUyeNMxvxL97F4DmUbPoSWfoC6SyAKvSqZLRUonFzvGfxP6GW2M3YjEZ1j5S3jn5PUGzgMj/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8xzAKBmceNeNZTKIdkaAIsxjvu4/dAVXPpaN4OSa5Kar45MA
	nOF0eO0tmAlMlRioxYCaB6uaG5LAuxtfo746wj5BMEC7JpU2wpSHM+BSHME044I=
X-Gm-Gg: ASbGncsEwNUT9wqbvKtsIeDGU+TWCbnXtl6Ez1oQ+MIKrAgDp5FUjLpjRT65MeE3bSp
	bdb2XRSfe98gYjLanbmJ+hEQBKL/8lRlZfqJNDpJFblP3UdH48JzJI+aqucf/uiPzNA7s87H//Q
	7WK7QMdi/NmzfynlXuBj+gDy4UPdeu7bpBDvqUfLVKS48eI0v/FNnXHf0YXqfWvIWNzbRWXEBuR
	VMTSZLRcgEpPflUL2a2FFKkbmDZ5Hq8Ol2Hkx35a26rXrPmUz+33PG85hJctT9TMt7hFIqGdkAS
	RjfS6EvQwxbn8Po43aZt/nTOSRkfypa3Qnk+pF8/zcYQ2qFTRg==
X-Google-Smtp-Source: AGHT+IH5gBq2KWLgBq7WpJUU07oAE/+qUjAOTHRdyHSwsN6mzL5qmAYtEHrU8HiKf7wPT/AHNvl3+A==
X-Received: by 2002:a05:600c:c115:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-43d43bee99emr13202575e9.21.1742387466306;
        Wed, 19 Mar 2025 05:31:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f43cbasm17403325e9.9.2025.03.19.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:31:05 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:31:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] f2fs: remove redundant assignment to variable err
Message-ID: <a9c06462-5fd2-4724-9d44-0285f281ecec@stanley.mountain>
References: <20250319113011.791319-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319113011.791319-1-colin.i.king@gmail.com>

On Wed, Mar 19, 2025 at 11:30:10AM +0000, Colin Ian King wrote:
> The variable err is being assigned a value zero and then the following
> goto page_hit reassigns err a new value. The zero assignment is redundant
> and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/f2fs/node.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 5f15c224bf78..37c76bb19a8c 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1497,7 +1497,6 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
>  	if (err < 0) {
>  		goto out_put_err;
>  	} else if (err == LOCKED_PAGE) {
> -		err = 0;
>  		goto page_hit;
>  	}

We could remove the curly braces as well.

regards,
dan carpenter


