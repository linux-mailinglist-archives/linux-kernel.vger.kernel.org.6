Return-Path: <linux-kernel+bounces-279528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4851694BE89
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043CE2843A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708018E024;
	Thu,  8 Aug 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+kvdnHJ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8218DF8D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123807; cv=none; b=ouMRdNXag/keXADzeCRExUWvdibHzK8Mx77/OiDshdR+j+zgnlUjkFBWATTGTVtkRQdlzzF846ekHj862sHCo+sTuCWDESSaPZ7O+uawAeJn3YVJhUtuCiGWvU7CxwvkvrOAZDW5ijkSKdiltwDxMo4DKJAVX2nGF4/zYtvX+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123807; c=relaxed/simple;
	bh=bbmfFVb6t654IpaQqd7GVf4O7Wxk6p1giGtbRBjzz1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VigypLdKOrpQbaLClduM7y57AHbIfGg+upmc4CJJYnokp201/rzyenRUxk6HyhzIKWvbvZEgIxBm+Iv+tbHlXHgtP9PukkHvcwkh0VvHBHrHWUuVz7SIaTJug8CHxoNxEB1rbGAMSCP1Bsl7k1Xa9g1iI/Mk3MmYd7Om522OyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+kvdnHJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cfd1b25aaaso813753a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723123804; x=1723728604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lZxT14EwwYSSCHgAAJs56j4ybzd0J4lZ2llfSmTpvk=;
        b=i+kvdnHJlhvp6YgzUSEg/etdWs28tdmfVRQ23wGVWSxJ/fLS+X8l4qfBAiLML3w6/e
         DJ4vqlYT0lu/xsFatJYrOSnFNL5Vcw3EB296bDOJlotPSZBIHqAbma0eUS/uOHQXGntI
         122EXSQpNqrPRAW07+DDj6KFDUEQAWfV+hQAevGTEBomnSm6hXLkP01XvEJbVCpRc+r+
         QSucKAwIRBe33hFy3+0XwoIt2vaitPQTB+dTmlx1c/D7yRm7TpK7dwEjw6mdZgyIUPT/
         xEQzSHbQ0O6Ezoosyv0OKh10xTDjJhNxz9PkXYWqnMrX/mVtXgWJptMaGMtxLuueIFeT
         IU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123804; x=1723728604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lZxT14EwwYSSCHgAAJs56j4ybzd0J4lZ2llfSmTpvk=;
        b=g1RQJFpmVmSurEWiz6bYDThYfTZGAekQAEzCrYAHmyL5Sv/xJpSp+irZUTegH/dByF
         2uEZFvgRPZh/bDx6QYP0wEDwSCja8h+H6eh+J7BRID2FPkzfATLSMA97B3y/aste+6RQ
         e70bpWlibiFe/lnjndvRTc8qfQnFIawsOn/v6JKNvdKSDFO4IZ3RreGUdZYYUVedzxhg
         voYxge/JfuxeFFuqCGfHXexBmyRmOS1TY64fE0OGxlm/wal+rDerYdtRoqPkXhKwAAdV
         l0RfFA4cXIsr+R7lWL+BWtCk8A1GJvyIg1S1AgFe4m35kakc2GNb2Xk6nItL29Qbxzrz
         MpyA==
X-Forwarded-Encrypted: i=1; AJvYcCVTV4iK+2O6lUihtLfLk60GOYoo/ulwEwU78LZwnIkCpMAKvhvnykzNpNbt28mdiy4HeJeFGMe8qIi3kJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlecTM1Qi5CbDQTeqK03o3WngPSpzDu3QF73dJL231mxpPOcup
	utVhWzIjPsy9Lkj4ouPwnt0ABFCGRrMZ8DTg7ZpwTMy480LkZwlcsyexNgngxQ==
X-Google-Smtp-Source: AGHT+IFpAZ/58D+aRL3ZP38sJbvoR7HzeA59k/BtocUQn6vm996btF22ZeJW7vPZa9tDi73gILiEBw==
X-Received: by 2002:a17:90b:4b92:b0:2c9:6b02:15ca with SMTP id 98e67ed59e1d1-2d1c34723e1mr2164190a91.39.1723123803549;
        Thu, 08 Aug 2024 06:30:03 -0700 (PDT)
Received: from thinkpad ([120.60.136.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c5d696sm1122630a91.9.2024.08.08.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 06:30:02 -0700 (PDT)
Date: Thu, 8 Aug 2024 18:59:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jingoo Han <jingoohan1@gmail.com>, andersson@kernel.org,
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
Message-ID: <20240808132953.GC18983@thinkpad>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <5f65905c-f1e4-4f52-ba7c-10c1a4892e30@kernel.org>
 <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
 <ZrEGypbL85buXEsO@hu-bjorande-lv.qualcomm.com>
 <90582c92-ca50-4776-918d-b7486cf942b0@kernel.org>
 <20240808120109.GA18983@thinkpad>
 <cb69c01b-08d0-40a1-9ea2-215979fb98c8@kernel.org>
 <20240808124121.GB18983@thinkpad>
 <c5bae58c-4200-40d3-94c6-669d2ee131d4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5bae58c-4200-40d3-94c6-669d2ee131d4@kernel.org>

On Thu, Aug 08, 2024 at 03:06:28PM +0200, Krzysztof Kozlowski wrote:
> On 08/08/2024 14:41, Manivannan Sadhasivam wrote:
> > On Thu, Aug 08, 2024 at 02:13:01PM +0200, Krzysztof Kozlowski wrote:
> >> On 08/08/2024 14:01, Manivannan Sadhasivam wrote:
> >>> On Mon, Aug 05, 2024 at 07:18:04PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 05/08/2024 19:07, Bjorn Andersson wrote:
> >>>>> On Mon, Aug 05, 2024 at 09:41:26AM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>> On 8/4/2024 2:23 PM, Krzysztof Kozlowski wrote:
> >>>>>>> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
> >>>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
> >>>>> [..]
> >>>>>>>> +  qps615,axi-clk-freq-hz:
> >>>>>>>> +    description:
> >>>>>>>> +      AXI clock which internal bus of the switch.
> >>>>>>>
> >>>>>>> No need, use CCF.
> >>>>>>>
> >>>>>> ack
> >>>>>
> >>>>> This is a clock that's internal to the QPS615, so there's no clock
> >>>>> controller involved and hence I don't think CCF is applicable.
> >>>>
> >>>> AXI does not sound that internal.
> >>>
> >>> Well, AXI is applicable to whatever entity that implements it. We mostly seen it
> >>> in ARM SoCs (host), but in this case the PCIe switch also has a microcontroller
> >>> /processor of some sort, so AXI is indeed relevant for it. The naming actually
> >>> comes from the switch's i2c register name that is being configured in the driver
> >>> based on this property value.
> >>>
> >>>> DT rarely needs to specify internal
> >>>> clock rates. What if you want to define rates for 20 clocks? Even
> >>>> clock-frequency is deprecated, so why this would be allowed?
> >>>> bus-frequency is allowed for buses, but that's not the case here, I guess?
> >>>>
> >>>
> >>> This clock frequency is for the switch's internal AXI bus that runs at default
> >>> 200MHz. And this property is used to specify a frequency that is configured over
> >>> the i2c interface so that the switch's AXI bus can operate in a low frequency
> >>> there by reducing the power consumption of the switch.
> >>>
> >>> It is not strictly needed for the switch operation, but for power optimization.
> >>> So this property can also be dropped for the initial submission and added later
> >>> if you prefer.
> >>
> >> So if the clock rate can change, why this is static in DTB? Or why this
> >> is configurable per-board?
> >>
> > 
> > Because, board manufacturers can change the frequency depending on the switch
> > configuration (enablement of DSP's etc...)
> > 
> >> There is a reason why clock-frequency property is not welcomed and you
> >> are re-implementing it.
> >>
> > 
> > Hmm, I'm not aware that 'clock-frequency' is not encouraged these days. So you
> > are suggesting to change the rate in the driver itself based on the switch
> > configuration? If so, what difference does it make?
> 
> Based on the switch, other clocks, votes etc. whatever is reasonable
> there. In most cases, not sure if this one here as well, devices can
> operate on different clock frequencies thus specifying fixed frequency
> in the DTS is simplification and lack of flexibility. It is chosen by
> people only because it is easier for them but then they come back with
> ABI issues when it turns out they need to switch to some dynamic control.
> 

Atleast in this case, the requirement is to just set the frequency based on
switch configuration and not change it dynamically.

Krishna, is it possible to set the freq in driver by detecting the switch
configuration? I believe the freq is based on number of DSPs enabled?

> > 
> > And no more *-freq properties are allowed?
> 
> bus-frequency is allowed for busses.
> 

Okay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

