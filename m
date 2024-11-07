Return-Path: <linux-kernel+bounces-399767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B0F9C03EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185A71F2345E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D661F583B;
	Thu,  7 Nov 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htyDoRRC"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A41D86ED
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978841; cv=none; b=i02Kbhwu4jrvhjrw6TszM5r/cu2tgtBAFuPE04+I0yKYPR8+UmX9cwqL6n1Plbv/5g5o0psvm1YNTHXDkAWdMDoIzmypQhtwlVunkUoNPeFe/n5vKK4HIJiYbc8W8ybBjUkfatcPCksa3WidVnNgjo12pE112eai3+4JMd84Dcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978841; c=relaxed/simple;
	bh=0OZWaiQn9AWmIiwX8FekiaJfurR682XuYrycumSEHFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMj2LVY8ajK48ObXBqWy0NQSO1GnbkvHYj8eh6OQnIh2MHy8SCftMCFYLbK4PLA3fP8utgWev8NttfyDOIk+Ddub34ScyOCVvTS793Edmn+4JricfHJdPVmQPa8e14Rj7/9elNOcu5V5EXldYBxZlGrEEfJJXpe80xR/hurq9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htyDoRRC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e63c8678so842817e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730978838; x=1731583638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vB57gwkL6EOjqLzPnsjwgyWlaMdSWrhLg+efjo7rzY=;
        b=htyDoRRCebKVT6his0n/zC5nBRRyWi4hTFF55vT5Kg6cdKo9T0cx4rniqRjOVsb4rk
         9DHk9f9psgTdj/nfmBpPKgDkYGz5cwRUrnLK9KDgZu/elDoCSYzuQ7KY5pOaImT0YjCm
         8p/auniw7sgTGExFekK27y3LRIy6NHsvVNbKscOc9hA3k9nHNvwVf7UrYJfLVTm4tlr8
         z/F7hNJb/QNEa7W4zlargRZasq4kUpFiER1iSK6ABHu++XLM9IYDixxZ4XkWYEYlhvBs
         xp7lsNaM7+6oNkXrUfHjo4LEhWrfxMtBI2wIYizWR2HtSC3UhVB3W6VKHDDOlEMXGP3u
         UomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978838; x=1731583638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vB57gwkL6EOjqLzPnsjwgyWlaMdSWrhLg+efjo7rzY=;
        b=bxa4oJShfF0vkn0gmgYh2YQqq01bycBTCU3E4M2SM7SobMj9VqA1rzMm3GGVtNCnUW
         4HdbIRlzCr5b2ZhTVQB8IlXVpjxQi9WUB4XjYx9sk4n5uRPNxKGY2lXkqi/gZNHFb16N
         jG/o8gmQ/njm/11GFPOmsF8In491vPVNKafG1/tkQJTMuTDAfpFZlzEijZWykQWAlgNp
         o5nhsLqo8XGTBKngSzNEd5ge0ExB2SAH4sBBGlQgkvGSUiWDBPaRaErhazFqtE3eESnz
         lC2MHlwrhKOPOIRFd7tcyU5MRvcK1e2OykCCSrSzXw4wfHrXHGQa0dlUJCRRoMwpVKKZ
         k5Ig==
X-Gm-Message-State: AOJu0YxdQTsx/eFDEh5oXT9JdKVNl4ObrTy95SVsi7ljO7zvjETEVpXM
	xgV3NO9ha+P6zpC9XDDN+U9N9ek5f3lRGbAQBjuw8iglVT0xtQAm/0AkNL2Xh8W6+mqtHQUBHcE
	wIqEJH38KbT+8JubLS351JgdyDZiV
X-Google-Smtp-Source: AGHT+IGl9qb6yhjltoN7aBw75zPq44wVl7vXtuiiiqm0lSoOCFuX2ppdSWcGQd+i8zUusm6f9zsiIPpo5h1msMxctsA=
X-Received: by 2002:a05:6512:39d1:b0:539:8b02:8f1d with SMTP id
 2adb3069b0e04-53d65df2a2fmr12016421e87.30.1730978837944; Thu, 07 Nov 2024
 03:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-7-brgerst@gmail.com>
 <CAFULd4b9RqWD5uaZEzejQfzJ4cH85sCgbTaHJdg-qJ-OaLJiWA@mail.gmail.com>
In-Reply-To: <CAFULd4b9RqWD5uaZEzejQfzJ4cH85sCgbTaHJdg-qJ-OaLJiWA@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 7 Nov 2024 06:27:06 -0500
Message-ID: <CAMzpN2i6MM27Pb+82rPN8FuBn4B7HZOZdaPdP2eNRS9FJZ-GGw@mail.gmail.com>
Subject: Re: [PATCH v5 06/16] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:20=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wr=
ote:
> >
> > Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining th=
e
> > stack protector location.  Treat them as another type of PC-relative
> > relocation.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/x86/tools/relocs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> > index 6afe2e5e9102..7d7fc7f0a250 100644
> > --- a/arch/x86/tools/relocs.c
> > +++ b/arch/x86/tools/relocs.c
> > @@ -32,6 +32,11 @@ static struct relocs         relocs32;
> >  static struct relocs           relocs32neg;
> >  static struct relocs           relocs64;
> >  # define FMT PRIu64
> > +
> > +#ifndef R_X86_64_REX_GOTPCRELX
> > +#define R_X86_64_REX_GOTPCRELX 42
> > +#endif
>
> The next patch (7/16) introduces the above definition to
> arch/x86/include/asm/elf.h. If you swap patches 6 and 7 in the series,
> you won't have to introduce the above conditional definition.
>
> Uros.

This is a userspace tool, so it's using the build host libc headers.

--
Brian Gerst

