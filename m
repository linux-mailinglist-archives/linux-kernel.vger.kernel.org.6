Return-Path: <linux-kernel+bounces-335199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4A97E27E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350FA281364
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA8B28366;
	Sun, 22 Sep 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LBIRjcZM"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5761C695
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022904; cv=none; b=o2eZ+MTDh/stf9KSa9DBvfQaPQAJucxbwFj2o/KYz65HHq1TdkyzgCaeBEer5ARyycB/oz6eqDLWbxvbJ0sYDdWinwTClR54narSJjiyNGL7nHFbvoQgBWKKZasYNpJVvJBy8zm6vxOJRHpVm1YN0z7C+ojnNQABLGhgHbqkoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022904; c=relaxed/simple;
	bh=1YPOfHesH5RVdRJUP5Wt8b62Owi5WSCj403l9mws6B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoT+VGeAwY7B6SEl0tJ7dlOgamem8jJ60ML8gLzoXkYc7WAL1rZvW/BzPwzaHN8315/CLmfvPShJTVjFMHALtTHeF9lIOKpWm6FQQ50PfTf0ec/YrCETcdYZPqiNTpc46zMEmR0uyG0B9LVNjT2KwaW6xMSTZd3IfWrr7vu+pW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LBIRjcZM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so528079966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727022901; x=1727627701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYdVIYLjBwZlAOZe7nqVykViMDFKAIlIkbyf3hUinq0=;
        b=LBIRjcZMWKXxO/lHPEI2VtAXjR2bTflL64qD6mToW5C77xzbyXz7cfQh5m8dT5GkKf
         bHj4SkAqnGpdsKx/DjEMjW9+xlkTM0LHIHZFgS5X+5dfAugftDY3LLb603ceKbQmRRVD
         pPnbMUAKcsa/vNXtXGqUuwY96/qYtVk4r7M9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727022901; x=1727627701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYdVIYLjBwZlAOZe7nqVykViMDFKAIlIkbyf3hUinq0=;
        b=W1VhHrkvuz27xl2hgjZsC9GBqQL1jVo8e/sfMgpnV6miPZ66zgh201rKQIL5jnZ69C
         ZsCejhlppJSaTNx9w4SUFjrvs8miS8cONmcDrdq+AzJiVggmugXim/8r/gBXZl25UbhD
         mLxPMjMqzaWqSR6l5I5LcDmGLsaKctQi8O+HGA6OhWA+CQtu01eRoyb2po7VEzfls8Rj
         spFmh0s93S/6DKpTkafo8Qss9AGT+wfUMixKeGXwq+qREQgTXRTEtTivEYuN4S8dB6RZ
         WMRfo0HlKlzQYo0CZh0XzJeFUQY32RJ27y+fFUebSFutla0+YL70hvkU4EMRdSqLRPZD
         iFvg==
X-Forwarded-Encrypted: i=1; AJvYcCUFB77UN98SHaj+nsY+/bF46jFme43D4KV7v5bOFmfDpsfecdxkf7om+DxLepbLvlGYTFrx2KVsFOJ2GH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzBsq0CBryzhuec9B2asJFpXkbqXjQYd5ic59yotlQMv5xgQr
	6b4eORpsQV/0EZN3vfCpoMYE5zHc5HSKLehTO3sbdkyLVmy3ghgSRLXlG504RiGstWRUNtiAjem
	+/D0=
X-Google-Smtp-Source: AGHT+IHz5Jif2tYUPyKn7QD2gzDSQKN8AFOFmWe61Lb71gq/htfavLazVCDsMlgAsv6UXhU4BEB0ZA==
X-Received: by 2002:a17:907:3f9f:b0:a80:f6a0:9c3c with SMTP id a640c23a62f3a-a90d4e31709mr939281366b.0.1727022901060;
        Sun, 22 Sep 2024 09:35:01 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3fcesm1100889366b.133.2024.09.22.09.34.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 09:35:00 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so475767866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:34:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeT6FH9F0TMeWp7Xje/VDEFjXK8OenxsKUOjwqzXGhtyfPA1CxRVF2KWmWVSInd3COffk8UfHo2phqnOc=@vger.kernel.org
X-Received: by 2002:a17:907:9444:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a90d4fdec7dmr1048951666b.13.1727022899627; Sun, 22 Sep 2024
 09:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920023317.f20c9ecbb2a2f4bf382d831c@linux-foundation.org> <CAMuHMdW-4_WvazciLPedP6R6XnEnHqsEh+3s7M5159zcmHit9w@mail.gmail.com>
In-Reply-To: <CAMuHMdW-4_WvazciLPedP6R6XnEnHqsEh+3s7M5159zcmHit9w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Sep 2024 09:34:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUiO3qUVR6ydhGjby3yf_KQO5+m7Hfb4H09kXXPogZ7g@mail.gmail.com>
Message-ID: <CAHk-=wjUiO3qUVR6ydhGjby3yf_KQO5+m7Hfb4H09kXXPogZ7g@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.12-rc1
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Huang Ying <ying.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Sept 2024 at 02:32, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>
>     kernel/resource.c: In function =E2=80=98gfr_start=E2=80=99:
>     ./include/linux/minmax.h:93:30: error: conversion from =E2=80=98long =
long
> unsigned int=E2=80=99 to =E2=80=98resource_size_t=E2=80=99 {aka =E2=80=98=
unsigned int=E2=80=99} changes value
> from =E2=80=9818446744073709551615=E2=80=99 to =E2=80=984294967295=E2=80=
=99 [-Werror=3Doverflow]
>
> Due to
>
>     #define PHYSMEM_END  (-1ULL)
>
> not being correct on 32-bit without LPAE.

Hmm. Can you check if making it be

      #define PHYSMEM_END  ((phys_addr_t)-1)

fixes things for you?

That said, it would probably be even better if we got rid of these
games entirely, and m68k just defined MAX_PHYSMEM_BITS instead. Maybe
as a config option, since I assume it's going to be either 24 or 32
depending on CPU (or are there other choices? I used to know the old
m68k, but...)

                Linus

