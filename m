Return-Path: <linux-kernel+bounces-308571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DA965EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E3F1C24842
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE6190685;
	Fri, 30 Aug 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evNrqpGO"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C017B4F6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013219; cv=none; b=fpQEkG9Xf4g48UyIuFbXciOeBwDpgOL7+tdLr8jPPZxUW5oRtVilv3oE1GiLcGeYQrVN0UtBNUbTFvXaRHDVJH2DKuuQPJyTYTIJDoqL9wnmqTXaUSd+uY4nlB0+Q630dt3qRMj+kSxr6mq4AqYal3PaK6lRgyf3nCHHGK+q9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013219; c=relaxed/simple;
	bh=EesvOEgJSLzRCVBoAr6J7xNkmClMeE/QKFNwAGv/v7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyUpy2CDF9xu+jVcAQJfSkoZB4264CpF4wWmvFUivKpeySxhqq24YzX9V5yyDJ4OEAu4hiGmYinIM5n0oWXGSUR80hnxz+faoicCzxIU9yl2CfPAf4e0IFbq50xQiuA6LxTyt8wPAHbcZtAh3OpOSvStk7Q3qJA4zcYgsQnWh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evNrqpGO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f4f2868710so17209741fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725013216; x=1725618016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXMZ9iiVHTavyTEQK63I/cvAw0zgWeR+ndyAUsvE43U=;
        b=evNrqpGO7spfy8PLDSKRsIQJiVf2NNR+u3XVUkFKoIV6dMo3ko9YF/hSYMcDOxrnK9
         rVksXND4AI0Yc2iptVfDA4mh8XFU0KCMUWWJAhWEWocfzRJQRV17H+s51QY/LevRATXf
         5miNLC6cx8cJPzRrlmT9J6erkSu7ez63Ts0a8BcAXenqcXB6UUgFCW3XmLLsGz432wq0
         BmS+NXyubCTDwlKd5FFsMLwSnM0zrIDHm7Qr/5klV15MUQsOkgoKrBW1lS5u/NQaodlp
         PmBeJXcnnq/QBm/FRSoDgv1jZvvRRgGU5919Skn74Mg/+JuMCrGnZBzzci3U2sOcUpd6
         MMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013216; x=1725618016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXMZ9iiVHTavyTEQK63I/cvAw0zgWeR+ndyAUsvE43U=;
        b=dgVJRp2p6Xw/pPYaooVBysT9oUOjKMN2IDspjiWPVFZO2X0ltWMg1fVQyoqoIlPBQa
         rX0biRkDLe05KOFYrbJobZpQKlSey8NJvtTclKfL8ejuTPDwjXjJBFMmk4J/nH+zWuQD
         BpO0Cb4H9PnYckIi85FTQR21YfGQYgQy2y15SxavQsHaigh79Fq7Jw4CC3WGLBuNk1gf
         zE/8S1ulvaNa4le/K5RRDD6YnDCWKa2ybTdp1Ez+BfzeUD3xQo+m1XrbJpNh6IZ28cCD
         ++PXyvX/mWwDLyQCrtyNiwH40+vaz+pFS3zYzOqlazAfSO0TRW+KGt2dhFdL1+H8QkkM
         Nn3Q==
X-Gm-Message-State: AOJu0YwDw0bT6yQ49HZ099MkbnAGzx5CqTQtUN7pMat0dkOLWFeuQkkW
	3KpmqYDxZsLR4z5FaEMaWV9dOhOMVFqRufSWbQmg3shSSBmKJB2rWq5ClWCeChu+eDS8TSuj3HQ
	AyCkSAfOVdolohC/CKmGnUXuIdz8=
X-Google-Smtp-Source: AGHT+IEhlQy/UzrQtBx+dajC3BS83KtAOAkX5IH8AHxrD+556vL8eDBbh5tFYqPFOdTnELG57EubkLlGkI32PXeRQLY=
X-Received: by 2002:a05:651c:198d:b0:2f1:929b:aef6 with SMTP id
 38308e7fff4ca-2f610923301mr46114241fa.36.1725013215243; Fri, 30 Aug 2024
 03:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830083406.9695-1-ubizjak@gmail.com> <2024083059-crummy-backrest-3b6c@gregkh>
In-Reply-To: <2024083059-crummy-backrest-3b6c@gregkh>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 30 Aug 2024 12:20:02 +0200
Message-ID: <CAFULd4YvkBAQ0xXsTmnp66w_0zjC0q6PBF-NgV_jQSrux6Uhrw@mail.gmail.com>
Subject: Re: [PATCH] devres: Correclty strip percpu address space of
 devm_free_percpu() argument
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:54=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 30, 2024 at 10:33:52AM +0200, Uros Bizjak wrote:
> > devm_free_percpu() calls devres_release() with a pointer in percpu
> > address space. devres_release() expects pointers in the generic address
> > space, so address space needs to be stripped from the argument.
> >
> > When strict percpu address space checks are enabled, then the current
> > direct cast from the percpu address space to the generic address space
> > fails the compilation on x86_64 with:
> >
> > devres.c:1234:32: error: cast to generic address space pointer from dis=
joint =E2=80=98__seg_gs=E2=80=99 address space pointer
> >
> > Add intermediate casts to unsigned long to remove address space of
> > the pointer before casting it to the generic AS, as advised in [1]
> > and [2].
> >
> > Side note: sparse still requires __force, although the documentation
> > [2] allows casts to unsigned long without __force attribute.
> >
> > Found by GCC's named address space checks.
> >
> > There were no changes in the resulting object file.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Na=
med-Address-Spaces
> > [2] https://sparse.docs.kernel.org/en/latest/annotations.html#address-s=
pace-name
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > ---
> >  drivers/base/devres.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index a2ce0ead06a6..2152eec0c135 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -1231,6 +1231,6 @@ void devm_free_percpu(struct device *dev, void __=
percpu *pdata)
> >        * devm_free_pages() does.
> >        */
> >       WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_matc=
h,
> > -                            (__force void *)pdata));
> > +                            (void *)(__force unsigned long)pdata));
> >  }
> >  EXPORT_SYMBOL_GPL(devm_free_percpu);
> > --
> > 2.46.0
> >
>
> What commit id does this fix?

Currently the source compiles and checks OK, so the patch does not fix
any specific commit. The error, mentioned in the commit log will
trigger with future strict percpu address checking patchset [1].

For reference, the last patch touching this line was commit
d7aa44f5a1f8 ("driver core: Cast to (void *) with __force for __percpu
pointer"), but as explained above, it didn't introduce any problem by
itself.

[1] https://lore.kernel.org/lkml/20240812115945.484051-1-ubizjak@gmail.com/

Thanks,
Uros.

