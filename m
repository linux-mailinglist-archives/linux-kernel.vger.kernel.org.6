Return-Path: <linux-kernel+bounces-317664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94C96E1BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128CF1F25B54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4F17A938;
	Thu,  5 Sep 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MH0RSR+"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41EF15F3FB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560176; cv=none; b=B/8QOX57fnDrsZw+z5F5pgPSy9OoxMtwmLNpl1evQm3CYFmpPRgzxTQuCkgDh5TFU9CYboJXqOpZS22DPpMJSHwbvmT3eMbNcnY7NJxvNm9Lwu8ETuLJ9Mvhj9egmh8B1wi2r0JqwpT7ElQaX7zlozNiCCk7ofGrT6D7S9kb+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560176; c=relaxed/simple;
	bh=VDG73B3i8Fkx0gtYg22krryRHLAdvGRMSQ2YE6B/GM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n28lhZsC/O7QClmyXGp/Z7tAcTUN4I33I6JoJjPqTeQEPgnansmCueq1eMa+yBgKrnsDkGS4wCBvBaH6dIMcDn25F/RhRq9i5P4lLAaDWdGrkrAc2PrJF4uVxvfwnI2BtyzzxR56pugXwEvGNXjXWTHfjWhNIbQ65yhQs+HYd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MH0RSR+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-457c6389a3aso33961cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725560174; x=1726164974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdUTGl7VQBs4B0vEjvie8Mtu3hSlR654PMQj+t2RiC8=;
        b=2MH0RSR+vBTqzWcGR82xVle83Co3iKi8k0SOVZRgYdM6YUfUT0t/U+S05hqjqfYBMm
         E8OxUZIxYGAy8bwOBDXGlD2IQsfOBPHR7VEFkCRUshU5JbHckkVWjpqnPtS9aUiCWF33
         1CZv7V6HZ/LV2WiS0XqDEl4BK+JvtdXsYEwTkY6RaB5zLyp76qofq4DG9MkgWSKfHLlg
         fr91AnP3EqFQWrvWmffIljiYcBXYJQJmwN/wE2IQBmC5vEayfhplZ/IdJFHVODSc+bEB
         5rH5K+gmEVmF3GSmsUPXdCP3nF3RgARM5frtEd9VgoFMAnIHTWHfTqwBcSZPjxF6u3VG
         h+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725560174; x=1726164974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdUTGl7VQBs4B0vEjvie8Mtu3hSlR654PMQj+t2RiC8=;
        b=TuB09PPIxFdEj7GXKKFg/klX77d3IQnBHr9xT8JBc375ZmukBCbmI1TjqnTd+ucnL1
         oikSYFJQoudpsZH90fU1lMvc7zBxFoepD0m/J1h6v+iBAZGFfos6AM5T5CVbQTe2/3E1
         rBoH1n8w3L54APpKT2Vq9Nq9R9FXXAei883OGGCvsJAsBXDdWtKy0kwtkd8OkAsjb3Ud
         qCk8cHILZNmiL2xsBWqk+zca+mLQrG2L/AQ91E5drn2eeoa3nMjW4MGYh1IahJ8Ow5gk
         74BkecgiZdwEPSF0WqPX4U9J9SZdftNVu0J1oVqUIRe16QPDDevWF3c5vxBrZGEPrJaR
         HHZw==
X-Forwarded-Encrypted: i=1; AJvYcCVNzVnPAjK3NKDWKHi0mcm2WdsafQTnptMqNxmfc0uEcnGRe7si0ya0q5iOKlLwjWFlYQswpwxOmIXW88c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9NtihVe4DRy/droTEgbCJ9a//Mcy2vGTlUlEs8PNhQfnTNgV
	6CTU/OTCwSNM3wH7qb8VlIuANcGyDhjTqp7E5nC+vMl7+JxCmXe0w7rgE71zTMEMTusbZCnVH9G
	yPfXk6W79Q1BLqwub9z1ntvzz90Q03lbAmX7t
X-Google-Smtp-Source: AGHT+IHplDe4MMiBWOY5cVCCpgg/EB/UGBgSHmgVn9Z/Jd71Qt02BDSa8paxdOMnp8DalfNq+r7OJlfFE4bJP3BtPdQ=
X-Received: by 2002:ac8:5891:0:b0:453:55b5:ecfb with SMTP id
 d75a77b69052e-4580c434242mr323391cf.2.1725560173715; Thu, 05 Sep 2024
 11:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-32-samitolvanen@google.com> <47bc562d-b9c7-464b-a2e2-dbb8c14d146b@suse.com>
In-Reply-To: <47bc562d-b9c7-464b-a2e2-dbb8c14d146b@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 5 Sep 2024 11:15:36 -0700
Message-ID: <CABCJKucxDtCeq5NgwU9+8Fb1yGbrcV_91NbzM=6YquPLL48Jxg@mail.gmail.com>
Subject: Re: [PATCH v2 11/19] gendwarfksyms: Limit structure expansion
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:15=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 8/15/24 19:39, Sami Tolvanen wrote:
> > Expand each structure type only once per exported symbol. This
> > is necessary to support self-referential structures, which would
> > otherwise result in infinite recursion, but is still sufficient for
> > catching ABI changes.
> >
> > For pointers to structure types, limit type expansion inside the
> > pointer to two levels. This should be plenty for detecting ABI
> > differences, but it stops us from pulling in half the kernel for
> > types that contain pointers to large kernel data structures, like
> > task_struct, for example.
>
> I'm quite worried about this optimization for pointer types. It could
> result in some kABI changes not being recognized.
>
> I assume the goal of the optimization is to speed up the tool's runtime.
> How much does it improve the processing time and is there any other way
> how it could be done?

It=E2=80=99s mostly a matter of how deep it makes sense to go. For example,
queue_delayed_work_on accepts a pointer to s#workqueue_struct, which
points to s#worker, which points to s#task_struct, which points to
s#mm_struct etc. Does a change to an internal kernel data structure
several references deep change the ABI of the function?

If we traverse through the DWARF without limits, during a defconfig
build the highest pointer expansion depth I see is 70 levels (!), with
~5k symbols going 30+ levels deep. We would end up pulling in a lot of
major internal data structures at that point, and a change to any of
them would change thousands of symbol versions, which feels
undesirable.

I'm fine with increasing the limit to something more reasonable
though, the impact on performance doesn't seem to be significant in
parallel builds. Of course, this might impact vmlinux.o processing
more, if we end up doing that, since the DWARF at that point contains
information about all the data structures.

I do wonder if there's a better way to figure out where to stop than a
hard limit. Any thoughts?

> > diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwar=
f.c
> > index 92b6ca4c5c91..2f1601015c4e 100644
> > --- a/scripts/gendwarfksyms/dwarf.c
> > +++ b/scripts/gendwarfksyms/dwarf.c
> > [...]
> > @@ -651,6 +742,7 @@ static int process_exported_symbols(struct state *s=
tate, struct die *cache,
> >               else
> >                       check(process_variable(state, &state->die));
> >
> > +             cache_clear_expanded(&state->expansion_cache);
> >               return 0;
> >       default:
> >               return 0;
>
> I wonder if it would make sense to share the cache between processing
> individual exported symbols.

The actual DIE caching happens in die_map, which is already shared
between symbols. The expansion cache keeps track of which DIEs we have
processed per symbol, so we don't process the same thing twice and end
up in a loop, for example.

Sami

