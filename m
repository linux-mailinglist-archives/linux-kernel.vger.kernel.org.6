Return-Path: <linux-kernel+bounces-385472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8579B3796
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BDF281B90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E41DF278;
	Mon, 28 Oct 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pliwsATn"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C211DD533
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136221; cv=none; b=ffIWKBCIdEPm9xQ7cnZc5UU7nAKC1JZr2NpCGxrwTncOAD0cEzTGppUpJADNDvmzeH7gKWFA5SIvZmM35IpzmIA5xQJuNTEFH1Wee/G0HAAsi9Fho9hVRPMRgYhkQogeA15KIz6UO5Bh9MailHHbWLKgqmx2n61jtnDxkVP3aOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136221; c=relaxed/simple;
	bh=BgoGY13/0A9hg+yn9ilgipvRMLg4bgsrT2lMBaCPQsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQpbZ9NOVNLcgefQ8QaA2s6lBMHrNa68jvQRALqTvBtspI1mcLbHI2bg6QIzN2WbTFA8WWagtPayzpcR6cjBCoEG1tKmVFrT3UYqHB4KwlXZzqI4+uBy07WHVKZCbREKVx9qtJu1xOAeh8RAX64pWx02YbO/52uVopBP3U9Rsqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pliwsATn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e681ba70so1535e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730136217; x=1730741017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgoGY13/0A9hg+yn9ilgipvRMLg4bgsrT2lMBaCPQsM=;
        b=pliwsATnvQo9W46kei15vq1haGMjlI3nGAotlHrlsiIt8fdNQqsYFe3tOM6tixcxtb
         ZHoFfpr9Hj7L4ZzUuWBS3cCA9JXYRWpv23ycmKFeqppmjTF8qr6A6o/ZIt8Qtdc0s688
         ll1lb6vxQ24WQ8DOnBI8oFvchN1ZfmO4jF2Z6WijAduqSwtxP0URp5/X+niVCZk4Ny0K
         NEqzasAXbC6gkpeonUIVOanI8AzkofAjvPta1ENIGsDeB9LYR6uYZ/zhhGTOkcdkvBuU
         vgSQ9RBRitHO17iMieVQI9oVOhGzRVXIHPZHpHIwZ2qMy+Oh31ZdhUbnBdQZo9X1ZjmP
         88cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136217; x=1730741017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgoGY13/0A9hg+yn9ilgipvRMLg4bgsrT2lMBaCPQsM=;
        b=eKD/xpXPkkulOEhhjB4KTrlFHSWB0aGRSQMTG1UrImKWGnCuytnY62XQdJc6zfJTEX
         YiQy34Mu8CYWnalvccAo/qMEtIrlCsg5c/bu1uIgarnaV0KAdsn4scLkW2xckp/UDGuZ
         JOPCgU6rEuVsn+SI/nDQiHCYim1SPda5/z05c2pcIjNg7aTxPrIfjdH0QRiUaiSZy24f
         mtvKC4eYacG75bdeW1iAFBiKH8H0YS1UCByc7aJvALFcW29RpZ6fIyai3zj4RaDLaiQj
         Znm6wqPhgEtDhOsGvID1qW/TgMRiVL1S9NECjbqVCTf6yYRPHTbMqf6uPAOMIzFyvG4d
         2OUg==
X-Forwarded-Encrypted: i=1; AJvYcCXWzHp1xBgJ3nHD5a3qMz3bcVDuYNQcv6mCJZ37wWCdgNz3TNoH07nmRxiZufhCElIaOY5ncLgEcUO9oYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLuQH8+1yfpfudTwsoTrwkblRXv3zIYGRlVHp+4IfCjE7Qunr
	RWONPRgKtg2F1KZyEv7e3bzQ6jB+jJYQzalDWdCQyh6b/rMUBperQkKlqPkTmlQNq1D8DtzT+Cq
	tlqBnSmzAe7l6R4N5/TPVQWBWoVxeXKV66QTT5Rj06d5Y0Lwlh+oe
X-Google-Smtp-Source: AGHT+IGE/0PVwPVSEY3Y9J6zjY8sqDS5x9M/SZVk5DXxZEOmDhpQLbE3pqhER4neGQ641EaQZaWsr/irY8P39SGvI9U=
X-Received: by 2002:a05:6512:1188:b0:539:d0c4:5b53 with SMTP id
 2adb3069b0e04-53b348e3700mr369451e87.4.1730136216904; Mon, 28 Oct 2024
 10:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410281414.c351044e-oliver.sang@intel.com> <CAH5fLggdtev=scJ1C9EefZf-fVrMvgMbfD+b_T5vFfHqNTn8Kw@mail.gmail.com>
 <CABCJKudR2UwvR8x4MwKYPmHETMz+aoiXEXz135BoufTF9Pt2Gg@mail.gmail.com> <CAH5fLghwEGCAxCR+OifGYh3jKK4jJqa-AX3gMUdN0HETBNBkYg@mail.gmail.com>
In-Reply-To: <CAH5fLghwEGCAxCR+OifGYh3jKK4jJqa-AX3gMUdN0HETBNBkYg@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 28 Oct 2024 10:22:58 -0700
Message-ID: <CABCJKufypN0c6EwiexQufjxMss-Y_fYdp+2XdpXU=4mmf2ZYgg@mail.gmail.com>
Subject: Re: [linus:master] [cfi] 8b8ca9c25f: CFI_failure_at_do_basic_setup
To: Alice Ryhl <aliceryhl@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:18=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Oct 28, 2024 at 4:15=E2=80=AFPM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 1:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > Hmm. This config has:
> > >
> > > CONFIG_CLANG_VERSION=3D190102
> > >
> > > Sami, is the fix not available as of llvm 19?
> >
> > Looks like llvmorg-19.1.2 doesn't have the fix, which means it won't
> > be available until LLVM 20. :/
>
> It's not going to land in a patch release of llvm 19?

It won't land to 19.x automatically, but I requested a backport:
https://github.com/llvm/llvm-project/pull/113938

Sami

