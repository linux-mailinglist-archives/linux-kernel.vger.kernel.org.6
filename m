Return-Path: <linux-kernel+bounces-524524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E40A3E41C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE4317B106
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBB24BCFE;
	Thu, 20 Feb 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l6vwVNjq"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA2247DF0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076931; cv=none; b=DVGWL+RV7JwJy4cyBGBSmzVZXvc/nySqDZ2+cXNPxbA+2IJyd6NS9VjStRN+qMBj7KAjhznNPHwZetF2a0VKbhdWgJkQ+xQ0W1kSA/+y6Lw8O6YQXybUEYChbw9ozJwNxDC4+sMqdjcJtanSLt4xtB5SaeIj+wFPM/O9qni1VNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076931; c=relaxed/simple;
	bh=p5xm1o22PRFvmKnwXPUj7mBJCX1wDvSvLIhEab3PO58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY1H9Y1Bsooqf8e45ip0A2VXreuVPGkn70393rXGbZeZleBSg32PZWXcQ7aV9lhJvnrbcNWcKwONnIwcReF0zMi4bMTbtFfNgtx6sk82MPTK1HdYdUaHfkqDG5bOF0ibfpJAxnIUqdWyhYVbv6kXLTxXu88imKQsbCbwsHFK4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l6vwVNjq; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e66d4f3be2so16518636d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740076928; x=1740681728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gx0W/uUZlTRGbJlDEomLybSdty7XE+fwJpN36vGWqNQ=;
        b=l6vwVNjqQOS2498+ipxt3sNWZMLteLmYoVkpt8+lOiRxwyRoa7fx9XOHopubJmCf9D
         vPxEZotp15CIHH2mK+snURXqWPwvm3a6KBltG7Jhl+CL3fXOGQvqIWLFzGykCeHDX8uy
         g4y9Kvd20FLElnGl9dTEedTV1S6BJt+5N7YSmoL2PvEJ77lC2QD8wQ9B0ym1bzbaM7Bn
         yXHuNbADzdeDR4jvufGQPpb17tIEtvtnqkermr1xh7G+iZn7G5m85lm6A42HBehCXVak
         rkt5mTYv3Saie7mGH4pukmhtWoHGhKuGGm0KsUlty+g2GJlMwQ6cpIBqsJp1zGJf6P9J
         Jdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740076928; x=1740681728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gx0W/uUZlTRGbJlDEomLybSdty7XE+fwJpN36vGWqNQ=;
        b=FSCdzR/HgK1gQD2KKSnaYnQu2OwlgNXyB/DExkxdaQK9KLuLftYRYwq7e/jlBp2IQN
         zGeRdKzrdRYm0i3RiQsgsj2dIf2nHtjWvw4TgtAmXOlqPYyanhq8ZHUkuuf13yYPcdxV
         togpGUXI6S4yi/yLeYg1XYBVZZb4/DBDh4uhp6guaHSs5n0JapIsMsGzLQcSDi+KMu82
         HhWLFospNqw4fLJyM0ldW4/tFo7RfFoPuDX4eBQ7NQnrK4OzCNq8gZIa9OUlu2U5r421
         +ZUzcDt9rsf0OGazZFhwYIrHhjqFytYYib5hqAD6diekrIpGEnNG3nmg+J86Jkj85IfH
         vc5w==
X-Forwarded-Encrypted: i=1; AJvYcCWCvsM2+bRP7SJZH2+ElEH1rbRXhByJnLTNEubC7b6wg28UmkeSmi7MwYzvpeIOkXC760JERWpg17f2ja8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgs62bflZRO2lTQ/NFqGPIQyg6yKrmNIsr7qx5P+3nM+b14u5
	/+EY1HQfWU4wKzdNxU64jhTWObnX1oS00KeNCxiZ0L26AgVj+lZx/Ww1GrLbU58=
X-Gm-Gg: ASbGncvTdXb/hJHs6Wez/DDQiOckGpgknPwjhiIWtjYunpJcLdnQ5ul41CpoZbhm8pk
	ZHzqMPgAzdP9tvelYq5yuimk38Z5nFQdRc4Kjdpn1IA+Tfsy8H0Hip7UjJbh//uqIH+uHVf08mi
	akTuRPqqBQRWF2gj00dmBhK62aDNm7HPKkQeVsk8Wy1dHiI31T9O1sN+/Va6BwIUQK/xHyOmhcW
	IdsbAHlcEwwyQgoVxWSlBq+PmDypqjNRPIbmDTfN4R9ltlYaqrckyIqpKB40rUolEJxwqceebDl
	YfBIr87c1iG1SFGLGgh7Fu/hFKfA3mDvSHiU+f9R6PUSmvot8Ca4PDFkA7ti+ObHGa2PM/X4gQ=
	=
X-Google-Smtp-Source: AGHT+IHxs7YJJAceyj3jfJdQOg1vrzRGu2Ox2ngK865GcPb4UiuNqVh3X9LOAtp+SMVMNER6i4rkEw==
X-Received: by 2002:a05:6214:e8d:b0:6e6:9c39:ae4b with SMTP id 6a1803df08f44-6e6ae9e2293mr2780336d6.42.1740076928276;
        Thu, 20 Feb 2025 10:42:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a40bdsm89111136d6.59.2025.02.20.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:42:07 -0800 (PST)
Date: Thu, 20 Feb 2025 13:42:06 -0500
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
Subject: Re: [PATCH v2 05/15] cxl/region: Calculate and store the SPA range
 of an endpoint
Message-ID: <Z7d3fuL_YuwFWM2n@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-6-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-6-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:46PM +0100, Robert Richter wrote:
> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Calculate the SPA range using the newly introduced callback function
> port->to_hpa() that translates the decoder's HPA range to its parent
> port's HPA range of the next outer memory domain. Introduce the helper
> function cxl_port_calc_hpa() for this to calculate address ranges
> using the low-level port->to_hpa() callbacks. Determine the root port
> SPA range by iterating all the ports up to the root. Store the
> endpoint's SPA range for later use.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
>  
> +	/*
> +	 * Address translation is only supported for auto-discovery of
> +	 * decoders. There is no need to support address translation
> +	 * here. That is, do not recalculate ctx.hpa_range here.
> +	 */

Can we at least add why translation is not supported / needed?  Just
saying "there is no need" doesn't help devs after us understand the code.

With that change:

Reviewed-by: Gregory Price <gourry@gourry.net>

