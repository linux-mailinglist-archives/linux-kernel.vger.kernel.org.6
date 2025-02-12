Return-Path: <linux-kernel+bounces-510446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D226A31CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86AB3A6CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5111DB154;
	Wed, 12 Feb 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9264kiS"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71B271839
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331630; cv=none; b=OaJPv/rHkzvQ2sc+ZSlJ9EpxfdHM1/2po043wfL5LIrm7AYlN4tWGho8rDt0PEugdjf478SCYJ6MtqOCORKFGReiA9K/jvTyrvDbpszBrpOEVAyaBYU8wEThS4VZEqO/8WaU3V3VOzmlohdq1BNEfMUyWTHvRxxgo5tk6XbJlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331630; c=relaxed/simple;
	bh=DBCyGV1EF2kVi6SpMZY5bssgMo6tiAe0sntzvUzsdoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haFg0uJVd5VV53Ypn2X6UlpBbDQl1q6jzKO8QkEzz9tu/PiZZN9ifMsfYxnk6mr2RJK3w9rNaTHn57nxV4PwAwLN00APAQppIYzOsftBO4RD0mSdBWFmiAfefsFiuSKreypGE4/EKwALlFl08u2YlG0NKY2O69mQaTtUjjAB9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V9264kiS; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f3c0c172f1so293846b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739331628; x=1739936428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1O1+kqXPDLIzus277gFO2o1Khwx0jyRKEzNJbJfbQ8=;
        b=V9264kiSmq56XVlnlBf4De6kBBSr1YtfnKVHh0GZwBcp/lTYcXSjfuW+w2+VJWqeeh
         iZ96+ARYCTQkOlLtbPTchOOEtsjpmCEniikv2Y7bFVXMA8Srnn6kFUhwerkob4fJIH2g
         g/H+K40JYDbrCNvZs8gnQFYnZAmGzIz4WeGvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739331628; x=1739936428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1O1+kqXPDLIzus277gFO2o1Khwx0jyRKEzNJbJfbQ8=;
        b=A/SUrf42MkbRG/Vl4UJguKkxsdwhYVYofSbXUq+TP5NmPNuh4lR1WeTujnDQzMRNbK
         vWsJve7U7WRWvi6StPSlvlRfv0sf3Tsc6JLdw8WccGe7im6J+R6WCks9FOseNV+fTdgI
         qRRDeHPYK674i6lxAsXlX2wMAiWLpV2rYk/5BRn6/3Ir4q1g9UcBg74jvuLy1Ny4CBZ8
         nWj7AS2losOuiB6rBdHzBlgPEhIIzOiYAPa9onCiFRmCcZZucnIShi2m3BPnSinpuvM+
         rOkDTszCXfnMbtNmYYhbzRqJC3blaKQO0F0QjimiQ34rUZ/qZzqQAuQo9yDBvF0qQ7lI
         C4jw==
X-Forwarded-Encrypted: i=1; AJvYcCXsWqJJGogTqtpmlDFCsn4thmBZb6dPw/QhPXer/VWKVAQjN0zIv9YQARVyiZU8T3furJ6MfhcIVPxGEug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNb8LunD5fn51uLADB2qZldQ7/ZFGLBd+xGexlszhrY4FfUU4W
	FKL/NDBnUlSh5WOaki+WZebyvFue2b5OAXbDlmtsQNL2/JcE0Bcy48SR7TWlgdT0L2bGxA327mu
	s0gb0ZDGPDuvVjAaR/5O8F3IDS8he+BarM36R
X-Gm-Gg: ASbGncs4Yt34QKKCxp8dCy6+SK1+lLcmWBHtRszPpK6n4QLC09XXCCdv+PwljyVDpfG
	1qNuEratKyUUDWYT1jjxMezsaMPcYB0CocIlQsyyu9IyobusLoKUURdF5gjqLknms2oGnlIzGrk
	oqb5LxoUmRgrlqeAXYSjG1LnoRDDtBfA==
X-Google-Smtp-Source: AGHT+IHS5JwD+Jt0SwmBinJt8SPZp/OeUf8HMOU2PgEZ1F7kG42eaLlTkBqNf1TT9g4dqMBA7NLngUztb2UDdxDdlzk=
X-Received: by 2002:a05:6808:1817:b0:3f3:b2e6:f57d with SMTP id
 5614622812f47-3f3cefd766bmr279476b6e.3.1739331627854; Tue, 11 Feb 2025
 19:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-2-jeffxu@google.com>
 <8899161a-573d-4826-a6f8-88c2dd145692@infradead.org>
In-Reply-To: <8899161a-573d-4826-a6f8-88c2dd145692@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Feb 2025 19:40:16 -0800
X-Gm-Features: AWEUYZmE2X6QlpBPZRLc059M-Bg0dneOqDbOfyqMe-duzNz4oMske6H0kyectqU
Message-ID: <CABi2SkWeTCZ+vfLLvgNe+M98N0Dnyzd+SyhF3Bx8rM5YPMuFhg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, davem@davemloft.net, 
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:31=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 2/11/25 7:21 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
>
> > ---
> >  include/linux/userprocess.h | 18 ++++++++++++++++++
> >  init/Kconfig                | 18 ++++++++++++++++++
> >  security/Kconfig            | 18 ++++++++++++++++++
> >  3 files changed, 54 insertions(+)
> >  create mode 100644 include/linux/userprocess.h
> >
>
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..892d2bcdf397 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > +     bool
> > +     help
> > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       To enable this feature, the architecture needs to update their
> > +       speical mappings calls to include the sealing flag and confirm
>
>           special
>
Ack, will fix.

Thanks !
-Jeff

> > +       that it doesn't unmap/remap system mappings during the life
> > +       time of the process. After the architecture enables this, a
> > +       distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage acce=
ss
> > +       to the feature.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config HAVE_PERF_EVENTS
> >       bool
> >       help
>
>
> --
> ~Randy
>

