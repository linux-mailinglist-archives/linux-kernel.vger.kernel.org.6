Return-Path: <linux-kernel+bounces-346905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1E98CAD6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A6E285B07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D883232;
	Wed,  2 Oct 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3sc1GJ/"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36D23CE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832585; cv=none; b=tQhYHCBt36ZJ3cBYqSVaSaJRrJtHRrYSzHrQswawaXWLRj2ye0p7Wx1zylCtmQxIBUWjNmZkCxVtfw/VKxnv6c+1BFWeFKC6X0gZAj2AMUlfTQ/jytfjp1sO1hEJZDpagCoqiCVfrAPGSJvgQKiQlRAcsZxn6NRK9gTw3b7KU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832585; c=relaxed/simple;
	bh=no7c8fJI81iYL9/KAir8ED8q+nd9xskRoiPL4Pagg8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIvu7MMjzZqb837SSRGCp5Jzr6zKvUhrn0XOT/FGvBAN4wrjAttaA08YXvJmzfF+YH5pkyPexM3hH/BPByT/WD3wQNQgFprmr0HSaifeH3/j/F5XMaZSFdDrXwfXnWI286XGhcbLziDT3hARN5VOtqtena483Yz04aeGeQud47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J3sc1GJ/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dc4451fffso748636b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727832583; x=1728437383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3l2P/cYnFNGuy2mvgzIdF3YdyJAwX1+PAF9CRrwubs=;
        b=J3sc1GJ/a5meQ1yIFYgMZK01Y0ckLr8qL4SqMfVoBb5CsMIXEd1FDLh28lSWCOmcrt
         h7ivMZ8UQkYLwZNx8F5MsimYCPBMDxisI/4mGc7Olo3pTezb/s1I2F9xdktECHFHXy23
         pzLiDS90YRFGIG0+nGdPkvcry4GhHQnm5qBpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832583; x=1728437383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3l2P/cYnFNGuy2mvgzIdF3YdyJAwX1+PAF9CRrwubs=;
        b=m3djbDHOqHge1cOrB6nOR/i74EdjmMypRbhJSbgLqdhpI79mt+rHk3Hul11mpbbMTD
         0ZHTwnx05uUpQsJvzbgzNAUZiYUDH7HJopfCT8B5GlC3na79KYfG3qRKm+FhmPpBjd9U
         /NIMkeg+J6o0jbOxxd/M6W9t5B0QPmYHpeXcpUrO75KrR+AVD+tFs9l9iEVocBnKnP4E
         rAQ+BSL/yKa9PDnhaJWCgKCQsmP7ELQ0ipKnanz6Zi7xQb3e7wDpCkw9fp1JIGXT8yUf
         2ImhnTD2B47pyt/cz6A+lT8FQ4HG6G8sGIh2N5n5xpy6VyAgalLFDNPaxkfYRSDx9zeG
         uhXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUle1KroTu4SzWDdl3xiiFVYK2MI17oYHt/zCAASE9RStJio3mEYFmAUz7Ajppgdo9zq3j2MH1ffWPrf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJ7LJZXp4LueSJlmeZnjwe4Gi4a5ekkzhk8fvGwMBUyj8xqbY
	TWo8+NHD99MRfdowFI0HfVxfiM0KW7qMvmyYmL7NFghD0a4hOo1WGINB+1QN2XOq8LUeUfVfHGG
	hBw==
X-Google-Smtp-Source: AGHT+IE/ZlTPT6cMujCkJgHgSpXk1qyHTk9xUWaV6F4Wdx8+bmjkOrhRlNdqs4abiwS1P7xiCxzOMg==
X-Received: by 2002:a05:6a00:1956:b0:70d:1dcf:e2a5 with SMTP id d2e1a72fcca58-71dc5c4499bmr2479853b3a.3.1727832582748;
        Tue, 01 Oct 2024 18:29:42 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8dcb:9ffe:3714:b8ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264d3c9esm9020233b3a.96.2024.10.01.18.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:29:42 -0700 (PDT)
Date: Wed, 2 Oct 2024 10:29:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] zram: do not skip the first bucket
Message-ID: <20241002012938.GH11458@google.com>
References: <20240925005315.89E59C4CEC4@smtp.kernel.org>
 <20241001085634.1948384-1-senozhatsky@chromium.org>
 <20241001145739.8afe344d456d90fb6e8d96d6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001145739.8afe344d456d90fb6e8d96d6@linux-foundation.org>

On (24/10/01 14:57), Andrew Morton wrote:
> > A small fixup.
> > 
> > ...
> >
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -264,7 +264,7 @@ static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
> >  	s32 idx = NUM_PP_BUCKETS - 1;
> >  
> >  	/* The higher the bucket id the more optimal slot post-processing is */
> > -	while (idx > 0) {
> > +	while (idx >= 0) {
> >  		pps = list_first_entry_or_null(&ctl->pp_buckets[idx],
> >  					       struct zram_pp_slot,
> >  					       entry);
> 
> I hate to be a kernel bureaucrat, but there's a lot missing from this
> changelog!

Oh, sorry.  I thought that would be just a fixup patch that gets
squashed with the patch it was applied against.

> a) What are the user-visible runtime effects?

There aren't too many.  Buckets are size classes that hold compressed
objects' indexes (zram slots) that are candidates for post-processing
(re-compression of writeback).  The bucket 0 was skipped before, which
is the bucket for compressed objects smaller than 64 bytes.  We rarely
have anything there, such level of compression (PAGE_SIZE -> 64 bytes)
is not common in general.  The lower the bucket index the less
interested we are in post-processing of the items there.  E.g.
recompression of a 64 bytes object with more efficient algorithm,
even if successful, probably will save us just a couple of bytes.

> b) What is the Fixes:

It doesn't fix any upstream commit, the code in question is in
mm-unstable.

> c) Is a cc:stable needed?  If so, a) is super-relevant.

No.  And a) is not super-relevant.

> oh, it's a fix against the mm-unstable patch "zram: rework recompress
> target selection strategy".  That's new information!  Please disregard
> the above.

Oh, yes, correct.  This series:
https://lore.kernel.org/linux-kernel/20240917021020.883356-1-senozhatsky@chromium.org

> d) what was wrong with the original code?  And still a).
> 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> e) what did Dan report ("Closes:")?

It doesn't close any known/reported issue.  The Reported-by tag there
is to give Dan credit for spotting that "typo".

> Sorry, but this is all stuff which you easily had available but which I
> had to figure out.  And which I now present to other readers so they
> needn't figure it out.  That would be inefficient!

My bad, sir.

> Ho hum, anyway, thanks, applied as an effectively unchangelogged fix
> against mm-unstable's "zram: rework recompress target selection
> strategy".

Thank you.

