Return-Path: <linux-kernel+bounces-435501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DDD9E78AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3911882D83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E718198A06;
	Fri,  6 Dec 2024 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IaFOPHH7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FBB202C50
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512542; cv=none; b=PyuF+HW4yJMx0U8CPgOazPVezNo1aQE6Cn5lwdR6+HldN6JbH0SfnGCJbWQ3tjVDVbS2qqUmkBeKkPUn3oJ5ANw0IQ/3jZzgSuCnxV4NvC8foSkGrVrVX6zAM/LXm/6MzhKdjyhnMBQkGsRjaz41BRIPEwJZQCH8IXp0Sk7xkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512542; c=relaxed/simple;
	bh=i8VSKf3d9h7aPyCMroFIPs2BgVVC/quFiHlWg+y9lfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiJERHKNBhh5Op+Um+odP2KR6p1rzRhciDVjU/vO6BxRdm3jkBqA+YOvQPlJEu3ow56ZIc4Q7J4DPd+nfii7TB8gBRhDGvmpo6toLRIREeGBz5t9w1DyeEPx0/ui5FQ6Y6trMin021jO1RVACugd643AtLc9TVh4QsDvWwlFRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IaFOPHH7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e224bbaccso2810153e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733512538; x=1734117338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB1D/kV+LS+wbR3JFN0rKIWFlL1hHHNzi40qmGJ0Urw=;
        b=IaFOPHH7Q1qhR31U6jVDe9A8NG8N9GzRTGp1ew27wxOc8vvQbBlRcfInq7il1wu7zW
         jx0d6o83NkzaXTlvBusBom6UOMqVs51dsgbjsiz3YJLcUZEflmHn8xJ2DujiDe8QXSFf
         vZCGq1YA9Folqjlt7tDd1SxQ+ld2p6+6i+aa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512538; x=1734117338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB1D/kV+LS+wbR3JFN0rKIWFlL1hHHNzi40qmGJ0Urw=;
        b=mtFYcbmcFszHFb3ih8hJqI6zVtaHXKoaxmqGveU1RTAdhOB+vsrrSLbE5fXllcwyRx
         zNQoE0JjEVQeRu+j/Gg2LDsShWJE7bILBJAbnisxOfL/ygb/tijrms3O8QpRVLUIp6dV
         k6W6RXG/J/2c6axYxdNJJF1v1cT69PkT1mBk6VkKmbXt8DoJ88vXzg9G6MHrz6uOoW1g
         xq4ii8GXyTjBvlhi/NgT0upYK1hAz60A4RAHRmzfLFHm7eyT18rGJ6278ZgvZUwH5gxI
         tcRARtCEn2xOqGZdQy5Agxi2P9fXnF5ffDHjS5k77LxKeEaWEG0wpGDiJx9QEogCziXW
         dzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX30AtZsK2WuZqXe6wFL+HkW75WEAhnYHBd6ssexkGTxVHzo/KvkkpncyfSWu0VgvD90KqPZW4tVMZTJRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAKMPFGsGhfFD+N0r0qlF9mQ0V4BXf7bBLX0APnnjIHIB4eq2Y
	Agmyiy+NyZvYQQA83zwY8RwgK6nmt7Rz4LBOMqEkgUx8zaVmUmbL3zkD2R803jAbR5aq/4vjtUr
	qIt4yUQ==
X-Gm-Gg: ASbGncv6bbbDZCvEW7PvvO5Tqk5+rY4N8t31IdNW/c168BwNLPUWtaGF+znkTOAykAw
	VzjJf4xa6gukkTAjxBdF7vCvYukNl0k4LIpAS0EST9kRkJpABAhnHBc2gN4Lre6aC5MQyCHjTtL
	NR42XfZfG6bJJMeQVgIYLB0lWFwk2EfgxRQ/u0p0LoHk4pPOoDApTsrmTPDJNe3WJ6Gs8WiUSRy
	/OJplKDtq2YU4kRVlZ8XPkeo8JAhq5m24DHBwsxXzOvq5haPph5qL7Pchmmk/IY4HlRTHe2ijKG
	toLqnsXRbC0ZOkdFmOJpMXDr
X-Google-Smtp-Source: AGHT+IH+9nn0FvZP3OGmK8MCPMdYHV5aHbRWqNA2wDqrGTILkaOPClOYBYdNBL/Lvsj+8P3o+VthBQ==
X-Received: by 2002:a05:6512:138f:b0:53d:e88b:ebc with SMTP id 2adb3069b0e04-53e2c2b8e84mr2370266e87.24.1733512538348;
        Fri, 06 Dec 2024 11:15:38 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608e0csm2505113a12.41.2024.12.06.11.15.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:15:37 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa5500f7a75so321532666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:15:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYjIxqp6L8fqJ47D57i7u+D+vfE4evqDMQpReGSA3gdmOHo1TLSfhVDeJt/AuXW+sK89bVMkB8Z1k4v7Y=@vger.kernel.org
X-Received: by 2002:a17:906:4c2:b0:aa5:308c:3489 with SMTP id
 a640c23a62f3a-aa63a2519b0mr271057466b.58.1733512537212; Fri, 06 Dec 2024
 11:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com> <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
In-Reply-To: <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 11:15:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
Message-ID: <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <vincent.mailhol@gmail.com>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"uecker@tugraz.at" <uecker@tugraz.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 11:07, David Laight <David.Laight@aculab.com> wrote:
>
> I'm missing the compiler version and options to generate the error.

Just -Wall with most recent gcc versions seems to do it. At least I
can repro it with gcc-14.2.1 and something silly like this:

  $ cat t.c
  int fn(int a) { return (a<<2)?1:2; }
  $ gcc -Wall -S t.c
  t.c: In function =E2=80=98fn=E2=80=99:
  t.c:1:26: warning: =E2=80=98<<=E2=80=99 in boolean context, did you mean =
=E2=80=98<=E2=80=99?
[-Wint-in-bool-context]

> Does a '+ 0' help?  "(var << 2) + 0 ? 0 : 0"

Yeah, that actually works.

And "+0" is nice in that it should work in any context.

> #define const_NULL(x) _Generic(0 ? (x) : (char *)0, char *: 1, void *: 0)
> #define const_true(x) const_NULL((x) ? NULL : (void *)1L))
> #define const_expr(x) const_NULL((x) ? NULL : NULL))
> I send this morning.
> Needs 's/char/struct kjkjkjkjui/' applied.

Oh Christ. You really are taking this whole ugly to another level.

           Linus

