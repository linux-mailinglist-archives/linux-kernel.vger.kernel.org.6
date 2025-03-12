Return-Path: <linux-kernel+bounces-558456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A87A5E62F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A244717EE11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4811F869E;
	Wed, 12 Mar 2025 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGa+p08J"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C51F6694
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813279; cv=none; b=AcbWAVM11fPTRD7sUHGYaqYFBZEaM3B3nvPK30Sff6aN/60XS6XBjanC5+DfcojSkHqAMvQrRLZvD68IAAQitBEpC6ZFvNJ5nK+nETfCTdN3UlUsVe9XEfi9xhYWkbai9YRblyDz+DvDpARbG3GaXMUTY6TlwS7JbBum1Qxo2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813279; c=relaxed/simple;
	bh=G6k9/ql5Q1cbDizr0QjgBTrqx0v2OwXXY/Rlqh1I4+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OINJFuCgViAID+2KI26v8sQaddHnSsvYYuX7dSRm089tDURVlfYWJRuSCWwPHd/PyuwAjbdbnJlFIPHribtTmuKa4Wmk4zQ+joiza3R9K7Hvd0yhAXCsDrG+u1Mpgqo3kqMi1G084V+IJdEDNVG55EGkJUx7Sp9khWKJi3GstdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGa+p08J; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso1443325e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741813276; x=1742418076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqc1poXxnyoLh8acLdyx6jnNQG9s8oh95bXH7s4VvkQ=;
        b=mGa+p08Jio0Pgfvr1ydvgLv/NTIiTwHlZUwc51/gzJpUZZGTeB7pYGvdXzIshybA7M
         EtQFm6KqJ3RCGqt3a9oUBOyHnL1AWMQ2ozDihKj8ge5l+9A1U7Zvghc2z/waCq3TBZeA
         SwpL4k6DoRP80LP9f4161SgdVBKhTNr+Wul2bFLsvZ8HSNzb3Ij6ILFoQXZjeni1ZDbr
         wBzrDzil3cBehplz8v2QGK+hGBgaJSrS/aS3BomcpLfptxZQXtjJ+Ho5+C4jFpdgLwb9
         MsxeeNIDm0LFrWdGg9jIccnXM32qsqV+sZIEpcpD0nUq9FMB8yrrJkNG4GR9X20tMj21
         TJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813276; x=1742418076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqc1poXxnyoLh8acLdyx6jnNQG9s8oh95bXH7s4VvkQ=;
        b=WXKqjBPo5J53xYmFAt5MW49jbP0c/FLoCE9FOAyJPsTHok7xs3APIOsJHjcQGrt3L0
         Y9ACNcnMTjTTU6+hVjuUYYqU7U8ZnaphWM5C6BKB1czkz6FYuSXZXqy32PAIRi/jPHC0
         5dcNqKL0YiPHAiXEJ5quav2/iGsLaGjNiZuSzkvarkzfOvin61bU64JBLdRuvvkDq9GM
         oHpB7BCYdsGyikfqpMf2CQomrXxHcICxVGzld9B1k0ZR2artcihgSP5OFQnrTnbNIcsa
         sJ9EuWfmOrG1N7Ay7moDqq8jozV5/COfLyYRZvFDsEogLe7HzFh5HWGPTC9eYpKIMoHh
         2vHw==
X-Gm-Message-State: AOJu0Yx7kO8VMiUBWaJHyu2zvM4p9IPOHQWM/+ajsZJgJmPZP+U8yaaD
	5QNBaTZVzOjO1qexWaHhmKh6US94Dv7Z4Xu/SkeY1KX+338PSaAH
X-Gm-Gg: ASbGncujztbVTmurne1XYP3dOrKvY0+aRZMzN6jt+H3jKOKWvPKWDC1W6L8O4Nj8+al
	unaf9WlV7sc6ecRobYiq0raXdwmIWpt5cYB3PxsdMkmzqbSQKhAhP1sZ8m3qMLdwW0Tc5wpkWTM
	MUunpFKvRP/7Ll5LElob/N00DG6O4i21WMEupOIEbFKvQlml14MkoQf7BW6K6ObkwCZ1wdxLjbR
	M8LRFUjwbIGkJbEZzfjPhYTap+gF/R2+mguN+5vtOMA2JvHpcTT5zvDN8NMk/n3Ac19vxpyy1kq
	ZVTa8rHck6BjAbrdZTadPKB0fuhyPhBCMm/omFzgvX7zARKoGEpxbZdOcLjBW8Ym3U5sk6Ju4mX
	U+Rs+14iB5CJBe41nvQ==
X-Google-Smtp-Source: AGHT+IFKuygVKUqjYPaYSdKNJPmQrQvxeGb1gcLRVCvTaRzOXVV/7NXqaWSlkHJhQew2IIZLrtPVNA==
X-Received: by 2002:a5d:59a7:0:b0:391:43cb:43fa with SMTP id ffacd0b85a97d-39143cb4581mr11199633f8f.51.1741813275555;
        Wed, 12 Mar 2025 14:01:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79adsm21842301f8f.7.2025.03.12.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:01:15 -0700 (PDT)
Date: Wed, 12 Mar 2025 21:01:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 nnac123@linux.ibm.com, horms@kernel.org
Subject: Re: [PATCH v2 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <20250312210112.63e3e207@pumpkin>
In-Reply-To: <Z9HhLr8zD5M1tdGw@smile.fi.intel.com>
References: <20250308093421.3724-1-david.laight.linux@gmail.com>
	<Z86rSd88eSiJxV-M@smile.fi.intel.com>
	<20250312191816.68de7194@pumpkin>
	<Z9HhLr8zD5M1tdGw@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 21:31:58 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 12, 2025 at 07:18:16PM +0000, David Laight wrote:
> > On Mon, 10 Mar 2025 11:05:13 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Sat, Mar 08, 2025 at 09:34:21AM +0000, David Laight wrote:  
> 
> ...
> 
> > > > -extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> > > > -			      int groupsize, char *linebuf, size_t linebuflen,
> > > > -			      bool ascii);
> > > > +extern size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,  
> > > > +				 size_t groupsize, char *linebuf,
> > > > +				 size_t linebuflen, bool ascii);    
> > > 
> > > int - > size_t in the returned value is incorrect change.
> > > This is explained in the comments to the test cases patch series.  
> > 
> > I don't see you mentioning why.
> > The return value is 'the number of bytes that would be output if the buffer
> > were large enough' - it is never negative.  
> 
> True...
> 
> > Although given 'a large enough buffer' length is trivially calculable
> > it would have been safer to return the actual number of bytes added
> > (excluding the '\0').  
> 
> ...but the functions keep the snprintf() semantics, which returns an int.
> This makes it more-or-less 1:1 snprintf() substitute in cases where it can
> be done in general.

And scnprintf() has been added because the return value of snprintf()
isn't the one most code wanted.

I've looked through all the code that uses the result of hex_dump_to_buffer().
The only code that needs the 'overflow' result is the test code.
Everything else will work just the same if it returns the number of characters
added to the buffer.
The code in drivers/platform/chrome/wilco_ec/debugfs.c uses the return
value without checking - hard to say whether the buffer is big enough (or whether
the code has the required locking to allow for multiple readers.

> 
> > There were no tests for 'len == 0 && linebuflen == 0', with !ascii the
> > existing hex_dump_to_buffer() even manages to return -1.
> > (and the function than generates the 'test compare data' is also broken.)  
> 
> Then you can start with fixes of those?

No one calls it like that.
I could split it into multiple patches, but they don't overlap and it just
makes more work for everyone.
> 
> > Note that libc snprintf() has the same return type as fprintf() which can
> > be -1, but any code the looks at is probably broken!
> > 
> > So an unsigned return type it better.  
> 
> Maybe, but this will deviate from the prototype and use cases.

The use cases all want a 'length' never an 'error'.
Having an unsigned return type makes it absolutely clear that -1 (or -errno)
won't be returned.
It isn't the sort of function where you want to have to 'go through hoops'
to write valid code.

	David



