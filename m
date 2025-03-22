Return-Path: <linux-kernel+bounces-572667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618CFA6CCE6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB7B3ABE81
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124AA1E5B6B;
	Sat, 22 Mar 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a83wRfSY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7986338
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680399; cv=none; b=IXrRZP1cf3RwuFsK+QY9ptWtapddULpB/YyIynZ23iz90Tcxuow+NH7oyR+geOVIY8m2srodvo67Nvl1/RFPsX0JZEABzQs6SMibfqwvVJvXV/5weHW4Mv8AxJwOfTIgNe9CuIK11n/PCItLxEMoJdz+k7UfaP1l44Pw7YPnVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680399; c=relaxed/simple;
	bh=MVvNJytHUU4pVQ3upkH7Pal4g2Ex+PJocrPChqEk/M8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb0Q8YlkF92pLgyvJofYyNlXx8njnEtnWCWpU/gSem9NNkOm6EF5TZ9Ojt5D1xp23rs081M1FsQ9tKEpUy1q9bJUY1k7znZDiLy/MXaQIoC1rxse5OsSt7MwY0ePireMlG87zwtVfVmWzUuV1Ieu4MOfHEbIkp6B+UBoGeLacT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a83wRfSY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso27267175e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742680396; x=1743285196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+zv42IQPtp8CqhFWegjLLKIu2NZooZvEV05yEQElpQ=;
        b=a83wRfSYxW81nvVeO2y2ScuyxD9eRzUlsm7dRcBC2lvLfJ6LI3GEA6ccFTNx1Q+7Cm
         dJ2eEyyM7b9lkGysjplbja3NfuiZP6oxVmDN+N9sT6d4IY5YveSWIVTlfWcl9j+ij/xk
         LbB1OBMGfgMyu1PNCPM0oGjiZbyxzTuzHcHUKHp0Rc2Ybn4LVOXY1nOctwyI87ytcQhN
         TEAvhvH9YCd5TpcjUOUXdMrwDFbcIk0WUHYBrma/hLItjqnNwWaKTsI1RfTC4MTeTAi/
         YJoUGHX/EGApCyp1p77CMM3PSRbMSfVJwAgWh2pKJEid3XOLmoX9dkPYa98o6V4jcS9a
         TbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742680396; x=1743285196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+zv42IQPtp8CqhFWegjLLKIu2NZooZvEV05yEQElpQ=;
        b=UB7ceY+Yc2NuLwU4zzHskrcbObcNUITiVOVMHp87fAw1sNTFkbl33ZX6oAvF1qtqHc
         CuKJWrqKRgjPO4p100M5HUXke4g3LE85NlItJxTjFLlwZSVt7K0RuDaMlfpkya+jrrrd
         TLEofQ9lhW8OQNpDU18NVQeGEeO0SorD6zKBdVZFH92qJ/KNiJVYfNyZoHKEqVHwZ8mk
         kN3+E6MGBKZgz4EzVzILLUN1ysQ4tDgz0i0VKpJPuMl0mJPebsfVBoBSwdUTj0vjjWkg
         fntLdGF7VrDcwm0+VC8Vz5yaQbrYaOmmKuo2O12ii/kSW5jRRN8b+kvfwEBbEVGnw7AE
         vHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh4UKAl00ZovgnUZYzF7bbK9La+oXNUsjC+kAqm7dTtgnKwKQWfxs0GzmL6M2Dt72Gv5SwKJM3m2M76KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKV34wvJgEL76q2HhvM6FMpmMIVJA/SD7gGv4xN7BjIZfzFn8
	a8QDIr+5KDm4Rddx2iTrGXYUsPweCCjW9J7rJ4156qM2vRuCtSfm
X-Gm-Gg: ASbGncvX7s+i66/64qi8aJWKNe9VlXfqj6I4t1NInnzTS0HTwP1PXbDI4SxOQinwGy/
	+pKTKWtwhE/AbibQNVVWBFvNnudWYF4Hw18RRWwzNMKGusAfk7rLRkVYNyxH8kG9dBTq0oNtRNA
	7lACmoaZ0hTSZ+hcapqHmnNhOypzEJKOjCJXZOSu244/XgGCv5CU5KwRKZo/3LnlfYUbfdQgv3U
	PuhdtKrZrPj0OId6CRv7Hi7vinsTVWqATUgI9IkLAfLs6jB9y49q/rwAJvJNlKwmALzTiMpnI3F
	N8JTV+6PU64HXiiJn6R3uFmKEGVlJkdEV9LJSjfjU7jppk5vzvTiKO/x6VEA70k34YahQTTB3cq
	0ywXQHas=
X-Google-Smtp-Source: AGHT+IHkDhic+ChKS9azNU0isv9mplj9FRAWczrfb4nlJWwwZaQwtgdFfpypH6w93IXk8qIph4X+fg==
X-Received: by 2002:a05:600c:5849:b0:43c:f81d:f with SMTP id 5b1f17b1804b1-43d52a2068emr45018295e9.8.1742680395873;
        Sat, 22 Mar 2025 14:53:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f33242sm119320825e9.5.2025.03.22.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 14:53:15 -0700 (PDT)
Date: Sat, 22 Mar 2025 21:53:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: "Tor Vic" <torvic9@mailbox.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, "Borislav Petkov" <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "H. Peter
 Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] arch/x86: Add an option to build the kernel with
 '-march=native' on x86-64
Message-ID: <20250322215310.7b69b8a1@pumpkin>
In-Reply-To: <e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com>
References: <20250321142859.13889-1-torvic9@mailbox.org>
	<e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Mar 2025 12:40:08 +0100
"Arnd Bergmann" <arnd@kernel.org> wrote:

...
> I assume that the difference here is that -march=native on
> your machine gets turned into -march=skylake, which then turns
> on both additional instructions and a different instruction
> scheduler.
> 
> Are you able to quickly run the same tests again using
> just one of the two?
> 
> a) -march=x86-64 -mtune=skylake
> b) -march=skylake -mtune=generic

I've wondered what -mtune=generic is actually optimised for?
I've seen gcc convert 32 bit add into an lea and then have
to use another instruction to clear the high bits.
I've not fiddled with the options to see why it does that.
My only guess is it is avoiding false dependencies against
the flags register - but the flags are split on non-archaic
cpu so that doesn't matter.

	David

