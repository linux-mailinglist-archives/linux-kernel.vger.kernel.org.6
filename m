Return-Path: <linux-kernel+bounces-562595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40985A62DB8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C6717C140
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0E202972;
	Sat, 15 Mar 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkTGLw2E"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F2201249
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742046762; cv=none; b=eW4iuVaE4WiY+PEz0ncRA1n3rJLmCX6w19FJvwLAe2A02IhSxQO08ZDi6hRbdc0P76BRanfIoab+yQvJJX6MRMhU/XHfhkgNFu7Pbz+zQPLU79lyk3Q78CIXAs1mfrKA7VsSZGCdwyofYFAHg+uRyT9vg7jbwXxDnTV26b+iDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742046762; c=relaxed/simple;
	bh=bpgbrPsEwH4Rgd2cGzaI2Mcb7TGn6jy8WRMC4fg8h4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egjiNgnW9oSlWncLPoMC4f5Tof2BD+bp6SLfstE1LUBjZhQwZ8clms38HquzDPGLtiwjDSIcr5QZ8MkxBMhi6oORhf7VpBp/at76SquQnI2TWNOoG1HpXXJLY5SiTeIz+ZVfMPFTblfj3Jwy32ezs7WfGw5hpoPT/g9DZ7gpj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkTGLw2E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso2525358f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742046759; x=1742651559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kisHNLR7g3UrSh4QGQ2sNXSGLY1Z0gAXoM4Ba7cSqU=;
        b=LkTGLw2EFDw4/QWlhvLLEcELv7JrkAulhq9JxaczIBmOGJZGf3OnXJeF2VqDkJUIqV
         rQWWKDfFhvvAK/wb+c6e3zVzrkSrvgBoIejtQ2deiLxI+gGkhlsMMfXx00XfTFZlativ
         kDXuYqBm1m9pJvad1oeUOJhn36NnqvY4X9EUEbw0G8t0m3Mef608Y8DPqYRkV0TVoFkH
         G/qVg2PCupfuUrIxUtWwRPblixHhgVAEg2ZVlI1h+laz7hbdgM6PoWw+ost2/Aitwo0h
         AREPRJlwpIFjs/nJfR5fsbwzmmdjfkA63g0bL7w8YiCXw15qX/7sLhfs0nK4Y0D8hSJN
         SFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742046759; x=1742651559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kisHNLR7g3UrSh4QGQ2sNXSGLY1Z0gAXoM4Ba7cSqU=;
        b=xAYRRgARLwJ4dssaiIjemzI1WZ4qY7jnERwT329GMQxGv4+2M4GWM/NzOq59xCV+Pl
         VYYDeMi3qhHm+gtljLeCbaaikC4SgttA6GrXqkxXG177rfeEOh7Kk2tunGCVNVVhLm0A
         BnkcGDDPSYM0WM49QiUBAsy1fXxghBk4C2k51r6hv6sWsvPm/Zp+aoQnUaYvOJSLOcPl
         dlORGoYIS31YkwR5PDcvwqNFwKOIOW0JUmsZfedJVam+FTGVTL7oWFPX2dR4DdmtJXSq
         rPGJbxpaeS3eGjbcxIj3uWWAAlEORgkFTsagsXkKE89r6jJmudSawnxS/lhrrA3LG1+5
         sN1w==
X-Gm-Message-State: AOJu0Yz3bfBnm/eLywH18JudGqckbIOYSYb9VOOxo55yId3LV4kcftji
	q9gZ535CJ9Gww4eIS1owrvxj66Bn5e1l+0ZZ5ZzjcfsGfztR2PQI
X-Gm-Gg: ASbGncvWH6nzDy5JFGAzVhiNe3xRpSV13N19fGuS9AaUOjJm6jHIf9OWDsnPIwTWQlC
	xZQAuEaKaLML74mL/MMrsZNRYSgsNQZtep2hZHPvkol/2wKb+duhVEb0kuT1hBJRaq6OuDne7uh
	Kl918vTZRjIncdBEALlhLX3XWwRAguWE03HSnbzRYThILCxjvs7ADPiz+G+peYFfeauSX0pxKmT
	f5zhOQrcSHzbdtygVVFeAjHg/fCjj284UkzA7bWHd/c1qcN99qMDoM2OjfHAMYLyejAQvmZzL7R
	Vfo7Fd+zIhEIMoWfZscY/PTKyLB8WF+SX3xD7Q7E96KoKkvMHAFUA3uKU5+tNxn/PN+zsyg9zpq
	6BNkNNiU=
X-Google-Smtp-Source: AGHT+IGMidQQmtRUzBwojnOPxhA16KnLJIRVwIIPB9x0RfOJRE5FiMZYpiISVJA+gFip3dy9gFQreg==
X-Received: by 2002:a5d:6d06:0:b0:391:2ba9:4c59 with SMTP id ffacd0b85a97d-3971e971f44mr8442885f8f.43.1742046758793;
        Sat, 15 Mar 2025 06:52:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a96sm9265317f8f.69.2025.03.15.06.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 06:52:38 -0700 (PDT)
Date: Sat, 15 Mar 2025 13:52:34 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] random: get_random_u64_below()
Message-ID: <20250315135234.65423e07@pumpkin>
In-Reply-To: <20250313163810.60564-1-kent.overstreet@linux.dev>
References: <20250313163810.60564-1-kent.overstreet@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 12:38:10 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> bcachefs needs this, for sampling devices to read from based on squared
> device latencies.
> 
> this uses the same algorithm as get_random_u32_below: since the multiply
> uses the top and bottom halves separately, it works out fairly well.

Adding two separate copies of much the same code is silly.
Given what the code is doing, does it ever make any sense to inline it.

Inlining the original get_random_u32_below(ceil) that did
	(random_u32() * ((1ull << 32) / ceil) >> 32
(for constant ceil) made sense.
While good enough for most purposes it was replaced by the much more
expensive function that guarantees that all the output values are
equally likely - rather than just evenly distributed.

	David

> 
> Cc: "Theodore Ts'o" <tytso@mit.edu> (maintainer:RANDOM NUMBER DRIVER)
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com> (maintainer:RANDOM NUMBER DRIVER)
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  drivers/char/random.c  | 22 ++++++++++++++++++++++
>  include/linux/random.h | 22 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 2581186fa61b..84808300044c 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -588,6 +588,28 @@ u32 __get_random_u32_below(u32 ceil)
>  }
>  EXPORT_SYMBOL(__get_random_u32_below);
>  
> +u64 __get_random_u64_below(u64 ceil)
> +{
> +	if (unlikely(!ceil))
> +		return get_random_u64();
> +	if (ceil <= U32_MAX)
> +		return __get_random_u32_below(ceil);
> +
> +	u64 rand = get_random_u64();
> +	u64 mult = ceil * rand;
> +
> +	if (unlikely(mult < ceil)) {
> +		u64 bound = -ceil % ceil;
> +		while (unlikely(mult < bound)) {
> +			rand = get_random_u64();
> +			mult = ceil * rand;
> +		}
> +	}
> +
> +	return mul_u64_u64_shr(ceil, rand, 64);
> +}
> +EXPORT_SYMBOL(__get_random_u64_below);
> +
>  #ifdef CONFIG_SMP
>  /*
>   * This function is called when the CPU is coming up, with entry
> diff --git a/include/linux/random.h b/include/linux/random.h
> index 333cecfca93f..b025bf3d8f27 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -6,6 +6,7 @@
>  #include <linux/bug.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/math64.h>
>  
>  #include <uapi/linux/random.h>
>  
> @@ -90,6 +91,27 @@ static inline u32 get_random_u32_below(u32 ceil)
>  	}
>  }
>  
> +u64 __get_random_u64_below(u64 ceil);
> +
> +static inline u64 get_random_u64_below(u32 ceil)
> +{
> +	if (!__builtin_constant_p(ceil))
> +		return __get_random_u64_below(ceil);
> +
> +	BUILD_BUG_ON_MSG(!ceil, "get_random_u64_below() must take ceil > 0");
> +	if (ceil <= 1)
> +		return 0;
> +	if (ceil <= U32_MAX)
> +		return get_random_u32_below(ceil);
> +
> +	for (;;) {
> +		u64 rand = get_random_u64();
> +		u64 mult = ceil * rand;
> +		if (likely(mult >= -ceil % ceil))
> +			return mul_u64_u64_shr(ceil, rand, 64);
> +	}
> +}
> +
>  /*
>   * Returns a random integer in the interval (floor, U32_MAX], with uniform
>   * distribution, suitable for all uses. Fastest when floor is a constant, but


