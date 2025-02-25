Return-Path: <linux-kernel+bounces-532538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1BDA44F08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF45189D454
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066720E32A;
	Tue, 25 Feb 2025 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKXsB8Sa"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419618DB1B;
	Tue, 25 Feb 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519501; cv=none; b=XU50d7cBNS4uLc9LR5sPpAR9h2dmg1Kg5DPDOul5kGUL9iWZziAy//GEZXDPqmIHoCFsqNMSEEHl6dSxlFX/SOM1eSs/WjYZZwbs7BHLqEeTzx0T0fpEaKXnZuslFzhX2Q+xzMeFUOKpv7fTm4oOWYhrfClDJiebHIytTHlqO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519501; c=relaxed/simple;
	bh=fXFKcm0lZuF5OG0aApeKuQOf3+mW6bFB0yCFPCGgwEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbIZBxiqU6j+Iw0YYPlQQt6MaIYLLk46RYIpG3GzSTkbCaJB8prd66d2KS/PY9EcIa0pj/l+bDqxFE3aatDWQbM8xGcRVup4TaOH03Yb87tXQwMSzUTvRb1wKOZQvILg0zW4mMa1mXS3G/T0pdsAzcxdaEWenoQcIib4V1Qd3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKXsB8Sa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so3210477f8f.1;
        Tue, 25 Feb 2025 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740519498; x=1741124298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXFKcm0lZuF5OG0aApeKuQOf3+mW6bFB0yCFPCGgwEk=;
        b=HKXsB8SaNQZrsdPJN5G/e969u4XrplWhOBrOM4CudSdla/LNbPm2hgGO5Rt+cPW4eU
         ohVtN6piiLlF+dSBWtwsgl/PlIUjih2Wlqs9cPGF3FT6TKDVySBOG7KwH0dVYd8DunzB
         z4T9OdDDwL1uqu6RkoSTKLKjh6GYJ5edSq1xYlkXF6tpC0lc3slac8c6UU13g9XG+jAo
         N7jF5T10iOTENnB1tgtowOMAdTh+UsiuQRdH0lUQxJ6E/xQvppMa7KDiddRBlWHWCyk6
         yIsR+wXyAdrRjGJAI84vmNREdbXESEqskFqkU3ALq8+ul+jQ+zm6tkrLWeeGgjTOekJo
         EWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740519498; x=1741124298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXFKcm0lZuF5OG0aApeKuQOf3+mW6bFB0yCFPCGgwEk=;
        b=UF/uYTM16g8lhg4++2JVPMTKoFYdsUfD1kJc6IYUqkSffZPeHCg0JyoM/90j/gYBD5
         8oi8NGfovqxCgwwHD8fzszhupg4UBeY2B69DZigP7TG5m1Yj7XtjrcBp669DyOL01P/Z
         ilHOlSXG3fwyyVv/LneF/rrvVdCl6/zwzUf8dDViGmr+1+ukr6io07gPmbsnKZnssVKs
         /RRw5xSCM5TfsZ/oPU3bWRmMlduYs6wGKiAphlV8cpaaoqPMLOjL/Uy8eunhg5kvra3d
         1WonlsFImeK5AkGMyGVD9/il1DK+b4WK6El4U95MjkRAALi9VgUaxbOLLI8cKUCGMPaH
         hBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMB2Me87K9kqPgl/79wLRD58/z/tFVGCWAwAJ9GMPf+2gtEYzWeGFitW8j8wjMCcIFxi5KamI93ttedTD7@vger.kernel.org, AJvYcCWafhspqipt09d2toHy+F5uSFvORoxLIVH1EyujqrCVAXCVb9Nq/IoEZjZAhBciEKa316y0NKW1jys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoi0qGUZ8shaE2k1fSCrKUP30BW0hnmENooH55ZqKPtKZZcQ6
	WfGjo0IXa7WJKfbtYk6RZQHDYzW9yTjgHFXhMEe21Hxlx2+soyu/2mt3quVuYikAh7HQhXJs/Eo
	BYKmc88uDJmyEOBUROWcKKvuM8TY=
X-Gm-Gg: ASbGnctQG1HG+z6Ov2LVDYfAVR6htULS5Q6KSKTS5MowP8QIBv6pimjfqk22vssUmZU
	Ftvy09dciYCEB5RShz09Ks2lTih0OX2SMz5CZzICb+nzctj60ZORe0avbV7VDG/PNbOWEzn7yk7
	KXjWTo5hH1
X-Google-Smtp-Source: AGHT+IGh8E+lTwkx8iX124FdlLJw2Xy9DPydEazX+qcbmRtx4fMlCbmv7VFo9hwZNeA+xmoTq7Gl/a44OapVymXi8YM=
X-Received: by 2002:adf:f003:0:b0:388:da10:ff13 with SMTP id
 ffacd0b85a97d-390d4f3c491mr589082f8f.21.1740519497503; Tue, 25 Feb 2025
 13:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
 <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
 <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <gisttijkccu6pynsdhvv3lpyxx7bxpvqbni43ybsa5axujr7qj@7feqy5fy2kgt> <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
In-Reply-To: <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 25 Feb 2025 22:38:06 +0100
X-Gm-Features: AWEUYZlodhwAbgPi0Dk16h7YK7x4HrrqY-JVxMx5ByQmdcv8cbnJsNVhi4etBIM
Message-ID: <CA+fCnZeEm+-RzqEXp1FqYJ5Gsm+mUZh5k3nq=92ZuTiqwsaWvA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Vitaly Buka <vitalybuka@google.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, mark.rutland@arm.com, 
	broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, rppt@kernel.org, 
	kaleshsingh@google.com, richard.weiyang@gmail.com, luto@kernel.org, 
	glider@google.com, pankaj.gupta@amd.com, pawan.kumar.gupta@linux.intel.com, 
	kuan-ying.lee@canonical.com, tony.luck@intel.com, tj@kernel.org, 
	jgross@suse.com, dvyukov@google.com, baohua@kernel.org, 
	samuel.holland@sifive.com, dennis@kernel.org, akpm@linux-foundation.org, 
	thomas.weissschuh@linutronix.de, surenb@google.com, kbingham@kernel.org, 
	ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, xin@zytor.com, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, cl@linux.com, 
	jhubbard@nvidia.com, hpa@zytor.com, scott@os.amperecomputing.com, 
	david@redhat.com, jan.kiszka@siemens.com, vincenzo.frascino@arm.com, 
	corbet@lwn.net, maz@kernel.org, mingo@redhat.com, arnd@arndb.de, 
	ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:13=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >>Thanks for letting me know about the tag resets, that should make chang=
ing the
> >>check in kasan_non_canonical_hook() easier.
> >
> >Ah, but the [0xff00000000000000, 0xffffffffffffffff] won't be true for x=
86
> >right? Here the tag reset function only resets bits 60:57. So I presume
> >[0x3e00000000000000, 0xffffffffffffffff] would be the range?
>
> Sorry, brain freeze, I meant [0x1e00000000000000, 0xffffffffffffffff]

+Vitaly, who implemented [1]

Ah, so when the compiler calculates the shadow memory address on x86,
it does | 0x7E (=3D=3D 0x3F << 1) [2] for when CompileKernel =3D=3D true,
because LAM uses bits [62:57], I see.

What value can bit 63 and take for _valid kernel_ pointers (on which
KASAN is intended to operate)? If it is always 1, we could arguably
change the compiler to do | 0xFE for CompileKernel. Which would leave
us with only one region to check: [0xfe00000000000000,
0xffffffffffffffff]. But I don't know whether changing the compiler
makes sense: it technically does as instructed by the LAM spec.
(Vitaly, any thoughts? For context: we are discussing how to check
whether a pointer can be a result of a memory-to-shadow mapping
applied to a potentially invalid pointer in kernel HWASAN.)

With the way the compiler works right now, for the perfectly precise
check, I think we need to check 2 ranges: [0xfe00000000000000,
0xffffffffffffffff] for when bit 63 is set (of a potentially-invalid
pointer to which memory-to-shadow mapping is to be applied) and
[0x7e00000000000000, 0x7fffffffffffffff] for when bit 63 is reset. Bit
56 ranges through [0, 1] in both cases.

However, in these patches, you use only bits [60:57]. The compiler is
not aware of this, so it still sets bits [62:57], and we end up with
the same two ranges. But in the KASAN code, you only set bits [60:57],
and thus we can end up with 8 potential ranges (2 possible values for
each of the top 3 bits), which gets complicated. So checking only one
range that covers all of them seems to be reasonable for simplicity
even though not entirely precise. And yes, [0x1e00000000000000,
0xffffffffffffffff] looks like the what we need.

[1] https://github.com/llvm/llvm-project/commit/cb6099ba43b9262a317083858a2=
9fd31af7efa5c
[2] https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Tran=
sforms/Instrumentation/HWAddressSanitizer.cpp#L1259

