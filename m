Return-Path: <linux-kernel+bounces-225183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEAA912D38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539F21F25D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF09717B416;
	Fri, 21 Jun 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6D94MCr"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27F17A934
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994751; cv=none; b=ljUGGn0XSd3jmQvYb5KkFQfq5AW3h26dt9ZFO61RkNWNpKfw4QZtn60uF4Prx+MklRtvsebkfgEiWzU9NvPBmf7OBguEDOTNIjUP6QY8DLt1XTsGXrQgHLS0KAPIHMEXWftKpcT4sclE0zD4brHDF48nV7SBhTwczwpm3vbxask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994751; c=relaxed/simple;
	bh=thhtlSie8YVBkDY1b+PMHQ9EaUfvPElL5+RTRl0VROg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfTR1QZ9xL3o4SjeuQBTS+vPdut05zp6lQzkqbaDXYf0lipuN7YG9LHIbP5LdiACgbptL2xU3bt0MEk6KocMkcvKPQQnMutUd8MibOr0OzmAJGT1tJzIwE199ejqB9aDdLMKPv5oVg0jPg4Jpz+cpFBcpRhKZDUu7+11bCzX/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6D94MCr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cd87277d8so835031e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718994748; x=1719599548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bq0UL8IzpOonk6RfZKl80LUoC0gW9D6P21SahttrDvM=;
        b=O6D94MCrQ4RvjZaibfsJ/Bx2+8yK7wX7DyQKFJgQKwpMFg86giHgdFPMPyn7Jd6GAW
         1nbRWo67vu/tQTte84gAsNo35Sy0ihk0dxuTTKnFQKEV7y2gLTnAazbuFv2kTub6fUpn
         RD+MFgS7HxJ/9WukN0aFWW3pW05dEZR/dPwy1tM7dH5TLY2NR6YScjyb+92Rm23FbjTq
         b4yiXdxmD8v1IJev9s+InHpR6t5guattkwrspGMajcqH1mdnjs50uU4PR5ej6rVH34n3
         28+4aiEzAG5XTvHky6oQBg1hF4HdjJwsZCNlk6j1HIHmQURh9psTzfXothSGn+92h9yn
         Kw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718994748; x=1719599548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq0UL8IzpOonk6RfZKl80LUoC0gW9D6P21SahttrDvM=;
        b=DYhc4VvDXOVT5faj5q6cwJbrSFhg2MFqpGT7hJzoMmTWlXamE5ybBh7HQO+tdu0OCB
         j20NPBpk/ADCLM0bxWQVqcCKXwkFdQKFIOozVLf3A1FCOgdD05ajgwDAsNrEUpmm8fss
         Tvc9D3VJRAE4g2/s6QcmlDyW2xWQ7+9+azA6DKhi64V9L/BO3BzAcyA+ZPRLmmjjZrFw
         lVd+0G/eKjOsX9IroD+R0sYdaV6dfApppIVtmyKliUfQeIAcBN9JCVpr8CiX8fi7mp8r
         JvXuwu5/c7553pG8e5OcJnKuyoHd8ze4noci50EIaI+yHxeIaClc38QZ2Ah7k7rZ6aKW
         by0A==
X-Gm-Message-State: AOJu0YzcqrSaz5Jfra/gzuuTt9Xtz/fKXrW61z+WsSKQUlW2pXltfhgv
	aaTIrnCyLmt4NDFjwPDOHMZiX/EEVkjJlZDEfBWarP6WvgylqAA=
X-Google-Smtp-Source: AGHT+IHzg95NzN8ePMceXpdhLLVEiWevt2VQizHAjHxnmLlaZjvMGCSW/E0kFTwyTHIPrCDE9GmgXw==
X-Received: by 2002:a05:6512:3995:b0:52c:8b72:3cdd with SMTP id 2adb3069b0e04-52ccaa9190fmr6935367e87.47.1718994747471;
        Fri, 21 Jun 2024 11:32:27 -0700 (PDT)
Received: from p183 ([46.53.254.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf54944esm108628166b.101.2024.06.21.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:32:26 -0700 (PDT)
Date: Fri, 21 Jun 2024 21:32:25 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] build-id: require program headers to be right after ELF
 header
Message-ID: <ef904b3b-e9b2-4fb4-bce6-72eb4f2018e2@p183>
References: <0e13fa2e-2d1c-4dac-968e-b1a0c7a05229@p183>
 <20240621100752.ea87e0868591dd3f49bbd271@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621100752.ea87e0868591dd3f49bbd271@linux-foundation.org>

On Fri, Jun 21, 2024 at 10:07:52AM -0700, Andrew Morton wrote:
> On Fri, 21 Jun 2024 18:05:50 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > ELF spec doesn't require program header to be placed right after
> > ELF header, but build-id code very much assumes such placement:
> > 
> > 	find_get_page(vma->vm_file->f_mapping, 0);
> > 
> > and later check against PAGE_SIZE.
> > 
> > Returns errors for now until someone rewrites build-id parser
> > to be more correct.
> >
> > ...
> >
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -73,6 +73,9 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
> >  	Elf32_Phdr *phdr;
> >  	int i;
> >  
> > +	if (ehdr->e_phoff != sizeof(Elf32_Ehdr)) {
> > +		return -EINVAL;
> > +	}
> >  	/* only supports phdr that fits in one page */
> >  	if (ehdr->e_phnum >
> >  	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
> > @@ -98,6 +101,9 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
> >  	Elf64_Phdr *phdr;
> >  	int i;
> >  
> > +	if (ehdr->e_phoff != sizeof(Elf64_Ehdr)) {
> > +		return -EINVAL;
> > +	}
> >  	/* only supports phdr that fits in one page */
> >  	if (ehdr->e_phnum >
> >  	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
> 
> Well can we get comments in here eplaining the shortcoming?  That way
> we're more likely to get a volunteer.

Sure.

> And please drop the braces?

Bracers are good. It took hundred years to drop -Wdeclaration-after-statement,
I hope to see mandatory bracers by 2050.

