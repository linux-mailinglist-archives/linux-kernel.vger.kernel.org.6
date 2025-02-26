Return-Path: <linux-kernel+bounces-532710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A40DA45145
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532281645CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87898F64;
	Wed, 26 Feb 2025 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fCvlNis5"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E64A21
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528774; cv=none; b=M/sYFRL06x0F2nwwCFjWaKBSLQ3ePlPNzx67+vK8BS2D/7wdQaRzYUtdELp10/i06SdoO7yP8ObcGXC+WRwYgOW/Hc28JDSk3XxAqqpHaI9EGPDYCH9CnQy5UBBIApjpqtBksBFZ4hZn/5dpwGt8b4spY73+P37Oco/XgfkL8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528774; c=relaxed/simple;
	bh=4KmHgrrpAP4ms+fM+hRZmcR3Rx/fpI3cfOf7lpr1Wn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3SI8Am/zzv7vlSvbFF4oa0inhOXeUP0gZBg/IELiuQ0pgIoVQK7HxQybtAU/KFW7ncD5amTKR1RkiM34myICR8onTv2RwrZnjHjorvbgCGN080ZguWjekED2mN6+zRvu/RREc9wbvnBUZO8Zm8cL5uupl0N/YaZ+fgP4qztxAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fCvlNis5; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-728a2736e7aso121952a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740528772; x=1741133572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JZComv1EUu/8PE1y3nNgwwcXn6vNcbsWZABFHGDthE=;
        b=fCvlNis5WCkUyFnuOhEPe7bRk8QkmceRY0Ok474lkRU6jganqSfxGFlnc3QMWzRJKR
         faM4xFcw6vTm3m+uget4KnjqIkOkIAMQjtP360j45cMl4g7uwoYx+Tb656v3Ixo+CJdP
         TfxCmkTVsFxcWLvQ4Hycgr68UdpXqK6barKBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528772; x=1741133572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JZComv1EUu/8PE1y3nNgwwcXn6vNcbsWZABFHGDthE=;
        b=WOzQ8MSfBVPS5whv3As//AuIlrnLi354PVGyGQaNkpiD7ppgSU3DwbSPoCw0knSI0U
         UFuzlOHc8QggyooDz+PWY1ubElLqo7De4I4aPIpeFA0jQBJNBnu6E+p3jwP7qrYS2t6j
         txYs2ZZTa/85bvzUOwIUSwFP9xA2n0HCq4OsxeNGDCF7lGV/zc5ViPn1Lw0LJ6+DipKd
         DUgGriNL3j+Zsu7S4xYA7N1ANAz8a8765n6qjP9Mb+Z/DmOGirlM+9Enbc2gTBgNV1DX
         zOV6daNxHtcU9Ak2X63LHr0lUBhNZOhsbherGKduWLZ3LIQZVjKxBnm+mtG48riXQBOx
         gpzA==
X-Forwarded-Encrypted: i=1; AJvYcCVThYO+dhJzAL+79AsBxTPwJ7fYvAjq33LHD23raYXoeTH1fmr081u8uOC8e7IwgzO1wnT5GvwwIxCUjEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8f2RfQoM8BASDTRtSh72fFNEEAApI/ijpzq3A0HaZojqrdkBg
	Rh+z9BesRcI/UARGmRrzT+D644UzWCOwjzvol98IkArZKosXsLerv56qjAyNOnmzs90OkBkbXWX
	qqU7QOrkhAWDrB/CwffpO79zQ+v7L0G3c7kg+
X-Gm-Gg: ASbGncvz4xzV1ZId10ETGSxybvPY1lLbyuPqI0u/+zqQ3Tt0oQIwLF92uETbwhL3kFZ
	NDMaP8sNCFHZ0AOK7eYU/FssJr1AZWM/3kLKNc0DR0QD/+lFg5hYlMLySh/Oh7+IwH3ZSUzmnuN
	h/TBy+4Zll070lXxldtx3eXtyZ/jh+s6+Hem4=
X-Google-Smtp-Source: AGHT+IF+DM7ULHyyCq+8FePx8Pwa6mTgdKJT6V5TiujxwSXVaSD2ZmXtPFIg/19c5S3mUSM/bsmFnV+3csWbBw+T4Kc=
X-Received: by 2002:a05:6830:908:b0:727:3e60:b447 with SMTP id
 46e09a7af769-7274c276e44mr5006873a34.6.1740528771830; Tue, 25 Feb 2025
 16:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <e697ee1d-6075-4f24-8365-32aa4bc84d7e@lucifer.local>
In-Reply-To: <e697ee1d-6075-4f24-8365-32aa4bc84d7e@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:12:40 -0800
X-Gm-Features: AQ5f1Jo6a5YPljR9jcq3wgj2ygDTzULFozIVCwT6U2UOWgir5EVnc-62Nq5J5mE
Message-ID: <CABi2SkXcgB1Zjztqc1W4M-5j9z_wMCRaEtK-wLL3x9_qC1aGHQ@mail.gmail.com>
Subject: 
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:18=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Jeff - looking further in this series, I asked for a couple things for th=
is
> series which you've not provided:
>
> 1. Some assurance based on code that the kernel-side code doesn't rely on
>    VDSO/VVAR etc. mapping. I gave up waiting for this and went and checke=
d
>    myself, it looks fine for arm64, x86-64. But it might have been nice h=
ad
>    you done it :) Apologies if you had and I just missed it.
>
Thanks for checking this.
Do ppc in kernel code unmap/remap  vdso ?

I am aware that userspace can remap/unmap special mappings, but I
don't know if the kernel will remap/unmap a special mapping. Could you
please point out the code ?


> 2. Tests - could you please add some tests to assert that mremap() fails
>    for VDSO for instance? You've edited an existing test for VDSO in x86 =
to
>    skip the test should this be enabled, but this is not the same as a se=
lf
>    test. And obviously doesn't cover arm64.
>
>    This should be relatively strightforward right? You already have code
>    for finding out whether VDSO is msealed, so just use that to see if yo=
u
>    skip, then attempt mremap(), mmap() over etc. + assert it fails.
>
>    Ideally these tests would cover all the cases you've changed.
>
It is not as easy.

The config is disabled by default. And I don't know a way to detect
KCONFIG  from selftest itself. Without this, I can't reasonably
determine the test result.

