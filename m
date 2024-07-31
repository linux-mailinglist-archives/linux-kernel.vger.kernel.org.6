Return-Path: <linux-kernel+bounces-269865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2B9437C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796281C227E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA516B3BF;
	Wed, 31 Jul 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VK/nC3ix"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E5208D1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461004; cv=none; b=RkQuLBVNg/gc/JCqzkP8uJTK9ZgNrsDEH0ZmkUHb6fP4FZKAjclXffSxU6ogp5A94O/YblsOpFqwfs/qaDdE4yh5aEiqkm9OFGD+fObJ8tKhF0ouxSY9S3f1elDelr6qUJEXjjT6HdW57/BQUjshPY4z4uB4eTWRYgojyfwSsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461004; c=relaxed/simple;
	bh=EUeCL54Bp4XRGnP3yEj5/WGMsQQ9ejTJX7xHqUNlLCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkLiDHGgF43W9y3vRyuiEfjQD3vIcs5Qh/3eWZw2XpBa/WIy3iyNOn52QvJOhGL4mebtr+wctfpBF/RavBY6mbvc4J1gyIWxWh/idXX69usyVnKurN4Nn6F2Ht9Ks/m9dVlKkgcrbxQ3G2IfxX86z232q09lwfTDqc8VPSLLEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VK/nC3ix; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso92388811fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722461000; x=1723065800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3GK72tzkhlHWJiS3p5Z4EY/UL0oFnnL27t4XIzKVUow=;
        b=VK/nC3ixkGeu9RMJxwe012oyGyzf4yiznZMLiUKgvSct0+VGWYmF+xnXGSIxHVge/a
         6o2ZTXm7Hd+W6tLOpRBrMzgIIpdiqC8jjJThtuWhJwkT/yT6ea5UzfZB7IU4Ty7GgFDW
         p7VmOx04Git0Qnq6GssV76H7dXI6IFnLI7a2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461000; x=1723065800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GK72tzkhlHWJiS3p5Z4EY/UL0oFnnL27t4XIzKVUow=;
        b=mi0YTe0fgksszLpPAtDYndIM5VmK51x7jtkcNDJ2ASElxhq3qB9T5G3LTHZog5ySdo
         2SatBTCTauYh3kpMrBYNKbpUMqbl9KZqAfMnXtl3QwQaUua1lZ5Bf6vTbeE52VRHaeIK
         WyR8uH+m8pr0BVUBqaJJyhTgcH5b/R9zPVbMwVKsz6Vqh0VXryulCZJZwm/y/bXsuBxV
         JZms4dadL4hy3mFbnYiTetF4M75oXcKhSVeiHcw9Hql1HFiqxrbiCpwyQVUR7AoeDmiP
         pvUye6iVD2CQ9RJbSz3PyCkDBUvfcQbuZ/S1OFwv2Vj1AVYJQUiAOXSp6kOOvJtN1nOv
         OL8w==
X-Forwarded-Encrypted: i=1; AJvYcCV8sXbczDxRkVK7NvikniHZQPxkgJxkHxz12rmk9DiynRRZSxE9CmXAHtVqCauLBXzbgur8DHvlozO6fKz4KblcSbq6dmU0lZAeqxqm
X-Gm-Message-State: AOJu0YxmC6BFYGsnem/1eJSidTCUuWbMdN58KVYeuvBiD98tHDvNrrWo
	iAMgTCv6Y9ulvQJTtxIswpx7Q7bQQf9/Ci4SUmCgpBWMAuT9fxCAZbWHIuB3+EXegVFQs4TQoNw
	KHZNx9g==
X-Google-Smtp-Source: AGHT+IGfJfugSfXqKRcV+jKvnWVgdcwpKVSIxjGRets5/bGkI+A8vKxf3+A1vS9NrjoAI+/DnFK1Hw==
X-Received: by 2002:a2e:8815:0:b0:2ef:324f:c907 with SMTP id 38308e7fff4ca-2f1530dbfaemr5107821fa.5.1722461000238;
        Wed, 31 Jul 2024 14:23:20 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac615c0sm808450066b.97.2024.07.31.14.23.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 14:23:19 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso5319255a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:23:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUinU99SJDcrsxCC52GOrWkS3XI/ujy5xOstuZAc2B9Ah86zrQwkifef2bTZqM2uK74RNBVfMxdCEqKsIHqnPvXIlyjx4RMuQZbFkdh
X-Received: by 2002:a05:6402:125a:b0:58e:2f7c:a9c with SMTP id
 4fb4d7f45d1cf-5b7008ae6e3mr280816a12.26.1722460999006; Wed, 31 Jul 2024
 14:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net> <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net> <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net> <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net> <20240731165108.GH33588@noisy.programming.kicks-ass.net>
 <87bk2d5v83.ffs@tglx> <20240731212007.GW26599@noisy.programming.kicks-ass.net>
In-Reply-To: <20240731212007.GW26599@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jul 2024 14:23:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSs62k3p7sS3uR7TSTsZg1q8-=Vm0douhodk2R0FqP=Q@mail.gmail.com>
Message-ID: <CAHk-=wjSs62k3p7sS3uR7TSTsZg1q8-=Vm0douhodk2R0FqP=Q@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 14:20, Peter Zijlstra <peterz@infradead.org> wrote:
>
> The alternative is ripping that level thing out entirely, and simply
> duplicate anything we find in the page-tables.

That looks clean to me, and don't we want to clone the minimal range
anyway - even on x86-64?

           Linus

