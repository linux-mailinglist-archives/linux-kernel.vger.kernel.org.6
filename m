Return-Path: <linux-kernel+bounces-186440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1D8CC435
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278751F22F50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019DD7D3E6;
	Wed, 22 May 2024 15:36:32 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC929768EC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392191; cv=none; b=d6UM4TnSCtop0KbXic5v7Pl3KuWkugvPNvzv55HMWMX/CnBrwTl+dUUKeHD4RUCdcXzEcxbIJqF4gkeBZRqRmJQTEgvUUGJimJETbicfuu3CteWbsy8XjytglsuZGHwvlexLOzG+WP6CkF6xjb9kSRRa0YjmHXIMvhGXv9RuzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392191; c=relaxed/simple;
	bh=ULFbJbVKQMWnZ1ms7vRd/YXmVFPFapk+Fu4aJyVk1Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFodIP/gTtT5iaEXmhyILNzJQxnOCPce6kClvC9/aqWsbbA7Mx0cZIAr+CbN2XW74zB8dSTWKY5eX+yv9rpHzJEY4nLYjjqsOxY2HJf7zuxCm1LYOrnDnGd1fYo2tPpku5RRsqfHqZvkIQJmV9XDKNEKVZRluW8gDbKt2y+RUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61804067da0so9779387b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392188; x=1716996988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rBlAy4O9Lv/8JE6GkQCoKCu1hP1DJWjgLhKz1QEi/g=;
        b=bVcKAU2EKuH6vr+0TkKvOu/jc5s8o8II0IlfwZGgxg4xqjAgeZEEnyvzwZGNOi6w9u
         67QRRfpGGfJ9Z8rX6UAyb6+Z7nfmvRMhF2GT74A6vOYEwYJhg0jju/s6AHuZ4YFd69fC
         5aZOIOwHzcF6rTVoh6fYlvv7s6YjNpxEyxOFgMRMfvmtQBSVMcUrq/gB4frH48E6NVeE
         FZTuuIfJYw3ravIPioXgNDHix7CA5LvwflSF7iaB5fRARXWDOMnklGTVL9zLJ4QdcTzQ
         pNgkWK4iTTKVCLmFwcPDJ4U5WqSJDVaWGcf6p4QBHVLB6PRNM8lBVmSGqhORK91jsNmh
         DJXw==
X-Gm-Message-State: AOJu0YxkY3541Wi72fAmdpgH7LgQowC2yKR0XHvKoPW+gCteUkpyaQ+X
	o8N0z5Ew+ehN7rTRjpicwIZKeHnEgIYUKM5Vf4bENCnwHmwEikcJCx/is/OC
X-Google-Smtp-Source: AGHT+IGBb/g68Rs+GTvSoaGZj+8rQG55UfsO9Fje7NvqXXTO92ltwP0gWtUpoe1G0ptv+qJpiuILjQ==
X-Received: by 2002:a0d:cb94:0:b0:61b:1c75:2077 with SMTP id 00721157ae682-627e4623210mr26271197b3.7.1716392187972;
        Wed, 22 May 2024 08:36:27 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e25483dsm59231797b3.46.2024.05.22.08.36.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 08:36:27 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61804067da0so9779017b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:36:27 -0700 (PDT)
X-Received: by 2002:a05:690c:6513:b0:61a:da7e:1f66 with SMTP id
 00721157ae682-627e462389bmr27860127b3.2.1716392187488; Wed, 22 May 2024
 08:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521111958.2384173-1-Jason@zx2c4.com> <20240521111958.2384173-4-Jason@zx2c4.com>
In-Reply-To: <20240521111958.2384173-4-Jason@zx2c4.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 May 2024 17:36:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwVuVfAwDJkMNZFj+_+dKHFf1MX1=wrchUhHfKoP0Z6w@mail.gmail.com>
Message-ID: <CAMuHMdUwVuVfAwDJkMNZFj+_+dKHFf1MX1=wrchUhHfKoP0Z6w@mail.gmail.com>
Subject: Re: [PATCH v15 3/5] arch: allocate vgetrandom_alloc() syscall number
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:21=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> Add vgetrandom_alloc() as syscall 462 (or 572 on alpha) by adding it to
> all of the various syscall.tbl and unistd.h files.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

>  arch/m68k/kernel/syscalls/syscall.tbl               | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

