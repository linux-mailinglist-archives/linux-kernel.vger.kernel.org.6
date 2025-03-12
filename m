Return-Path: <linux-kernel+bounces-558314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A79A5E43F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA74A3BA2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D224DFE4;
	Wed, 12 Mar 2025 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYxknHGH"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0A1D79A0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807101; cv=none; b=jmE9tbAyL+wX5RihsTqGacsOfEX164zK22fttPXO8NmVg9o9fXYtR6740AmkGIhDGeXQJwZnFlv9ToEBzjvyNrSqcl3bD2SySyRn9geaMyn3eGbRzN3S61DYKAun0Qb2gxU/n6+VTB5lPmVocqWDqmAeQWUqrnrjQ8z98hX5M6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807101; c=relaxed/simple;
	bh=uBkLqDFPbp+mHLMtRhyUwcnbIq3MblEdnMuBe/G9pc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNgyOCzEGBqnirj1FyVEWwHtc/CafBZZ0/lTyDTwv0Dk+mFu62WLhNZZFl2/Ll3PCm7s54Cf1lRCMNgGXRGXYSXH3PALnnxKKP+jWMZyaUg4mXFCaWCW7rzb726LUQhE3pVO2qjrckXG/O7eqUxVqz3386nrSZtWlacs19rXMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYxknHGH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso1145235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741807098; x=1742411898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b/9OW3u55VJ2Sr4wf5V+6OipGDIyQS3dhq1VGx3cdE=;
        b=JYxknHGHtNk93yy1HA/IZ5QAPa2aa9dz+4joTOlbj53HIrYG3seihXrFAZRdwzJ54K
         CXKS4W+mN94yT+WjdXbR9R0BXPNU4Jxieqw+CyyM6R8EL8nixAy/ejYLBDX2ocQ6YBuj
         ze5+6ZabWHS3vJVc5MbfrN6Wpx++X/NwH7TwUROVc3FpYuPekNh/6DexPUUdRpN4PebT
         TYcTq7ROa6uioHGyj/44VvKwMGu/wAn5X7It1k3iUE4Vb2vFmSuCjZUcwrGccqdkPCxi
         HpQabL4NBTVnIlhbJ0XwePQ5JzwdZa5X6nJdXjB/Xinewizf4zdw/vovYXgLFDHlZyIZ
         qORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807098; x=1742411898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b/9OW3u55VJ2Sr4wf5V+6OipGDIyQS3dhq1VGx3cdE=;
        b=pO+w6f9n9QAdtbViLUBfgUEs1epWJVaCW2lgIu32auxhwfX87kYZGk6fjH0klxitJG
         qll9eeO1k+tHhOgoooF4Mb8pcYCjsgidHAt67B5FMXdq05Ycv8YPgn2Cpziv3OrNgrjb
         hvNAMW4MNcSxcai72HzwDwMEEKO/NUJMQ0YoS/O9mjenyXg1EkUYEF8Vo2Z7oBVEZ9Qa
         kp2QHfmePOwHaUOau+efXVAzFLyXk87bNuEae+ZvcP0vJipquLS3UM3+mrOoCjUhxCh9
         4tm2ta/HTzGl18Mb5S+45orbbwxGDNvXrIliMp+33Zm6VdM2CSj2ghVQxxNTcQ3WPuK4
         Sacw==
X-Gm-Message-State: AOJu0YwnqmAe8DtiFJpwioQDidtxNXrQL9DuuGjjZr3szjkfA8OazrTI
	d8XqT/R7dxdlCOQLV44P2fPCjgJDXbcSMdfXyY/0s31d76oCP7Ww
X-Gm-Gg: ASbGncutwmx60tMOYDYuF56DDSqmTtSIuZGUK0hMvbfuA/rHB3PXO19deKHYRc8pqyD
	0gRMvkv5dfE8CqzNoH4z+PwlkjXkdMJmnsGPjCf07eurbmpmcYkinrLxKBN1atT5tuMNdQ9gByN
	f8608lwf1udmEaOKun6ZweCTz2FREfJTKmBmnPTZ8k5lYhiFI7gsDv7AHMS23nYqkYiZgod0qPA
	gz83U8Cn7dtnz1fOyTc22TYlCUm1mwPIwKDStElEeOBiO8lmonp0GHGbpnoRbtBUgAbFUJv5VIN
	e/CM0LyFtZn/y9WPZiBnz4h05GlxZbNEQT8HupxBVOmhdND3rYmMWAsjtWXbSQzN8v5tcy2tY/r
	0MxDri5U=
X-Google-Smtp-Source: AGHT+IEM3hrBqStmjdloKaPfnjb71kVUMWw9p9YnE9KNJq+w31MIlazLGwsr1SlzdYmNH+cNKrFJwg==
X-Received: by 2002:a05:600c:1c25:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d073805dbmr52106045e9.27.1741807098111;
        Wed, 12 Mar 2025 12:18:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a7582absm29732145e9.17.2025.03.12.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:18:17 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:18:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 nnac123@linux.ibm.com, horms@kernel.org
Subject: Re: [PATCH v2 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <20250312191816.68de7194@pumpkin>
In-Reply-To: <Z86rSd88eSiJxV-M@smile.fi.intel.com>
References: <20250308093421.3724-1-david.laight.linux@gmail.com>
	<Z86rSd88eSiJxV-M@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 11:05:13 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Mar 08, 2025 at 09:34:21AM +0000, David Laight wrote:
> > Fastpath the normal case of single byte output that fits in the buffer.
> > Output byte groups (byteswapped on little-endian) without calling snprintf().
> > Remove the restriction that rowsize must be 16 or 32.
> > (All callers currently pass 16 or 32.)
> > Remove the restriction that groupsize must be 8 or less.
> > If groupsize isn't a power of 2 or doesn't divide into both len and
> >   rowsize it is set to 1 (otherwise byteswapping is hard).
> > Change the types of the rowsize and groupsize parameters to be unsigned types.
> > 
> > Fix the return value (should be zero) when both len and linebuflen are zero.
> > 
> > All the updated tests in lib/test_hexdump.c pass.
> > Code size (x86-64) approximately halved.  
> 
> ...
> 
> > -extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> > -			      int groupsize, char *linebuf, size_t linebuflen,
> > -			      bool ascii);
> > +extern size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,  
> 
> Why is extern still here?

Because I didn't spot it ...

> 
> > +				 size_t groupsize, char *linebuf,
> > +				 size_t linebuflen, bool ascii);  
> 
> int - > size_t in the returned value is incorrect change.
> This is explained in the comments to the test cases patch series.

I don't see you mentioning why.
The return value is 'the number of bytes that would be output if the buffer
were large enough' - it is never negative.
Although given 'a large enough buffer' length is trivially calculable
it would have been safer to return the actual number of bytes added
(excluding the '\0').

There were no tests for 'len == 0 && linebuflen == 0', with !ascii the
existing hex_dump_to_buffer() even manages to return -1.
(and the function than generates the 'test compare data' is also broken.)

Note that libc snprintf() has the same return type as fprintf() which can
be -1, but any code the looks at is probably broken!

So an unsigned return type it better.

	David



