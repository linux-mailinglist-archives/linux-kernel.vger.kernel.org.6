Return-Path: <linux-kernel+bounces-259364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7489394D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A331C2150B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027B3BBE3;
	Mon, 22 Jul 2024 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egXuJs/w"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437C3A1BA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680729; cv=none; b=sEQDpPJ3iEI9NnefZyoZc5JiPileIvCVjrnRBSIHCQoHhi6Ungxh1KHbdJnJhjbnnXD68Ddi1r45giao2Hq3sG3plMuF4XxT55onhDobMwP7yJvlNd3jRYBo2YOZ7DToVAi0cln/m7tH7BbhG/UB+Rb8hsHfTwY6U7Nb5wXVs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680729; c=relaxed/simple;
	bh=g+fv7OJVWOMMleBQzuG7E8psB777BJk/nbaQACHZyX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhTG1KOLy/4MJsBzT4dDX0XeSXoUWuqYic1i6bQtAb05mzDs4eN3eFQxjLR3OzRCeaqpZv/bEc6TIp8pJCt6nGbxS0I2YMyqnLj8YC+/2L87ehliBrYH2KsJRntUMg+bwMPKbvYIftmBupIJ3KE1WYBXozE+s7aKUYwGCdtVM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egXuJs/w; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso2331449f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721680726; x=1722285526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWvxWL/SNIp/p1/ug+eVMpMZjJit2TPmzxyd8I18mCI=;
        b=egXuJs/w824NoK+wyBRzI8GqppQ2uk9HyVsKCwCjv1kRN4PJ+uG7jB+mltBmHGIozS
         o1STubrqiKArn1TnteRn23vSiK/O548p6uHUHdyQ7LG7z/wZUVvtz6+cmNMYUnnb0/qP
         dRJ/PiqwV4yZ/P1p+xXG20Yb+awG4tZbU+UPbxO9KtdtnGlRS4V4Qci/GpyuXzJgxV/c
         lfU4iEbwe/k1KwLyLqTQGsgNoIKUzxpaldMqrW2kmr4tDaAKRtyd72VhtvU8AlCDuKyp
         bKVBh8oTj1x/rjd3CZl0jg9xxmwbREhRYLm4IK+AH9B0pWjIqI469nZ+H+yFXofdrt6X
         YNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721680726; x=1722285526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWvxWL/SNIp/p1/ug+eVMpMZjJit2TPmzxyd8I18mCI=;
        b=afBBT/msPLHk84a/yFeswqy0hOgfocfpsgGCWPlPpqXcyLJFpqJit091iStk8FhCF1
         o8xJtRMsPs/TWKrOLU2Wfe8F6tL9MufIogTHIaGsjlDx+zjBYUdTl6sNk47uKf8UwRTm
         VAY+t1d3W+oD/b4UHiKmTOccUPrVh2tNXLdH92kMLwAQmNiSoy4k0lmzgJnyYBXPD9I5
         GfsINN4BQYIYMZXETSXP9X24WpwbFnQlwuTba9Q+c2K0V2MtWw3g3rqGAWFPd42ygBXi
         v3dKrZJcSXqP9S56V6BJBkagPBmqsG76qUrnsxsplR5Lblj3FeUms8BOXPlbrZY/Xez3
         D6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXo471YuFujc+LO+OQ1c16xquqsR6PMvOBUAGB8V33qDgv5wwgpuTTjoYTB0csHZRVKlNiYdVYBWP5S9Hl9w8B0k6vlIc2fhSRly6V
X-Gm-Message-State: AOJu0Ywcq3akj79E4cGohHCsas2VvRZhSnOrgdzmp+4w69kNd+sQ1l1n
	Q/ZAIPNGXML5fyEB0kF/VZ9ckVwXDvGLobhSP+QQw28PwOBcfMC/GgfaAAAQtjJboClacqxF4LK
	czqVJ39Lt68xOSpiYaKjUeflMXPo=
X-Google-Smtp-Source: AGHT+IF8J39DuFIL/NKaVBRas1RRiYK8t648txfmNo9Ttbikt7JIk4Wdvhex5K3BTc1O7+q90FGcdZ0AAp0YrRgpAs8=
X-Received: by 2002:a5d:4a06:0:b0:368:5e34:4b4b with SMTP id
 ffacd0b85a97d-369bbbb3025mr4808628f8f.6.1721680726073; Mon, 22 Jul 2024
 13:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722202502.70301-1-andrey.konovalov@linux.dev> <CACT4Y+Zb5ffw0MiYMNqT6YUSdJ7X6xDxJND0ZZPQ7SZmoGybXA@mail.gmail.com>
In-Reply-To: <CACT4Y+Zb5ffw0MiYMNqT6YUSdJ7X6xDxJND0ZZPQ7SZmoGybXA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 22 Jul 2024 22:38:34 +0200
Message-ID: <CA+fCnZeZqPX-K=FAAHfT3nZKWPgAABsqKBUrhrZJ-omuyH=w6A@mail.gmail.com>
Subject: Re: [PATCH] x86, kcov: ignore stack trace coverage
To: Dmitry Vyukov <dvyukov@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Aleksandr Nogikh <nogikh@google.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:36=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
>
> > +# These produce large amounts of uninteresting coverage.
> > +KCOV_INSTRUMENT_dumpstack.o                            :=3D n
> > +KCOV_INSTRUMENT_dumpstack_$(BITS).o                    :=3D n
> > +KCOV_INSTRUMENT_stacktrace.o                           :=3D n
> > +KCOV_INSTRUMENT_unwind_orc.o                           :=3D n
> > +KCOV_INSTRUMENT_unwind_frame.o                         :=3D n
> > +KCOV_INSTRUMENT_unwind_guess.o                         :=3D n

Ah, I even reviewed it, completely forgot :(

That's great then, thank you!

This patch can be ignored.

