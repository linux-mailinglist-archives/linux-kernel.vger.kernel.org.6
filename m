Return-Path: <linux-kernel+bounces-527301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0EA4095B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C21175AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0201A23B7;
	Sat, 22 Feb 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ8U2lbm"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2816FF44;
	Sat, 22 Feb 2025 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236856; cv=none; b=a3iz8txIk7ckEiAaU7zV7vLQVQvJf6vzfoBEqCsVYwJdFhNbUNStN7xQHnG+Heo5P33m7Bo1qNxdaomyOIoGMWq12cg6XDZvXxqHd75oD3u54uPFpV22YSawbQ/F2VTUv51QU3Q0uph/5xLGUedORtSPpkQ2hy8ib8Yfa2CSQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236856; c=relaxed/simple;
	bh=70pD9gnFNEV46q1yL+XWGZJhvCSgCKDZIGACepg3f1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo0UeM5EX/ZOGuTW8SFyebj18v+OAROWrqVP7i3/B1RgOVplZSeNWvucG180+BkQdVpgbyW7JBMsjwtfDr0mIObbx7aAxbhl1voD9qYneuTY0TAywsxWHI7k1Ddfybug9N7a9iTJz1j2G5vyekY7uFuMJpXcnKavn3YaCECpkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ8U2lbm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd049b5428so30991376d6.2;
        Sat, 22 Feb 2025 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740236854; x=1740841654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70pD9gnFNEV46q1yL+XWGZJhvCSgCKDZIGACepg3f1I=;
        b=PQ8U2lbm0lQl8BmhQa9UsO3qkCgnuu08p25k/i4VWm6Be9BWS89x3Ni4l0tdFth4k6
         +WVYKq+DopmbV4F71lwZ224dmEtCh021+7H/Lj0/HiZq1em4gsTIQAkBpmskPcbhizYz
         9yDJ/J3xmV21m/0t7AfB0wSgAY8PcQLAEmiWhsKlcJkIo1SxfqUuNR4KlqUMeT8uFkII
         MoUJNiZKUXT3eECIkxNwEfUHMSRt4jiNTFTRwUfbqKvS5uWJ43bF0rlVmx0bNbmgPn+3
         89KLenaI/LgaESG+OOGlxKzHs+KoSq2iUGY2zGAtCXp79QXPsaZ0XoiKJCUmbaV0oA9x
         oc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740236854; x=1740841654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70pD9gnFNEV46q1yL+XWGZJhvCSgCKDZIGACepg3f1I=;
        b=QXSIiutdaxj/tKQ531Y4h9Dyt03+wKaYrvNczIamDexUjY+4FCNSUjjaSFpHn+E1KS
         0y1MPzKodgIobYGPVk/RroxTEtPldOTTCwF03IoIb2K7Cm/d3X6QlhIexLxNXQQLUSGb
         QX9IyPxejAMFwuInpxxHsXsmZHdoJGcu57IGQEFdQnwVFXQ7xN4SLDXgMGrNlc7330CY
         7AMcFX0N9YOIjjfcUIQNgwd5W0lPmoV3i/9EG/Y/yKpSTFS/uRdfPwRFXGckV3IXLX7Q
         Sv/KWi1FRFeR75HjqjDkkCRkN4dToYEItyHBmij4iVs7P19onOf+kSPuJJo7u5Pkd8d1
         WUew==
X-Forwarded-Encrypted: i=1; AJvYcCUpA7RQmT/Y+b+8OSjwOV4kTdHNcnDiXwbUCqx+qTeVotzy2Nz4V2w4sB7Aq3Bjt0+EEoK8qrt6lDs0QP6P@vger.kernel.org, AJvYcCWpmMGNDjtq/+2rC+VpOIj0B2U11hrtqsxO+FRtMfkuHQXRBoWa70hbiqwO27ZN9dX60B+pimsSYUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxDEk1Ck8SD7CAKiQnJUVHnroTuxhRY7z8ARN4B9ynkk3L6Ef
	3s4IPbxiCbIeurYl0GrJ0LJrG2Mhxzuwd17Q2F2pY+kSY0gnd/9VE00RbLEjB1Apgt+EPZO7E5r
	UOWSRlAOWplUeuvXiQrCVhH5/5wo=
X-Gm-Gg: ASbGncsYmEel6s6Z3+043a3AMgXBoxhlmCJA9k6J6Y5NrZwUwv+e0xZydA8YuK9Vt1x
	S/uWJE3nzML1bC9MJfuv1RwvbbQ5AO6mkFtcHuAGiyBwA/FXfdAOywqcXZz2FfESaWTtsjpt9oi
	qPF+rJhYX2sg==
X-Google-Smtp-Source: AGHT+IGzaUBBYsZPN6nwYD9SKzKfluRv9+knK4LuyyydKSabCwcaxgNi9q2iHeK7D9X3awEI3Ddvi+fItxaGI+EwcEo=
X-Received: by 2002:a05:6214:daa:b0:6e6:5cad:5ce6 with SMTP id
 6a1803df08f44-6e6ae7c9f82mr95965996d6.9.1740236853223; Sat, 22 Feb 2025
 07:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com> <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb>
In-Reply-To: <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 22 Feb 2025 16:07:20 +0100
X-Gm-Features: AWEUYZlkmxeF6xgXCl21B3APEThb1gNkBITR5DJujsdnWalnykrR9HY2cVqQu30
Message-ID: <CA+fCnZcOjyFrT7HKeSEvAEW05h8dFPMJKMB=PC_11h2W6g5eMw@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:11=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> On 2025-02-20 at 00:31:08 +0100, Andrey Konovalov wrote:
> >On Tue, Feb 18, 2025 at 9:20=E2=80=AFAM Maciej Wieczor-Retman
> ><maciej.wieczor-retman@intel.com> wrote:
> >>
> >> On x86, generic KASAN is setup in a way that needs a single
> >> KASAN_SHADOW_OFFSET value for both 4 and 5 level paging. It's required
> >> to facilitate boot time switching and it's a compiler ABI so it can't =
be
> >> changed during runtime.
> >>
> >> Software tag-based mode doesn't tie shadow start and end to any linear
> >> addresses as part of the compiler ABI so it can be changed during
> >> runtime.
> >
> >KASAN_SHADOW_OFFSET is passed to the compiler via
> >hwasan-mapping-offset, see scripts/Makefile.kasan (for the INLINE
> >mode). So while we can change its value, it has to be known at compile
> >time. So I don't think using a runtime constant would work.
>
> I don't know about arm64, but this doesn't seem to work right now on x86.

You mean it _does_ seem to work? Or otherwise if runtime constant
doesn't work on x86, then we shouldn't use it?

> I
> think I recall that hwasan-mapping-offset isn't implemented on the x86 LL=
VM or
> something like that? I'm sure I saw some note about it a while ago on the
> internet but I couldn't find it today.

In LLVM sources, ShadowBase gets calculated [1] based on
Mapping.Offset [2], which is in turn taken [3] from
hwasan-mapping-offset [4]. And then ShadowBase is used to calculate
[5] the shadow memory address.

All of this happens in the common code, so this should affect both x86
and arm64.

[1] https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Tran=
sforms/Instrumentation/HWAddressSanitizer.cpp#L1305
[2] https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Tran=
sforms/Instrumentation/HWAddressSanitizer.cpp#L761
[3] https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Tran=
sforms/Instrumentation/HWAddressSanitizer.cpp#L1863
[4] https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Tran=
sforms/Instrumentation/HWAddressSanitizer.cpp#L171
[5] https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Tran=
sforms/Instrumentation/HWAddressSanitizer.cpp#L899

>
> Anyway if KASAN_SHADOW_OFFSET is not set at compile time it defaults to n=
othing
> and just doesn't get passed into kasan-params a few lines below. I assume=
 that
> result seems a little too makeshift for runtime const to make sense here?

Sorry, I don't understand this question.

If hwasan-mapping-offset is not set properly, then in the inline
instrumentation mode, the compiler won't generate the right
instructions to calculate the shadow memory address.

