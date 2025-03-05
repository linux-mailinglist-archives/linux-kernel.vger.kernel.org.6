Return-Path: <linux-kernel+bounces-547678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E50A50C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BCF188A90C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E494D255229;
	Wed,  5 Mar 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8pjV7pG"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C632512D6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205599; cv=none; b=SmdWwzOG6mAhiOwJw0hj9O9BGGf07lql3HGZd5GC5cQdCf9PP5qh2aMwCj67f8aQftRH8B27F8aIBlxOBh8ZRm/7/qEuSjwi83tRkupPx0ymTwj+dWQzo9hP2iKIWfcoN1ty911pE5iEaORkcc2IsRP3bYy8JiyeNxJTnm8sYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205599; c=relaxed/simple;
	bh=Iy2SptRI8YQW/DPczz1dM8tfspwRL+VqmPjMz2EYmAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3lzxvYI8pkN6LnROW2WtYETbWCa15oMrxVLexISVsYHjmqROLAMJ5Tf+STo6magiSi/LQ0P/KYNVel/l1XOIfGtdk4bHucb367gJKSgxK6D2mflKk4I8vjR6nVLEczQWQW3UcJmUnzQF0ePMqSqMFB6j3CjFpqP6jhwtKqwX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8pjV7pG; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fead317874so4969177b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741205596; x=1741810396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy2SptRI8YQW/DPczz1dM8tfspwRL+VqmPjMz2EYmAQ=;
        b=c8pjV7pGUHCaP56uoB+4O4Dq5yoe3kIdbsXmwfocGM36dBve7SW9KfBjuCrzWM9tux
         Z+S6B7hXWTY8oYN1ciXSCnxcl7TqO7hcW4WFBOZcdbSRCsxma1PT6TC8c/O3WHTTGQ4X
         E4IOlbE/1hE7Atj8Af6YSpQ7Hjleckz7M2k9qLdI45gmtMU/PbflRaOkMIM+xVLPfYq8
         oWXj1OEA8WKCgFhb6Yy0+KqhJEx4ZRoQeD8jxFmlw8sXbmiCcPWvlfrXaGRD5phQckjM
         OHnbr2vy1XT2oQ80Tcw4LlsJi//SdIfzYyrPcgFVl0QdSV9CwR4BqslBmpuBqiJufRi/
         a3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205596; x=1741810396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy2SptRI8YQW/DPczz1dM8tfspwRL+VqmPjMz2EYmAQ=;
        b=ufC1MARIHyL5PkU8M4bvHKRI7yVZquBXzARhadBkJEwkCBhO6K1va5BSNeLNe2q59Z
         vAKRcBOLKzRt9AyImo6v4LpzioGL568bnBZtqP3EP/wNFudK2pnlmBuyUz+/Ppnqr3VD
         0Q3+tQR8QTvR0PGxnRoss33THEYA2cUz0fFtHSkmovdP1j618IhJMsT0dHOcOwjyXudJ
         dtFzhcJRQvfLeY9rEaXBpmMktQ3Hp3vu6FHSZWE/89luI5v1gnGVcDxGhSToXE561icv
         RaVfmwu9Qau4E35Zx4lyxsM+vW7MK5H0z6XfuTCX0+dj90MBf2XLxT7iVJkwhVuEz2MD
         BSdg==
X-Forwarded-Encrypted: i=1; AJvYcCVk66OU2ouxpLdnhxj0PsMqxnW7HF1SbpBZEUA7lAdoKoxKBexHYy+xhFVBSWOaLBMS5ZY3awKCSRoXzZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycC6TzyTePKiJ9koEdClRH3pyVf0ZN5/ljl+mC4bkhP8K9moQD
	hQKLOm9QxM8kWCp+yXfzCq+5Re0VsPkkJmSHPLBfH/HqrzMvfqp0qAFe7vSayRnjdgVF5lR7MOM
	6HJmWxynMK9UapOHDVIqaQ+S4nHE=
X-Gm-Gg: ASbGnct7fyK1DFUFM254fc5ghKG8p4TjEJvYsLzbADYtgZ9ZHqNh4q4xQ6U9gNwFSEZ
	XQm85KYUtLDf/cQMPjZATXK+110ZPSHHpfxgj9zj4ZN+SEnCs6LwOzN58HVk+mxErElD6gMUS0z
	BHEGxNGHo29I2eYpBMjgZUpzl8Ew==
X-Google-Smtp-Source: AGHT+IHd2siWiHRaURY8dxNWfbg/AD7QBNNK4/7lQNgq4ETwltoeJw+YxAsP6bqrC90lcpZaen+1qUJEgmyr7S2IZc4=
X-Received: by 2002:a05:690c:a9a:b0:6f7:50b7:8fe0 with SMTP id
 00721157ae682-6fda2fc4d38mr63327377b3.1.1741205595644; Wed, 05 Mar 2025
 12:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local> <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <Z8isNxBxC9pcG4KL@gmail.com>
In-Reply-To: <Z8isNxBxC9pcG4KL@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 5 Mar 2025 21:13:01 +0100
X-Gm-Features: AQ5f1JpXH2JUcJP0cW_q0zCM_ZUOoXVk8JRi209gPyVJbRo5Qpzd5w45PsDLXbM
Message-ID: <CAFULd4bDSh7fzm8xmMzn0YzF0pr=mLvzb9dVYhCajyXx=XBrtA@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:55=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Sat, Mar 1, 2025 at 1:38=E2=80=AFPM Borislav Petkov <bp@alien8.de> w=
rote:
> > >
> > > On Sat, Mar 01, 2025 at 10:05:56AM +0100, Uros Bizjak wrote:
> > > > OTOH, -Os, where different code size/performance heuristics are use=
d, now
> > > > performs better w.r.t code size.
> > >
> > > Did anything change since:
> > >
> > > 281dc5c5ec0f ("Give up on pushing CC_OPTIMIZE_FOR_SIZE")
> > > 3a55fb0d9fe8 ("Tell the world we gave up on pushing CC_OPTIMIZE_FOR_S=
IZE")
> > >
> > > wrt -Os?
> > >
> > > Because if not, we still don't love -Os and you can drop the -Os argu=
ment.
> >
> > The -Os argument was to show the effect of the patch when the compiler
> > is instructed to take care of the overall size. Giving the compiler
> > -O2 and then looking at the overall size of the produced binary is
> > just wrong.
> >
> > > And without any perf data showing any improvement, this patch does no=
thing but
> > > enlarge -O2 size...
> >
> > Even to my surprise, the patch has some noticeable effects on the
> > performance, please see the attachment in [1] for LMBench data or [2]
> > for some excerpts from the data. So, I think the patch has potential
> > to improve the performance.
> >
> > [1] https://lore.kernel.org/lkml/CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pU=
r42AVOWSnfKsg@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/CAFULd4ZsSKwJ4Dz3cCAgaVsa4ypbb0e2savO-=
3_Ltbs=3D1wzgKQ@mail.gmail.com/
>
> If you are measuring micro-costs, please make sure you pin the workload
> to a single CPU (via 'taskset' for example) and run 'perf stat --null
> --repeat 5' or so to measure the run-over-run noise of the benchmark.

I simply run the lmbench command, where the benchmark was obtained as
.rpm for Fedora 41 [1], assuming that the benchmark itself sets the
benchmarked system to the correct state and does enough repetitions to
obtain a meaningful result [2].

[1] https://fedora.pkgs.org/41/rpm-sphere-x86_64/lmbench-3.0-0.a9.3.x86_64.=
rpm.html
[2] https://www.usenix.org/legacy/publications/library/proceedings/sd96/ful=
l_papers/mcvoy.pdf

Thanks,
Uros.

