Return-Path: <linux-kernel+bounces-388974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB09B66CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A601C21794
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDA1F5859;
	Wed, 30 Oct 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DYEUmdjF"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E21F4735
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300494; cv=none; b=m76Qy6UZWkJOhKLsmjmOTUnS05d7aq8m8mstbMkYjEi09XZFuPoEVbKECOMo+aY8QbSYMPZrv7Kp1R63OnORcgt/u3O29twUYxohULG0AoionPGXpxWF9olUOn4gocRMIM8vNrTyXM5hOK5xawzpLSDI9VI/Ky+4T2pyP5upYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300494; c=relaxed/simple;
	bh=FL8y5vH2DP6OO+W2bGbV05vpOD/N9aEaxA/0pmFdX6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4PoO4Lqwo0fz396qgMqXZf2cBrKKBYtV2BxXQjf4f9nC3OkdK2j3xF8eGcJPq57sQ8cbp43M3ejsPvTs2GWNT7LC5c6JWn422GtYrphPPG4guWzQ+5gtwK3W+jAEms+vUakHmRo8jk9gy+0YI/M7fYab6jy8V6w3++FTEGhOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DYEUmdjF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cd7a2ed34bso40650306d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730300492; x=1730905292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q8Onf+m3kOOMRY7hbWMtGK0sJkECClNbY5UDCI4RFs=;
        b=DYEUmdjFGdHgGK+dT9jD0zmz6subT09g6tL6rJhMKfF8dqY2awwrdV8R8S2rk6uZgA
         vBP8DnXGob/dsbV8kRhSA8mBwkshJTMpk1wp2nZkDTS83ADsTR67Ihq4AWcPygx14/Kp
         Cf22nv2pZBx+5OvVsUOEg4mMWMzmaMA0wqnVLHWJ6fxpGKczSSsY28721hreIn2NsgsB
         vP1mxnvCMF58N7hP/NgsuZxEws2qmynqwhJmnDvouVcJhNmO4LVFoUw6g+lWvkVXIr/f
         lKCW9pCjtzK1swnQ3N7HQYqQLqI8roVWKeCGycXnYPDfEFpP0tFF2oAy4xS4Ck9aPjii
         TNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300492; x=1730905292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q8Onf+m3kOOMRY7hbWMtGK0sJkECClNbY5UDCI4RFs=;
        b=sxBAACESmiSt0TuDFIvSRKITKAlhWJugaNHoOjPtXr4r6drqg0h9bZV2O+QY69FRGx
         jHx/A6Mz/IdKk+Ge4d/7dsmVkwZ/vWWZ/LP9nEr43PhZJ5YK/26iIdrGSqhR4uKqYeMv
         7o5sxlvg3rbd5tNWePC8Q5f0b21I0A5Y7Nm9sfQ/5hIUoPsJyWKripiDPWTwe+SD6L1D
         NKKGtoCTZU5GYr1bKqu8cwzI1N2MGt0Hn/O+Xl/M1pPDZBQRhWHDAFAcbSymQy1t9cj1
         5O0wUpDYQKXBiS2lHsuDXJPRhVXaTRDLEuSPukYZxcdcly6Z0t0n/XtBLtnhbEGMeWdi
         YRJA==
X-Forwarded-Encrypted: i=1; AJvYcCWVExF7ilXfeP4+G1nGzWBSjCZvcuFEpymfKdWdnjq1SKyy/7UHTfr75qtt7bdhvdcwMVTqCGX2IUA1ZPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kB3fdDGuHIsC/+H6ChDbefUGjmyVnWkHMmcFZqxZXBeQAHvE
	0tWSp0opt3ZuuJ9DIH4tHXjIrBnTq0Npr48aYWWT61ItKtJdmDv4s5gtbX7Whnk=
X-Google-Smtp-Source: AGHT+IHhuKpLShK8fctWjn/NG1FZnDN5PDqypx/YhKTIWg3COMyVpTWAl/pGdOiRoamvWFhjIhqKWQ==
X-Received: by 2002:a05:6214:398c:b0:6ce:1011:60c1 with SMTP id 6a1803df08f44-6d185849638mr176475236d6.35.1730300491405;
        Wed, 30 Oct 2024 08:01:31 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798a8455sm52968066d6.32.2024.10.30.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:01:31 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:01:36 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v4 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <ZyJKUAcn8iLoV7PI@PC2K9PVX.TheFacebook.com>
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-4-gourry@gourry.net>
 <c47337ea-f20e-44eb-95e8-c29b2db849a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47337ea-f20e-44eb-95e8-c29b2db849a7@redhat.com>

On Wed, Oct 30, 2024 at 11:40:08AM +0100, David Hildenbrand wrote:
> On 29.10.24 21:20, Gregory Price wrote:
> > Capacity is stranded when CFMWS regions are not aligned to block size.
> > On x86, block size increases with capacity (2G blocks @ 64G capacity).
> > 
> > Use CFMWS base/size to report memory block size alignment advice.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >   drivers/acpi/numa/srat.c | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 44f91f2c6c5d..a24aff38c465 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/errno.h>
> >   #include <linux/acpi.h>
> >   #include <linux/memblock.h>
> > +#include <linux/memory.h>
> >   #include <linux/numa.h>
> >   #include <linux/nodemask.h>
> >   #include <linux/topology.h>
> > @@ -338,12 +339,26 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >   {
> >   	struct acpi_cedt_cfmws *cfmws;
> >   	int *fake_pxm = arg;
> > -	u64 start, end;
> > +	u64 start, end, align, size;
> >   	int node;
> >   	cfmws = (struct acpi_cedt_cfmws *)header;
> >   	start = cfmws->base_hpa;
> > -	end = cfmws->base_hpa + cfmws->window_size;
> > +	size = cfmws->window_size;
> > +	end = cfmws->base_hpa + size;
> > +
> > +	/* Align memblock size to CFMW regions if possible */
> > +	for (align = SZ_64T; align >= SZ_256M; align >>= 1) {
> > +		if (IS_ALIGNED(start, align) && IS_ALIGNED(size, align))
> > +			break;
> > +	}
> 
> Are there maybe some nice tricks bi-tricks to avoid the loop and these
> hardcoded limits? :)
> 
> align = 1UL << __ffs(start | end));
> 
> Assuming "unsigned long" is sufficient in this code (64bit) and "start |
> end" will never be 0.
>

I don't think 0 itself is necessarily invalid, but it would be strange.

I can look a bit.
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

