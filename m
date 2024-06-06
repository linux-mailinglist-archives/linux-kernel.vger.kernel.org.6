Return-Path: <linux-kernel+bounces-203464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E478FDB96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AF1C2325A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBE4748F;
	Thu,  6 Jun 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaZqeNHq"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFF646
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634539; cv=none; b=b/zxkT33H2+bFF6xD+OJ8X1Rhjw/AwPD3wjYroHrK5gmwX0OFEWxoVfxqsgkdjfmurKUM74/R2d3+SEtnTOFdnL7joeC3ccfMJFV9v/1IaCgo2na93jUU6ogL6utsmtiUu/IPZ1yPa2dTccrcmFaIMZUcqH3CwhixEvL2AYc3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634539; c=relaxed/simple;
	bh=H97UUkxz43bfwlw7MPZnzFwcHWU9V5Gq9lHVpnzJ0L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIIAeU/iR6o24NQkULc5SXewsEhPeDV6F9FNOoEqSL+TCyGhIqv4CDNCq3FmIHL9s8cTWBLIZ4r4aJdXfL+mRUm5cL1xavu5sJ+xIm9OOWeoo4nxwAMGAUFs2RWyqlvF/40HCG1v/EjFU2jJmqkSxhZIUlD0hJzBCg7UbVK8wII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaZqeNHq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a087c0638so416897b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717634537; x=1718239337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRHWIqKrogA88n9Tkj9zJquUR76xLrOnJBRrvpKpqgM=;
        b=OaZqeNHq0CeyRSWNx47YyC5Wjoj7T0yHkfnwoZjswUg28ilurEIE+F7Ap7DnbPaKPH
         AhwsStgJblTuEOOVi2RW3TMWVBjy2Ye5GLTyR3gxobbvqcUguzYsAQsaoWK1A+3iJlSy
         dqCAhM5Qdu7jaA4r1qbhqOnwv3F5jO+wE05G27nA5WSHt6gNOSMElf1aQOmMY15oP3oI
         gEjtpwqDuvOPQk7Cerzllqu2ArLneQnosgx80I7uAYY4CED2MSkd/6AC9eDzWcJ7J9z8
         BzFaWhCQrS60jtLf9DNESJiVVP4nQvfIjsn9Zx052eECWMbycADFnww0KT5lcXM9aAQl
         pWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717634537; x=1718239337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRHWIqKrogA88n9Tkj9zJquUR76xLrOnJBRrvpKpqgM=;
        b=RjKl5osfBxSQti+kdKFcx5jqwy+pz2RFPGh3uODA56Wg+jcobKgrn/8SUUrYb5iVAH
         ouCUw8clbbinnMGt4GV+zSCuPzGNxPlbSshn+Iy9lQ/RTRbWwSByHV77IJMqDdt6nYKS
         66ZKozqegfw2pNjzPpODJPL6fuQF13BnKSJ+NqbFvKgLi07+hIM4wDlLZ7Hq7zyK9TRG
         6BpvTEQP31hIYW7aUmHA06dI8dAjzbRvbfbKg4dujoTtIXvCZxT5Hnb6USg0IS6WosE5
         F5W2IekmxFy6R+iuzZoF+l6Y8QX44x9b9/WCf7N8qfcKRaHGT/dXoTxY36omx6SBtzyL
         19Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWAJHS0VHjiMq7bBAHO1fqep4L7gqGbYejpSXgsWZfqCaFctdZMvJhXLxDIzWf6oNtW/GKBytVxuB5jCwFK9Vzc9zN6NdF9gr3z4sfF
X-Gm-Message-State: AOJu0Yw0n/EoQT9Lo25AOYqXS0BRkYJHpDpIhY98rd/pNRT1UadATWtv
	z5IGEI2uDPK+ALWtZ+JioAinDZrMRNN9icqT0sUIvoxHlPNm9WvtMrdrQUDLZ0d9WB//WUD8BZo
	GbSvyRpHDxDb+fcYxqY1zC1m7OPA=
X-Google-Smtp-Source: AGHT+IGG+yEl6GsG8Q10ABwlODJbh7Jvv2CPe2zzEg+R2wJ2Rik4Z8buKvpbpjKi64bV6lL8IUuC3qw9R8ZDeM45M00=
X-Received: by 2002:a05:690c:660c:b0:627:a25d:6e76 with SMTP id
 00721157ae682-62cbb4c9685mr40711377b3.2.1717634536103; Wed, 05 Jun 2024
 17:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605212840.3227774-1-olvaffe@gmail.com> <ZmDiYze9MEFxn50C@smile.fi.intel.com>
 <CAPaKu7SJ5TVXsqnsqnucpE=wVKwGCdXyCTNBhr+rcJrmLw5GgQ@mail.gmail.com> <ZmD2c0rNz10KsPA0@smile.fi.intel.com>
In-Reply-To: <ZmD2c0rNz10KsPA0@smile.fi.intel.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 5 Jun 2024 17:42:05 -0700
Message-ID: <CAPaKu7Rt_wn4nycc=2hr6N6X77vDqyvFbkgrBeEzfmY3nEaong@mail.gmail.com>
Subject: Re: [PATCH v4] resource: add a simple test for walk_iomem_res_desc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Baoquan He <bhe@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 05, 2024 at 03:52:26PM -0700, Chia-I Wu wrote:
> > On Wed, Jun 5, 2024 at 3:10=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Jun 05, 2024 at 02:28:26PM -0700, Chia-I Wu wrote:
> > > > This mainly tests that find_next_iomem_res() does not miss resource=
s.
>
> ...
>
> > > > +     /* build the resource tree */
> > > > +     res[0] =3D DEFINE_RES_NAMED(root.start + 0x0000, 0x1000, "SYS=
RAM 1",
> > > > +                     IORESOURCE_SYSTEM_RAM);
> > > > +     res[1] =3D DEFINE_RES_NAMED(root.start + 0x1000, 0x1000, "OTH=
ER", 0);
> > > > +
> > > > +     res[2] =3D DEFINE_RES_NAMED(root.start + 0x3000, 0x1000, "NES=
TED", 0);
> > > > +     res[3] =3D DEFINE_RES_NAMED(root.start + 0x3800, 0x0400, "SYS=
RAM 2",
> > > > +                     IORESOURCE_SYSTEM_RAM);
> > >
> > > ...here is overlap with the previous resource.
> > >
> > > And here is the gap to the next one, in case we make that overlapping=
 gone.
> > >
> > > > +     res[4] =3D DEFINE_RES_NAMED(root.start + 0x4000, 0x1000, "SYS=
RAM 3",
> > > > +                     IORESOURCE_SYSTEM_RAM);
> > >
> > > It wasn't the case in previous data. Please, elaborate what's going o=
n here?
> > The test data is chosen to be
> >
> >   first interval: a matching resource (res[0])
> >   second interval: a non-matching resource (res[1])
> >   third interval: a hole
> >   fourth interval: a matching resource (res[3]) nested in a
> > non-matching resource (res[2])
> >   fifth interval: a matching resource (res[4])
> >
> > The idea hasn't changed between revisions.
> >
> > res[3] went from a half of res[2] to a quarter of res[2] in v4.  I
> > guess it causes confusion if it is not viewed as a nested resource.
>
> Okay, so far it's correct data from testing p.o.v.
>
> Maybe you can add a comment on top explaining this layout?
Done in v5.  I also added negative tests for all holes in the test
data.  Hope it's better now.

>
> ...
>
> > > And rather sending one version per 12h, take your time and think more=
 about
> > > test data. What are we testing? Are the testing data correct? Shouldn=
't we also
> > > have negative test cases?
> > The current choice of test data covers the most common patterns.  Do
> > you have other patterns you want to cover?  I am new to the resource
> > code and that's why I am largely reactive to review feedback.
>
> Nope, seems okay to have what is there for the starter. Later on we might=
 add
> more if required. Just got confused.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

