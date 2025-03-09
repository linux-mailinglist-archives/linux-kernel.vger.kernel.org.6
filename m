Return-Path: <linux-kernel+bounces-552874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55658A58045
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 02:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91917188F990
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E8182BD;
	Sun,  9 Mar 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBAcePZy"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32570C2FD
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741485542; cv=none; b=UK1U0TVE1k9DM9ay2csvRqesc2BrnWcpmyVX8Li455Mlu2ZVcDKbNMob7LmKtiS7FYwvJZxsRh+DJB4QKZU0eefcs0eB5xc1c0QhC3UeRijiZOswKf49S03os4alNcnXLWK2bslhx1PVtiuDpvac9egAMZUTilHDwk6xQBTGrlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741485542; c=relaxed/simple;
	bh=jFFdOLDX5FzlEc88EzHrdvlUQPuvmbq5OFjIfKH59kU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PM73My50BtP5tUJhQsYOiBMkNWXX3tLcgHlnxEB83vtyIBHMBCmT1dpVDYDH++iczkjxBPIFepwQEPyoSbtjYP2bn6hN+tyndm52A+W7x4tdRNmAkVKbIpliognN3AsanYH9Y7bMLRIgymIB6lUPdMPqO93aQJCpynYgoqGrVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBAcePZy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac27cb35309so94723766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 17:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741485539; x=1742090339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQPV71ADDI/mWsm8CeKOioi3PQYjTezoJGiR28RCRSY=;
        b=QBAcePZyrvNGSGFfEwEyO+z9xG4NDZRLHIWNZxEGpaSwLFzxc3MLsKNZ9D9LQPJx9q
         YHO3yb2mMt+L/PiXCQ9B4UKmvZCVjmUhV3SM04/GTFb2I3KUuHWpDQ8yxLRKCNMdmIXu
         SJma5KfAeY3mgxAUDjmegvy+d1GuMva7MC0MqOmMDybbkqFfE+bMtC2RzMVGYIOHIjx7
         IUEc0hqLnGTKaqB6erhGEBAcY5duGqxXpkMz1XMWX17CszjXFjq+3ss1OhsJN3lBQpUd
         oeb9+XopZJD7NLeNQmFpJEsNIFkpFiRy0qD+GgSRZuRTKBLkY++hw0DmT677iM0jhJs5
         3Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741485539; x=1742090339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQPV71ADDI/mWsm8CeKOioi3PQYjTezoJGiR28RCRSY=;
        b=lCvp9I9grjh/PEucWg0wOv4d7C3tTeLesFA3wTKLWpUONadBRxwrvoZP6nNc8rC5Sp
         vadm0zKLFLwigxdmJFVuAY7bJC104IFkxtnQc41g36HeN3J6cDA74iFZh3X3OlK+3Y6f
         yRjgvE1UlHcMF9asS3p6fZejuAfOfGgLMsbh2eSy2iO3A2nBUaeDQCSk2O1cVBexL34F
         nwlkUgX9DrU9UwNgEZf8DMDp5Zf3U/V3BTzFGx6+0Hu1B35w0USQ0xlJlBJ52Xx1E9dX
         ikwrCiXw80gd1JlFYVTb/crNx1oJsxeBm4mqNwpXYXP8KdTFDYc3T1etTN0/3iVpsuAW
         IB0g==
X-Forwarded-Encrypted: i=1; AJvYcCUQb8Shn0sjCGqZmPgz9kgOVvoE4piOpQWu5FLyPHuKG10MtP6QvyvTROb3Ng7MEx+YJC5T9w2pY+qH/Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5VP6AHwtePKuOi5r0RoEfL6q7Ukk84IgZkZQeuVcnvYBkJmv
	xy7pLrl5bchY0tJUYl7PhPRnIcskggSvQbOoHwCrsCoAcjz4FCaoAZaFXA==
X-Gm-Gg: ASbGncv8JZIb0i/OFZKsX6sblUdUBpug1AgelRAcblo0Jgv1zsrtqC9GZ3drKZjGRUS
	lUilOZLOHnRcw3y5slErj7zijFIDCnKeefuVKFEAZvT7Keu7yMiOPdjvvH6WhK+hOFzOcISfYyZ
	JvpJVxohUCeh9UVaAvm7SeJ/hNOAODL6++qRyPfO7Nb8xbdlJ42LpVgR+uRYqZ4b//4e/6oggGw
	2imGqZIWiRH51nxSv//WOQQ4oXz09eJ3s3QID8jYAI6hMt9f4qklorSqfEu1YxBCELF68YUFycf
	4gNPLRduJP/PF+/r3kVlf4tSguHe1vTrCf7oGXwwc2lt6w4SzFQtjoLE8jk8qiluLT489ZTqEYi
	wxmT5c2v9WOvZcL0e8A==
X-Google-Smtp-Source: AGHT+IHm3r6u0Tc1JavXfFI/s+U8dwCNj8qWrGb6bQH+IsLrTWsHG6S8/8z8ZR3B4eeZ93W15hty9A==
X-Received: by 2002:a17:907:7255:b0:abf:51b7:608a with SMTP id a640c23a62f3a-ac252738131mr911910566b.5.1741485539107;
        Sat, 08 Mar 2025 17:58:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653d1esm79429666b.125.2025.03.08.17.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 17:58:58 -0800 (PST)
Date: Sun, 9 Mar 2025 01:58:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@ACULAB.COM>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and
 non-asm GENMASK()
Message-ID: <20250309015853.01412484@pumpkin>
In-Reply-To: <bdce7d99-7f02-4667-acda-9ffc62c92af2@wanadoo.fr>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
	<20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
	<20250306192331.2701a029@pumpkin>
	<bdce7d99-7f02-4667-acda-9ffc62c92af2@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 18:58:08 +0900
Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

> On 07/03/2025 at 04:23, David Laight wrote:
> > On Thu, 06 Mar 2025 20:29:52 +0900
> > Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org> wrote:
> >   
> >> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>
> >> In an upcoming change, GENMASK() and its friends will indirectly
> >> depend on sizeof() which is not available in asm.
> >>
> >> Instead of adding further complexity to __GENMASK() to make it work
> >> for both asm and non asm, just split the definition of the two
> >> variants.  
> > ...  
> >> +#else /* defined(__ASSEMBLY__) */
> >> +
> >> +#define GENMASK(h, l)		__GENMASK(h, l)
> >> +#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)  
> > 
> > What do those actually expand to now?
> > As I've said a few times both UL(0) and ULL(0) are just (0) for __ASSEMBLY__
> > so the expansions of __GENMASK() and __GENMASK_ULL() contained the
> > same numeric constants.  
> 
> Indeed, in asm, the UL(0) and ULL(0) expands to the same thing: 0.
> 
> But the two macros still expand to something different on 32 bits
> architectures:
> 
>   * __GENMASK:
> 
>       (((~(0)) << (l)) & (~(0) >> (32 - 1 - (h))))
> 
>   * __GENMASK_ULL:
> 
>       (((~(0)) << (l)) & (~(0) >> (64 - 1 - (h))))
> 
> On 64 bits architecture these are the same.

I've just fed those into godbolt (https://www.godbolt.org/z/Ter6WE9qE) as:
int fi(void)
{
    int v;
    asm("mov $(((~(0)) << (8)) & (~(0) >> (32 - 1 - (15)))),%0": "=r" (v));
    return v -(((~(0u)) << (8)) & (~(0u) >> (32 - 1 - (15))));
}

gas warns:
<source>:4: Warning: 0xffffffffff00 shortened to 0xffffff00

unsigned long long fll(void)
{
    unsigned long long v;
    asm("mov $(((~(0)) << (8)) & (~(0) >> (64 - 1 - (15)))),%0": "=r" (v));
    return v -(((~(0ull)) << (8)) & (~(0ull) >> (64 - 1 - (15))));
}

(for other architectures you'll need to change the opcode)

For x86 and x86-32 the assembler seems to be doing 64bit maths with unsigned
right shifts - so the second function (with the 64 in it) generates 0xff00.
I doubt a 32bit only assembler does 64bit maths, but the '>> 48' above
might get masked to a '>> 16' by the cpu and generate the correct result.

So __GENMASK() is likely to be broken for any assembler that supports 64bits
when generating 32bit code.
__GENMASK_ULL() works (assuming all have unsigned >>) on 64bit assemblers
(even when generating 32bit code). It may work on some 32bit assemblers.

Since most uses in the header files will be GENMASK() I doubt (hope) no
asm code actually uses the values!
The headers assemble - but that is about all that can be said.

Bags of worms :-)

	David


