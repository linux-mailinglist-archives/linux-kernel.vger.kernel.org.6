Return-Path: <linux-kernel+bounces-341904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D1E988812
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC171C20F40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD11411E0;
	Fri, 27 Sep 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UssodlJs"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D45149C6D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450291; cv=none; b=ALE2un1lH2PuVscAjjdMupxSrvV0HvupqCbK8F8QkzVrrqU7mtj9so6byUkgtZqdxXrdaPfuXjSzyz+pPZofOzo11FnXPqmErjGH93XWwJVoqtZVRDSKkKMX0Og84yKK04PXla50+u2egRW13XxSO0sZu42tnvLYHZqw9MQEE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450291; c=relaxed/simple;
	bh=3SScFSnuQe1/FEIIg37+hL2l/VXFwiSz3zKaA3JRboI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXRV3DccWcYxKX4kddME+CW6Loia4lVfbQXw5OF0wQMkjWBzeVSwG8TPG/MOJwna3l/vXisPMDibUqZqjfQVX3OvcP+uuB0vdM9fMX6NNgiEkK161KlACY+Sui5awKL/9npgqRz4gk6IpAMP+1o4Jzy3fxyQ5prgKiooCAMgEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UssodlJs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso2523637a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727450289; x=1728055089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SScFSnuQe1/FEIIg37+hL2l/VXFwiSz3zKaA3JRboI=;
        b=UssodlJsW0jP0ji5x+5hbJeJzAN8277K8t6p8IUnNnjC61FeE2dhuvUsDN/CxEGrOO
         /uhThFyw0rfhbrzHXLr2RSfq148ysuzhMbtQLYc1OHT2d9vbggcmuxV9hjcsb1XtQvMm
         PG0C7aZDFbpStiYSRtvAra+wWIWH0ursRznG5EPr8yvvjYDsd85bsjvZA89pCvDG5wVd
         bcBia7oRDHYRNj07lD8CTeCxeDFNko5gJfzVtlbCRVUOPPqOx9rfYeOS/dCzC9aLlwCW
         uS9805iq55DKZ5335Jo+KTzi22ZbNno9Pt9/QMcG6HZxuY47kk/FQEpSORoIsO7frsAq
         3hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727450289; x=1728055089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SScFSnuQe1/FEIIg37+hL2l/VXFwiSz3zKaA3JRboI=;
        b=tnL0LglT4ItDK+tCk3nwT332sBgxBcdYFNDGXY+pTsmy+irhZPHeM3C7CZVCyz7dzP
         Woss5Tdxo5lP6m8BVzM0rlbgiWs9JRCVKTlIt162QAZ7lD8XHGNfBcObHWYKmfYzun2r
         f4SGMy0N8i4eoDMgm8YwQ4GGk5TDNY3HfVt+vay6qa+aIPrCrG1HEjtB7Vja3ysNRS0u
         2VDm2zCDCGEtm78FkvRg/kowah8a1gLJ75e9qpE+OxCiQ+1FSoMDmM4yXiO7Jqas1TRQ
         LTj5XIpAMWCRv8XMIzA3gkh2Eu7JGY9Xy8egM7o25y+MO2HCVhj7qHYqgLxGGXY4qraJ
         YNEg==
X-Forwarded-Encrypted: i=1; AJvYcCXETsTXRt2AJyofomQV6hApvWBmK2OWsdnDQrJciHM8TDwemEOcpWO8SZtxUudABlqf/XPjnggRKvKAIpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zBjjgoFVRIzvrJPnxAqYJz8Q0Ri++rGU9MQfyHCvO/gMuxdy
	3yNszAVjPSPlLi/ZBdGxf0KP28f+iqnuBeFtA0ssiRN6KY2L+fcLvHwTMhdgDahahRGkqoLknuU
	Z3dRDS+E47JWqUGeaLhi7QDHUJqE=
X-Google-Smtp-Source: AGHT+IFF4jzFwyyncN/Gcd8KYVGvRKHxLqpOVkAtttPgMcZJMOGBXawqXWQp70Q2kfc8vVHlPFbO41eS4MAZmwRVFOU=
X-Received: by 2002:a05:6402:35c6:b0:5c5:c4b1:883c with SMTP id
 4fb4d7f45d1cf-5c8824ef708mr2520367a12.4.1727450288449; Fri, 27 Sep 2024
 08:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZfaZGowWPE8kMeTY60n7BCFT2q4+Z2EJ92YB_+7+OUo7Q@mail.gmail.com>
 <20240922145757.986887-1-snovitoll@gmail.com> <CACzwLxg7_HPxbjLT1v+dHG=V0wAcUJYZvqdcdLBD9xhLgNUmqQ@mail.gmail.com>
In-Reply-To: <CACzwLxg7_HPxbjLT1v+dHG=V0wAcUJYZvqdcdLBD9xhLgNUmqQ@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Fri, 27 Sep 2024 20:18:46 +0500
Message-ID: <CACzwLxjpH=n5RDWnQCPZjH8i1GZAAbG-6BzuWCcVf99=qTO7HQ@mail.gmail.com>
Subject: Re: [PATCH v5] mm: x86: instrument __get/__put_kernel_nofault
To: andreyknvl@gmail.com
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, 
	glider@google.com, hpa@zytor.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	ryabinin.a.a@gmail.com, tglx@linutronix.de, vincenzo.frascino@arm.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 11:09=E2=80=AFAM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> Instead of adding KASAN, KCSAN checks per arch macro,
> here is the alternative, generic way with a wrapper.
> I've tested it on x86_64 only, going to test on arm64
> with KASAN_SW_TAGS, KASAN_HW_TAGS if I can do it in qemu,
> and form a new patch for all arch
> and this PATCH v5 for x86 only can be abandoned.
>
> Please let me know if this wrapper is good enough,
> I will see in kasan_test.c how I should use SW/HW_TAG, probably,
> they should be a separate test with
> KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
> ---

Hello,

I've sent a different patch [1] to support all arch checks,
tested on x86_64 and arm64 with SW/HW_TAGS.

This [PATCH v5] for the x86 only can be ignored.

[1] https://lore.kernel.org/linux-mm/20240927151438.2143936-1-snovitoll@gma=
il.com/T/#u

