Return-Path: <linux-kernel+bounces-561477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6380A61277
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F031714ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55061FF5EB;
	Fri, 14 Mar 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWLvJLro"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48331FF1BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958563; cv=none; b=gZV/1BBV8jdVNOwXvPoRu36NwqM/gndnhuercrItafT5z7Ze3R1GX/73PEQyyI+0gqm0G3tZK70dBPHOcF+B8RDl+Mm/Na68jVOBd887GLq9rE/o8tdAyq3reSAr1jyEqNOWw0E+38UjccEBc6fSodZE2Oh05ziWc/+jM4eBd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958563; c=relaxed/simple;
	bh=T43WpE2mKpI72ELnZYpALkFuYcFiYQUgNQSw5JiJNwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqfErBAut/G/znFp8tuetQlWedGrAjB2vFwCWE+FVLuqKFWm6J2weB0A1RjtOppCSeN6kUhh1Ru0i7OGjW6j8flQvj9LvGtkzLr0iz5c6+Vk6FEzC2wok8TdL1KD0qgVB6twRZOYWXu1D9K2KtKxZ16jWIA2iYEuhovtF1BHmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWLvJLro; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54954fa61c9so2568339e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741958560; x=1742563360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T43WpE2mKpI72ELnZYpALkFuYcFiYQUgNQSw5JiJNwI=;
        b=HWLvJLroj/Swwp0sAGjee2evRKxcU1f3t4sd9VeNToQLCwG5YZjvFdZLrFpuTynuyP
         uD6tHGSLkSx2kfOcu4RuksQp69FExb1oN6ujmfb5UOaBkRQprfi89dCHqUnDiCawDSZh
         8LaiGSIlnpdXfW6lNDVnJKKf7hSAxEucMtGw3oQs5nM0I99DseVfxgsTCWeWKeMw3ySy
         CDLvSAbnQOrt3eZUip/sJ2PDWuQsK7UCNPRi+kTXnNvGvnl60Ula7xCtYooM6w+M9Nx9
         DI7n58ccKz0NrW1PIzHJ9K9IHJWnVj3m1K4AxgbuxLDKhEmx1kyM3jRKC/DqGnBNA27m
         zCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741958560; x=1742563360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T43WpE2mKpI72ELnZYpALkFuYcFiYQUgNQSw5JiJNwI=;
        b=lX0wu58Kq8aTl24QpoLF1dbKUy+eho3xbBbk+h820J79ftPoT8sQRDI4KEbbPhJXkm
         BvWAuzPk+5yTtjPC7TKqkyP5XzqSh6HtpBMRzdzQzXMK6UpDc3uZS4S/R6y+9MWPpOTb
         sNVYpQf5NlagUnlu0izTlFAvVq9JZ0XeZH8vszl+qCxjDnGW9RTlsVplsm8w20OyqsVz
         jdmH6Xt3HQ7xHr95s2ih6nwFCp3spfJJ0Lwj/ys/oLY1n1JMNtk5dGoE6T3aVuyjbsf1
         Ui7ollI7eRpfNtLc0+Ji+ISHYi6h7vkE1c9TT6tL0L9ZjuH7fv0q8Qp5g+dqtPyhRixq
         Vjew==
X-Forwarded-Encrypted: i=1; AJvYcCXhI7mCh2kCr1sDeUkZtjyjqePUTULxzpnJw2zefDEszNErKlYBDc03ryNvKniq5OcCMWktWA9c9K8cKDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxciaAC2ss06PzErmSFfzmBk5gPk7rN1r+mCT9VoxWqfR4hDJRw
	gCxg1/J8ciSLBqiSbP8zN1gWY6aoY4t2GaWSNvQykGqWFvzcp0QK/J7m8K1YXRXAx/zyKzIu0AV
	KlM2q8iPBEEkFwqEYDpF+KJP8Qgo=
X-Gm-Gg: ASbGncssuoMvy1U5rrW7qNhNscSYOPgKvsdEioFp3eXtpH/EgMdK5tNfJhqJFVwD2jC
	fbK5nu/EEzygfI+tKgt7OUcwDwB4guqyEYicmNOLUV4ykzbMGL/iMJ21JB8YyMduj1S3gCzFUpO
	xDYmDlUaE/cZcnJrxVf5MkeWWWSw==
X-Google-Smtp-Source: AGHT+IEkaEFbne5fMuPXZQ2jz13UeoDut1DQHM9ZXHMTo+enu32eEgEj9dHiip7c/bsg/ZjQmTkGacNST+9eRVmoq5Q=
X-Received: by 2002:a05:6512:1392:b0:549:7145:5d24 with SMTP id
 2adb3069b0e04-549c39ae770mr696985e87.46.1741958559488; Fri, 14 Mar 2025
 06:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314093111.654359-1-ubizjak@gmail.com> <20250314112504.GBZ9QSEL1hgjp376ey@fat_crate.local>
In-Reply-To: <20250314112504.GBZ9QSEL1hgjp376ey@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 14 Mar 2025 14:22:45 +0100
X-Gm-Features: AQ5f1JpeA1-9bK5Cu-KGLIij4AI669j3MEp7CHnh9LL8A2Wb7ZF4jAPd5eO3ogY
Message-ID: <CAFULd4bwsZENN5eVLXDDizt6+EcdwgnFBaS4b7YjjqzR-Rmjjw@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in __untagged_addr()
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:25=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Fri, Mar 14, 2025 at 10:30:55AM +0100, Uros Bizjak wrote:
> > Use asm_inline() to instruct the compiler that the size of asm()
> > is the minimum size of one instruction, ignoring how many instructions
> > the compiler thinks it is. ALTERNATIVE macro that expands to several
> > pseudo directives causes instruction length estimate to count
> > more than 20 instructions.
> >
> > bloat-o-meter reports minimal code size increase
>
> If you see an increase and *no* *other* *palpable* improvement, you don't=
 send
> it. It is that simple.

Do you see the removed functions? These are now fully inlined and
optimized in their inlined places. The program does not have to set up
a function call, invoke call/ret insn and create a frame in the called
function. The well tuned compiler heuristics make trade offs between
performance and code growth and it chose it that way. The heuristics
are as good as the data the programmer provides, and choking the
compiler with incorrect data, as provided by asm() interface,
certainly does no good. The asm() code in the patch declares *one*
instruction, not 23. Please count it.

Code size is not the right metric with -O2. It is that simple.

BR,
Uros.

