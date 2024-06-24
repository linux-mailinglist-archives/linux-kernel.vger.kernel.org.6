Return-Path: <linux-kernel+bounces-227371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C191501D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5DD1C21C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311EE19B5A5;
	Mon, 24 Jun 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsYGDDQR"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD819AD4B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239880; cv=none; b=BuQttJRBfv89OoN1CS3el1t48FSfbiexcFPwJjxx94l8HZEnmZWLVTkUkN763fHJ1vKKDEMXtDELEGvUCGch9kHn/iEpvVPf83z43W//h9x2AHlpBA3mbmABjIQH+Q+KRy98a05Q4I2pVhoIkKRk0Rz3a7QgNLUpENOqkQKei90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239880; c=relaxed/simple;
	bh=mjvDJAhd1mMWnZS1wrz7et5Bq2sIcftBF0FSDjDOghw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB73tAQrz5le+BEosTWs5frZrlAz2VTO203JY9i0CV+sqC7slSXMxFE0UYQseo/N4pseiXIpdJ/EhAryskbWhOBiM3kz7TWjZCOq0PmNH1KNFGI3AQhBe/BxGEpLEQxGqiaq1T+jY78jfgG/BJrOPDPMVAxFfBTSWySXqTwTa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsYGDDQR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6fbe639a76so703577666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719239877; x=1719844677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgU+6GYzD9vCDrN/T/3QzYTvEhq8GGPegHKXVur2NPQ=;
        b=CsYGDDQRm9XXDKFV24vpE1MCPPtvceZvr7m5/a0UmNe7Fvl2FO9/xM2bUbN3ovuZC+
         JrojheQtkiR/9xFrPGBc++zdmDXI9lnk1efjOhauW2602ajhnJ0iBbEW+/wXjXw8mLZk
         IUQszecKTyHMCpR+UJbdIkjH0YU6bIYpqFrXUsbPKQ706yWKn4Fmk9iqay4oiTfZMkKV
         oQ+7kUS1f+Cm4olOdBnCvIhy0QYMI5wHGLs2U+MIf3T7FpRwHMDXJ1eo5bbmmOXxytZ/
         6T4D3w5CNCyxQrzWCEnjggFf1QYDPORLJOMc10afrRQslnrXTARiVLN5N3uo3DkFrg3M
         9oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719239877; x=1719844677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgU+6GYzD9vCDrN/T/3QzYTvEhq8GGPegHKXVur2NPQ=;
        b=oC1wRGcaRNsAgIfzDXr+kl9MHjBuvvdUrsxXnvZvlcWawtpzcZUxa6lSdxDLVAjhl8
         PzH4d6/kLM+dGNRYc+y3ZcVfIH6Jj0ofSCN3sv4+6pAC4zn9tdQz1aePaLAwLr8x6WW/
         jq5LqculfqZxTlTAbTk1h6bS4aOisGorPwyjcscSYs1bDYnawaZLSZasWIX+vetUQ1u/
         mKvNadZcwGwqpTvMO1mV6aTivISjQtfdd4xI5sy7lomJrKvevIj+KFLDltj7J4PJRzBQ
         9uGv4OQm/rBkPatSb7Gz3FZImmAli19THnnxu2xMNNcwB5gnzFdfaBnh8SJc1NlUKeKk
         PZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6G/DvPsAqwRgwBZTx2r9s7gV4Eb0kFyI4p0oeSSHpVC8LurpqZ0TBcMXpBcIVPAdUhyg44qEb5AHixtOvmNXeYrsb92xHuErwe1To
X-Gm-Message-State: AOJu0YzkKo3547KetQlYHu029PBe+Jd1XGoce+J00GFOtyxn/VWN6B/W
	N623aqbWlpJXoClXvkm16vtLwCkLpTgZG7JgDdcUNe5BsyCS5XE=
X-Google-Smtp-Source: AGHT+IHsKfWAxl92cX8iY9CjK3m0qbxitGZvj8mwXz0mLF/3d1tPGiOIcJO6fN02VL79XJyETx0zmA==
X-Received: by 2002:a17:907:208b:b0:a6f:881a:cd52 with SMTP id a640c23a62f3a-a6ffe3ccd23mr482644866b.17.1719239876938;
        Mon, 24 Jun 2024 07:37:56 -0700 (PDT)
Received: from p183 ([46.53.250.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428c24sm423079466b.17.2024.06.24.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:37:56 -0700 (PDT)
Date: Mon, 24 Jun 2024 17:37:54 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] compiler.h: simplify data_race() macro
Message-ID: <c46bf4ac-91e8-4594-966b-b46fbdc140ce@p183>
References: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183>
 <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>

On Mon, Jun 24, 2024 at 02:27:43PM +0200, Marco Elver wrote:
> On Mon, 24 Jun 2024 at 13:49, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Use auto type deduction and comma expression to decrease macro expansion
> > size.
> >
> > __unqual_scalar_typeof() is quite wordy macro by itself.
> >
> > "expr" can be arbitrary complex so not expanding it twice is good.
> > Should be faster too because type is deduced only once
> > from the initializer.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Thanks for cleaning up.  That code certainly predates the availability
> of __auto_type. Although if I recall correctly, __unqual_scalar_typeof
> became the first user of _Generic (the first C11 keyword we used in
> the kernel?), but we used some ifdef to still support ancient
> compilers initially (that definitely also didn't have __auto_type).
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Which tree is this for?

This is against mainline. Should not really matter, -next has the same code.

> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -200,10 +200,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >   */
> >  #define data_race(expr)                                                        \
> >  ({                                                                     \
> > -       __unqual_scalar_typeof(({ expr; })) __v = ({                    \
> > -               __kcsan_disable_current();                              \
> > -               expr;                                                   \
> > -       });                                                             \
> > +       __auto_type __v = (__kcsan_disable_current(), expr);            \
> >         __kcsan_enable_current();                                       \
> >         __v;                                                            \
> >  })

