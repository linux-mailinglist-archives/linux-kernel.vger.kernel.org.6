Return-Path: <linux-kernel+bounces-286823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E64951F81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD8EB29EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0DD1BA897;
	Wed, 14 Aug 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1PBHjj/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03D1B9B35
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651463; cv=none; b=jWj4uQt1XV7M8qEkqJ56JutpINNvwnuHouV+jweglRrzeRaWHwKVtUevlWcu+UhlHcUQ6KqPNBhOyOTELG6aXBuJHgQQ0eNJAvXKKjX8JfsaBw95YUO+XK5AWJb3cMkeN+SPlbu2zr4Tg3oL9CeVtzKZ4UtgkrZFNIGjW8C6aDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651463; c=relaxed/simple;
	bh=CHA/NxN+WL7ytxiSegH/356eeDIJRHkkS9m7+B8R7k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuybsctaVpD/++J8iQDeMlnjlojZqi9gqL6Z8wQSO7x/RCHQoknNCumFhjL9fQWdHUjAXEPLoAy1QiM4601EcvunpPsiikXCA4g6IbhfTJ9vvQv2C9Isz5yQYJznIQtz4bXo8IpkLLH/oryTbCAMv0/FXoZisduBghZzfx3cGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1PBHjj/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36bd70f6522so45934f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651460; x=1724256260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Zca3EF+D2CYuuuToauHn6IlALs7hm5snAMPHxabeUc=;
        b=a1PBHjj/GETz9redEIkJ6qwz/qayDMZEVIW0Yej2qdoAgaYzTMyKCl0avytZzaaeQV
         RFkdbswAFqjv6UoT5vTCgulfYFB/dkPsuAu6LoTj48Vjpkp2VF6Ovm8iHWCUzmpNxrjC
         VhxSuBGQlQM57xRSLgh8zkYGKHeze32S2F03sO40dxvDxQmwaJCYfIj0g3o7XcUyYTi2
         JNom5F8Z8Fmnj+SGvgIw+MyM1iiOLoDi9zZNpigXFCr7IG7DoFKusC6PDddEa1jeNUUT
         P2B8gkdaLIWLxiL83I93lhhE0hsji5OSfdNw+684tf3/Kvo1XeUQaJM9fJfMCgCtYfoS
         ybIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651460; x=1724256260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Zca3EF+D2CYuuuToauHn6IlALs7hm5snAMPHxabeUc=;
        b=QN6xb6V23sCmwaNvB1UenilGMjcyTjadjTWmDoVGf0nqSt0ASwcHnycTx+QkWIbfWp
         7gW3s8b1LvqqL+mmfLFlXQT/frPLLCPEK+rD47viCeBlQlQ6ninedjMIBTR/nShJkRb9
         dijunDio/ZWTL/0xembc0Ye8ZT4OIbp1aC/SNkKmyMFySLzcKpcLvORAREKlie1vH86s
         6rmWjpbtxOky5FqISVUA6a4sCKxQmeEMsISxVN1M/KjB/HO7iqb74hoeIUrJ/ycUo2IU
         pHzyW71YSn7+ZWIpvafwGYi0G1Sx6CPztqSXKjk2AuXt0kC4ahEXdjPDbmeD4UFdYPQ3
         +HRA==
X-Forwarded-Encrypted: i=1; AJvYcCVXgSy9xoadYN3gfHqzhKdNHL6Or/81K+zHz5I6GA6D6GSF0ZnRNEwfn8qW0m564I0r7tm3uKdFhWCWzqg8WVsZt+gwWY9JNgoflQ6O
X-Gm-Message-State: AOJu0YxENqDS/g1LUWbg9IBjrWEVUwJ7ZFKj0fILsy1loQ2jj+gXwdry
	JV7wEVqocd0uRSdnyUVTuKDvNqtFADhYkdgBuNdQFStJFzzbdsm/02FojszjC+AA+B9KnDNkG9W
	rKDIGoIaQl9xXBJUTJ1EO1cfsYjE=
X-Google-Smtp-Source: AGHT+IFnmHqdQ11FZb2kogrsYYqSw5JlnW8SZXlee6hQo5kUNIASams8wn5Bn1JNJ0T5DVU0M/WIuuCUXjv2UnMVM3s=
X-Received: by 2002:a05:6000:ec7:b0:367:f054:7aba with SMTP id
 ffacd0b85a97d-3717780fadamr2383175f8f.41.1723651459847; Wed, 14 Aug 2024
 09:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814091005.969756-1-samuel.holland@sifive.com>
In-Reply-To: <20240814091005.969756-1-samuel.holland@sifive.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Aug 2024 18:04:09 +0200
Message-ID: <CA+fCnZfk5cAO5hC+EJmmvjZRmFRX5A0QScNXScyfajgeKhOSdg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix KASAN random tag seed initialization
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Douglas Anderson <dianders@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, James Morse <james.morse@arm.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Puranjay Mohan <puranjay@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Ryo Takakura <takakura@valinux.co.jp>, Shaoqin Huang <shahuang@redhat.com>, 
	Stephen Boyd <swboyd@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:10=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Currently, kasan_init_sw_tags() is called before setup_per_cpu_areas(),
> so per_cpu(prng_state, cpu) accesses the same address regardless of the
> value of "cpu", and the same seed value gets copied to the percpu area
> for every CPU. Fix this by moving the call to smp_prepare_boot_cpu(),
> which is the first architecture hook after setup_per_cpu_areas().
>
> Fixes: 3c9e3aa11094 ("kasan: add tag related helper functions")
> Fixes: 3f41b6093823 ("kasan: fix random seed generation for tag-based mod=
e")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/arm64/kernel/setup.c | 3 ---
>  arch/arm64/kernel/smp.c   | 2 ++
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index a096e2451044..b22d28ec8028 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -355,9 +355,6 @@ void __init __no_sanitize_address setup_arch(char **c=
mdline_p)
>         smp_init_cpus();
>         smp_build_mpidr_hash();
>
> -       /* Init percpu seeds for random tags after cpus are set up. */
> -       kasan_init_sw_tags();
> -
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>         /*
>          * Make sure init_thread_info.ttbr0 always generates translation
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 5e18fbcee9a2..f01f0fd7b7fe 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -467,6 +467,8 @@ void __init smp_prepare_boot_cpu(void)
>                 init_gic_priority_masking();
>
>         kasan_init_hw_tags();
> +       /* Init percpu seeds for random tags after cpus are set up. */
> +       kasan_init_sw_tags();
>  }
>
>  /*
> --
> 2.45.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

