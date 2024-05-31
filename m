Return-Path: <linux-kernel+bounces-196459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58518D5C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C651B25F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475D81205;
	Fri, 31 May 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddDFW6VK"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E155C29
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143415; cv=none; b=LhElpyLgANOGrejlh0VL7TjCTDqI9aVGvqPhpQ4NVLxFjG+KTcv2n3j1vVGoU8elPEqK0cpbLiSIWkY1wbvjSoYjV6JkPYaogbibVRJxGGLyqdodKJILRIJwBzNZu3VNxMHaXKsS25/GpR+bsLEnbGgwQk1O6IIkNOAUz6TPqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143415; c=relaxed/simple;
	bh=YMgL3lre7I/OlyfjMxvG6CeEGZbm3rTJAWtPmeIjhfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CC+L5cWfxbiFksBaVIIg2C1kcy+6Bq7ZtKz1VPKxT39A+cp7dGEIGgV9x0XdrHSQ5Zs3v9hfKM/OBdSLvmoscDkQQaAQZcetP8ibc5lgEP2aQ+3PMylm003jA78+Upn677Q3wj0RkmJttQfjFGberHzV75QCFkK29u2IiODuCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddDFW6VK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6267778b3aso143368866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717143412; x=1717748212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNEH1JZguieMQsD5WSBVsL/nrC2J/payU/YAff//+5I=;
        b=ddDFW6VKsAF4vRPcI4dWSwi8OJj5bl2z2heAxPcQ+Pmblv5gT9hRSIG28e4h+e+kEp
         zlntwSegViQZ0mmIsLxcD/vc/yzhEBiuV0Ja6u3SxjkuNrcewX8+xWkZQZRWm6/9DQ8f
         TGf7MfUcfH3DikTLyd6nvkzOGJSXnSUoXjTWA2wOVWd2qtwV9lVcmHogQOcG/VwGDaqy
         jR86q/SO+CL3Svm79F234Kif5H0kZGGIfmqR73fuXf/aaEbc/iA6RuhczN9LEbsoSd74
         OmeBmFdjCfK2rTr/Cd0utzcHCjrjhH5YKD5SrwtAtEXVthX0c6Vb7nq5GP9fOf5nNkjc
         TvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717143412; x=1717748212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNEH1JZguieMQsD5WSBVsL/nrC2J/payU/YAff//+5I=;
        b=CmuRJmMTurYekMipD8fu9B6tCoS6Qdv/aArtBjRaWZeXkgVxR/MW+XJLYxtoFsUwwP
         vaSUiYSB3RD4PNwgp5PkR3JX12FKOhOtyXVZeyxILNIiha4dc1liX+piBj5UCz7qTq6w
         kRMTT6eCcZO2T4JNGzM+96qD/Bj9eKejjFnFjNXyycvW+x32eJgGgRyriKVYnaM/2OF5
         agPnYXWKDRaOs3N1vDOSc0mCHEF07DcCv1f3Lq+AtwgxOOD8MvtwEzo+wl3llnoR112B
         UOTiy9ZSXq90RRALLHQCvYNLyUQUkLYq1lJbU9sIvrUfNflKRooLrouOfnamGNn9kEP1
         zOHA==
X-Forwarded-Encrypted: i=1; AJvYcCWLFA5MMmKfUbxnqXhM07R1qxdiK6I4/JFkNLs/Fn67GI0qQBr7BOPncwP9XLbz9wQCAXrdRki78rzfgDbfK68igWNOfJZWW9M+FQs5
X-Gm-Message-State: AOJu0YwkT944mUvjhnzNZbdowKREEGl5SdQPoZhs8l9jx+QEdrZ03JpF
	/zBvAP2ORbFbVBc+aiGyVFc4QNveRFjwsqyx9HVh5ymJBMUBkFwBSD9mVZe2sI6j7RXow098tkO
	Xu5pbf7+tqvLZ5RnFQSCzr3jtr3o=
X-Google-Smtp-Source: AGHT+IEaGEeTCXunXlypoEBmu+yFF3gi33ufGOYRlAmzHKk8V7P8Es1lMvS4VmhYBh5FD20HZq4VCY0wm8zoAB4BX1k=
X-Received: by 2002:a17:907:75c6:b0:a68:8e98:1d92 with SMTP id
 a640c23a62f3a-a688e981e44mr4642766b.37.1717143412076; Fri, 31 May 2024
 01:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz> <CAMuHMdXGJxwRDRjKQT5aa6off9nQ5WqreK9K-QhJwhUXngYA=Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXGJxwRDRjKQT5aa6off9nQ5WqreK9K-QhJwhUXngYA=Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 31 May 2024 11:16:15 +0300
Message-ID: <CAHp75Ve3-JkNUuF_LT=E53WfEfxt5yizSvoD22a3OvHiPXSRJQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot message
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andy@kernel.org, tzimmermann@suse.de, 
	ojeda@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:45=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, May 31, 2024 at 7:28=E2=80=AFAM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> > Like we do for charlcd, allow the configuration of the initial message
> > on line-display devices.

..

> > +#ifndef CONFIG_PANEL_BOOT_MESSAGE
> >  #include <generated/utsrelease.h>
> > +#endif
>
> The #ifndef/#endif is not really needed.

It's needed to avoid unnecessary build of the module (in case of m).



> As I see no real deficiencies:
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

I believe you agree with leaving ifdeffery above.

--=20
With Best Regards,
Andy Shevchenko

