Return-Path: <linux-kernel+bounces-524583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6340DA3E4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE5A189EE26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381426388E;
	Thu, 20 Feb 2025 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YRe0ouD8"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7B24BCFE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078805; cv=none; b=lm/klCxmopALcmnjiWloUF0w6dWT79jWzS6gx+s7x5/7bbrFYD8cgFtcUZA7vqqKMpUMaLj9ZNVW9jiKzng2JBAtQlmCaigVK1TIt7wQnOkhyhQEV5Eiaa3uKycayKjTDUkNM7cq2COqXpUSMiVLs2t7QfYvk3jRqxnnSaz0sKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078805; c=relaxed/simple;
	bh=3ju+Fge1vefH4rJ7oHab4mwdT63sJzOAo2WkeZe1IsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq6NDtKIJHcbEi2Oqt5PUirMpRAlqfpKzvSE8VKOsENDkmf2i8aFFd0VRSut6MqdJqIsTHtLXKkr2Rd8kEbQUcDO3saRKM0evtL3Ck1u05JcUiQ6nfrWyjBwEkS1CETwH+1w85uGs/KJpDuqUYLUrm1hI422pm4QJ0JP0UiA5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YRe0ouD8; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be3f230436so116174485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740078802; x=1740683602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNx9JrIVabkYve1PD6+5XRax/4bHll/Ja/FL4uUPxuM=;
        b=YRe0ouD8vryCVVMEU/Wf9SG3jLxWgZZY3b0m+wZtLy+O9/srHa6sfPbXdlcsb1WeNw
         Cip8lhHRudkVU9Vt8twQ+qYohTfpjQHdM9cnOmb79JwkldVVutTWr4XvmZczOYGBYdHr
         ZIBPoAhFkVXqsPWtCK2+dBPNs1mrfJMReUtN6tht86ZejSN75yR+LTAC+At5x1w0zVUj
         MkX2+A6bCOe+BjCoJz7xVsObj73R7WW2P8+wh16BK40dgEX9fqDJnSYbA3o41QxdGzeC
         BkejS4Fnmfe1d1m7M7BPHaCHyFov2uk2iGdHIf5GQ1ka6MIIuY2QTH0EEBS4hvRWR7hJ
         gIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078802; x=1740683602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNx9JrIVabkYve1PD6+5XRax/4bHll/Ja/FL4uUPxuM=;
        b=u2/6UPvOXLlXdK/8tXkT3z+rVD8J+2NkKs9/o1RKqItQnjUwkwlseUw7UHKk0PsHPA
         5byIwIyINrtZM6g5kiETfFAjxouw445zIXVuVDlswv7ivxA8yQ9vD4vn5dUKet4YXSzK
         Lvg13futu2GAA8OX96dYgftPPCB+vXpylw+BW7JM7K8Ez9OEluKmwpbSt7JkNp2gvZ3a
         pkVcA4BfzMHEQDax7xJ5AcLirxaSfZMd3NeRYTjCcp/Hg5ZETjrIklQGnSIPa3likwKI
         uA9xaYmss+lfnbj0vD0tF4x7kmsA1XRzBGKuv5nUaRRjd9RfdcL6iAW+iEmN2jGb/k/J
         4L5A==
X-Forwarded-Encrypted: i=1; AJvYcCW2IbTZXVWmqUlOUI+9cheF7IKP5nPMObgxJrEEA0Tzsgd+L9NChmbCc/L/hWMJycDbN41f4FTiS0H4Kx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvIF44PKHqQL7hwjmBZ6xTqZBM7Uv+eci/Up0iVgnDTOpM7mPQ
	APkZseYuQTVm92Oo/r007QUxo/n+C1C3z7Drt+eDhbeEbETgNhu3/kyzplzrWXA=
X-Gm-Gg: ASbGncszz7Puv6qd0CCKvcycRpb6xfrsrlf14XUa7cQxSzAiuAUDQx1QMZoebBBHuw5
	kZiBoKZXr16yAPmrVh6OnfvHSimcLsTSly9Xc8hK954+SdUDBHVYYHIKCxlfsQ6I09BMU8YSoLh
	/oHaujq6firJNtfXOEvag1y/wLAUAzUhBOWRDQrPcYl9guxLWr9galtbWAuTGcn9Xw0pnMj7nZU
	tDMjsp2fFfNMKYfRx09YFzymmINU2oAajXS1O01QPb7f3K49lrSVLLzhzm+Do8bbGZgEMYy7byP
	Q4GAb4mmWsG8uJ4k+xVgfHEUQJIaiCCyi4PPH3XZLkEmmYvuvqyQOJ5IffNDuyQZCiVasIiXiA=
	=
X-Google-Smtp-Source: AGHT+IFQN9nUHNkBphF2rvfCIhCVm6Hj1N0F070dzNmNKy/cVT7UuqEFg+GppUV0fFHN/1S/dwR13Q==
X-Received: by 2002:a05:620a:191f:b0:7c0:bb63:5377 with SMTP id af79cd13be357-7c0cef66889mr51580985a.39.1740078800600;
        Thu, 20 Feb 2025 11:13:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b424d51bsm269027185a.77.2025.02.20.11.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:13:20 -0800 (PST)
Date: Thu, 20 Feb 2025 14:13:18 -0500
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
Subject: Re: [PATCH v2 07/15] cxl/region: Use translated HPA ranges to find
 the port's decoder
Message-ID: <Z7d-zqJBVD7KNR4_@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-8-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-8-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:48PM +0100, Robert Richter wrote:
> This is the second step to find the port's decoder with address
> translation enabled. The translated HPA range must be used to find a
> decoder. The port's HPA range is determined by applying address
> translation when crossing memory domains for the HPA range to each
> port while traversing the topology from the endpoint up to the port.
> 
> Introduce a function cxl_find_auto_decoder() that calculates the
> port's translated address range to determine the corresponding
> decoder. Use the existing helper function cxl_port_calc_hpa() for HPA
> range calculation.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 60 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5048511f9de5..6d5ede5b4c43 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -887,6 +887,63 @@ static int match_auto_decoder(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> +static struct device *
> +cxl_find_auto_decoder(struct cxl_port *port, struct cxl_endpoint_decoder *cxled,
> +		      struct cxl_region *cxlr)
> +{
> +	struct cxl_port *parent, *iter = cxled_to_port(cxled);
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct range hpa = cxld->hpa_range;
> +	struct cxl_region_ref *rr;
> +
> +	while (iter != port) {

I understand this is used to map an endpoint to a region associated with
the given port.  Is there a scenario where `port` is *not* a root decoder?

Seems like port will (should) always be a root decoder here in practice.

May or may not be a useful check on input, either way:

Reviewed-by: Gregory Price <gourry@gourry.net>

