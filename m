Return-Path: <linux-kernel+bounces-213666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A33907882
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BC81C23D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8E149C47;
	Thu, 13 Jun 2024 16:43:00 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AD130A46
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296979; cv=none; b=lIPkvs/T6jPDDRybLfyS2omHoglKdSZiiMPHVCCixy88HjZg65bRJKyxirDwHEXB8/HQArpjjnWV/XtTjGSXh2cYtuyU5OJ67tgm77JNpFyTnalJrgCIoIUmvyDP/ZCqbPQ1ZMuF/EKcOYVYqAgwWlmAwId6NKrSi6J3IMGuoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296979; c=relaxed/simple;
	bh=fdR+HOux0l7slfjVf480YuwNVlVxXAAoX1BpgPIeqh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfWaJTPnhxofIfFmacRm1YKKlMkmtYbwiTXsMlgOsVEwlR27KCi8Z0KJcjHvm52x20jUA8FSlwgepLjHtBfHBMymNqeRHLGDXslUXfPPlSexEFJnhV3v5sztWXZvRlN8QTDBrsIT0h6U9M7HIykkJHMbPPOgCbBZUy2T009uh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a0849f8e5so13246687b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296974; x=1718901774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7eDnx/cZDpbixJmVjvIErbIrnZeY3Xb1qwzBjK+wtI=;
        b=jibTxUWf9gbjyEtOvOGQ2G7tvh35gugK4sT+D4Lh2o+q+4fFBftJaH0iNUbGda9Nye
         W9nJT9JCUL1DfPunMb5L+2th1Xx1bW6hLn0S03T7EJKHY5LrTftK/IfSnBiPU7u6+2Wv
         aYFqk+H1IMP1MGaC/IwCx1Yw9+98URrDt2geQljPBz8ITFV7I3qFHHtSMmRTZMIZTM6T
         b+S4h/Y930OcpXX5gtKU/qwKAkweSJnJboTlShtKcAEN8gziv+FOpVXsNFBGiUyc3BUg
         F7BXRKt56pmEA7MqQZ2gM++6kBja/mUv6vIeF53nVEOkraMSILOizuqFMdlHAc0xM76Q
         K9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe+oHKjf7QsqAUMc5K7no8izGvvkDo/EjMoRulTMeSyjYcHpGd+6PrqeYI6G+SEBB4JdtNZ9hz44onZQ8yad0mIwo4LQEUgvQXndWL
X-Gm-Message-State: AOJu0Yys7r/+R7rnAF3ZwkBJdRzMJ8o5tFustiBWpWoXm1iRBdw/Tbq2
	YRxBndeZJT6pifWWhDSpKNaxhez/8lCF4sqKV6jvJABcIXMqQYML8EGrt2X4
X-Google-Smtp-Source: AGHT+IEn07g8Tj/OlFMQwKuoKgS2aoCKtPwBeljYrkvab+mU31GyP/9OxgkUo9Ha7rx87dyaGxCPfQ==
X-Received: by 2002:a25:2686:0:b0:dfa:94c4:72db with SMTP id 3f1490d57ef6-dff150de489mr59974276.0.1718296973510;
        Thu, 13 Jun 2024 09:42:53 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff0475defasm245359276.8.2024.06.13.09.42.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 09:42:53 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-63097363e63so14014207b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:42:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnz0tX3ADtleY3gpD6G0tuZbFHI3vwpLQSiJOIBnbEMQkS8lPH9c2OnbY+eRzTZq3TpjTWv7zxifNkQtaAvbSlo8l0rl1cpUUKD7+1
X-Received: by 2002:a0d:f447:0:b0:61a:e2e4:454d with SMTP id
 00721157ae682-62fbc5dacc4mr50619227b3.45.1718296971533; Thu, 13 Jun 2024
 09:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121203009.9257-1-ansuelsmth@gmail.com> <20240121203009.9257-2-ansuelsmth@gmail.com>
In-Reply-To: <20240121203009.9257-2-ansuelsmth@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Jun 2024 18:42:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0dpQdZSCJGuOM0MgM3N-8OA29skARvXEkm87eOPEWBA@mail.gmail.com>
Message-ID: <CAMuHMdX0dpQdZSCJGuOM0MgM3N-8OA29skARvXEkm87eOPEWBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: decompressor: support memory start validation
 for appended DTB
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Eric DeVolder <eric.devolder@oracle.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 9:30=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
> There is currently a problem with a very specific sets of kernel config
> and AUTO_ZRELADDR.
>
> For the most common case AUTO_ZRELADDR check the PC register and
> calculate the start of the physical memory. Then fdt_check_mem_start is
> called to make sure the detected value makes sense by comparing it with
> what is present in DTB in the memory nodes and if additional fixup are
> required with the use of linux,usable-memory-range in the chosen node to
> hardcode usable memory range in case some reserved space needs to be
> addressed. With the help of this function the right address is
> calculated and the kernel correctly decompress and loads.
>
> Things starts to become problematic when in the mix,
> CONFIG_ARM_APPENDED_DTB is used. This is a particular kernel config is
> used when legacy systems doesn't support passing a DTB directly and a
> DTB is appended at the end of the image.
>
> In such case, fdt_check_mem_start is skipped in AUTO_ZRELADDR iteration
> as the appended DTB can be augumented later with ATAGS passed from the
> bootloader (if CONFIG_ARM_ATAG_DTB_COMPAT is enabled).
>
> The main problem and what this patch address is the fact that
> fdt_check_mem_start is never called later when the appended DTB is
> augumented, hence any fixup and validation is not done making AUTO_ZRELAD=
DR
> detection inconsistent and most of the time wrong.
>
> Add support in head.S for this by checking if AUTO_ZRELADDR is enabled
> and calling fdt_check_mem_start with the appended DTB and the augumented
> values permitting legacy device to provide info in DTB instead of
> disabling AUTO_ZRELADDR and hardcoding the physical address offsets.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I have been including this series in my local tree for a few months,
and so far no regressions on any of the Renesas ARM32 platforms
I regularly test on.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

