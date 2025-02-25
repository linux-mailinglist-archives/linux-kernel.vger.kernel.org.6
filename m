Return-Path: <linux-kernel+bounces-530649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61FA4362D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9CE19C0682
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6F225A2CD;
	Tue, 25 Feb 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pkp2YFwJ"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDAA25A2C0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468560; cv=none; b=NhIhoksTIjYTH6Heu8nStEiUzAue/L5I/76Pq2bYUX5sZnSSuI7rl5rRlVBDAbvRD+1lUB/vbMksr7YDNn9neg1Go+ey6GHnF02bTsLAm2DzKEAzR0I9hcg1GyuM4W8mcP5UAaBwxoZtdZfuvECF0BM/zxncnK3kmJjHFFVieLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468560; c=relaxed/simple;
	bh=zIvaaoQGm7KtfdZ12vZ6A5bV0odA8xANuXpTVcfAHfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqWYM7xn863dvixLviVm0oEXuDTOnT8ft4PF38Ub/a0JYEv8iyjP5qbjSJx7OUJXJOZ7as/YidRYhOM7Ur/OjvGCC0We08zTVSgkqJD3fFcRkZqmtruydmxEoBOE9x8uyOI2Ecy2uLF4rV4MdgJJWSobnJh2Qloqa2YoXF2vdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pkp2YFwJ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fb6c36ba25so45956127b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740468557; x=1741073357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YmLM7oHR00hoPy5F7b3VDNoInC9XlQISOKmVVqo7gNI=;
        b=pkp2YFwJ8UdySUpGyfT32apwslskcRIbjO6kPfuP/yOZjJ93xrqIe7WHQ/m4OmhJpE
         ZGfuwhBgoiMw+w+h74fGzUkWrtrSfbfBC5YwoHIo9g/Yt3yaMJoT4HreeBq3O6QHOk3M
         ODA5W/Fox1jpqsGrCK9U0iuBEHXGgA+fzXMRflaYAHJ9VIA7E4F5nhCh87y4hdsW1UbN
         QTbe0F90jC8RNXP08kkujpAHQ5M5nsBTrlmVFZ/0bwjSBNGxXsZABTXHIbnODFSkfj5C
         1xUnJ3fQsHSBDxa9QILsCqr3K4MMOZzLuvS/Uk81yo1WKu6K1MPtYwGdKQSaDNfZXDfo
         Assg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740468557; x=1741073357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmLM7oHR00hoPy5F7b3VDNoInC9XlQISOKmVVqo7gNI=;
        b=RIEMlmMkHuJW/VFhQ3AwrQQ1EMNTL0yWO/KJ4tuNTVGTyYzs1fIbK8yb/WkUn2a2TM
         YeeUoueRUXd2dlnUs9bf9gcuoN8kBQzpvQvpNObFbd6isbBp/siIXtkhx6u7ir38U1c7
         phobdSFrwnUGOfJM+6fVI0VYFfba/IzFO0DY81VtS2u8jbaboSLRkSRS3C+1Ij7wp4VH
         Z2AIHPJ5hc600ZmpzIu6d77CDaHkTkICKJJ+uelieBTApD4asXIOVPirSDLKNLT/DYy8
         Ht1c+ajj/Eo+rRAV8n3y0tnTgtrqV7AUDevAqrMxrtDyrflOmx4wK7cbPV/Z2RKX9/h4
         qgfw==
X-Forwarded-Encrypted: i=1; AJvYcCUxLxy/JYya0cryZwpNL5oiNmQ7/n++GWhkG0d7pFD0hGYheHVjBW25v5mjzh2IOzypr4YbwimmivXOyJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2DGvbheN8jFN8WxDskDhLnMARW4o1kXj5dHXl/ufpe2nNXFrr
	iaJHiRAa8hn33K0/7GjpB291K8lk+HWoGt4gu0leDDivWyiKddMUny7xEQS1afV0BGN4xpn6tRK
	gXQPOiNg+Li1wbRvv5TZ+tU1lwv66U4trUCz2+Q==
X-Gm-Gg: ASbGnctzQdIvcqlimtpbNPpDIDuYtwgm/YAUZoCEFvQeimSk1lninTf2oKjdmWIiQQO
	umJ/EAVQ6Z/pBgdJ9klfWOElwgnAxtkRZQYo3Nk7I9IUp0aViEvam6b1Pi2975J8vVQsQxATiVq
	xCqLTjmsnHK0XtmWXJFcZscI3BqZCGC7sXfCHR4LQ=
X-Google-Smtp-Source: AGHT+IF9jdcF1gQYWcqJRP7dskBg5Xa5PlysLeHiljmo+uvVBKR+01JJ5+3ZW148YC22+F7vV3ocHacmYQVxaxc3wzI=
X-Received: by 2002:a05:690c:3687:b0:6f9:4c00:53ae with SMTP id
 00721157ae682-6fbcbc8c426mr119358127b3.8.1740468557236; Mon, 24 Feb 2025
 23:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224142604.442289573@linuxfoundation.org> <9a18b229-f8b7-4ce2-8fe0-4fabd7aa6bd2@sirena.org.uk>
 <CACMJSeuQkzvi5j975bbb6gF=+NMz0Aw-X5xLXR=8rMUjeQUoZg@mail.gmail.com> <2025022548-swiftness-supervise-ae80@gregkh>
In-Reply-To: <2025022548-swiftness-supervise-ae80@gregkh>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 25 Feb 2025 08:29:06 +0100
X-Gm-Features: AWEUYZnvrzYRtYLYeSfKngXkQZhA38Ce1zhEnS7-WwuvLBTGBLkn-dt-SFzkyZ4
Message-ID: <CACMJSesFVOp2t5C0mhB-=8m3reUtuBnMrcTShj-duEpPX1iocg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 07:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 24, 2025 at 08:57:10PM +0100, Bartosz Golaszewski wrote:
> > On Mon, 24 Feb 2025 at 20:52, Mark Brown <broonie@kernel.org> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 03:33:50PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.13.5 release.
> > > > There are 138 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > >
> > > This and 6.12 are broken on several platforms by "gpiolib: check the
> > > return value of gpio_chip::get_direction()", as reported upstream
> > > several drivers break the expectations that this commit has.
> > > 96fa9ec477ff60bed87e1441fd43e003179f3253 "gpiolib: don't bail out if
> > > get_direction() fails in gpiochip_add_data()" was merged upstream which
> > > makes this non-fatal, but it's probably as well to just not backport
> > > this to stable at all.
> >
> > Agreed, this can be dropped. It never worked before so it's not a
> > regression fix.
>
> Ok, thanks, I'll drop it from all stable queues and push out some new
> -rc2 releases.
>
> greg k-h

My bad, I should have just queued it for v6.15 without the stable tag.

Bartosz

