Return-Path: <linux-kernel+bounces-522709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245EA3CDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549C6189BD12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF0025C704;
	Wed, 19 Feb 2025 23:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="S44wyVWX"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198541DE4EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007971; cv=none; b=kT2WYWGqTMrYpPmgVcToIOIi9sGo+RkH7dFDCwYJPJXhOJ4kpR+svcNYkfBbLOhfi2XVw8hiUFQkTaq8l/MNCJudUg6Wh4X6uXT4E5rJ76aN2S2KjM6hSPoyDHBBJmbolyIiXZVs8pEsGMNceWfafE1HTNFGsT6gaadMu70JM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007971; c=relaxed/simple;
	bh=3Qpi59IwyoeIc+HODTOPdRs+OhUPUgKytanIj4rGMlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSZslucnjHgtzQVq+gbXhfeu0DWGM4F7xLCx87N4YwiQi2rkCokL+lIvXCSxNRgQ04YgRs9EplAgoDG4rYt2QM/RpedoNwmPIZN/gIqs+Dxd6GiO/y+6ZgIqIC2yDLNvB9Pj/CaO1teuomdcYpxws0SAAR+VK3TYuctC9N4mX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=S44wyVWX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e6846bcde2so2527766d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740007968; x=1740612768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BuJ8MnTrLLKgSkkWBdG51HCA8Qkyi0aXGWMt1dCxiM4=;
        b=S44wyVWXSFRWrX9p0tc8MphkaYAy+ql4+wXN6T2wP0qjNqpEXvhFXjfeeZv5zEo9l1
         JxNYsaHNcJIl6fMtDooaC4SKGJfctspyxJJ74OB97ezOYzwvigl3MhZ6opJ1u+IQkT/U
         eOfV2H5TWTuLf9yIJsraJy0fNeww7sY3a8EZmwuqSQeVvbJYhn/bKFIgDpu9McqliC2/
         mFe/zV9zTHPiRTTD0h3T5Q/yKXppI1FYJCijYd5mtnzXAcWCljCNbiOqBWqLL9DfI19X
         1Qm9/hG3M1dESMP9NcQBSOIamYZ1AG7daVlYAGj6vHPjOot5UqHCBKxqwooqVBYRFy1W
         st1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007968; x=1740612768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuJ8MnTrLLKgSkkWBdG51HCA8Qkyi0aXGWMt1dCxiM4=;
        b=N3Qzp6mHt8GQPbneKQe3J3UXld5xVxNmqEnvPb22gPs74D7WHRR1IWE5V/TmJAOlXB
         jfniJQSDwvM+a3por/tpuv5MkuzZczpyAFE9QuRgKcxOROepSD/g7aThYrYbVn8duUTX
         LvlenZsq6/mZ+JHxZ0mXw519teTM/ZM94vQ4KU1b4UW29TZV7bw027MH80uqtk6NiR+8
         UTh0BzVdVqdtspaZeKUD6W/z/koEFKm9xAIjbO97buRENrJScpdTHguO7pEr9KRmgwoV
         JuTm8JvqZuTJyMyWjnR6VIqbdg126Wu1eCC8hlzc3qMrsuIUgTTu44DuePhX38MdA+rR
         FefA==
X-Forwarded-Encrypted: i=1; AJvYcCUWu700kWziXyMw1JCQ4SvZLVinqiXFHJtvcit2up5uXOE5KnUJgY9Txc0cd1H+HaM5vzSINXVOxtxCBcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywot82SEygLKRDm/xn6ir7nSCqYpfeMbh3+AFg2EQkaYRU7g85V
	H9El9TataVMBlPhvCErm/adFXvpzzgYKWRPorM9Yxwcm64e9HnWkAN+YsSai6u8=
X-Gm-Gg: ASbGncuiptwR9Y1WgZKflRbDEHVpZXheqX9jvPPC5IJJ+ZvpZTeTJiX19jJPgwFF4tv
	6LkjdseWNhjNVJEvfLlABaZBHgjxc8FF2ijNaxNwQd8hFnbHESpFsr1Equ6pzPY6iSSakQKJOYf
	KDqwUSrXtQDNGval9XF+C2RJ3r+Sn8E/BThYvwakfh88msKy4D+eyut0+S8h4TeQieUzoLzFtv+
	9Cs+aBwKWrRh0fpY5MNzrXejZq4PueM/niAg3H2NUVJXcPNVb4lqDBcENR6RU6tHD+Bmi6o6Ky7
	tirRlQbi3qPxS0FyMHeEWPBzC5CiYKulNcIAcgyHg80SFpk/mf0Z/emwHLxvGrbmrPTMs2mt6w=
	=
X-Google-Smtp-Source: AGHT+IEb1NSA6KP9GRyN2gqcBNFucCfbTKdR4b3/RwdPjgrLvsacTXJUjiUUYluNqmcUzxHzBNnpzQ==
X-Received: by 2002:a05:6214:d46:b0:6e4:4484:f357 with SMTP id 6a1803df08f44-6e66cd19ecamr248188026d6.30.1740007967718;
        Wed, 19 Feb 2025 15:32:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784e99sm80839416d6.28.2025.02.19.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:32:47 -0800 (PST)
Date: Wed, 19 Feb 2025 18:32:45 -0500
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
Subject: Re: [PATCH v2 04/15] cxl/region: Calculate endpoint's region
 position during init
Message-ID: <Z7ZqHc44qLU73hpS@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218132356.1809075-5-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:45PM +0100, Robert Richter wrote:
> The calculation of an endpoint's position in a region traverses all
> ports up to the root port and determines the corresponding decoders
> for that particular address range. For address translation the HPA
> range must be recalculated between ports. In order to prepare the
> implementation of address translation, move code to
> cxl_endpoint_decoder_initialize() and reuse the existing iterator
> there.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ad4a6ce37216..6f106bfa115f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1903,7 +1903,6 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably
> @@ -3264,10 +3263,22 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *iter = cxled_to_port(cxled);
>  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> -	struct range *hpa = &cxld->hpa_range;
> +	struct range hpa = cxld->hpa_range;

I believe you have a build error here:

drivers/cxl/core/region.c: In function ‘cxl_endpoint_decoder_initialize’:
drivers/cxl/core/region.c:3286:51: error: incompatible type for argument 2 of ‘cxl_port_find_switch_decoder’
 3286 |         root = cxl_port_find_switch_decoder(iter, hpa);
      |                                                   ^~~
      |                                                   |
      |                                                   struct range
drivers/cxl/core/region.c:3244:67: note: expected ‘struct range *’ but argument is of type ‘struct range’
 3244 | cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
      |                                                     ~~~~~~~~~~~~~~^~~

Just a missed & later in the function

~Gregory

