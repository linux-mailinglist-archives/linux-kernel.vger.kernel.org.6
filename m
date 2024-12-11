Return-Path: <linux-kernel+bounces-441344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D399ECD17
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBC0166AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20B23FD14;
	Wed, 11 Dec 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1TVn5oB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBC22912A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923307; cv=none; b=O+/5ZQcj3WGXK2bQx3oRoX/SlrINKZDWP/QNKA0F23wvT1W01LEUm1PugCQjxDuwf1sPGYabdk+TChKEQsJMRSvFGMBOW9aDVhdyu32KJ+TGLiqBvJdR8ExFULKtz2ZiCp0JOrtDtZRWLY5S8jGYanP4Tb0tHJDC293WPh+5wO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923307; c=relaxed/simple;
	bh=RPEBjQP0OcwhX3nUIQE9WuQDD87s2+IGYDhtmJcS9js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbiK3drJpr+KnCP4ocog9e7Fsvj/oU76iGI4UAcB2pQdEpRaYLo90ThujxoxCqj6ylFZsgPIiby9X+5irCVlNBstMuBzcJMtST6RMYIEmMmrLXrXIqiHWYLIfF/bmrWT0St13EdO9LTWxNRX5KyUYDbPuTMnWHtAzj9ZYNkXoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1TVn5oB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361c705434so4984105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733923304; x=1734528104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9eKaWxEhhuVWvBsU53E8KZ6fOQTi8MzTOfznqa4xjH0=;
        b=q1TVn5oBp1lb1YK/sKlZ2+h2xr8WrHLpSdvnm0FmkUDJFYAwZuhk3gmakBaKOQDy5E
         vo+uEWPdNJacjhF07wY3+WCwhsZAQ6u5queozgf5Z3OUiUDK1La1AcAoYe8FAXt/QJRI
         YMGyCoUpTgRKUlwRCRhzGnJKvOdO+MGO5rSFq67xllvm8ABXMEeqHxo9BP6s5ZLQfwZ2
         Q+70wCJrYD9q555dkmebY7N/Eq4ZkHBNsC17R3ey2zAb/vjgF1N1HaGi0v8vDyVsrioH
         zPO5Ot0D4701bbv08jEJsMHHHFwmNt+JgfTgp7ezXdyvGhl5vLnMbBi8f//HgJju00Xl
         AlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923304; x=1734528104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eKaWxEhhuVWvBsU53E8KZ6fOQTi8MzTOfznqa4xjH0=;
        b=tEUtnXMsAuJSW+JWIPHLm4O6ENsCxnYjE1dVQi2Yoa8r1YPhGh4n/hdNwnlT9cig1D
         s+a6yT1Jp8uYZXBx+hc1BOELik39vK5SBHhRv+evBkSUbEPgBED7Xg58RgiUFFiiJdRw
         oZCX/AA2ChDlY/G9XRhU3SfjtaboDEsQJMIJHHprSHZ1ppMSySlHZguJ6eGoCflTqLtq
         pIvGgbfAFP83dGxBLKwYzegs3EwUEEyiRS9Ns05yJF8dcq9uDHW24YwUmFRjE0hLSxtP
         h2eslAL68pEax09CwRRFUbLENWokm9xdlqkF1gZWF7xx2fHg2L6DHbfkWoGCaji+Oldv
         Lz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVumK+z2kTZnecWUolzGizuJknRpUAunxvq40BotMBsFe4HqbDd1v4/al/HQTXdDHzOnYt6y3ZAs7d0Gtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwRBbnn8jGzdGgaEvfAMlQnJsTrbkQAUceMAzqEjzMdeg64O8
	lOSgz7GWk22Oe7T3PUIdRgq3UJ3QrIRP4JK3MxbxhCQtC0SGIG6Ui2NVVuYsqds=
X-Gm-Gg: ASbGncsVx7uBsnYQnFK8tJMfc1+WRu7EAqBn12nsXqRZSy77wiVvE7Au9l7kCK5oVan
	oyNvc4B5AU/TNQY78mfJyYcczG1C1x9UEHvLff7Xuq2QQ60dsxsGFc6b34vKUsi11P8hA2AziHG
	3F4q14V3BsWy86st5RQkuPxXO28zKo/78XpsnBPI5rOGEmys8lwsYpO6yci2mSTw5DymRGve49o
	pMuQfBw7msVkV/FpuCwFC4Q2xz5Du1bHf9BJpOp/4m/P0JLdQDQfeeFi0k=
X-Google-Smtp-Source: AGHT+IFfC29j6czTll9rOLSqjnFeJosj8hGWZx1V8FqolEsDfwkRoQYubFcSENWm0L8tfipl6WqLzA==
X-Received: by 2002:a5d:6486:0:b0:386:4a60:6650 with SMTP id ffacd0b85a97d-3864cec5bd0mr2542328f8f.42.1733923303738;
        Wed, 11 Dec 2024 05:21:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514d97sm1260997f8f.64.2024.12.11.05.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:21:43 -0800 (PST)
Date: Wed, 11 Dec 2024 16:21:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Laight <David.Laight@aculab.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"toke@kernel.org" <toke@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"kernel@jfarr.cc" <kernel@jfarr.cc>,
	"kees@kernel.org" <kees@kernel.org>
Subject: Re: arm64: include/linux/compiler_types.h:542:38: error: call to
 '__compiletime_assert_1050' declared with attribute error: clamp() low limit
 min greater than high limit max_avail
Message-ID: <49a14c12-a452-4877-aedf-94bac6ed2b7b@stanley.mountain>
References: <CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9MRLfAbM3f6ke0g@mail.gmail.com>
 <8dde5a62-4ce6-4954-86c9-54d961aed6df@stanley.mountain>
 <CA+G9fYv5gW1gByakU1yyQ__BoAKWkCcg=vGGyNep7+5p9_2uJA@mail.gmail.com>
 <bd95d7249ff94e31beb11b3f71a64e87@AcuMS.aculab.com>
 <CAMRc=Mf8CmKs-_FddnLFU7aoOAPU6Xv8MqyZo8x9Uv-Eu+hs_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf8CmKs-_FddnLFU7aoOAPU6Xv8MqyZo8x9Uv-Eu+hs_g@mail.gmail.com>

On Wed, Dec 11, 2024 at 01:46:11PM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 6, 2024 at 3:20 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Naresh Kamboju
> > > Sent: 05 December 2024 18:42
> > >
> > > On Thu, 5 Dec 2024 at 20:46, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > >
> > > > Add David to the CC list.
> > >
> > > Anders bisected this reported issue and found the first bad commit as,
> > >
> > > # first bad commit:
> > >   [ef32b92ac605ba1b7692827330b9c60259f0af49]
> > >   minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
> >
> > That 'just' changed the test to use __builtin_constant_p() and
> > thus gets checked after the optimiser has run.
> >
> > I can paraphrase the code as:
> > unsigned int fn(unsigned int x)
> > {
> >         return clamp(10, 5, x == 0 ? 0 : x - 1);
> > }
> > which is never actually called with x <= 5.
> > The compiler converts it to:
> >         return x < 0 ? clamp(10, 5, 0) : clamp(10, 5, x);
> > (Probably because it can see that clamp(10, 5, 0) is constant.)
> > And then the compile-time sanity check in clamp() fires.
> >
> > The order of the arguments to clamp is just wrong!
> >
> >         David
> >
> 
> The build is still failing with today's next, should the offending
> commit be reverted?
> 

It's a simple fix.  I've sent a patch.

regards,
dan carpenter


