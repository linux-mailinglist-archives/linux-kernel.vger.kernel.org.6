Return-Path: <linux-kernel+bounces-531663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF1A44369
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AE319E2BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6A26BD8A;
	Tue, 25 Feb 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbXsH3Vf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB1268FFD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494465; cv=none; b=jNL3fyRFltRJ4mAu2f4k1P3bqzNtmYB/rVOypMjmPd2Bk3k1Rh0KGTy3ybczN1ns9AEu1VIuMGYOjqq10MKXnBNL65r6sWwmzKnbxsCGEwyI6qPRQ6gX71l0iDt1J+NAYDfOgRf0bo99RZntGY+VzpYtV4D8bVcrBchjc7WypA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494465; c=relaxed/simple;
	bh=GEUr7lnI35WzYb/mPh4d5UB1M5UUR2747skIsV2YE0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxIaLTTrFk6Y85TUTyghymFqLgVsT1qI4BLut0MFqASyRAIfMXFlbQKyMPgsw+56V0ZixBV5LMrvPJPA4WhdCyRp3PAjtT2/FPeTiUFxssqjlVFT4Z93xK2br+UrOg8y11xhZrhKRgOKnZ0qw34fJYLS6Svadlaxkaipxu94RNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbXsH3Vf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43a9e6cd0b4so45925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740494462; x=1741099262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVPLkGH9fsfezCsdG/LPsCweWncjUk5oFN3XESRzpwA=;
        b=pbXsH3VfO7FA8T5/GApXEyKeYVx1JlCqtIlj6sUZ/kSpZSL2o/ucJp99NGJ0K9q2lk
         DjAQNsjntl/fOKy90zxIXbNKcr4ttucIQ423TI9BVvy2VFyvkXdcYqgnlUeTQUnvYGDk
         KIN+vK3p1xPfcxCGFDrq16XfPvzvoR+f4jnvxKN8KXaVCZN0Jx53/yRfvpEyJG5xrb1N
         gACWlRTfrowzmyBToHwwRXSdgYt6+nazyvj6MOO71msTmbGVncmpuEnsykxljwQ9mKOK
         rC0SiZu9Zc2u83bUC9XkZKrqhckG6LzVNsvR4cO9V73EGqb+Shba4S/9WlmJ86AD1o1u
         KN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740494462; x=1741099262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVPLkGH9fsfezCsdG/LPsCweWncjUk5oFN3XESRzpwA=;
        b=l6qZSVnNDP8RqWiF4OiFhY8D/7Wl9C5JQO7gtD5eP4V8iWbBdL1F1vWW4wDdfd31xc
         dWd7Yv2zIKrFZI/RYYELI7EykK6YslUdp9lT0fg8b1YQFVz3+XeRdaR5Gm58tu0WQW5x
         703cA8W1A8gIOfQP/BIHpRoBYLlA5U97IdXsgRVeee2MhB2fhUA+t4HFUZws596bobnH
         wKeiCJHCY58XKOER9JTxzZQ5nybTi2gYSzXjheivA7z2qxxtqv02cxKpiD3fipLE7eLW
         8S3hIC7ANAN/cTZk03ScrF7XJv1c3aoPUZN/qmX6hAPrLYnVhbcHjC60e/FQUpomIII4
         GTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxdlCYVJyZH5jT1kz/spO6dq6LKXeiZYtzJa32rSKW3SlSrhbmG53GdIIvM66mdbOX4I1oggI+TKcrsI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnCkN+Yce8BGR3kCFPxf+kDTDS6sKxeK2TJvTRr44ls/+Fp42
	V7OWxg8tyU5h3T/PT/67hmCfdSloS51eXgiVtz/2Ok2x6PDQYKHH6EcVc2DMgBa9iUUEb3NNLos
	FfQ==
X-Gm-Gg: ASbGncuAgTDCaDdT1H5ZIqXYOA3DhivthuywLmkzRjPIRZQev99M2inGwOaVCEAKJ5k
	N+FmvASL6jTxWWrn8FDQvtti6N8HxCoHX/6KxRF9kYXis+zFcJ3Vdv+bJxu5O4X3soPMpjHCHG5
	fO/KWqCPHXozWNIhCCaOWF9FzMMeVBtKORx9nDWMln4QqkhNIzwSc7BOPwUPp4kBfRRlpQKgckI
	GXHpI6LTgnNxN1wechriIHgmKdpeaQJ5+OSk9vAfl+FE1o4rHFjGFiISbnqEyDAXajtYRpK0jqO
	Q6jRexLp3myiovS6QUYd0d4KiLegNWg3tra6XOLpf0qJF7ptnlNg3QZpX4itig==
X-Google-Smtp-Source: AGHT+IEROKYwH4XYqQJNIbnck1s/CMsF0eGRyC7Wr1NndD22CRh76Vq1AamAbdm7v0Di489uZDA95w==
X-Received: by 2002:a05:600c:2287:b0:439:8d84:32ff with SMTP id 5b1f17b1804b1-43ab101bf6amr1317125e9.3.1740494462367;
        Tue, 25 Feb 2025 06:41:02 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7121sm2514621f8f.61.2025.02.25.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:41:01 -0800 (PST)
Date: Tue, 25 Feb 2025 14:40:57 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: page_alloc: don't steal single pages from
 biggest buddy
Message-ID: <Z73WeTfMrtEmct_6@google.com>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-2-hannes@cmpxchg.org>
 <Z73G6A6asz_KrGTo@google.com>
 <f44b7e1a-02d1-4cda-8b0e-e748f96e92bd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44b7e1a-02d1-4cda-8b0e-e748f96e92bd@suse.cz>

On Tue, Feb 25, 2025 at 03:35:25PM +0100, Vlastimil Babka wrote:
> >> -	return NULL;
> >> +	if (alloc_flags & ALLOC_NOFRAGMENT)
> >> +		return NULL;
> > 
> > Is this a separate change? Is it a bug that we currently allow
> > stealing a from a fallback type when ALLOC_NOFRAGMENT? (I wonder if
> > the second loop was supposed to start from min_order).
> 
> It's subtle but not a new condition. Previously ALLOC_NOFRAGMENT would
> result in not taking the "goto find_smallest" path because it means
> searching >=pageblock_order only and that would always be can_steal == true
> if it found a fallback. And failure to find fallback would reach an
> unconditional return NULL here. Now we fall through the search below
> (instead of the goto), but ALLOC_NOFRAGMENT must not do it so it's now
> explicit here.

Ahhhh yes, thank you for the help. The new explicit code is much
better.

Reviewed-by: Brendan Jackman <jackmanb@google.com>

