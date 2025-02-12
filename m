Return-Path: <linux-kernel+bounces-511078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC712A32583
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4703A6850
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4092820B20A;
	Wed, 12 Feb 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Och21hfR"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C462063E5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361558; cv=none; b=VuDEM2mqGNOo3NVNq0pv9ctJc1ODj09seTb2+rY0xx70ObTSy117ajiPasDFA7Mg172gbrYsrlYZNlxFFVanWKMKkmZb6apMhRi7WPGv29JN/XJ8/3iNh73QDomxXbGkEA8gaNXxSXHyC9pPvI1vM8DLlQyup6AHFxZb7f1heI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361558; c=relaxed/simple;
	bh=JPt+xC4eyv+WQHyNcmq0S8J7JpIxDT7l8ZQI8yLkBps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQFFYv9ttatssVJSGacM7JsbM8T6WRe5KrO/5XBiBbz63pIIwmZB3JfCgn0R3/UCWiytAzsJ6Lvng1yKGKMj0ulBEMIjJ2UOO0doNoYYsmOoqTZcEDq928vVNPcNhnNfGtezBxzRzvFD48ESIGg2zVg6R0/pGU76KtJ6teCCbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Och21hfR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dccc838deso349901f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739361555; x=1739966355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eSl5YfX4v8OgkeO1jdSOmTgQstGlkukMTg9/pwP0Ps=;
        b=Och21hfRXmoRGTsw6wnUptjva2ETk70/2unrQudDCicEzFmTUqFC6Lx1XPrPWADnVj
         SrPALFAYq0QhAyzvuLcQUwRxGBklLUTQxifWwV2U0RLo5TPftMaQQ4GgvIkCBzQp37Nm
         YClgJ/djIH2mIgd+SLM9KLYdv98uSBNUs637iJwTaY4AM/8yhUee40Cl/ihIhb9ysXih
         8rrIibSuTYBqrc7hnpjPXjdf1xvrrjmmR4g+v+7hipGe2Kg/YK4HkRCEWyvOj2Sl5udq
         foP2TmAg7tozkl6+SBTOMCt7Xl4dVNbWYTucK8cTsb5tpMrr/+ArB0IaAFHtQWA5/Tn7
         FKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739361555; x=1739966355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eSl5YfX4v8OgkeO1jdSOmTgQstGlkukMTg9/pwP0Ps=;
        b=wLKrio/9ed9OSfPtc2NW/0Qt04dLf7Sd8n7JMSBOK+iVZx5rnoMb6RUiTQF2zs+IWe
         YvVb+4g0ZwEaT+GZdBYZdqQXKHFu2hIGfFaz99LTMMqX3mORvAGZ6hcCGGUaJq0Vxf//
         lQqw2JNghZ//wWty//mYHp1zriFZKKHIz6GGYmJZOYWyL27xkH46DPGokD70ycGCf2R4
         mbT4ZoZij2IsAiE3lEXvWiVQBeRG/LVedMkhL9t3oTbS73T34CvO7h/0TPXp1JsnpivW
         HRWht8RiJug7pAJIeN0XcGt2t24wMuTX3l0LV8BtHl2zIQi9h47gBMp7UyI414Yo0UNx
         eMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOvWGbFTbFqjF80wtgB4oFvp+jplrhllJKRDRg7vR2xMXbruROULbu5MAqRyoqgklW2ySsOP8/R7XCaeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzytfbS7oG2r5bZcZQSkFJRzE6aK8RTypr2XifJKNkNW9xQQHDo
	G2nPoeR4gR0CiuSm7m9Z5GZYTwBdi2tMc8FLY3pzMFLYUXgeVwk8Md1f6CnE+lyJzsejNseledp
	+hBstzxT2YmeoiJO9bbR1UTxzrIc=
X-Gm-Gg: ASbGnctibpK0Zy4WOd/teuUT3/Qtiia90vtP5sF1IXaMUAUqNPkEH+xkY/3dmJIpmqP
	+rQrRNM1sxhlhdOz8AySsfQE5YVdcRFtj844AgLdNM37Cj+h/q9DUFIcODeHSkDZP/xGYMigMzb
	97bpUtumv9Bn9iwTkR3Lba237EedI=
X-Google-Smtp-Source: AGHT+IG3fmHz2E+6aMtRT6NZtv0M4VNelZBA1J0TIg1co0vQFmeR6ifavyyfyKBLbGkyrmm4MYHT38YxPlA2+orv6kk=
X-Received: by 2002:a5d:64e4:0:b0:38d:be5e:b2a7 with SMTP id
 ffacd0b85a97d-38dea2e98e7mr967564f8f.10.1739361555145; Wed, 12 Feb 2025
 03:59:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211160750.1301353-1-longman@redhat.com>
In-Reply-To: <20250211160750.1301353-1-longman@redhat.com>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Wed, 12 Feb 2025 12:59:01 +0100
X-Gm-Features: AWEUYZnaqmNFQ_lbBc6EZt7NZdSpHvlmvNFB56VaHucCrwmsBCcCq_pnMuQNjtc
Message-ID: <CAPAsAGzk4h3B-LNQdedrk=2aRbPoOJeVv_tQF2QPgzwwUvirEw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <longman@redhat.com>
Cc: Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:08=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3fe77a360f1c..e1ee687966aa 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -398,9 +398,20 @@ static void print_address_description(void *addr, u8=
 tag,
>                 pr_err("\n");
>         }
>
> -       if (is_vmalloc_addr(addr)) {
> -               struct vm_struct *va =3D find_vm_area(addr);
> +       if (!is_vmalloc_addr(addr))
> +               goto print_page;
>
> +       /*
> +        * RT kernel cannot call find_vm_area() in atomic context.
> +        * For !RT kernel, prevent spinlock_t inside raw_spinlock_t warni=
ng
> +        * by raising wait-type to WAIT_SLEEP.
> +        */
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEE=
P);
> +               struct vm_struct *va;
> +
> +               lock_map_acquire_try(&vmalloc_map);
> +               va =3D find_vm_area(addr);

Can we hide all this logic behind some function like
kasan_find_vm_area() which would return NULL for -rt?

>                 if (va) {
>                         pr_err("The buggy address belongs to the virtual =
mapping at\n"
>                                " [%px, %px) created by:\n"
> @@ -410,8 +421,13 @@ static void print_address_description(void *addr, u8=
 tag,
>
>                         page =3D vmalloc_to_page(addr);

Or does vmalloc_to_page() secretly take  some lock somewhere so we
need to guard it with this 'vmalloc_map' too?
So my suggestion above wouldn't be enough, if that's the case.

>                 }
> +               lock_map_release(&vmalloc_map);
> +       } else {
> +               pr_err("The buggy address %px belongs to a vmalloc virtua=
l mapping\n",
> +                       addr);
>         }
>

