Return-Path: <linux-kernel+bounces-549572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE91A55412
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C9F3B5594
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC1C269AE0;
	Thu,  6 Mar 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHJN7BDw"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A025D90B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284129; cv=none; b=nqJR60oJqRk56kHLBCPdLkiDh9sK4tsW0JAGAvV3BZ3HXvlacJMMRLE7jfIrEM9w+a4LtKQIopnO+aqFCHJxb889QBKmXm+jz2GxXGaXXJd5crO6T64CjWxFRiKZg3GnZUwXXjP9FbPlZ+eFZ5sSaf1lwAxMmkEsxmgikTRDiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284129; c=relaxed/simple;
	bh=SHGqAQtkYqdbG7i1jmLQ7ZcmVdmbyubnIXmmW4OskH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljEJTuILYwHSLHVfUTTVJ/pfkpWCb1QKoldeT8nCjfCJEpwBv0dbtRmEFdr3WY9h7FDRvDC+0wI5n2/xEv3ityCEo1VIcDSfovcVjwKaY7AzFHRHNG3L9mlqHT5Vz7UJnOIEz+0MjOkow9mPe/FdoBMcSM6ZGGzDRe411bglo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHJN7BDw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224171d6826so18104665ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741284127; x=1741888927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmNdfOlEyK8+DyFRjlO0/pfeZ0+ZYasRFFNbsHDfXFQ=;
        b=FHJN7BDwKPjHASp6vcU8D1LdHOPIflVa9xl4crJ+59/1B+KxMQ1XHT1Z1MsDWD+nls
         OWSuoCixjCKs+1sQ8A47n1T8TNCf4alk5hkXdOXFpL/DnuYr2wY3fsAJ7f8WBT5QY3Da
         FhxT5XRuUMxJ3HpQ2iybveWcLBRo6p4b1YCIdnWhp0jiReauIine6vAIBp4TibPISMPq
         O+IT06CwJuX0gcJKrU7vBU7gAOj++0Ny3Prp9vhVBlb+1r2SgsEwD49X958uhJYqjLeH
         Evtjw0OxgsVQiM1sILf+Qg1k9RpdaWTqif0p64uO1kOJNZY+lITpIfOU0EWnycQKlgU1
         5jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284127; x=1741888927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmNdfOlEyK8+DyFRjlO0/pfeZ0+ZYasRFFNbsHDfXFQ=;
        b=LBkwR/qS7MGdGzcMk8PnE4+jbCSWKd9Ut/rTM5y+XI4WwmXRstpyprsNKOZ+gv9wnV
         tmofU8klEcEkzspcHJclNkfFmTp0IwMxqZv9RWZi5aRGaUE/gwdYf9G2ESgCd4DF4gHH
         8ztRV77za66zgE301Nx5R+d5pT+RunTVxVkJ4RVLyNy5Rf7It/N5IJxC948KVGcSthrt
         lX0Y62l8aIvtWs8g2FxFKFIbcCPcshb0xcG/YFNPyWKkHuExieZ+E+aePOym7Vb0HDaC
         zzy1fRE7l+vp01D64a/zBVLMlgm7WbLtmILuEYWaF4Jp/BfILH7ttLTV8FA/4k9VD10W
         m/OA==
X-Forwarded-Encrypted: i=1; AJvYcCVL0/J0S/tORC4p0ZLtQyIOSmhZrS6ZHeBwR2Hr1qlM1nXt9NjupYgCQOqxBx6RhSxwfHWv6HHyKuu8MTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzXsRHKqEjOV8M3K2tvcqT3jimviKqqe2Z/vzgmm0O+1BuoEpY
	Sfmg/NKnYe/mwLzXnBPHVjhetJWak01+nJCExGWoQ7llBe5eQY7DuXOjZXh0
X-Gm-Gg: ASbGnctpRwt/b9KqvbXSl1m0AlFWNCy2V4LppY2tBan1HBlzK1qojMyuPy/zYrrJupY
	s/GBF2XMu1/ZQDfazuYrzd19I5AQPZGta2HTM8nEp59d3A6ab8+UxM+V6Nks1mCi45sDOVUSs9J
	LQfup2I1+osbFNezXbKPyDwmuxu3zCwmouz6WwoYPgjGwq0TGkNoiBYhVAJM1pgPgTnmMpzw95W
	HMrGgFK08rq7BqEmUgIGIOrBvtYj+OrOG9MKcTRM0BK/ompa+2JmAL83KnCEkFe7+ZzOritFFD9
	BdoGmUgyMI/NELgQki8mMcUXUAhKGXo3F1KIkWMO6DfQ
X-Google-Smtp-Source: AGHT+IESUIwptRrRXpmlC20JKth15md+bf4XVotqtlikXZvetraphShQk0i14aWb4uoCRKb39/AVeg==
X-Received: by 2002:a05:6a20:9150:b0:1f3:4563:d0e7 with SMTP id adf61e73a8af0-1f544aee8damr818418637.14.1741284127030;
        Thu, 06 Mar 2025 10:02:07 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28126dfffsm1336780a12.60.2025.03.06.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:02:06 -0800 (PST)
Date: Thu, 6 Mar 2025 13:02:04 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
	linux@rasmusvillemoes.dk, vincent.guittot@linaro.org
Subject: Re: [PATCH 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <Z8njHKwzQXdaUAjD@thinkpad>
References: <1489a042f329b1c1238756c68fd880e2966f242d.1741257214.git.viresh.kumar@linaro.org>
 <8cacf9df-fb8e-40d5-a716-cc43a266b43b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cacf9df-fb8e-40d5-a716-cc43a266b43b@gmail.com>

On Fri, Mar 07, 2025 at 12:38:41AM +0900, Akira Yokosawa wrote:
> Hello Viresh,
> 
> On Thu,  6 Mar 2025 16:06:50 +0530, Viresh Kumar wrote:
> > This fixes various kernel-doc formatting errors in cpumask.h:
> > 
> > - WARNING: Inline literal start-string without end-string.
> > - ERROR: Unexpected indentation.
> > - ERROR: Unknown target name: "gfp".
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  include/linux/cpumask.h | 65 +++++++++++++++++++++++------------------
> >  1 file changed, 37 insertions(+), 28 deletions(-)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 36a890d0dd57..73ba808c559f 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -20,7 +20,7 @@
> >   * cpumask_pr_args - printf args to output a cpumask
> >   * @maskp: cpumask to be printed
> >   *
> > - * Can be used to provide arguments for '%*pb[l]' when printing a cpumask.
> > + * Can be used to provide arguments for '\%*pb[l]' when printing a cpumask.
> 
> kernel-doc (script) can recognize the pattern of %*pb but not %*pb[l].
> "%*bp [l]" should work here.
> (without quotes and a white space in front of "[").

So why not fixing kernel-doc instead?
 
> No need to escape "%".
> 
> >   */
> >  #define cpumask_pr_args(maskp)		nr_cpu_ids, cpumask_bits(maskp)
> >  
> > @@ -166,7 +166,7 @@ static __always_inline unsigned int cpumask_first_zero(const struct cpumask *src
> >  }
> >  
> >  /**
> > - * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
> > + * cpumask_first_and - return the first cpu from \*srcp1 & \*srcp2
> 
> kernel-doc (script) understands the pattern of *@srcp1.
> No need to escape "*".

Yes, please don't do it. The comments first and foremost should be a
human-readable text. If we add C code, it should stay a C code.

> But it does not (yet) parse the pattern of "*@n+1".  You need to say
> "*@n +1", with a space in front of "+1", for the time being.
> 
> [...]
> > @@ -335,6 +335,9 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
> >   * @mask2: the second cpumask pointer
> >   *
> >   * This saves a temporary CPU mask in many places.  It is equivalent to:
> > + *
> > + * .. code-block:: c
> > + *
> >   *	struct cpumask tmp;
> >   *	cpumask_and(&tmp, &mask1, &mask2);
> >   *	for_each_cpu(cpu, &tmp)
> 
> Do you really want those code-blocks to look fancy?
> 
> In kernel-doc comments, I'd normally use plain literal blocks instead.
> 
> Something like:
> 
>  * This saves a temporary CPU mask in many places.  It is equivalent to::
>  *
>  *	struct cpumask tmp;
>  *	cpumask_and(&tmp, &mask1, &mask2);
>  *	for_each_cpu(cpu, &tmp)
> 
> should work.  Note the "::" and the empty line below it.
> 
> [...]
> > @@ -941,7 +950,7 @@ bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
> >  /**
> >   * alloc_cpumask_var - allocate a struct cpumask
> >   * @mask: pointer to cpumask_var_t where the cpumask is returned
> > - * @flags: GFP_ flags
> > + * @flags: GFP\_ flags
> 
> You can say:
> 
>     * @flags: %GFP_ flags
> 
> instead.
> 
> >   *
> >   * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
> >   * a nop returning a constant 1 (in <linux/cpumask.h>).
> 
> [...]
> 
> Side note:
> 
> I think 1/2 would be better to be CC'ed linux-doc as well.
> Please do so in respin. 

I agree. I'm all for covering cpumasks documentation with kernel-doc,
but it should stay readable after that.

Thanks,
Yury

