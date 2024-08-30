Return-Path: <linux-kernel+bounces-309499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED147966B73
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F511C225B4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB3158522;
	Fri, 30 Aug 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oW3eEVx2"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BF16BE03
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054312; cv=none; b=p+tpZLn83bIn1lkEd7CTvk0leIShDHBHwV7YlN1g9070Mc3F1fZfiTdSRSXejgJO8nNl3hZ3xcLYOC5YP7NqSIBtoNfRh2nEjWSi0Xd4V7XW1oaNcIRbzo4HzjqZIkryvjqqOYABO0FONgtC7mFW0t4/XwQkNu3ycYuPNjpCpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054312; c=relaxed/simple;
	bh=jY2f6hdUNrBcTP3s1l6HmvunmvX/o4bAQuAo1MwTAV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNwMg5clw+HUcRnlbWbq3u/NHLVar8kZBVumYqoMJKdd1ajkbw9Pe7X4WUfa/7npx9n3w8hXNNT6xhHerQFVOxU07YyrGjnVgfHISSF79xG7/DjhxOVjQ34V0CNZkBTsOXRsQSg1rBVeeufj67tRHa2e5qcJpEnC9oO42Hsrnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oW3eEVx2; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-26ff21d82e4so1320725fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725054310; x=1725659110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xylz0mwWzjFrdaZpGrna2u+Ajnu8hOvOrwmJ4DUtico=;
        b=oW3eEVx2TcOHMm3XCG1rrTBNx2MBIsCaR/iuLaqQ0OIHKlUi/aCQY3Bf58wnF6q+Uo
         xdLvRb3p0lEomYmExMuGu16njWqs9r5gAXPcD73QCsgGDcUJL8mDdtv5bBEQ3jf8dh15
         lv7SopRbd/U5KAmPMkqHxbedzPyAH2QiMmvEoLxCh+2LJYa8dlO/o6UG9T21NIBcWU60
         pAIRcEhoRg2+aiO5VKfq7BWhEratlugsVZiRJc3vFt1fuLWQe3LO7Ya7hZR6wUabIxjq
         jxCuMSfbNhB+xpYwoZQ9kym7omMvHzv2idpcXk1VRkS9LigzoeRBXKmSn2s2gHgtzaFc
         nkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725054310; x=1725659110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xylz0mwWzjFrdaZpGrna2u+Ajnu8hOvOrwmJ4DUtico=;
        b=G0SndQIGS29KqquxwLDtQkYPAwrh8crkBrkTuf/Fv3BatOV3Ha8d+sYmLAGQoERWeh
         NP7RJZKjuHKV6YoZQSy/08MywShK//KISDTdLIX6SjDW14fNfnQfZ/VXq8CUZPVd5deB
         cnSYI/fXf3SwklFi0Ho6oMz7GKJu2jUx/xuDt7N99/rbd4yFuJTBo7kbpLFMRcdCJqiM
         EtQKgyFavKJskE8Crh5z9uVOcyZJm/OEVS7gB/unCjml20ofqukMZRCyIZBTa06GPLRD
         eiuywDlRozc/mHXVGJ8v+vGhVtYwgGTTP5ZuXJI+mz9WztlXtgf2QxuPIypwzJlOEc6J
         iecg==
X-Forwarded-Encrypted: i=1; AJvYcCUId38wgEgAzVEqMpNYKW3DtSTculpqgoAPvnhXvxc01A7PGY8/JmV/v1R1HXyLzR1mQxLHUZTly8YbenI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykpvDoWNhIRgZKP9lPRKpk7kSWKfCUl7dE0c3VPvbm/tSNH7Dj
	AZRUMBPZw+8D8PhO1ThplXaM6G7FDNUDRmbNve4jKhW+BUajmwneXNZbZJtuelI=
X-Google-Smtp-Source: AGHT+IHwLTZAKBqQ7a2kydEg3gYbyQRt34soHL4MRlYgHN1moHi71IiUobsJkYMso64jNXFA45ybig==
X-Received: by 2002:a05:6870:c98b:b0:277:cc56:2300 with SMTP id 586e51a60fabf-277cc56360bmr437328fac.12.1725054309775;
        Fri, 30 Aug 2024 14:45:09 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c241bfsm182988885a.28.2024.08.30.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:45:09 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:44:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	ardb@kernel.org
Subject: Re: [PATCH 2/2] tpm: do not ignore memblock_reserve return value
Message-ID: <ZtI9ULGWeBKAVqUV@PC2K9PVX.TheFacebook.com>
References: <20240830132303.6665-1-gourry@gourry.net>
 <20240830132303.6665-2-gourry@gourry.net>
 <3f79211f-f82c-4e41-9b40-e0abcbb4bdf0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f79211f-f82c-4e41-9b40-e0abcbb4bdf0@gmail.com>

On Fri, Aug 30, 2024 at 10:33:22PM +0100, Usama Arif wrote:
> 
> 
> On 30/08/2024 09:23, Gregory Price wrote:
> > tpm code currently ignores a relevant failure case silently.
> > Add an error to make this failure non-silent.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/firmware/efi/tpm.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > index 9c3613e6af15..b6939a6d44d9 100644
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -61,7 +61,11 @@ int __init efi_tpm_eventlog_init(void)
> >  	}
> >  
> >  	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > -	memblock_reserve(efi.tpm_log, tbl_size);
> > +	if (memblock_reserve(efi.tpm_log, tbl_size)) {
> > +		pr_err("TPM Event Log memblock reserve fails 0x%lx - %x\n",
> > +		       efi.tpm_log, tbl_size);
> > +		goto out;
> > +	}
> >  
> >  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >  		pr_info("TPM Final Events table not present\n");
> 
> This was not a proper fix for the issue, sent a bit quickly!
> 
> I have sent it here https://lore.kernel.org/all/20240830212852.2794145-1-usamaarif642@gmail.com/
> 

This change addresses a separately, discrete issue and the two
changes should be different patches (this is aside from the change
you posted being incorrect for v1_2).

~Gregory

