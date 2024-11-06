Return-Path: <linux-kernel+bounces-398969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655989BF8A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1529B224AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A301D9337;
	Wed,  6 Nov 2024 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkRxEy0h"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392932EAE0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929541; cv=none; b=dbX4xg7EwxnxqV+Va5onnaNoQ4VIyx4WyS4EsuFieG8xd1ILfsemkJ9ECMuR8Cb3PXzTeLFBgrdmi7YzdNyxHaFnZCvIjRJA6+XMfC8GG/x4wagMeeS/7sA/QANUIHjHAierIS3bj8Cve7j9Ge6BKVLvjOiQFWqAyp3enZtSlA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929541; c=relaxed/simple;
	bh=3XjTb8z/OatcAGlD70H52F9d4EjSpcmkKKzfQEYX9JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i38MuQO3LtZ09oyx3Hz3oWK6lsIIRYv1ht07erPzwbKH357c+A4tzZepjhqqV/2A+3+AbVjnYTv/RwDB1BEZEbJWJdehcLVgnIXNVrEru7DsFxuu5k7FYJQ1aMTCy0/pocJCDSHg6IJQl/xFgpHOEsc5Gnaf9oPvP95ks+1tamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkRxEy0h; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d47b38336so167647f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730929536; x=1731534336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZG/igyMP++w3vhsSNt9GffWfG68As9xDtf6/9FjLaY=;
        b=PkRxEy0h0Ur+Jmh5tYHalLezV8YDHl6inrztumpRGeRT6rT2BOhw6NslKTfYlDBhHP
         dLxc6sDxitlOQgHyF451KlSXZ1oYfnCQUSRmf3wOv17aciImpNYtACYMyXLNIvEMdcqR
         eTLVA9bNLG2FhPXuZhsKRmruzb0yN5pYdA8t+veQFTFvwTwfwK1bI2J6D/PJDD+z2LhY
         0yay148HPPK0aQw3nx+LtpgGkNI0ckYGxGV+Wgu0yxzWlOfgv5J3z9ST59qjQTIJsric
         PLX5SJ04rD0DePLSS7Ik0TLmwTTSXqKdMQbNJzM/dapZlgXcZ/r8I5XBfvkImNhs8O3C
         bHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929536; x=1731534336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZG/igyMP++w3vhsSNt9GffWfG68As9xDtf6/9FjLaY=;
        b=LGBmGHhwoA1mDTsWLLa4YbIZ5DvIKD3EOvjDIBIik8i4G1NyXGqd1hNPeLUZJA11Og
         9/QVqoFrVsnCRl6lIwFPTymezPVRQccpz/NZE8CLX0+srv2NEufuNRbZ9XPqEkGzZL3L
         iIxjbkaNBqBh/ADy90te0fmQ3dqbRUgRZJalAfst0OKP4fQGrBHd5La2kNaeG+Ab7KFh
         9NJ9rMqe0tMQaheZHJn87HYvO13TOzamIZN3ee5/T/mGDu6I6Ft/K3HXjMwz/jZRv83g
         WhdwD2tvyOlmitRQ+Vyahmdtxb/Hc7L9Cu/N7Lm2Hev+Ca1MqPVD6xiZMREyk6EzbpeR
         gzIg==
X-Forwarded-Encrypted: i=1; AJvYcCUl5Tj1YTv1pStAOLBW986EvmU/pWYP2/6uhzYKNhj519Z1UIlE9jIWLVVqfRd0pEsDXUWuoZOpM0UQfU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uWoeFOjKcFTDMyoy3b+LLXrL5DdvMwpyAgS5t/pzsriMpCXC
	Zp8GlniuFTswVJKuy3zg6USd1QGtMltsp3UPd6M6/EO2UL+R+PfoKfRn4TZUHJU=
X-Google-Smtp-Source: AGHT+IGQ0v+koMdAwFpvu3s3vBOtc/f9ove0xeGvJGuO0IWV0GiECd61P64DFb85ruuM8ktF6Hv5hQ==
X-Received: by 2002:a05:6000:12c5:b0:37c:c5be:1121 with SMTP id ffacd0b85a97d-380610f7bb8mr28648760f8f.9.1730929535965;
        Wed, 06 Nov 2024 13:45:35 -0800 (PST)
Received: from localhost ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm20333098f8f.49.2024.11.06.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 13:45:35 -0800 (PST)
Date: Thu, 7 Nov 2024 00:45:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs/9p: remove redundant variable ret
Message-ID: <23a44a2f-2a99-47a7-a446-d96b5adf62ec@suswa.mountain>
References: <20241106152209.1626630-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106152209.1626630-1-colin.i.king@gmail.com>

On Wed, Nov 06, 2024 at 03:22:09PM +0000, Colin Ian King wrote:
> The assignments and return checks on ret are redundant. Clean up
> the code by just returning the return value from the call to
> v9fs_init_inode_cache.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/9p/v9fs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 281a1ed03a04..ee0a374e0d9d 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -661,12 +661,7 @@ static void v9fs_destroy_inode_cache(void)
>  
>  static int v9fs_cache_register(void)
>  {
> -	int ret;
> -
> -	ret = v9fs_init_inode_cache();
> -	if (ret < 0)
> -		return ret;
> -	return ret;
> +	return v9fs_init_inode_cache();
>  }

Better to delete the whole function and call v9fs_init_inode_cache()
directly.

regards,
dan carpenter


