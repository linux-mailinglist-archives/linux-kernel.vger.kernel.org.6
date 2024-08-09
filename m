Return-Path: <linux-kernel+bounces-281528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDF94D7CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2645D282B68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484B16088F;
	Fri,  9 Aug 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akdgBJIZ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CD1D551
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233706; cv=none; b=Z1/R7VtEfZSEkOaRkdOUSw/Rbe23JCPDrKdBGtPwHN5nQGaJBcPLszQ4KxsxC4kCpmBAEqiP6Wl+l+Ue13wfN1HI92OrsebHGfVIcrtr/aENDSKphpoMz1kJfQ9Qatxjqj3AG/rZR1Vig/azBgQuSN0Sv3AO66PM19PhE5TpNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233706; c=relaxed/simple;
	bh=TNLYKaOh+vXkzGubqpxPtUj8YBAHq2VsF1/p5ZbPDrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOhMR3koBfvCxt3rdl0QqzT+kRDy8f6KmpBrfr+aUSGHgNNLZukCC2MUR6LrziKIM1M+qOYXC7kaU1GNqRrrjjupXYhiN9lP7K9VxM/2pA2OJi+drJynnjA+xsbKJG77ObRBgV0df2KreFj43aHFJ1pBkY2N5LWLKyhgRVuf3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=akdgBJIZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so3038308a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723233703; x=1723838503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMUz/aPsGaSf3AR0ZEFloy0Ww3muXJ6eOj3CetN6o6E=;
        b=akdgBJIZpjyZS7QnEJfkRXvuNHjgeh+ItYaNR1DnLujQokt8AOG7cpumc415ZqeHbo
         RpK3z0nbaeupy9x4ByOOJCiTCkxCLiO710J+FSR9TuCq1qOB5WsXffIV59ethMTzRL2W
         BRBy280WyYzsm3Ue7nO4VMphrZE4UWxis+iKPP+RDQ4Onhl73wQ779KJLMBu44pS8dOt
         VSwgcKUoRJKxYJaiS8sfs2pj3nCEwjKlhvcWkX8nk/q2XcOfrbUgB6NvtYDAuGlCdUQA
         ElsahOwBzRv41ir3XFKH/9BXPp5ZlaGOxAS4fZi6wnrIR6FFVKodDTfdBrLyi0ZV5/F5
         yC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723233703; x=1723838503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMUz/aPsGaSf3AR0ZEFloy0Ww3muXJ6eOj3CetN6o6E=;
        b=LBLtoa1UFsmZKs7agrYumbxMWMkc8dNFxcKxpPMBBtYGijo7cDr45BWONMKtVzLP3X
         kSF5CaAMWqfN+t2XcFno/eb2IEVND3pFGe229J8SiQipDZf28yRJbnd4c3IWvGgciTNl
         2+jgphS7Pe4z9xRT442ym0aEdfdKkB2vPODdDAI37i5f4hl7eHx9erLYeQRM8JsEk7a5
         C8tuAhCLFdoEfl9eCstHcLm92LVARh0bUiCGmmBAAQOdwaJm+MnlDj51x9IHUjZ1ylUB
         KNbEyvlLqDihg97eW7knWjpZRqWV5hyjdgJ3VrujkfFk2JK7DvlnEMTurINORyQmK68k
         gkrA==
X-Forwarded-Encrypted: i=1; AJvYcCXqGRR2euacpeBjBZ6FlsrwdjGrtkMzbkVfnrwJnkgNi3C4z0tJgFt+3bvMlbSck0oGaJY3hSFncrdKKoTQB8hqH10qVG+jp372CexF
X-Gm-Message-State: AOJu0YxHG7V8PsnwZaxoDlBZI69bag83IC6RYyIA/0CbqoijCz4PWsca
	wm1p1Mh2d/EG+qHMjysxr4ZSkcRRjwlTU+yqG4WFm3vm8Endagd90yjdKtbAOFM=
X-Google-Smtp-Source: AGHT+IFp6SPqZJvmY4Rp3COtc6Vyho6/Ic6I4+ja8ES14iyIMQ5Ho1Cxum8VvNzfD9FABxLcWUIK0w==
X-Received: by 2002:a05:6402:43cb:b0:5a1:7362:91d9 with SMTP id 4fb4d7f45d1cf-5bd0a56c918mr1327974a12.22.1723233703104;
        Fri, 09 Aug 2024 13:01:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd191a20fcsm58144a12.36.2024.08.09.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:01:42 -0700 (PDT)
Date: Fri, 9 Aug 2024 23:01:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: compaction_test: Fix off by one in
 check_compaction()
Message-ID: <20ad879e-689b-4b09-823c-4cb4f9b010e7@stanley.mountain>
References: <87470c06-b45a-4e83-92ff-aac2e7b9c6ba@stanley.mountain>
 <4c709253-50de-45ee-9cbf-8bed65eff857@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c709253-50de-45ee-9cbf-8bed65eff857@linuxfoundation.org>

On Fri, Aug 09, 2024 at 11:20:48AM -0600, Shuah Khan wrote:
> On 8/9/24 06:32, Dan Carpenter wrote:
> > The "initial_nr_hugepages" variable is unsigned long so it takes up to
> > 20 characters to print, plus 1 more character for the NUL terminator.
> > Unfortunately, this buffer is not quite large enough for the terminator
> > to fit.  Also use snprintf() for a belt and suspenders approach.
> > 
> > Fixes: fb9293b6b015 ("selftests/mm: compaction_test: fix bogus test success and reduce probability of OOM-killer invocation")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   tools/testing/selftests/mm/compaction_test.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
> > index e140558e6f53..2c3a0eb6b22d 100644
> > --- a/tools/testing/selftests/mm/compaction_test.c
> > +++ b/tools/testing/selftests/mm/compaction_test.c
> > @@ -89,9 +89,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
> >   	int fd, ret = -1;
> >   	int compaction_index = 0;
> >   	char nr_hugepages[20] = {0};
> > -	char init_nr_hugepages[20] = {0};
> > +	char init_nr_hugepages[24] = {0};
> 
> Can we exceed this limit too? Can you make this a define?
> 

It's based on counting the digits in U64_MAX.

18446744073709551615X
123456789012345678901

We don't have any defines for that kind of thing.  It's not a bad idea.
#define STRLEN_U64_MAX 20
char init_nr_hugepages[STRLEN_U64_MAX + 1];

But it should be done as part of a kernel wide clean up and not part of this
buffer overflow fix.  The line above it could be changed as well, for example.
Let me create a KTODO and hope the internet will take care of it.

KTODO: create defines for STRLEN_[SU]8/16/32/64_MIN/MAX.

Btw, I rounded up to 24 just because I like buffer sizes that are divisible
by 4 but the compiler is probably going to do that automatically either way.

regards,
dan carpenter


