Return-Path: <linux-kernel+bounces-336718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372B983FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B3FB22074
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501CF1494CA;
	Tue, 24 Sep 2024 07:57:23 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DAA1474A4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164643; cv=none; b=koEHjEuKuwpUSM8nJf+Ej40wPkG5Vlv0RNkmt/24iG+G5QPVE4nIXkfDcEeZmaoIKPmeDIHKQJz0fx4lEetca8OwFU7kwGYmD79qfzwNqzToyKC5X6J3DLMfT0Bi171uM8WiEcMWoyFH5BG7w7s8MYcNgTZjGbLny1joJm2SlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164643; c=relaxed/simple;
	bh=RKowt0FFc8x3wRCchLfYX7XfexyNF5l2SWwQCM7MR7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5Mf14XjoUIR1/sTkqWt176AVN4gKkOx+D5IM6b53YTg27FbAYIvfUKG9SCdMiU7ELiY9uEZiIwNl9jhmPBors4475dbGRW3XVUp6PTeC1/KxtHNMKO51pPFL7atCUozlyniX9RyqyRvLMK/DKDl/d4O9gSspJ3Encblqrs0fa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ddca648c26so42116397b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727164639; x=1727769439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T6lrXrdJ42dj8UMvWJFA38sI0OSrxm8jLvhOl2iNKc=;
        b=vq6OBU5dOTDVJd05m+MM6kMnbLfsqYzhGdoeYNkKdP34hgNE+cM72t7n8DtKWugYAJ
         q6EvKvHgzS0oIJ/jQsuniLbKq0FxRBMpk0ZsshJAZaiUuCU9ZRXDflOqasNyLeW5aUvp
         Jp1gEPAa+4MBBm8Fra8vcoZRZv3nvcBC/xNBXj8fAJ+R92eLyA62ybB428eC8XxZ/rfl
         nMFbrP5gYXZ3sqgR7keFsZJ8c3mNzkHjW3c4e6X2XakbpcjGf13KoGLx0WuykX1/IzX7
         FWWHVeFSJXpfAWQrZ9jswHWoC/cRv5QkuhnotaV1KSleAV7m1aC+YTkVQRGac1kP37TT
         BTYg==
X-Forwarded-Encrypted: i=1; AJvYcCUsfi56N508FcEr4eXyqWWyneiFBAM+ATchoHZUMTLV9FfOHq1llKQ7raLIery2mzYf1GLV8oX8xzaQVa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0LeMs72R6fQjXJxxAK5X/bZyZRIzHMs0mnhWvv7b2pkN3e4f
	Eyb7wUgXtBzH+djXgM2YRq5gc65h2mPVAR3kJOz+6pcXg3seIy1RIQ2LNizk
X-Google-Smtp-Source: AGHT+IEWVCBrJtPBKr+VWNWjdQNs9c5OwKoLSb6c5eMDqjEPH48R70HMD0JilgBDydkpVEp1XaJvxg==
X-Received: by 2002:a05:690c:dc4:b0:6db:cea9:6ed9 with SMTP id 00721157ae682-6e2085506e5mr18421807b3.4.1727164639560;
        Tue, 24 Sep 2024 00:57:19 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20ce8857dsm1777907b3.0.2024.09.24.00.57.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:57:18 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6dddca05a60so54771957b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:57:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/kbn+AUELjuIQv09faTBdqsZNhtvWnUTFwKUt2Nu1T3T0aqsYcKR1gjDClNUBYn2vr5Jq2xq6cd+K1JM=@vger.kernel.org
X-Received: by 2002:a05:690c:2508:b0:652:e900:550a with SMTP id
 00721157ae682-6e20886da73mr15435207b3.19.1727164638275; Tue, 24 Sep 2024
 00:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922225041.603186-1-linux@roeck-us.net> <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net> <87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Sep 2024 09:56:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBbBKskY+TXswaw-oHvLANzoVJGWAjWQDy4HPMuZwasA@mail.gmail.com>
Message-ID: <CAMuHMdXBbBKskY+TXswaw-oHvLANzoVJGWAjWQDy4HPMuZwasA@mail.gmail.com>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Huang,

On Tue, Sep 24, 2024 at 3:25=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> > On 9/23/24 05:58, Geert Uytterhoeven wrote:
> >> Hi G=C3=BCnter,
> >> On Mon, Sep 23, 2024 at 12:50=E2=80=AFAM Guenter Roeck <linux@roeck-us=
.net>
> >> wrote:
> >>> Building allmodconfig images on systems with SPARSEMEM=3Dn results in
> >>> the following message.
> >>>
> >>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
> >>>    Depends on [n]: SPARSEMEM [=3Dn]
> >>>    Selected by [m]:
> >>>    - RESOURCE_KUNIT_TEST [=3Dm] && RUNTIME_TESTING_MENU [=3Dy] && KUN=
IT [=3Dm]

> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to depend
> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
> you check whether the following patch work for you on top of latest
> upstream kernel (with Linus' fix).

Yes it does, thanks!

One remaining issue is that RESOURCE_KUNIT_TEST selects GET_FREE_REGION.
IMHO merely enabling a test should not enable extra functionality
in the kernel.  Can the individual test(s) that do depend on
GET_FREE_REGION be protected by #ifdef CONFIG_GET_FREE_REGION instead?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

