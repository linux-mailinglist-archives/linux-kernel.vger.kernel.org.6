Return-Path: <linux-kernel+bounces-524641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9088A3E559
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8FB165585
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08968213E80;
	Thu, 20 Feb 2025 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XreyP/6V"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35191B423B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081024; cv=none; b=rlGjWNXgRTDtvkJFPRW9nQ9GZ2HDyZ920YiKYWC2o3Qq86IqfvAaTKCU570z3LhZb0ATSBpchoNhYsf0Rkr+12+da2koVnMXiCkLbOMUxKVEiadJ54hK/vpEukANzKJmkllZ7REgbUXM+mvlv0CFXYm+fBFiTXt0WIMK3dlE4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081024; c=relaxed/simple;
	bh=hrA9p38IDspEkGP1O2nHIhWSgfQXQd2krV1yHoiJhZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8hMGGqIBNFthwAkMqbhKiBZ+TfOR1X7N5uhPDmpyQRasxGS0Hir/Qs93j9UMgvR9PNdMyJgQtrfrAbUp/i7AkCnI/j7TWOFGX+zF3OkwEXM10qFiqchWbLarS6zcIkyWQWUO3Z61ZtddVBDfoytsDQLAkDie13olmSZlGXNN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XreyP/6V; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c04df48a5bso137461785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740081021; x=1740685821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsR/rhOtN1rjKKzwMCE+sYzTv4I88D0Di854W37LUUs=;
        b=XreyP/6VZR+/YlqqsKyd/jk6z18yFsNjCesyjq1uzTTXdRqQI6zR6xijGstcs8KBYM
         wER5BnvKL5jg3oMtzvYCc/UoJpI50wZvZIqz/UF0yY2fRAv+xQ+Oellzny35NYn9wk2D
         qytqRcU0jHxCSZ4s1YRR2cG4aWOz3wwDTu+Lt+GU9TXyd6g9wL+ejrYESAuf2yjxpyIx
         LYe8E8CHrHCXU6F+p6epRmVC7MDXTUnvevQrLSXb4rcUXwkk16tEr/vrWBpcpYXTQlKq
         kyA/rR3Ob2wl8tAqrds6C21gn2tRau7sN2Ovgi4YYhURT/f7SAejJ7RQf8IeXQI1qKlf
         8ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081021; x=1740685821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsR/rhOtN1rjKKzwMCE+sYzTv4I88D0Di854W37LUUs=;
        b=fjyyiEspcTCFJtaknK0e1SJK1CEIyG9e2RS6ttuC76kcwUfcoWHkoRPdTPHnbHmaTB
         /3UgbOW0+fAgw9AfWaa7osU30ru2uzSdzmBQQcoN4dh6qucboLJ7aFsBAo53G5UXCw1v
         fXiaoXlqkVMiTVFtHMC7RhmVQY//EIAYc7uMJozeKi9z3qDTdUQphlu28hnx4Wr03K+5
         0HZHK/5XkwoWrEygQ5LZOVme2ZARdpGvBtAMCoepGkrTImbxJH6Z2zNmCzqx+GzpOzhk
         ofvaro13KbJNugtpjOz7ZPEM/YdPsc/FsRsLouZmTHYV6+bz9o9k6c6L2VKEUgJji058
         F65w==
X-Forwarded-Encrypted: i=1; AJvYcCXtvyec9SBXVpaix5SjODQW2y3db36xiZ03RoxxY2V6u1059D27gvSSqSMr0tc+TE76TyfxylbaKTIeRGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPpbgs4Bs1ZwlLfXyoR+jfLZglhrrHwDznoxrNkQ1X1p51CEF
	z2II7ldfrxiXYGvzNZA4hIId+X0pIYCE9tmBq9086yS/NSJa7ahivuHOQsWa+hE=
X-Gm-Gg: ASbGnctmYbpCgB8S87O3Ev16WIB3ncLx123QP1WpuXJKmVTziX43i9aR7ZmTym9GEMg
	bRYXWLCYV+nXEMOk1ETSduyCdmALn2utkY86mfX3+OhOAqPN2wSspF8vk7H7H3QLWdN4Aq8BCoX
	buK6LQ8YKdYpLSPDmx4UUQ8YWHSLxi1pi56EQ/1iuBth9b45Xs9N/1iCCrRafWLkJryTJUbfbK5
	yuYHlgILcJG2soHHP8VQibP2CEWDcjeKNOCpnlYpO8q7sILAxWm94h16S3MmgS9qJ3rVu4JHQqn
	J193z5TIYhepz4iUDs37uftjhbqZE2XeTWOoGqQIb6fSfTE70chiUz2I4m5ATwp3w1AnhlvoCA=
	=
X-Google-Smtp-Source: AGHT+IEpdlOT13ijaiv8n6s5j9ITcvCGGzuTUZDlk5Q68kLQIU9M+/yqHtmw3jOZcJB0IM4LCuCABQ==
X-Received: by 2002:a05:620a:444c:b0:7c0:ae2e:630d with SMTP id af79cd13be357-7c0ceefe6c0mr64848485a.16.1740081021543;
        Thu, 20 Feb 2025 11:50:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c46f59cbsm98364485a.41.2025.02.20.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:50:20 -0800 (PST)
Date: Thu, 20 Feb 2025 14:50:18 -0500
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
Subject: Re: [PATCH v2 11/15] cxl/region: Use the endpoint's SPA range to
 check a region
Message-ID: <Z7eHeuikvako1Xhh@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-12-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-12-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:52PM +0100, Robert Richter wrote:
> Endpoints or switches requiring address translation might not be aware
> of the system's interleaving configuration. Then, the configured
> endpoint's address range might not match the expected range. In
> contrast, the SPA range of an endpoint is calculated applying platform
> specific address translation. That range is correct and can be used to
> check a region range.
> 
> Adjust the region range check and use the endpoint's SPA range to
> check it.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Explanation could be a little clearer, something like:

Endpoint and switch decoders may have an HPA range that differs from
the memory region's SPA range.  Utilize the device's calculated
spa_range instead of its hpa_range to validate the region mapping.


The interleave comments don't seem particularly relevant here unless i'm
missing something.

The content of the patch looks good.

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3afcc9ca06ae..2ca24565757a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1531,22 +1531,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
> -		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    cxled->spa_range.start != p->res->start ||
> +		    cxled->spa_range.end != p->res->end ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
>  				__func__, iw, ig, p->res);
>  			dev_err(&cxlr->dev,
> -				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
> +				"%s:%s %s got iw: %d ig: %d state: %s %#llx-%#llx:%#llx-%#llx(%s):%#llx-%#llx(%s)\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
>  				__func__, cxld->interleave_ways,
>  				cxld->interleave_granularity,
>  				(cxld->flags & CXL_DECODER_F_ENABLE) ?
>  					"enabled" :
>  					"disabled",
> -				cxld->hpa_range.start, cxld->hpa_range.end);
> +				p->res->start, p->res->end,
> +				cxled->spa_range.start, cxled->spa_range.end,
> +				dev_name(&cxled->cxld.dev),
> +				cxld->hpa_range.start, cxld->hpa_range.end,
> +				dev_name(&cxld->dev));
>  			return -ENXIO;
>  		}
>  	} else {
> -- 
> 2.39.5
> 

