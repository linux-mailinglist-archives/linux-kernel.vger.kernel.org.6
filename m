Return-Path: <linux-kernel+bounces-441251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710289ECBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA42F162FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F61225A2A;
	Wed, 11 Dec 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcBIahKG"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1C1D8A0B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919232; cv=none; b=Ji0+LdwsUFfsA4drg1ouYUHckx13FrQeZDZ/6kAwYwoPeMrWN/VKgO9aREQel8Fi58AKs9Qc9Z4jtacVaZWzgf/K8192aaRbsGQkX6P5sqsTY8BWRr3NbYnhQ1BCDj2tULVKdfOnN2VkU5cIcbPY/GWxnMnhIZRIElCUmhzDvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919232; c=relaxed/simple;
	bh=MJr4gynFaxN1UupeCq5uQNeM5rVyPoWBQWTfG4Xdvf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDLU+hHYdmQgj0ldSlxH/F5ecwpeo3xR2vtaCFhIQ6TLbt7BtotPY8aBmwiOw+ACiQvCCK607FI/qbsX8zeB854Jmlgq3eZeDs6wH9hiIyAuW4G6FWdYK8WbrHhFFZSFn9+FdRz5Hca2Zq2ogv+IYSE8U7QiGXqNCrIV77vSaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcBIahKG; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea55a2a38bso3461775b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733919230; x=1734524030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UDZY2QeYHN/iyr/49RZQKSkzZE163jbKdkdUiW04MRw=;
        b=lcBIahKGPxMkzCdd01MgJjYuumDNpmLxuITTMLhpnFofKxCbTOMmrC/CDeJfOn6fO1
         PbIn0oLiBw18l/MvAiRbPRO1VObyTo+FkA/tZejLyqPc3ljwFLKd7gQ8UFgK5U1vaeGA
         2GAxIrvAKwOg7vlCdrx3ajyjAITfSycngBLpOTQ0hNGCZgKrpzLLXrfugZAUhHarXZrg
         5kymp2xIr0Wda0DCCBYbeT6z8aHgxHYEfvPxaLcAoY8iL/aTBboH75wo0KwusaxnzltN
         HKY44Rc/9R04PEZG+3He1/zG2Spg4US+gLZjOCh14h0p/YJZzDnbIbKJquFxSoRDSscq
         stiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733919230; x=1734524030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDZY2QeYHN/iyr/49RZQKSkzZE163jbKdkdUiW04MRw=;
        b=cI2Zc7U+dCqHYBi39ESzktsXSDDTPhHj/iXMsLn/w7zBcc17N8y4BkWGDbDlmXv6A2
         QlPeVyDRWTEoff1E2w/Tbmfvj1winvaZYfJS0NBKbGHuDbyz00OYjfZAaRkVadGswIRZ
         Lsyrb5TvR/Dk1Ikb/70mRiSkFKb4jWmZWzV+wxBZoIGEbBV8G1L9mnr2o33lwVnS0vLX
         t7oQAR0Xz6gicIUCvcLghZHI6S4A37zoehPEHc7AcvTWPc5M8iT3RRjfCGhdqANRPgjs
         CIfcllGM49DwQr22Un0ZsnwO99gH13qfmaVxwMLa9RaNJyHRdwWAtJWQUkuG6mmH7JeQ
         qz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4KyXyTRvK9Dtqy4ckTIR5+QEek3jiQHCKxjdJHQp2NCKsPYS5cA7KQMEkQDQPRNZWh6oGyZdnxeDbMXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1dS1HS07sttWBqcp+teP4w1i7PvGdpzb55V5aRRXZV7Xo3Dm
	yNexlyDLB9szo8vFWmirxqSCmOOllTNuTgdFamvrqJiHN7wUeffyP0ZiMjfjbfcg6bAc7+MJuqh
	lN6nrInVhVDpEVU9o2iiejXOVaIEcygAe90wTuA==
X-Gm-Gg: ASbGncug0Di3QcJWpQp7HfUzH85q4xslnZliv+ebnh/BbljRE/iBcIPvI/HRVjPh8Lo
	wqWm5uh8JM0W/NonBJ+wEenyrq87qxcBa56k=
X-Google-Smtp-Source: AGHT+IG4lAagFo6z1ppiAYrOC7C4TN5pY0zUDuuH3woRWIw4oGjlKvx5/ZHHH9rcjl/Kqtx3EgozCxAjSqTP69gAblc=
X-Received: by 2002:a05:6808:189c:b0:3e6:6097:847d with SMTP id
 5614622812f47-3eb85a8b199mr1689009b6e.7.1733919230314; Wed, 11 Dec 2024
 04:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205175345.201595-1-tudor.ambarus@linaro.org>
 <20241205175345.201595-3-tudor.ambarus@linaro.org> <ce757b8e-4e6c-4ba9-9483-b57e6e230fdf@linaro.org>
 <vxqi23hxw7bmtfs5wk3u7szganpv5aa74b26xrvpmbehkltodw@dpum7zrxdz44> <2eedbbe1-6b4c-427b-a369-5b08dc27deaf@linaro.org>
In-Reply-To: <2eedbbe1-6b4c-427b-a369-5b08dc27deaf@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 11 Dec 2024 12:13:39 +0000
Message-ID: <CADrjBPo_YmTuuW9c3LtWzMp7Sf4365e2bxuuYBUiFPPc42d1dA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] firmware: add exynos ACPM protocol driver
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	javierm@redhat.com, tzimmermann@suse.de, vincent.guittot@linaro.org, 
	ulf.hansson@linaro.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

Thanks for your review feedback.

On Fri, 6 Dec 2024 at 19:50, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 12/6/24 14:28, Krzysztof Kozlowski wrote:
> > On Fri, Dec 06, 2024 at 12:39:56AM +0100, Daniel Lezcano wrote:
> >>> +# SPDX-License-Identifier: GPL-2.0-only
> >>> +
> >>> +config EXYNOS_ACPM_PROTOCOL
> >>> +   tristate "Exynos Alive Clock and Power Manager (ACPM) Message Protocol"
> >>
> >> Given the importance of this driver where a lot of PM services rely on, does
> >> it really make sense to allow it as a module ?

Yes, we want the option to build it as a module so we can use the
upstreamed driver with Generic Kernel Image (GKI) [1].

> >>
> >> Some PM services may be needed very early in the boot process
> >>
> >
> > If it works as module e.g. on Android, it is beneficial. I think the
> > platform was booting fine without it, at least to some shell, so I can
> > imagine this can be loaded a bit later.
>
> Usually the firmware sets the frequency to the maximum in order to boot
> the kernel as fast as possible. That may lead to thermal issues at boot
> time where the thermal framework won't be able to kick in as some
> components will depends on ACPM while the system stays at its highest
> performance state.

That isn't an issue here as the Pixel 6 bootloader leaves CPUs at mid
point frequencies during boot. I would actually expect most modern
phone bootloaders (since the launch of GKI at least) to do something
similar as it is a requirement for Generic Kernel Image (GKI) [1] that
all the SoC drivers are built as modules.

[1] https://source.android.com/docs/core/architecture/kernel/generic-kernel-image

Thanks,

Peter

