Return-Path: <linux-kernel+bounces-547758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D28A50D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9E7171F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B982561AC;
	Wed,  5 Mar 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrxRev3s"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA27255223
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209229; cv=none; b=DeTxRIrrokTgYj8ZWsNr0PdburiPDg/wJ7G3Pg/43Y/sG72yLS1I6741QbTVUc22O7WrU+h0Oh4wzVM1uQQ+IIARt77MxE9y5ZtCUNuESLBB9Qw9Y7WFvy8QEJtSBrnuYfHqsaK0b5cRH0v/y2ZEmLpQ2XY5GJHVnYbUA5v4YiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209229; c=relaxed/simple;
	bh=Bk1PHrizI9T3q1Sb7gFQU5nIriCehLNjici2Uhuip2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZ63bzJnd4FxCWJpcIj3HPwmG5bxM4zRCOOTai4UJvd607ouz/O0hFGWGUdUfUmvma9u02StxNTQ+EvOB03Gk6pmSucGdxcPgr4KcKCfwfzdJKbQR5OHxl9dcUzYaSxr/4uhArEVMsj5IPv5eoplCjz0xKRPgHV3nI9ilDNxMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrxRev3s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bd03ed604so15549695e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741209226; x=1741814026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBRrY/yBfxvuLgMlXhSkD7HMQ9Yj7k44KHWuqIjXDEE=;
        b=ZrxRev3suyauDon67PwqQO3DWGc0UxzPzQZDfYZ0HaNGH2hE9LuY15U7Omw1666Szi
         xixdHafAk5/IZykEVDz5RCTuTTbNCfHGcbnAgwLm1tq0UF6Qals/AQgVrpFc+LoqEt1s
         DB/ksCeCAATFMiyT0E/fmsokpNemEUQDEW+oGs/XCbYv45FF6Lwp2oxRSi3Ffg42jcQ4
         i0gXwE1AiWZtzTK81BRuaO+Hy693Gg8VfATpqQWZvLIgG6315xvD6Y0V0LkylcFC9uy7
         rroUD6xtAqMBCtWk/ptHwAUFHFYNC6G58visdjl0yBS2HdTUcK/MpjAaFfHAnUwHyl98
         23qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741209226; x=1741814026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBRrY/yBfxvuLgMlXhSkD7HMQ9Yj7k44KHWuqIjXDEE=;
        b=rJadQxbiIw8JbxCZatVkrkuceZfRdUdK+PrxKBGEuoxSMMGuc8ADEZIwpUxhffSJNd
         /O6iDC3EWf9kHe3a2L82iAqgnWnQWNeq9WpmnrM3g8+U7Eggey8Zz3jv2ktC1cfpmWV2
         gmwuYy5JUwF6yEqdvJS8XbVKEwM6Sk4x1P4TRkx1BxM5BiU7telrvojjUgSTGVGulkoL
         WUwFfqcYX9yfAPPDzf3jmyiwGTIk+gBwKmPEaiT9T/cILAugO7ucYG96kqOpE9K0bEn1
         fxKLXeI1xwQEAg2YqIKY82wWvkQJv6d9OW6+tEmYOlf1FNPH3yhTpfAB2LhMhUeIdYP2
         rrwg==
X-Forwarded-Encrypted: i=1; AJvYcCWOpUuyn5bE7WAFY+cdeuf8GakViG1SzZZxCPCnr7tK1AyO/byfJ8oQS3omkpvuwygEMLCknQRCXrIhKb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmw3zyfkXpH9aylNjBlzsJ/DxMA8Mw77/LIPRYmQ3C4p49vXOt
	ZuKhvBUDpNqXiKhMVEEbSfglQd2lvK/o5HHqONf4joUUmXPeg2JH
X-Gm-Gg: ASbGnctKkS85EFR8NNf3KwLPdWMfTeDokX8cJGELo5zjTkJk3UxbFxap+pLz+PmYahq
	1AHBu6DPHrh5iz0DfbhmIJ+30NdwlvkoM1r1MwK4Y81vH3lVQPwLVjfPHj283KkUdLiCYhtmUZ8
	NGNXUaH+nPREWowQFGqCGJjUe7RzU2tqq083dPTjHbXAkHuPJQ8UNbWdDvcSogz9JzQYrQqAZtY
	Cl9kbJQMLnDQePV4CkutL4OSGYSBekltqpjuOlwlRKAg3Qymdhzv6+IiFzwNofM11ZA05uCm5gk
	Sa5SEMj52pQjbeKLY+YcqbDorFu+zx7gXlrX46ID5CYEuK0Bwyb+hEIlUlLjsYx4GPS/9rhXFQF
	9PmJou0E=
X-Google-Smtp-Source: AGHT+IHVQz7StEb3E7vwY+wN9yjtbQ30ziK4JQuHk7WcBp+0Xfw+qMA37Ery803rfsIYjDm2WSDeiQ==
X-Received: by 2002:a05:600c:198f:b0:43a:b0b5:b0 with SMTP id 5b1f17b1804b1-43bd293ef18mr37803035e9.4.1741209226004;
        Wed, 05 Mar 2025 13:13:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a9fsm22432775f8f.36.2025.03.05.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:13:45 -0800 (PST)
Date: Wed, 5 Mar 2025 21:13:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov
 <yury.norov@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@aculab.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 4/8] bits: introduce fixed-type BIT
Message-ID: <20250305211344.0c7c3782@pumpkin>
In-Reply-To: <Z8hyNXVZxLzhEzNy@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
	<20250305-fixed-type-genmasks-v4-4-1873dcdf6723@wanadoo.fr>
	<Z8hgqOB5Ym-GGykS@smile.fi.intel.com>
	<d7f3150d-0167-44be-90b2-17f8a050687c@wanadoo.fr>
	<Z8hyNXVZxLzhEzNy@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 17:48:05 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 05, 2025 at 11:48:10PM +0900, Vincent Mailhol wrote:
> > On 05/03/2025 at 23:33, Andy Shevchenko wrote:  
> > > On Wed, Mar 05, 2025 at 10:00:16PM +0900, Vincent Mailhol via B4 Relay wrote:  
> 
> ...
> 
> > >> +#define BIT_U8(b) (BIT_INPUT_CHECK(u8, b) + (unsigned int)BIT(b))
> > >> +#define BIT_U16(b) (BIT_INPUT_CHECK(u16, b) + (unsigned int)BIT(b))

Why even pretend you are checking against a type - just use 8 or 16.

> > > 
> > > Why not u8 and u16? This inconsistency needs to be well justified.

What is the type of BIT(b) ?
it really ought to be unsigned int (so always 32bit), but I bet it
is unsigned long (possibly historically because someone was worried
int might be 16 bits!)

> > 
> > Because of the C integer promotion rules, if casted to u8 or u16, the
> > expression will immediately become a signed integer as soon as it is get
> > used. For example, if casted to u8
> > 
> >   BIT_U8(0) + BIT_U8(1)
> > 
> > would be a signed integer. And that may surprise people.

They always get 'surprised' by that.
I found some 'dayjob' code that was doing (byte_var << 1) >> 1 in order
to get the high bit discarded.
Been like that for best part of 30 years...
I wasn't scared to fix it :-)

> Yes, but wouldn't be better to put it more explicitly like
> 
> #define BIT_U8(b)	(BIT_INPUT_CHECK(u8, b) + (u8)BIT(b) + 0 + UL(0)) // + ULL(0) ?

I don't think you should force it to 'unsigned long'.
On 64bit a comparison against a 32bit 'signed int' will sign-extend the
value before making it unsigned.
While that shouldn't matter here, someone might copy it.
You just want to ensure that all the values are 'unsigned int', trying
to return u8 or u16 isn't worth the effort.

When I was doing min_unsigned() I did ((x) + 0u + 0ul + 0ull) to ensure
that values would always be zero extended.
But I was doing the same to both sides of the expression - and the compiler
optimises away all the 'known 0' extension to 64bits.

> Also, BIT_Uxx() gives different type at the end, shouldn't they all be promoted
> to unsigned long long at the end? Probably it won't work in real assembly.
> Can you add test cases which are written in assembly? (Yes, I understand that it will
> be architecture dependent, but still.)

There is no point doing multiple versions for asm files.
The reason UL(x) and ULL(x) exist is because the assembler just has integers.
Both expand to (x).
There might not even be a distinction between signed and unsigned.
I'm not sure you can assume that a shift right won't replicate the sign bit.
Since the expression can only be valid for constants, something simple
like ((2 << (hi)) - (1 << (lo)) really is the best you are going to get
for GENMASK().

So just define a completely different version for asm any nuke the UL() etc
for readability.

	David

