Return-Path: <linux-kernel+bounces-215023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B9908D61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C361C24FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E029C157;
	Fri, 14 Jun 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJXqKvVP"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4199441
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375370; cv=none; b=Fac4ufyFY1Jv/4se7hLpQ+cOLZQB75x5AatmnsIQvHELfbWZ5+4RgPDgxZlSzxwXFJhG79ArQ913XAhNT+Ybz6Sq92Fe/965s6Q1g/srlDsxIGfKAtCPjRHkm1QrqNiFRF3GDorl/QT5jDciHPv/4fWt9akK9CZ2oTGhbV0ToFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375370; c=relaxed/simple;
	bh=Go5NY9rjfYwbYnHuccpPke/peZaXSvphcukgyXADAjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ora0zc7M0NlTGHV/OgS2OtDNOo4UOLj1J05UXEJP4Uqx1ZdM9ikg5zuqS67d3t8R5x0SKd1tzOKf5qCfvW9NMMZQhPHcLK1T3jTYPKNZBulNmg6uMwSPLs8S/WU7ItXmjfF0fL8RulTzQgqh+Y3zJXc9mp9X6RgQvFVEOy0Z1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJXqKvVP; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4eb5eabea6bso502632e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718375368; x=1718980168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+M4MVfQsxov5VdJSZaNFx/kfeT/vurY02zgZoKqlOZY=;
        b=wJXqKvVPFd4J4/8MT61h4JTuC3bibOg4StivXf1Pwys6VTgVIxwwh5m+8gObt+tHFC
         BAgIqscMdaKUwRl17Tn+IE5vVFPSIa0YiGJU3yoYrkzahT7mOVj0EuM/Gwrhu01PoMYL
         iGgT/u3fofleZMVN2BzPC7jQyrDnL4STbcQL9uRFxukj/fvVBkFqWPYdUvQhx8iwAQba
         RPqhXGDyYT5HLr6V8qIRhjpybFqg41+jG5HS5RHDo9rwTGQvInSYTxynyygevfUCub7T
         SJuTVBwmllHi7ntUnW6vQOgVR6nLaiHaUT1cMvj4prQUb2p9rYhXzZm53GGh/wQkPBz5
         pPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718375368; x=1718980168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+M4MVfQsxov5VdJSZaNFx/kfeT/vurY02zgZoKqlOZY=;
        b=wYVD+53/AErnvM+cE5Qtj68xanYrN/l7fuOLtH6fmpSX+9vdh25yBoxSNscS/37265
         Z1cq5qbA4YvGFiRBD5Hbo0Qf89QkGY0yIqzwUCfBAy7Q8/HH1d3wAzXlEvEraShODtSm
         0SWNedpjSHpsUVa9A0APW2hF9mMV2fhPhSpeGubHLTcdR9So3gdn6kCX9paCbj/S3cym
         BoNEEkAyN8UkKRAH9whNe7HLLrzrMbLm7MfuHty9rP6ZDBBAZ8B30Vo9UT8Zc+R4cbrb
         h9aBhfLRKl8+TdwnRR4jrZFNxEAS4c69DCuIs/tCmBRbAzNZVaQINebx3O0Wf2rPGwcq
         ne0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc0W3Gb8g+7o82lMbznvOyfQDKdQyAWch2JfhpTFH1FGbDc/BL7yXmrQghF+8nhKAleidYRl3Sg2gyNBUj5Q/LAcigRXmek6vyyZiO
X-Gm-Message-State: AOJu0YyrEZBWD0HwWZd0upN20Y2BqBkVd5bmqGVBGZzYGx7RJSQ+PUy/
	MvL3EhsGwH9kJ6/RAu6VFC/caH5/ST8lp8oRtHR+ivXVhSAx4lX9Ps93IUL6FPN9bvmM+K6IrDF
	eKe3RH1tNvQlLuPe1svE6GK8Kt1krPE1C8/qM
X-Google-Smtp-Source: AGHT+IFvLtBsNkt/EHH9zb4a3GIp+wU2qWyVRWUEWGarYvJcHCO7wVvPBLT5A6iMQRK8HeLel0TcH1bgkYM/oBsiR/k=
X-Received: by 2002:a05:6122:1d8d:b0:4d3:3a0f:77ce with SMTP id
 71dfb90a1353d-4ee407328c8mr3639955e0c.13.1718375367706; Fri, 14 Jun 2024
 07:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614141640.59324-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240614141640.59324-1-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Fri, 14 Jun 2024 16:28:48 +0200
Message-ID: <CANpmjNO0T-sooJYs2ZCAzFUs6NVkV7iacY=hzB0JtGAyKhEmzw@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix bad call to unpoison_slab_object
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Brad Spengler <spender@grsecurity.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 16:16, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> Commit 29d7355a9d05 ("kasan: save alloc stack traces for mempool") messed
> up one of the calls to unpoison_slab_object: the last two arguments are
> supposed to be GFP flags and whether to init the object memory.
>
> Fix the call.
>
> Without this fix, unpoison_slab_object provides the object's size as
> GFP flags to unpoison_slab_object, which can cause LOCKDEP reports
> (and probably other issues).
>
> Fixes: 29d7355a9d05 ("kasan: save alloc stack traces for mempool")
> Reported-by: Brad Spengler <spender@grsecurity.net>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Oof.

Acked-by: Marco Elver <elver@google.com>

mm needs explicit Cc: stable, right? If so, we better add Cc: stable as well.

> ---
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index e7c9a4dc89f8..85e7c6b4575c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -532,7 +532,7 @@ void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
>                 return;
>
>         /* Unpoison the object and save alloc info for non-kmalloc() allocations. */
> -       unpoison_slab_object(slab->slab_cache, ptr, size, flags);
> +       unpoison_slab_object(slab->slab_cache, ptr, flags, false);
>
>         /* Poison the redzone and save alloc info for kmalloc() allocations. */
>         if (is_kmalloc_cache(slab->slab_cache))
> --
> 2.25.1
>

