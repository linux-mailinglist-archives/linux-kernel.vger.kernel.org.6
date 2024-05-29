Return-Path: <linux-kernel+bounces-194184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39028D3810
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117F41C23F68
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719C182D8;
	Wed, 29 May 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdsZ50HZ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6EFBF6;
	Wed, 29 May 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990133; cv=none; b=oPQkyCzirAH9vHep0iJ6rqFq/gB36V+aVeKPldltUfNZyX+jWsJ/4NDVr09Tr71J4+K7lXVp9HBaswdIDgFK8Ti5vK/++wQOKumruGDlWmdrlK9wRam+LsJ6cxD83hMEhczOxVyj9c7LNy0wX8jG6QK5mfELEAGjACx35h0zuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990133; c=relaxed/simple;
	bh=CS76i+zGV1UVewLcKzHnXIl9od9YiR4aRukKmEAMMdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBjy8x+5detHALVWNpqpsNzIO7jI9NhblvmTK3yGMERCU0TEcu2cqDAcIBpxnC087cb9CpfxUqcHp3mKzq7oTbVwSqPWpQ1081VkVNe8PKXoCxFJkCCTFykFUiLyQhdIBw4r9+tl7D9el2x39rxSbZoTeMmy1uiv5HzAMqu110M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdsZ50HZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a653972487fso58237466b.1;
        Wed, 29 May 2024 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716990130; x=1717594930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmwaHNB5h7Bb1aKSr3REWrUKJJZAZf4lqZlbFLDlq0w=;
        b=ZdsZ50HZVKQzSqzCw+bJTgglxoyZjpFvJtT5iSIuFOTbnDJRaWYwsfNv7s7kiIi8n2
         2sSQkv8UyicUA32Q3P0aUhBoj0DZGVGbN99ALjlXCEQGgvTBgi1ofJmTTrVqkiaZ6QqB
         njN2y84M9kdEKXcbpGH0Q54QTf7tDMtTqxuyiv8Y5aKf3hoVnHTI1rTBunjsLGE8+nPY
         YayovVMPlhI4etE1jvPmn2PbPuzCmGP17F6ZoscNOXqf9WNOgx4FnJyEk16JzSmeH13U
         qg8JH+e2Fj6c7KhwpwKFbFMxixZXw6WbhhwFiKlFz4gEac7v45ITdOP89FburfX9Z+za
         qWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716990130; x=1717594930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmwaHNB5h7Bb1aKSr3REWrUKJJZAZf4lqZlbFLDlq0w=;
        b=F/UnIxGYkY6ES0eS8FgGstxf6L8ZN6d/FoHL9ZLr+F+TkSwfWGOPW9AzV58ns0hVFb
         1pa3BJF1HvgyAxLyZqzlcTXUDuh4UY7zY+DcvFNZrDzrx7gPMgQiqD8fLoAKJN80i+uz
         NcfNp5VtXhz5fwSmtSG1MGqXKB+ufhoFGP3n7vW77IvIeNkLnqOJhCmvIj8HjSKy6631
         b+oiJtAJTcFyWV70CgQmn7ij//2fUc389m/XdK1zxZ2FYvbSU8hQXYnhAVah3ta+VvP7
         Yn/7zdvnXHEKGl+qWdI9zN5nqoMWqqBxHKulHGk1HdqWK53Tt06ENPPvokC9V/wwg72i
         huWg==
X-Forwarded-Encrypted: i=1; AJvYcCUnCaXfKj2MR+nm/WvlkyBEyhI7UXaux317AQDnb1qHoqyMPSUXCsFv9Eto/ZIWssE/VkaosAdThOADQKUnv+j2TtzqhN63foHhWy1rZjzbFll3PDnIaKInVHwrOjK9GNB8B0mmAKmYPZBMmPTI4tAjEw==
X-Gm-Message-State: AOJu0YzIS+gVMaLC1qHhWn3Gulhu4xTTZHBl/QqbCI/djkPbeS5tppAh
	5hoT40gGeObYnNT0CwvLyWGTP6/EfJ28s9Nc8kTdDytd1g+jkF35Bpx5Ab/2C2NC1wtDhpRHT/a
	aooa0kW3xtXNZQpveaVWgkPd5SWc=
X-Google-Smtp-Source: AGHT+IGyT1xiDyONKn4viXOJrmtwX33X8kyHCmc0QVNUQaLs3+KaZjHo/Ev1t4Pz/wx/IaDLqacKsYQe9XD5XiEgZ1Y=
X-Received: by 2002:a17:906:3d72:b0:a62:e4d:8666 with SMTP id
 a640c23a62f3a-a62642ec2f3mr1008888966b.28.1716990130304; Wed, 29 May 2024
 06:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529095009.1895618-1-arnd@kernel.org>
In-Reply-To: <20240529095009.1895618-1-arnd@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 16:41:34 +0300
Message-ID: <CAHp75VdRuK_sOF=25xP0azp8sOJ8DY_SRpLq9mUSaNEmWj5EAg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: int3472: make common part a separate module
To: Arnd Bergmann <arnd@kernel.org>
Cc: Daniel Scally <djrscally@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Linking an object file into multiple modules is not supported
> and causes a W=3D1 warning:
>
> scripts/Makefile.build:236: drivers/platform/x86/intel/int3472/Makefile: =
common.o is added to multiple modules: intel_skl_int3472_discrete intel_skl=
_int3472_tps68470
>
> Split out the common part here into a separate module to make it
> more reliable.

..

>  obj-$(CONFIG_INTEL_SKL_INT3472)                +=3D intel_skl_int3472_di=
screte.o \
> -                                          intel_skl_int3472_tps68470.o

> +                                          intel_skl_int3472_tps68470.o \
> +                                          intel_skl_int3472_common.o

A nit: Can this be put above instead?

..

> +EXPORT_SYMBOL_GPL(skl_int3472_get_sensor_adev_and_name);

Are these namespaced?

--=20
With Best Regards,
Andy Shevchenko

