Return-Path: <linux-kernel+bounces-524222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484DBA3E0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C27470323E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914BC209F3F;
	Thu, 20 Feb 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vCUzGkuM"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1520487F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068925; cv=none; b=pJF7UUilLUA8cgFDM6N20OkYgKrR16+cjl83M/9IVOjcoC6+0GYA4hLJoO17ZTpGXcUiupzPnAbH6RSk6CW0MP/obD/6M0vny2e3CdRYNcC0hNEjUWYeEXSWq31bxTgo2+10++sFM8GlpHDfFW9GKl54lTo4XKdHc7zBcN4zrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068925; c=relaxed/simple;
	bh=qtZvEjj3Lx7yqO+SKHcxEAF3FCWhyE/jBk/4XkhKUHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTvCMj327Ua1AXfs2Uu2zAtY6ynCm/Ds1+3zW6vKoGmhBrdrFd93iJBs0G8lpvD93gtniKYzybzsYY5d1yckfzfhZfxfOx2aTR45lnpXv30hQffxmHGTAH9/VA3qPa3EkJs5NkVCrsosR2KwF7smiUdQ6O83gGxLE9pRXnWbDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vCUzGkuM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0b24cc566so92637085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740068923; x=1740673723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zPKPwpgMpfH3brPd29df7mwe+JvN1VwGQmS25Yuk50=;
        b=vCUzGkuMsP9JQS/QWcl3XWgfSJ3fY6m8qeLG0kmNyNkt39Na2wQxRQ2uIX3dar1PuO
         gKQ6UZAjKXnqHN6wnZfnIjHIY5UMlWbHYh/QsJUtmxIA2SseglV5roC4S2pM5DJXS7cJ
         mZzSqdyF29ATpTa6e7oOUcE81dFMJ4OKj94Lk2qbM+k1HjEtNfS8SS33cMhBDTKhxaVo
         TRMPNOCGkbaUTFJbvalO7lREpk34EajTxSku493IsM7VUI7F+bJqdkNtjXlfAvmz7oLm
         xIr5uRAafsGj5VPREpxoOx1uiIfFeqAwcynhnvDAJ0hEfL3HprjVicYMzQfH8kO3j4mb
         vCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068923; x=1740673723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zPKPwpgMpfH3brPd29df7mwe+JvN1VwGQmS25Yuk50=;
        b=l8XH8I9F/E8fj9/e0PALsK3rMpW9qs7cflxrGoxziQTA8i3aPDmIIkWb83WnfxHnlr
         FXwt1Mhfk9uWfCkQvSO9ui6xi3w+i+KuuTEoTRykzJqiLP6Dtg2aoY6TcVRTSx6PN3HZ
         daS1+2CJfYMwuI1DGo1q0dvb8wmKkgv7DGf6jvvUPiNEuqDtNAlZE7V+H6tIRsnOgrKz
         B1XHF10lS1diBG93+3EqqgIx7KHlamuGTvJUHFdd2uRW9QAE4Y86cK6Up7ucRjH7248D
         SmLHpJhkzUUG6ZEZOXvNDtSVhzHeFvqcHCVzLbd3vfrsXakxWU0D1o03mwUWzMzkaRfc
         0tNw==
X-Forwarded-Encrypted: i=1; AJvYcCX0mFIRJWRvsjK4pO1v/KucTgZNLSDXj3Xd6yLhjsOcYpzNTILE8OfeE4aLd2KpHamkNgsb6lCCQdjPOgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJkVmMO8nzD/FLpEHzgHedCFqyh1/TcGADdCTCmSirr8fkQhL
	gSWdHjcx52ZGHA6303SoYBPoT/XKyti+ea/3qNx1GqP0boyCO/m08h2jyJ7pwms=
X-Gm-Gg: ASbGncth2CtiHDm0Smtcz3gV8R9heKd7x/Eh8k7+bc51TafSO1Q5qwGZHyn81wzLuB2
	Pa1atpl84PkxLtib88uqoIpUE7lNr1xVbrEF+HVsdWqY4U2oY9Tbsh3+Zt6XSOq85sjn6M9Og5A
	ajj9nbfFs7nd70a9fCnZ4RxsdbREztMFoSBYNdkfutC9D164a3PZHh9TBnJgWdiEbQ7KVZ26864
	hJ41jIVSkTghxTfl5WKka5WPs956W5XUTDzoyaVdT8+h6tu/lL1bEnLB5v7zg1UMeFOcJv6QHLc
	EO6JZtXQj3viLE84adYS5n7VSmfgX+bNir9CgdQL+1vpk9EonMfP0KSn8TvuPhNTTqTbqG5zaA=
	=
X-Google-Smtp-Source: AGHT+IGeFR8D7nMbaUp/3ATL7D3M3qMty7rR8JIiXinKvzPnvyJ/Rj3ZuPHNQJnrNccn1sWN2TpbjQ==
X-Received: by 2002:a05:620a:28d1:b0:7c0:b0b7:493e with SMTP id af79cd13be357-7c0b51cdf04mr1099093585a.7.1740068923018;
        Thu, 20 Feb 2025 08:28:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a62e9865sm409747885a.59.2025.02.20.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:28:42 -0800 (PST)
Date: Thu, 20 Feb 2025 11:28:40 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 03/15] cxl/region: Factor out code for interleaving
 calculations
Message-ID: <Z7dYODuRrRv1bXpV@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-4-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:44PM +0100, Robert Richter wrote:
> Function cxl_calc_interleave_pos() contains code to calculate the
> interleaving parameters of a port. Factor out that code for later
> reuse. Add function cxl_port_calc_interleave() for this and introduce
> struct cxl_interleave_context to collect all interleaving data.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 63 ++++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c118bda93e86..ad4a6ce37216 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1800,27 +1800,34 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	return rc;
>  }
>  
> +struct cxl_interleave_context {
> +	struct range *hpa_range;
> +	int pos;
> +};
> +

I get that this will be used later to pass information back, but this
patch by itself is a little confusing because ctx seems pointless since
the function still returns the position and accesses the hpa_range directly

Looked at in isolation, having the context structure change in this
patch than just adding the hpa_range as an argument and adding the
context later when it's actually relevant.

static int cxl_port_calc_interleave(struct cxl_port *port,
				    struct range *hpa_range);

> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *iter, *port = cxled_to_port(cxled);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_interleave_context ctx;
> +	int pos = 0;
> +
> +	ctx = (struct cxl_interleave_context) {
> +		.hpa_range = &cxled->cxld.hpa_range,
> +	};
> +
> +	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
> +	     iter = parent_port_of(iter))
> +		pos = cxl_port_calc_interleave(iter, &ctx);
>  
>  	dev_dbg(&cxlmd->dev,
>  		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
>  		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
> -		dev_name(&port->dev), range->start, range->end, pos);
> +		dev_name(&port->dev), ctx.hpa_range->start, ctx.hpa_range->end,
> +		ctx.pos);
> 

	context just gets discarded here and hpa_range and pos are
	otherwise still accessible if you just pass hpa_range as an
	argument.  So I would push off adding the context argument to
	the patch that actually needs it.

>  	return pos;
>  }

~Gregory

