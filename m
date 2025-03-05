Return-Path: <linux-kernel+bounces-547681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23DA50C56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2786E188CFB3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7739255E20;
	Wed,  5 Mar 2025 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SndV3K8m"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68139255237
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205676; cv=none; b=j7qqFV2i6DNGkL8zPb5n67imroWUGkgRfFYHhkgwTCsCUGMd7aujLnPE53zrMn2zrCQn58WNDMSIwc355RDViN3iz0tgmnTjxu7Nod2x/fSkslxERLpj+3okQ91INrSCuknA+hvEAVCyjvMi/5qSvJz/Oor6dAdX2nER1SWpRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205676; c=relaxed/simple;
	bh=72n5FagYl7I0GS8w6DivzwBotLDWglg1LU7AmhSW/Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHMod5lYGlAOXiLgsRsD5B/8sTN0uNndf6oxfmgA9gVzYC1lxNpMJBzhnWXzJ11o8jYDktieaDF2dmmpBjziAQpSePgw1usdhkBvoehxv85nFDnIjKJExlKENmLZcSefRv6LVxLQ1UWSwVkwAlXL6y6n6bwYkwQIer+loZd5LK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SndV3K8m; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3855332f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741205672; x=1741810472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5qd7Wszrfqzd4EGXS7jC8AKQgbVyyF+d0BKc3STsmk=;
        b=SndV3K8mrWxmxQwTW+0zEIM2Nf4KkuObyG4N/XTFZWVsfN0/FnvhmS5D7hDV3NzZXj
         iQBke9NHIJcH6pCNgq8nrP1KrRni/oKnl3kkZTBPmeb+5VQiT+KiwZuIEfqmQTSoDLIY
         pcUkJM0pWUuAN2swMhpmMlv5PRTOdrlCt5Ozk2S0BqVPG8WMuECCe+qwnfciQd8gHGXY
         Ph6ZzxV09c8Q+Bo8dUIH6FogIG2U84hhTRzdlleeBU2R2NTm5yTTdPnHSKYewrw29sKL
         ai0/spaDtIpE+gM3q0xeVF2Ih996+ELhGuDvttbn6ycaj37ZETduf8KptG4SVVzHOmQX
         zL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205672; x=1741810472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5qd7Wszrfqzd4EGXS7jC8AKQgbVyyF+d0BKc3STsmk=;
        b=tNID0Xdj/AOOqOUEdcSnJu1GvRP9pPxw75bN1ByL6x6tReXMSdt37B3nrvB5eIHmGv
         83K9Yh007NdaJyS3shPToU6CUJk2CjdqtzkzbVis/W0dEGPuKxgrcTFkO05Xa95I6b92
         dysMwpLp49okW5Q82+aklUMbM4nWs1RJT88Vo09K7oXzJFAoPTTu4UwZnmUYDN9/KTby
         q1Y6ye7fPlD1mVeYjsP7Vwhhd/nDhJlSJ1Ax14CI6KzFRVXQhe6QdhHS6GFNVTEBJ1pr
         1wzpt024q9dmMw2Iq25Aj6oz+pSTA59EoQwpZR/LkTaXyteUaDHVmL6DzE/uDX75LGZQ
         iLVg==
X-Forwarded-Encrypted: i=1; AJvYcCUE7FOumWtzDo7/SEQw1TV9c4kT0baNfYyTbnMRPs+mTSYmsLWKOtUQaXv5Int257ym3qGi733FinTLoc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxogmInWeUWWWDe9LdZR4iBBEe+SO1aHPNrtcZ3/8vY29r4EOow
	uWY6yp5saF4XNJ139qJINHA8Vtqzl7B0ONThsPXZoB/MzlM9x0R9sBhDdg==
X-Gm-Gg: ASbGncuFWIaW0hMYYdOWs6nFaayRZfjeaSOaaAtBDSEhNmeLSwSwBpFI7iR48Cj9Qaj
	rcdLWvqPavC6eezz7hv9KH5lfK4g1iys5sAS6i/H0svtQx3YEPxgvbkw31jP2XOJEqXgwjxjOq9
	+1PWFv+0HXfDdYk6BfzMI+uMZgBQbazaabRtGHJWhFGYR7AV+1F7cFHezEefosLL9PDK7auRIQ4
	Tpox75VoLci9lMlSTKNRLLnOICiyoEMHA4QAPDKDnNAp8sRMK1SrbI/Y97TXngrrU9BbO9xQznq
	TKJlnlQHkpaKTwM6+0DRKQg8tkGjRhK7YSkD/pmgue+cd6sWtGc6GT6kA81+F+tvrzNoqia8Zi8
	wn3Hwcts=
X-Google-Smtp-Source: AGHT+IFVXG9Z6nCIN9g5IcDEftUx8c6/jASqlC8CQtcgPuG0+4kwCqL4En+z63gaZ/wszpVcbrujAg==
X-Received: by 2002:a5d:6c62:0:b0:390:f1cb:286e with SMTP id ffacd0b85a97d-3911f76eeebmr3870550f8f.27.1741205672261;
        Wed, 05 Mar 2025 12:14:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd431070dsm27441055e9.34.2025.03.05.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:14:31 -0800 (PST)
Date: Wed, 5 Mar 2025 20:14:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <20250305201429.3026ba9f@pumpkin>
In-Reply-To: <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
	<20f1af22-71dc-4d62-9615-03030012222e@intel.com>
	<CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
	<c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
	<CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
	<20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
	<CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
	<CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 07:04:08 -1000
Linus Torvalds <torvalds@linuxfoundation.org> wrote:

> On Tue, 4 Mar 2025 at 22:54, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Even to my surprise, the patch has some noticeable effects on the
> > performance, please see the attachment in [1] for LMBench data or [2]
> > for some excerpts from the data. So, I think the patch has potential
> > to improve the performance.  
> 
> I suspect some of the performance difference - which looks
> unexpectedly large - is due to having run them on a CPU with the
> horrendous indirect return costs, and then inlining can make a huge
> difference.
...

Another possibility is that the processes are getting bounced around
cpu in a slightly different way.
An idle cpu might be running at 800MHz, run something that spins on it
and the clock speed will soon jump to 4GHz.
But if your 'spinning' process is migrated to a different cpu it starts
again at 800MHz.

(I had something where a fpga compile when from 12 mins to over 20 because
the kernel RSB stuffing caused the scheduler to behave differently even
though nothing was doing a lot of system calls.)

All sorts of things can affect that - possibly even making some code faster!

The (IIRC) 30k increase in code size will be a few functions being inlined.
The bloat-o-meter might show which, and forcing a few inlines the same way
should reduce that difference.
OTOH I'm surprised that a single (or two) instruction makes that much
difference - unless gcc is managing to discard the size of the entire
function rather than just the asm block itself.

Benchmarking on modern cpu is hard.
You really do need to lock the cpu frequencies - and that may not be supported.

	David

