Return-Path: <linux-kernel+bounces-425958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F99DECF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3D916119D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CC197A7F;
	Fri, 29 Nov 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cq4w+HVZ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092263224
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915919; cv=none; b=aACuCSJ3L4VsY5fOhP4ZhFbVlAyvOIPvGYPVFCzPBWdkp3er+PlR4T0mPByI/OVfwa05zbWz4dyiLT7b/4kRtSqL/GXhbLRWt2Rwq7AhllKNBb8v4e9Cd1LUVcpLNsdSrV3SwTx3hLYJuUBHujaHHujD6wtdPU1//mOs/JC0q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915919; c=relaxed/simple;
	bh=c/4BzfBqscpxnHhCiNMK+dGOonD7WwQs3o3D8ZG/Vos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR0Pop2UF75fp+6d5hEPCO6fLW9UatQ6unNC1vpv1UJyQsB4navtIC+kbMY50Wo82Bzl2tyKpfRYCQz7Uz8NvdxRhl1vpglGA7WKixoJ2ysCmwmzTNl8Xf8dUsUKBwy5GzRqZUKJETKhqG5N/3om+lpJqCny6JAusXhapv42bwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cq4w+HVZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so262770866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732915915; x=1733520715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tzXAb2AynyjsC1brv/v5xtyGzPL78eXMtSvB4G/f/z4=;
        b=Cq4w+HVZihaTxA1i6jIVkJgKYygoBmyO2MBITP4ewRylJx0mk+XfCroPyGgp07Wm4Q
         UIv3T/uNNnenyXmbRx8jcVXElrk5VJSK/Xfc/iJGktHfbz9Ar/SnYF5ODNHtxwCp1rut
         E2qDFKn5pusNCXeL6+E5nIinsKLs/xvWOUFmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915915; x=1733520715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzXAb2AynyjsC1brv/v5xtyGzPL78eXMtSvB4G/f/z4=;
        b=rSkkG5erRamYNy0cXpgkphQY4MS3SJE1nAGGvzA3/9231zZt/LgUBGv8nQ30zH4clG
         52heliRUBrVWeVBRxbpK6ryEymTLhZdpIB8h61ZvSq5VCxYY588Yic3PTKxTpbNuC2at
         MPrrUOp1oOrp/IdiG4+3qk7ki8Ek/2MnraFJGMNg2/WP+Gw1cUV00Z+G9h0f7FimL4EN
         wBiS1ze25ySiGi9H2PJcQPcqMSn9HCGhBvPXK+X+2ZzxyxIaShoA45E3/zFw9rrxYJCi
         4BdZIzh8ptqWfzDp1/ho0wWAHkKhvves9U0vrGi6YGlgoKyd5YeRywMBLtCtBH7djp00
         MWmA==
X-Forwarded-Encrypted: i=1; AJvYcCX3GzMlJAvTsyzQdfHzYtMoc9WXY9jj9U03IPaPsUlJRD2s/wRbnYdUEoH0xP2AfNwG5/zzR0tXQIjPaO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE42cc2BugabTYTr0BrBXupmFATVp6vHMDGqwrMfOybhiDiu02
	wxm25ojfPcz7WP6kiYwcBZE0OtdgE4WR3xQX1oPbRXK5Wg3LiXTRZfBclwXxtd8dvisGqLBKba2
	hXsQgpg==
X-Gm-Gg: ASbGncvOmHv6wwSHLxa5tMYGfil3VW61q1BAglb6yXIm7auwjIFn7vz/CiKNC06wbiO
	9xmHygq57C/B1rKFCBn2LEoRwsBQY783spi34WSbqdxowned+BRehnU9vM5RLbZw1NpZRHdk5vg
	qT5ik7q3FMzdgyvffAOLikRrd+7jsZJa9dxB1r7TOCmR8WT8VnCNIlpbpEjzEbfCjDXZeiuL4BT
	DDi4YFhZ5//XngfgLQF8OYDD4IjDkQjKLmTdc1GEXAlo0BpU8KsWtVQLTo8OWWVMJ3+TI11qRwU
	MjnD6LxuzV+shbj2JXmWcrEn
X-Google-Smtp-Source: AGHT+IFY4rK5GfJlHroBPvwyLLIsIO7bLwmXbcuHRp40Uy/XTqyigPpWqq7O92JFjgCCUFaAMMSVPQ==
X-Received: by 2002:a17:906:31ca:b0:aa5:4b94:cc2e with SMTP id a640c23a62f3a-aa580f33394mr1129410666b.29.1732915915223;
        Fri, 29 Nov 2024 13:31:55 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599955e1fsm213480366b.180.2024.11.29.13.31.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 13:31:54 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa520699becso330504766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:31:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmE2a+ffoBv7kVY2IIFBjl7wTAyHgCJOTDBJYaVs0jrroDZ9y9ZMUbJmiT1brp52wAI0joOAeQX4XXTvA=@vger.kernel.org
X-Received: by 2002:a17:906:18aa:b0:aa5:2c1b:d2cd with SMTP id
 a640c23a62f3a-aa580f353c5mr803914866b.34.1732915914141; Fri, 29 Nov 2024
 13:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzpFOhQN3yCb4+OpLsfYVrq4mLuUS+SP=H=gq=qSLDz7g@mail.gmail.com>
In-Reply-To: <CAPM=9tzpFOhQN3yCb4+OpLsfYVrq4mLuUS+SP=H=gq=qSLDz7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 13:31:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh74-reWGqpP+i3O8usrS1Jr12UGGMCfaK58_0aK5Lw_Q@mail.gmail.com>
Message-ID: <CAHk-=wh74-reWGqpP+i3O8usrS1Jr12UGGMCfaK58_0aK5Lw_Q@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.13-rc1
To: Dave Airlie <airlied@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Sasha Levin <sashal@kernel.org>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 12:42, Dave Airlie <airlied@gmail.com> wrote:
>
> Merge window fixes, mostly amdgpu and xe, with a few other minor ones,
> all looks fairly normal,

Hmm. I've pulled this, but do note the report by Sasha.

The

        if (WARN_ON(!work->func))
                return false;

from __flush_work() looks odd, and is fairly obviously triggered by
this one liner in commit 93df74873703 ("drm/amdgpu/jpeg: cancel the
jpeg worker")

-       bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+       bool set_clocks = !cancel_delayed_work_sync(&adev->jpeg.idle_work);

where apparently the jpeg.idle_work isn't initialized at that point.

It looks like the initialization is done by amdgpu_jpeg_sw_init(), and
it looks like that cancel_delayed_work_sync() is just done too early.
But I don't know the code. Alex?

The other report by Sasha seems to be a 32-bit issue, where something
calls roundup_pow_of_two() on a thing that would round up past the
32-bit limit. Presumably it works on 64-bit.

But I'm not seeing anything that looks like a likely *cause* of the new warning.

There's a couple possible cases, although this one looks suspicious:

        adev->vm_manager.max_pfn = (uint64_t)vm_size << 18;

        tmp = roundup_pow_of_two(adev->vm_manager.max_pfn);

because it explicitly uses 64-bit types for that max_pfn thing, but
then does that roundup_pow_of_two() that only works on "unsigned
long".

Sasha - it would help if your warning stack dumps had line numbers
(using decode_stacktrace.sh, which you should be familiar with, since
you wrote it...)

I realize that requires some debug info, which might slow down builds
etc, but it would be really nice.

          Linus

