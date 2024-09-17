Return-Path: <linux-kernel+bounces-332143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5997B5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA861C23181
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222C0166F23;
	Tue, 17 Sep 2024 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSh0Ztk5"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739815C137
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726613486; cv=none; b=HeaWxO1NwAyuYoaHAE5uxWiICOCYrh3C/eCmSxtAVuc3+GbNq+CkaJQFIR4M1i6Z15bOnZvrtcGtmjPCTjalbXz+Ly/dTrcYg8P0g602Izft2CBxZWtGa0sLoywSlyiNOHVGe5+MuwxXugxIxrvYNWEDjGJwCpZq33xdXcEoDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726613486; c=relaxed/simple;
	bh=m3lHy17qugQ/E4yQQqzLNDjhPIqFMHj7HVxOmDp4cVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMC6OoCzvtK8Iwfi32FiyXDxp7npcoYAdO4kzwWmlxzbLQJt8mbziTj8fGphscyl7Ckj4bkg09DYeW+ebYrnVyZ45l/IVpSGh1Ne9G/YnVCExHL8Z9voJj5IFX1hEg1r+EGT6aE5PhrldPNBgVrprMuglarz5lvvvQpNPxuwJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSh0Ztk5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3780c8d689aso4523641f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726613483; x=1727218283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGebus8PHpfHDtzBPw4HHyxPsRzXQn85I2IG0X1v/b4=;
        b=XSh0Ztk5dG2LpAWW+Jqg+rVWSuCUmmGxB9mMuRtDU5owH+sCSo996T2meOMnaScFj8
         cjE5KfVP9BBeM6mVOCNlgHfIMxHDbPU67oebbHGiTnxkX8TnepmhjKJPyeQLDYxj7Obt
         3N5GpHqAVyQa4BJGpra2gU+/RPkDCkwZyMs8eBWI/wtCKVHj5j6TgT5OJo39b1vnHgfr
         ZoTXz4TVjqXWR7U5kzxNf5ZZDAMdsRd6j0EcWRkNtgBqPsENsN9J+IB7ZnV/qPwe94V2
         YpOwYyWZ1zh6fIku5ofANTtSejlXha8+AaatDCCsjC6i5ScysdtJYdGR4bgesQapMbZc
         8CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726613483; x=1727218283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGebus8PHpfHDtzBPw4HHyxPsRzXQn85I2IG0X1v/b4=;
        b=aeiv7Fbpc4vjVw0v9mETeS3CTd3A9t33LVQW7To/6LIOUfA+fXJQWlocqx6F5oBR1M
         MqxMhvsb1K5Z/G+3RX+Q1x8/sd7KDcKLo45x64Nn5Z/L/AJPo8/LxRZ+yZQY6WKL4SdS
         xs2lIbrFjg8Ybu7bSXHyZGX7ZM3q3/C4pFlM1NQ9V7Dr56qmO2SI/4cKUJUrEDSyd6SS
         VZnWzsAdcTTzmcm2J60N7GMQ2LK3oxTF/ydUe1PZqir7ckvv84/NTgcpTNxYYLHWgfzj
         7YN35LHBt9VYe+uGYyf3NfAeOCE2cvroByBsuq6PL9hQRhOssZqyxjxSLbcBKeNrL+Eq
         VBNA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0df38GsE8SQkC8uSZk/BoUFJadQ2FjgAzHoN4s1raSCoAAJWQpEXg8saNmOaz9FYReVFMY8lJOuU8sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtzbg40WPgNercJRPvxAaI0OImBIjemaEEG0h8dkKiBV/JjVka
	Pd5yjGh6ro7fr0RjPxgUqY1Atsu5BfoSrNxayqyBS0uDrTRX2wohvMK3a0OJOl08++snVV77j+j
	Oh9WVZYVR0DZQ14YJzGtKAVcLZS8=
X-Google-Smtp-Source: AGHT+IEIj1iostf4S16nmDYG7+icMYmHU8ht1VPE1al+T0XL9oODcC3B+8iY7hCPMsMcRBCyoeX8Q1KIuhw8eE/nrnY=
X-Received: by 2002:a5d:4811:0:b0:374:b9a7:5ed6 with SMTP id
 ffacd0b85a97d-378c2d064c2mr12804597f8f.22.1726613482785; Tue, 17 Sep 2024
 15:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917201817.657490-1-snovitoll@gmail.com>
In-Reply-To: <20240917201817.657490-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 18 Sep 2024 00:51:11 +0200
Message-ID: <CA+fCnZeorA7ptz6YY6=KEmJ+Bvo=9MQmUeBvzYNobtNmBM4L-A@mail.gmail.com>
Subject: Re: [PATCH] mm: x86: instrument __get/__put_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: tglx@linutronix.de, bp@alien8.de, glider@google.com, 
	akpm@linux-foundation.org, mingo@redhat.com, dave.hansen@linux.intel.com, 
	ryabinin.a.a@gmail.com, x86@kernel.org, hpa@zytor.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, brauner@kernel.org, dhowells@redhat.com, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 10:18=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault(),
> strncpy_from_kernel_nofault() where __put_kernel_nofault,
> __get_kernel_nofault macros are used.
>
> Regular instrument_read() and instrument_write() handles KASAN, KCSAN
> checks for the access address, though instrument_memcpy_before() might
> be considered as well for both src and dst address validation.
>
> __get_user_size was appended with instrument_get_user() for KMSAN check i=
n
> commit 888f84a6da4d("x86: asm: instrument usercopy in get_user() and
> put_user()") but only for CONFIG_CC_HAS_ASM_GOTO_OUTPUT.
>
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

Hi Sabyrzhan,

Thanks for working on this!

> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 7b32be2a3cf0..f5086c86e0bd 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1899,6 +1899,22 @@ static void match_all_mem_tag(struct kunit *test)
>         kfree(ptr);
>  }
>
> +static void copy_from_to_kernel_nofault(struct kunit *test)
> +{
> +       char *ptr;
> +       char buf[16];
> +       size_t size =3D sizeof(buf);
> +
> +       ptr =3D kmalloc(size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       kfree(ptr);
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_from_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(ptr, &buf[0], size));

I just realized that the test I wrote in the bug report is not good.
This call will overwrite the object's contents and thus corrupt the
freelist pointer. This might cause crashes in further tests. KASAN
tests try to avoid harmfully corrupting memory to avoid crashes.

I think the easiest fix would be to allocate e.g. 128 -
KASAN_GRANULE_SIZE bytes and do an out-of-bounds up to 128 bytes via
copy_to/from_kernel_nofault. This will only corrupt the in-object
kmalloc redzone, which is not harmful.

Also, I think we need to test all 4 calls that I had in the bug report
to check both arguments of both functions. Not only the 2 you
included.

> +}

Thank you!

