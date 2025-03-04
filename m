Return-Path: <linux-kernel+bounces-543685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4F4A4D8AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565BE3A4F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56C1FF1B1;
	Tue,  4 Mar 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSJxmG0i"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C81F37CE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080415; cv=none; b=TPG3KPV3Io+Yau21grqNkMZIms78X568x6+wXnphubZJaCjmkUEus8IqRVFdehnn6tkQvTb8wrxJWLrtrC+Mi4IaKDzlUOZUUas3LEAwrxYYsQ/Sgj99W4apRQXp4xhKURKcFSSg9MY6dLOalhzBQRtfZnuHgMjsue4/jHbAUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080415; c=relaxed/simple;
	bh=ngTjm3wKPFbc6t66JOZalOcvwoArJEVbDeWSYS0wuiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5AURpAAftlwRmeNz5P3wBwainwfIUOgFJ4719x7CU9G735+kpXm5bN7mjFiaiVmWfkBcXMnRwTAg/PvUOWUV5gi9WrerZsuZlIwkz+oWtxaPWQglVYYDMo/FykOvB1SdRbruOJampNdbH/ORIlNm6hhajgnmN3nV0KbyxLc/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSJxmG0i; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so6358665e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741080410; x=1741685210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3cnCoqSgCLSn8a978dMdMagQ1ah9AakWwYcXfYLV6w=;
        b=DSJxmG0iE/AnhTEgD9bmVGzpTrWpc+TcRjLmtOx7wipq98qybTIgDqBaiQePJtxBCa
         Yg+LQH2hORLVaanXZDwrcIaWgG97BCSbSqwNloGNroBOLbKI86eayD5RqI2WPdVDFWz1
         jmQup2zmVE7n/VzaiZMVTt74M/+w/ZLqQhXjqLnrCfeGhhpIgV/kzaIcfYaFMVN1DF/4
         H+o9BH2JV4Z81polBaMylFMvo0U/e+h4tmJPBp+JtVov6F9KB7rsqoTZF/ClLoyMFPV3
         kmBEcpYXItTkX2Rck/exx1EtZXJVP/cTJSDpzib/iugFHzwrnQkWVjJjDkxPBomn4G3m
         FXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080410; x=1741685210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3cnCoqSgCLSn8a978dMdMagQ1ah9AakWwYcXfYLV6w=;
        b=Vx/aUU7zDBmxOCfwx8g5j00Ly8ZFNdR89kZZjmA69ZMmJHwvIPn1QNEH2Altia5AuM
         SuqIFVszT+bHMrS/aEVLL3bcQZivSoEugjFTCoAYl0l/YaXAmMYav+UCi6P7GiUsnH4c
         K2DMuIDQeShKKD9ey6CQn2bbg88UozNrupDS3XgZqbctBswN2AkGUJ7Tptxnne51tJsA
         8tOT0I3gx59DIQLsrai7Hq+gEILzG6YhfJSb2JYFxu9A0X/vLEPe7yKTHa4nRQ6aGUaE
         NTChE+T1D2PMfIrUwKgXCmi8r9Zysw9+280Kd34cP/Km6zrTkkftAuY6503biugfJugr
         Nn9g==
X-Gm-Message-State: AOJu0YytM9B8LjCWpVbPLpsONhfdjX9UaqxmFvFwGbOlZVKF15kWJWVb
	h56VUgg0U0qqdoRzL08/bajVGMOVL+1W8BlAaOaZQFafhfEaqbPdz74ONeRObpwMd4OeIEaPUni
	4IFIB5lnYaUzkc18d3vccRwbPTQ==
X-Gm-Gg: ASbGnctLQjRxVyclbs+rMW+V5cbf+k/+Tw4WFNY2SwbnRrdA8YukpLJA711J5TvdwVr
	RjH9aAoylLDb1vFRbBQ5t7wB/jKNOv3FFZP2OuRy4ayaD7LPVIbZeZ/v8KqDbDYR9wPVqCzI5Qe
	ExDDtgznKO2WzsCW+rlN4X5gNtWaOSo4T7M394M+9j
X-Google-Smtp-Source: AGHT+IFtGnp8h5cRfI8ialBWiTIbhGfrvIXhlP/FkcbLWSpAZbnQkhb0ZOXLR8SDpAd+qcWL605w63/X87yqDggp36o=
X-Received: by 2002:a05:6512:318e:b0:545:27af:f2d1 with SMTP id
 2adb3069b0e04-5494c38c202mr5194000e87.44.1741080410243; Tue, 04 Mar 2025
 01:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303165246.2175811-1-brgerst@gmail.com> <Z8YTYWs-DeDHal1Q@gmail.com>
 <CAMzpN2iB4Gv0Fq1pNtk7bpa2z6eYwQGYXT0=p=_wWDBE9Uxa7w@mail.gmail.com> <Z8a-NVJs-pm5W-mG@gmail.com>
In-Reply-To: <Z8a-NVJs-pm5W-mG@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 4 Mar 2025 04:26:38 -0500
X-Gm-Features: AQ5f1JrrXlN8I_sVcoMxmyGwO3RWQG-EzazhOxET-xzb2CgOwGudAlqKhT3Zto0
Message-ID: <CAMzpN2gpHRtOtRuCJF_TKOFbEJ2xkksndCH+MfntfDuZHC0O1w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > >
> > > -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> > > +       PERCPU_SECTION(L1_CACHE_BYTES)
> > >         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D 64, "perc=
pu cache hot section too large")
> > >
> > >         RUNTIME_CONST_VARIABLES
> > >
> >
> > That is probably the right call.  The initial percpu section is just
> > used by the boot cpu early and as a template for the dynamically
> > allocated percpu memory, which should account for the proper
> > alignment for NUMA.
>
> Okay.
>
> Randconfig testing found another corner case with the attached config:
>
>     KSYMS   .tmp_vmlinux0.kallsyms.S
>     AS      .tmp_vmlinux0.kallsyms.o
>     LD      .tmp_vmlinux1
>   ld: percpu cache hot section too large
>   make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
>
> (I haven't figured out the root cause yet.)

CONFIG_MPENTIUM4 sets X86_L1_CACHE_SHIFT to 7 (128 bytes).


Brian Gerst

