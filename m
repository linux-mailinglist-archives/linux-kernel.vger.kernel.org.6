Return-Path: <linux-kernel+bounces-294495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44948958E51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B0BB22F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460DA1547F7;
	Tue, 20 Aug 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ldO+kBAn"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755601537A2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180023; cv=none; b=C3Gi7xQMg6Bei5xLKQp9PFHYt5EHXx/7M1VJSWRuS5zActfTeP0cpNCAnkiTFHPaasnWPNx6vTy/NbJmkFHUtnGWBiAQrw0ck9v3N9J55yhOzvDdErb02UtHYWOPjmhX4/XTPnIQHwaOoU4Kk+Hydxc/px/kK2gp8MEa0G2x9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180023; c=relaxed/simple;
	bh=Q2U6jltiiNaK+JNKXKBVgR+Xb/Bhf/4VdjQFQy+dZ9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8XjJDOAPFa9Y8RMKu0+Dc+o5k8mLrQUFUW95Me2KEW2bsFEPbd1mmXkZj5RteACCLRRfiK51r9taLtlOrVy/1FrNrlr2EiuoB4KuPbo6/iQ/qUXEFBCB/YVs9FxXpj+vlXPlfbGeA2xDgEkCUjmDBQKbJ5C7ffgm2YZnWPkHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ldO+kBAn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53345dcd377so868844e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724180019; x=1724784819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlTLMLs7In8/gOHrNjsLpOQwDWaLLP6ewH5dG/aMvH0=;
        b=ldO+kBAnLYJSj81DchJcTCILRdSpTTwbpvy2z+1WHWwlQXNWBjMNHe06NYo8y2k8Y6
         H4kVYQAK4cUZvBmf5ADNOQD+KrzjzuMq8rOT8zX7YjvrxIRa5W3RzAomUSdhvlqOOEN7
         AHrSEAE3RYdsnyoyYjH2K874LuqqFq2Z3dnplMj2hpwzRPm+CVzkegoI791KMhFFnLEi
         5VIuz5M0MKBF5eChi1Fy0D9C0cLEz/QwuGzHnioZdJfz5V9MHjmfEDd4MNHb9v77PiwA
         ryFZ9boLbR8VV9NvSCt/Hwb6NfrYK7Ym8P5WvcrOhxm7sNdfVw0wviYNA/dDFxFpgF37
         dQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724180019; x=1724784819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlTLMLs7In8/gOHrNjsLpOQwDWaLLP6ewH5dG/aMvH0=;
        b=tArFf56RQJJHYeQuz17Onpxjaox3xe34E5HNbFY/jos+hIYiKFY3q7HZHLRxVRxXiz
         hCW/D3yP1B7sAcTQrih3pI2/E/RcChWrD0CVy4/nd9dIZMHyn5fE2mhR6DEvX1yhVMVe
         8NpA0yNh+KOB1f2EF7i1XkKrsn6eJ2TUJGLZ08NLD8UTNhHZ2zyNgq9lllECRmzRLHH5
         g7U6xm50/NQVidgL1rS0Ee+gEWEdHD6I+fOZ5z4leafSQAKNWnsNCrMKk/Fu81FHEIOW
         1H48jkopgoQVh7aNn1iilAPsIW+LI9sSa/cbFxpuAG8flC7OGOm9vxHmbe3CEAqEwNuc
         14nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVCLjqJePXuvNpgJtZNymUy+oulifM1JTwnLuMvquSp0s3pItdymvgm0dV4pcGN/00kG7DW+/PM9PE1fU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mkTslkpduRUIFmDYSyFtKjyveMM8v8XsgNqhy9HZqOhp4bIB
	tccrMUadPunL7HDDfyxiTF7KHgNC8My2gIlnSjoKh3WjMm/pgVuFt1Xg5eLLIqX3pyNZWTXjUwd
	Ci90QdFXlM9VhXcgt3RonYteW4HxLF3gB454qu2BPGrAn1THnwMo=
X-Google-Smtp-Source: AGHT+IEDXYmnOcAXEgHI+T1DxDx1Io5reHaoh1XIPDPaSvNR3Qz2IYQiyr3/KRaoVuRTo4UR8HZi7b1wzjYn3J3QPqU=
X-Received: by 2002:a05:6512:2511:b0:533:4689:973c with SMTP id
 2adb3069b0e04-533468998b6mr434610e87.23.1724180018746; Tue, 20 Aug 2024
 11:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820153855.75412-1-brgl@bgdev.pl> <87cym3f447.fsf@trenco.lwn.net>
In-Reply-To: <87cym3f447.fsf@trenco.lwn.net>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Aug 2024 20:53:27 +0200
Message-ID: <CAMRc=MeGew-iHFmeKuKqDfDPZtjCfdNXzOzj56=qxssGP90SzQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add a driver API doc for the power
 sequencing subsystem
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:20=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe what the subsystem does, how the consumers and providers work
> > and add API reference generated from kerneldocs.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  Documentation/driver-api/index.rst  |  1 +
> >  Documentation/driver-api/pwrseq.rst | 98 +++++++++++++++++++++++++++++
> >  MAINTAINERS                         |  1 +
> >  3 files changed, 100 insertions(+)
> >  create mode 100644 Documentation/driver-api/pwrseq.rst
>
> Thanks for this ... just one quick nit...
>
> > +The consumer API is aimed to be as simple as possible. The driver inte=
rested in
> > +getting a descriptor from the power sequencer should call :c:func:`pwr=
seq_get()`
> > +and specify the name of the target it wants to reach in the sequence a=
fter
> > +calling :c:func:`pwrseq_power_up()`. The descriptor can be released by=
 calling
> > +:c:func:`pwrseq_put()` and the consumer can request the powering down =
of its
> > +target with :c:func:`pwrseq_power_off()`. Note that there is no guaran=
tee that
> > +:c:func:`pwrseq_power_off()` will have any effect as there may be mult=
iple users
> > +of the underlying resources who may keep them active.
>
> There is no need to use :c:func: here; just say function() and the Right
> Things will just magically happen.

Am I getting that right, are all these :c:func: directives useless in
this file or only in this paragraph?

Bart

