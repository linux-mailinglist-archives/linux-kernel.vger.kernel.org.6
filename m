Return-Path: <linux-kernel+bounces-250610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630B092F9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2130D281258
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA516C69D;
	Fri, 12 Jul 2024 12:02:00 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F126AED;
	Fri, 12 Jul 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785719; cv=none; b=peaJv2r2224gXJ8JSxK02luBJoqKlB2JogN5g0/PcaUyrCAJ/TlE/lOi1/4Cxzx/N6C1EJRNM7dgc48Pir9+1V1jk/yaZmRXmqRkacANe2F+dQM5kJgF3K+HB1w/FMU5LUeQDrMa/WCJ4R1sByE+4gnbnAAlTfTbdZGJLyB66KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785719; c=relaxed/simple;
	bh=L5PoypYip9dGkf9Ak3IhsRm7GfrXu8b6oK8/4PtmN8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBZ1FNIiU3GujYdAnLxdQG2wko//GOlLXAd3t3RcZMD+T4U0/MNkVZtSOqA8NHJWakle49vyLcWlM8xUj9Qx/dc30tD5GLN3mGgyVKN67+xRRkLm46jF0TtvAWS7NhwQnMS1z55C1PDqCgA1OUyyVtk8yBjFpHjenUYX9V27FVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1932337276.0;
        Fri, 12 Jul 2024 05:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720785716; x=1721390516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpXdfTCjeFJkU4/oXiUVwTTFqHjxbGYvB0CpFZlv+fU=;
        b=CE/bQX+ELhOJ/5en5swAlpFxxB4KM1VxiuZJPyJrsNE+R8xlY07bchQlt42bTfiGre
         3JzVUSHrZKJ/fGcWPoM7ZOHUifkouqGdQ+By6Ugf+j94kGxQuzVQvHk6jyHTZ6HTVEfl
         C99vRflK/EndL8dKwMLs2QWH9itelYe23ckbEePDaxaXxAfu8oW2NjHT6FH79gy62acy
         KYhM+IrrYKsZmYCfBjjMOD6h4Hx2/zi9nmmHeZsFEE/Qqbldn4ONfhDk3mFrWY1WFC/4
         i0Rn5iwPZ2W/L9VmlQYfVlglbYZjP5t65M8Z6JY1ZTd9spWoDdXqzAzjJeFBdc3C72yL
         nmGw==
X-Forwarded-Encrypted: i=1; AJvYcCXR1Jm9Ds6jYS+8miFGBJstAw3Nd8Vcz9mE1rBJTbO66jo4zHQdceUeVAyGWPoxQ6LayrNi69uGHNMtRDA3MJrtQB3p3E237PYY5hEGW/TgNo4dLLzjkJ33YpN1EPV/ZQPrBpkxWWZPJwf+owD/y3cGHg==
X-Gm-Message-State: AOJu0Yxa+xdD49nU0J09j4jYmS4HwmZRmaZUW8DWBVgcVWl57CfO31uB
	gClFWyT1tZMJ09spsXMQ/Bwh7fYAb01pTKWzwmLs4pkDSD2GPO4dWvwnsx5S
X-Google-Smtp-Source: AGHT+IG8xm77aX6biFcsIDvdAb4TKJc+bHqwUY8Et4AYoMkMMXtCkvcK0Xm5iIxSqNMsLR8bkQReJw==
X-Received: by 2002:a25:ae5b:0:b0:de5:4a92:435f with SMTP id 3f1490d57ef6-e041b12b399mr13265954276.46.1720785716449;
        Fri, 12 Jul 2024 05:01:56 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e041a98b0d4sm1261686276.49.2024.07.12.05.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 05:01:56 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so1995301276.2;
        Fri, 12 Jul 2024 05:01:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw7ERtCnFoEz3WWQhAQ5sVJI3SKra0EivIwidEkUadDsvBUXaBBaX8jip6txlaZl6UtZHplVmDZFqlBLHUq9mjXtpE2bWoSbSZnuwqMfH0ZUh+qBxzPFDbuHRPiP+Q/PSvO0rBi2vnxTCqtbeuvkxa5g==
X-Received: by 2002:a81:9208:0:b0:632:c30a:fde1 with SMTP id
 00721157ae682-658f07d73d6mr125308057b3.48.1720785715087; Fri, 12 Jul 2024
 05:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
 <0e4c9ffdc8a5caffcda2afb8d5480900f7adebf6.1720707932.git.geert+renesas@glider.be>
 <CAA8EJprLg8-BQT2OsLb5xSNVdFLf2mF6sSw_gAie0dBXawQFqQ@mail.gmail.com>
In-Reply-To: <CAA8EJprLg8-BQT2OsLb5xSNVdFLf2mF6sSw_gAie0dBXawQFqQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jul 2024 14:01:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMPJh=02xn_2PuZ2UWyXKHiWSe_Me+wg_qiSziCUSH8g@mail.gmail.com>
Message-ID: <CAMuHMdUMPJh=02xn_2PuZ2UWyXKHiWSe_Me+wg_qiSziCUSH8g@mail.gmail.com>
Subject: Re: [PATCH] platform: arm64: EC_LENOVO_YOGA_C630 should depend on ARCH_QCOM
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Jul 12, 2024 at 12:24=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> On Thu, 11 Jul 2024 at 17:32, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > The Lenovo Yoga C630 Embedded Controller is only present on the Qualcom=
m
> > Snapdragon-based Lenovo Yoga C630 laptop.  Hence add a dependency on
> > ARCH_QCOM, to prevent asking the user about this driver when configurin=
g
> > a kernel without Qualcomm SoC support.
> >
> > Fixes: 5e5f2f92cccc29f3 ("platform: arm64: add Lenovo Yoga C630 WOS EC =
driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/platform/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
>
> Could you please add the same condition to the Acer Aspire 1 entry?

https://lore.kernel.org/all/f5f38709c01d369ed9e375ceb2a9a12986457a1a.172070=
7932.git.geert+renesas@glider.be/

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

