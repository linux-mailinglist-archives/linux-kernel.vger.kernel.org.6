Return-Path: <linux-kernel+bounces-562596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1BA62DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E378E3B4C39
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6450201249;
	Sat, 15 Mar 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOSyzTaj"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7351FC0F3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047112; cv=none; b=OMXkHPdBqisu1fZeP32KEyTGzHGdJ+QN0EiG1zkgrOCIrrSCHi82fwRYN31jE+8+lc3GlSzvDwVwXOc16qp4DcOwY+gbDZJOzvftc6AxeT5+RRxiBFYOkhcoWI4mIzxFgTWbkcbIi2mlyAuuxhooB4LRjzr86rVqTQZ9oPVaw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047112; c=relaxed/simple;
	bh=ocRcn3Zw0TIaolaGhTOTEjA5wym+J/rbJLyfhvjHCnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4XIKIMDGQT70+ou9t5Wp8xL5Lg3DC3HIC0tQgcx0cpzUs84/ltuDxxz2ZRrsN+SwhBCWLET0Fck53dvojusE6xtJFM0TlFpFyMnqqOPqQNb4rqpVf3/nSd0zze1q8WhI/qdJy9YmiLtgibFlVH0UE8+CKbx8VjMf1blCbQadQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOSyzTaj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913958ebf2so2382253f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742047108; x=1742651908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20QYNz9CIBTDkmtHww1HpIkVGQ2C1iEZWdVS69B27H4=;
        b=IOSyzTajB1fDfOOroc+6GVud5kHb6q7bBKvq5GdWiDv4kIqcZSGyr+ziheYN1zN3jo
         C+OQDiaTwzFtYn6sQMJHkU4QyPa9qJtWeDzCO6N4c8vVtIsPrlez+1F8NOzB9JirwCjm
         oCIRvvAg3T9wnThnU03NKVuIYRkSWZOhm1wdfe9tpliyO/rdIgbCnKR7Pk0b1sj+pP+O
         rsy0dPbBTFxKh0eDr0XqvSdEDFOSy1wtmmQ25FANXDFwW3ovfgxz7gRHcfTSbr2XpjlR
         hJXRhz7u/R4BvDUpqJWVivFNEoNHLpKUfE7oQ1QcCsLs4fmzDLPgKI2LyJcjnvjGASyR
         yGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742047108; x=1742651908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20QYNz9CIBTDkmtHww1HpIkVGQ2C1iEZWdVS69B27H4=;
        b=PoxKRzjSGmhSy2Luez7Pzdksq+HK3Ez56yoZa2sOsonctDfzVXpZYjT/Ky1IFe4P98
         m/sXGoVXHob+HjbnhAzsgr0dEmU8DFbQY6DQH1aV+9EAKqDIq177CqD4ogtpYnAoAnIF
         bTD488BNJepPxDfNvvzpcE74W3/dRrBHo9EaiRvKAIBWbamWu4qZP8t61YpvWqAP4SuT
         am+CRdclWCePjzz4AO6mo1yhDOTrAJkbUBYznLj2BhLxWcyPOiliDb9EifSIXNY3ACzO
         vdpohgwTRlUbR3CgVgtcDcFE+Cc7LxtrpYCqMjaqhFiKgfVswhTR4d2JsBUC0hcOkyPn
         WDVA==
X-Gm-Message-State: AOJu0YxoR3gRZF99u4wMCSf8Efac2/vcHB2IreANta/8aLEsZPQHtmXj
	oBzvZ1RGRjmdlGQ1xZlCGNiM9QAXi61JbIpWuc8o5g+7lp8oauOY
X-Gm-Gg: ASbGnct7emNWpuVxYell0FmCRhW2m7nTwWfaVjPcyDNu0W/0ZaKEJlcqDlba/yf5CL+
	323Y1qcHfmRYY+5teGVdAHwGre50TJsuIg3tUt0LbxQPrGut96xi/INZqdG7upc9YQC6nAV9kP3
	/Wn2+EX6K2WMks22favKbn6P0Nvw8BceXPJU2loXpWHe+/ERDb/639fNmBa7sUAe2Edf2XlY1iN
	PnUEyKZ5M3NiS8QDqsJXJtOTtbFboEfQCkOMb7qMD63ai7xg4xb3jmbSWeg3E1O32gT1nfTySRj
	LLo5gxLZx5Bmj3qqMOsL/FtNYnOVFxnAjmnBGKK57c8VXSqQFQ+E+ldEPB8R592CmbqFXadwACI
	gdOdDas/HnJxS6IUbUg==
X-Google-Smtp-Source: AGHT+IFV6jpuKmA56rBF+l6Pu5X2mde6BKeajm5WGbLEPpjB4JJuUETYGSQzBIPzVJrFJoQTE6AF1Q==
X-Received: by 2002:a5d:47a1:0:b0:391:2a9a:478c with SMTP id ffacd0b85a97d-3971d70c23bmr8869421f8f.23.1742047108493;
        Sat, 15 Mar 2025 06:58:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a8bsm9314335f8f.66.2025.03.15.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 06:58:28 -0700 (PDT)
Date: Sat, 15 Mar 2025 13:58:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] random: get_random_u64_below()
Message-ID: <20250315135826.44a506e6@pumpkin>
In-Reply-To: <20250315135234.65423e07@pumpkin>
References: <20250313163810.60564-1-kent.overstreet@linux.dev>
	<20250315135234.65423e07@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Mar 2025 13:52:34 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Thu, 13 Mar 2025 12:38:10 -0400
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > bcachefs needs this, for sampling devices to read from based on squared
> > device latencies.
> > 
> > this uses the same algorithm as get_random_u32_below: since the multiply
> > uses the top and bottom halves separately, it works out fairly well.  
> 
> Adding two separate copies of much the same code is silly.
> Given what the code is doing, does it ever make any sense to inline it.
> 
> Inlining the original get_random_u32_below(ceil) that did
> 	(random_u32() * ((1ull << 32) / ceil) >> 32

Brain fade, it is just (random_u32() * (u64)ceil) >> 32

> (for constant ceil) made sense.
> While good enough for most purposes it was replaced by the much more
> expensive function that guarantees that all the output values are
> equally likely - rather than just evenly distributed.
> 
> 	David
> 
> > 
> > Cc: "Theodore Ts'o" <tytso@mit.edu> (maintainer:RANDOM NUMBER DRIVER)
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com> (maintainer:RANDOM NUMBER DRIVER)
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  drivers/char/random.c  | 22 ++++++++++++++++++++++
> >  include/linux/random.h | 22 ++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 2581186fa61b..84808300044c 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -588,6 +588,28 @@ u32 __get_random_u32_below(u32 ceil)
> >  }
> >  EXPORT_SYMBOL(__get_random_u32_below);
> >  
> > +u64 __get_random_u64_below(u64 ceil)
> > +{
> > +	if (unlikely(!ceil))
> > +		return get_random_u64();
> > +	if (ceil <= U32_MAX)
> > +		return __get_random_u32_below(ceil);
> > +
> > +	u64 rand = get_random_u64();
> > +	u64 mult = ceil * rand;
> > +
> > +	if (unlikely(mult < ceil)) {
> > +		u64 bound = -ceil % ceil;
> > +		while (unlikely(mult < bound)) {
> > +			rand = get_random_u64();
> > +			mult = ceil * rand;
> > +		}
> > +	}
> > +
> > +	return mul_u64_u64_shr(ceil, rand, 64);
> > +}
> > +EXPORT_SYMBOL(__get_random_u64_below);
> > +
> >  #ifdef CONFIG_SMP
> >  /*
> >   * This function is called when the CPU is coming up, with entry
> > diff --git a/include/linux/random.h b/include/linux/random.h
> > index 333cecfca93f..b025bf3d8f27 100644
> > --- a/include/linux/random.h
> > +++ b/include/linux/random.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/bug.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> > +#include <linux/math64.h>
> >  
> >  #include <uapi/linux/random.h>
> >  
> > @@ -90,6 +91,27 @@ static inline u32 get_random_u32_below(u32 ceil)
> >  	}
> >  }
> >  
> > +u64 __get_random_u64_below(u64 ceil);
> > +
> > +static inline u64 get_random_u64_below(u32 ceil)
> > +{
> > +	if (!__builtin_constant_p(ceil))
> > +		return __get_random_u64_below(ceil);
> > +
> > +	BUILD_BUG_ON_MSG(!ceil, "get_random_u64_below() must take ceil > 0");
> > +	if (ceil <= 1)
> > +		return 0;
> > +	if (ceil <= U32_MAX)
> > +		return get_random_u32_below(ceil);
> > +
> > +	for (;;) {
> > +		u64 rand = get_random_u64();
> > +		u64 mult = ceil * rand;
> > +		if (likely(mult >= -ceil % ceil))
> > +			return mul_u64_u64_shr(ceil, rand, 64);
> > +	}
> > +}
> > +
> >  /*
> >   * Returns a random integer in the interval (floor, U32_MAX], with uniform
> >   * distribution, suitable for all uses. Fastest when floor is a constant, but  
> 


