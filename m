Return-Path: <linux-kernel+bounces-429385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609D9E1B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2D11679D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B241E5027;
	Tue,  3 Dec 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0Bu4nmo"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767F1E501B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226717; cv=none; b=JhjZ53K/4DA02VULesRmtkkh2LN4Q7dR9hWfv13IA/Nh6s6O0LpK2Wk4AhpkaC43MknCzjgEEKfKl613OXhRCFWEtwAOe47HLcUMMgJeyYtjzXj0klaEam6Z6kEt77AFpciImkO/njXy8p5swO8IBf5ol7AbINwJGrO6+Byeaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226717; c=relaxed/simple;
	bh=xODsXxgFfNZd8MjPBZGqmi3sIBbEKRslq024Q4XA774=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ2HNfuXa7RWvgT/Jt7+mDdc43fAar2R6P5ts0pl8Q2peKnpCz5krouMZ655pVeW4MiCG7ULeInjeUt29M509H9NWUVGPRGxOjfuK4HS6usxkE99aOIY6PP6zSV7CCRpMBp4XdhMUsGB3HmCgDKxXgGD1c4JpzyzzPAKrwWcxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0Bu4nmo; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6efa08f91c8so19181007b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733226715; x=1733831515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJmN9vm0KKdkbgYJY1kJ2PT7vRHayhKSRB17RM5kC5E=;
        b=X0Bu4nmocEtYnkYNZV3jm3+ODoDpXf7OFUSD4BK/eNEAnGS92mxk0QKcWlfWaqd/t0
         bKan83juUuc5txilEUJnJKr266BkeuwZs11HmnfIIFId0bUZK942UkyzZjafisK9doDa
         5uB31FoFPQSAcVIMtrd3oHZZEFpZAdOUXNu46lVNiBlb2B8OF9ub7va69WFNwxtQmIaU
         vTMyZCyG3++mj5oF+xqTNthMlYM4Untn1TvWhS/s5z0QjaD1NKuD8Vwz6cCO6E/OTwRr
         pVI3kW668KSehmrYZZye/FIFtvSjCLqF5ROYDf4byEq7/hFVlyROhu7oO+AjQ7lkRd4G
         MJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226715; x=1733831515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJmN9vm0KKdkbgYJY1kJ2PT7vRHayhKSRB17RM5kC5E=;
        b=qxd0AW07sh0Nrt3tdOJCL+Xww0RVJp5NMGUysKmevlJbEdyMgzgkem5nSeXEcPdcp5
         NglL1xbGXdITM+P//hMDyY7KcprtlbtqjXNR1ITEpOAUtt9hYrlH6hoydAuFE2oKPD63
         m3hT4tdCo1PPASdtKraKXgiF5vU2WetYa/0tFqnidCHbcpr7FybSEdWZpYN/tRJ1SCcC
         QyPuSDNls6inZxu0LxLSTc9cIjcEprz+vM3R3ifCIX6Yf0hMDAd8Yrdzq4w46Osc4xNM
         WTA43DeXeiWxWKvpeSBzs3v0TBq0I3enInfAjAgWnPGk0oFuOWXPbvL4FGQ4L7szI+aY
         G2pg==
X-Forwarded-Encrypted: i=1; AJvYcCVbMGJtpGVzNlNn0jaerjDU/cpsuUQ+tvGaY6ENbTDBbFFRqVv8/Fli+VK/3RHPIFLA4kIF9b59/HFQLLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvCyzGKAHmElAUK0VEIzrrQdbPTG57PmvvCwcPt/9dyp1ucQa
	4NgcpCta//GrbKQwEIPQXFAfj1mE00re5S4GqvU2gw66JoZGA+Wh5x44DPlmo6toxYVsZHmgb4i
	XLQsZVB4OLiQljvBFjtLhpy77ekch54HPluUtLw==
X-Gm-Gg: ASbGncv17PglYg4I8kBX/xcALrnqgTpUNEWGgRMEkfK59IJqX/OqsYCh+Z+3WZiKyjS
	1hmNCW3Xht714kN3OXLDyoiMfKbVcJw==
X-Google-Smtp-Source: AGHT+IEjsHAYwArBu8zqyJKRiaq0r1rzH6TwAontXOXbJw7jEjz6js3BPKBbGiqM6LVavcAfeIYgmun7BtLOfMgwhmU=
X-Received: by 2002:a05:6902:150d:b0:e39:772b:4bae with SMTP id
 3f1490d57ef6-e39d39ee384mr1903823276.6.1733226714940; Tue, 03 Dec 2024
 03:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112003017.2805670-1-quic_molvera@quicinc.com>
 <20241112003017.2805670-3-quic_molvera@quicinc.com> <em4vkg4totsg435s4usu7kqn45vfqfot2j7sikzmnof2kkyidi@26b6kkpz7z4c>
 <0ca812e7-bf5b-463a-83dc-9195aee14589@quicinc.com> <828dbdb1-d987-43e6-8cd1-7ba267da9e67@quicinc.com>
In-Reply-To: <828dbdb1-d987-43e6-8cd1-7ba267da9e67@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Dec 2024 13:51:46 +0200
Message-ID: <CAA8EJpqPRpV_aGH_LHoG8EWkaQ_tCR3u0jM3C_jXKowCAUEqPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add interconnect provider
 driver for SM8750
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adam Skladowski <a39.skl@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Vladimir Lypak <vladimir.lypak@gmail.com>, Danila Tikhonov <danila@jiaxyga.com>, 
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Abel Vesa <abel.vesa@linaro.org>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 00:04, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
>
>
> On 11/18/2024 10:01 AM, Melody Olvera wrote:
> >
> >
> > On 11/15/2024 7:27 AM, Dmitry Baryshkov wrote:
> >> On Mon, Nov 11, 2024 at 04:30:17PM -0800, Melody Olvera wrote:
> >>> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >>>
> >>> Introduce SM8750 interconnect provider driver using the interconnect
> >>> framework.
> >>>
> >>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> >>> ---
> >>>   drivers/interconnect/qcom/Kconfig  |    9 +
> >>>   drivers/interconnect/qcom/Makefile |    2 +
> >>>   drivers/interconnect/qcom/sm8750.c | 1585
> >>> ++++++++++++++++++++++++++++
> >>>   drivers/interconnect/qcom/sm8750.h |  132 +++
> >>>   4 files changed, 1728 insertions(+)
> >>>   create mode 100644 drivers/interconnect/qcom/sm8750.c
> >>>   create mode 100644 drivers/interconnect/qcom/sm8750.h
> >>>
> >>> diff --git a/drivers/interconnect/qcom/Kconfig
> >>> b/drivers/interconnect/qcom/Kconfig
> >>> index 362fb9b0a198..1219f4f23d40 100644
> >>> --- a/drivers/interconnect/qcom/Kconfig
> >>> +++ b/drivers/interconnect/qcom/Kconfig
> >>> @@ -337,6 +337,15 @@ config INTERCONNECT_QCOM_SM8650
> >>>         This is a driver for the Qualcomm Network-on-Chip on
> >>> SM8650-based
> >>>         platforms.
> >>>   +config INTERCONNECT_QCOM_SM8750
> >>> +    tristate "Qualcomm SM8750 interconnect driver"
> >>> +    depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> >>> +    select INTERCONNECT_QCOM_RPMH
> >>> +    select INTERCONNECT_QCOM_BCM_VOTER
> >>> +    help
> >>> +      This is a driver for the Qualcomm Network-on-Chip on
> >>> SM8750-based
> >>> +      platforms.
> >>> +
> >>>   config INTERCONNECT_QCOM_X1E80100
> >>>       tristate "Qualcomm X1E80100 interconnect driver"
> >>>       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> >>> diff --git a/drivers/interconnect/qcom/Makefile
> >>> b/drivers/interconnect/qcom/Makefile
> >>> index 9997728c02bf..7887b1e8d69b 100644
> >>> --- a/drivers/interconnect/qcom/Makefile
> >>> +++ b/drivers/interconnect/qcom/Makefile
> >>> @@ -40,6 +40,7 @@ qnoc-sm8350-objs            := sm8350.o
> >>>   qnoc-sm8450-objs            := sm8450.o
> >>>   qnoc-sm8550-objs            := sm8550.o
> >>>   qnoc-sm8650-objs            := sm8650.o
> >>> +qnoc-sm8750-objs            := sm8750.o
> >>>   qnoc-x1e80100-objs            := x1e80100.o
> >>>   icc-smd-rpm-objs            := smd-rpm.o icc-rpm.o icc-rpm-clocks.o
> >>>   @@ -80,5 +81,6 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) +=
> >>> qnoc-sm8350.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8550) += qnoc-sm8550.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8650) += qnoc-sm8650.o
> >>> +obj-$(CONFIG_INTERCONNECT_QCOM_SM8750) += qnoc-sm8750.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_X1E80100) += qnoc-x1e80100.o
> >>>   obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> >>> diff --git a/drivers/interconnect/qcom/sm8750.c
> >>> b/drivers/interconnect/qcom/sm8750.c
> >>> new file mode 100644
> >>> index 000000000000..bc72954d54ff
> >>> --- /dev/null
> >>> +++ b/drivers/interconnect/qcom/sm8750.c
> >>> @@ -0,0 +1,1585 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights
> >>> reserved.
> >>> + *
> >>> + */
> >>> +
> >>> +#include <linux/device.h>
> >>> +#include <linux/interconnect.h>
> >>> +#include <linux/interconnect-provider.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of_platform.h>
> >>> +#include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
> >>> +
> >>> +#include "bcm-voter.h"
> >>> +#include "icc-rpmh.h"
> >>> +#include "sm8750.h"
> >> Nit: please merge sm8750.h here, there is no need to have a separate
> >> header, there are no other users.
> >
> > Ack.
> >
> >>
> >> Also, is there QoS support? I see no qcom_icc_qosbox entries.
> >
> > Unsure; will let Raviteja comment.
> >
>
> Spoke w Raviteja; looks like he wants to do this later.

Will that cause bindings changes?

-- 
With best wishes
Dmitry

