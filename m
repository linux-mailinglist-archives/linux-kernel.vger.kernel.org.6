Return-Path: <linux-kernel+bounces-406878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18DA9C65AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380CBB3B7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8DD21CFA1;
	Tue, 12 Nov 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aMQnJ4BO"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A21F77A2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455282; cv=none; b=LiaSpo/U2EwKR8ziqUedVayPGHsvEnsNgLsx/dc+jg9nPDe8T9Uo35sGwwxY2ArZHnrLi5f3ULaSXL+UEqrm1alc8zTiheCkcOS6Z1hCHCZI18HlnP+UDWSe/EEEcWkXyb9ydxX7F+deCH3jyXrFZHFEf1dAVtbCe/W7uLEe6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455282; c=relaxed/simple;
	bh=N7dFYszMXv8mOrLoOkSsYfFtGY+5VlTWGDWy+wCc/Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+3oNzCItebEAISbD4+xzO/Nc98dY1G4zD4jaJU4XQqkrcfiOhLlGf7sA2932UGmD+FDFnXxDJJFU/aOIiCc1uFrPzF9cWHBcIXElUuIpkHrI1KIa9x37qrrJbX4InFI2TOwI9KJ5/okJv3ri/gnR8s3L8XKTuzA7e2oU17jiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aMQnJ4BO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf0769512so42375796d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1731455278; x=1732060078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOX9DSgNLbyzHMkGOIxDMiwsq1o4f6ejGQOhBxaCHpU=;
        b=aMQnJ4BOncOEUbjunI/ZUQTc01EBixAoSiqs6gb0lLss+sR65ega/+nqMc2vrZD4tI
         qtBrJ4Qb5XcS2kHa3lQEq7tgX+HkZENJtaYFFekrlCWFgAfTtwzlP2n+dOjjoT/EOm2+
         tXq5dcGpYzgr+cd8pgA0N4xr8xmDUHaHF59lCYjj7XLHjt70hFFpK7cwLD3G3xZd0d/s
         EYfD10szDlD+m0I17jj/ifLMpGV4ONz8u/YBPWnpLJj1anqaV161w+sqWK3Xcn3/mK1V
         PQGio9H+XsNZrUhiIa1YjzzIHUKPQTv7JYAZWVbhbyPHQ1IPjnXXhfKKuZvN0YtVgVIK
         7PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455278; x=1732060078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOX9DSgNLbyzHMkGOIxDMiwsq1o4f6ejGQOhBxaCHpU=;
        b=J1NroKQl6Ve5jJRx1ffP2uIgzXQtPZG9DO8ZqVWWVOs/xL1LHOBzKcS1EeKNv+dT1S
         oOHP3pSzX8w8jFZEUXr/Il2atyCR+T+331qscxSP/jAqO4bibJd1y2CRvs4uZhq4QRaT
         ElYc+yOyedHipwOAqkM+Rm0lmxjqeuI9AeIMCcsA16w7i6X6bLajo+g02WBVIrF/L0nc
         UPCfxg4Wd5pQAUOQYxLBaTJbH6aYOOcUqp/Vg039mte7SLtcLGzcBQhrO+vsWXg0PMRL
         Dv8cyT2mu7/5jEL/onBDo1fsqRHPYii8oPuGZX2dcDPlkt1h5CA/YVJaoa766wcDLQ3S
         dGNg==
X-Forwarded-Encrypted: i=1; AJvYcCV/u24LQANnFjRjh3Ritwrt7i5ZX2iEatAQbgaGN9l4/EGDfOj572YWcnDCNe0ziGwXYI4s07JtLl3JvNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Ce3OTYmWPfxjL5NoKRErnaoSIXIhdRGoqf7PKy30H2BBLRJu
	/18RsakQFu94plhCOrtR9167p2c624/L4Aei94G0dY8i5ryqsQcVX8nn6Vbv7EM=
X-Google-Smtp-Source: AGHT+IESCbVOvkdTgqqmwdwGBZDyO5gMTGBHvzuur/6mM+yLjVaQptGL8/RUONrYdiW+pZ1cU+a0nw==
X-Received: by 2002:a05:6214:5b87:b0:6cb:f16f:65d5 with SMTP id 6a1803df08f44-6d3dd039d0emr15720396d6.12.1731455278579;
        Tue, 12 Nov 2024 15:47:58 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b678sm77555456d6.97.2024.11.12.15.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:47:58 -0800 (PST)
Date: Tue, 12 Nov 2024 18:47:35 -0500
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
Subject: Re: [PATCH v6 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <ZzPpFzdzu-cis114@PC2K9PVX.TheFacebook.com>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-4-gourry@gourry.net>
 <6733cba395c30_10bc6294df@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6733cba395c30_10bc6294df@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Nov 12, 2024 at 01:41:55PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > Capacity is stranded when CFMWS regions are not aligned to block size.
> > On x86, block size increases with capacity (2G blocks @ 64G capacity).
> > 
> > Use CFMWS base/size to report memory block size alignment advice.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/acpi/numa/srat.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 44f91f2c6c5d..34b6993e7d6c 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/acpi.h>
> >  #include <linux/memblock.h>
> > +#include <linux/memory.h>
> >  #include <linux/numa.h>
> >  #include <linux/nodemask.h>
> >  #include <linux/topology.h>
> > @@ -338,13 +339,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  {
> >  	struct acpi_cedt_cfmws *cfmws;
> >  	int *fake_pxm = arg;
> > -	u64 start, end;
> > +	u64 start, end, align;
> >  	int node;
> >  
> >  	cfmws = (struct acpi_cedt_cfmws *)header;
> >  	start = cfmws->base_hpa;
> >  	end = cfmws->base_hpa + cfmws->window_size;
> >  
> > +	/* Align memblock size to CFMW regions if possible */
> > +	align = 1UL << __ffs(start | end);
> > +	if (align >= SZ_256M) {
> > +		if (memory_block_advise_max_size(align) < 0)
> > +			pr_warn("CFMWS: memblock size advise failed\n");
> 
> Oh, this made me go back to look at what happens if CFMWS has multiple
> alignment suggestions. Should not memory_block_advise_max_size() be
> considering the max advice?
> 
>     if (memory_block_advised_size) {
>         ...    
>     } else {
>             memory_block_advised_size = max(memory_block_advised_size, size);
>     }
> 
> For example, if region0 is an x4 region and region1 is an x1 region then
> the memory block size should be 1GB, not 256M. I.e. CFMWS alignment
> follows CXL hardware decoder alignment of "256M * InterleaveWays".

Max size to minimize capacity loss to due alignment truncation.

If CFMW-0 is aligned at 1GB and CFMW-1 is aligned at 256MB, if you select 1GB
then some portion of CFMW-1 will be unmappable.

so you want min(memory_block_advised_size, size) to ensure the hotplug memblock
size aligns to the *smallest* CFMW (or any other source) alignment.

Unless I'm misunderstanding your feedback here.


I'm not clear on why the interleave data is relevant here - that just tells us
how decoders line up with the memory region described in the CFMW.  The window
still gets chopped up into N memblocks of memory_block_advised_size.

~Gregory

