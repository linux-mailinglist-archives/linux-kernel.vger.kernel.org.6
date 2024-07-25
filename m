Return-Path: <linux-kernel+bounces-261954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7BC93BE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E256B216EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04C196DA1;
	Thu, 25 Jul 2024 08:54:51 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AE196C9C;
	Thu, 25 Jul 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897690; cv=none; b=p1MhjYO60ygHQ06Fn2wHoa4GJ16JQM6CdspKoZU/tmJfszvIsjX/FAl2RPh8M019CWo8w6XbHw2/Ly5KA491N9VbLYApXyuRAT/ScOaGWbxwuu5YCSvQjntjP7d3Cd8PMds4OBQQKL39Xoc2MMUYdxrT97i9R48IXAEc4KVsnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897690; c=relaxed/simple;
	bh=qMTxOoF5YOyvHk0ls45knTCQg1X++VoqiD3C92C7nOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKO3DPot4Vmp00vN9XOhJDocbNVoi9z1kYwxwovrzI8mxFogEbqj1WwukRA3sjrSDcQYhxI4ZNQhh8rH0gU6woDbNpZ+3wO/I5/T2QQoby9OhXjRuHNDBtVTTn1WM9cvVLHzn0iH00UJR5gLMJMtsf5XjwtZ/7wr+3286+qaGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64b417e1511so6506737b3.3;
        Thu, 25 Jul 2024 01:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721897687; x=1722502487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsUUEK5ZVOH7HhSfZgOatkefmX7HFbX/FBUmM+q0VkA=;
        b=seLtY4N7hjuFCgjcePAXw55tjhPw5rQX8GB/C8P88/arS456xuvJwPBe1DpeCexq4r
         ajsGxMjO41hs1q4M8u34HwoqdI5KjJ6OK7vjhVeWLfaJuT6uIwktE83SlwV1PaPze8AI
         xSZGNpUTAmotbPfhfsd71CSRSf3Zxi35+DWZSkox7PzTW+4EjjKuwAYdaWv5Ne2K4Fca
         Hw/tKmxFUCMv/6TJr67ggigB8BPAglrglrCuOs0cSri1qhgTEFbyHatexpyfbLsz0cQT
         BOCWas9jpMUcqfkeHFsxPcyXASnnER0r7sqzzlhBOfFdINa1812F3XSUCiovZWQ2Ya59
         QHnA==
X-Forwarded-Encrypted: i=1; AJvYcCX7qFTGpOjHedWxqR4NLERsvtOBg7u86+DWYGaVm0CSqIZs4XMAeImNHITFWRzV7gb03Dc98i87f2t2PToPizOVufb9xYV10gxUk4UV+ly93GJMejUiMOiDH5cUEasWy9fyeXLMs4cqXtR2OTYk
X-Gm-Message-State: AOJu0YzVuabhxQ+fuv0RCtc1UbnbcjF/cFaU25LsIMkAyModKvb7Kmpp
	GQW8RAcTm7VBL7jjREx1hkbHnaUkXyRwZX8JoEJUa2p+cvFpgSxbXoOraEVv
X-Google-Smtp-Source: AGHT+IGOlnlMP7i8Z2Ccgjj5YrIMZfb9LGKwt2Y3U+9k3lbPVW+XWaR0o/9ckMfCj2zWK4HbXO1UJA==
X-Received: by 2002:a0d:fcc3:0:b0:65f:8e2f:f7a6 with SMTP id 00721157ae682-675b6c2f9bemr12145727b3.24.1721897687118;
        Thu, 25 Jul 2024 01:54:47 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756786a33esm2715777b3.44.2024.07.25.01.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 01:54:46 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6634f0afe05so7214647b3.0;
        Thu, 25 Jul 2024 01:54:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqldUMO2gOKwT6Yn2AFPhPEuKdPpTTbyeWod9pD/ZPusju2eO45IUtejKqK6BXoUHc+BL+zOSi7mT3P3D6cU8IL4FcvBsrbleOEhMC6/VCNC8kgJAE1ng+M0YbrS5eD5M1vKfvRtIQGkFqESxZ
X-Received: by 2002:a0d:f401:0:b0:64b:8b8f:7770 with SMTP id
 00721157ae682-675b6d2553cmr12736707b3.23.1721897686734; Thu, 25 Jul 2024
 01:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-md-drivers-auxdisplay-hd44780-v1-1-0f15bd19f949@quicinc.com>
 <CAMuHMdWCTKBJ5FXeDTD+opJshNk3micT06kea+YRD7WTtqsnbg@mail.gmail.com>
 <Zl4eNFEdrsFmHFq1@smile.fi.intel.com> <3f18dc40-ac63-48a3-bf25-66617d37b27a@quicinc.com>
In-Reply-To: <3f18dc40-ac63-48a3-bf25-66617d37b27a@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jul 2024 10:54:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXORkCo0wJqG-kQfw9eJVf8t8xdN97yTQO_Hih_Hn+b1g@mail.gmail.com>
Message-ID: <CAMuHMdXORkCo0wJqG-kQfw9eJVf8t8xdN97yTQO_Hih_Hn+b1g@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: hd44780: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, Jul 23, 2024 at 8:22=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> On 6/3/2024 12:49 PM, Andy Shevchenko wrote:
> > On Mon, Jun 03, 2024 at 09:55:00AM +0200, Geert Uytterhoeven wrote:
> >> On Mon, Jun 3, 2024 at 4:50=E2=80=AFAM Jeff Johnson <quic_jjohnson@qui=
cinc.com> wrote:
> >>> make allmodconfig && make W=3D1 C=3D1 reports:
> >>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/=
hd44780_common.o
> >>>
> >>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> >>>
> >>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >>
> >> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Pushed to my review and testing queue, thanks!
> >
>
> Hi Andy,
> I see this landed in linux-next, but is not currently in Linus' tree for =
6.11.
> Will you be able to have this pulled during the merge window?
> I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks for reminding us!  I have just sent an auxdisplay PR to Linus,
including your changes, so I hope they end up in his tree soon.

https://lore.kernel.org/all/20240725084741.2519888-1-geert@linux-m68k.org/

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

