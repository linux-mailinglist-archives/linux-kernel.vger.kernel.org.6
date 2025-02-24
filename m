Return-Path: <linux-kernel+bounces-528304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62887A4160D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2C13B42DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74423FC66;
	Mon, 24 Feb 2025 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if8lQvhE"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A518E377;
	Mon, 24 Feb 2025 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381239; cv=none; b=E75O0X0AMUlt1+pNKG0SKogaBNSqc7uoMXfMUEF4aa/GOyF3i0qhZO94b4xEuCUiX9vEpXhz85/Y4LkTtaipJeuH9RbrhyVL0zaY3XDAnYS/r6yM36jnNwww8RdvKYsk8SMghMYe3pfXZhbeu8KYjhw7mBa5+sHXOf1Ky/eiq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381239; c=relaxed/simple;
	bh=bQb2/dc1WzW2BE++gvgsOTmck7L6Nvf4DdHExnkKCCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQItS5JxsX0RjbknyaG64b+bhrHsVV/iBuzYvOrKJS1onmjfxJlF/9EMpFYCot8cgJmX+wFFDEa/hizuFjKTi+5pbBSuibz9m2bZ9l3q5TRYMh1DLdtenQqqYCen+3o3Rxhm7mUV5V0GacBTt/pRhUkFsGDxY03DXUPkrwuQ36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if8lQvhE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb81285d33so779239366b.0;
        Sun, 23 Feb 2025 23:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740381236; x=1740986036; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhJ1T/fwWWXZEiEbcn+HPev6I/zpx52m+r3y5yvwxno=;
        b=if8lQvhE8okM+fuHSrY8eK39/VGmeaUcFJrAx40FA4YzbZ6TV7vToKIgU4l23coK/Q
         VrzWqn21m6/dctQNLrxMp4LcDkQz765JfhmMteSiMx6SCL4EKkmDdTVuzC1Gu2z8nBCN
         tKiXkowgKLPe0Lni9Z8I69SyYEtZc+tKYTYUJ7oZpuVV3HkOMGWBoZdmYB91P86sh1lg
         LZpZJodjbKP8Z9aZir9XDgkB+6lRft+JSOFr33rmGbIOhxndwj2XvMJxAhELMcSdrkBC
         +6J1udlYb0ElWU1ZK/7zJ+HD9HN7ExmRYm/uGJYTPaweCWknBVw/nxVr2/JISmvS8IoN
         AtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381236; x=1740986036;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhJ1T/fwWWXZEiEbcn+HPev6I/zpx52m+r3y5yvwxno=;
        b=ZJTbiE8vByRsWdeg1sNDN5vdOsFl9ptOxR40G3gypNrqSWhNoNwgmlTWRTF5Yj4i47
         Cy6GpWPuPpRgcnGfkGaKVbcaTvAL5+RotJzm4h3Naw9WapmlOMWs+vsy8LXEYU7gYeIG
         6dmLgqaqTNH8bX33uQmcONLqqkAIYsBFxGAg54p7V2j6gTUQZMe9jwWNLKO21XCOanNI
         GdXmszUVgsWyhsP9UCv7lNtZXsqy5cPUFqJy4qfjJXw+UyVdOFnTG6wGMhvxgJx106fI
         /k4lf3AogfkFoa2Z5FN8VGM5Cy/TKYG3vD8S4UrmTC3Hh3bC+cEbvYmxZrwDCEujydv7
         bYLw==
X-Forwarded-Encrypted: i=1; AJvYcCUAGs33thR+1rGjZbMInSttBDQF4Rn5nY+chXFVLxXNpiu1/UhSl2G4VMJYTYwTPOGEdQUU8jTPHVv3@vger.kernel.org, AJvYcCV76yqCjfKyycTLXq4ta3cb0s2AvUlllcUlRW8/Jdc4bFbtnnXOOn4Y/YpFhiVhrAPF9WvydtucVYWq@vger.kernel.org
X-Gm-Message-State: AOJu0YzWA1EV3LsOP1LcWRrcoap2jtonB9WhJxnovLd6igmi6zczhkxQ
	V9vrohrjhNlNbqKm4bgJdn1j2uCuxnRr7OU8GXmDjL1exSu0D6bY
X-Gm-Gg: ASbGnctQCLMj6W9X3KBWwhn022xzBNMyuyI/7aCrqsbj6SIpKXh+p2bDRU5nq9ET410
	w9Dhj6mRc2kHnCTMxnkm8Ev5fUIb+AUrzr46sZY7hbYspc/Bdg09eUv7Upn7HazVBM1MSn9GCIM
	+FEAwt+xurcxE+Uw/lZ3mQZU8XZM4eEhAEq4uKVr/hJiN5YGV4qUwJnaIPMoqY2k0UfYO1zCXZm
	Q1S1F8Q8y18+y+ht4CWLL9DonS5VusTDuuzJ3GAuAMZ+lESaY8X3S9elFwsotYegvW4WT2kws70
	WRPGYqBDWy9H02i46uI/z5ZgqQ==
X-Google-Smtp-Source: AGHT+IFTl/OJwiOMCrQwp/6jVuRvgGddWSjPDFK5GMI5evFJFlBu1ePwDd5puvr/8TxFgsTqVzZxSQ==
X-Received: by 2002:a17:907:7ea0:b0:ab7:d361:11b4 with SMTP id a640c23a62f3a-abc099b7f3fmr1362031766b.7.1740381235930;
        Sun, 23 Feb 2025 23:13:55 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbda707e3dsm1034964866b.106.2025.02.23.23.13.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2025 23:13:55 -0800 (PST)
Date: Mon, 24 Feb 2025 07:13:55 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 12/14] x86: Add KHO support
Message-ID: <20250224071355.xsl2dbupda4dhfzl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-13-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-13-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Feb 06, 2025 at 03:27:52PM +0200, Mike Rapoport wrote:
>From: Alexander Graf <graf@amazon.com>
[...]
>diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>index 82b96ed9890a..0b81cd70b02a 100644
>--- a/arch/x86/kernel/e820.c
>+++ b/arch/x86/kernel/e820.c
>@@ -1329,6 +1329,24 @@ void __init e820__memblock_setup(void)
> 		memblock_add(entry->addr, entry->size);
> 	}
> 
>+	/*
>+	 * At this point with KHO we only allocate from scratch memory.
>+	 * At the same time, we configure memblock to only allow
>+	 * allocations from memory below ISA_END_ADDRESS which is not
>+	 * a natural scratch region, because Linux ignores memory below
>+	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
>+	 * allocations, we must allocate real-mode trapoline below
>+	 * ISA_END_ADDRESS.
>+	 *
>+	 * To make sure that we can actually perform allocations during
>+	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
>+	 * so we can allocate from there in a scratch-only world.
>+	 *
>+	 * After real mode trampoline is allocated, we clear scratch
>+	 * marking from the memory below ISA_END_ADDRESS
>+	 */
>+	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
>+

At the beginning of e820__memblock_setup() we call memblock_allow_resize(),
which means during adding memory region it could double the array. And the
memory used here is from some region just added.

But with KHO, I am afraid it would fail?

> 	/* Throw away partial pages: */
> 	memblock_trim_memory(PAGE_SIZE);
> 

-- 
Wei Yang
Help you, Help me

