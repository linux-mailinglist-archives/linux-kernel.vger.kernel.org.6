Return-Path: <linux-kernel+bounces-524643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A0A3E566
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF113BEECA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC564214814;
	Thu, 20 Feb 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Z1Yowb9l"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79B1DED7C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081444; cv=none; b=q888ZaE4hM5yhaC1T9cP4glV4NIIkSjiTcm1k1hxYF90SKOAsdEBBRfG3y5Iyne8ocLGV9VvlTWk2vWalECy3Ql8j3J4ve2IkPP3aZAdxRfKsyP1aZ8dxt5IoZ3XqR4rD0eGQq4zvMNj/gXyscbQvSqmoMx+aMtqkMzsPd6jfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081444; c=relaxed/simple;
	bh=7bUrJ1Cjqb2EiUJGa4KTWG7F8qOdrjd3V9ZbYf2XJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeZd2Ky1MLomxVQnCWw/AiFJ74eOaT5mHTgLFAI2EmCkfZsXFwVNyVW5MeVXhe4PztsrSJ3bQvLzM/JZxsDAc0FrdHBObHmU922VMlkXPTCGuQopdZpshvhExb8ZRc8thzSCJESPF07gS/npUMlv4xGBSQ8aHlgDZ1zg3y2KKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Z1Yowb9l; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c09d7bb33bso101080685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740081441; x=1740686241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUhOlff27U4QoWDOX5P1YVDFfN2sk4tXY1Rf/8iKATQ=;
        b=Z1Yowb9lxccYsNR3ecyU9GJ80VlKfnOmHhtHu/mPWj9DxQ0wBbIGLvFuSpcpq9JekH
         homPPGJlDOG5xy3AD9cWi371EIAiXdZVcr/VRW48+DAuzquUArpvMBTRTHJCBRkW/dbq
         8L53ZdhrJK42a+SdHI+Lyvh+TovjK03KhORXDDA3O7uimC8I4QlcZNJsG4GpogPXDH/a
         AJTYdVqlsLAZlaEdXz+8Z7/Xg+tiiS0aEZwYWkNwxX5LFfzyoTREKQsQFUmLcsM4AL7R
         hO+YsN7miq1TVcozlwfEhSEJQT7u6u8el6PVJX7OaDu1yx/u0HZpGoE959XqquejVV+L
         JXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081441; x=1740686241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUhOlff27U4QoWDOX5P1YVDFfN2sk4tXY1Rf/8iKATQ=;
        b=Q5fTDrcuz4tNLK81OzJnd2cqO6bUkOnzFLRovGNyeMD9luzU4ueilPNtHX/hfXTKmN
         t/J+4lEnESSc5hIE+0+VVhQhPhiXHOpsBFvpXpa8aj7MKAQXzwp3Qfr3r0ka842sXWKH
         o/8KZg0q12+DLiAr+sir4gzREDetW0qUceyUXsd8ale9Jwt2oALlT6XLd978AilAHZ6i
         duEs/K+rT4W/gwGz1BMFFst75jhWAHyMJJuDvlLj5d4TvfFgDcEjQk24f7uCqjBVyBUO
         mK43T+cXa1vcy2tdsGJWNGQulXytXqxmB6IcH86TkiA46Bn5ktFbnQdd+KNnD9LySjt0
         EFfA==
X-Forwarded-Encrypted: i=1; AJvYcCUTuBkM9E3XuYqkhkSj8bA9jiZ5RfdxfCzaZKtr9CIdlOq9lxH5jU/5oswfWsHU8UvpPTZ39q4FORjwqyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUxf3ylPOi/2DeAJjHo1srFTHwwq7ETvnnn5VUc5FtU3JxHZA
	aYwkB598ig2Nk6lUMqjV3lLkt4Inu/uX09UOSYLmEU+AqCWo/gmm1IlVFyWfLPc=
X-Gm-Gg: ASbGncuM+AOSYQSsxaTundGHWSNnu4rEfJmUZsvV9nABos9ZcX3M6K2q7Q6QE+BdHG+
	I2QXF2Zp/2O7l+TEF02TVe7OMobWeWQLtvex1E5Eeypk8ab1z/aQvUUnygURbM1eQCAHDiud2W6
	YqHF0stlYrs848jmEifR8PCTalWGiM0lF7WOk1y+f1wqH1HLXbvs/0a2MJ5J1qRUKKig//+u1/L
	/nyTNKRRTfZlNXpHBTs6EFdv2dWITRhTDGmzVb0Ero6Jn0UGBwLQ2h787JZERhJUHbu7WWv9lT4
	h7F9UZfuhbPRuDlwkkWEXmJ8nWddUpKvgFlU6bHCOHKxtas4Tqxh1GozFu7MHKCV8FfFbKmwcA=
	=
X-Google-Smtp-Source: AGHT+IGF+v/hS/yyKv5D1whZamS+A1vgR4WWuNyb6f+i2eFGhFkLObm9Oi2CTo0XkJ9/LAnLFRGlwg==
X-Received: by 2002:a05:620a:40c5:b0:7c0:b0a8:52f1 with SMTP id af79cd13be357-7c0ceefe6abmr85895585a.13.1740081440746;
        Thu, 20 Feb 2025 11:57:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a8cf5eadsm405080585a.11.2025.02.20.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:57:20 -0800 (PST)
Date: Thu, 20 Feb 2025 14:57:18 -0500
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
Subject: Re: [PATCH v2 12/15] cxl/region: Lock decoders that need address
 translation
Message-ID: <Z7eJHpJT2j-2BLvH@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-13-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-13-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:53PM +0100, Robert Richter wrote:
> There is only support to translate from the endpoint to its parent
> port, but not in the opposite direction from the parent to the
> endpoint. Thus, the endpoint address range cannot be determined and
> setup manually. If the parent implements the ->to_hpa() callback and
> needs address translation, forbid reprogramming of the decoders and
> lock them.
>

Re-reading this explanation, it reads oddly.

I think what you are trying to say is:

On platforms where endpoint decoders require HPA-to-SPA translation,
decoders cannot be reprogrammed due to opaque translation done by
the platform's memory controllers. When address range is modified
(translated) lock the decoder to prevent reprogramming.

Is this accurate?


> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2ca24565757a..dab059ee26ef 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3410,6 +3410,17 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  		if (rc < 0)
>  			return rc;
>  
> +		/*
> +		 * There is only support to translate from the endpoint to its
> +		 * parent port, but not in the opposite direction from the
> +		 * parent to the endpoint. Thus, the endpoint address range
> +		 * cannot be determined and setup manually. If the address range
> +		 * was translated and modified, forbid reprogramming of the
> +		 * decoders and lock them.
> +		 */
> +		if (rc)
> +			cxld->flags |= CXL_DECODER_F_LOCK;
> +
>  		/* Convert interleave settings to next port upstream. */
>  		rc = cxl_port_calc_interleave(iter, &ctx);
>  		if (rc < 0)
> -- 
> 2.39.5
> 

