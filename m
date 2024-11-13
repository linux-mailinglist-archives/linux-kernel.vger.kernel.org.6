Return-Path: <linux-kernel+bounces-407059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08FA9C6803
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81319283049
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FBA1632E0;
	Wed, 13 Nov 2024 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I2rqHbmU"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E61632D8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731471325; cv=none; b=LjmuH67tNjtceYIfgPC7ZlFQNnd4cqt5eC4EL9UkFMRyhM9/VhXTsHqVVR6Xo00Q21zFLGYyEe7gH+AYo+4wecM1oYaqFVT9tpHLMPc8LNlzgwIwiSdTUhxVhk1qaBhzqsZpE98m/4icgcq4U6LYnBTDK4vy1Ou8ZpbRP1lrTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731471325; c=relaxed/simple;
	bh=T2rdd7tXYgiIrzYHzCAL/PU41GbaxiH5Y8Q/Zohq1FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1yIuLa5+7f1/3yDKdAdJMdrYTpdchqX+gN9RyOf2GyA2tblEIGDDRLeQK1euQOTt0T6fNQu3xW2gNKwXJRi+WzsQC62GRkTDlGQdp1fQLIbrynqrgptVG0TYSLiERDJKC/ltB7k3QGujfm954Mv5W6NKw7ZjwkJkcQ6ZF6TcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I2rqHbmU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso43617086d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1731471321; x=1732076121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUb1WojSD+HhOKe+sBVX703ySuQYQJYEhxr/ZtFrr20=;
        b=I2rqHbmUPI8ue4wAeGFlxm4cr/jRTxxfKfLtbSaTS2FjnXx1w9RNgVGXWBs1icirL3
         JKiE4XuouyoF3a+HT2Jj2GL70sEtwkAYZDmtzRM6F9xJcq5xA5bwQVcA4DUzgmi5KKJD
         ySfDc8lieJklBiOzxSYFQSLlEOz5hBgPA+/TYQ2YWOqJmvCegWOEzjHlBicqkERK6ibp
         MIULWyX9+46qR/9c1IOZIY63yd08OM6uBZkdz/W1iDyzlOCj/di32v7lxTPSIjuPUmxt
         84vH3qPysyJwoCL/XS97MgvdiXkL7yDxOIh/hyrcsqi9OJs4sfdVY8GApmYzHQWrSZs6
         5PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731471321; x=1732076121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUb1WojSD+HhOKe+sBVX703ySuQYQJYEhxr/ZtFrr20=;
        b=vHYy0z98nD/8rZYho2m8ObGmRct8W1ZdcVwopXMezSp27SRQTLhiIILslOyaDPBJm/
         Id1+66ICHvn0IV2wYC88zB9ppuSEBup+Y3H1S7UQFslyeu/Rj7+DIEerjqojqFjRFwbn
         azoedAIoJXSS7/sikLF63+PaWXe+btMOfIV6vml8rf66iy79Ro7aoTpyrVSHGvl9lTiK
         /J/sgq6TuWgT0DYTT704vH1oDC6yN0WXmkxv+8p4xqJpINs8ewyTmKvhD9EnmGEiiQwh
         Oh4L9mMidf28o5pWLKsavraUROpdZ1NFjpiUUfkKXyhiwIn70HSNX3LP0t0IrvmclYas
         5Oyw==
X-Forwarded-Encrypted: i=1; AJvYcCVaE11t1KecdNEijJczJf4V1GcQoY1E0AX5R9t2iVe/ASP0DyTfzsL1UW6tndgJEwnzSX4hXVpJKLLpq5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpFK3lAPe2ArTzwx8ubG736+r7MPmkwaQfkastyfO4K7Kt8RV
	0Blbb3mjA30PAct/JRd0FzhjnbiW+n6qTmFn0Z3Lyc69+wFlEuVo0bB41pmHBAM=
X-Google-Smtp-Source: AGHT+IFZHlowe441qeuXq5e14Sj+kjnoWxQVfmLizMJ+32RwzXsN2gXKawIsTikUmXrXXVOr5Z+7Jw==
X-Received: by 2002:a05:6214:2f03:b0:6d3:cebc:4cd2 with SMTP id 6a1803df08f44-6d3dd06b5b9mr18850226d6.34.1731471320966;
        Tue, 12 Nov 2024 20:15:20 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac44082sm652302085a.38.2024.11.12.20.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 20:15:20 -0800 (PST)
Date: Tue, 12 Nov 2024 23:14:55 -0500
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: Re: [PATCH v6 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <ZzQnvzPLsamSs7i4@PC2K9PVX.TheFacebook.com>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-2-gourry@gourry.net>
 <6733c86390c40_10bc62945f@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6733c86390c40_10bc62945f@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Nov 12, 2024 at 01:28:03PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > Hotplug memory sources may have opinions on what the memblock size
> > should be - usually for alignment purposes.  For example, CXL memory
> > extents can be 256MB with a matching alignment. If this size/alignment
> > is smaller than the block size, it can result in stranded capacity.
> > 
> > Implement memory_block_advise_max_size for use prior to allocator init,
> > for software to advise the system on the max block size.
> > 
> > Implement memory_block_probe_max_size for use by arch init code to
> > calculate the best block size. Use of advice is architecture defined.
> > 
> > The probe value can never change after first probe. Calls to advise
> > after probe will return -EBUSY to aid debugging.
> > 
> > On systems without hotplug, always return -ENODEV and 0 respectively.
> 
> Should the advice just succeed when the result does not matter?
> 

I figure at some point during __init the value will be probed and subsequent
calls will be ignored. I'd rather fail explicitly in that case to assist
debugging - otherwise it might be a little maddening to discover your callsite
is too late in the process.

> Otherwise, it depends on the caller to not care based on config.
> 
> I do not feel that strongly about it, so either way:
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>

