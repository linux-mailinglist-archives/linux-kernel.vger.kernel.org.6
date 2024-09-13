Return-Path: <linux-kernel+bounces-327534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208E977738
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E7B23B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C41D2F7F;
	Fri, 13 Sep 2024 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5JhBZdU"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EF1B12CC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197263; cv=none; b=g7Jh8OWrX3O0lv9H+/pj/aWWCKYd2J0d4JDZeguoVXnBF47xTEaaCuuSqvsCH/00OsN/VzuQmEaZWq0rx5pjzgRGi6JmZvlpYc8zSFvBN2SWscoAAIZdWBtGrFWxHmRFGmib8uZBlH+AOFAc3Eh8gCeL9IgpAiPNGYV/PBEV5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197263; c=relaxed/simple;
	bh=5BChQmZR9pQtxWJQ7KzWQcTI7/c3mxzUoONylUUGkho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsnTpsBO6ZIscyIICV9ooIzVNRaF5pZOdd8QaGApBP/bYk0oThoUCYTAApWDok0WAaO9NZ7r1Kxae+5WoOvZBpkJOsriX2cffdyyuSCPDZdV8+XVQuGB5WolM2J91p8E7opGgaR/Z195T4ajm59by6HL19HYUX9PsX9fSBVlaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5JhBZdU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so134525ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726197261; x=1726802061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BChQmZR9pQtxWJQ7KzWQcTI7/c3mxzUoONylUUGkho=;
        b=f5JhBZdUNjVTAd/CfCT5NZWTF66m8kAprkpGd2f/jtntNRbmKgObjQupMalRquLaAH
         hpj0qa7S+DBPBFzUfQ7LeSQV47BXTX63tQeJfnUgY+HnsUwN/5aUIvpTUhOUl2Fue2l2
         YgWkbnIYj8R6SUDusblB/pXKKtQ6eKQ1ubZ3e8WsKDVJrhPZ8h38jF5InRRQnH/vHrib
         Po6iMUkgPiiC/LuK+Zx/jc7yzqbgDr04W6fVjRHroi8JDId3jxk/0ZHUmjqX0AXcZ6oJ
         M5EckRemqk5I2KPGwGLjdFuDnYBNDdHTRPpaRubCptIndsgrJBCdpZQSl7ZY2zCKM55S
         SkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726197261; x=1726802061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BChQmZR9pQtxWJQ7KzWQcTI7/c3mxzUoONylUUGkho=;
        b=bc0W0Dm/PEOMyAMfQGf9FL8tdSkOgrhE4yDU4h3AYnsA4Ld7Dosy6zpIz34eMSucne
         NrgNaCHssWySeo9/YUAsZ+EN1CJSV6ryKylCs8aVFjdVaMl7ad052/fUuybb8fYjyKGB
         egswI2Cr0OajEHKlx1DL+dDIAyGUwR0RfVHP+Kk0s1dDXj4dHhJqFIVaORuVB1eMbZHE
         hJN/+6tO+VtUgnNd72ADVyD0LjP8SL/f0Rp9cPR42a6jX3tqNIJZDTJOBRMDVu6C05sH
         wew5R+Rlh/fjlZsUFT73T9JxAtUW1ZeiNnY2nGsQGpViV+R+R556CML9OXHJoFZjcIST
         P9/w==
X-Forwarded-Encrypted: i=1; AJvYcCXFlXUbeVb0cA1i7BxLJBMjmpAUZCrraChMEHnx2+Bq196LdrQPzQ4aCSnDXyWi9MCpDcq4l74peuyjspM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpcSDvli+6NNQqRp5fVHC6AbYofCbOtfQ73w7ApVm2KsSgVvg
	unnhSpi3aJGUS+sUc57U3VkzdREgcH5WLWQOVYPoRgb6aRtqo0x3KPWlD4jbv6OjPFshnXL1hsO
	zCVN+RPmckP3MUsUHlgk3af9XXp9lYEMRk1k039ETxc3XedIVv8YJu6CaVw==
X-Google-Smtp-Source: AGHT+IEkxgqPsNKDnds/eVtEysPWvXFKKgL74eRXd23NGUL72xMyWQkoPszPRpk08gepJWlb8EHEze3Z/SeEv8+HjdA=
X-Received: by 2002:a05:6e02:1d1a:b0:39d:2555:aa3e with SMTP id
 e9e14a558f8ab-3a0856cc931mr6139495ab.17.1726197260479; Thu, 12 Sep 2024
 20:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913125302.0a06b4c7@canb.auug.org.au> <20240912200543.2d5ff757@kernel.org>
In-Reply-To: <20240912200543.2d5ff757@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 20:14:06 -0700
Message-ID: <CAHS8izN0uCbZXqcfCRwL6is6tggt=KZCYyheka4CLBskqhAiog@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, David Miller <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 8:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 13 Sep 2024 12:53:02 +1000 Stephen Rothwell wrote:
> > /home/sfr/next/tmp/ccuSzwiR.s: Assembler messages:
> > /home/sfr/next/tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is=
 not a multiple of 4)
> > make[5]: *** [/home/sfr/next/next/scripts/Makefile.build:229: net/core/=
page_pool.o] Error 1
>
> Ugh, bad times for networking, I just "fixed" the HSR one a few hours
> ago. Any idea what line of code this is? I'm dusting off my powerpc
> build but the error is somewhat enigmatic.

FWIW I couldn't reproduce this with these steps on top of
net-next/main (devmem TCP is there):

make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu- ppc64_defconfig
make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu- -j80

(build succeeds)

What am I doing wrong?

--
Thanks,
Mina

