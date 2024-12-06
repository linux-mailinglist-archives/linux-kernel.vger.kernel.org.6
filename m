Return-Path: <linux-kernel+bounces-434770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CC9E6B23
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A9416AD00
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5AB1F12F9;
	Fri,  6 Dec 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPcGeXSx"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADA1F03FF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478877; cv=none; b=g6/s/WHMIH0gkh35AYEyLQPAVLBwkJl3PWL6ts8fVwrhZaV+R8B3PKGA6JL4+zSRbNyGXLzkiO9Tl1oYNoKEqf7k4GpN1zKHS+FoXiF2rJAVdPbR461pHk/iwFfLMvpg13f4/pUCxkHctlxLOrT7fiQxaJe6CHoIPZD2s8KmC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478877; c=relaxed/simple;
	bh=GsOvowfLLjNNwGhyFlvSXDZYnGxjPiihM7jqeMZ3c/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mx1VL7Yy6MOMxsGgWegE019qkfd2DXXVDpVdX6yrwoikc54QTF3ENjm4TyI18lt9IyGPQwC1Qa9mafp/+XSGrgu6+Q1f/V11ZtDwGViuov2q6YaS1LKZdkxcEeWq0Y1uZG5iSqsoNPuLfRlNrwml2QEBBJagtMR1K01R4LawkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VPcGeXSx; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e39f43344c5so2102550276.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478875; x=1734083675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GsOvowfLLjNNwGhyFlvSXDZYnGxjPiihM7jqeMZ3c/o=;
        b=VPcGeXSx/TScsTOQtUHsxSKUp7XtN3IXpT4Yoj7kltPJ/byTUcl8q6BeypxmFzc9dr
         WxlzzvseH4X1/5X1u2sxHh1+Q2XCOuwbd0AltW8/reb/I6OLFvagX6rfxN0RmOKFE5IX
         PvNDUk809MsUgn85s6/Yy4vDge8QeHCCMrb1ND4SnOY3vkQndWQXIs9i5ewMW6MK3DuW
         mfW/DsS1VWA9xWlZWK16lB9d4KZKrbA6QQUAdag+9rvrlmh0iWMaB2tF6WU/9I0+Gmid
         Lkc40dXH/5x2EBlGZRumhXeFB9IDqbSHlV50x7WVsoLby7Vi2NWlufsIGBbePRbfZkYj
         19KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478875; x=1734083675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsOvowfLLjNNwGhyFlvSXDZYnGxjPiihM7jqeMZ3c/o=;
        b=gC/o63t7As/s/VzmMugal3MOSSJkSxPnkV7eweSB37/Mpc21o3FGl7NXBpVYbwLQfN
         h8bVjNn4U27NNYHIi0Jg7xcW08GD6cL4IMFYTaAmiAmAnxW9QWhBBZykwgm9ii68bgDX
         MYb8HlIJXspAw38VVHHkWf55kZq4PyslszKtCatvPe5zN6RxHH6rOSGezw/QykRR4mY+
         n/0etiG0MY/Lejvqx9YJyGU28kUj7CayVJVRcLpAI6zskdTkDn7v8etNkrha/7hCqzIF
         /wPXa6vZJA5tI/TiOXnTtH9KU5A4EWx6UDd7deQLewQLBE6r9W2660pDFCHlg7G2WfbX
         /Rlg==
X-Forwarded-Encrypted: i=1; AJvYcCUUKywmqfU2kUw+GNrBSlLCym8LZNg3J2b9icRwPse7t38Dv8mDQxcRDgijjQSNV2ZlaOdN0bbtEocJsjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkiqpDG6wnzF9SQkX3T+4ZT+DIhkOY+cn3gm9YP6WpAZ2iu/M
	NPLx4nQwc+0B7vp8fc1JXU8x+18nBXyt7yTq0t/6rQvTuETwGKCTq/h7CIzVUStdaRtG7tzbQ67
	ZNAESkic0mGFuROK/zXQLJl6rOfTTp+dTx/dNzw==
X-Gm-Gg: ASbGncs38tq49ms71EmGTfa3ukqps4Fm2TCrTHvKThG320K486InQTGkLN0IRn7Xcii
	PkkFq+9d5+WNYU01Ysm77Ka9O5Qvx7A6n
X-Google-Smtp-Source: AGHT+IG2PPzmCv1pgcSI90k5Rm9y9v17QaBnFLGhMJzvsqYhGx2gb2GCPvaJ4EvSx5NnUUYyYVZdxWz2xiUdxk4w8+w=
X-Received: by 2002:a05:6902:248a:b0:e39:8174:7f2c with SMTP id
 3f1490d57ef6-e3a0b4d09d5mr1967202276.46.1733478874767; Fri, 06 Dec 2024
 01:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <CAPDyKFpGrw+vOs=-TxfChBeORjzkpaL_iVB08MtmaC4sFNKzcg@mail.gmail.com> <72add0ff-db2a-44f8-b4af-0b5fe5f65f20@oss.qualcomm.com>
In-Reply-To: <72add0ff-db2a-44f8-b4af-0b5fe5f65f20@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Dec 2024 10:53:59 +0100
Message-ID: <CAPDyKFq5+HWmHK4E4ERx1rb8O4mubHGqRHP8AAiq2KyZyX1GSQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow specifying an S2RAM sleep on pre-SYSTEM_SUSPEND
 PSCI impls
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Maulik Shah <quic_mkshah@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+ Maulik, Vincent

On Thu, 5 Dec 2024 at 21:34, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 14.11.2024 4:30 PM, Ulf Hansson wrote:
> > On Mon, 28 Oct 2024 at 15:24, Konrad Dybcio <konradybcio@kernel.org> wrote:
> >>
> >> Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
> >> CPU_SUSPEND instead. Inform Linux about that.
> >> Please see the commit messages for a more detailed explanation.
> >>
> >> This is effectively a more educated follow-up to [1].
> >>
> >> The ultimate goal is to stop making Linux think that certain states
> >> only concern cores/clusters, and consequently setting
> >> pm_set_suspend/resume_via_firmware(), so that client drivers (such as
> >> NVMe, see related discussion over at [2]) can make informed decisions
> >> about assuming the power state of the device they govern.
> >
> > In my opinion, this is not really the correct way to do it. Using
> > pm_set_suspend/resume_via_firmware() works fine for x86/ACPI, but not
> > for PSCI like this. Let me elaborate. If the NVMe storage device is
> > sharing the same power-rail as the CPU cluster, then yes we should use
> > PSCI to control it. But is that really the case? If so, there are in
> > principle two ways forward to deal with this correctly.
> >
> > 1) If PSCI OSI mode is being used, the corresponding NVMe storage
> > device should be hooked up to the CPU PM cluster domain via genpd and
> > controlled as any other devices sharing the cluster-rail. In this way,
> > genpd together with the cpuidle-psci-domain can decide whether it's
> > okay to turn off the cluster. I believe this is the preferred way, but
> > 2) would work fine too.
> >
> > 2) If PSCI PC mode is being used, a separate channel/interface to the
> > FW (like SCMI or rpmh in the QC case), should inform the FW whether
> > NVMe needs the power to it. This information should then be taken into
> > account by the PSCI FW when it decides what low-power-state to enter,
> > which ultimately means whether the cluster-rail can be turned off or
> > not.
>
> This assumes PSCI only governs the CPU power rail. But what I'd
> guesstimate is that in most implementations if system-level suspend is
> there at all (no matter through which call), as per the spec, it at
> least also projects onto the DDR power state (like in this i.mx
> impl here [1]), or some uncore peripherals (like in Tegra's case with
> some secure element being toggled at [2])

Right, I certainly understand the above. There are different parts of
an SoC that may be sharing the same power-island as the CPUs.

The question here is whether the NVMe storage device is part of that
power-island too on some QC SoCs?

>
> > Assuming PSCI OSI mode is used here. Then if 1) doesn't work for you,
> > please elaborate on why, so we can help to make it work, as it should.
>
> On Qualcomm platforms, RPMh is the central authority when it comes
> to power governance, but by design, the CPUs must be off (and with a
> specific magic cookie) for the RPMh hardware to consider powering off
> very power hungry parts of the system, such as general i/o rails.

Right, that is why the "qcom,rpmh-rsc" device in many cases belongs to
the cluster-power-domain (for PSCI). This allows "qcom,rpmh-rsc" to
control the "last-man" activities and prevent deeper PSCI states
if/when necessary.

>
> So again, PSCI must be fed a specific value for the rest of the hw
> to react. The "S2RAM state" isn't really a cpuidle state, because
> it doesn't differ from many shallower states as far as the cpu/cluster
> are concerned. If that all isn't in place, the platform never actually
> enters any "real" sleep state, other than "CPU and some controllable
> IP blocks are runtime-suspended".

We recently discussed this, offlist, with Maulik - and I think we need
some more clarity around what is actually going on here.

In principle, it looks to me that using S2I with just another deeper
idlestate specified (with another psci-suspend-parameter, representing
a deeper state) should work fine, at least theoretically. Of course,
we may not be able to use that idlestate during regular
cpuidle/runtime but only during S2I, which we need to control in a
smooth way and that is not currently supported (but can be fixed
easily, I think).

In the end, it's the psci-suspend-parameter that is given to the PSCI
FW that informs about what state we can enter.

That said, using S2I may not work without updating the PSCI FW, of
course. For example, there may be FW limitations that require the
boot-CPU( CPU0) to be the last one for these deeper low-power-states.
Whether that is just a FW limitation or whether there are some
additional HW constraints that enforce this, needs to be clarified.

>
> This effectively is very close to what ACPI+x86 do - there's a
> co-processor/firmware that does a lot of things behind your back and
> all you can do is *ask* it to change some handwavily-defined P/Cstate
> that affects a huge chunk of silicon.

Yep, there are similarities.

However, ACPI is for generic device power management. PSCI requires
something additional, such as ARM SCMI or QC's rpm/rsc interface.

>
> Konrad
>
> [1] https://github.com/nxp-imx/imx-atf/blob/lf_v2.6/plat/imx/imx8m/imx8mp/imx8mp_lpa_psci.c#L474
> [2] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/nvidia/tegra/soc/t210/plat_psci_handlers.c#L214
>

Kind regards
Uffe

