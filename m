Return-Path: <linux-kernel+bounces-534784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A113EA46B20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FF16E260
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D2243952;
	Wed, 26 Feb 2025 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UOP/bGY/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113D23F421
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598389; cv=none; b=d22Kwo6maTxGxzjGkCsLHuJZFrugggfpqc9Q6Rq2lnADOGa/Kz52Dm20sHali8g9VYGskhjzmMCmeQjy+8YNGLFfJ9gfaEWn7XUdigSIxoV/3M++e4eDc/hfp0ELwbuKCeHr8qLYssrzqXpOXbuXshMbLaeHlIUMthT2WJcn2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598389; c=relaxed/simple;
	bh=3usIangzu6r4PaFTKvtnl+Iw5bp8L+06/4fSfDibBko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaD40wj1LiAqhvQDF+xqmXAIXUyUzGIgJ48mWwDiu88+Mm8GqDZq0y14M7jIIscSSn/qeX0hTdl1GPaKZZ+EwawH/ixNDFmIRL/KMKzgW8u8C/ubl0ad4aOjn/oMqUfRWJvU5Uzk/IZjgSLETYZZPJWkomxtgLHk49pkDmy4XGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UOP/bGY/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaedd529ba1so9628666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740598386; x=1741203186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eF9pvpFw1/YLJE+EPUaheMire2o0sgR/Rpuz1tvLIh4=;
        b=UOP/bGY/KIAuF34KWOBvshzYdThvJudeTGB1uZeMm4tJ5QnF9mwTcC2TEHFZZJ/suT
         iBaWGynibEANB6dVI0E2SFt0YNDqdLcZGDf2irgqFbNqmrbaVow2ZsRyR+W9PYm4pfDR
         syTC0YZKvzSzcPk8rngrmYFvYITvFAwnlkNU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598386; x=1741203186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eF9pvpFw1/YLJE+EPUaheMire2o0sgR/Rpuz1tvLIh4=;
        b=dFkICBSW/ft0PGEH5V98Fcj3R6K0CvaqL5Igt+UzsoHS5/ru+za8Irt5SAG9keB1v1
         xiRYQ1De/Or7VttDtwwegPDTsTApikRiDq27T3+0o2Daiu6goMTDKbQ36/LiljkBEclv
         PMwsD99CMe+TPLaT/Ys6vrvZ15hkOVSsNfqxO3iCBmP/Mw4C05jSrSngCQ+1mmw84K0l
         MoN3gSy7xUw3XEfUkBSVEkXlMiKXmUyqQXPAk7lyEtGQ0277fr3+h4mZQq5km6lyOSvf
         vA9xyTkzRX/Hfy6iBH4K2cg4DetCKPICDSFRVcmwqSBuAHLQrjiZzbIIeNoTgg2h9CyA
         M4eg==
X-Forwarded-Encrypted: i=1; AJvYcCXYUfbtyTVTm5nq/jdkc9OAolu6foETCoDEaahMQHfeSajsliiNoc4/uzTw9/oKPOs2GOpMrVA7FEkV9SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjR7oL9z6FW4BGQjgdXy+rCRM9VwwjGK/XDfeYrIKLUVnaeOR
	6eq8z8oMllWaXmaewfISWTM7PudLT9qdhQodfZphSThzYN0sUFeFzRxDDcm/v1YFzF9vXDCE/wc
	5s7gmOg==
X-Gm-Gg: ASbGncvFKHG8WnWdil9Qw/AS1bGN43U8mXF+M41FfO0wGKy3bR/i+lSGH5k0LY9ZHLr
	ie0eA2PD+7Pdfpdny/NVZVH0bZ6tHh0UElq4Mm9SlRyYg9qej6Fz1l/yrOtAOal5cCjpFmGEUH8
	51UWYUL+W0gEjk7P8JeJZrgN2+60lZOmtCMDxblAAQXD8zZJhzz3ftg2BBJli5pTfaaTGNiFEJ/
	/WtzAPHzaRmJLbiIrxBejRsMf7fTK2LvJyUDjskakC2gXeZZCGTP6SPE6R8+2OAT23sSXL6EsoK
	myTHuvWvc22pxrxTWkZRodxsfzNDeM6pz0s9RpFu2CRsgw+hz9h2m83TIVz+p4c2z4vjNEwGBJk
	t
X-Google-Smtp-Source: AGHT+IFkkGtJzuGcTYDuh1U0UrJQPSLMzXoxM2xHogoVE3l+ewXVQaAZnxdwQZaA2V9GRxB1iVXRPQ==
X-Received: by 2002:a05:6402:210d:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5e4457abbc9mr22549727a12.11.1740598385683;
        Wed, 26 Feb 2025 11:33:05 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45a8b8c4esm3259360a12.26.2025.02.26.11.33.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:33:04 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e04f2b1685so96180a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:33:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2fJIm5YO3MNUMmOx8A5Q15j8z4Zl6KaBvirC741ZqlQRyf7IJTT2rLsYQZtmdMH2M2A8Nzkkq41vf1Nk=@vger.kernel.org
X-Received: by 2002:a05:6402:2690:b0:5de:a6a8:5ec6 with SMTP id
 4fb4d7f45d1cf-5e4455c2f52mr21228207a12.10.1740598383403; Wed, 26 Feb 2025
 11:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <Z7bO1jT2onZFZwgH@infradead.org> <CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>
 <Z7hulnJ4fwslRILy@pollux> <20250223180330.GC15078@pendragon.ideasonboard.com>
 <CAHk-=wie_Winz7CtRCM62S2b1pWKN2Jt2wdGHgFBv=aBU8qwqg@mail.gmail.com> <20250226160554.GA33931@nvidia.com>
In-Reply-To: <20250226160554.GA33931@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 11:32:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjg1PJ81E23DB1QbvPBQ04wCf7mJjRAXG2U1N3BkNTY6A@mail.gmail.com>
X-Gm-Features: AQ5f1JrQKblYd_mlL56qfeL7HjizeGfzBVaee_mjm-AjiG60v7JHCqrs21U3slM
Message-ID: <CAHk-=wjg1PJ81E23DB1QbvPBQ04wCf7mJjRAXG2U1N3BkNTY6A@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Danilo Krummrich <dakr@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 08:06, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>  2) Does Linus accept a PR from the maintainer? This is what I think
>     Laurent is driving at. AFAIK Linus accepting a PR at least
>     requires it passes your build test and boots your test machine(s).

I don't think I can give any black-and-white answers.

I refuse pulls relatively seldom, but there are no hard-and-fast rules
for when it happens.

The most common situation is that something doesn't build for me, and
that's because my build testing is actually fairly limited.

My build testing is trying to be wide-ranging in the sense that yes, I
do an allmodconfig build on x86-64 (which is likely to be the config
that compiles the *most* code). And I do a more limited - but real -
"local config" build too fairly regularly.

But at the same time, my build testing is *very* limited in the
configuration sense, so if something fails to build for me, I think
it's a pretty big failure.

Now, 99% of the time, the failure is on the pull requesters side:
_almost_ always it's just that the stuff I was asked to pull was never
in linux-next to begin with, or it was in linux-next, problems were
reported, and the maintainer in question then ignored the problems for
some reason.

Very rarely does it turn out that it was all in linux-next, but I
happened to hit something nobody else did. Yes, it happened with the
Rust 'bindgen' thing. Once. Not enough to make it very much of a
pattern.

Sometimes I find problems not in the build, but in the running of the
code. That actually happens distressingly often, considering that my
test-cases tend to be fairly limited. So when I hit a "this doesn't
work for me", it clearly got very little real-life testing. Usually
it's something that no amount of automated testing bots would ever
find, because it's hardware-related and the test farms don't have or
don't test that side (typically it's GPU or wireless networking,
occasionally bluetooth that fails for me).

But that tends to be after I've done the pull and often pushed out, so
then it's too late.

Honestly, the most common reason for refusing pulls is just that
there's something in there that I fundamentally don't like. The
details will differ. Wildly.

                    Linus

