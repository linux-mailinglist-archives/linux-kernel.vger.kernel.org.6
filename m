Return-Path: <linux-kernel+bounces-544849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16953A4E6B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8192F8A17BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E327FE61;
	Tue,  4 Mar 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjsqJ05d"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168227F4EB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104131; cv=none; b=Y3cLaVFVJ3YsooYutIx2YHfJLcLkbo3uVNlH+VB8k+o7XQf/K9Kgj4GRm883Zh6bYK8RmhA2QzJFbmQ5e10yDHrLFiGhlw3CGVXEWTvnYi3JmwGRq5HgvHgIaa80QERxO0I9hseESnTYkpjyHV0XgmjO8kj/w7y6vd2LFQVwOMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104131; c=relaxed/simple;
	bh=5kgf2XzuReDplrC7xkJGoGTdOoU+VH1yqVnPuD0KzKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9etqpRl1B4qz+6+fIgTg1uJLXW2NPktCkimQU97L0lPU/77U7HMHdZo8DJ+L+nXbf5okDOOZ69VpS2VcMwO73AeEHfJHO6tDe2+K6Cj51sOHsY/Q8JKxFzG6de6ccAON5odWOVasZ6fNUWswd6YWDi0Qs5e5niU3skm+AebUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjsqJ05d; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30762598511so62099911fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741104128; x=1741708928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=73DiKG1T2MFOOfr7RhvJymsHR6dLp2tVdL/Jp+/fuis=;
        b=FjsqJ05dkIZFlck518obwsxmGquT+ETYP22W1yEGrLK9CYo0SxxX7iM87SNvM+1tZ2
         paYMjQiot866fk45jCuI0Yk8TvpNF3yddt6vj11IfPrTMmS0FSszdvmFes9WBLQjU1mK
         IF801TwlcQeIAmhOw2FsUDJEaLA1CeBVup4jEFWc9075AskLi39sJpyj9unMKbmokKue
         2AjrDENJs4GHwOgrR1OxEQMZhtTLTOWL2X1+d7bXdvJ5zm4uRGDmlDRCScwVQV0qk3P4
         mKktGOvZlSXE3p6tjXruHm0Dli7/TpXyq7oNyI6yjqPhR5igNr0FpYp/lLXuZ0a6RCYR
         6p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741104128; x=1741708928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73DiKG1T2MFOOfr7RhvJymsHR6dLp2tVdL/Jp+/fuis=;
        b=cf3S5wbqCMATAwLVa+chNN5E+NSPiBtOjsp6CS4FZpP4Ke43R1J85z7yv+M+tWy/MQ
         5YVw6oVCF0QzRhbnxNGy5uvV3nuTsvyau9EuEozaodcp8k39fbFk6TmRQsGRSnMu7G0R
         De9musws9pmLtkaO3RHH2xVMXF1Mr2c5xD9jnzOJdKc3RrwFp8y23D5jmgkuJ1NtSYIu
         Hap3Y36VnXcSNaMwLqtt1enxiiz9bdn9PaB8HKMfx1A3QAo3N05IiisF5Ey0xJ71daHH
         6UQHBoYrWMpPQy1Nsu+omDyoPi2xV1VI+tEYS7WHo6MEu+XxKl8xq6zKh/a3E1gZ6LR0
         yj1A==
X-Forwarded-Encrypted: i=1; AJvYcCUt9d3QvxMButf6Yf8RIznd9q7I3pvoihMkhbbuHErSqcbX6I69MbPdLpMJ+V6cHmikBOtL0lN2hGElz6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYudllyEucQzTt1gRxzIz0jgztaN9i1RlHHeE8JWdD4BG4fJgY
	LJk/VxAlcBLOLyGfYSQ2m9+q49nAXgr/oxkQprGqmWZZ7slkee79hTomfS3yr8ByvJDSf4wIp/5
	X2toqKVq/4pYi+4CzMmKFcbzhBEY=
X-Gm-Gg: ASbGncvfzOCvmbqHarLD4kvMvHxQFYeRJAu4qA4T2ULT5CioXZ+SQPDrAqE404GTbA7
	5x0DK3sZGJzvMmastMjn7Bp1fXcv2BzF4+RLwUDMjt590NFL2Ji3IBbhMDxdTbCbvCePqHDX+Su
	Jg5KsxN59XveI1Pfxd2rnXp6Qrvg==
X-Google-Smtp-Source: AGHT+IGe8d62DKKUBUeUN0uMi55QovhHDeGvSHjR6vmKcYqCFkmmvUCGzioh4XQgAecRfxQIZGvZ/AgHEslFDonMXTw=
X-Received: by 2002:a2e:8215:0:b0:30b:8f84:49c5 with SMTP id
 38308e7fff4ca-30b932f3972mr59397751fa.28.1741104127522; Tue, 04 Mar 2025
 08:02:07 -0800 (PST)
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
 <Z8bOIXeWYycUEmp4@gmail.com> <CAMzpN2jUKp93z=jeXqa0uA-kQtaZ931aehZLm_axZoqGCeQZJQ@mail.gmail.com>
In-Reply-To: <CAMzpN2jUKp93z=jeXqa0uA-kQtaZ931aehZLm_axZoqGCeQZJQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 4 Mar 2025 17:01:54 +0100
X-Gm-Features: AQ5f1JqWfTUQOWtnJFruKvAheFGZmayyvbsKtuxYZe2h4qW1iAlTX71Cicyg_6g
Message-ID: <CAFULd4aR3+J3z18OCKbFcghOrJ7xLdYM1kPbD4HnUka4+AiLcw@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
To: Brian Gerst <brgerst@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: multipart/mixed; boundary="00000000000009d57b062f86655d"

--00000000000009d57b062f86655d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:00=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> On Tue, Mar 4, 2025 at 4:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > On Tue, Mar 4, 2025 at 10:48=E2=80=AFAM Ingo Molnar <mingo@kernel.org=
> wrote:
> > > >
> > > >
> > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > >
> > > > > On Tue, Mar 4, 2025 at 3:47=E2=80=AFAM Ingo Molnar <mingo@kernel.=
org> wrote:
> > > > > >
> > > > > >
> > > > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > > > >
> > > > > > > >
> > > > > > > > -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> > > > > > > > +       PERCPU_SECTION(L1_CACHE_BYTES)
> > > > > > > >         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D=
 64, "percpu cache hot section too large")
> > > > > > > >
> > > > > > > >         RUNTIME_CONST_VARIABLES
> > > > > > > >
> > > > > > >
> > > > > > > That is probably the right call.  The initial percpu section =
is just
> > > > > > > used by the boot cpu early and as a template for the dynamica=
lly
> > > > > > > allocated percpu memory, which should account for the proper
> > > > > > > alignment for NUMA.
> > > > > >
> > > > > > Okay.
> > > > > >
> > > > > > Randconfig testing found another corner case with the attached =
config:
> > > > > >
> > > > > >     KSYMS   .tmp_vmlinux0.kallsyms.S
> > > > > >     AS      .tmp_vmlinux0.kallsyms.o
> > > > > >     LD      .tmp_vmlinux1
> > > > > >   ld: percpu cache hot section too large
> > > > > >   make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> > > > > >
> > > > > > (I haven't figured out the root cause yet.)
> > > > >
> > > > > CONFIG_MPENTIUM4 sets X86_L1_CACHE_SHIFT to 7 (128 bytes).
> > > >
> > > > Hm, to resolve this I'd go for the easy out of explicitly using '64=
' as
> > > > the size limit - like we did it in the C space.
> > >
> > > Why not simply:
> > >
> > > ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D L1_CACHE_BYTES, "=
...")
> > >
> > > ?
> >
> > I don't think it's a great idea to randomly allow a larger section
> > depending on the .config ... The *actual* intended limit is 64, not 128
> > and not 4096, so I'd suggest we write it out as before.
>
> Change the assert to:
>        ASSERT(__per_cpu_hot_pad - __per_cpu_hot_start <=3D 64, "percpu
> cache hot section too large")
>
> We only care about the used portion, not the padded end.

If this is the case, perhaps it is better to use __per_cpu_hot_end
to mark the end of the real data, as in the attached patch.

Uros.

--00000000000009d57b062f86655d
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m7uoffom0>
X-Attachment-Id: f_m7uoffom0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaCBiL2luY2x1ZGUv
YXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaAppbmRleCA0ZWQwZTZhMDEzZDAuLjU4YTYzNWE2ZDVi
ZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy92bWxpbnV4Lmxkcy5oCisrKyBiL2lu
Y2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaApAQCAtMTA3MSw5ICsxMDcxLDggQEAgZGVm
aW5lZChDT05GSUdfQVVUT0ZET19DTEFORykgfHwgZGVmaW5lZChDT05GSUdfUFJPUEVMTEVSX0NM
QU5HKQogCS4gPSBBTElHTihjYWNoZWxpbmUpOwkJCQkJCVwKIAlfX3Blcl9jcHVfaG90X3N0YXJ0
ID0gLjsJCQkJCVwKIAkqKFNPUlRfQllfQUxJR05NRU5UKC5kYXRhLi5wZXJjcHUuLmhvdC4qKSkJ
CQlcCi0JX19wZXJfY3B1X2hvdF9wYWQgPSAuOwkJCQkJCVwKLQkuID0gQUxJR04oY2FjaGVsaW5l
KTsJCQkJCQlcCiAJX19wZXJfY3B1X2hvdF9lbmQgPSAuOwkJCQkJCVwKKwkuID0gQUxJR04oY2Fj
aGVsaW5lKTsJCQkJCQlcCiAJKiguZGF0YS4ucGVyY3B1Li5yZWFkX21vc3RseSkJCQkJCVwKIAku
ID0gQUxJR04oY2FjaGVsaW5lKTsJCQkJCQlcCiAJKiguZGF0YS4ucGVyY3B1KQkJCQkJCVwK
--00000000000009d57b062f86655d--

