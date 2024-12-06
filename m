Return-Path: <linux-kernel+bounces-434463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DB9E6737
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3001E1684E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F101D90BD;
	Fri,  6 Dec 2024 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UPQ24zRM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4D193417
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465698; cv=none; b=UVjS2VdHHIauHEqWDVdPcHpYh1uvQYdYsUb/XA9EYwa2+cecBsWtrt0Bn0y99o3Y/FCw/FO/lG2ElHne90rtT31Bd/C6Jxnj5SwntbT7cL/q6jUvT0HMjL8RT1RMs1bPJHbGgi95MevG/Jf2yxJCoyRexTz49UlANmninXbcP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465698; c=relaxed/simple;
	bh=z6hEp8csz74EZNAx+MsdQ8oAglzBDLPIjblM5QboFag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7Xs4stZSyEwi3XwGMY6YoZskRvMR/GNAYfjrDYxz35IVc14krHGv1chzCyAP/Ce5XjECMVP0M3gBPT417YqVu7JRrQhj3RSfNch687dcf38xsNFDJ058L0F4Aivu/dhax+QRinP88FrfZ5R1tqhWYuNODVXxeC3F5098cRpMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UPQ24zRM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e44654ae3so267586566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 22:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733465694; x=1734070494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lkINBrTDhyE0tcSEzrQhWY00f3rEWU+OMRPtBhc6Jxo=;
        b=UPQ24zRMfaNpDh8nlmyIZ7Mqdwh9tsKRgq6iDA5Y8Pl2MS2rtllq2ttVNRK4tF+KAx
         hZ3utFLACLJ5xHOy78qFgoKkjJkw6eLWkk6m2tvl1cjdUMCcpEu4mL/K91DwLvRUHiIP
         iNhyTiKeYTctIJO9lqJ2DTXeXe/UVC1eNGl+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733465694; x=1734070494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkINBrTDhyE0tcSEzrQhWY00f3rEWU+OMRPtBhc6Jxo=;
        b=kxeK6fCDmeSsSxC7SkpIUhDF/7yFduFJqmsrLaBF5RMVYvAL1F/Pvml0hOwhWkyqD7
         +FykIrXWAWkvctAGSdCC4NLdbNDsI8QjKhI6zK/ryWLw1r7ocC3GllHkdL0zYE3nxUnU
         xyQL1WPXkU97tGU1TZh7oWlHdyWXl/ioaIqkH/cp4LwmsJ6Y7dNzgsO6S/0Qeu+YipLd
         pgLoePdOBj+VedceSrfIcP4kHIT/x320xoXibcjy0IXNcpQjg+Sqf0x87WM13ycoAWg0
         0vZIh10UTcXTSHFYvzDkwDW8qy/PaHgY5UZTlLyJt4o1GRgV30aoqoRCqK+XRMa7+mUd
         YfHw==
X-Forwarded-Encrypted: i=1; AJvYcCVUk+F9IL94cuAlkUZKwGAyn+AXkknbKAcT+zh9mKxEvotzpc3J9PnR4fbuZPtK0oemSc4AKwfbitKqe1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/SehL4NrWvBAAENbNFUn0krD85bXUCvjLKxYqRxB6qoG+XCi
	WrvXWpjLxMJSe3p8Y7MmtSqrPX4eUGWy2KYX0z/murX2APe3c+DYONtwitcraqClL0CSBTRaZMS
	DzqIxTw==
X-Gm-Gg: ASbGncuS80kqMW/gPDKCJ0T9DsEwjE0bDS9bQhXoFciNZ8HaqFXIF7c247YzghvRKnx
	kKSlnKDE28pcCuQq3z5cn2xUg7fBerC+qJSSjWN7wt2qSYdTywbBVFYwqvKRYOCEsQvCLy8O8Ia
	+0pDitleybG4D4ldJKdfDf1shPJwuHm4POprIVxQ/uqjEAATtaSLw+iWy4rYjlwEL+fpg85xbhf
	5uXna3/ySn7AeKXdohuwLv7jzfExCJKQCqflgESOSsAkk+SS1XGT32SqKACEGv94PjB1iCbRCGr
	apHnFSCoNiDn7yMuZ9S3eaAL
X-Google-Smtp-Source: AGHT+IHCeM4uLgEozs8V3+xlmvNJgSNnG3k4KYUEK1PJ9Qr07UtbJUCKAqMbWRcWWdiqwRMIhFZUyw==
X-Received: by 2002:a17:907:2893:b0:aa6:36ef:1050 with SMTP id a640c23a62f3a-aa63a252272mr125356466b.56.1733465694389;
        Thu, 05 Dec 2024 22:14:54 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e97254sm189148166b.69.2024.12.05.22.14.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 22:14:52 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa5366d3b47so267548266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 22:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+qxYkorFxGQiS1gjTCp+4+3wPrc/nmBqGEdV5fTFyrElcTOyoUsccD/E9JtOSuikpWYXxOmkICECZlUg=@vger.kernel.org
X-Received: by 2002:a17:906:1db1:b0:aa6:3de7:f258 with SMTP id
 a640c23a62f3a-aa63de7f394mr66959966b.37.1733465692215; Thu, 05 Dec 2024
 22:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
In-Reply-To: <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Dec 2024 22:14:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
Message-ID: <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Martin Uecker <muecker@gwdg.de>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 18:26, David Laight <David.Laight@aculab.com> wrote:
>
> From: Vincent Mailhol
> > ACK. Would adding a suggested--by Linus tag solve your concern?

I'm genberally the one person who doesn't need any more credit ;)

> I actually suspect the first patches to change __is_constexpr() to
> use _Generic were from myself.

Yes. And David was also I think the one who suggested something else
than "!!" originally too.

I may have liked "!!" for being very idiomatic and traditional C, but
there were those pesky compilers that warn about "integer in bool
context" or whatever the annoying warning was when then doing the
"multiply by zero" to turn a constant expression into a constant zero
expression.

So that

  #define is_const(x) __is_const_zero(0 * (x))

causes issues when 'x' is not an integer expression (think
"is_const(NULL)" or "is_const(1 == 2)".

Side note: I think "(x) == 0" will make sparse unhappy when 'x' is a
pointer, because it results that horrid "use integer zero as NULL
without a cast" thing when the plain zero gets implicitly cast to a
pointer. Which is a really nasty and broken C pattern and should never
have been silent.

I think David suggested using ((x)?0:0) at some point. Silly
nonsensical and complex expression, but maybe that finally gets rid of
all the warnings:

     #define is_const(x) __is_const_zero((x)?0:0)

might work regardless of the type of 'x'.

Or does that trigger some odd case too?

            Linus

