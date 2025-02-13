Return-Path: <linux-kernel+bounces-512140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A4EA334B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF300161CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F5E13CA97;
	Thu, 13 Feb 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDo++T07"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD23139CE3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410103; cv=none; b=JFAW7M1mTdie83/shxl25nR9Tf38hm3GQhTTHaIEUWIfBWl6y3x1vjiGMeHn+AbbLi6gGOxbT877l7DKpctQMU5hjhzd5roj7ljhN6MgJKbmcMz30OFwTyjTxo5GLAvw9Www5wbOKk6NxJDyWV6PL239fPL43jYLAFruyFtQp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410103; c=relaxed/simple;
	bh=FnnVExe7d6QVUJNp8Nm3NF0K0bg0bBBcU3T/4AzgGYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRujwRSVtBRV4tswZiCnrUE+Zlh5t5gX/U35/lNG0fPBfJ0J3mNkhezKHUek084OLN/64blE8FY6efFnuUfBKZF/J6TKE3BV3ivgFFvFDbEQdk07QXwgwXsGs8EzerPHYMCuiAMjeOD4/XFiu4x4x1jdCfOcrBB50TSs+zn95dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDo++T07; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38de17a5fc9so158112f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739410099; x=1740014899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnnVExe7d6QVUJNp8Nm3NF0K0bg0bBBcU3T/4AzgGYI=;
        b=dDo++T07RdJ1EsTu98bywJCBtkqwllWlGf/bhcEfrU3S2OD7AV9EveCGyR6WdozvSv
         40+Kf0HnapF97GQ61DSEI+kzSytjDC4Hby6NwVlNrp4sDPX/077hojRKxTctM4xfge7q
         xLJTrNtkoqwoNaOflWC90TvWPrgBwmPggWLiztBYUXu7EXKEQd2RkMy1ZH8uKv0oRbHZ
         WLg0A/DqcRXQ1dca/HvkRApkVDtT/O+hSf0hAnQEzqmaMa0/SF1+1J9M4gk1/9fFayrU
         MaOPAO/BGSowqEMkJCB1o8/5aos7ml1OcrPiQtRGXriVwyXdspB2qwqovpcDhk20hHiq
         k3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739410099; x=1740014899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnnVExe7d6QVUJNp8Nm3NF0K0bg0bBBcU3T/4AzgGYI=;
        b=Z5fpH6mI+g/UvOOFs3NqfnfsIBF6aOHaxB685+pSO8T7u75oX1ZwOsauB3wT01l8F9
         J1U9ORP2TQ3GOBqpAKKyQqRlX9gNAo51cE7JsGZlsiElpMxraxkbEpiaERyO9RFYqBBa
         I+kiP7oQGK8v12COThK74iqNeAJIAfHUyHBPrVjQl0vNIw7ORaAZeK4FzObm2qabtipS
         ufBKDBYb5PWaRTOzNZqudFJIJ5mPdp6skwxDviwIvCKBCCWvdkuaQzQcVv68f152iH/j
         ljnKdIorXfvrMUGBU72GNQkT0pH9MyPxCJi5EkHn7t6qnLygKSpz7cXGaD+saOIdlhp0
         4NhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDf5/LsGT3E/bfR+wDTRQJEVYJi5KzFuT/JAiQTVxyW2XDCHtczbj64Ys6f43PElIIvZQ8pGOK6goms48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKkemejk/J1IIyI3seh1qWcoYr1d2c8Jo3ArBGGsQMopihCMT
	wEWhxR40A/FBns5uTFTgeUeFgJAwgmir+jqHLhj/PpcthdU6NL7fSQkyebELynhFfJ1pD2TCGq2
	AAI/tt6vOrA126aH/H4Eengn1OVo=
X-Gm-Gg: ASbGncvSM1Y/4fldd65P8U4xDPcJ8Ks3gZgfHgouhvUGjAxyZIOfd8UMRukk3jOiOGH
	iJaZJCLU9VzyT7UPBdlpHSngspgMp8vnmp7zjD+QpTcmj5eVbIwvhYh8XO2Qt9Od8vlymMDbZ19
	o=
X-Google-Smtp-Source: AGHT+IEhltifMX701fYkEDmSU69qM9C3gXECNDsqw8PpPT3Yw5x0mc+ricaPHhG6ElqQmHswedH/T+PZOKbLltISlh4=
X-Received: by 2002:a05:6000:144f:b0:38f:227e:6ff2 with SMTP id
 ffacd0b85a97d-38f244df054mr1302880f8f.14.1739410099435; Wed, 12 Feb 2025
 17:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
 <20241022015913.3524425-2-samuel.holland@sifive.com> <CA+fCnZeBEe3VWm=VfYvG-f4eh2jAFP-p4Xn4SLEeFCGTudVuEw@mail.gmail.com>
 <e7t5yzfw3dq5stp5xjy5yclcx6ikne4vwz7d6w2ukfw2b7gr6t@oomoynf3b2jl>
 <zjuvfdbl7q76ahdxk3lrgaznk7vjj43f5ftzfgrnca6dqtcd5x@5qj24womzgyq>
 <CA+fCnZfySpeRy0FCFidLdUUeqp97eBdjAqQyYPpz1WxYwcsW9A@mail.gmail.com>
 <aqhm7lc57srsfuff3bceb3dcmsdyxksb7t6bgwbqi54ppevpoh@apolj3nteaz6> <CA+fCnZdjTkreTcoo+J8wMhwDuAFM4g33U5BFy0OPtE0UCvyJbQ@mail.gmail.com>
In-Reply-To: <CA+fCnZdjTkreTcoo+J8wMhwDuAFM4g33U5BFy0OPtE0UCvyJbQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 13 Feb 2025 02:28:08 +0100
X-Gm-Features: AWEUYZn2XkAKpo5fHBIg4DaefcDCWc7cwclFMrZ0d3cOTpLW86BXbO6cjB81ilc
Message-ID: <CA+fCnZcoVdfXVN8VBFLx835cV0eGAT6Ewror2whLW761JnHjNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:21=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Feb 11, 2025 at 7:07=E2=80=AFPM Maciej Wieczor-Retman
> <maciej.wieczor-retman@intel.com> wrote:
> >
> > I did some experiments with multiple addresses passed through
> > kasan_mem_to_shadow(). And it seems like we can get almost any address =
out when
> > we consider any random bogus pointers.
> >
> > I used the KASAN_SHADOW_OFFSET from your example above. Userspace addre=
sses seem
> > to map to the range [KASAN_SHADOW_OFFSET - 0xffff8fffffffffff]. Then go=
ing
> > through non-canonical addresses until 0x0007ffffffffffff we reach the e=
nd of
> > kernel LA and we loop around. Then the addresses seem to go from 0 unti=
l we
> > again start reaching the kernel space and then it maps into the proper =
shadow
> > memory.
> >
> > It gave me the same results when using the previous version of
> > kasan_mem_to_shadow() so I'm wondering whether I'm doing this experimen=
t
> > incorrectly or if there aren't any addresses we can rule out here?
>
> By the definition of the shadow mapping, if we apply that mapping to
> the whole 64-bit address space, the result will only contain 1/8th
> (1/16th for SW/HW_TAGS) of that space.
>
> For example, with the current upstream value of KASAN_SHADOW_OFFSET on
> x86 and arm64, the value of the top 3 bits (4 for SW/HW_TAGS) of any
> shadow address are always the same: KASAN_SHADOW_OFFSET's value is
> such that the shadow address calculation never overflows. Addresses
> that have a different value for those top 3 bits are the once we can
> rule out.

Eh, scratch that, the 3rd bit from the top changes, as
KASAN_SHADOW_OFFSET is not a that-well-aligned value, the overall size
of the mapping holds.

> The KASAN_SHADOW_OFFSET value from my example does rely on the
> overflow (arguably, this makes things more confusing [1]). But still,
> the possible values of shadow addresses should only cover 1/16th of
> the address space.
>
> So whether the address belongs to that 1/8th (1/16th) of the address
> space is what we want to check in kasan_non_canonical_hook().
>
> The current upstream version of kasan_non_canonical_hook() actually
> does a simplified check by only checking for the lower bound (e.g. for
> x86, there's also an upper bound: KASAN_SHADOW_OFFSET +
> (0xffffffffffffffff >> 3) =3D=3D 0xfffffbffffffffff), so we could improve
> it.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218043

