Return-Path: <linux-kernel+bounces-341002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E156987A10
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A941B1F224F0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A6183CB4;
	Thu, 26 Sep 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XP+12Kja"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7317DFFC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382500; cv=none; b=Qr6EODZMrgpNP8zsD4T354hbV18jv93WfWS0aKOwsq7P9RvqPmANW63avdCVwg3oi4tv2BSBeCcUHUtaerOZpwkIzKjp7TgV0JzdjlE/GZQZLkvJFn7dbH6guU+pqb60bHxgWADT4b6avXDXBXkk9XabW7HMyYv3mMHeoif6Ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382500; c=relaxed/simple;
	bh=5i9PvWSVQ7pmJdAj0JVCH4wfYvmOKbNzNLK7RmykQCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1HrzmdbVJnQJYVGjvrTFzRRxfkBAUOjhHcCFq7YbB0wor9C8ojAMDizf4ct1Vdnm3elMB/q9TOGO1/RMRlzCDA/tDpsc2DoyANTOTLrqelw3zg/yCaIeI4A5wf2fNbcUp0dg/mq/JGgOaLNOpAnbfXmZ3yVKqORw/wq8h/Rj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XP+12Kja; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so16743871fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727382492; x=1727987292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BsSpvuOtgm3mX4L6cqlhiDX/t4WAYJef/7qC9Vsyxvc=;
        b=XP+12KjaJWMCvJwvzaDadYlz3s0S9RWV6SUfG20GHXoL6n+2ZLm6z0dSDh24wVVx/R
         OwqXO9L6Khgx+C0EFnhQv5MJkEomtaZ1MA9RzgPv4ZTrsAGEhg/y0dcb6IEba59A3kdt
         YMXBiCeAB0yf4yoAfy2gnuaF3Q4tfTK9t+1Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727382492; x=1727987292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsSpvuOtgm3mX4L6cqlhiDX/t4WAYJef/7qC9Vsyxvc=;
        b=DX2MnMVuul4QaSOvCD+w9uG4s6XwPFAZjfJUU0PY5AGFP9VpWgGdSkBV75EHc8sjPR
         0ahFdcyhISdoP66ExnuBXqaZ3scjx7gEtJUgJfCMAT94UftKkPPqD1SdCrvgJTmMnEW5
         yRvjzUkRyyXJRn1sjLv+Z8GzwvNIlPd19zyU6mOuskb5YmNv8+Mj1qPavUKFVcUgvrnz
         YagDqedAwSp1pNkGKagomS8mfPqicwGnOpuZeteu3o+RJXnoAy6K9ldL8CKa2C5rJVSz
         fFL1/qo6083r3MHC0g38S8ey9eAeNW/xtOxcruRc+T/5SK1EV/Dq9fe/nViTOUNHugNT
         YHYw==
X-Forwarded-Encrypted: i=1; AJvYcCWd3LcIMe0eMkhSI20JaQAdGBj3+6tFBdkElqStEilxYweBOXkXKzk/R1/cQDdZDeBkgbmhN5nk/klIBpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10Vp7NC924E3wPh1ikwVCRNNTupgrD7x0po3KazJarCuyGZUs
	eL02ajQhkYgXX+PHTzgRrSdXRQq/3sjinVpkgYcZuMeaJBcSD3JtGyJR02nHsh2yCOgMb/8oU96
	+sx5eLA==
X-Google-Smtp-Source: AGHT+IHdSJaZyEteFPKUy5xlg4mv83hH+BRU8LRKtPjC6nVQjPDazp7O8QnZMllF840DHK44HdI5eQ==
X-Received: by 2002:a2e:b8ca:0:b0:2f7:7216:d7ca with SMTP id 38308e7fff4ca-2f9d3e47df8mr6581751fa.13.1727382492348;
        Thu, 26 Sep 2024 13:28:12 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d4605518sm633251fa.80.2024.09.26.13.28.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 13:28:12 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5389917ef34so1656606e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:28:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLx2Z+SPHaiMr1ovyPdW+T3xGRYcRSJAyGh4QJTm+F6IF67hNRJqjf8wrRsBzQ6KNavWelfApcFwc8w1c=@vger.kernel.org
X-Received: by 2002:a05:6512:1383:b0:535:68ab:7fdd with SMTP id
 2adb3069b0e04-5389fc362b2mr551171e87.19.1727382490149; Thu, 26 Sep 2024
 13:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz>
In-Reply-To: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Sep 2024 13:27:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com>
Message-ID: <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com>
Subject: Re: Bricked Thinkpad x220 with 6.12-rc0
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux@leemhuis.info, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 13:01, Pavel Machek <pavel@ucw.cz> wrote:
>
> When I press power button, it starts producing some noise (hdd
> spinning up), but power light goes pulsating, not on, and I stare at
> black screen.

No beep?

> I removed everything, let it sit for a while, but behaviour was the
> same. I'm now letting machine "cool" with everything removed,
> but... It seems EC is very confused.
>
> Should I try removing CMOS battery?

It probably won't help. Last time I had something like that, it was
the EFI variables being messed up and messing up the boot as a result.
That's all in flash.

The CMOS battery these days tends to really just be for maintaining
the real-time clock.

But if it's easy to get at, it won't hurt to try either.

> Is there some magic combination I can hold during boot?

I don't see anything  about keys during power-on in

  https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles_pdf/0a60739_04.pdf

but you can try the usual suspects (hold ESC / Fn / etc during power-on).

But that lenovo pdf says
 1. Make sure that every connector is connected tightly and correctly.
 2. DIMM.
 3. System board.

for your symptoms.

That said, my first suspicion would be a dead harddisk, just because
they happen and you hear noise (but it migth just be the disk getting
power on its own, and making noise even with a dead system board).

The BIOS _might_ be trying to resume from sleep from a dead disk, and
not even initializing anything else.

And the disk is easy to get at, so try just removing it first. That
might get a stuck BIOS unstuck, and you'd get a "no harddisk" error
instead of a hung BIOS that tries to access something that doesn't
reply.

At least that way you'd have a suspect.

              Linus

