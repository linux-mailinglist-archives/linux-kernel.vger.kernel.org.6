Return-Path: <linux-kernel+bounces-241574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CA7927CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F8C1C2306A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E839FC1;
	Thu,  4 Jul 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bt+/fCxV"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3344C7B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115768; cv=none; b=EU1xRoopDmarG0sQnR1V3CU1U5x4vzFRFqUla5HS5K+BTjVbxv0PH3y94HHtn/CUKGGNE8jEOHrYbytvkRtKaXrG8EJt6SzytnHJAP4yj3jvO35m3cWZRhBTe+YqjRsx+hAMdBheL1vML8ZwIQPrXlSYJUiKKg7iPlWHECk9rhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115768; c=relaxed/simple;
	bh=m0ZDtft++kJCmQfRkagmS+67G506QwBeypxZAKNB0sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/iFH4rx1ogady0MzbE0zXgjNR3Amq9x3wQ/Ft8mDYF0swHWMDbRGttxVnCLK2gs8PeKVYQJo7zDTfA5zHcVH2mU+/CktsGw4j+PPd2XBOPOHwYycm57C/dP/nhP01E9rx4q6fokASQl2O6PcUO2ilGl2AMDZyKMHQe+zXKoXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bt+/fCxV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so602485a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720115764; x=1720720564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qgtRvCdg/ifivgMecJnzVwS9qRz/l20Bd1YgNSPk6qk=;
        b=Bt+/fCxVoSDC8GGA4uulhAtE09211GXb8IB7Xgts7EKUl/wAhRBsA2o9OONQogN1vR
         oBh0bcS83XsDjlLrsf44iZmezcsh8xMUIQJV5+Vjvo2J3rsaWzUMUDhEA6mqTYCwdmTz
         +rnb6cOaPRhmA+OwcUjnWERxynBxVyeaDVyjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115764; x=1720720564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgtRvCdg/ifivgMecJnzVwS9qRz/l20Bd1YgNSPk6qk=;
        b=wPcNrejVqhZzLpoRoAFhUvivkJwoeSSUBNk7COB0dnRTaEp4rSeehqFixzDud+Asm4
         zH6IpzgPh8MTgmGLzbf4KjxvttIw71fZN5kyXlIr/pS5kKTter0w6CF9kToYNpr9Uqz0
         OHT4gN2tpiMNN1bKihPekdsDAK3tpDyfZ9VObao1apKRKa491Pn99oVrGxWtu+NVoLct
         WIDFfvfNGeT5VcFuDNP7c+a06kEMNMYc/3WhWN4/I2GFMFHoYjGgO8BvPpWx3lKWP/Hf
         Eh00RjjGyGPpeQhf2lbNW4rTMO/DwJt/gg/ae1+2QBURDQzWJ4Q8hiWN7qnRzNz/kcrU
         JdXA==
X-Forwarded-Encrypted: i=1; AJvYcCUoDXDMSOehToZukKlHdMyoLmpE7m8Qfhw584eN/yOQqB/zYv90mDZf77IGntAWjNj3ySVPDd3RHJQD82pxEHfNFfJcndB4WyMRKCys
X-Gm-Message-State: AOJu0YwNlZdU5FBICnRZdVflv0HZAUqj0mfwJf9d1sc8GHqlY2zRyaFb
	BeA9aA5LxBP/ueHP7vXZ3svcEPp2zfsYaZNYdlefw4n+GqD7HYFFq1dlMYSIuOK+Ch8ePszmQXM
	K5vrG8g==
X-Google-Smtp-Source: AGHT+IGMjk3Hjxnj4wI7ETlGw2NQQby+uLbabTYUuZ64EH2zQtwWZAxuKLI5EDp8KFn1mgPvLSRzcA==
X-Received: by 2002:a05:6402:2809:b0:58d:c542:252a with SMTP id 4fb4d7f45d1cf-58e59d38b0cmr1633023a12.21.1720115763696;
        Thu, 04 Jul 2024 10:56:03 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614f3d579sm8768100a12.86.2024.07.04.10.56.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:56:02 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso1217876a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:56:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsFhKBQnsZlv6ubw2/ArbutnYiZLUKviNQ+BiH3aXcR/t/xtSF06cKqHjlo0sUGFhFIFs0oGufTAVEAfYaw41CGB+piAAWjLXYui0Z
X-Received: by 2002:a17:906:578a:b0:a6f:63c7:3083 with SMTP id
 a640c23a62f3a-a77ba6dc751mr117061466b.13.1720115762523; Thu, 04 Jul 2024
 10:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com>
In-Reply-To: <Zobf3fZOuvOJOGPN@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 10:55:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
Message-ID: <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 10:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> As far as speed goes, there are many legitimate applications that cannot
> make a syscall every time.

This is not an argument.

Nobody suggested a system call each time.

What I talked about, and suggested, was rdrand and user-space mixing.
The system call would be a "initialize the pool" thing with possibly
some re-seeding occasionally.

> Anyway, those actual users exist, and the partial solutions and hacks
> required to workaround this shortcoming are kind of grotesque and in one
> way or another bad. This isn't theoretical. I'm not working on this for
> "fun".

Once again: I don't want to hear "users exist".

I want to hear *from* those users. Because I would have expected all
those users to already have perfectly working setups in place already.

A trivial google for "rdrand library" finds lots of hits for things
that then use the AES-NI instructions to whiten things etc.

And several of them mention OS X and Windows in addition to Linux. So
those things are at least partly portable.

And no, I'm *NOT* interested in catering to the crazies that say "we
can't mix in the TSC values and do rdrand, because we don't trust
those". That's literally the kind of people I want to avoid lik,e the
plague, and WHY I don't want more of this in the kernel.

Because sane users don't say that. Sane users say "every round, we mix
in the TSC, and every X rounds we do rdread, and every 100*X rounds we
do rdseed, and that means that the end result in not really
predictable even if you've started from the same virtual machine
image".

And sane users presumably ALREADY HAVE THIS.

                  Linus

