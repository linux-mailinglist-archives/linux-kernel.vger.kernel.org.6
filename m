Return-Path: <linux-kernel+bounces-239168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F8925774
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BEE1F26C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002FD1411C7;
	Wed,  3 Jul 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuFTRo6x"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82F140E38
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000503; cv=none; b=QOIVH8jt1Ho4tnccFfeGhPUaI12nI5vzkGTgOE6eYoB1DiY9Nt2CTmHG0eZhL1nYU/5Mj/+PCeJ8JlrkqEtxMrYacQIudNWgYcd3K7gc0aJstQpHXfHQv6XSTzpfcKf25Qt1ff4PWipbT8LscFsa5MBOqBsHLB1m1GsIEUwGgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000503; c=relaxed/simple;
	bh=k/+CTBpj1EiCKMxmYiMFK6O7Hti0OmObuybzNT9VcZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ0Y5Zv/f2AnmPw4D7GeprzxT9uHVeTiPLK6PXjD+dLm5tzpwrUPeGbEwgWxb1qNKVFx+95XwozVDXJvvhErRUAbNEGr4/T1XLZdM6cn/N6IqWgmTbwxTGIHHHU0FZmom3x6vCheZ+onDVyZ9n6sc29stoWdz17KFAM2idCIxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nuFTRo6x; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64b29539d87so45998887b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720000500; x=1720605300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KRpouyYlT8w2vDlaWB3dgP182H0ox0N2Q0MheHmPiuY=;
        b=nuFTRo6x4AaHQ5W+QWLWOgUgkOpgi5FCU7SwWX986/hr7jLsO1MZQaLDYAVxykukjg
         ZX2kt2pUJZ8/xEhwFW3kEjQzKIo7WmB0PzV6/nmhGfF0w1fB/jQafFDDYzlF1pi7qYrt
         QePEPBM+Qb+AzeM1KCEKRPFOcJuYpMhOmbcNxkQ7MoJvOS4O+1zATM739AcHmdq/Jarj
         fAwEgXz2hyvdJnTIL4nnlfdAaFLxV1rJ88UYHDOXphUmapTF0LZhP1+PHnn5zAvflYqt
         QU1PPLqniroTY+POaMukarYhczrPees08Lk6H/Y5o6hMRMvqqBCa8VFT3SPhYFHtX5Qj
         xTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720000500; x=1720605300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRpouyYlT8w2vDlaWB3dgP182H0ox0N2Q0MheHmPiuY=;
        b=MOfkBxrNPak0Ti2mpiWlT9dZz34CZDIgvahuc0/kfsva7a1HEfhCqcf4ulBWjY4MfK
         OtSbK6hkNArfwa5O5Qi1gX+PV4R6SlsRay3thBMgHTHiyTsJUYvTwQIYGL5LhA7UThyj
         dmMFHqXWVSN3+YiOjSKWUm7o894wQNo3vjSZTV31MBFOshXhEr8V4Kp4umTszzQ685ja
         juybjpXCtYWy+g0PK1Fju65i+0fPTPgiDFNi2Wj7ZP67cJ6/lKOcUg4JMWVl6TcyVz/x
         AXDWqw67AuVa1SFZoa4NaA9zvQsgUmxW4LSH6vHtkXCNNY2wQRGDlwUxNfPfMoTBZZsR
         L2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJaOmrDNkOHUVbDNAwOBrfAMRDCqDb6hEKNreB4IU5VmCzXYc1LM5kCY7CLyZGw8leTgRlV5WgouR74EROGFJynVtAYJhziGiFI8kf
X-Gm-Message-State: AOJu0YwbTKZkR6Kq2kwAWBh7ToUcq8tH7HqAbAgNoUisMLwKaX6YViry
	oSw9uUkpfp06ovcuGSHi/ZWIuNI0Hf3pZweeEn9ohRPk07TzLIddFhhYxqyVqEu5JE3G+YW9EPL
	FjuimdJhiC4zayYrBH2f74srDrTLQwPACkn2C2g==
X-Google-Smtp-Source: AGHT+IHoNzBewnWkhcdAH2IejqHRntRYwy/kVJsz9+740G9qHkKMZZR3MQADqefkEA2eUyN1XlgmAmLhG8Zvd2gJPFA=
X-Received: by 2002:a05:690c:804:b0:64a:7d9b:934 with SMTP id
 00721157ae682-64c7277c728mr123416777b3.16.1720000500575; Wed, 03 Jul 2024
 02:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
 <20240417133731.2055383-6-quic_c_gdjako@quicinc.com> <CAA8EJppcXVu72OSo+OiYEiC1HQjP3qCwKMumOsUhcn6Czj0URg@mail.gmail.com>
 <CAA8EJpr3GYimirDz39f4n-3hDAxFWzo+9fdY6MAuxaNguouVFg@mail.gmail.com>
 <3e816509-a12b-4658-85f4-c0d0037c6a64@kernel.org> <CAA8EJpr1G4eq5xJn0z2JQmpXY89UK13uk2BWJCgROsFP_-NkQw@mail.gmail.com>
 <20240702163908.GA4635@willie-the-truck>
In-Reply-To: <20240702163908.GA4635@willie-the-truck>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Jul 2024 12:54:48 +0300
Message-ID: <CAA8EJprGja_L6QXVmfSqoeMKCmSrf-qBeAWNToZDe++AsZ+Nyg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
To: Will Deacon <will@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Georgi Djakov <quic_c_gdjako@quicinc.com>, robin.murphy@arm.com, 
	joro@8bytes.org, iommu@lists.linux.dev, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	robdclark@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, 
	quic_sudaraja@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 19:39, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 25, 2024 at 03:59:27PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 25 Jun 2024 at 15:57, Georgi Djakov <djakov@kernel.org> wrote:
> > >
> > > On 25.06.24 10:50, Dmitry Baryshkov wrote:
> > > > On Fri, 14 Jun 2024 at 21:05, Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > >>
> > > >> On Wed, 17 Apr 2024 at 16:39, Georgi Djakov <quic_c_gdjako@quicinc.com> wrote:
> > > >>>
> > > >>> Add the device-tree nodes for the TBUs (translation buffer units) that
> > > >>> are present on the sdm845 platforms. The TBUs can be used debug the
> > > >>> kernel and provide additional information when a context faults occur.
> > > >>>
> > > >>> Describe the all registers, clocks, interconnects and power-domain
> > > >>> resources that are needed for each of the TBUs.
> > > >>>
> > > >>> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> > > >>
> > > >> This patch now prevents interconnect drivers from hitting the sync
> > > >> state on SDM845.
> > > >> The TBU driver is enabled only when the ARM_SMMU_QCOM_DEBUG is
> > > >> enabled, which is not a typical case on a normal system:
> > > >
> > > > Georgi, before I start acting like a bull in a china shop and sending
> > > > reverts, any update from your side?
> > >
> > > Hi Dmitry!
> > > Thanks for the report! We can easily add status = "disabled" to the DT
> > > nodes, but please give me some time to take a look what would be the best
> > > way to handle this, as i was out last week and now i am still catching up.
> >
> > I think the simplest thing would be to move the TBU driver to the
> > arm-qcom-smmu.c instead of having it in the -debug.c
>
> The TBUs aren't used for anything other than debugging, so I'd really
> rather they live with the debug code.

The problem is that not having any driver bound to the TBU devices
prevents interconnect drivers from hitting the sync state (and thus
lowering the bandwidth to the requested values).
Being that late in the development cycle, I think we should fix the
issue in the fastest way. So I'm close to sending a revert of the DT
changes. Setting status = "disabled" doesn't qualify as a logical
change as having TBU units enabled on a platform-to-platform basis
doesn't make sense.

-- 
With best wishes
Dmitry

