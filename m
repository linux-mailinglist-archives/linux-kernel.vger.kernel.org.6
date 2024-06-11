Return-Path: <linux-kernel+bounces-209281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C610C90312C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F7B27141
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5B171E4B;
	Tue, 11 Jun 2024 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwaWTKtR"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F35171060
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083745; cv=none; b=jzgX9bxvH5JQF4lgy7ObHLz1zPhflFg51NYXjhegY46XFnMbfoafzAIg66spe9O5BxeJCRLbdimnRu4Lv4nK26grP+B+J30NprWvbPvQS7Tvh/feCDes3Ca6UaEPaPdv0khN8pEnDkh22cN6rf+ZGQ0qrREvuw0uviuvUFc+Yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083745; c=relaxed/simple;
	bh=J5bAxdXaTCX2laLzVh4rmT2+nkCm3xJ3GBnUd9t7xL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM4kXfa0h8fImLIAVAMaBPDLUozyM6xMsVtjInAsrTUpc61I0aLHi/M7O7to3e/6mr31YsnCb2raXVWRmrVOFN6d5eYT2WUnYFDkUDH1GpK9gsVDN/LwXCfpIkO2wqaJ5EpzGsCM0FVsbSGV6EknyUopep9fa6s/Cifl+XSL7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OwaWTKtR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c2eb5b1917so605795a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718083743; x=1718688543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyKm2iIwO08HuY648f4kYt9bhJZ4NfMxB3bBto/Qz70=;
        b=OwaWTKtRaZjXj+159T3grJfzpilmTwNSTm+pdef45ldHuSZU6bgMKyHVH8fQ0lrep9
         Q3lGgHdk667ShUYEpojvSoc4EDsPtbd6yy0NU83vpxgfMhtnvmSCpqul1DBHDYWM3a5J
         ywoGM/Btukjg8xPGl7JCSXOr70R7KO1nrOiL4AZdhZzwhCwTT4GQeryztq5SvMU7fmgc
         BvfWKMHsWnRO6RJx1J2lrbcAmoSKziaFylQmGFSCNE23ORKfVo+n7qY8uv8ggjrRAdQi
         nSL5IjZ7C+TcjFFy9apqcBajNNwrUDNZxJE1oZTMH1/s4tFFEJV0undpzJ+EBRbHd+kc
         Qu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718083743; x=1718688543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyKm2iIwO08HuY648f4kYt9bhJZ4NfMxB3bBto/Qz70=;
        b=fht1gOYn28iG9aA3R6oP6hVCnAPaIRIsHy4AmeN5UoNPZBw8TNFbafIgehoHOS0ofM
         1W8AHTbhp/VAWZWTsRek7Pf8d7UB4CkgLw/DI6NRs/hcCRR5UxHskRcTYVDcpa0hZIRk
         Ssc3ehIQe9Yws5GqX3hVT4WFQ6aVwzcy9EBXVdL4i4AAKOQmEVubKmyGRy33UmC4cxcD
         WyRb5lRtvPn6D8ULgMFYKmnJf+YshOD4HmjoHCj4pZJukuxgXfsID/NmDyV9YdGXvC6i
         XZpjpHnF+TYJrHX3kbCQDriD2O+A+qW9kOiQdeRTj4jcG6F0gxm3kSKFpOAAOcjyLzRx
         7tpw==
X-Forwarded-Encrypted: i=1; AJvYcCXxSR+tc8YHMBQ0ahvAN/i5Y1eu1FnkbHu+S8iw7Dr7YRn0HWx0/+z6GTXCFukRSYizYTL8kO6i8AjbOVxdFiHPZj7vm1VbjKNYXRIl
X-Gm-Message-State: AOJu0YwJaFtDCkeK6Yk14ST23yEEtYLaQV1LaFWUKOrBPLeDbHhrbDHK
	14AzqdIGtoYL+4JRU8zVGmBLcIkYTmp9s+eeuqUPAw+rAzoycJXj5h1M8KUZKho=
X-Google-Smtp-Source: AGHT+IGP3Ny54TMey997patAe+l/sTO0GdA0axZzTAAm9Wo4/b3ddc2Jen1cLYIdCSeGxM66OzCvPA==
X-Received: by 2002:a17:90a:dc09:b0:2c2:e175:4079 with SMTP id 98e67ed59e1d1-2c2e1754323mr7120030a91.48.1718083743030;
        Mon, 10 Jun 2024 22:29:03 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c21e28csm10250920a91.16.2024.06.10.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 22:29:02 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:59:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] OPP: ti: Fix ti_opp_supply_probe wrong return values
Message-ID: <20240611052900.e5phijnffzxnu2dz@vireshk-i7>
References: <20240606070127.3506240-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606070127.3506240-1-primoz.fiser@norik.com>

On 06-06-24, 09:01, Primoz Fiser wrote:
> Function ti_opp_supply_probe() since commit 6baee034cb55 ("OPP: ti:
> Migrate to dev_pm_opp_set_config_regulators()") returns wrong values
> when all goes well and hence driver probing eventually fails.
> 
> Fixes: 6baee034cb55 ("OPP: ti: Migrate to dev_pm_opp_set_config_regulators()")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  drivers/opp/ti-opp-supply.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index e3b97cd1fbbf..ec0056a4bb13 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -393,10 +393,12 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		_free_optimized_voltages(dev, &opp_data);
> +		return ret;
> +	}
>  
> -	return ret;
> +	return 0;
>  }

Applied. Thanks.

-- 
viresh

