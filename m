Return-Path: <linux-kernel+bounces-409179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5D9C885F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6833F2830B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D061F80DF;
	Thu, 14 Nov 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hB6xe5bp"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2E1F77B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582360; cv=none; b=UEk4q8AfDm0OvWYtYxpxEvTRTBEMJYnA+3c5Z3f92+ODXlhtkJYHbQ7EqyEZTqaec2/Sv6DjOPOGJLZ0pQkndi4tkvZjEKgSAg+cXmFkCUZLylv8ZR9pIALnz1qNYvkmqv1sgwd5RUhitnunlN2J+DKcZr1j0u4HhCdx+YiILfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582360; c=relaxed/simple;
	bh=gnJfNUfIqzprkALOAlcuM/+9mzsL2BoiJFz23GrDSwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6a1wct9PNkhS1AWbkAgQ+i244nilc/ajT354nkEVkXCf0/W37/vPG5qCmxeU54LrQA7qu/kTd4l5feT7hr/Fs0vlpKWmX50s/LjKbHQN4gi4aYg0tJ7sRo+wyCL+uAN7+j/G7MzA9uRBjA8u3gyfYsuD8q2GrjJCse4YR8tQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hB6xe5bp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43193678216so4846375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731582357; x=1732187157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ep88RfVuQ8sIoolXEmcFxWVVUvTLRRVbPvP1VZdK4xk=;
        b=hB6xe5bpiTLGYzIoCMvLmNRvHyknxw271iXPLv8dx9Hf/6GzH5+A/MJsWCqQ/bQr7e
         81Ay7DW4YFWX28zBdS70NGgkzajcxt9bgMKfKF0AiM0a7JYck2UT+NVOjAKPN/iEv82d
         ipvgvqL0ajKBnraz6uStAgoQgCosqArLxFItBLbbr2JiyAMcT3JmOJ52LDgumiPjtAHb
         rS38N3E+HXfYkvCqo9BRFToTdwVyU8ZyaOOSHlLDHudMZO1QFe9PVcPLC08oaQW7M1h1
         phqlGyecmrrd6QKGIj4BXGl40jXnaWTIGkTyD37b2yqapsUQD+4RyVa6ba6jEsUCwkna
         S9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582357; x=1732187157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep88RfVuQ8sIoolXEmcFxWVVUvTLRRVbPvP1VZdK4xk=;
        b=elUHSvapctCr2M+VBls7Cd5jb0gSNfVENEsI44ke/wDIWUk3nvm7ubAgJa+TyWfCl5
         I40WrLwYZiKdSOkoLNc87FPyYquWy47OJAta1MW8NCgYO04nDZIPQ9Tr5pZ06xKXjGUT
         UxaAUh1A20W2SChRwcg7VuPr0LgaqWObHZK6oxUaanJvdQFNIL4VjvKsyfim0NJviZC1
         HaZxDyfip2J4k7B+fxHZUXHesahYa412JfoXSH/TYczh8Vfu9s4LsluPXF8c77RB310w
         XblEy6PimD/zlxa6oNGtcvl2uu3yKk/AaYcfz0WsvnRB9pq/oJRyrYGzuEHX0EQeJhgJ
         Q25g==
X-Forwarded-Encrypted: i=1; AJvYcCWWNiIznaiIakqW6iJjD26GAbvQeO7U1zrReIGEs9/SntviDoepJ2p1sxQx5D9IkDoSv1JqNX2uB9SDXmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX783EUB1pfbAblFY+KbL7XhSZTjH54YGq8Kz0oQpWHJ+cegFA
	IfnJDDndGk+oaDspZtpp0Hdc5S47/tlF/antGFuS1qgwuhzAcJ0X4GH9n0sXkBc=
X-Google-Smtp-Source: AGHT+IG/aWdXKZAnmxpptIEr7aM/+ApVTS/n1BQ6I9fFkfMmPPG9s54NeiXM21wD4TXeZTi+qnj5WQ==
X-Received: by 2002:a05:600c:4f09:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-432b7501fdemr217488655e9.14.1731582357322;
        Thu, 14 Nov 2024 03:05:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fcb4sm20076195e9.23.2024.11.14.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:05:56 -0800 (PST)
Date: Thu, 14 Nov 2024 14:05:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for
 build_bug.h
Message-ID: <870a1165-6281-4ca7-9379-83fc6cccf702@stanley.mountain>
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com>
 <a2ed9ec0-4909-44bf-be11-21a22789e1d1@stanley.mountain>
 <CADGDV=XZnkOUrc=AC=D5CeOHagiTbSGd2KGK0rN1MWoSXjidCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGDV=XZnkOUrc=AC=D5CeOHagiTbSGd2KGK0rN1MWoSXjidCw@mail.gmail.com>

On Thu, Nov 14, 2024 at 12:01:42PM +0100, Philipp Reisner wrote:
> On Thu, Nov 14, 2024 at 11:40 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Thu, Nov 14, 2024 at 11:14:02AM +0100, Philipp Reisner wrote:
> > > compiler.h defines __must_be_array() and __must_be_cstr() and both
> > > expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
> > > So far compiler.h lacks to include build_bug.h.
> > >
> > > Fix compiler.h by including build_bug.h. With that compiler.h and
> > > build_bug.h depend on each other.
> > >
> > > Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> > > ---
> >
> > Fixes: ec0bbef66f86 ("Compiler Attributes: homogenize __must_be_array")
> >
> > What actually breaks?  This commit is six years old.  It's weird that we're only
> > seeing build breakage now.  Or did you just notice this while reviewing the
> > code?
> >
> 
> I am working on a compilation unit that includes linux/string.h.
> Compiling it breaks when using strscp(). That is since commit
> commit 559048d156ff3391c4b793779a824c9193e20442
> Author: Kees Cook <kees@kernel.org>
> Date:   Mon Aug 5 14:43:44 2024 -0700
> 
> Of course, my trivial workaround is including build_bug.h in my
> source; it is just not the proper way to fix this.
> 

Ah, okay.  Thanks.  I thought it might have broken in tree code.

regards,
dan carpenter


