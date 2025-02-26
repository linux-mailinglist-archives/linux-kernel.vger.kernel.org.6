Return-Path: <linux-kernel+bounces-534799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC6A46B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E1318893C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF312505A4;
	Wed, 26 Feb 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeCQF9/V"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF6248863;
	Wed, 26 Feb 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599090; cv=none; b=AzyrovifTKyR8kN8lsGhqsM/GOavqasddksT5mPQDQ8AadTgH/584a+Kf0PS4ReV2RwB0m1VJGuvQ2Hd4+Ms4HXSlD9BHvei2MekSY16LdAEJ5On7b1bKZEDhQIMCvw+1oRNJNfdPGwmEK6ytTwi4wp7MKK2LtdNerFMO8j9Dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599090; c=relaxed/simple;
	bh=0ALXJzO2ZhXP82Zb99HSpRWAbbmI+C+3+0buhND8ud8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJ2DFEpOAYh9xTZy6/rJGLUjU36KhB2HFkHHySKrEvYhjltTgpEE5qgxxD1zqtXx1ZnOJlXgw2YNNMaFcSv9NDVUPaDVNCncuPvmhKLzkuRBGoRuCYfbn3Fb0rrBwfXDZA7NDEIUxJVv47zNDDCHHbJF4szZvPfsBpWNttXZYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeCQF9/V; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f406e9f80so71327f8f.2;
        Wed, 26 Feb 2025 11:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740599087; x=1741203887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ALXJzO2ZhXP82Zb99HSpRWAbbmI+C+3+0buhND8ud8=;
        b=TeCQF9/Vqt77tczJxQOxxTVQ0t6tehjBAi4SS01dBrNwOsY6EyU2pyR5q1ATMtD8Lm
         rHjZEdu6ndkdWljfr+KZJdCt0l5WCSIOizyHwO4i4EdYzA1vsiamwqYnQoENnWOwP2RT
         1jI2aywN6XXGQ8CckyLR7pVNgjGbTygtn1I45vCd+hSsJvtpTBhmEqDPhwM/OffI1bru
         gHfBgWAEBjZZogTClO+twEuZysHDhUFxs8B25zV9EuFHU/ffEzerBl20lrxnpVj0IsNb
         ndl+GXxLU3J6FJzRzLRkaPxWmilYc07ifucf0N5KMN5xCF9+A2CMgug63IfcI0wSfnrO
         X3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740599087; x=1741203887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ALXJzO2ZhXP82Zb99HSpRWAbbmI+C+3+0buhND8ud8=;
        b=cA0Kb6Goq1gimoBtJXT88W7i3ex3E5MGFrHmFoxfJkBaQ+OEDElVG6lZ5SAdVr/L+m
         G3tmCpYHr1PHO6TeanVmLJtTp6vQcET0vpR85EAyQ9acK93ugOLqP1Xuhb2hGui0dp68
         McMJfwuSbyqurluy9NZBvlno8E/yFk7HZZ/0b7U1U1550dDxEOhTb8y1bhLd0pO0iHl/
         xxxbgPpxn40xDtm+KQp92Yuko1gz4SGW2Rc2GtFAlWxkgmAvOWtz+oECBu0C5FGpqKQ6
         s1g47cwk0cXh/zJOs+jOffAl3t+IWF2SkE55nOdNEkNGvQAnHpdy33T7Zih1OakRRTnJ
         EuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU24GX5XrzUJVse31LT/jaxlKxoGcJjYddTDFDGlCBGKPOHAtxgfSGbrGT9rTaT1cHAxSy8SWNuVuY=@vger.kernel.org, AJvYcCXJcwauOQwRHkm9rNohzjUaZcCgiY3AnelBxq4r0niHGyjomHst0TPXjBUqc3mPJKi/A+DVOCxkWRBJKI0r@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYThGSO9S/Ogtp+ZKlwmnJc4pp7ndiCINpTEzGdJyB5SlREz9
	rGebKT4VUmU/cfQZ1sMQcDOoDIg4tEVg5ZMTV9G3r5zbRUWty6JnuW0hUUwz+UuUdIdnn1wMrjz
	/7KeF/yz/MyDfExLrKhl948qHhRk=
X-Gm-Gg: ASbGncvLwshD/cewohHAxiGEwHPKzuxyfOzU98gQ8lcTukgGcgxkb9n6gXrridUfPMw
	oCXTbgCMKxQCq8nfqstwTGALFi+O3YIM63ew7eHHqtDqcEcGfZmEk/n5HZZrTMCfJHbrzB/gyV/
	SIYtjQm3B0aA==
X-Google-Smtp-Source: AGHT+IHilSXiABFjyw+TG/xRCYQ7cyaP2Rc5n1xYVBGwvzFT0zNXCjxGLoWyBMyb5UlgopzX0CdEgRn+K7Y4/n90qsI=
X-Received: by 2002:a05:6000:1848:b0:38d:d5af:29af with SMTP id
 ffacd0b85a97d-390d4fa3e25mr3522475f8f.49.1740599087190; Wed, 26 Feb 2025
 11:44:47 -0800 (PST)
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
 <gisttijkccu6pynsdhvv3lpyxx7bxpvqbni43ybsa5axujr7qj@7feqy5fy2kgt>
 <6wdzi5lszeaycdfjjowrbsnniks35zhatavknktskslwop5fne@uv5wzotu4ri4>
 <CA+fCnZeEm+-RzqEXp1FqYJ5Gsm+mUZh5k3nq=92ZuTiqwsaWvA@mail.gmail.com> <qnxlqbc4cs7izjilisbjlrup4zyntjyucvfa4s6eegn72wfbkd@czthvwkdvo3v>
In-Reply-To: <qnxlqbc4cs7izjilisbjlrup4zyntjyucvfa4s6eegn72wfbkd@czthvwkdvo3v>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 26 Feb 2025 20:44:35 +0100
X-Gm-Features: AQ5f1JrdMqMC3b0HBepr7R3zwbWYmhOcf6RK7JusOEJWTmRQO7QPte-5YIs-RgA
Message-ID: <CA+fCnZdUFO0+G9HHy4oaQfEx8sm3D_ZfxdkH3y2ZojjYqTN74Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Vitaly Buka <vitalybuka@google.com>, kees@kernel.org, 
	julian.stecklina@cyberus-technology.de, kevinloughlin@google.com, 
	peterz@infradead.org, tglx@linutronix.de, justinstitt@google.com, 
	catalin.marinas@arm.com, wangkefeng.wang@huawei.com, bhe@redhat.com, 
	ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, will@kernel.org, 
	ardb@kernel.org, jason.andryuk@amd.com, dave.hansen@linux.intel.com, 
	pasha.tatashin@soleen.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
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

On Wed, Feb 26, 2025 at 5:43=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >What value can bit 63 and take for _valid kernel_ pointers (on which
> >KASAN is intended to operate)? If it is always 1, we could arguably
> >change the compiler to do | 0xFE for CompileKernel. Which would leave
> >us with only one region to check: [0xfe00000000000000,
> >0xffffffffffffffff]. But I don't know whether changing the compiler
> >makes sense: it technically does as instructed by the LAM spec.
> >(Vitaly, any thoughts? For context: we are discussing how to check
> >whether a pointer can be a result of a memory-to-shadow mapping
> >applied to a potentially invalid pointer in kernel HWASAN.)
>
> With LAM, valid pointers need to have bits 63 and 56 equal for 5 level pa=
ging
> and bits 63 and 47 equal for 4 level paging. Both set for kernel addresse=
s and
> both clear for user addresses.

Ah, OK. Then I guess we could even change to compiler to do | 0xFF,
same as arm. But I don't know if this makes sense.

> >With the way the compiler works right now, for the perfectly precise
> >check, I think we need to check 2 ranges: [0xfe00000000000000,
> >0xffffffffffffffff] for when bit 63 is set (of a potentially-invalid
> >pointer to which memory-to-shadow mapping is to be applied) and
> >[0x7e00000000000000, 0x7fffffffffffffff] for when bit 63 is reset. Bit
> >56 ranges through [0, 1] in both cases.
> >
> >However, in these patches, you use only bits [60:57]. The compiler is
> >not aware of this, so it still sets bits [62:57], and we end up with
> >the same two ranges. But in the KASAN code, you only set bits [60:57],
> >and thus we can end up with 8 potential ranges (2 possible values for
> >each of the top 3 bits), which gets complicated. So checking only one
> >range that covers all of them seems to be reasonable for simplicity
> >even though not entirely precise. And yes, [0x1e00000000000000,
> >0xffffffffffffffff] looks like the what we need.
>
> Aren't the 2 ranges you mentioned in the previous paragraph still valid, =
no
> matter what bits the __tag_set() function uses? I mean bits 62:57 are sti=
ll
> reset by the compiler so bits 62:61 still won't matter. For example addre=
sses
> 0x1e00000000000000 and 0x3e00000000000000 will resolve to the same thing =
after
> the compiler is done with them right?

Ah, yes, you're right, it's the same 2 ranges.

I was thinking about the outline instrumentation mode, where the
shadow address would be calculated based on resetting only bits
[60:57]. But then there we have a addr_has_metadata() check in
kasan_check_range(), so KASAN should not try to deference a bad shadow
address and thus should not reach kasan_non_canonical_hook() anyway.

