Return-Path: <linux-kernel+bounces-545026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A8A4E82D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14F01883FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2DC27811C;
	Tue,  4 Mar 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOnExzph"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BE278110
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106933; cv=none; b=g8V/D/nX4glXUMNKcKaOaiJBI32HoL6RZ+pBq4WQNziiwlauNGSF1/uzrIbIJo1OBEvG+TP/ZQGTk1DbhArmzcAHBmBH5B37vO60l0Za4FtazDUySH7UsxPJvRHb/l4mhIKSGi+naTadKbUecBvehzz7eeNhH50BC6R0rHjYkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106933; c=relaxed/simple;
	bh=/z0XwPGGhoHlFeHUs2A7nBYOZsSvcI1+TvpOTqcGq+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6UBdsUK2QeqThPC33ma8qU/uhCa5mC6hGPSTVm/3K4wAgHE/RzUVYmSnGAzGAJg9dq1A+mfyOXBlHAHIc1YwbNqoAHGVE8qt6s959BgYBh4EUXoCNIlYupiL63MCXQm8tYlaXiy44BT8QetM9sCEwOiF6ospg1eMAgBpaA+e58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOnExzph; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a04so59627241fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106930; x=1741711730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2p1zWXWJUnwqxrejHWDKdVWhbal1K6h7wHaPnZrswE=;
        b=VOnExzphBLw+v4SCXl6qQrywzYxY7w3RnY/Y8ipsDJVpFOLkDI72MbjiSt+7M+fcQ2
         XdPPSMbp2wcfQBj50XPqhDkJwBb8mQ8jwEd7UOtpjoRvRkuvP/AGJeYAyR9ky/RiWdtD
         SrnB2ViITZiUWy21/IapGQ5Ar8P5zVdHMkfuKIJorow3UBkkgUKkMyDtlkX8ZFeHxjuo
         aBOBegkg//g0wiOTTt7pUu4MJHIMeeq3ZNQ2FT5w2l1C9/1LZ7/WkvhXl0pZF/LnZlp/
         E+c6DHOKgq8GcGFIzuv6qAsnqyuUqd3WSukfGQR2H0vZLjLz3bmgmfpF077VdzN3jXJm
         KkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106930; x=1741711730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2p1zWXWJUnwqxrejHWDKdVWhbal1K6h7wHaPnZrswE=;
        b=cDZyeeJh5BTUD4g7OFtWMqaovhK0zP2u4GTkwfHMO2RGwoTH+8nlzZwe4l/Xb0xvcR
         m2aaSKBZJuriniNb1eAlfQF0kbt59e8PWb3ReckaxXzqVWiDspvK6q/fwEprWAgTrSwD
         EtIYhPgqiOht9nIstgDG0eqgAUySUS4s1jvzHxeB7gHg2U9qYOjRNKd7WsppVct58/0Z
         ral72x9ql1MAq+WI/M30Kk8INeCyK2/iVV/L7WRlaBJFViJPd0shd0wEVZagI5gYnCQi
         Wpi+rB95Wohn9wwGhFN318KKaqGDFEy03TRONsTxjcIcvtnjkrFtLjLqPUKThqd9QepR
         Ezmg==
X-Forwarded-Encrypted: i=1; AJvYcCWEyuPNNy/kBkcCNarAqgNpjrT3E3MzhIAMHE0MnMGVtY1MIqCSr1Y6cTP8to/C7RDEVsr8opfRQGRcJEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJb5AOB+mgJkXxmCopqqGEW54iXhEf6eCl1qPKJZR0hEixTtYA
	NJj7jT7OA4S6+MJNl50txbSvimj2qKYXwJsJEqZPOxzLGYgIkQ2DheLSds/mQZRK73363CKhMqX
	PdR6kU4zPg4Br63hmSur3q0UUByc=
X-Gm-Gg: ASbGnctxMzSEzIUEm7M/caKx03N3N8kC29XdIXoPxYbvEfeW4UVulFt5qxUNgVCSjUM
	N/ofHBp2H7S+70a1cb/et6q8wdpOVHl5zuDlktO6iCqpWvQADA9AJ5GPfWFbj1R7KjXQdxfVRrw
	X4iGokvHtFplEw1NlX/0GDLbLFcg==
X-Google-Smtp-Source: AGHT+IG+nyTkzziefkFGgQAs+gxUFqxfRYcnS1VunyY9grWbI/b09zPWZTWHdLe4XR/cwpnHW/KUiDkeZtdK60eAJdk=
X-Received: by 2002:a2e:9a8f:0:b0:30b:9813:afff with SMTP id
 38308e7fff4ca-30b9813b525mr50699561fa.31.1741106929338; Tue, 04 Mar 2025
 08:48:49 -0800 (PST)
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
 <CAFULd4aR3+J3z18OCKbFcghOrJ7xLdYM1kPbD4HnUka4+AiLcw@mail.gmail.com> <CAMzpN2gLR51ko+hWAS7XRDM4VLL+YJYcP91AsH+phG1K7UoVDQ@mail.gmail.com>
In-Reply-To: <CAMzpN2gLR51ko+hWAS7XRDM4VLL+YJYcP91AsH+phG1K7UoVDQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 4 Mar 2025 17:48:37 +0100
X-Gm-Features: AQ5f1Jqb3Rp_Qm1vV9QpzNLG9o-5fA_UIgOcFDmt8WFw_xNmuevaonc13Rl9uFs
Message-ID: <CAFULd4ZN1FXh3JMznJ=SiBxuYj74iaDSg-j6wZjbYxuTaS7wTA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
To: Brian Gerst <brgerst@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:42=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> On Tue, Mar 4, 2025 at 11:02=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > On Tue, Mar 4, 2025 at 4:00=E2=80=AFPM Brian Gerst <brgerst@gmail.com> =
wrote:
> > >
> > > On Tue, Mar 4, 2025 at 4:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org>=
 wrote:
> > > >
> > > >
> > > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > > On Tue, Mar 4, 2025 at 10:48=E2=80=AFAM Ingo Molnar <mingo@kernel=
.org> wrote:
> > > > > >
> > > > > >
> > > > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > > > >
> > > > > > > On Tue, Mar 4, 2025 at 3:47=E2=80=AFAM Ingo Molnar <mingo@ker=
nel.org> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> > > > > > > > > > +       PERCPU_SECTION(L1_CACHE_BYTES)
> > > > > > > > > >         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start =
<=3D 64, "percpu cache hot section too large")
> > > > > > > > > >
> > > > > > > > > >         RUNTIME_CONST_VARIABLES
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > That is probably the right call.  The initial percpu sect=
ion is just
> > > > > > > > > used by the boot cpu early and as a template for the dyna=
mically
> > > > > > > > > allocated percpu memory, which should account for the pro=
per
> > > > > > > > > alignment for NUMA.
> > > > > > > >
> > > > > > > > Okay.
> > > > > > > >
> > > > > > > > Randconfig testing found another corner case with the attac=
hed config:
> > > > > > > >
> > > > > > > >     KSYMS   .tmp_vmlinux0.kallsyms.S
> > > > > > > >     AS      .tmp_vmlinux0.kallsyms.o
> > > > > > > >     LD      .tmp_vmlinux1
> > > > > > > >   ld: percpu cache hot section too large
> > > > > > > >   make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error=
 1
> > > > > > > >
> > > > > > > > (I haven't figured out the root cause yet.)
> > > > > > >
> > > > > > > CONFIG_MPENTIUM4 sets X86_L1_CACHE_SHIFT to 7 (128 bytes).
> > > > > >
> > > > > > Hm, to resolve this I'd go for the easy out of explicitly using=
 '64' as
> > > > > > the size limit - like we did it in the C space.
> > > > >
> > > > > Why not simply:
> > > > >
> > > > > ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D L1_CACHE_BYTE=
S, "...")
> > > > >
> > > > > ?
> > > >
> > > > I don't think it's a great idea to randomly allow a larger section
> > > > depending on the .config ... The *actual* intended limit is 64, not=
 128
> > > > and not 4096, so I'd suggest we write it out as before.
> > >
> > > Change the assert to:
> > >        ASSERT(__per_cpu_hot_pad - __per_cpu_hot_start <=3D 64, "percp=
u
> > > cache hot section too large")
> > >
> > > We only care about the used portion, not the padded end.
> >
> > If this is the case, perhaps it is better to use __per_cpu_hot_end
> > to mark the end of the real data, as in the attached patch.
>
> That's a better approach.  There's not much value in the current _end
> symbol if it's not always _start+64.

Thanks, I'll submit a formal patch submission.

Uros.

