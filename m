Return-Path: <linux-kernel+bounces-336708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059AA983FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359871C2274C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D85126C15;
	Tue, 24 Sep 2024 07:48:19 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBA2110E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164099; cv=none; b=UmcwxRCbfsGcBP8yGIh9AKpGIKKbkMMQwayM+FrpcVenGYF2tbQa8j6cmqVPRT7hF/n9XMxVilMuOE0YR3ic1YtG6SMEwDOeN8m6qWkmEwchIh+ND9H0bQSNfOAoVSgeBebfYFnYFHIO/uwcJdcn7nMJhl0bkri1WAvL8wRmdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164099; c=relaxed/simple;
	bh=GzfUliITS/AjWBFNXjODAUX2WTzfl9ZmwrLuuODou7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqS/CoaPR6GWFaiuhsTXIUMJYF/KI+f13fSAgnjCp4TMpvCaL3LoovDgC2YMowuGSLWhYEx+KsA9LbMDqgm5G+dH5MK33nh+ARWesZTSOI7Pz9ZdLFhgDhvDH9VFFSAlBUBLhIUnc6Fh6NZNyjLGc2GA8P0Rd1Fr5vDTl+wte18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ddccc408e1so37447527b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727164095; x=1727768895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEEBRQ0kzptclnZPUjTzc9Doy6RNjA1649RxwSFTkiI=;
        b=MdODnF8L0NSsDCrWRSZLMbAMMdLqNuZu487x5lVYH5Ix/9WHu4dUhFnn6LdBAcCgwl
         NKiBQKKoqa0cvLsIweoSPBLtwQC8M6FXTfjI8tFrIBYMmQS5IeeAefmqViUtWX4855Ts
         s44zvNob6iXn1f9LHFjdsTqcnMbm2zJuqTc8+zh5G7tSxbdxfe2zW2NxAYaJ5cX+2dGY
         v0N56nS8RySoZS00ozosjz7GgGgac20sATFZwgF7vrUCf93ogtcmP6PTvOykGqU/Rp+D
         rybX6AcMhfebkMfu2+eGabvo5nEe+dpdzBSjsEfXMK1CuVZZQ9U1BHApbY94otS8/4MW
         wS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTmIr3zlXnqLm1ceFS/5cKEUWtR3Ezxxq+I+pAuwviEj6FnqJeMMjBw77kp3v6IvM01099mjC/D93q830=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBV+LyIQMinj74LrpKjRQDKutPeYRyXLSvM3+7GQtlI3RevKqe
	YCgApYnSjVTseaK86YcRHtuZtBuE8UhrtUfQRmNa0Wej087RC7BSZJYiZhIb
X-Google-Smtp-Source: AGHT+IFTVW5T8s9JyReWDytnGRFyQ6IGjTsMuIDax/ejSVaix6Xvqt4Sp2IM3xAYHoyxyzZhKuuZBg==
X-Received: by 2002:a05:690c:4487:b0:6dc:45f9:fba6 with SMTP id 00721157ae682-6dfeed330famr83351687b3.17.1727164095313;
        Tue, 24 Sep 2024 00:48:15 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d039cd8sm1670957b3.30.2024.09.24.00.48.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:48:14 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e129c01b04so15220247b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:48:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMkoJB00HAx6R/8Da2yyclwCOisVDWK7KQfYBVrGE2YRZkfhmUOa4DLFBFNkBm6f2MeU0e2KxbYVxo2F4=@vger.kernel.org
X-Received: by 2002:a05:690c:700f:b0:6db:ce60:4f8e with SMTP id
 00721157ae682-6dfeed617f3mr115603067b3.22.1727164094228; Tue, 24 Sep 2024
 00:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923235617.1584056-1-linux@roeck-us.net> <aa23abe3-7236-4b9e-b237-3b822ac9d186@redhat.com>
In-Reply-To: <aa23abe3-7236-4b9e-b237-3b822ac9d186@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Sep 2024 09:48:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEfPtwps0A29WvHcwgo3f+3nTBiGn1PFxoYy1dxPsUMA@mail.gmail.com>
Message-ID: <CAMuHMdVEfPtwps0A29WvHcwgo3f+3nTBiGn1PFxoYy1dxPsUMA@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: Define NR_CPUS
To: David Hildenbrand <david@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Sep 24, 2024 at 9:34=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
> On 24.09.24 01:56, Guenter Roeck wrote:
> > v2: Instead of trying to make SPLIT_PTE_PTLOCKS depend on the
> >      existence of NR_CPUS, define NR_CPUS for m68k.
>
> Okay, looks like we're cleaning up CONFIG_NR_CPUS for good.
>
> I'm back from conference travel tomorrow; I'll then throw in the followin=
g
> into cross compilers and fixup any other arch that needs attention:
>
>
> diff --git a/include/linux/threads.h b/include/linux/threads.h
> index 1674a471b0b4..e31715e6746b 100644
> --- a/include/linux/threads.h
> +++ b/include/linux/threads.h
> @@ -13,8 +13,7 @@
>    * bit of memory.  Use nr_cpu_ids instead of this except for static bit=
maps.
>    */
>   #ifndef CONFIG_NR_CPUS
> -/* FIXME: This should be fixed in the arch's Kconfig */
> -#define CONFIG_NR_CPUS 1
> +#error "CONFIG_NR_CPUS not defined"
>   #endif
>
>   /* Places which use this should consider cpumask_var_t. */

This is gonna trigger on almost all architectures if CONFIG_SMP=3Dn.

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

