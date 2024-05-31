Return-Path: <linux-kernel+bounces-197302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BF88D6905
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8329228783A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FAF7E103;
	Fri, 31 May 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dblSYSjV"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CB7C097
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180491; cv=none; b=Vq/pjxI5b/lBm7zunzg19RRcdblTj4alJRuItfeRZBPfmpdKKsc5aFbnFkCTxPQA21RBJk6xTNpWjy1fnCJZnJW/tL0Ca71zNXpadSn+b4tShynkwguEspQl1mr+BcSJdow+NnKAfIJ3EUSPEBo7GOga80ypEuEzH3ow9HwPtX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180491; c=relaxed/simple;
	bh=aSGiikkT6x1TNct0kZEX/uNcjl8Rojs8bZbsZLGio/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACSS23yAhFqU07t+0wqU4bzbvZBUj6oHnrYTkjD9iJ8+NA7yOgtY6nqZ+RxEP2u2+9DnPIwaHef/Pu4qeFZLHOTGJtPbDaGAQNiCE4+2LV31wITNbcBopYjy2JTluoPd5uyGzCjea7CuLhi8ihIECOp4DOv6MJhbvbw01J1ukBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dblSYSjV; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b82d57963so1959905e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717180487; x=1717785287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ajAKtHvE471CPuPKfvRU6jqIKN2/5fnuw4v2uvpYPQ=;
        b=dblSYSjVYGak6B/56e9TVZVB7duaZFqkw1B6kot9jo8ZKcxdvkhkJhmfp3VRV/6kbQ
         Z6zbq0mw7ks/tILe+31GrVlZq8c2+oneedJPjdduKreHWx9OqrYTF6RTKWHspt2jqadk
         dBwO/HY8pVFCICXY/ysGsMPBzBR8jqAltyXRuWzKf8AY+KBohino+ePzwqhpKRW6TIz6
         v8CHdCpoXl4rkleZ/lc+LCOv4SXyog3TkhGVQO54tan2RvKHCSggf/IwCUKE7EHXEwTg
         9jO3tspHLb345HT0sAG9Ukk+QO2NF/UV7uVfoc9sYLSTKFfEh8St9ITMkyC51JFmZquC
         qk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717180487; x=1717785287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ajAKtHvE471CPuPKfvRU6jqIKN2/5fnuw4v2uvpYPQ=;
        b=qA9kh+sQZ22d2B8Ifpdba6DeScEuhGVgICACWp2YzamG9QrncNhnztG5KIYWOKeVvK
         5ADobCWxZPoaU3Hc5XWeqMnUvLop9iMb4bXCVLhvvol2lpsKbHVWasQA/ykD6uaZrX7n
         mDYtbMutYG65+2ram1jvjq+9YAM4RHkPcnes+DXoIDk10HgxyH+dnYjLgByBm/aTUcAf
         vtyFEN0pR0LW0jBeJfuBP9GqWwljGEsLw5xAOr3/e/pGhmsxHC5Dco6JdXIsy/qywUlk
         O8xgpxGVP2wo7fTXIgWsGVvBU5vT61dFbnyXtiWuYObSt2s5Xl3WdNAE0tQkdWdxRjvi
         Gzug==
X-Forwarded-Encrypted: i=1; AJvYcCUVthvRwMDbEZqXKOjYSs0Fe9XOwFybO4qg1RD8W5E8VqoD7OEelmHcPlwGEk20nfEwILyjGTuLBT4g2knNsiC7f2V5OWfCwcbkDVr1
X-Gm-Message-State: AOJu0YzHiiBi4uqhuS84MmwtT8STGH+vmaJhFvdx0UoDzpKynj7tQJYS
	mSKNieh/qb8BF0LoCmQNMJUh70LZ2Y0W8yIa8mblHg17TbGkFsfKGQo0xgZhzeU=
X-Google-Smtp-Source: AGHT+IGD6e7kaRCA8BDiu5RMfdDUAogfscN87V+yK9tKmvj4jP1cN89O4Gg//R+tBckHRlIDnAVMcQ==
X-Received: by 2002:a19:c514:0:b0:51e:1bed:13a8 with SMTP id 2adb3069b0e04-52b896aa750mr1679529e87.29.1717180487212;
        Fri, 31 May 2024 11:34:47 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31be4f4csm1300160a12.48.2024.05.31.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 11:34:46 -0700 (PDT)
Date: Fri, 31 May 2024 21:34:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kees Cook <kees@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Message-ID: <b335c8f8-f59f-40b1-8388-013c815fb9e6@moroto.mountain>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <202405310923.78257B2B3@keescook>
 <c19aa2df-adaa-463e-b3a4-843f04538a2b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19aa2df-adaa-463e-b3a4-843f04538a2b@quicinc.com>

On Fri, May 31, 2024 at 11:28:58AM -0700, Jeff Johnson wrote:
> On 5/31/2024 9:28 AM, Kees Cook wrote:
> > On Thu, May 30, 2024 at 09:23:36AM -0700, Jeff Johnson wrote:
> >> On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
> >>>
> >>>
> >>> On 29.05.24 \u0433. 21:09 \u0447., Jeff Johnson wrote:
> >>>> As discussed in [1] add a prototype for __fortify_panic() to fix the
> >>>> 'make W=1 C=1' warning:
> >>>>
> >>>> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
> >>>
> >>> Actually doesn't it make sense to have this defined under ../string.h ? 
> >>> Actually given that we don't have any string fortification under the 
> >>> boot/  why have the fortify _* functions at all ?
> >>
> >> I'll let Kees answer these questions since I just took guidance from him :)
> > 
> > Ah-ha, I see what's happening. When not built with
> > CONFIG_FORTIFY_SOURCE, fortify-string.h isn't included. But since misc.c
> > has the function definition, we get a warning that the function
> > declaration was never seen. This is likely the better solution:
> > 
> > 
> > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> > index b70e4a21c15f..3f21a5e218f8 100644
> > --- a/arch/x86/boot/compressed/misc.c
> > +++ b/arch/x86/boot/compressed/misc.c
> > @@ -532,7 +532,9 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
> >  	return output + entry_offset;
> >  }
> >  
> > +#ifdef CONFIG_FORTIFY_SOURCE
> >  void __fortify_panic(const u8 reason, size_t avail, size_t size)
> >  {
> >  	error("detected buffer overflow");
> >  }
> > +#endif
> > 
> > 
> > Jeff, can you test this? (I still haven't been able to reproduce the
> > warning.)
> 
> Adding Dan since this comes during:
>   CHECK   arch/x86/boot/compressed/misc.c
> 
> What version of smatch are you using? I'm using v0.5.0-8639-gff1cc4d453ff

The "warning: symbol '__fortify_panic' was not declared. Should it be
static?" warning is from Sparse, not Smatch.  So probably that's why you
can't reproduce it.

regards,
dan carpenter


