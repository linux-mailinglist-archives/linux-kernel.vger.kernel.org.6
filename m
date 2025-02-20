Return-Path: <linux-kernel+bounces-524396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF03BA3E28D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EDE7AA4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6E62139A6;
	Thu, 20 Feb 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GhNU/lWi"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADD212FA6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072674; cv=none; b=ssxBWdBzX/fuUUh3Noi5OoV9mdHUZa9IFN9fUmgI5XyrskLELTGQi7rWxT5eGve1sEXkP2uoVjZhAeefqw36OT/qkL43xgHvmdLiXCcby4G2HKVpqzEsDPzHjUHeXufdYQrD4hcHEti2wQval7y5s/O4dpQ2xN2TN4oNP4KXMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072674; c=relaxed/simple;
	bh=Ey8+OU07K9kFMi/slxHk+wmK5uae70juS2ijj/OEFX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ6GJN9vgauOyxygWZXbazhTJQdq3HZgleNEhSCKhTbB0/I75sSpBOftpuR4DPuHYXobnzoeGgM2Lir9Xmitu+zhe+EnKnO45UIKNrPwzraNYcmPSbqqHDX7xO2ZiNXMW52D11RK2RuzIb+ycDX7H3F7KXz9GlT7WEvvRQ8zp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GhNU/lWi; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0a4b030f2so151831285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740072671; x=1740677471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kKlkXCNBsbg1hSiU8FUD61eyE6dPTAUZNvwxeSK768=;
        b=GhNU/lWi+39Rb7ZZnkDTqXL1uvMBc5oHUwMQVJCpZJjmDsjAgsm7zCaoEYPkqdLbr/
         TdHFCXdPerupEqBh+JSg2wnpzuMx5GJ9bNgjzpBF5hjNMuCOQKntF2igNsSssNcAoY9y
         whv82Q3jqQPQzlBkvlWS06pp263bd7a2IYuXZp6DqOZpKrWUOfgHEIhUci5wpDkTSL/l
         KAhou6Q4WQps91HwWtjlHrP1vq1aGl2RGH81ibXbKES+uIPB1tb6RuQOXXA4tfYoxNvw
         H+EL7NQ0PsMR43zjSOLGJ1D3qMRCx+BM30HJAcYrmL6zmuUxUDjVkFQLedQd6P49UR5v
         AmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072671; x=1740677471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kKlkXCNBsbg1hSiU8FUD61eyE6dPTAUZNvwxeSK768=;
        b=Ot6LLglbOxiO/7yuIixhqoyNScXf1tfuenKLc7wAO0nhPDQRtueTaH0xBacRtrmO2P
         XYF+XJZUDr4R2TUUd6fqZZW6V5qr/HZxkb/RyBeBE+obeJHZ2lUmUDIENxtGZTde5tOT
         IiEq2eITsfOCn7QSsUthyH2UZrMilOv2Qk9CL8XAF45cCenqVFNzhVXjxXemdfWoQlIY
         lFvKc3auuzj123ZQ9tThitNiWtGHDuH+Ml4Ef6OXN4kiqOyh8Bq/dQH4VGBe6fvdp5s0
         fuuI8l7Z+d/bQvljAQZmM70dycY+y7NGeAP67p8+aeatbgQ36/SrcM/4wdw0ZLfA7J/0
         fMvg==
X-Forwarded-Encrypted: i=1; AJvYcCXD2jnxdWZu4TQRQWAS3lsECLVfpwTQwaXajPM8dp196LCfNI9QIl64raO79uSoGklN8jnd6YHJ8oQcsvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/MJ8vPl7gUJYhZY6+fLaQLXrFZBXmyV4egSdh2RgBVGizsjc
	ZFNCZ+3SngdzA8PI+I+vl0C//5NpDk5JsyGAdo4GvF8gUBfvW0k7/IzNkp40lf0=
X-Gm-Gg: ASbGncvwxDsiNOibD0wBf+abfvlGvU1azL+E7PUIysFUyCwKJc0BTRa8jAD7w/Ki6WH
	kuE2B4T3UTlhsbr24BjswhOCCsnkJvT0Y/3DoqzVDiC9+ZsSvZdoj+z0sbC0bi81FvhRloXVI3A
	m3JpYzNADJGQNchqRqusRVT6ueLD+DcKKwYE8DZtsBjw7NROjkBy/n5ctO3lMzDEoHgjZtybrCb
	lE0H8YxUyeL8pW0TeAGlAR/XdG4+BvFmx2eLrrE2+E/nwBTtTYIlao6ccKNKFkGutt3ly2sWWFI
	YV3en2bXcO1N3tzSoBHHOROYgYDXgLtxs1eaLLEjpnbBDgqORTneh458rtFdsz5l+cPBmc0vQg=
	=
X-Google-Smtp-Source: AGHT+IHtz9ziu9H73OBuxBOPa7vDiNeRXwOaafTxvcP8JXQxND+yNZZLPxNMqyP89aPMmHCcTCqoMg==
X-Received: by 2002:a05:620a:4002:b0:7c0:b3cd:9bcb with SMTP id af79cd13be357-7c0ceef9b9amr11334485a.23.1740072670683;
        Thu, 20 Feb 2025 09:31:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ab3e3383sm376379185a.81.2025.02.20.09.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:31:10 -0800 (PST)
Date: Thu, 20 Feb 2025 12:31:08 -0500
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
Message-ID: <Z7dm3FeEXVXwJs2O@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-5-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:45PM +0100, Robert Richter wrote:
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
> +	struct cxl_interleave_context ctx;
> +	int rc;
>  
> -	while (iter && !is_cxl_root(iter))
> -		iter = to_cxl_port(iter->dev.parent);
> +	ctx = (struct cxl_interleave_context) {
> +		.hpa_range = &hpa,
> +	};
> +
> +	while (iter && !is_cxl_root(iter)) {
> +		/* Convert interleave settings to next port upstream. */
> +		rc = cxl_port_calc_interleave(iter, &ctx);

Thinking about it a bit more, you still have cxl_port_calc_interleave
returning the position, but you have the position captured in ctx.

I think you just want to return 0/ERR now since ctx will have the pos.

This makes me think patch 3 and 4 should just be 1 patch.

> +		if (rc < 0)
> +			return rc;
> +
> +		iter = parent_port_of(iter);
> +	}
>  
>  	if (!iter)
>  		return -ENXIO;
> @@ -3281,7 +3292,13 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  		return -ENXIO;
>  	}
>  
> +	dev_dbg(cxld->dev.parent,
> +		"%s:%s: range:%#llx-%#llx pos:%d\n",
> +		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
> +		hpa.start, hpa.end, ctx.pos);
> +
>  	cxled->cxlrd = to_cxl_root_decoder(&root->dev);
> +	cxled->pos = ctx.pos;
>  
>  	return 0;
>  }
> -- 
> 2.39.5
> 

