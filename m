Return-Path: <linux-kernel+bounces-194269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F6B8D392F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42695B25DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167D1586C9;
	Wed, 29 May 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMp7bNM8"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF76157E9E;
	Wed, 29 May 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992925; cv=none; b=lG5Wf64G0OWSa50SYfQph0ZxKeCl8/hzR4dTrdaph6SlPmCJF3id9gNmlgY8W7yn5zCwKb6mEzoV9nO8M/NpvktBaSKi4OAOpdmV6BlCSZ/tHuzuKMo2Cyo9POCs/8SITow4SMieus5c7XsXv3IH1d3qU2qDBDsvGo23aVZyVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992925; c=relaxed/simple;
	bh=HuG35zW4Cif4/8q3V8npkUZQOn+01GHHL+f9PDDz84w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPpSiCjFvmfWP+vYLYap5uXZZVuKt1TeHYF4Ly1w8uN1clnUf+pOET8O525tsNGclFAr1rbQDO2wvROgFtBg5AWqQarT2m55K+i74wouLmo8n7qN9JAmt/iFP7vQbJPhnulCDRxfZmODnX/Bgv3yT1uDzE29b8/DUY9t1hwIJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMp7bNM8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5789733769dso16062a12.1;
        Wed, 29 May 2024 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716992922; x=1717597722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqEY5U9mWqFpY7LFrJzI8LrdDM4tYViPg9IrN0Az+O4=;
        b=NMp7bNM8LTIRb4Y07AieHhdnOZvg7znDuGU5wpVRAjtf2Yinxw+mfjT2vUsgN4EBiC
         HVDpXCitl4PtRMxwkIDzNUp0KrI/kHCfl9ZVU1+BCyEFxczSV1+gGvlAZJmtU5/wj4F7
         bVF4WadP4Pw1csXD9BE3qXSv0DtcsUIdJHh8GwCui++ge5J4agkARhFCq0UX5Np693Dh
         X096P0OCKENHKL0FcOBDUSxcCSgLH+YUbZbyV6oNbJomkRaD5NHlapebsuS+zp3IKe/j
         dGrkjoOSBbZEb72O1pzF9aVsImDTHc5RQBgBOqDARGmQJzQNRvsq/k4yJqSdTKD2majx
         oEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992922; x=1717597722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqEY5U9mWqFpY7LFrJzI8LrdDM4tYViPg9IrN0Az+O4=;
        b=qFWalxigHv6khL/rd2UmmioXHS7SqW5KmZcJWVAXvYdg1pyhf/jtOi89qXyhTFf6lI
         XlHijUGiptVtb54sWG7MNbHwwxhYuZzJ5+n6AAFhsWqC4PMjq68Zyr0EbXPGrNT8WmfH
         p4TZRbdP4gQXfbz1fa086cXhg0tp8G2Z8+/blpzPBp0TIn85akKwnWFnKkGuGym8MrcQ
         1b5gVjeYVL6nG06uz96l9eK+vL+4LfjDwvY4VE0O5MSPcWxU/pcgY++XwumSsaRphj3i
         qxaErQqJyKEJdVBnId1uzaTWP2tztKQRlOTehdiTA91o8ktbCt8q7z45MUU+sfelooc9
         a8+g==
X-Forwarded-Encrypted: i=1; AJvYcCWv84TIn/UVSese9oT28c/BdyLT2YWpW/A+XsnXGm5VpYUox76zIvTJ9t/gc/KJHgmobiUU2LqvaHTBp7lmrKKgprKc4zgLG5UUpDLkOlhFbi3KJAt7bAhG9iLgczcUdyXY0E7DdTdbNnvrft4XYav8qg==
X-Gm-Message-State: AOJu0Ywc3Vf1hmRp56O5+jaBEDb4+XOb/TLNN7eMDL0oX641ZKLI/cii
	rxwS/9j/Gyrdiqd0YNvwGaaoBKEHflTbSLXIWwk5Jqntua/0KLzcg3Gp3amonk0UxLtcKJa/iHO
	lF0RXVvZA9/hXBq53F/loP/5L0ZHyttd5
X-Google-Smtp-Source: AGHT+IH9/qKwYyx5RhmP9F/H4tmfTr5GvPSYrRfdhTUQsmMUkwyQWqdd9fHZEjaf/TWJ6Quvdxzf/Jl/H44quOT9Y3M=
X-Received: by 2002:a17:906:7013:b0:a62:5094:817 with SMTP id
 a640c23a62f3a-a642d37e944mr191016366b.11.1716992921772; Wed, 29 May 2024
 07:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529095009.1895618-1-arnd@kernel.org> <CAHp75VdRuK_sOF=25xP0azp8sOJ8DY_SRpLq9mUSaNEmWj5EAg@mail.gmail.com>
 <436667b5-308a-4a0b-b66e-230667ce0cc3@app.fastmail.com>
In-Reply-To: <436667b5-308a-4a0b-b66e-230667ce0cc3@app.fastmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 17:28:05 +0300
Message-ID: <CAHp75VcVdwxv5Mm3GEv7SmsCiN3ZACpejNb7V_Ld1NBTxcXixQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: int3472: make common part a separate module
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 5:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Wed, May 29, 2024, at 15:41, Andy Shevchenko wrote:
> > On Wed, May 29, 2024 at 12:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:

..

> >>  obj-$(CONFIG_INTEL_SKL_INT3472)                +=3D intel_skl_int3472=
_discrete.o \
> >> -                                          intel_skl_int3472_tps68470.=
o
> >
> >> +                                          intel_skl_int3472_tps68470.=
o \
> >> +                                          intel_skl_int3472_common.o
> >
> > A nit: Can this be put above instead?
>
> I've changed it like this now, is that what you meant?
>
>
> obj-$(CONFIG_INTEL_SKL_INT3472)         +=3D intel_skl_int3472_common.o \
>                                            intel_skl_int3472_discrete.o \
>                                            intel_skl_int3472_tps68470.o \

Without the last trailing \, but yes.

> intel_skl_int3472_common-y      +=3D common.o
> intel_skl_int3472_discrete-y    :=3D discrete.o clk_and_regulator.o led.o
> intel_skl_int3472_tps68470-y    :=3D tps68470.o tps68470_board_data.o

..

> >> +EXPORT_SYMBOL_GPL(skl_int3472_get_sensor_adev_and_name);
> >
> > Are these namespaced?
>
> No, is there any advantage to making them namespaced?

Yes, to clean up the global namespace.

> It's only a few symbols and they have proper prefixes.

It's different from the exported namespace.
The function prefixes are needed due to C language, as we can't have
two functions named the same. The export OTOH is what used for linking
modules and if there is no need to have it exported globally, if, for
example, compiling in this one.

So, can we move to the exported namespace at the same time?

--=20
With Best Regards,
Andy Shevchenko

