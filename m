Return-Path: <linux-kernel+bounces-522702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FCA3CD98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7269189C306
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01C425EF86;
	Wed, 19 Feb 2025 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE1Vkhpp"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B886257457;
	Wed, 19 Feb 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007838; cv=none; b=f6BgGlGINE8AQjng8T2GopIrH+9pUUa60skgTDXpHffXwdwsGVUO65XKsEUZ46kObwDSKhK+PzWpkvEjDiAybwLA422kJv8RZCH5dKE3Y1aRY4khrlTxxSrkiuI3/28sNCbEPItIebaLyFgn7P9LwXrT34SaUzSpTY3iEZbhAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007838; c=relaxed/simple;
	bh=QHBkefvnoQ27PkxeG7M+C/KR4ZeXuhRpAwQYpDXPXEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maKkdaRVFj/VsJI9i4svYUOpM60uoNNr+UoOlwwbrX0VEeO5hhcr5VA3GpFWkt57Fqwe5L2Pr50xcWg35HHHQYOFKtvp5MgS0t9Paa/FegSZ+w2ZrFiw4hZ7tfMh8PUK86VbUbiTKqMHhwXrlCOSOHjjT08QOVywXHN8vPR2Hc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE1Vkhpp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f403edb4eso162390f8f.3;
        Wed, 19 Feb 2025 15:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007834; x=1740612634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKnTn46/4Y2PZeZ3N6KkyX0o2kLFr+MjBIJGyqLqLvg=;
        b=RE1VkhppcYilLki797feCtEvM6bNrinuVhyydA29y/CM2qwlaHSlBkUQ27eEWAsu3U
         lbquQNw+3rqYqM/2K8+OoMSyvR24uKamYjsfDLwM8VsIeXKxdpFit0N4SDqb5z6M4x+6
         pO35Zg6IFPD2j+hs6aUNEfheo53SGvr7S1H1YpoJVPM6G/FWEWSIAOgGG3KsxpkIrvHm
         JEmxssmOmuvNGykryCu7wxjCCbLkFtCJKEzxfGNFIOtJ5yVNWkgkOzzbilcy1aLJOWJ1
         bsy8VGCZTq+KY41z1ip80dq9x/3Yo45PQ+lvteinhy3R+xYgcIWWuMnN2KdHLLINhsT6
         FOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007834; x=1740612634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKnTn46/4Y2PZeZ3N6KkyX0o2kLFr+MjBIJGyqLqLvg=;
        b=shwYzr3Tbmb++65u9RcDn1pGySLYcU8d8sSBMoJRK7yrkcgFSSo9va0g0dCZVAN51o
         cHH+w1De6FkUjVKZJ3Dql39CL31q35lK9VlswP404VhtpQbfuoRaX/0JBNu10bB/7kzd
         Hzg77m3v/0lgN0nM4t4TjwTjICUJ/Bbpy70ebDDLdDR3ju+qZuftujTS8HkDCz5w+kN6
         oi5FQ2hiE4eeoTTuw0wLJBQl1A5UXkT7NfS8aQ6yF1vJUlIrBPr0Dv7t2J5k6YjDEOQO
         xZDXAqtVo/xk+xsAdX1JHHn0J9rDwUndO0Dmd4L3kKabjrCMXZ/NrCuZ7h+oLm0ixw8l
         HdJw==
X-Forwarded-Encrypted: i=1; AJvYcCVcRoLt1fG+IJwFOlSt+i0P0e0wNgIF1/v8/YfvaQgKik2CsaFwQykrUO5Qlk9R60f5WJj5OLO6YvI=@vger.kernel.org, AJvYcCXL9FYonNIWaVytLP/sA73O45pwe9nmXPi9DvMb/FOfzZ5B1XE0UUWbJqkKWb9BP7BrEHa0mdwuZ3y2Rlwv@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXsQ1zCRnnyT1eeSeuo9JjxR02UnTtyCm+xTQdGo1q19HPX6U
	FffTEO78nMKnyRcEoRfIkYda+y5eRg3/srUrghDCyCyV0wfSc8PzSb5GplINg/WPxYvUKBylTr6
	RIrF/GKthuh/KzaIldybCLjfJVX4=
X-Gm-Gg: ASbGncv9Rkj6evYb9NToEHoWlgHPLm8QKXSwiamzDFmt6hunx9JvuYRkWuDsBBX0yDf
	BgTo1qhvctvmWwDcZLsGBHiCq4WtearqLOLpm989Oq910L+3hAMFhEh6K4WYpViCxkZrO5zMyGw
	g=
X-Google-Smtp-Source: AGHT+IHFGBp+H9LJ87eH9NcwjPr+u7W+cy6vGPQrVBD8VepuvfiNtoUe7umH1zTNOROzdxEEh6gwl0DkWMx2aD8oMrI=
X-Received: by 2002:a05:6000:402c:b0:38f:3b58:fcfc with SMTP id
 ffacd0b85a97d-38f3b58fe8dmr17435032f8f.13.1740007833626; Wed, 19 Feb 2025
 15:30:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com> <20f64170c0b59cb5185cfe02c4bc833073a2ebe6.1739866028.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <20f64170c0b59cb5185cfe02c4bc833073a2ebe6.1739866028.git.maciej.wieczor-retman@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 20 Feb 2025 00:30:22 +0100
X-Gm-Features: AWEUYZlmUvY8zJgQzvnlM_yf4TfmlW5I_F8Q4WL7EAI9RSu7Ct1C7vf6wwcX6ek
Message-ID: <CA+fCnZfyWE_g44tbbC5ugav-gufhjQiGugfdgWJV+Ae4Gff7WA@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] kasan: sw_tags: Support outline stack tag generation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 9:17=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> From: Samuel Holland <samuel.holland@sifive.com>
>
> This allows stack tagging to be disabled at runtime by tagging all
> stack objects with the match-all tag. This is necessary on RISC-V,
> where a kernel with KASAN_SW_TAGS enabled is expected to boot on
> hardware without pointer masking support.

Same question, is this needed on x86?



>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  mm/kasan/kasan.h   | 2 ++
>  mm/kasan/sw_tags.c | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 129178be5e64..2fb26f74dff9 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -636,6 +636,8 @@ void *__asan_memset(void *addr, int c, ssize_t len);
>  void *__asan_memmove(void *dest, const void *src, ssize_t len);
>  void *__asan_memcpy(void *dest, const void *src, ssize_t len);
>
> +u8 __hwasan_generate_tag(void);
> +
>  void __hwasan_load1_noabort(void *);
>  void __hwasan_store1_noabort(void *);
>  void __hwasan_load2_noabort(void *);
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index b9382b5b6a37..94465a8a3640 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -71,6 +71,15 @@ u8 kasan_random_tag(void)
>         return (u8)(state % (KASAN_TAG_MAX + 1));
>  }
>
> +u8 __hwasan_generate_tag(void)
> +{
> +       if (!kasan_enabled())
> +               return KASAN_TAG_KERNEL;
> +
> +       return kasan_random_tag();
> +}
> +EXPORT_SYMBOL(__hwasan_generate_tag);
> +
>  bool kasan_check_range(const void *addr, size_t size, bool write,
>                         unsigned long ret_ip)
>  {
> --
> 2.47.1
>

