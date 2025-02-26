Return-Path: <linux-kernel+bounces-532790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEC8A45239
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481AC3B1625
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC4918FDCE;
	Wed, 26 Feb 2025 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SVH2ht+O"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48B718F2CF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533618; cv=none; b=eNLFWOSS2HfPICSXC26XTSlEb6yrO5QGfpAuH32V0Iwn61RU8QuP4o7Q38tiSbB4kd0I6KnFgwZ+4jUSSjeiQ+HffAbEo6s92CoB/NIWt77R1gSAZ6lP9k0y4hGAZjnaxCisXyOK8Yq6jFpPxojX8IyxWGVvcGbc1A+zPwwdpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533618; c=relaxed/simple;
	bh=LhjbSv4au6MwH7sOdXIixpDlfbsqQWEbooKY/OePEMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHhAGZWli+fjngTI42BQyGPGItogrWPb2lhPjDvFG/ESM9F0JLbyHjH+kpVqeNIW627nErdihCgFpm8klAZlZV7U9/e+8fVKH79tL84uEuHq6kNRz32ywQojqlsCnIavysNiUV7+xBS1yXgvKgn4Knhtad05tU8BxLw3hRhF3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SVH2ht+O; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7271b86c102so1070823a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740533616; x=1741138416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebnR0JarUmGpdugflrkwySQrLMMn1nm/13vqMSjIKHA=;
        b=SVH2ht+OtSk4SAnZMP1jJWUa6+SlELsTYmaC1Xzavjy5wZInLfwsLpQK3BP1G+tfeQ
         NBi7b60X86/txyGb6mBOXOSZM8Nqef5FQtEAt6jcWv5lM81GzlVRyVIa+Kn085YVhO5v
         vu4oFaoUxbUJmfjZX2nmf3kZZDLUXzsEVAFBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740533616; x=1741138416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebnR0JarUmGpdugflrkwySQrLMMn1nm/13vqMSjIKHA=;
        b=OQ1LUnFRHMDG24Mp6d8bbMark8FehIM/UwfXmbmN+cYSVYMhjLDNgdVFX9rCpsDla3
         SfteLT4qIejWZM6rfins345OAxRRD+tWJEuAJe56jJJqR0DcpoMS+rxNb2fb4bdxAQIY
         lX/MPsrjv7Ils2YTwP8njBpg/uKt6ehBjffNjHzeIy1qY6Qp7iZT336BgQ4ABvS5IXAN
         H5JbuOJmvxqLaKHYKiyBk3hHJlincuqSsrykM9aebONKfdkVoP4JQf6u8xCaGGEoKeB/
         mztdPAc7T46Zd9341SVnqW6R3yBO0a7pJWQhJqrYbqHrpTMAmoo3DApHF3MBKngj5V+B
         3H0g==
X-Forwarded-Encrypted: i=1; AJvYcCWNHALMF3hs0Lj34N6vK5Fmw4jzD7S9awIHSf8Yp31EUAkh2LjQg+psBAbOqw2ZjPRjRzWNCP2AbiEEsZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipuXwPSGFaHIRBC03wUzR8ixsPCysWEXBZnmkpWe5iSsFWm8d
	RgxhXJ9sWQHwPtNJDduaGOHcMVptSFgBKQKN2NTc83zZhXrUorK41grwUu6F0gp7Dz77bEVhIHE
	EVM4jQI33zm4CfGSmmj8Yc2dBw9qdJ6iYkHax
X-Gm-Gg: ASbGnctXJrbWGh065SRcH5ZWA/KMFSEpa0xIWtBI83d8Rzk0rlSW+YE0r9EtH9hewsq
	hnbnVg36OSHlmgc3u8KGzktVmXe25lz4JhOa8qW+pouYaQ0g/sHRMfJZ170FaxVlW21QIjVBeCq
	/0D3oS0dGWtseemxJ6+PvUhxqafRbX9dhX1yI=
X-Google-Smtp-Source: AGHT+IFfBkogeI+J+TIhuVzZ9liBdFBVMLOI9W8jdXh42R/dMGuOgxyd/PaAvwBTUDzVj6zG3B2V7PXvso8cUKCSbEU=
X-Received: by 2002:a05:6830:2b22:b0:727:2d05:aa9b with SMTP id
 46e09a7af769-7274c25fa25mr3476833a34.6.1740533615690; Tue, 25 Feb 2025
 17:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-2-jeffxu@google.com>
 <9abd68d9-3e6d-46a0-b92c-5aee0a90abf3@lucifer.local>
In-Reply-To: <9abd68d9-3e6d-46a0-b92c-5aee0a90abf3@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 17:33:24 -0800
X-Gm-Features: AQ5f1Jp3JOWAzv-64Vb5PKwzbpnpGSYiSOq3FsK4TQhOwG3l29ADM_4sybBE2Pc
Message-ID: <CABi2SkXT0z9YFsEkf3-HH0r_NuXXs_SJid9yzjuu0SwuxxWmZw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] mseal, system mappings: kernel config and header change
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

On Mon, Feb 24, 2025 at 10:05=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > +     bool
> > +     help
> > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       To enable this feature, the architecture needs to update their
> > +       special mappings calls to include the sealing flag and confirm
> > +       that it doesn't unmap/remap system mappings during the life
> > +       time of the process. After the architecture enables this, a
> > +       distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage acce=
ss
> > +       to the feature.
>
> Architectures also need to be confirmed not to require any form of VDSO
> relocation, which as discussed in previous series some arches appear to
> need to do. I'd mention that here.
>
This might need clarification, the system mapping includes vdso, right
? Why the focus on vdso ?

The sentence  "... it doesn't unmap/remap system mappings during the
lifetime of the process."  already cover what you want here, I think.


> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config HAVE_PERF_EVENTS
> >       bool
> >       help
> > diff --git a/security/Kconfig b/security/Kconfig
> > index f10dbf15c294..15a86a952910 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,24 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config MSEAL_SYSTEM_MAPPINGS
> > +     bool "mseal system mappings"
> > +     depends on 64BIT
> > +     depends on ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > +     depends on !CHECKPOINT_RESTORE
> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, uprobes, etc.
>
> Let's be specific here, 'etc.' could mean _anything_. Also you aren't
> sealing most of this, let's just list what you are _actually_ sealing
> here. Which is AFAIK VDSO only?
>
I will remove "etc" and list all the mappings.

Those mappings are:
vdso, vvar, vvar_vclock, vectors (arm compact-mode) and sigpage (arm
compact-mode), uprobe.

We seal all system mappings that x86-64 and arm64 have.

> You can update this later as time goes on if/when you expand this.
>
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       Note: CHECKPOINT_RESTORE, UML, gVisor, rr are known to relocate=
 or
> > +       unmap system mapping, therefore this config can't be enabled
> > +       universally.
>
> Thanks for putting this here, appreciate it!
>
> Could we tweak this though? I'd like to make it crystal clear, so I don't
> think 'note' sufficies and this sounds a little too vague.
>
> I think 'warning' is more appropriate here since you're breaking things f=
or
> people who might be unaware. And we need to say this -breaks- programs:
>
> WARNING: This feature breaks programs which rely on relocating or
>          unmapping system mappings.
>
>          Known broken software at the time of writing includes
>          CHECKPOINT_RESTORE, UML, gVisor and rr.
>
> I think this is critical.
>
Sure.

