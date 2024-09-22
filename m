Return-Path: <linux-kernel+bounces-335130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4497E170
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDEA281446
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045E17622D;
	Sun, 22 Sep 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gACPEqnC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74C179A3
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727006684; cv=none; b=aA1I6MF8p4wq1FBlQlLtf2XwyqrqRal+0cE5ZsqpDAz3qKY9gXY9+XK3UAsChRSF5BhGtiS0XHV5MvFoAETUwjBAYAnN1wV19T4gyjlJBx8OqkHXZQeANiv0H2v44nqj79GmTeun388Jbl7JaZcrTSutwsYDH1EWyg3V8DD25tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727006684; c=relaxed/simple;
	bh=RBEPlNYF+wUU1oRD6OHrayxuYaCQspJdH4WFCZ/gD0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axuVq1sK9T6whNIRFS+9BmH91zV499O8N1OqeVpZzkdg/fI5727UV8R7M33gLXck+N4eG0lagwKVU3fq/gnWTkfEkf4t26GlE5z1moVsLIRjo/wHO+KA85OfH2Je9UsX6bwoZuZAiFeWJZxWER9dKiXqyn2QkV/+/aCFy1jqPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gACPEqnC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb806623eso28333655e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727006681; x=1727611481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBEPlNYF+wUU1oRD6OHrayxuYaCQspJdH4WFCZ/gD0I=;
        b=gACPEqnC8UdVewt2bwb+M6DRp1PwHBIArYfKUZ+9UDXJXLN6BSvEV0rZJ/3eNkt6c0
         kaVn+HB31eYHD5tnPds8aeD8N4bp2+gocFkna1OwN/DRVPRsf40po8k/l8+jZBy1EzQz
         A1x+g0fA857ZxGO0Q+dvP/EtqGkrpNzXHFfDLxj8q/IH6Za9Vw7YRVSf4RtBj3xA5zfP
         JTbrpYMx2n4N0Sg16lttVYkvqdzxaTpKUHIQPzbsg6yir4AtILTLuUCn+cHsDRhsqrc8
         iIDVSko9qoyz0NVDSq6OG4InReR6zTh7QNTKsIye02LyS8a72t417fGV6YVv6uk0xSAK
         rPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727006681; x=1727611481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBEPlNYF+wUU1oRD6OHrayxuYaCQspJdH4WFCZ/gD0I=;
        b=urUEuzcUfEoLrhvQ/Wh6Q0OCYyhxqfteBn+ZpgGSYsGnSq8B80hMmqXeUD4qYrbq1v
         Ahc1dvFvi5NqCTaASUcIvlhWBLyudTRyRvfDa3ixGtOLtM9aQII4EJULvXiH416/9oZO
         i9ogEgBbbIAsexeeXZzDHcHtHeb4BPPa9TAdKQAQI3ViNjY4nl7OnlF4N3k5if2j/ZkZ
         4ZDoshLKILTKTZawZ91sJM0a3RMDVIJaE0pTrwBBS3LJrC6OwtXJRItu3Has+YWQ1jn5
         4FCbn91Mlm0ad6a9hLXRQSHymdO+015HlyuUvk1qMPAr6TzmAHhnJUxt9FDaUQ9XOIt7
         +Ajg==
X-Forwarded-Encrypted: i=1; AJvYcCV/iphJjDE3EQktAUT7oCFQXZjtmw37fCjy/68sME7vSixTvhiK1a28xk6MylmvJJ0jOCu62mEy2w/qmP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pSPz9sKO6ZQxNim5A4xTkMGlvfXRAO4+fNHBnSvxF4iQ0Rah
	KWlY9rjP+yKDhzDzGgmR6fHeUmbn/K3LmV/4nXvKhje7NgCeDoU5GG8QTYCYC3DrP685VqSvweO
	Fb/h5ZhSyrc94Elfol7UdcDu6E4E=
X-Google-Smtp-Source: AGHT+IEMkYivBBLCu45KwOxOr1zlBQuXYCIPWCIVHkwszKB/mQ1UOqREqYbpX2MLZHyEse9IAwbi7RS164qLT8lftkY=
X-Received: by 2002:a05:600c:15d4:b0:42c:b22e:fc23 with SMTP id
 5b1f17b1804b1-42e7e7aa2ccmr43532325e9.15.1727006680647; Sun, 22 Sep 2024
 05:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZeiVRiO76h+RR+uKkWNNGGNsVt_yRGGod+fmC8O519T+g@mail.gmail.com>
 <20240921071005.909660-1-snovitoll@gmail.com> <CA+fCnZfQT3j=GpomTZU3pa-OiQXMOGX1tOpGdmdpMWy4a7XVEw@mail.gmail.com>
 <CACzwLxjZ33r2aCKromHP++2sLjWAQ9evF5kZQCx2poty=+N_3Q@mail.gmail.com>
In-Reply-To: <CACzwLxjZ33r2aCKromHP++2sLjWAQ9evF5kZQCx2poty=+N_3Q@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 22 Sep 2024 14:04:29 +0200
Message-ID: <CA+fCnZfaZGowWPE8kMeTY60n7BCFT2q4+Z2EJ92YB_+7+OUo7Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm: x86: instrument __get/__put_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, 
	glider@google.com, hpa@zytor.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	ryabinin.a.a@gmail.com, tglx@linutronix.de, vincenzo.frascino@arm.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 11:26=E2=80=AFAM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> On Sun, Sep 22, 2024 at 1:49=E2=80=AFAM Andrey Konovalov <andreyknvl@gmai=
l.com> wrote:
> >
> > I tried running the tests with this patch applied, but unfortunately
> > the added test fails on arm64, most likely due to missing annotations
> > in arm64 asm code.
>
> Thanks for testing it on arm64. I've checked other arch and found out
> that only s390, x86 are using <linux/instrumented.h> header with
> KASAN and friends in annotations. <linux/kasan-checks.h> is in arm64 and =
x86.
>
> While the current [PATCH v4] has x86 only instrumentations for
> __get/put_kernel_nofault, I think, we can take as an example copy_from_us=
er
> solution here:
>
> https://elixir.bootlin.com/linux/v6.11-rc7/source/include/linux/uaccess.h=
#L162-L164
>
> , which should be a generic instrumentation of __get/put_kernel_nofault
> for all arch. I can try to make a separate PATCH with this solution.

_inline_copy_from_user appears to only be called for non-kernel
variants of copy_from_user, so you would need something different.

> > We need to either mark the added test as x86-only via
> > KASAN_TEST_NEEDS_CONFIG_ON or add annotations for arm64.
> >
> > With annotations for arm64, the test might still fail for other
> > architectures, but I think that's fine: hopefully relevant people will
> > add annotations in time. But I consider both x86 and arm64 important,
> > so we should keep the tests working there.
> >
> > If you decide to add annotations for arm64, please also test both
> > KASAN_SW_TAGS and KASAN_HW_TAGS modes.
>
> Please suggest if the solution above to make a generic instrumentation of
> __get/put_kernel_nofault is suitable.

I think the approach you have taken with adding instrument_read/write
into arch code is fine, we just need to do this for all arches.

An alternative would be common wrapper macros that calls
__get/put_kernel_nofault + instrument_read/write.

> Otherwise, for this patch as you've suggested, we can add
> KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_X86);
> to make sure that kunit test is for x86 only and I can add arm64 kasan-ch=
ecks
> with SW, HW tags in separate "mm, arm64" PATCH.

Sounds good too.

