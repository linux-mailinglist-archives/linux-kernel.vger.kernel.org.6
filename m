Return-Path: <linux-kernel+bounces-544561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA315A4E306
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE33A4A79
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319AE286290;
	Tue,  4 Mar 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1WihUrq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669A28628C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100454; cv=none; b=upQPEXixVg1vMKS/Td0NJUNVn38qmLffZ4aYbuf28scqa0qUnIEeISf5oV9Ba8yJH+UB8gzvpsG7ehRiHLPApZaaYOORGeeic3mn8MZUSWgL1L2MEHPex76sxiR7EVKQFAoozxcoi27vCmCv8dJ+mgcmeLZZPonBiKym72N6Pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100454; c=relaxed/simple;
	bh=BlRyUHi1/9WLo2thjf8nE2lR4dJOYm4R8Ic57D2gBUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLveus0gTTHJujdQfsVkuNsLHUuLKaliwlJH2m4kHXT0Gv16GxlU0NBOpHYhwAFe37QpKkg4ZDZtEWEWQlPXdV0e1Dd9PEaO/16rbzD4SlD1VVJMpt3bgooU6qTCv6pJ4v80Xm3MlxQrGFZFxq+4svQc76uVphAV5yUDJYrjweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1WihUrq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so6739952e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741100450; x=1741705250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9oAc9RXyHjtozCaeG7YNctUjs0ur3PcMX/gfa6fUXc=;
        b=U1WihUrqGMGDCJIWjXZWUyqRNOr8JFxaGbe7oGoZ362GndVKBM4vY1m2S3p5AT4+XM
         UpLP5jc332jBbeinHaJ9TXUzdnUZGSQgjLXS5Wim48E6by7h0jVTfYLGRtDfY1PEOF2e
         +gC7FBQFCuzipVqtWxfdpkfeQShzlWqT13z/Gmulifc69Lc0xUeXZviH0kFztQc9LmCt
         9RhWHY8DB4SMKpL1M9bwAiHfvH4f6wJkEy+MvcHAsHwYkV+wBDk6DbfXvKLHv+FpnHxR
         T2utoxrvXvsb51S5b4xsZDo5yiCG3SM7OjDidYVIz4u9PpCknGFPhcGD8x30zq8xJQie
         Rlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100450; x=1741705250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9oAc9RXyHjtozCaeG7YNctUjs0ur3PcMX/gfa6fUXc=;
        b=wTR7bI+KXA5y+CThIknAuwcagglIyxwB34RExb8oO2Lcw44ncnCZnPRDPmNxr0qUZC
         xioqlGqRIggwvKW/ACyoomjGp9od/fP2N3oec/jVTGloDjMn6JAIlFEUPGFR5XxhRF7/
         9LzbftfGppdcsLwYexK+/P78smK9zwhX37G7MNKMsMq4c0lK+UnJfkWa5qAheggArmCF
         1Ba4DLjWfvAl/6tFf4rCijQ1SpgHrN1UX+ABn6X8DnsL8SUh7nd7GIcFZoRiQRyGY6Ql
         fdIdXQ9hM1Diu+gMhGHjn75nE91ZvvI1zSUWwjNjvOQ2358YBF8XQX9k6jpjKopw298p
         CG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3SjTqes/e/dBWSpgoW+7l+z1pGtc0sgjDZCanH0GDGbEwgFVwH1jUvUUbCXjeKx6Ql1YEdzfqnJSR+/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xAp3MFv/ZDarAEm6XtXoyWrExHPkX9TWmDU7Gu7UzwxD6d7Q
	lFofYNzSZiuxr04yZc6pjlsn535Tb9OcWqbWjBOPg8k6DwaIXPWvxSbqCXVXTftYYGR/vxhg66W
	Nq2p5VHlcETxF+WCtoEke6Kc2hA==
X-Gm-Gg: ASbGncuT4sDhB6VFqNpiQyMYTs2N6AG176xFJySWUQJz/rL3i5H7I60P1Iw3h+78MB6
	/ha/g/X4KGM9+emgehu6H27eMS+TN/cEK3gLFaECWdEe2rMHcL5MFptza36GNnAfq2t9tGawXRd
	MlJABmNLE3BCe9e0hX4joXUJNET0GqYxKlKvnEcWR0
X-Google-Smtp-Source: AGHT+IFZBEFNWft/k0ipX+wdwzYgWTq681XFAOpbPmWCq/PFGY8gI2ozN0dP5AWvxJSFtbtKPi+RdXu6T8K6R4KiHDM=
X-Received: by 2002:ac2:4f01:0:b0:549:38eb:d690 with SMTP id
 2adb3069b0e04-5494c37d998mr6180680e87.36.1741100449381; Tue, 04 Mar 2025
 07:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303165246.2175811-1-brgerst@gmail.com> <Z8YTYWs-DeDHal1Q@gmail.com>
 <CAMzpN2iB4Gv0Fq1pNtk7bpa2z6eYwQGYXT0=p=_wWDBE9Uxa7w@mail.gmail.com>
 <Z8a-NVJs-pm5W-mG@gmail.com> <CAMzpN2gpHRtOtRuCJF_TKOFbEJ2xkksndCH+MfntfDuZHC0O1w@mail.gmail.com>
 <Z8bMSr8JrDZtqwK8@gmail.com> <CAFULd4YFm-2Sc6NOzyWt4-TPDkwY-=5h-Gb99M+tFf-Mczk0Ng@mail.gmail.com>
 <Z8bOIXeWYycUEmp4@gmail.com>
In-Reply-To: <Z8bOIXeWYycUEmp4@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 4 Mar 2025 10:00:37 -0500
X-Gm-Features: AQ5f1JrnX3yviP5nMa7DgEknye_ue3YIzQMMt8c9YgusTLMc7pXjZTGV9MggJNY
Message-ID: <CAMzpN2jUKp93z=jeXqa0uA-kQtaZ931aehZLm_axZoqGCeQZJQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Tue, Mar 4, 2025 at 10:48=E2=80=AFAM Ingo Molnar <mingo@kernel.org> =
wrote:
> > >
> > >
> > > * Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > > On Tue, Mar 4, 2025 at 3:47=E2=80=AFAM Ingo Molnar <mingo@kernel.or=
g> wrote:
> > > > >
> > > > >
> > > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > > >
> > > > > > >
> > > > > > > -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> > > > > > > +       PERCPU_SECTION(L1_CACHE_BYTES)
> > > > > > >         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D 6=
4, "percpu cache hot section too large")
> > > > > > >
> > > > > > >         RUNTIME_CONST_VARIABLES
> > > > > > >
> > > > > >
> > > > > > That is probably the right call.  The initial percpu section is=
 just
> > > > > > used by the boot cpu early and as a template for the dynamicall=
y
> > > > > > allocated percpu memory, which should account for the proper
> > > > > > alignment for NUMA.
> > > > >
> > > > > Okay.
> > > > >
> > > > > Randconfig testing found another corner case with the attached co=
nfig:
> > > > >
> > > > >     KSYMS   .tmp_vmlinux0.kallsyms.S
> > > > >     AS      .tmp_vmlinux0.kallsyms.o
> > > > >     LD      .tmp_vmlinux1
> > > > >   ld: percpu cache hot section too large
> > > > >   make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> > > > >
> > > > > (I haven't figured out the root cause yet.)
> > > >
> > > > CONFIG_MPENTIUM4 sets X86_L1_CACHE_SHIFT to 7 (128 bytes).
> > >
> > > Hm, to resolve this I'd go for the easy out of explicitly using '64' =
as
> > > the size limit - like we did it in the C space.
> >
> > Why not simply:
> >
> > ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D L1_CACHE_BYTES, "..=
.")
> >
> > ?
>
> I don't think it's a great idea to randomly allow a larger section
> depending on the .config ... The *actual* intended limit is 64, not 128
> and not 4096, so I'd suggest we write it out as before.

Change the assert to:
       ASSERT(__per_cpu_hot_pad - __per_cpu_hot_start <=3D 64, "percpu
cache hot section too large")

We only care about the used portion, not the padded end.


Brian Gerst

