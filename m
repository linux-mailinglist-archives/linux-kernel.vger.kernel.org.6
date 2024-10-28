Return-Path: <linux-kernel+bounces-385017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019069B316F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336F41C2141F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489681E48A;
	Mon, 28 Oct 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOKPfHNc"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7691DACBF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121296; cv=none; b=QpsPmacKhxO5uXJoOcDBV8xwZOusJ9DGCrefqlGN3ss5oCAUsJ867w8rWypQ43St+yDgH4WCbSKmPZjjglUUW8tDZ+SYd4a2fdw4m5FxfzL1TfRjzH6LlXcGyWQvoZID+RMLVkHuwjUCriAOqiZ0vEzWfuvT9r8efVMgeH+Q2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121296; c=relaxed/simple;
	bh=e+H7/8ZFlFExxneYh4qMJr3OPE3Obm7MPzwVFnWQ4Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8nynsSSA/WuWcrmclCGYT7uGOgytaZQqb97w/08ckCMU6jQ6QlBG2rFmeybQW+TxN2gPwZpnuBJnoXdxzNdQWII2R7TXbonl3B+qkuszzwhPNBQLV1NtdPM0egw47Y96luQy5cpJ8bBxiPnn9lvP5z2XfEzHwa39gkgqLulo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOKPfHNc; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53a007743e7so4890803e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730121293; x=1730726093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dp3q2DmaZ8BXzAwaa0cSoS4TpNkn/nCd8yHDeDdV330=;
        b=eOKPfHNcbKfbPoJTkxk2sBMJhCkVqFvOoEeJlq6KrpCF9oq6OiEWe1/qTdWpUTeQoT
         nShKhqhU/JCZOJ3n6TJeX7zk4Iwzn5V6NIDKs2YZ3NnoV9JRzpmQvpDT64JkqGoQ5lsi
         3qX/NXZxaH90MWgceW6qVWSYRoMo0UPE9E8srZAXMuvoGQkdoNEeGJhDL/Z4PZWdYosy
         D0gWYiKbasdTvD07rswzRaYc8SHF+pKdwjKrWabdpX0Zm4WWvIobwaQoHQ46E5oHs81M
         BrhNHtRsupTwYDmx+GmQfH161Vlh/MNmYeyUozX6X0MUegx003TZaV8kWWxDThz9/e4w
         bv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121293; x=1730726093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp3q2DmaZ8BXzAwaa0cSoS4TpNkn/nCd8yHDeDdV330=;
        b=aNxLOEb1J3JAIXMOyD1SFet52qVNb6YwmfyP0kGGwURVUWSQQ8tTHY4Fuxmb37ZV8b
         mZ5QBubgpaUHk6p4e2y4ycLuL96FUpwDhyUKvQ89xhZQ4qF0VxPluwSiq44C0AzdKuOi
         2rkx/aopv9whZ3bgQ5ZF1BgpS/HWV+bDMzHuqly4z5Ut8GGAL9urlFxWqNCmQBgeOlks
         SSeeQfu550/MMdGEr1Fa8xi/RBPq47dGmH2nk2Z73RzjpJfaGLDT35zwMaRK0HZqGdXH
         WTuPJI+aZLK5taiLXwK6BIpRlmQZC+V4CnzeMYTdr2hHsB0u/nK6jO/mskBWnHPLozli
         Y4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVgYbDNI1PxOgh7KRlRUoPlxM6iyCqnV1WllY3ypgcsFJKStX7/pqhXIb7FPn0gdTi8Z9VQ45CHWJ925GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1IkQs/Mq9Mqfjduo2QJRP+kziWskeOsgRHLKRrfnVlLZhvLR
	96XzPjCpaI+2tkyLlbHLyPsldvSht8VYJPnzelKNPxoQUclUvTvlyhfdgYIjFpw=
X-Google-Smtp-Source: AGHT+IEJwg/JVNj5cu07/aL/9CeiE3T7ncVaaZ0g9sFSJEJ3+NF6QXOKj0U+4Ks1onPuF/nX6vi0sg==
X-Received: by 2002:a05:6512:12c2:b0:539:f7ab:e161 with SMTP id 2adb3069b0e04-53b34a190demr3018930e87.45.1730121292653;
        Mon, 28 Oct 2024 06:14:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a5c6sm1062606e87.19.2024.10.28.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:14:51 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:14:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Tingguo Cheng <quic_tingguoc@quicinc.com>, quic_fenglinw@quicinc.com, 
	quic_tingweiz@quicinc.com, kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs615-ride: Enable PMIC
 peripherals
Message-ID: <csxhtspv4klk3yrdqx4rkoag3ssaagim74nvdpglijkqzfux4d@btniilyxnnwm>
References: <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-0-f0778572ee41@quicinc.com>
 <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-2-f0778572ee41@quicinc.com>
 <j4ggfrynyoriseef5r5x6uwgo6cespll2np7uitc64yagoa6pz@r3ro2cpqrrry>
 <38cceae8-5203-4057-bd8b-f20fe3656474@quicinc.com>
 <CAA8EJprYHjYVM58e7i7Sxj64DSth4hhW_cUZ3hGqX7u0ecZFQg@mail.gmail.com>
 <ad9c7e47-8a7b-4aee-8d88-cabf42ec3298@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9c7e47-8a7b-4aee-8d88-cabf42ec3298@oss.qualcomm.com>

On Mon, Oct 28, 2024 at 02:09:45PM +0100, Konrad Dybcio wrote:
> On 28.10.2024 10:41 AM, Dmitry Baryshkov wrote:
> > On Mon, 28 Oct 2024 at 10:40, Tingguo Cheng <quic_tingguoc@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 10/28/2024 4:23 PM, Dmitry Baryshkov wrote:
> >>> On Mon, Oct 28, 2024 at 04:03:25PM +0800, Tingguo Cheng wrote:
> >>>> Enable PMIC and PMIC peripherals for qcs615-ride board.
> >>>>
> >>>> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> >>>> ---
> >>>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 15 +++++++++++++++
> >>>>   1 file changed, 15 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >>>> index ee6cab3924a6d71f29934a8debba3a832882abdd..37358f080827bbe4484c14c5f159e813810c2119 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >>>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >>>> @@ -6,6 +6,7 @@
> >>>>
> >>>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >>>>   #include "qcs615.dtsi"
> >>>> +#include "pm8150.dtsi"
> >>>>   / {
> >>>>      model = "Qualcomm Technologies, Inc. QCS615 Ride";
> >>>>      compatible = "qcom,qcs615-ride", "qcom,qcs615";
> >>>> @@ -210,6 +211,20 @@ &rpmhcc {
> >>>>      clocks = <&xo_board_clk>;
> >>>>   };
> >>>>
> >>>> +&pon {
> >>>> +    /delete-property/ mode-bootloader;
> >>>> +    /delete-property/ mode-recovery;
> >>>
> >>> Why?
> >> Because boot modes will be supported on PSCI module from another patch,
> >> reboot-modes are required to remove from PMIC side.
> 
> Do we know whether the PSCI call does the same thing under the hood?

It might be writing to the SDAM. For example, SAR2130P also uses PM8150
and, if I'm not mistaken, SDAM for reboot mode.

-- 
With best wishes
Dmitry

