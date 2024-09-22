Return-Path: <linux-kernel+bounces-335132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6331697E17B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC1F2813A3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0AD193099;
	Sun, 22 Sep 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un7lcU9C"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35C13174B
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727006808; cv=none; b=le5Bze0WFZEcc0WHXyayP3LmBHD9X+0UBtTSO81/X04KG6ggDkYUtEKue49AhLNIZARl8kkOwx+6kKetoAidWgczyv5lqzHN8AQveYKRN58Fpw29q3kSHm4PTg0/kiLslHWTN/xPpKZjo7pNiMvTOXfW5ER0GpVnRFX29Cw/408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727006808; c=relaxed/simple;
	bh=myGsc2dcwzFf7LeP1OtSumK6hJE8kMe/JHQXzXSRh80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khOYms8l0hzDiJaLDAO3CVTUR85UCMDWA6hEX0pQZ4K2TErI0CQ+tt3XBBQ7OnXb/YKI6fErHSEKY+MIffFnFFiMhg45mdO955QqiJeyo5lNsF8xZWn0v1wrNPDh23TuEyM8Gy8sxHn6tVLLeNSAt7Z19xtk7K7LxBRvH4sCqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un7lcU9C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cc8782869so32502335e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727006805; x=1727611605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiZOe2lz0efuBE5xsl2if9Xg0X7UVZYSnN/VuYjkL3s=;
        b=Un7lcU9Cgb4dosCWwpfLR0nRM43gYgLbUq+oLSx68M8DEsN87ifB9Ovnehinb9lnp8
         pa9Cdh2272riEQu7QjQu6Byfe/LBhYIngtlc9U9SBMLvjlfoTHhWmBUcA9xC2qWl4ZjV
         CX/lrmPOxD7hh9pdDBemSslOtd19yw/03tCJpHdIVotEuLEUuDu+vcT9ainPEOs2Hxg4
         iD1wxQPCpPmo9s42cFetfJmqOPdpcWWyiIz/IsuyCG4PKfttzeiAVS62Ihm4tZljLm2K
         orwlOx4veyypBUrhjYhiwxhQB+hqXkUxn2mUn4jCEAT6Is1FGnms1MmsxkzAS1pb9DG9
         qpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727006805; x=1727611605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiZOe2lz0efuBE5xsl2if9Xg0X7UVZYSnN/VuYjkL3s=;
        b=Khz3qHhy7NUWys4ENCrks+1h31rt5QNYQlJvRy1fwar16LpmYf/WH37ZTtIMETDmiQ
         w38WnPIqKcwO6tcsnrZfQmnWr8aQz3Z4EfnOQyT7gInepbTGNhm2lQp8P2Bxrd3deIcg
         APlcnB16yv/6aDVxeaM//p3JfBn5A0JvebhVGH0Ro/qLhJ3NKKWHnoeF3QUzqcG2XFAE
         2W1n1LGTB6F02+8cCNOMI2zhkbQ/bDWY9alfFYB1E8arh7NpFg/cBVBe3em9z7Q1HdWY
         spR+jlsdB6wScCzAy6zzujFlr1HI+p7+UqH2TEK66DOz4ye3X737fZRmUJmO75FrR+qf
         A7UA==
X-Forwarded-Encrypted: i=1; AJvYcCUP7Xwlbs/q+DurucCC2nmO8WuuulMgNTCyThpDqocINCRbF9/YbYtjf17ks7W9UMrGjfkJ59vfdVoovfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzskbmdW8YXj+LagXyNQEkSLl1uqpxHnSSk+jR/6c2+MUc9w4e7
	Pcbt+NS8aEhlRPkfrwUNlb+RH5RmOXdNt2mwoKEPOVvIsbjtfPdmlWoPU0wiRwfoqFP4PhVInv3
	GVKPxVrBWHmuv0QyVrH6TaND5OeM=
X-Google-Smtp-Source: AGHT+IFI/LzUiaaN9j2ioL0Boz8nfXukgualdsFYRmEzQ7Sb0pS6nsINcWotP+04mGDp8wqhnWaWRNHSOC1/w2hwK3Y=
X-Received: by 2002:a05:600c:4f8f:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-42e7adc0dc7mr60810165e9.29.1727006804828; Sun, 22 Sep 2024
 05:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZeiVRiO76h+RR+uKkWNNGGNsVt_yRGGod+fmC8O519T+g@mail.gmail.com>
 <20240921071005.909660-1-snovitoll@gmail.com>
In-Reply-To: <20240921071005.909660-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 22 Sep 2024 14:06:34 +0200
Message-ID: <CA+fCnZfXp3-NOq-LB13q8V6tv=H976AeNQXU8p-VGK-m9Qdh1g@mail.gmail.com>
Subject: Re: [PATCH v4] mm: x86: instrument __get/__put_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, glider@google.com
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, 
	hpa@zytor.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mingo@redhat.com, ryabinin.a.a@gmail.com, 
	tglx@linutronix.de, vincenzo.frascino@arm.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 9:09=E2=80=AFAM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault(),
> strncpy_from_kernel_nofault() where __put_kernel_nofault,
> __get_kernel_nofault macros are used.
>
> __get_kernel_nofault needs instrument_memcpy_before() which handles
> KASAN, KCSAN checks for src, dst address, whereas for __put_kernel_nofaul=
t
> macro, instrument_write() check should be enough as it's validated via
> kmsan_copy_to_user() in instrument_put_user().
>
> __get_user_size was appended with instrument_get_user() for KMSAN check i=
n
> commit 888f84a6da4d("x86: asm: instrument usercopy in get_user() and
> put_user()") but only for CONFIG_CC_HAS_ASM_GOTO_OUTPUT.
>
> copy_from_to_kernel_nofault_oob() kunit test triggers 4 KASAN OOB
> bug reports as expected, one for each copy_from/to_kernel_nofault call.
>
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> v3: changed kunit test from UAF to OOB case and git commit message.
> v4: updated a grammar in git commit message.
> ---
>  arch/x86/include/asm/uaccess.h |  4 ++++
>  mm/kasan/kasan_test.c          | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 3a7755c1a441..87fb59071e8c 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -353,6 +353,7 @@ do {                                                 =
                       \
>         default:                                                        \
>                 (x) =3D __get_user_bad();                                =
 \
>         }                                                               \
> +       instrument_get_user(x);                                         \
>  } while (0)

instrument_get_user is KMSAN-related, so I don't think this change
belongs as a part of this patch.

Perhaps Alexander can comment on whether we need to add
instrument_get_user here for KMSAN.

