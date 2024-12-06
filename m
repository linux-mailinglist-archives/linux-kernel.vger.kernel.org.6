Return-Path: <linux-kernel+bounces-435480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63B9E7860
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B3F18831BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832201D61A5;
	Fri,  6 Dec 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OhTH5CKk"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF223194A63
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511173; cv=none; b=uGDdfkqZk+iFgiRwhLApT6V7t+RDynVxpxxe5FkBZn7jTqK9LtSnd/AMjjBrt0Um82owAKjs2Z4wS8fz2QkJySWGTA/Y7Gf9IZ28NO6IgKUHiXddpou01OtDoOJgT9Apn+eBfhJPinf98sPgiVmmH+XhoWgSxiCIMbeCDLx3d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511173; c=relaxed/simple;
	bh=uWEIYj04jJcQVEnaMjzH0epqUyK8EmgQnn9LnSnYd+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSbik9pcFfB6wqifWJC5PwMH/ytL0Dk4oyMIBSm3I3ZFJmRGeqi4gDg6huHJ57japFykNm1x1Cy0JKRj1vEbAOyZEc/sJ/tAyabtZdQI9RS0lbHdGWeA07qgt5CsErKOkgSbi91ULur+DnzxNSTDjOOPthVg63oChLahtq0IBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OhTH5CKk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso298575066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733511170; x=1734115970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGtbOaTCTsAvyUDr9a4PNqlmY0QlpNlNkPLsZ0+zYxc=;
        b=OhTH5CKkWXXqmugX4HPIcBEIQ3Z2x9sHpA9AXoEv1slR0lNN+NDgBaBCpTdU2jU74m
         3Yr/U+ga6cpP5OfklowR+ofWrEQSC62xNCWtCg5oXW5ky9AgJQiLQlj0gZP+E+0tKGaU
         s2aWcRIIcZVkQtTae/f/j2o54IcLkOAgJazcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511170; x=1734115970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGtbOaTCTsAvyUDr9a4PNqlmY0QlpNlNkPLsZ0+zYxc=;
        b=k/OGLSyBqrdbvxb53eXCwJeUf8m1B8gEU8ufAXLvted01dHbicOQ0akMrbQn+NdWM+
         EHGGXHBo/KnnVruHfxB15zUxmh855Aj8Gt6F/4W86zk/iOTFxwmPYZmpUq/lO6afPulJ
         sF22CHuSWYMeQp+fJGu0g78kkmKcS8Sgcy0pXXUeJY19XCjXuz/2cU6DM1s6x1ThuCHF
         5AbiXkTmJMM3VDGaAmyo6nj4J0rj4DK1HDaGdDcGWLTVHX2NGcWqjiXocLJoyg/YewZA
         sMlcanV8fqiQ0eObYCBLpeWodQm62ff1fu1+/Cp65IGv1JQ3UdzdkpN3JKxdoAWaxa8j
         6irg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8NtazGXXMfRoB9ZhKoQOJvQ81V7kayexWMN23PKZUBNZNH0tPeY+QgaLH4BQjd4ugFtjpDLxf7t9jQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMvk04VI3vUnwiztBJn5dl6aP7r1Vot9dBluxGzUyez+7AFsi
	vaPDi20Ts7M6BIITinOLMsVdKZzk85CsRRoUX7BowWVEB2jVv5jrvMHVW0woa/cG/GsTK4YDobm
	8upmFrw==
X-Gm-Gg: ASbGncvdcvJ44Xee18Z0v8KlyhK9O1LvudZkWZILBWsh6pOobfiMnqbNuoHqmcMczzL
	Nxl0WPhg3zK0nLCgBWJHnsOTXpiMhAzkFIj3F3gT1BKv7GjV3bDO2rkrRAzN0ovOj4JKHT21SAd
	Py/+IvCVIRhrT4AKrLnHmL6PysJMlhsjghJrAdk2PFWd7C6ZNwAMpPnz8IN1Xp8368mAinXc220
	FhGxC4YG/pKSGBcTRhFk0NePfmZbeyH4lOhH9+2MbKkWkyGsCLAqZMyFev2bHwwaxDW8n+6hOtW
	xEuzM3DhB90VRBpBaeE4xMKr
X-Google-Smtp-Source: AGHT+IGxFE0SvVstHjQ3MIASNTtLPUsnHMK5PfLZ5JfoCSS29SpottAm2BPQJyXUrniWeQhneS6QbA==
X-Received: by 2002:a17:907:7707:b0:aa6:2a5c:fee0 with SMTP id a640c23a62f3a-aa63a207312mr234774266b.39.1733511170001;
        Fri, 06 Dec 2024 10:52:50 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5f3sm283391666b.120.2024.12.06.10.52.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 10:52:49 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa629402b53so281130066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:52:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaji/Q3UaQBuQnfn8d44eSvZ4APeWfQGL/bjndB0uxV5LVzkBCAKCe6PCTgNEWAmLf+RHSrSDnda5HOeE=@vger.kernel.org
X-Received: by 2002:a17:906:1ba2:b0:aa5:451c:ce1e with SMTP id
 a640c23a62f3a-aa63a0aa48amr290776466b.32.1733511169269; Fri, 06 Dec 2024
 10:52:49 -0800 (PST)
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
In-Reply-To: <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 10:52:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
Message-ID: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, uecker@tugraz.at
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 10:31, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > causes issues when 'x' is not an integer expression (think
> > "is_const(NULL)" or "is_const(1 == 2)".
>
> But 1 == 2 already has an integer type as proven by:

Yeah, I was confused about exactly what triggers that odd
'-Wint-in-bool-context'.

It's not about some actual bool type, it's literally a random
collection of integer operations used with logical ops.

So it's things like "!(var<<2)" that generate that warning, because
some compiler person at some point went "maybe that left shift should
have been just a comparison instead '<'".

But it turns out that "(var <<2)?0:0" _also_ triggers that warning.

End result: I have *no* idea how to shut that crazy warning up for
this case, if we want to have some generic macro that says "is this
constant". Because it damn well is perfectly sane to ask "is (a << 3)
a constant expression".

How very annoying.

This may be a case of "we just need to disable that incorrect compiler
warning". Or does anybody see a workaround?

             Linus

              Linus

