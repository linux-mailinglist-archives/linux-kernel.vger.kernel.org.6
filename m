Return-Path: <linux-kernel+bounces-524831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E43A3E79A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC95D19C46D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E1214801;
	Thu, 20 Feb 2025 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="llI1Gf7i"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744931E9B35
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091048; cv=none; b=JjvQS8Umr31CbOLNueBQK4AuyYkH2g4bYpob+0OeetjUpW9PZ2atu/dcbELLfiHSNUdQ4ZQzv86EWfqAXZFdH2wh5wFdfjAsxxaigqu9kUFU0ufmAG2hqWEUfdfQ+HTnIO4naM8lIzAAusLLH/08YOPOiwe5KBlfuxxwCiEMdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091048; c=relaxed/simple;
	bh=aeh7OcMPYkl6w3gYelF2VL8aafx+DdFmxv2lt96VTxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCF6KemYANnRKg5QPDvefTvfnRfrZuJffT2WlvZkvq1mGIaL6rPUDg362XEtYh4SYJG3rQ/khRKwV2J+6Oar92MTziXQcWtpEH5DQQxk3+v0j0VJ0a1aPGZ0q88RTQu38Zh5cdv6BSft+bYhT/lsr5hQs7sDvSzyFnuDS9Dsr3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=llI1Gf7i; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e67ce516efso12192376d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740091044; x=1740695844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQeLa18sMIqd5ll6IHo4VMf9DcsVrnxNmwvubrqEs9g=;
        b=llI1Gf7i+lHse5kAtp1LtvDP8gMrgv63inxXM9aMc7IH4Bn4s5KhSxvXOU+0mOYVsp
         Gtq1IBaNYhd88+UtI/jQlX0e+GsU+GdDvQprPB/Kg9ME1t0AlL3jTLDMjuMULg70IQOo
         YREGIb+6X80bi/5FZ2mBFDQiFcNKzOuqjzBxGP+hIQ+XaB6IYhaMG66Ld9bd7pL8o7mQ
         fp2XeSgS7RoWjcYjSlNG1a0y9mwxn1RgxPhz9+SRsXt6d5XPsJ1oKQ6UMsmuo4Cf2eDM
         1OaijywKPWSeaGkZIS8vyBML2fmoX+vCoOOlJD+fhxrGQhcDx7SpmY3MxwQxWMr6gGSL
         QOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740091044; x=1740695844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQeLa18sMIqd5ll6IHo4VMf9DcsVrnxNmwvubrqEs9g=;
        b=HzZvHxbHEqRjF3UErY8BLuO9EiNVrLDLR5UHuVoJjjVCOdoSdcZYI9CIW8BHacDhhL
         ovO89quuLwYTop1NNIEu8c+L6401I9BdonrQYxO3AsvXHXdI29VqoLfCI1pvctyJpJjK
         9EdCrbwmb8H4XFwLv3DpNMC4mTADTz/iQ6nu8e18MLuwqKn1MWoYMqvI//irGDjAkKTk
         JRpjusK5UrR1fpokfdzKH3vPLOjcFnAnIr6wKtS93vBw0E2CyyN35tS+CEQwKc5qYcb/
         MEXwyl/W95WBZfgpyAl4IMheRBDoC++JAgUfFNywlsPPi5zvousKWOeTBX14kuMvjdut
         mbOg==
X-Forwarded-Encrypted: i=1; AJvYcCXDPs+JulUMvL3+JUT6mbHzEcKdOogfR/yU/0tPxbKDpHlqQGmm9cTTC/qg1W9mo1aits/IBnsciicTmGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvxX/f17Lc4q7JeKuDrR4zBdYLv97swS/YZPlQAfVOLr0HICf
	+5AOpoIkC40AvLqDwWVSJRCWqwJaMisjLlLUOX5BK0w8ePIOqxL8Fupxx5wNKbU=
X-Gm-Gg: ASbGncus1x4RLXYmh5RmO6dYre/iocvVWJqegYMNKJLYaaDKjV1UZ+0mOsG84UAvgBS
	tGdqSnzUxrrxxUYFwAnYgRh0CN83aa/DfspT0o3+kDegyiWfUOcsvWoPQeEpglagqz6JWo72ofI
	ryhQIKcBb3aQSiwlojMq5H5eyFsJHQNzyH5m6S796UN4n/ua31eerogv88LkC8vgSS1QZTzZrgT
	P9pygj9GWf/zgVwVarXJuetLonCwvlE3QlHyRbfwMWsGIdGkxGkumVM23pdOIFfHka0Wzkk9Rfm
	/DNUWzsVSc3iPQibMtkB+dOV4fssSDg3lht6ARJHFMHqa1oSkqYY5hAvCvcvZzJh8gwUn0/4lg=
	=
X-Google-Smtp-Source: AGHT+IGkX1BVkOFxcGXRzhZIaESN8QXQksTx19whpdhUSusCfTIWV5/fyiIBR4vnjNYznVFgbP5DUw==
X-Received: by 2002:a05:6214:5190:b0:6e6:6240:afb with SMTP id 6a1803df08f44-6e6ae7c9e48mr14916666d6.3.1740091044308;
        Thu, 20 Feb 2025 14:37:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a4430sm90953856d6.65.2025.02.20.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:37:23 -0800 (PST)
Date: Thu, 20 Feb 2025 17:37:22 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 05/15] cxl/region: Calculate and store the SPA range
 of an endpoint
Message-ID: <Z7euop4i-6orzTMU@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-6-rrichter@amd.com>
 <af32c954-76a4-4328-a016-62248dd68815@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af32c954-76a4-4328-a016-62248dd68815@intel.com>

On Thu, Feb 20, 2025 at 03:31:45PM -0700, Dave Jiang wrote:
> >  	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
> >  	     iter = parent_port_of(iter))
> >  		pos = cxl_port_calc_interleave(iter, &ctx);
> > @@ -3262,7 +3305,8 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
> >  {
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_port *iter = cxled_to_port(cxled);
> > -	struct cxl_decoder *root, *cxld = &cxled->cxld;
> > +	struct cxl_port *parent = parent_port_of(iter);
> > +	struct cxl_decoder *cxld = &cxled->cxld;
> >  	struct range hpa = cxld->hpa_range;
> >  	struct cxl_interleave_context ctx;
> >  	int rc;
> > @@ -3271,25 +3315,33 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
> >  		.hpa_range = &hpa,
> >  	};
> >  
> > -	while (iter && !is_cxl_root(iter)) {
> > +	if (!iter || !parent)
> 
> While parent_port_of() will check NULL and return NULL, it just seems icky checking the pointer after use.
> 

I briefly had the same thought and dug into parent_port_of, erred on the
side of "How many places is cxl_endpoint_decoder_initialize going to be
called?" - but you're probably right, we probably should do the null
check if only for style. 

~Gregory

