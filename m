Return-Path: <linux-kernel+bounces-389033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4F99B67C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF67283109
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC29215027;
	Wed, 30 Oct 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AhIA4s8M"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A62144D2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301913; cv=none; b=s2+8lyPkhCKudlRiGgR1xwq1fTOzPJe1tUKBAbbJLN3jourRe+44xwuZJJvHw4/2u6UA+wYxRPOJTP4kUFG9g5y28pn9V2M1r8JevObMk0Wm1pMHl1BSQZ9qbPhjZPXt+OUuZRg4iIgMGT9KKsu8RdtMrJPw3dKubODy1F/8QRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301913; c=relaxed/simple;
	bh=NEIgB2tFlQkG+JrX4hQVS8M95TFQSsPnWmdZLvR/njQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1/LThIvqMdM6Rxki676TFY+VjiJt7eCUpLiaFEfymUd+RluOkajZ/LSVmpI//odMILj+0jjDoPsPE3O44scnV7QO3qROM5tVIJeVb/wteXfu0yciPua20BNJs4llQ+6Z6svc1PZcPRA6aO6qRT8uJnMjptCxNAxrd5L4aZiy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AhIA4s8M; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460b04e4b1cso46635211cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730301910; x=1730906710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YLqxwpXuJNQygjoc5/hn+2+ADZpj/AHIhIEEnWpyXU=;
        b=AhIA4s8MqbgWg+ZbRSzG+38DHbbAMKeSwtiPDf925OIgvJqOrGMQneQQtiY9POPQJF
         SwZ6ffTIme+H0/mzempof9BRw2AtR1yxNemfrprls9Wtcd+K4qnXqeliX+jEbpgc+WBU
         ILNstDkhBvL7gFhILPVzv7FngIcSZb5vPk0+VDATMM+yLIOFcGDmn1toMdf08YSd9m4H
         /s8uFfTH2fliMYZE4SDFkcagM0RousZX7LeQUHPck5SGfIFa6gkjfyMF6rBR5WxvNEAl
         QbD+tDKUWsNjyXkupOaP5XIOJPHV4dJnBQEYCcDXVzfOt5lr9wcvU90PdKd0Mry79P7r
         veXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301910; x=1730906710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YLqxwpXuJNQygjoc5/hn+2+ADZpj/AHIhIEEnWpyXU=;
        b=c54AEucIZ1nKTBDDGL8IonqHCcLVFPFKsObeP1AjvcFGufiEoK2AaJW0amjrfH/+3c
         Ih7UhaZdSTXl2Sot4uVtBwWDDDp60LBY3gjSlrNzLIp0ruiNUIHdAdoit/oL0HyUPSxM
         bvqBWxO0VxcAqWwp7ZsBDvuS7G9gWXU5EWGRmmDeZJS9faXnT9NoDqPQQ7vCz/sHMwit
         UR5YUiBD0neirkICILE+vvhSyI17cKFjIxBBFnMpU/N1hJqxO3sGRkv+pS6I50b7vih3
         DeVHJCHiHMdKLUBjt1aQ5i3IhaV8z4lLVfMIIiEr/3g+L/dQjhmSJbqoe8eVh8K19SnJ
         gylQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtsii97xTS34BITDLSkO/u36pfAEUVRCs59l9fwHAd//vrzZpXrdCnm0ll76eWFfqwkMB2jh5zR7BPIgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKHGpRq77EDmFk+3l4uIDn2Ofye3lCd9leJ+Fcf0JQ4sM2Lbw
	9r+5LBpowOJdWqdBg4dTDjFvH1URJ9rePIbE8CFmiHNiQceCKuZRy03PivaCTd4=
X-Google-Smtp-Source: AGHT+IFdUZSjkUbpmwREg45uzgHne+Gkj526u++YBcKniEz4ijMYyFG+sSVSPyJ6DJno6yiyLbeAAg==
X-Received: by 2002:a05:622a:34a:b0:461:e77:d6be with SMTP id d75a77b69052e-4613bff1f08mr234444901cf.20.1730301908427;
        Wed, 30 Oct 2024 08:25:08 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132297c39sm55537921cf.50.2024.10.30.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:25:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:25:13 -0400
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
Message-ID: <ZyJP2c-wHADaE8ox@PC2K9PVX.TheFacebook.com>
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

This will work, if start | end is < 256MB, the ACPI table is invalid by
definition since either the block itself is <256MB or the size is 0 (which
is nonsense).  So yeah i can simplify here. 

Ack. will push v5 once i get KLP to clear another warning.
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

