Return-Path: <linux-kernel+bounces-227642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A89154E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E831AB239DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265919E802;
	Mon, 24 Jun 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIeb3cS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482BB19DFB5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248295; cv=none; b=RXTXJhbVvlBjpYxN9ImKLDpIzFiq3kIBPbQI8iIee/HRqZSfyGD5R5Su+kmCwmkztgsouTQa8psziLRJqkHTFpcL6u/vJCUJVkScFvByQdw9sg+/O8I/JPQYSeQABmnaFO+6b6/bAP3EncvQk992viXIYRgh3lfDFAUcfaWfoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248295; c=relaxed/simple;
	bh=Eo2OdHJwmKn4XxlV9q5h82bJ2Wh5ZfYJQiLjLWtK/A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMiAj08BWekpus+zWmckGGC5KE6CUgmahbIQGyps96scQZyBdP9mTJrdKvTVdIyYz76RJkF6pNpCjt5vu78DUqXXw9B9XAnvJa4Z4ZK1rHna+npkqgUeHxzGiCbx56HmbFIpuvSJ/Wupwxy9Sl4G4kJpYGB2XVxo28DpPDB+hsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIeb3cS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B0BC2BBFC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719248294;
	bh=Eo2OdHJwmKn4XxlV9q5h82bJ2Wh5ZfYJQiLjLWtK/A0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TIeb3cS94jx3/B0aDqfVKYQrxoba+stMRwDG9TxGjiFdYjrFvBIvW1sIhzn6rHXst
	 e00wpE6K4x6Yx1KKoKzcjbgUzx7r1GCi3QreHGQeUojHHvnfe2eV0Cn3Rs031vlZRZ
	 f2BTywM6ZyZuc8huDzpnoxz4yDB3YCKcmE6WgP8vLKNqVHtHi3/ud987ysh8Vt/A7Y
	 V1Sc3Kq0GrMC9ugx342HpvOiLUdjVNUp0IYCsVkbbGgNaAXdhyN/kWPmUvocLHNAiA
	 x3LGEAsVQd1ZZZkc6qjQitCjqVDWyuVGN2plF2vqQTlZ7ObHb6o+WYG1BGMOSF4ex1
	 jCgbpj+HSloQg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cd80e55efso5292604e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:58:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1W3y0Btj4kwL9vcGkS8x6crNiQufAPOiAXktwTGgCl3fFxDzpm5i+MI4ztUyVvDMfRqGdpfabLICw3JyD+3V8NdVWEKluDWDdi619
X-Gm-Message-State: AOJu0YzHIoth4qAkIf8xwb5JzlF7tfQvy8zwdiVNhYHrPtZErjMKhrD0
	EsAgrEerxeVRFlz5NaMIZtTqZRA0mAvYDllYCD9kiKoYSrtpPoo0s+BLb9OMCNSbRmuJUITFkWY
	RG8oT1ZUPclt6QcCyT0G6McGmIQ==
X-Google-Smtp-Source: AGHT+IGJAMcptfT+477ET+nX/lX4BOXE4aKuye+Ytt55rmmQ9D5LB2VwxuJB0kIKyF/eA6/cPMHGFcKL6J35ySb3CKw=
X-Received: by 2002:a05:6512:745:b0:52c:8b69:e039 with SMTP id
 2adb3069b0e04-52ce182bd0amr3586435e87.4.1719248293214; Mon, 24 Jun 2024
 09:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611155012.2286044-1-robh@kernel.org> <8c55de88-96ad-45a7-9be5-4f33f4266af2@arm.com>
 <8804f769-faa2-4d88-8196-8f1ed62d076c@arm.com>
In-Reply-To: <8804f769-faa2-4d88-8196-8f1ed62d076c@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Jun 2024 10:58:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXL12cLtP=BBiMw3dn0ZqPWmc76ey8LziDdSDyhuGh-g@mail.gmail.com>
Message-ID: <CAL_JsqLXL12cLtP=BBiMw3dn0ZqPWmc76ey8LziDdSDyhuGh-g@mail.gmail.com>
Subject: Re: [PATCH] perf: arm_pmuv3: Avoid assigning fixed cycle counter with threshold
To: James Clark <james.clark@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:30=E2=80=AFAM James Clark <james.clark@arm.com> =
wrote:
>
>
>
> On 11/06/2024 17:13, James Clark wrote:
> >
> >
> > On 11/06/2024 16:50, Rob Herring (Arm) wrote:
> >> If the user has requested a counting threshold for the CPU cycles even=
t,
> >> then the fixed cycle counter can't be assigned as it lacks threshold
> >> support. Currently, the thresholds will work or not randomly depending
> >> on which counter the event is assigned.
> >>
> >> While using thresholds for CPU cycles doesn't make much sense, it can =
be
> >> useful for testing purposes.
> >>
> >> Fixes: 816c26754447 ("arm64: perf: Add support for event counting thre=
shold")
> >> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >> ---
> >>  drivers/perf/arm_pmuv3.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> >> index 23fa6c5da82c..2612be29ee23 100644
> >> --- a/drivers/perf/arm_pmuv3.c
> >> +++ b/drivers/perf/arm_pmuv3.c
> >> @@ -939,9 +939,10 @@ static int armv8pmu_get_event_idx(struct pmu_hw_e=
vents *cpuc,
> >>      struct arm_pmu *cpu_pmu =3D to_arm_pmu(event->pmu);
> >>      struct hw_perf_event *hwc =3D &event->hw;
> >>      unsigned long evtype =3D hwc->config_base & ARMV8_PMU_EVTYPE_EVEN=
T;
> >> +    bool has_threshold =3D !!(hwc->config_base & ARMV8_PMU_EVTYPE_TH)=
;
> >
> > I was going to say doesn't it need to be (ARMV8_PMU_EVTYPE_TH |
> > ARMV8_PMU_EVTYPE_TC) for it to give the same results as the hardware.
> > But then I saw we only enable it if TH !=3D 0, even if TC is set. And n=
ow
> > I'm wondering if I inadvertently disabled a useful combination of optio=
ns.
> >
> > The Arm ARM says it's only completely disabled when both TC and TH are =
0.
> >
>
> If it's easy it might be worth adding a helper function for
> has_threshold() that's used in both places. That way if or when this
> issue gets fixed up it doesn't break here.

The other place being in armv8pmu_set_event_filter()? A helper doesn't
help there because that looks at the attr value, not config_base.

Rob

