Return-Path: <linux-kernel+bounces-254005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71060932A12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12D31C23D94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA7D19E812;
	Tue, 16 Jul 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSuhoIcj"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224919E7FC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142330; cv=none; b=SK9O/BoH3Lr70tqQ1PTt86E5EYcjIfQ++GEzrMRQNxHeKa/0oxtoG4DbCHSxHFwHK0LbMAPSA3l9XGr5+LJszxuRL6PHbFDp9U2XJofoQZm9lZL8M6NaR5Di2wWqUTZp0JMNZW3W/kT4JbgiyQhI8jsmNGGNrXts/BsjIwyZM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142330; c=relaxed/simple;
	bh=xefOgnZeuLhtvi65uS18ux4ujjqzyflaGqyvkSgWkHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJwGKVKwT5K0SCnkXGy9bfV3lxpFJ6qxpOBtAHP0Hugb9IzgtrTefFlver0Uo+jGzzeip5KotnGFSn1UKnuT/qGS2rJiag2q1E0oKH1FhK+SES/+lSn7skGkng3OZbQGZEO4w2Ls1JhOAJmA5bq7fF4ARfjFs4fwNx7/XbT0GvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSuhoIcj; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-38b3543541dso177585ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721142328; x=1721747128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xefOgnZeuLhtvi65uS18ux4ujjqzyflaGqyvkSgWkHM=;
        b=WSuhoIcj213PE38UZtyVgeBwXsIR41nLYNaSsSOQqgd6E+8cMdZJOiDbpCj1CeGGvS
         jEfyA4tt1pRn6Z0/mNVjjUsYc5lV7oCHFyTIzdlfbUDHL/OO9vAKQqc4ieOOhNBTEMDk
         e0bV5Sgq5ENgkhIbOQ14te4fDeKNpPa25cNguN+bXqO8L+tsngSJgMIw9t2eG/Yo6h9J
         TY7SJcyOHTeJCfFNcuNqfHFb4KkvdovNnh2H5sJ951ybrOxpR2F9EzGIvX3OEpaxFksW
         2JvCuWgKa8F7uBWbe8TGunSNWgkoQMefncfWoKqe4sRtlfBpVUgo1snSvHO1PzHtXG3E
         2uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142328; x=1721747128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xefOgnZeuLhtvi65uS18ux4ujjqzyflaGqyvkSgWkHM=;
        b=Co0NUmpzRM2TomISmvyj2oFNYM25+XyXrpT/DqBdV5+nHK72AiiIIbZqcol91+rjkc
         8m7/gOWrFgyhVfWbWrv6AlCoIkBB/u/w6ztEMxchBr39jSqDGcGLVwPLyO+6y7Lh3gTJ
         4B7fcKw4zfOG0EmqEjq5j5rMr/NA6E0Je0lHPAnLLhde/yf0RvMdvSIDlyiVMzy/SjGL
         JoOKghWV0J/C03y1+VmL2hCDHqaAm9JCVMTYgYHEfTwssMVRZiM9vXfiBdAQZc0qJIHP
         sY+2fwLC1TOdxP+ifQJx8lprxT00gxOS2LiyabMeIXiJqvzc4x0aNvt+oSQ0iyXYsqaX
         /z+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbMm/kUndqO3oytbffXxe1croWgV1v2F3AjBUTWPNARiiWRLfK/ZLneUR90WLPoYPafkI9roFR17TiqGhayE+CnXz1NChc3yuLCRXR
X-Gm-Message-State: AOJu0Yz4oe12oqj5xde0R6GCb7p9WedV4nvzFTN6MsuF/UlkcctTJuw2
	R0J8LUhOd4SpmEO5X572WmoIml/GjTwlwjKUv8D4uAiR4LOHCNLOSAYutQwkI7+luHQbkZntfdM
	Pju9rtfFEW22YXYUBdFBhjVS7X2ZMaLIohPr3
X-Google-Smtp-Source: AGHT+IEIPantRUK2oSHuRgiQ05thlnoYDlj/klIq6vsDAHLGGqEsy9dglfj/Nwvip17tk3QxhSF3RAgc09241BCGrbc=
X-Received: by 2002:a05:6e02:1cae:b0:37a:9156:400 with SMTP id
 e9e14a558f8ab-393c25f44e6mr3042645ab.28.1721142327777; Tue, 16 Jul 2024
 08:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715143342.52236-1-leo.yan@arm.com> <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com> <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
 <CAP-5=fWY4AeMxfNGh_jB4gss_qtGSgfX4pvv-D-fpCWuqamVfA@mail.gmail.com>
 <f316e3ce-e1e3-45f0-ac78-9af590b58706@arm.com> <CAP-5=fU=LguHNi861L4gmgZWXrrgZtG1w5cdw7hXDxnfWyJyMQ@mail.gmail.com>
 <a17e6701-4195-4132-8518-fe4b10403f7e@arm.com> <CAP-5=fVi8RJVokVBQtin8xSAq7uxN=GB7zcC4OiT=SzqWB+V0w@mail.gmail.com>
 <0c20b4b7-c1f6-4c0e-9f89-a99c25555640@arm.com>
In-Reply-To: <0c20b4b7-c1f6-4c0e-9f89-a99c25555640@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 08:05:15 -0700
Message-ID: <CAP-5=fVvg=5SE29_SUW0MWmLADL477vpP2DBid2kKZ8kNqxXiA@mail.gmail.com>
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Leo Yan <leo.yan@arm.com>, llvm@lists.linux.dev
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:49=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
>
> On 7/16/24 14:30, Ian Rogers wrote:
> > On Tue, Jul 16, 2024 at 3:06=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote=
:
>
> [...]
>
> >> Thanks for correcting. Now I even can build successfully with the Clan=
g
> >> from Android NDK with an additional flag 'NO_DEMANGLE=3D1'. Though we =
still
> >> need to disable several modules for passing the building, but we are o=
n the
> >> right way.
> >>
> >> Would you like to continue a formal fixing or you want me to follow up=
?
> >
> > +clang-built-linux
> >
> > If you could follow up it would be great!
>
> Okay, I will look into it.
>
> > I'm not sure how we detect
> > in the build that we're using clang, I suspect there is an approach in
> > a different kernel Makefile/Build that already tackles this but my
> > quick searching didn't yield anything - perhaps the change would be
> > better suited to the location the CROSS_COMPILE prefix is added to
> > gcc.
>
> Should we follow up the steps in the Documentation/kbuild/llvm.rst?
> The document uses the flag 'LLVM=3D1' for selecting LLVM/Clang.

Fix clang-built-linux email to llvm@lists.linux.dev

I'm not sure as the kernel build and the tools build differ in certain
ways. Perhaps look at the selftests build to see what they do, as they
are under tools and share the build files.

Thanks,
Ian


> Thanks,
> Leo
>
> > The only thing the change to Makefile.config is doing is
> > injecting the --target option. I'm not sure anything more is not
> > working for me on my laptop with this approach compared to cross
> > compiling with gcc, but as you say going in the right direction is
> > worth it anyway.
> >
> > Thanks,
> > Ian

