Return-Path: <linux-kernel+bounces-207400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EA6901689
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E261F2196F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED2F3FB3B;
	Sun,  9 Jun 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LrH9hwc5"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9D45BF1
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948075; cv=none; b=RGgdBDApZX7ahyjNHhQFd9szRF6AEwgcSXJoLQM5qh8nrtJzFrVnFn8JOmCQ5MpLAJ/M4h94fvb71J+/3M3wpJS+SVPhMyhlhYY4sHZfKl11TzN12LGUMcH8WMVmVYGxiGNpg954acmaR1iTZPCjSWuT0FXR7aWYjghRCZVu8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948075; c=relaxed/simple;
	bh=rWELLHoGeL+cuZcwTGrspQgmi3NpQFHoFf+sewYQBwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9RJRr73QqP1kpgb3PkvQFLYfIxF1Gud2HlhVBqQ5oZKehDhdFbWwMvHE797ddYWQNT9CZ6FGpi/J6Fblb1WaTbu/wZzondoduo3Pmz4aPo9CJFo7DRfm3mVblRIHrv2ON+F7b9YW2w1wDDilTyUlQpzaaXFNVdNDX6LT79sAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LrH9hwc5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6ef8e62935so189749066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717948071; x=1718552871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj9Z56DW6+nSHM9dJZ7yiVMylhEQOTIVepZXRaOEBmQ=;
        b=LrH9hwc5MpaI3dJuoPY73fPwi8F4SL/HfR+UgVr/swwFfBxChNmiwhJuWhmYsKksv9
         ftKi563hZTQlZqEHXOgY5T8AAcJxuhYurwHiylXmQbaa583DfKCcJuNFNmR1A+v6/dhC
         4AMERydO/hXUrgGeeBrzZJK7hGRUS82aF9mJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717948071; x=1718552871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj9Z56DW6+nSHM9dJZ7yiVMylhEQOTIVepZXRaOEBmQ=;
        b=fM2DW2yo+I6h0xbXC7hzybZkmtgXT+59jzu+UpkLskOp8Zp4Hrthgb/9BnhE0JjoXv
         5TpfSdTrMTrr1+mQFffTz6eCKeoWH3OKkh+qJ34ZbU4mkryOrXd0f8XA1HHQLpgbfQOl
         Hk6UvW+y6IJGDyyzlev+dJG9K/WDf3Bl/lNYx33R4uQyaEOjj0jOwIYL5XplwlBwoSZ3
         QyWEEWt5wEJEMiW0amR3CxlFI0ko3ojwjoPvQz89HILzGN0bvlehOUvHKwoCfnAg6eAf
         +XGm69HAdTHWPyl0CSjXxedbiIAQ1hSbGP/ZghTH3E0XbAsSyzk/P3JrvF5yK/nkdSxq
         VOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9JLVRmGzgykA6FX1GaCggtHBWG5sVnHM3YkFLqDNO7Yeq70900yQDwUljcJ4P5zL9CWGCuxMCsENZNnGTytkFES7aWpgkb8sF8g2P
X-Gm-Message-State: AOJu0YypLLWK+C7Mx5CRnd/y5JktHfoAbxJITadFFJ5EelSNl8h0ShIJ
	ciBhdHzRJtbV6aP+Jm//anPjqCdTfUnJxPuGkJ07y3G5NFi6lFKQgtkA+GVcTV1nQKzMix8Iy+o
	jJHg=
X-Google-Smtp-Source: AGHT+IGTHEhiTPFXw4ZVaEp48NM02RFykdEVCSZ9EGK7qYqRAdbot021nUv1+YtHUN84l49fTx9eqg==
X-Received: by 2002:a17:907:2d27:b0:a6f:1daa:9031 with SMTP id a640c23a62f3a-a6f1daa9cc0mr84513166b.42.1717948071514;
        Sun, 09 Jun 2024 08:47:51 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6e67133de7sm356693866b.57.2024.06.09.08.47.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 08:47:50 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f1da33826so31455866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 08:47:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmLSKHi3oCc4FMdDxMz0OUDxT/g9L0KTsVYercxsduiBWJT/ycdHMQU5QXuC/V7uL+K7txwczDSYh/c5iU2QTPsGuFsJb996F2ZlYN
X-Received: by 2002:a17:907:3ea0:b0:a6f:1b3d:8e0e with SMTP id
 a640c23a62f3a-a6f1b3d9041mr125143666b.25.1717948070458; Sun, 09 Jun 2024
 08:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240609112240.GBZmWQgNQXguD_8Nc8@fat_crate.local> <00BA183C-4EE6-46AE-AEC8-94B612222373@zytor.com>
In-Reply-To: <00BA183C-4EE6-46AE-AEC8-94B612222373@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Jun 2024 08:47:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheiidA4Nib0kY9jje9D_eF05rt8Z36C-QKKpobVg3gRQ@mail.gmail.com>
Message-ID: <CAHk-=wheiidA4Nib0kY9jje9D_eF05rt8Z36C-QKKpobVg3gRQ@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Jun 2024 at 04:48, H. Peter Anvin <hpa@zytor.com> wrote:
>
> So the biggest difference versus what I had in progress was that I had
> the idea of basically doing "ro_after_init" behavior by doing memory
> references until alternatives are run.

Yeah, that would make it a lot more complicated, because now you need
to replace the whole asm, and you need to write it in a way that it
can be replaced with alternate code.

It's a bit akin to what Rasmus' RAI code did, but while I liked
Rasmus' patch,  I honestly don't think there is any advantage to
having that "load from memory" alternate version.

At least for something like the dcache lookup, the "before things have
been initialized" state is that the runtime constant pointer is NULL,
so the pre-init code would cause an oops anyway, even if it had that
"load from memory" fallback.

Now, there may be other uses for these kinds of runtime constants, but
I do think the main one - and the one I wrote this for - is simply a
boot-time allocation. So I think that kind of "before it's
initialized, it won't work whether there's a load from memory or not"
is fairly fundamental.

There are other constants this could be used for - particularly things
like "size of virtual memory". That

  #define task_size_max() \
         ((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)

thing really used to be a big pain back when we used it in every
get_user/put_user call. We replaced it with just the sign bit test,
though, and now it's gone.

(I still see it in profiles in strncpy_from_user(), but it's not
really noticeable, and it's fixable using a similar address masking
thing).

I'd expect that there are other cases than the dcache lookup that
wants this, but none that really show up on any of the profiles _I_
tend to run (but I don't benchmark networking, for example).

There is the security layer blob_sizes "constants" that could possibly
use this, but a part of the cost there is that since they aren't
compile-time constants, the compiler can't just use a common base
pointer.

So even if those were converted to runtime constants, it wouldn't make
the code generation all _that_ much better.

                    Linus

