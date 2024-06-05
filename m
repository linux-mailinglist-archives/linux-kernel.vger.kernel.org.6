Return-Path: <linux-kernel+bounces-203376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71238FDA17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19A11F24FB3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8C29AF;
	Wed,  5 Jun 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiaqTXnv"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568E15FA60
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627959; cv=none; b=a0vq7eg6COh8Qi04x+4pHc3g2iPWIQxxzxgyOj2MW9F+XuxlI0aK6G/ViYgqBecxdOVZ/83LN2db86mj7kfWB5Jiwe7lmUB5CFRiIY6aaY4rbT1UHGiGlv3mpJC2ozAndxzyi0QCCnDBXZr83bw9WPvBX2RsmkOGCrTOzlJr3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627959; c=relaxed/simple;
	bh=V5PWI2luSGYjQNAGEHrE7D2sJr+EpkuD0aH+Q2Bo/Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhj6RUyTcJLKa8SMLfwFpud6eNTME0CfQ/1GXTw9PrrD79NMNvMi8RPgYEJZ79gS0QSZKr5kml5QiNT+buB0tdqiF+HNwd15BQ+YuZF9sZ2/Hkke1JK2x9c2T4r0nD5x5Cd7TOGwXiiyELEd49cJxTwtO93wm7/wFgoeKYBPWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiaqTXnv; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df7a1b98a5eso54563276.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717627957; x=1718232757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX9avYazuctYJRBA1bjpEKfWuCleFsVSEM/u63KPMHw=;
        b=fiaqTXnv+yKuN5CwZlO+q+IjYrwEOB9z5pieAEG+7fUcEqTS16WChQSPq2it7xQwdn
         7G69VQc3eVakYCsxcb/2w68e0S+I58slhbcvC+cNCyV9XI1tyV/w7DrH3wmG/0MjK2oV
         6LvLbbt9qAoAFLsPi6LRKS6+n6CUo976vePR1QpwlgMhuRntg26LXTOW+/37gWsNvRlT
         2QMbcj4qCAwT7SO2IC+CwpK+VnrWJEOvKujzt8s5JQde6CAShunywrK6kgQ2icB0L6Wx
         CJefrtvo0za6AiS5OyhRn3h8MCTvcZnLLOVuwoLfcCy9XrLA0t7yYdp9Vyhcqs74r44l
         ke3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627957; x=1718232757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX9avYazuctYJRBA1bjpEKfWuCleFsVSEM/u63KPMHw=;
        b=OzOWV0Mmiu+LSG7UAZcaEpdQ7yJhpn2iA4fMqQEGL7w1skRPzKMoX9UUkLIbE86jpK
         1QsUbknihJq7uVSrEFjT/dyI4mItfZq9hg+kRiFdN2nInTxekwZ6uAewYQowgaY/N6aN
         /6bi/zNyBJxMMH9iAwI5SRlwI2vx4CUI46uPeZtwQA4JPKh9+39G+qI5dOY5Ry925Htm
         OLMpvuV51NrHDFU6imcvIjJrQU1ou9tUuQD3TpKYTZJDl5sFKtN+R9rg9jQlprdW6eV1
         D5Z+TXenCi46DCaSDZlrsheipmYsdcPYDCkxZ9OgSTfaKQ7UBJmPXYfOl8qaI7FwChh/
         /bKw==
X-Forwarded-Encrypted: i=1; AJvYcCXOJ/6sXvLe7z9by2G24wD2uupeEimO/87PsO7e/7OBYJkrPnjjivAg2scJ3qfu7tXNTJKca93NxW2dHJBCA9rkIhFvLUEeIy+HMLHl
X-Gm-Message-State: AOJu0YzwqDv/fg/9sbUfUtTPaW6hYBbTw14NXM1tfVhtP5KnWwQ67n8f
	aOnjhF1lBObhiJaIdJBZiB55RiX8eE67uwxjf4kQydDdPNXiYhWYg2zNDzlg2kHKtkBYekpZlCc
	z6SeKMxPPrZP50kYtiJGa3k8AvLA=
X-Google-Smtp-Source: AGHT+IGy7Wl+MmMN6pkKWThOX2Er0QYkLxUb6OhtqTvonm06MQ1MswM4vauHfObYEHTEPfAob5vmCijyKI9V4fNA3zA=
X-Received: by 2002:a05:690c:289:b0:620:4fc4:4ae4 with SMTP id
 00721157ae682-62cbb62d00emr32187267b3.4.1717627957362; Wed, 05 Jun 2024
 15:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605212840.3227774-1-olvaffe@gmail.com> <ZmDiYze9MEFxn50C@smile.fi.intel.com>
In-Reply-To: <ZmDiYze9MEFxn50C@smile.fi.intel.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 5 Jun 2024 15:52:26 -0700
Message-ID: <CAPaKu7SJ5TVXsqnsqnucpE=wVKwGCdXyCTNBhr+rcJrmLw5GgQ@mail.gmail.com>
Subject: Re: [PATCH v4] resource: add a simple test for walk_iomem_res_desc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Baoquan He <bhe@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:10=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 05, 2024 at 02:28:26PM -0700, Chia-I Wu wrote:
> > This mainly tests that find_next_iomem_res() does not miss resources.
>
> ...
>
> > v2: update subject, use DEFINE_RES_NAMED and hardcoded offsets
> > v3: really hardcode offsets, with 4KB intervals since 0x1000 is easier
> >     to read than 0x400
>
> Right, but...
>
> > v4: use RESOURCE_SIZE_MAX, split allocate_resource and KUNIT_ASSERT_EQ,
> >     and other cosmetic changes
>
> ...
>
> > +     ret =3D allocate_resource(&iomem_resource, &root, 0x100000,
> > +                     0, RESOURCE_SIZE_MAX, 0x100000, NULL, NULL);
>
> Just double check that limits.h is included.
>
> ...
>
> > +     /* build the resource tree */
> > +     res[0] =3D DEFINE_RES_NAMED(root.start + 0x0000, 0x1000, "SYSRAM =
1",
> > +                     IORESOURCE_SYSTEM_RAM);
> > +     res[1] =3D DEFINE_RES_NAMED(root.start + 0x1000, 0x1000, "OTHER",=
 0);
> > +
> > +     res[2] =3D DEFINE_RES_NAMED(root.start + 0x3000, 0x1000, "NESTED"=
, 0);
> > +     res[3] =3D DEFINE_RES_NAMED(root.start + 0x3800, 0x0400, "SYSRAM =
2",
> > +                     IORESOURCE_SYSTEM_RAM);
>
> ...here is overlap with the previous resource.
>
> And here is the gap to the next one, in case we make that overlapping gon=
e.
>
> > +     res[4] =3D DEFINE_RES_NAMED(root.start + 0x4000, 0x1000, "SYSRAM =
3",
> > +                     IORESOURCE_SYSTEM_RAM);
>
> It wasn't the case in previous data. Please, elaborate what's going on he=
re?
The test data is chosen to be

  first interval: a matching resource (res[0])
  second interval: a non-matching resource (res[1])
  third interval: a hole
  fourth interval: a matching resource (res[3]) nested in a
non-matching resource (res[2])
  fifth interval: a matching resource (res[4])

The idea hasn't changed between revisions.

res[3] went from a half of res[2] to a quarter of res[2] in v4.  I
guess it causes confusion if it is not viewed as a nested resource.

>
> ...
>
> And rather sending one version per 12h, take your time and think more abo=
ut
> test data. What are we testing? Are the testing data correct? Shouldn't w=
e also
> have negative test cases?
The current choice of test data covers the most common patterns.  Do
you have other patterns you want to cover?  I am new to the resource
code and that's why I am largely reactive to review feedback.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

