Return-Path: <linux-kernel+bounces-401303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB7D9C188A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206B81F24389
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A11E049C;
	Fri,  8 Nov 2024 08:56:31 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB67047F69;
	Fri,  8 Nov 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056191; cv=none; b=H8kpo6gQJcY2asF11IN2fx2efBd2fDcABbtHftiv3hW77TKvvqJZ7F1lu5uI6rYB9naKcYIaxsL6PntUNs5S3QaIChUMmReIrBv5loKP0wO2LpIGKuBOlji7EX1ZUiqPpiTBIDv8FlVcQE1S8x4/Nx+/iPk1wn4np61y0M+9UXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056191; c=relaxed/simple;
	bh=rrmgunvTJ+LbeosaRNs9WFk6xpnbkpOpbqPD4AJK4s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfW9KPpNOa8of8r/nWIwpjycQs2XbGkIK2cN0PgFYpJOp2B6OFR34m4grlGHJMnTtYKRldDzrM63wC+FyEhqHOQaftciEI5OsDvTmwxofU5aea6uTqUiMEB7McUvXhQDwlBr9CoYGvuR6D5J9BwLmVBpagJdJrDlAYXqV+YV3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e2915f00c12so1962993276.0;
        Fri, 08 Nov 2024 00:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056188; x=1731660988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wpmVEsmuJB7pcIow0lnOOrf5v2idmphGsuBkI3kTvk=;
        b=UrzI+WyMWzS9WJatjwiGS90AUMbJIlbaDxuKwY3bLJRAIHTdHsTT8sHGliGbTGRnaM
         SXydcsYML1c428oEWW9tEEB2OTwD7D9rR72UIWutCRLa94fSf3tgOoiIuC/3m/GXUJ63
         UXWTD7JsWcFf1cyJURfkvJRTuiba4ZmQRpV6c59YoZo284ouVUHT6XJQ/GK7DYH+dOum
         H9zx4wupHbsVgtjjU0t3YCbEAzLNksw/EIxqcLWsehurJCZZrpXmXab95xhoa+Lyx/iQ
         hxHE/GZ/atM8uMjpS8U3E1e+ka1RZtIq0IOB7ijwapwb3wj6MA6pkDFcEnEshYNDY4vj
         +DDA==
X-Forwarded-Encrypted: i=1; AJvYcCUFXFMz8uNQMNCdi+JAKyFNnG/p0vBNvN4VcAXIChv3UlNWnxf9yQw+vEp3FEzNKIcxhp3HJO5jtUnR@vger.kernel.org, AJvYcCV4PoS5i22gNs1zFIToRffG2e5S1yHBLpnm0vXW0wRkHMgxZrys4RYnoia6pvqbZo9PwqrMvsJvqwdggOkt@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7F41RfWKvX9HZTNpBEvcRLVNOwhD5oS++hlik7eYsCiJb821
	WoeqRMDnxOAMNc6WZnqW726bGpZuTfvzdK5tjybF25rw3L4rZvXbehUpZWDO
X-Google-Smtp-Source: AGHT+IGeY/s5J2bVGu0icsdUQxxyXhyZjLlUf1CpjeDtenCVESqXV3O3mlgWWPkltQEYdZEPvGn5bw==
X-Received: by 2002:a05:6902:e0d:b0:e29:4818:bf13 with SMTP id 3f1490d57ef6-e337f8be9cemr1758803276.41.1731056188030;
        Fri, 08 Nov 2024 00:56:28 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ef24de5sm622220276.17.2024.11.08.00.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 00:56:27 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e290e857d56so1912721276.1;
        Fri, 08 Nov 2024 00:56:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7UCEvosAAJ0wLbyHfT8+2D8OIk2XbqQ4YYxo1KFTmGJpVU75ViR0FPx/Hbe3dh1GrJjIgt14KKTMxhnrK@vger.kernel.org, AJvYcCWZQUnW5Ida+/f/a1aXbttcotysYqSSZL4VW8frMRicYRZZwwSiVM8SvktPZ8ajQxqGC+TqsHoW1slH@vger.kernel.org
X-Received: by 2002:a05:690c:4b90:b0:6ea:7198:fb64 with SMTP id
 00721157ae682-6eaddfa4910mr21644887b3.41.1731056187520; Fri, 08 Nov 2024
 00:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016212016.887552-1-sboyd@kernel.org> <20241017203810.GA814469-robh@kernel.org>
 <38153cbf2616a4a6706412952778eec1.sboyd@kernel.org>
In-Reply-To: <38153cbf2616a4a6706412952778eec1.sboyd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Nov 2024 09:56:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWp84u66Y-ELtbbRmySYwQch_=2qQiXzWJzrSkGeLZYBA@mail.gmail.com>
Message-ID: <CAMuHMdWp84u66Y-ELtbbRmySYwQch_=2qQiXzWJzrSkGeLZYBA@mail.gmail.com>
Subject: Re: [PATCH] of: Allow overlay kunit tests to run CONFIG_OF_OVERLAY=n
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Sat, Oct 19, 2024 at 12:21=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wr=
ote:
> Quoting Rob Herring (2024-10-17 13:38:10)
> > On Wed, Oct 16, 2024 at 02:20:15PM -0700, Stephen Boyd wrote:
> > > Some configurations want to enable CONFIG_KUNIT without enabling
> > > CONFIG_OF_OVERLAY. The kunit overlay code already skips if
> > > CONFIG_OF_OVERLAY isn't enabled, so this select here isn't really doi=
ng
> > > anything besides making it easier to run the tests without them
> > > skipping. Remove the select and move the config setting to the
> > > drivers/of/.kunitconfig file so that the overlay tests can be run wit=
h
> > > or without CONFIG_OF_OVERLAY set to test either behavior.

Thanks for your patch, which is now commit 027af8c26fdc0642 ("of: Allow
overlay kunit tests to run CONFIG_OF_OVERLAY=3Dn") in dt-rh/for-next.

> > > Fixes: 5c9dd72d8385 ("of: Add a KUnit test for overlays and test mana=
ged APIs")
> >
> > Doesn't really seem like a fix.
>
> Ok. Feel free to drop the tag.
>
> > Does this need to go into 6.12?
>
> It's only important for 6.12 if kernel configurators want to build the
> kernel with OF_OVERLAY_KUNIT_TEST enabled and not be forced to enable
> CONFIG_OF_OVERLAY. I don't mind if it waits a while.

I'd say it's a fix, so please keep at last the Fixes tag. Merely
enabling kunit tests (which can be modular) should not increase the
possible attack vector on a product by enabling extra unneeded code.

So
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

