Return-Path: <linux-kernel+bounces-239856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F415926622
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F198E282F28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C718308F;
	Wed,  3 Jul 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2uYEEO9"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7918308D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024189; cv=none; b=FRLgw5pnqc5Ec/7RCroMSmjVw9h2H37DxntDbmIo44aNME5L+krByNY1IJrLf5z5TKJc2R5YRg083LA8r0u1NOlOllgxKAS5zk6cLNMUAgthnfCYKvvhH5SHux0iv0uKRsBQNjXhGOc/EDZyq/3JC2l5BCLPsLwmjEbSvJZCUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024189; c=relaxed/simple;
	bh=aNIR/KnDS/D87sfRG4FlVLnAx/6qwlwcseVvnzirxcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU9CqKu1Q8u5VARmfbJlstTvwMVSuQKIYK51xholbNkIXLaNXAljPooQEDEHDgNO06nfVRXfeGzLXRAg7dh4oklgX2A5AlKXcJLj204HGVL4oUOrTTpXYjARJhlO2i5cCdB2T3W7Spa6ycyJq2vXwReBklcbNRoCNnFU6zp5Kd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I2uYEEO9; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c1d2f7ab69so2636347eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720024187; x=1720628987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5O6q9Z7NTtFmEDBkDLtJJ7YaO922XTE0oE8J7a41lQ=;
        b=I2uYEEO9rcyqhZ4co9AqcX57zQ0nq81P+3QsAUiC0+I0n0cuwUYM5kccQ4N7SkcYmv
         PhzjPp7VR9WVoiK1Z1tK+7dgWb4UXFjIatBjnoBcMizpaUTrurk5MlbLyFx0PZpcxQK8
         Hlo2KT9wLLLEB3y4pNL9AEr6Kbkqi+pMB3wNqbpGqHGqBWOD1l+31Fb6LPJXyPHNDpwr
         jY6YKJ+zzjo5OcJjTd9zFTdQcCugYk5lIfQ0i1bhsex1L38svd/Xa2/nbKlKYTDqMp1c
         HgJK0Ti96O6U6k3fXXI7EtwSJrlspjIqXxDDbsw70dApK1EVdhwkFjLHLw4nQ4rCJBG6
         0TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024187; x=1720628987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5O6q9Z7NTtFmEDBkDLtJJ7YaO922XTE0oE8J7a41lQ=;
        b=XNlKWRK6XZqy55GxX5l/Os4JudOLuTCBU7nqU7Vb8h5IW1HwilfQLH/mkA44RgbZDr
         vj0RdBw6eJH8Dp41ao0yMYD3WoIkoarDoG4e4QamJstJj/dac+MdJlOn+37o5OmPu5pR
         Qpq6H/ObneykDyorUUrjl0A1o/jl4IoL5WnTlW1rMb1VDwQSs/9xd1U92ylg6bE4B0JZ
         +fjMoAmvVeI89PBmeDE4RxYe+YMs9MQfxlNBihbAhYlasFmd8DNV4KpL/NHhoADNsuLB
         5BXGPXDKFwj4GfKCKVIYYQ7XWBrIzkhIxaqIjnmXnC5bWoD7Bnr29T9G2GuItnUmyFqI
         QDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY9LBZBo4Roiwb8YlplsLx1JHrwrbglYQAShMGH+znIzZwu39lBcmCQcAJ43pWi9ysI59Hy+3CvjkQalbhQd9s+50PFp23K/3qNtAf
X-Gm-Message-State: AOJu0YwmPcgEOoS27n04t4eMX8dNcmTrpC2rvZs/r/JaftXs1tNKf1rz
	29cJ8AMsV8fIYSaSYpwxZlYJylg8KaegrW7uzqfRmfjNCarI6VRbevRY+VJBX3c=
X-Google-Smtp-Source: AGHT+IFnI1l9XwT1ZvBLQOIlT5uXSniB7GOrgNmzGE2z+XTz39WZu8FlxPvNO7AijOn9ZpJCHUmshg==
X-Received: by 2002:a4a:5b43:0:b0:5c2:2a09:86fc with SMTP id 006d021491bc7-5c43905bd7fmr13341957eaf.5.1720024186912;
        Wed, 03 Jul 2024 09:29:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:f98c:6a49:dd6f:a36d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c414833f9dsm1542775eaf.15.2024.07.03.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:29:46 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:29:43 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Datta Shubhrajyoti <shubhrajyoti@ti.com>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] staging: iio: frequency: ad9834: Validate frequency
 parameter value
Message-ID: <59cc60a1-f6d6-4f9f-bc36-6b06315eaee4@suswa.mountain>
References: <20240703104734.12034-1-amishin@t-argos.ru>
 <20240703154506.25584-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703154506.25584-1-amishin@t-argos.ru>

On Wed, Jul 03, 2024 at 06:45:06PM +0300, Aleksandr Mishin wrote:
> In ad9834_write_frequency() clk_get_rate() can return 0. In such case
> ad9834_calc_freqreg() call will lead to division by zero. Checking
> 'if (fout > (clk_freq / 2))' doesn't protect in case of 'fout' is 0.
> ad9834_write_frequency() is called from ad9834_write(), where fout is
> taken from text buffer, which can contain any value.
> 
> Modify parameters checking.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v1->v2: Check if clk_freq == 0 directly instead of fout == 0
>  as suggested by Dan


Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


