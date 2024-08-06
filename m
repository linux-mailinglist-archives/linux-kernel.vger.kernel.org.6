Return-Path: <linux-kernel+bounces-275607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833D948786
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E9D1F21DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DCA34545;
	Tue,  6 Aug 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hswbaazx"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070C383A5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910913; cv=none; b=uAMzl9pv8XRnFqJ5BrMiqrgeodJW7Nj4uJOOfjrrHtjZyywVtpxfl78Dnw6QG9jl4ihHJPqk90dCkqIqvADsHx3oZRcXEeLeQkaN5wzAyFa97MPPVuFNoNyMOTEuKyiZYTAZUkOY6q5A06HGcJZPF5xIt2i4m2OviSdgc/6TbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910913; c=relaxed/simple;
	bh=a9Vp+4x2A4ioCvdcdJD7sOUfBOazJEHoNcUHQ9qx7zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDvCYui7oQqhDIn8jEOX5EQcGQtCsgw7mw/T80EA5W2dko5SafPaouVfDmfgyG7xP0ckXV3vBDUMKFD+5Wj+KjVWsQDPkMz5nfgoOlPabmwYxDaNzf5ZPMQNK1mmEe3GujZbBFvPUKmS/NaMx1FFBCzmYDeCRDlL1yGNYoGBKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hswbaazx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367990aaef3so37431f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722910910; x=1723515710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIFbxMpiXxHdMqbCN+3/gUCx3hbdMfLnZFy+ZXlHFxY=;
        b=hswbaazxzLUQ2/JtUyGf1P3Ow7RcxZ8V+XuD7MoRTsD0YVogqHYRf50xT/slhJi4PP
         SRv2CMF/yxvL2k4xSgWis6nwM0fvPQAHJU/AOiopFxpf2D3rFKa+MwLjDcIZNHRMJJNL
         aJhkrQQduY4zxpRlQLhbwfukpboBV6NnCc9N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910910; x=1723515710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIFbxMpiXxHdMqbCN+3/gUCx3hbdMfLnZFy+ZXlHFxY=;
        b=MCTnwaCiz0tyw6xVXlIXxgTJmVpy8hUXunep/GNO5l2i3rk8I9l8Ffdkcca5YeL6NN
         nj/YEGbm0+m7qhGHNfv6Vx6Xgb7/XDrAdb6IHuKieD5EnRa03G3xgUV4oOspWTQALcsM
         8AnrLmk1BLgoGuHTW74J+fZIB9V661IjJpyJWVaGAk0n1nBFle8ve3A50jLzYBbMup/6
         e4RvKC/QoEllEpP3i3yFc/gRXS0kvRrgx8ThrsPKHrvkjSgGyn3e1N9aF04GIxF7x4Ge
         hX4jnnil+VzXaTny44AHW7jhjc/ciUeqbThEtrnQDQDmp8IOyUpaNyjkHtrb88dhn4xo
         ntIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7aPPm/CsewUOLUDlmvk74icFZHtlQgIQI/9qjLG3wQRez9Z8HGzVPT7FavhAayFkkdAUabm40hrD9jw/vbyvo0xArhUjQk6WOiNj
X-Gm-Message-State: AOJu0YzwNBm8XJWE5Kv3vgEC8Q5VaXSaj2BVSjaE2I+CHw0eGkyobNKo
	BQMmPU7kkNyH7yHx/X30zpBrqo0ic/peL81uBidf5FWCZ3BjMYM4Gww7RXyDfy9FjzR2n9KDPuG
	Epz0u7g==
X-Google-Smtp-Source: AGHT+IGA6UG47cBQ+hYG7oj/1OlYm4YLaI5ImJCbhvfH9+NHPN5zaebql9ePe+4qaUPjD1cjlGei9A==
X-Received: by 2002:adf:eb12:0:b0:368:4226:4085 with SMTP id ffacd0b85a97d-36bbc0c4bb4mr7421861f8f.8.1722910909873;
        Mon, 05 Aug 2024 19:21:49 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc2asm505855366b.63.2024.08.05.19.21.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 19:21:49 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso505605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:21:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxeSVckzrfAmM9XIleVtUY3+QutAzWix61Ncvgju7ZP88aVY9VB+goGMUGgv17G4TqtYfAYg8aClp0jeRwX94EMabG1K2iBfxE5vZP
X-Received: by 2002:aa7:cb43:0:b0:5aa:19b1:ffde with SMTP id
 4fb4d7f45d1cf-5b7f59e20a8mr9459334a12.34.1722910549350; Mon, 05 Aug 2024
 19:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
 <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com> <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
 <87r0b2if4t.fsf@mail.lhotse>
In-Reply-To: <87r0b2if4t.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 19:15:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibKvw92keueGCUpr428BvhgEwoJxXow2NyBq2LiRGhFw@mail.gmail.com>
Message-ID: <CAHk-=wibKvw92keueGCUpr428BvhgEwoJxXow2NyBq2LiRGhFw@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 19:01, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> >
> > I just don't quite know _why_ powerpc cares.
>
> AFAIK for CRIU the problem is signal delivery:

Hmm. Well, the patch I sent out should keep it all working.

In fact, to some degree it would make it much more straightforward for
other architectures to do the same thing.

Instead of a random "arch_munmap()" hack, it's a fairly reasonable
_install_special_mapping() extension.

That said, the *other* thing I don't really understand is the strange
"we have to set the context.vdso value before calling
install_special_mapping":

        /*
         * Put vDSO base into mm struct. We need to do this before calling
         * install_special_mapping or the perf counter mmap tracking code
         * will fail to recognise it as a vDSO.
         */

and that looks odd too.

Anyway, I wish we could just get rid of all the horrible signal restore crap.

We used to just put it in the stack, and that worked really well apart
from the whole WX thing.

I wonder if we should just go back to that, and turn the resulting
"page fault due to non-executable stack" into a "sigreturn system
call".

And yes, SA_RESTORER is the right thing. It's basically just user
space telling us where it is. And happily, on x86-64 we just forced
the issue, and we do

        /* x86-64 should always use SA_RESTORER. */
        if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
                return -EFAULT;

so you literally cannot have signals without it.

             Linus

