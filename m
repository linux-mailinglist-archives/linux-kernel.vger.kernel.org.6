Return-Path: <linux-kernel+bounces-238128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5689243E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF3C281C95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42AE1BD504;
	Tue,  2 Jul 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h5vqyz1D"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6F14293
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938852; cv=none; b=K0E+qlcaOmJEjnVGw0m64lCt5wbqNVxkXC46Svi1fY3t+Mq4nloidPGfc9/YTIOomPP2c8WMJrarqdjoYTp8xGt38KoVDVuKuuXy9E/XFlOMc1RAVvOZA4D21V/gGIGZ8Fm4ygoMKV5Fw03okZ7CUPV/qziM8e+IgRg0Gh9MBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938852; c=relaxed/simple;
	bh=JJCfUnxAyde8Pswp5C9S3wRVqYZag4IPQp284yiV5vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWHQjSW1NFdSbzfVIuTzMMD0RVCuj++TfNUsUecSjD2dldmC1QDm4+Q5Y402kaeJSss5Ntm6YJeW81nDEMrj++olHRj2dw4nj2Sbtn3mdPF3eYTuTBs+stB1G7wYhVmc691WJy1dQBhueC2joy6kjwu9C5PiBByXvyyRBMJIgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h5vqyz1D; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a72510ebc3fso660672066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719938849; x=1720543649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UuomGKlgZ/JCx5qkaXWQw7kYZlgSwRcXF7z8kwqPXBk=;
        b=h5vqyz1DRsftpyxKkD9cb4GypkvPCtLf4FGe324VQPbUDykBL0XkZ8Bcc0kmFAtTRp
         +2YkNN0xQSLvuKesoYImHDpcPkRfcIGA9mUethWQ/2lYxu1OQt6tuQfTZC3iENF77L/T
         lPmPCxX2zgs26nOy4iKxYPjx4XK8RC9GdxY+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719938849; x=1720543649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuomGKlgZ/JCx5qkaXWQw7kYZlgSwRcXF7z8kwqPXBk=;
        b=uhKFweFhI97eJNiOgd9Oh5ciWhqdX0pGx6KtJAxdsm2e7QPapQF3gY+vvzf//4gTyJ
         56pM5h7lbAx8sx1guTlraUr9F4u0cZeq34/Wp786YhC/bkBj/RPUAo9538COaItxpL23
         /JpXR9Z8aeWxNidj95zyP9d1kk0BV80ee+WRB14JnjM8LZQjbJMRvS7tZ2sVHf9kaOTi
         LtqYMgzrCwbsoRyE9Lxcj/xlTFzgf0EcXyID6IdpbrYIXMczg1jA9DFQnbcOCinHaP1Q
         SSFLUujF3LBUTnU2th9XfRYfsBHyU4lrLCDEB+/bqxR4Uy4/Ue1Ye5d0LvsN1waR8elO
         lWhg==
X-Forwarded-Encrypted: i=1; AJvYcCUcAjDRCN6qxWc6Hmo1TBR0x2GEf9ZZdm82KiTIQ9GTRXzEiF5x1yWYmmkPgxeXYqcUJaxB6htuyKO9HbtHVxhb0lJ2/dPiV43QlR/h
X-Gm-Message-State: AOJu0Yyu50Yk860bzzeH5ruep1f4rmxuGeEyW4eLRbMfmBWc7rPmOB3w
	aRY/+MsGn2zc1xqBU8B+kmjlAck7jYhfy9SMFyHRh8nBWjMJBAdQJ9G+6lt5JVl0u1wn5ryVyL3
	n6Dpmrw==
X-Google-Smtp-Source: AGHT+IHn72Km8gh8b+M+Oo+Qep3P/a3KA8N+PocPmHBVOgi5h5uGIHhgkqUa3jRcvTjM0xoE5q2t0g==
X-Received: by 2002:a17:906:6807:b0:a72:41e7:a28 with SMTP id a640c23a62f3a-a75144dd4f9mr605089466b.64.1719938849151;
        Tue, 02 Jul 2024 09:47:29 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b4d59sm437298266b.189.2024.07.02.09.47.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:47:28 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7241b2fe79so488896766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:47:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxsF9I82vw/EQeyF91hXFx1OT6F/a1z0Svv4CyasP4g9A3S+/abEMm2B9TDp1l7VkhFpyKsoIzHfbWccErIqFlg1LUvCmVEW+neJSu
X-Received: by 2002:a17:906:c2ce:b0:a6f:493d:5b9f with SMTP id
 a640c23a62f3a-a7514474146mr573370666b.35.1719938848162; Tue, 02 Jul 2024
 09:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
In-Reply-To: <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jul 2024 09:47:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
Message-ID: <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 05:10, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Well there is also the option of going full RCU in the fast path, which
> I mentioned last time around lockref.
>
> This would be applicable at least for stat, fstatx, readlink and access
> syscalls.

Yes. That would be the optimal thing - have some "don't take a lockref
on the last component at all, because we will finish the use of it
under RCU".

I looked at that some time ago, and it didn't look _horrendous_ from a
conceptual standpoint, but the details just got to be nasty.

What I wanted to do was to hook into the "we're still in RCU mode"
with a callback that stat could set.

And we'd call it at complete_walk() -> try_to_unlazy() ->
legitimize_path() time just before we do that lockref_get_not_dead()
thing.

So then the path walkers that are ok with RCU state (ie mostly just
'stat()' and friends) could set that callback, and get a callback
while the path walk is still in RCU mode, and could fill in the stat
data then and say "I'm done" and we'd never actually finalize the path
at all, and never do the final lockref_get_not_dead().

Sounds simple in theory. And then when I looked at doing the actual
code patch, I ended up just running away scared.

           Linus

