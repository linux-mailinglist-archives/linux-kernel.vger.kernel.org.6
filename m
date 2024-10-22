Return-Path: <linux-kernel+bounces-376666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D209AB49F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B47B23A16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DF11BD03F;
	Tue, 22 Oct 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WcEaW2gi"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3AF1E4A4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616492; cv=none; b=HXJi9KJuypmO0dkNfynlyag7wDHB/204T9J4EEkAkAN/UvKxJoK0RGX7JCmGHIacaWPST4O1bCINcKLowxy/c5MAmX1c1+H9bqndQS+okwnTlyNCz2uw5AM1dbtGqPdTHH49DUJWoG5d2hCa9wrDR7wg/rThbxiA0AmCleB/uEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616492; c=relaxed/simple;
	bh=QGuDeu8Z/KBESjJ3whFWRStG7FOWBcBfqtNWNFItQw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ys+1vjDgrKOcm+VZn4By8QOyhXQC1ksTzE0dyX9xlkQtP7K7nnLOACWZYE3lMBP2YDQ4HXO0LerJzo1cYumB8nyiQIhIR+JVptHqIA18UFVPWs0M0JYprss6tUB1pnlzC/UdI5S0aGOfMxRbcOlFl5RgWqFva/dkdpWrMKuseM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WcEaW2gi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a0c160b94so4591388e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729616488; x=1730221288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu485c5QOL9Uq0W8KFhjSs4H9Jf95wyVtKN5ZwvCgPo=;
        b=WcEaW2gig1Ky8aSBMgykJB1kMGmBvgD5h4YyJGGdRg1GjedgyYTAElpbglmVESQr/d
         MzLm62g+sR7M0PbmEpnChDfXX3npmfEIryj9zwP4MwiT2Te+5j137phQ63AXfxoXa0YT
         /+RrcWnUjYpsNhNJiJDaVqmtO89c+7vBWdzUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616488; x=1730221288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu485c5QOL9Uq0W8KFhjSs4H9Jf95wyVtKN5ZwvCgPo=;
        b=brKjvoiSMLY9PPdg937Et7MsrRvItNy9YsBqdeXcAcSk8qtcak99oKWUjGD/mUjBL0
         gXj97quyK+9296nmmwubAE6GmZ75o/3lo9zXpH+e2R2nxYDUpB3o+wUYhbeX+MslLVG7
         bwVerL+Eo+NpwD98YS5kmdwjUI0StsqCi7+9pzFruwC1G9xa8gAlMl6HfRuiXy4HfETz
         OxkQMx44JStq1yAcxxl5k25ax7/woX/9hV58oFwKtHemFqvwrqdb7DCWrTdCeEfw+KJX
         aolw74qijGzg9uYeOycgqarsUn8Qat0rf+bTmTaCCxBvqfTNLW8RvNlzN/XZul8Yktqj
         WlUg==
X-Forwarded-Encrypted: i=1; AJvYcCVu9VWvUmAQsRdl2IfEn2W7yKsCjxY4i4rkpkDOX6XOrzsqGyZ08akltyWjBe1M7NPEwnXv67jxUOBN3nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqeaUE9zoBXl4CTgfSdcJm/m8SZE9LYv6ivP+5Jt0+eAuzg/8
	yxhLY1qlN5yRu12rZYxcUjgjKiAW6UTe1d246N9fWb2X41izJWH0Idg4Hc4B3wKOU3p8OHEvG5K
	Jgdc3yHJsGfY44g4R/RvM53YeuCqnedEkIg4S
X-Google-Smtp-Source: AGHT+IFk0LVKitzrieTk4+PMmay3cOKMkCi2sdX689/k1/29p+yeo4Qup0q7blMbJZfrxrvdnadXpMVuYG4zN5k7whQ=
X-Received: by 2002:a05:6512:2208:b0:539:8fcd:51f with SMTP id
 2adb3069b0e04-53b1921f298mr148961e87.30.1729616488343; Tue, 22 Oct 2024
 10:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com> <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
 <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
 <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
 <CAFLszTgE+fjXGXFvJ0KWdw=q8CP_53kfWq0nrGZzJzyHJhdHFA@mail.gmail.com> <CALNFmy1P-K6j1q9dm92iJ87h9WnjnvnzwhC1a3jaugahFhv6ZQ@mail.gmail.com>
In-Reply-To: <CALNFmy1P-K6j1q9dm92iJ87h9WnjnvnzwhC1a3jaugahFhv6ZQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:49 +0200
Message-ID: <CAFLszTiWxQjjfg4ydQDEOH2-J0_7O5rYNowFPPJB9w86QY3gXw@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
	linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 22 Oct 2024 at 18:18, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Hi Simon,
> On Tue, Oct 22, 2024 at 2:16=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Peter,
> >
> > On Mon, 21 Oct 2024 at 19:57, Peter Robinson <pbrobinson@gmail.com> wro=
te:
> > >
> > > > > > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other ta=
bles.
> > > > > > >
> > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com=
>
> > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > ---
> > > > > > > Changelog v9:
> > > > > > > - default to BLOBLIST_ALLOC on arm
> > > > > > > - Move default for BLOBLIST_SIZE_RELOC up
> > > > > > > ---
> > > > > > >  common/Kconfig |  2 ++
> > > > > > >  lib/Kconfig    | 15 +++++++++------
> > > > > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > > > > >
> > > > > >
> > > > > > This is fine, but please disable it for snow since it needs the=
 FIXED
> > > > > > option for now.
> > > > >
> > > > > I cannot follow. What needs the FIXED option and what to disable?
> > > > > I run this patch on the CI and test_py_sandbox tests are still wo=
rking.
> > > >
> > > > I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED=
 so
> > > > if you make ALLOC the default you need to change the default for sn=
ow.
> > >
> > > Simon by snow do you mean the device (configs/snow_defconfig) snow, I
> > > think Patrick doesn't know you're referring to what I believe to be a
> > > device config.
> >
> > Oh OK, yes that is what I mean. If it is too confusing I can send a
> > fix-up patch after this series is applied.
> >
> Oh OK, got it.
> I wasn't aware that BLOBLIST is already used on some ARM devices.
> I'll send an updated version.
> Is it possible to migrate those to BLOBLIST_ALLOC? Any reason they
> would use a fixed address?

Not easily, since it puts the table in SRAM. But it would be possible
to migrate snow to use the handle protocol.

Regards,
Simon

