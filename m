Return-Path: <linux-kernel+bounces-315417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861FB96C286
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309811F26342
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B11DEFCE;
	Wed,  4 Sep 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQxYUasP"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE51323D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463934; cv=none; b=Z2/+ei6Q26qYy/omACt4MyUV0q3PUgZ2JbGFvd/U1/mlSCW2nGstHCjO1FE8urMF/2pdlVtFVB5hGC+r0viWnp8l4s3dNHpfeTw0lJDrY/dBEACfHQKOFdUbqxKPdIlGPN7bXZfPE+VV57lL15xf5/z/fzlsVoORvzCxT8PrZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463934; c=relaxed/simple;
	bh=hRL9DFBXxdDrWw7plKF0fV4dZAmFDldc9Q0oA4ecjtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK5aqaUT8okUTiKOus0Zw9+lAfedz1S0LAZu/VMpTADQ3+PgIqFyUtezQTUQUtiC1iW6Q+4Wze6QOqMVXtNzyT2GM0zOUm3fgUTTCsHOpALORqmHowgXPvzWXNcysLPf+jaFOTuFlggbNdS2wsSBhix8BWU/VkWUnbWTMSqVMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQxYUasP; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c35357cdacso23397456d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725463931; x=1726068731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM/IFpi5RYBm4yhH7l5IBkkn9oGxsE6HXM9tVqpW5us=;
        b=cQxYUasPq6XO51i84f5zDt4vN11NCgi3n8wrn1h+On6GK3GGrYFrKwWcAxA2hcxggi
         vcMpKuuSs1as2BoQhgonx9Qggus+4VdQh2iPCGBWYTVT8G5DkJK2FrkxoyinCYrLPa++
         H91zJ5JDFwGDROarLbgFyP95OhMThhEp26McB69qK98SkSunq0MnzsatXOoQR2qlljlE
         kAJOF00ls/5N1TEu4ABys6093t2v+IJukJZlmkw/C4Zdn6isLeRqFzdqfq4FjwO3XNqK
         bDF6r+BNxIaOCk83cn9I5ULNlyXgOEZEYS8iGk2w5g03XlAq1zgla4AEhQpbZd9D2c+z
         kfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463931; x=1726068731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM/IFpi5RYBm4yhH7l5IBkkn9oGxsE6HXM9tVqpW5us=;
        b=sWQ8ln3kizRJHz7mpHEcbKtxQ9XeX4eMXAYJkWqAYsuWzxxWlAwA6EqPUqCX+WWvgx
         OMwy20wlbCrnc/0bqXq50SgOUiPBYuUcK1aDyHI4icFu76HONIePfDRAnUG7RnKBGfyO
         wMpoQBmhXCm5PUllPzqZEHmQq779n8xm5lEOVFyX8zdb2ZY73aOTPohYB9OrzrA9tp7G
         KrWM5Dg3D7oJLlLTeL1u3v7OrRh434r/pc+xztb+frAj6fuSks7P5LrlDfNXluJVtViP
         LGrWs3T1cdhkuwoBAYeISjwAaVdlrEyTvenNmMeQZcxJltXBHaT32LeB/l+cifU22YcJ
         rigQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9tenfuFNs+iavkBbSwlv9k0cxxRRJyw/B2QRW6tato4x2KVS9EZnOR4qGYHkZVolf7w68EeK3n2wtiA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycWTjsnPSUefiHVSqf6Tq6YMDWi3JPhDQcWhIFRT2leCqbo/IA
	sdbPLxzgqjGW/IXQ7xxVnBUIWXovig6ig5463RU/u/547N7ww8kOHQBNH3cFxqUE04Qn4W6qhdP
	oYrTKMmmyf61nuzkJ2YAmuefwwbyQLT7oNHQJ
X-Google-Smtp-Source: AGHT+IF7cNzX9uP5GhlbLmWqGq85REskaNJaP/BF1DkF/KV/nBnwwrAuzPCl12NVbF/GoqejRuXZkn35GVCLCGuRtH4=
X-Received: by 2002:a05:6214:5d87:b0:6c3:5dcf:bf5a with SMTP id
 6a1803df08f44-6c35dcfc5e2mr151765236d6.37.1725463931324; Wed, 04 Sep 2024
 08:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f362e80620e27859@google.com> <20240830095254.GA7769@willie-the-truck>
 <86wmjwvatn.wl-maz@kernel.org> <CANp29Y6EJXFTOy6Pd466r+RwzaGHe7JQMTaqMPSO2s7ubm-PKw@mail.gmail.com>
 <CAG_fn=UbWvN=FiXjU_QZKm_qDhxU8dZQ4fgELXsRsPCj4YHp9A@mail.gmail.com>
 <86seugvi25.wl-maz@kernel.org> <d7a686a5-dfc8-4e26-8e4a-11f90fbf6d68@sifive.com>
In-Reply-To: <d7a686a5-dfc8-4e26-8e4a-11f90fbf6d68@sifive.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 4 Sep 2024 17:31:31 +0200
Message-ID: <CAG_fn=W_Vde+fXhLGDdt0Mu+6bG8LxLew052MdFy2Lqiyj1qLA@mail.gmail.com>
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Marc Zyngier <maz@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Aleksandr Nogikh <nogikh@google.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	Will Deacon <will@kernel.org>, 
	syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>, 
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >>>> Who knows enough about KASAN to dig into this?
> >>
> >> This looks related to Samuel's "arm64: Fix KASAN random tag seed
> >> initialization" patch that landed in August.
> >
> > f75c235565f9 arm64: Fix KASAN random tag seed initialization
> >
> > $ git describe --contains f75c235565f9 --match=3Dv\*
> > v6.11-rc4~15^2
> >
> > So while this is in -rc4, -rc6 still has the same issue (with GCC --
> > clang is OK).
>
> I wouldn't expect it to be related to my patch. smp_build_mpidr_hash() ge=
ts
> called before kasan_init_sw_tags() both before and after applying my patc=
h.

Hm, you are right, this problem indeed dates back to v6.9 or earlier.

> Since the variable in question is a stack variable, the random tag is gen=
erated
> by GCC, not the kernel function.
>
> Since smp_build_mpidr_hash() is inlined into setup_arch(), which also cal=
ls
> kasan_init(), maybe the issue is that GCC tries to allocate the local var=
iable
> and write the tag to shadow memory before kasan_init() actually sets up t=
he
> shadow memory?

Should it be inlined at all?
setup_arch() is a __no_sanitize_address function, and
smp_build_mpidr_hash() is an instrumented one.
The latter is not supposed to be inlined into the former, unless the
latter is always_inline
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D67368,
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D89124).

The report seems to go away if I mark smp_build_mpidr_hash() as noinline.
This doesn't explain, though, why Clang build doesn't work at all...

>
> Regards,
> Samuel
>
> >> I am a bit surprised the bug is reported before the
> >> "KernelAddressSanitizer initialized" banner is printed - I thought we
> >> shouldn't be reporting anything until the tool is fully initialized.
> >
> > Specially if this can report false positives...
> >
> > Thanks,
> >
> >       M.
> >
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

