Return-Path: <linux-kernel+bounces-378692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F99AD426
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E811728301A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88321D3195;
	Wed, 23 Oct 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1WnI8+T"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46191D1756
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708937; cv=none; b=WUfeZGnYmgqnIy/PYZjYMUeYKpEkNC4cl4cAo0iKqFNpyLsy1QoZuxYWs3A4dOCpaEOYCqpPw2tqnJ7GrnwsSS+YvGdfEgT6M/GX3JySEenxahlXERD38rSxfQEmEhgGWwOjCCqaIzjDKOYUB1b5BE79RY12g+uktYLC2XGDlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708937; c=relaxed/simple;
	bh=jrfwqO5oM0D9ZySyXATJamp4TpfqppW23vT0QbIFxMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBCsDgIbRLEFmCSkTM3uQX8B0zkdwGmsep5bLn2k/gf0zMMFLdkALFaRhnxVIw9RCrI/rcRNeVOiJxAi+4CP/zWOw+3cNEfnQcL0rkGXCZRzomZhfROPvbU0rc0RNlmN18p/EYKfuC6F/gxv7yyEvBnuZULNd7J8CVS9DFbwXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1WnI8+T; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d47b38336so11837f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729708934; x=1730313734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ay/OqGD2GTrz3V0tm8K+95EMKdw2lJQesOojfLv6f0=;
        b=Y1WnI8+ToI4rBfJlEcV5WY3HDIw8jkpeasGRJscBT6Xw+dNYScoUnVByS7d9pFi0A9
         72Dfty8PeyAZ73epfHIbL8WHOhmlM5OxBnqnpQrlOxl24l9uFSVpN09eJxhTIAmvmai1
         7eJZZCpV2NivAHXZ1XvaPgaNoa6PF2QKPwKNnzax76SjZWg7KqniaDM52h6sPvDXt+iv
         RFKclT+YbUDUmMcdcoD7b7sIl9BZFU8xLnwiu3vqNNVcu2F2ma8fTQZXkRfra/i+jyhm
         /BpjXlCbhgtAAvJo1onU/R+mzUDrGVBBeRQZoVcab2Idct+enkS8LCs114y6gU6fuTgS
         yPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708934; x=1730313734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ay/OqGD2GTrz3V0tm8K+95EMKdw2lJQesOojfLv6f0=;
        b=ILDI9aecRyemkRZ3s02rdWtPCnfnGFZucsMl1okmt0TtpJ1jmED5DL6/FU0Bf2/CeR
         IZaxa1cmlTTgpxvhULjEEZwZFg/aaJ2KQn5f5amBs3ZQea7n8dBA1eWQgECg/p+YNAia
         gUV+qYNdcEZ2zothZ1E6tET11uipXvecJWhLtyGkvLni+MRz+SVLsmyPx7kPNvV+SszJ
         bfEI4NxWeKkefuilchTnMyx5JOMn0QRijvx3ECmqe7ub3Lk9Dctkv2lQZWUwAVspQeQm
         zyn5gF8OdQY7bELIJ6Ec88qKkVWKCdY4fCVivCh6EaNukPFjJRL19KgN6zBo4Y29MM9A
         Y5qA==
X-Forwarded-Encrypted: i=1; AJvYcCXuUvLhpzYLQtF9dQ2bBqxafYw58RkpAsiVNHNTd+8+gcsGmcU2EEaj5HXzMFWZ65K9ypOjHSW3yfLkJn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADzdflEWzObsN9lfetRpNDQ1oejEz4x9rMS+0yoyd+8S6SAvp
	FLcLh34YG/XivYLv9Asz4zdAlz5p/6fwGeW3xv3LKExJoxCtIpgEVquXgxa3kwIfAKEksKiThAl
	ERAv6ePhenmYSt31ZRN86312pT9g=
X-Google-Smtp-Source: AGHT+IFB3tSRsLc8IJ+ZLmbBRgiQxMJcijIbkhHI+LcLoWS2ExMHeUZd0pXljEEFRrdcgGNxkIUIlWkiXJ0JtmbA57I=
X-Received: by 2002:adf:f5c4:0:b0:37d:5338:8733 with SMTP id
 ffacd0b85a97d-37efcf7ba95mr2248780f8f.37.1729708933928; Wed, 23 Oct 2024
 11:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022015913.3524425-1-samuel.holland@sifive.com> <20241022015913.3524425-4-samuel.holland@sifive.com>
In-Reply-To: <20241022015913.3524425-4-samuel.holland@sifive.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 23 Oct 2024 20:42:03 +0200
Message-ID: <CA+fCnZe49OGG_8J40_d9dTUBktY6qe-1dq1Y6Q+7hY9=xmUWQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] kasan: sw_tags: Support outline stack tag generation
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:59=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This allows stack tagging to be disabled at runtime by tagging all
> stack objects with the match-all tag. This is necessary on RISC-V,
> where a kernel with KASAN_SW_TAGS enabled is expected to boot on
> hardware without pointer masking support.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>  - Split the generic and RISC-V parts of stack tag generation control
>    to avoid breaking bisectability
>
>  mm/kasan/kasan.h   | 2 ++
>  mm/kasan/sw_tags.c | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index f438a6cdc964..72da5ddcceaa 100644
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
> index 220b5d4c6876..32435d33583a 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -70,6 +70,15 @@ u8 kasan_random_tag(void)
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
> 2.45.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

