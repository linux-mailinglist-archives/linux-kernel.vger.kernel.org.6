Return-Path: <linux-kernel+bounces-275691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA394887E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D85B2215A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736A15C12F;
	Tue,  6 Aug 2024 04:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zy0L9+tZ"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49115D477
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919774; cv=none; b=mxz63abBQJQHXA5UQjIHLCFRQzRvL5ZxlaX6lCg4FcI6ZJwIHct/U8olg+C8paCIvv/EtKa4eq40LDQIy5PxS3CMRQkAjyt32J5XUPuBLjhg44AhPwhUBcieWjv8mzGicW0LJA2aDi5juhOs1U/uehehl2mVIZQSAfvlBcsHID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919774; c=relaxed/simple;
	bh=zTCOmw6gISVXSp48IiCz6bMdu5nKagmz8qJ2lcvbZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl0EpNQ4ubcyQCxx/YQ8qGQx97Ln9NqmVrTnNHRhAwMvmX6W4CnSsgRA5YrRZOVCBrOp2phO/1O+MEYMrLBAs0+JoN8/ZT34O4CHzRsZwf41zHEyGP+WyoSkxTpB1QR4trDRq91wepnxUUmtpay9/rGLqWTR7m1NwmFhX99AX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zy0L9+tZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso145867a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 21:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722919772; x=1723524572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHH2ZM2ZbaCsMqJvKElXG0mbw5W5n4WMRbqy0wJyJXY=;
        b=Zy0L9+tZE/luJcWdvbBOQDYp+kLlncZyZfklFwj+Mt4EAl10coWLtD5PkFe0Vs1ghe
         IOEJ0CELQSd1SWgxxhlXGtawRHyAJiI+vw34S1EUr+rg1iVk3BXcLot+Fuh11fOT05id
         tP4WB6H7I6h5q4kFxW6pRnJ//ebtQqgWhkYscqLyEAYOo9phVCR2tdsGcKnRQ6dPUH77
         +RW3r35SwhFj3y5m+cmJWLN+qwNEgtX+k8eK2KqcXHttnLvjzx4y9eiBf3+fC5cgdUoW
         bcceApp4z50JV5sgJi60BRCfPNyGtfGlqB7sEQuS/vkRILpvVWObNKqg+UA2tP5FivWJ
         2L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722919772; x=1723524572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHH2ZM2ZbaCsMqJvKElXG0mbw5W5n4WMRbqy0wJyJXY=;
        b=UrfG337LpcErHkNxDNeALc0U4QG+FrLGWLdSeyIDzrkC/6tp2C7LmXtbP8nNjya9G8
         XjE0RT0Gj3WLvWGIiD+rpvnzGiXXhc7KnOL3/rbx0ysFDRgu9wbbWFmvu4Jz7TeyTbfv
         QeZlZUPEMc5DSwovIxxF7q1pTCPMMFi+ho186HjAeySlmrw9gTV05QwQwJs9G0NM42DR
         3sMEZnxUzZrBGa1Ud+bQnSj8jGQdEzw/BfVWBs8/3MRZdhHLNHe5ReUMGPx8ckapYQov
         BOdlkIt5EWFpXCNC+84ZsSqZYdQtHTYt5A7he6eF/v33SLRbrfud0YFDD5F4wsT8Uj64
         IQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWGJ2RD7gYcbvfKTS4QtyabJnNcCfvha/8mE0C4SvcWd6UZKJLxvUNu8XEL55sGR/DKI2BO0nVMqNNWGsi+pXyEj8er5swy+NevFTeA
X-Gm-Message-State: AOJu0YwHDKh9VN97XEuGnJMN+tcjDJ/YWwSmSrLSLTNCDFwiiVkMKCzt
	fE/K9Yf9PMP0LpyfJ5rA1hOTK8Y7L6fHF8f7ersmBWsTQ6l71nFSRgTd7gS/PCk=
X-Google-Smtp-Source: AGHT+IGIufVjk3jVXDFP+ZPCWH1xn0RILusDbBQ8tTUG4kEpwICOp9qYPfj0joz3IsRdV9VFGoKiNQ==
X-Received: by 2002:a17:90b:2307:b0:2ca:7636:2214 with SMTP id 98e67ed59e1d1-2cff9414339mr17227568a91.4.1722919771767;
        Mon, 05 Aug 2024 21:49:31 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc406468sm11668707a91.1.2024.08.05.21.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 21:49:30 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:19:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] cpufreq: spear: Fix uninitialized variable "i"
Message-ID: <20240806044928.2j6z2ucnzk6lg5y3@vireshk-i7>
References: <20240805202042.3229190-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805202042.3229190-1-robh@kernel.org>

On 05-08-24, 14:20, Rob Herring (Arm) wrote:
> The refactoring in commit dca2ef2b7d91 ("cpufreq: spear: Use
> of_property_for_each_u32() instead of open coding") left "i"
> uninitialized. Initialize it to 0.
> 
> Note that gcc doesn't detect this, only clang does.
> 
> Fixes: dca2ef2b7d91 ("cpufreq: spear: Use of_property_for_each_u32() instead of open coding")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408030418.gnJDcCpm-lkp@intel.com/
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/cpufreq/spear-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index 4d28147c23f1..f8c16699a68d 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -173,7 +173,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
>  	struct device_node *np;
>  	struct cpufreq_frequency_table *freq_tbl;
>  	u32 val;
> -	int cnt, i, ret;
> +	int cnt, i = 0, ret;

We don't increment 'i' anymore, don't we need an i++ in:

        freq_tbl[i].frequency = val;

?

-- 
viresh

