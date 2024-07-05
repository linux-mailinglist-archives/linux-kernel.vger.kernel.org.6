Return-Path: <linux-kernel+bounces-242911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B2928EBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883B6B268D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18B1459F5;
	Fri,  5 Jul 2024 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSyzUU+B"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F01C693
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720214162; cv=none; b=qh6v5scZ7kOYBo1Erh0DgQNWGIsi/Avb/uUZMEKMqRgt9mTCFH+pNJroA7we7rnFx+KFdWOGn4NgTt1JIIQfVhbziNQWlGcvkmGMA93FAlVSjMJGe+s37gZ0+8BG0Rt6vobWNEKAQ17irwzDa3EVKWapglZvNETZvfb8+tkRU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720214162; c=relaxed/simple;
	bh=Ic2LbMsnguoiVKQxFU8pj07QFdAiHGA4m/Zz8tgBXXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp7y6MiAWpEEQ9haMA+i4caqRotY4NffV8jspJD7IDYlfnIQ5RNHvDKvf09ocVbtcXlleXVUTi/LKodBtTW7IwGX/6s2aaDcEkh7WOY5mZu/qeqrId5XFq6gfhV8HdwEd+oW0ix/fbv3nD0Wt2wpcsFAo/gwPXZi4PfjEOuUE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GSyzUU+B; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9cc681ee4so1071509b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720214159; x=1720818959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gP9IOClOy8ifyUWle7kU/4az/csdyAUwswyqqTMCtkM=;
        b=GSyzUU+BIg2x4NlJJ+KA5vSrS8BK/3kJaDzlVNPEcUjeGDFpYS8fQNxMM2nhiLqOlM
         lsgfXS0UlW6+L9np0OrCjnPEl9QKfY0FwD9yvufVlrMG+qoF1dPmuGSYkPhHkqQ446zK
         TvnGXSaRJFGc+hY0FL+ZhW0sFndZ4vSaSI78VcVXuctvFxM3fqvxAr5NxMKmtQ5Syg35
         adVCULVoAA7oRRBIIfp610Qp1uTmvflkEQsfRvnnSXMyaU4hLeYJ+Sa1Mb7ijcJ3gY1R
         3SMmWPkedaXHYFUQgQ2MU/GBe8Fq0kjM9EsRi3QZa0P/P7tjZs9KfJtzm7Pf5Z0FuQ3v
         LSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720214159; x=1720818959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP9IOClOy8ifyUWle7kU/4az/csdyAUwswyqqTMCtkM=;
        b=vv3RvU3IclAvjH9DnnSvn5+tDeaES0lN9qVcgtzEek5hh4v4g3CauHY84Ry03gjsid
         QOHpCWNN4cFko2zpyKE146t3KkLCLcQPcChFDi6KUxAUqVdTLcbQ8Zg5e6mpm7rq5DaT
         FsjS0BzPDyNQepOBojqLdXmIWNQzbOI+0vc43IHiU01JNzI6CtXzW/jkw62a3whn4Lrz
         0S2rGY5TMRxJvTCHL/NfrN1Szjl/+yCqwL9gIbUkOVAu+JQYcM46nV01m97+GHkBWbMa
         HJj1QWJgb5q/QLiX/CCnGTBM2V38e6r83bJ7R8aIaW8ZJSKTF+JJ6J0uQJ1ypph1cyik
         nv+w==
X-Forwarded-Encrypted: i=1; AJvYcCWUr0YNmZLIXEN6E+YScY3Z6Syc8Rt+IDe7ODGYhX9dz9CYDbypxqBtY10r2Dzc9GEwBSXVxaISPAWeEo3GCtTL+ONjXQMtXzchupvm
X-Gm-Message-State: AOJu0YyiuxSTO5qKZahXA45W4LyktQk9b4O+bGZCIBF1s7yoPiQaMYWF
	1bRg3PodTf+J1zkXIQT7nycvOqIn++sqmgpM+smpWZA5UZNQ+6ONd/oLYq9C5QK4SSCbtIqL88k
	v
X-Google-Smtp-Source: AGHT+IGg7afFMV1Z0RlmTODc0srTZIscy4siYacHBPJuH2yHilodO9FOk+F9DHD5HFbdlLZVm4LPsw==
X-Received: by 2002:a05:6808:1211:b0:3d9:2415:da73 with SMTP id 5614622812f47-3d92415de10mr612343b6e.42.1720214158777;
        Fri, 05 Jul 2024 14:15:58 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:11fa:6fae:6781:5836])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d91bed280csm304951b6e.41.2024.07.05.14.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:15:57 -0700 (PDT)
Date: Fri, 5 Jul 2024 23:15:54 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging: ks7010: Remove unneeded check in
 ks_wlan_get_range()
Message-ID: <dd8d077d-4e04-490b-bf2c-dbeba8010db0@suswa.mountain>
References: <20240705204434.10541-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705204434.10541-1-amishin@t-argos.ru>

On Fri, Jul 05, 2024 at 11:44:34PM +0300, Aleksandr Mishin wrote:
> In ks_wlan_get_range() variable 'i' which value is always 12, is compared
> to 2. This check is unneeded and should be removed.
> 
> Remove unneeded check to clean up the code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 13a9930d15b4 ("staging: ks7010: add driver from Nanonote extra-repository")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/staging/ks7010/ks_wlan_net.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> index 0fb97a79ad0b..d56dae73e7ed 100644
> --- a/drivers/staging/ks7010/ks_wlan_net.c
> +++ b/drivers/staging/ks7010/ks_wlan_net.c
> @@ -972,10 +972,7 @@ static int ks_wlan_get_range(struct net_device *dev,
>  	 * in bit/s that we can expect using this interface.
>  	 * May be use for QoS stuff... Jean II
>  	 */
> -	if (i > 2)
> -		range->throughput = 5000 * 1000;
> -	else
> -		range->throughput = 1500 * 1000;
> +	range->throughput = 5000 * 1000;
>  

This is part of a custom IOCTL.  According to the comment, we're
providing the 5 million as information to the user which I guess they
might use for QoS stuff...  It's kind of pointless.

Anway, the patch doesn't make anything worse.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

KTODO: delete custom ioctls in ks7010.  (requires careful audit or testing)

regards,
dan carpenter



