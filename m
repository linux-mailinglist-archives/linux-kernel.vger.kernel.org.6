Return-Path: <linux-kernel+bounces-573993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F1A6DF59
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43E61892740
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878382620E5;
	Mon, 24 Mar 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsZaKxTC"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0632620C5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832666; cv=none; b=S/DSo7lA2bkJhPD1bLoye2t0AmPz49WW8hTXDl2g7QqbumQLuSrGZ0e4cnMYT0Px4FtsQKLUZ96gfKMUL328SZi4HE8doE2jbPbDtiEaArPegPi3X4VeeoAefZTCjs1dD4mcsTesplx8JxVubY6duHfoWzsQ9Zo5PflM0yYq3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832666; c=relaxed/simple;
	bh=h/ci9IErEClJvj/hos9no5+LsAX7syJvns3LywaCNmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP2yC2N9r88Jd5reGUQewy1t2mQU5V7rno+uwaIdghVqtnMyXM+ycy1bSrvpmk+r0p/OeKXNmb7DrZWvWZyzRprludUUEOoGKiDXxRo/oOY1kb/qbeNIUY6qmJnvEn8rdYqxbdLhOdkqAv8gKTz47k5O0+ty+nmO9OQOdiUQGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsZaKxTC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso9886899a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742832664; x=1743437464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfKZtzv59eBwLvLslJklRIH1GlVmmxb0T7NI0lTwvR4=;
        b=bsZaKxTCM8l3/SRt8K8HOvWnqYImCPza+3onKkH4KYa679neXl2RIHUk2/hKy+z6KT
         eehcXZttQshviYDxCG6Tuoq/6peL+QyFu9UnfDC8PSD0rj7VUqWayNZmlkT7AEYZQ1HX
         JcEoPkWnkKfqTPjVYDeFlttROA+QZqRmJ6eGYvN9NLbyFO+xJTn6v9xAnOh2oUdfs/uL
         dm0y+xXzYhp84HzFnbISRn/TlgENFALSqJi9x1yNZa87U127+FWL2vl9vHNpu4HlQoEd
         Or4HNrp7u96GBVZUFaR+GkQubWnF4OQ3N7Vnl8OcVJFeMdzXNYOjGoucxDlsLpK6WJPL
         ecmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832664; x=1743437464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfKZtzv59eBwLvLslJklRIH1GlVmmxb0T7NI0lTwvR4=;
        b=diRAeNaH17+LFkkJcAXh++0GmbL31ldGoXMjMT7w28jmM4Ja+EY8pJUGPsx/GfeFAk
         /f1pHUGAgfja1SWtltao4y84WguhWlHfdzKZn1IvYp54Fu7BqvDzDPe9KJCmVRtAzD4O
         +lplb2n2O7p3gn8uJ5v+p5uneDJlRStAhcAIqJWnMPeRlRw4QAJ3sSG32xLUJH1gcSqM
         8FtW9J83BG090dm6O2c0TSZRCNH0QWDYPAEgtDG/JDb16mlrgQ+3S/de25EsONWQtENe
         DamAGDco7lNl+jREbCUXY+Vk9fjEjlVxxvG12rqt28BZLoKL1p69H8M4fMFVh9di6Zdm
         tnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW80RZDX7fynnjxCKe4TswCTxw6tYeNKg7K42F3BGwZOGCZjdsWXSUS90iXSQTYFplvW4HSU3CZ/j63CQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/nNRmRmT1Z2lcCIg8+FXUAmhlFcQQpeABEJKhnRtAYF4slpV
	gY08UFgx97KsDlPDetbs+fbFMWj2QGCt8l5EPfrD40At0bdptstr
X-Gm-Gg: ASbGncveoFzOijiwrpMiArcOXPDYqRVz/zUKfHHmCUGfO41uTKYwwLXH+Z9VBPTsKcJ
	NkmysUSommL6f1h0JM7IZuR3E7Y+3Jm5jMfj3G3dsIgB6kEqMY5o84E7JoTfapKeBLP6ZCJ6AnO
	LuUqtJ1VaHtcKVKiuRlIJxsIPD7KZ/0aeISg+va/+E+F6Us6gnLa+jYM3H6lcUlPKxN7in/8PgB
	ESUPUrfdSw8C5AKaPpoXi2KuuORRUGnKuEEB7XD6vBnY8fIYu+ZxH4k69k8/+7WRjr0RPmwgg4b
	iDgzArasjagS9c6RYK2iJVwJ1yh8q+97uOcKkuHn8aWTvJs+XlYKnovQNnS9nFkydE5l
X-Google-Smtp-Source: AGHT+IFGSZzECIzd4xFIfdlc38K0Cf0n26OwSjiHv+4oEt7ysXyvnNIq/1GYBi7pelSqe/eAsII4KQ==
X-Received: by 2002:a17:90b:3943:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-301d43c9272mr29014013a91.15.1742832664244;
        Mon, 24 Mar 2025 09:11:04 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12373991a91.3.2025.03.24.09.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:11:03 -0700 (PDT)
Date: Mon, 24 Mar 2025 12:11:01 -0400
From: Yury Norov <yury.norov@gmail.com>
To: mailhol.vincent@wanadoo.fr
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/3] bits: Split asm and non-asm GENMASK*() and unify
 definitions
Message-ID: <Z-GEFcciqCwxL88W@thinkpad>
References: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>

+ Anshuman Khandual, Catalin Marinas, linux-arm-kernel@lists.infradead.org

This series moves GENMASK_U128 out of uapi. ARM is the only proposed
user. Add ARM people for visibility.

Thanks,
Yury

On Sat, Mar 22, 2025 at 07:39:35PM +0900, Vincent Mailhol via B4 Relay wrote:
> This is a subset of below series:
> 
>   bits: Fixed-type GENMASK_U*() and BIT_U*()
>   Link: https://lore.kernel.org/r/20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr
> 
> Yury suggested to split the above series in two steps:
> 
>   #1 Introduce the new fixed type GENMASK_U*()
>   #2 Consolidate the existing GENMASK*()
> 
> This new series is the resulting step #2 following the split.
> 
> And thus, this series consolidate all the non-asm GENMASK*() so that
> they now all depend on GENMASK_TYPE() which was introduced in step #1.
> 
> To do so, I had to split the definition of the asm and non-asm
> GENMASK(). I think this is controversial. So I initially implemented a
> first draft in which both the asm and non-asm version would rely on
> the same helper macro, i.e. adding this:
> 
>   #define __GENMASK_TYPE(t, w, h, l)		\
>   	(((t)~_ULL(0) << (l)) &			\
>   	 ((t)~_ULL(0) >> (w - 1 - (h))))
> 
> to uapi/bits.h. And then, the different GENMASK()s would look like
> this:
> 
>   #define __GENMASK(h, l) __GENMASK_TYPE(unsigned long, __BITS_PER_LONG, h, l)
> 
> and so on.
> 
> I implemented it, and the final result looked quite ugly. Not only do
> we need to manually provide the width each time, the biggest concern
> is that adding this to the uapi is asking for trouble. Who knows how
> people are going to use this? And once it is in the uapi, there is
> virtually no way back.
> 
> Adding to this, that macro can not even be generalized to u128
> integers, whereas after the split, it can.
> 
> And so, after implementing both, the asm and non-asm split seems way
> more clean and I think this is the best compromise.
> 
> Aside from the split, the asm's GENMASK() and GENMASK_ULL() are left
> untouched. While there are some strong incentives to also simplify
> these as pointed by David Laight in this thread:
> 
>   https://lore.kernel.org/all/20250309102312.4ff08576@pumpkin/
> 
> this series deliberately limit its scope to the non-asm variants.
> 
> Here are the bloat-o-meter stats:
> 
>   $ ./scripts/bloat-o-meter vmlinux_before.o vmlinux_after.o 
>   add/remove: 0/0 grow/shrink: 4/2 up/down: 5/-4 (1)
>   Function                                     old     new   delta
>   intel_psr_invalidate                         666     668      +2
>   mst_stream_compute_config                   1652    1653      +1
>   intel_psr_flush                              977     978      +1
>   intel_dp_compute_link_config                1327    1328      +1
>   cfg80211_inform_bss_data                    5109    5108      -1
>   intel_drrs_activate                          379     376      -3
>   Total: Before=22723481, After=22723482, chg +0.00%
> 
> (done with GCC 12.4.1 on an x86_64 defconfig)
> 
> --
> 2.43.0
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Vincent Mailhol (3):
>       bits: split the definition of the asm and non-asm GENMASK*()
>       bits: unify the non-asm GENMASK*()
>       test_bits: add tests for __GENMASK() and __GENMASK_ULL()
> 
>  include/linux/bits.h | 29 ++++++-----------------------
>  lib/test_bits.c      | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 23 deletions(-)
> ---
> base-commit: e3f42c436d7e0cb432935fe3ae275dd8d9b60f71
> change-id: 20250320-consolidate-genmask-6cd02abadf82
> prerequisite-change-id: 20250228-fixed-type-genmasks-8d1a555f34e8:v7
> prerequisite-patch-id: 572c05165229640db7dd8fe4d53e1a33ee5dd586
> prerequisite-patch-id: c16d122a487f83e2866a9a669259db097ef46a70
> prerequisite-patch-id: 35f115c0f1b327f1516cfc38b3076e07713df6cd
> prerequisite-patch-id: 5fe7058f6ea73b37df75d5c39ad69a4da928058d
> prerequisite-patch-id: 82fb628d052ce9f1efac7f3b61eafb2749f95847
> 
> Best regards,
> -- 
> Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 

