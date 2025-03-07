Return-Path: <linux-kernel+bounces-551504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B4A56D4E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB96C1894C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EBD23770D;
	Fri,  7 Mar 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBQWxhjw"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F926236A62
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364148; cv=none; b=rFwFZW+ZC9HSb/JsQ/cHCNKK4No7jwJddLT5WOE0sonB+hvjdFnS1D4SCYOon3asZiv8v42rl62ps8KCqvSV8lFQIZ6VSZNvddUki6TGoWijvb0Qo9/BvPnQkDYoK4je6x3ZW+rgsAEuyv63vSP6u9tEgmv2MsQn7BXgP/cUH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364148; c=relaxed/simple;
	bh=VW4EuL71/gBCf6iuA9+lb4LsKxAd/LGv788MHPfqzOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5eHiM74TQj24H29heX6kHCHX2nckmIJ7ZDrHtugKfrL5TbiVmtbu9fXE5ryovi5QTnAS2FPl2+IojM04cC/aPAcKly1JOo16uEXWyr65ukqB/dhSxTDFckRMgy4FRCTvdQPou/F/hBpNnn8yBVb4FR7lttVxLJtAP2tv8poyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBQWxhjw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so2847573a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364145; x=1741968945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1OkKYoiqnt3BpcbkLNlUYzWieB0Pq3sk2Ozz9eZKZw=;
        b=fBQWxhjwNghhb6I0XTmcFJVXCfy5ea07A39qg/g+1A6rXKNgoQj72u7JUCBuQOg0Lq
         2LATO1R+YMcGsE4gSi2bPBblWGNUzI+Dic32GK1dFk9hNVqzj2AvpKBbqvGxoGlR7yeX
         YoidG7/IuwySdnNYL7GvmZzeC3W2U3/W0LVrAIp7YnCNY64trAGtPA4Ku5CtRMwyzpG9
         m4vA+Zbwq/t1tzIoR1W+P2yEF3gvOgT/qLod+xSS025IeGXpQeR2WGbUXcFqP+wWXtK3
         Gg4tfquViqFP/yzXGxutvGflEi3XWjgV4xvNXQoIT3VUs+T4cAWnw8vsAkI51K6/FHRt
         k7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364145; x=1741968945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1OkKYoiqnt3BpcbkLNlUYzWieB0Pq3sk2Ozz9eZKZw=;
        b=eKTQerbSX5oNG2vphjA8AZktyI5e7SCdq0QZ9BqEi2EbhAtV/yHxCu2qDHJQJ/7VWS
         TxDiKB4W5KOIrM18Ve1ukpFtdEPzAdogfac4hNfgkEPp68HZN1OzU2kM7PuCK6ttaw+C
         3E6KAhGXPavMtJO12EMHvxHOYJW0v6UnjWl9MK96PWVjXacOwDqmm8luvBXYGEcAkSGQ
         4Aayy3zknCJkZLTpLkTwCRCA4/hPIs9IwMh4S/5jLxXnvTSfPsZcRIMl2YA6W4F58bnt
         eCj4K+wy+Qjd0ZKk3nni0pBTFWEPVvr0KI01OhfjUMBhSGN/bVhMO4VPazomj1G3tINM
         x7/g==
X-Forwarded-Encrypted: i=1; AJvYcCWKClUhQfvfBehgKKvcq2Cjri4JF0qZG2f1+uXoLNw/nImjrV7Hg5OVKlQulqL4WnPEuwe+yMR+G+c3AMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhLZkaJrcPtwA066OVtSsPwXW7SmKPtjFhNjpcDaaqGofqrno
	3MiRWzVHPJ7smGeoZWwXpJ8rGpQqFHiYOsu4jg85FCllkhxjA1s=
X-Gm-Gg: ASbGncvZaf+Jqw0iaZGS4uo4Eo8++wQZMNpg1ATzCpumWCKPcUHF/eroLyE9Oc680F8
	jnj8//4XybEnPEEJwYbn99R1Iumhjityx59Wu4e48lGoP/GVp0hOF5fWRoRVN78OTIiPxtYWrx5
	Wb1gKbASzdLSlJK1DLV7ZlMKu3RjPldDBEBSFcuBTy08ecmj+izLnS2a7JbjgpRSP7vgiaoMMcE
	sNrRXy+yPL30/drE9ik8bRIwRyur9iiGh87dtGPa/RjVoeuh+m2+u4HJGe8Q1sCZMBY9vJGbI5o
	73/qs/xpo54EmIxZxlS7zjbtHwj7nhEgtBU=
X-Google-Smtp-Source: AGHT+IHuT2cmiIP/31elXbI1GYUTMsK5ng7nGtK9P7jdU5jgS5Fn3jDq1c8v9MIWRiLxy3Qy1M7dnw==
X-Received: by 2002:a17:906:d046:b0:ac2:6913:7cc6 with SMTP id a640c23a62f3a-ac269138a59mr86334866b.31.1741364144922;
        Fri, 07 Mar 2025 08:15:44 -0800 (PST)
Received: from p183 ([178.172.147.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac24a843884sm202278166b.102.2025.03.07.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:15:44 -0800 (PST)
Date: Fri, 7 Mar 2025 19:15:42 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/asm: delete dummy variables in movdir64b()
Message-ID: <d9d6b9db-dcdb-4024-a14a-bdcbe6afe00a@p183>
References: <20250307061203.3281-1-adobriyan@gmail.com>
 <20250307061203.3281-3-adobriyan@gmail.com>
 <Z8rdRljzdRdh9hu6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8rdRljzdRdh9hu6@gmail.com>

On Fri, Mar 07, 2025 at 12:49:26PM +0100, Ingo Molnar wrote:
> 
> * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Cast to pointer-to-array instead.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >  arch/x86/include/asm/special_insns.h | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> > index d349aa0f0a83..b24c6c945c38 100644
> > --- a/arch/x86/include/asm/special_insns.h
> > +++ b/arch/x86/include/asm/special_insns.h
> > @@ -215,13 +215,10 @@ static __always_inline void serialize(void)
> >  /* The dst parameter must be 64-bytes aligned */
> >  static inline void movdir64b(void *dst, const void *src)
> >  {
> > -	const struct { char _[64]; } *__src = src;
> > -	struct { char _[64]; } *__dst = dst;
> > -
> >  	/*
> >  	 * MOVDIR64B %(rdx), rax.
> >  	 *
> > -	 * Both __src and __dst must be memory constraints in order to tell the
> > +	 * Both src and dst must be memory constraints in order to tell the
> >  	 * compiler that no other memory accesses should be reordered around
> >  	 * this one.
> >  	 *
> > @@ -230,8 +227,8 @@ static inline void movdir64b(void *dst, const void *src)
> >  	 * I.e., not the pointers but what they point to, thus the deref'ing '*'.
> >  	 */
> >  	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > -		     : "+m" (*__dst)
> > -		     :  "m" (*__src), "a" (__dst), "d" (__src));
> > +		     : "+m" (*(char(*)[64])dst)
> > +		     :  "m" (*(const char(*)[64])src), "a" (dst), "d" (src));
> 
> In what world is putting type casts inside asm() statements an 
> improvement to the code?

In the same world where creating distracting variable whose only purpose
is to make a cast is considered not good.

Notice the cast is shorter, there is not "struct", so it is positive in
both vertical and horizontal directions.

