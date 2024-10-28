Return-Path: <linux-kernel+bounces-385834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA449B3C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8FF1F22A96
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043BD1E04B3;
	Mon, 28 Oct 2024 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LPZnk7EL"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFE1DFDB1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148908; cv=none; b=WdxTxSi8mWyckYlOSdtHLbgOIr5zTtZoreVjfxZXZVbCUeM6ia5pQaxZs9RKeo7qaAeZr1YfoZgOwGVxYwKqTjIw1Zw/ZwPE/US6YqLsOZHj5BF0zzzFSMU9opHiB54D5OVXP+V+6D9Gqe7VMbizo/Bx9u/XiO+d4AWgKINkJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148908; c=relaxed/simple;
	bh=mberY6D9h2FF/3fPH5MF1ANrAot5jAR61a3ggIvhwTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxEI6a8DMSQ/l7ZFXf8fo0qCTTRnBH69T9qqLPZgblcXu2ZU/HfE5PJuZRe+QhFqf6QMYipX58ApezarGIpr1qqjFhmuN+eZYcHTEYsbhOhRTT2YLomqOQva7DoLwlSnHjloO9kgaG6OR/vgxblAMz70oXPcFe9gTKcYC275YQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LPZnk7EL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460c316fc37so32492471cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730148904; x=1730753704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDZcphslduxQftA1dGeGQDvxcvYJ8FPfDrG3tGZD4oA=;
        b=LPZnk7ELZ41CX5aIBCQzHqLFWf4K/wNPXcpb2y4ZGmI6pHeMox5wJK5OBlFcVYFOkD
         SeEW23H72zXAdCMmvVfm9EaG7wu6EhEpFPvckzGHB7Jbt/KZO7C4qP568Ndl/UrYqhoz
         LYLnv1Taq67Qhlpsf0bVawcL0UhM6fKd6+fNBRmNbRpQ1JjGi2GZQdNYleyReatxlvag
         rNznLUa+34yZNi2tWksC2brhwdaV1yOXwbYVrLrgjDLfs6hCYy92L1Ob/XwtEjrIp55g
         7glhng7dRwhqM73PHpusIA0//R4dCX7cHRnBZ/GsvdW9bfhlvWLv9dGLcVR1oKR+jIkI
         eyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148904; x=1730753704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDZcphslduxQftA1dGeGQDvxcvYJ8FPfDrG3tGZD4oA=;
        b=Hz0/0iwZs5js8Xe7BK63zEC0B9QXl5NVlJGEQNV150Ftc79tTB8yvpU8SpXzsgNquL
         lPzAsIh07KCAreJnkNMFIvXfqEdIwDQegmpeJx4t2Sol7dgEsHHEHI1TiPR5Y3qOWjfJ
         J6hBboanoMAlGzGVtR1L8zOv7z953iDUlQv0qofUfpOrSbd7FhXxwL0QC/l51RoJ1+2Y
         UgTl5R+Ob7EB5LGTUux8vk83+55CiCmWjSCLwEbS48l4K8Ct9gdkmycshKphiy/mhzRU
         jFoIuDfqw1UiW4KMKEKylIK+Yszo9Yed1xuwJU/S8/PRoy1of5nRvYR4OFswqsJ7RK1V
         QSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/G4Mgz9cJ4r3c51hZfzzBFkn2JL4iLPgCSGSkQK1mfANmvSRZrIrlVzB/o/VyXVlGx8QgwOluQAfxH3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLIjYVXkMGGJTgymBdAoXwpvO2wdOPfdYWwynz93uekvtMCuC
	auK6Mv4NToobBDxxzHJlcGc5xs26eHE1OHqzpAUGi4XlEubfDnmPT9BBqiXP1WixZFRcRJSYHYl
	o
X-Google-Smtp-Source: AGHT+IFRrgVw4GmkyKD40m3wsTA7KsK+g/9BRTSNmrCVLWSbkCXzB34WAAMix7S6U/b6Jvjw6Wt6SQ==
X-Received: by 2002:ac8:4158:0:b0:461:57b6:991b with SMTP id d75a77b69052e-46157b69a83mr43391541cf.0.1730148903754;
        Mon, 28 Oct 2024 13:55:03 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613214d392sm38291631cf.34.2024.10.28.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 13:55:03 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:55:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-cxl@kvack.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rrichter@amd.com, Terry.Bowman@amd.com, dave.jiang@intel.com,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, david@redhat.com,
	osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <Zx_6LNyA97_MeBIB@PC2K9PVX.TheFacebook.com>
References: <20241022213450.15041-1-gourry@gourry.net>
 <20241022213450.15041-4-gourry@gourry.net>
 <Zx_I5vPrXmZhQNj0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx_I5vPrXmZhQNj0@kernel.org>

On Mon, Oct 28, 2024 at 07:24:54PM +0200, Mike Rapoport wrote:
> On Tue, Oct 22, 2024 at 05:34:50PM -0400, Gregory Price wrote:
> > Capacity is stranded when CFMWS regions are not aligned to block size.
> > On x86, block size increases with capacity (2G blocks @ 64G capacity).
> > 
> > Use CFMWS base/size to report memory block size alignment advice.
> > 
> > After the alignment, the acpi code begins populating numa nodes with
> > memblocks, so probe the value just prior to lock it in.  All future
> > callers should be providing advice prior to this point.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/acpi/numa/srat.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
... snip ...
> > +	/* Align memblock size to CFMW regions if possible */
> > +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws, NULL);
> > +
> > +	/*
> > +	 * Nodes start populating with blocks after this, so probe the max
> > +	 * block size to prevent it from changing in the future.
> > +	 */
> > +	memory_block_probe_max_size();
> > +
> 
> It won't change, but how drivers/base/memory.c will know about the probed
> size if architecture does not override memory_block_size_bytes()?
> 

non-arch code should be calling memory_block_size_bytes() to discover
the actual size of blocks - and for archs that care about this value,
that is when it should be probed.  It's up to the arch whether/how to use
this information.  Many archs ignore it entirely and use MIN_BLOCK_SIZE.

basically non-arch code shouldn't care what this value is, and even most
arch code shouldn't care.


I added this call to probe to lock in the size since I saw that nodes
will start populating blocks immediately after this.

Possibly the APIs should be marked __init so that the whole interface
disappears after init to avoid misuse post-init.

Possibly probe() should return -EBUSY if called more than once to
enforce a particular probe pattern on the architectures?

Open to thoughts here.

> >  	/* fake_pxm is the next unused PXM value after SRAT parsing */
> >  	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
> >  		if (node_to_pxm_map[i] > fake_pxm)
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Sincerely yours,
> Mike.

