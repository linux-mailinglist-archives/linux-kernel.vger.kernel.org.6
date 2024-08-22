Return-Path: <linux-kernel+bounces-297420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC295B80B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBA11F23FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A321CBE89;
	Thu, 22 Aug 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwRK10DB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95414A08F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335817; cv=none; b=U8GNagaj/yn72YP8Yfz/NY4k48dRBv2vMyf4ALsuLMb71035ZM0KtMpKvsDVY+6E869dymA8lnuokL3mASDTzEeXNfOAovfu9WPkJAmMyXPXXy7dwv18aO0KhuT4xtyFE1TKO/oYmaKmf/uM/qOTzF5HH2Ptua2UkAFlRy304jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335817; c=relaxed/simple;
	bh=0zjURCfVd5HHj/VTX5X8G1aOa7+YHoPv4IrUn3361ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMReIa0oV3/JiS84yTDr4Z0pK9eHQ/S4bamJG53u1dvNNxfNeXLhwfWKGFVX6ItfUvRfm9flGjkhdLs+cLkblVHZKIDTF35Bx0E8mhDE+fcrd0oWbQf/7cntdciia75XmVDKnypSa3XvmYNKtLXH1Y1hR9wUbXy3ugf3Gi7LMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwRK10DB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20202df1c2fso13193395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724335814; x=1724940614; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ksLULyP/cLRQ/mJ475rRnLjhOrwePPcDiwX+xXFf4p4=;
        b=ZwRK10DBAUbWV0dSM3OA9u0IlISYXoCNeimPb++TbYD4Tm/Uicn5BYFz4ToO68hA6R
         LvR/0SLOe6YmN/GaY9S0J0w5mBGCL1K1lZvjlrjvCKpKG7sRLxgDAXKBs0pr02yBFRqH
         j5KgLvDsN3km41CPwMlKF8aLjt8ZBYVoPsByAYBJDoxgRq5OrZONoPDK9t0N2sqN4uxi
         1nmC0LiOoyYJvPj3UdPWeJluJXHxsZNysrH5UNsOrdDiYTNWKyUiX9lYi15sapzYPQZP
         Vy4qBs+eJUqFRQwdA6uM0s0HNNi7HdlPTEnNGfG+rwIJMYTTy4tT2AQEcmN9KHz9ISdo
         +wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724335814; x=1724940614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksLULyP/cLRQ/mJ475rRnLjhOrwePPcDiwX+xXFf4p4=;
        b=IFVt2hD6qcenz+vkr0QkHMLu49tL3P73Pr7ZXEnuxTw1Ua8DF5VC+FAbIWCSyBjkvo
         Rmo3xJb/AEncn4zMF9KwAcyJcile5Itz/P/7tMIUCYJwIqxSQOObgNzzfDUd3HCroOPm
         b1B3fi+vvLlE7s1ZA3X4P7Fop3IAYQ4ehfwj6/6C+qfCFr4Ko8LlbaiHJ/OGS8yUcGuO
         tFq8A6t9YMME/zO2P8ojhcglSqgUKCZjyH25AGG0TC2vdjuNlmTT/mbQVY4VL/A7Bq2U
         z1uT3rvQYAx59iiglcheB54mQOl4j1hop8l1b9uN6cow3LvoMH6XA4/v9BbZKmqhoW6G
         NqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPOH2KRePPgyBRQWb8arcsGnJ/zPjK/e4dpmlh8vjfwTuxXhIYsvmTWFf0wCgeHciZCCKWWWsCY8SF8Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLK30Yzv+vNLK/T7npXyxoEcECQQ/6QY0TGbIsc7o9rOrOc0NT
	+tDJQsxpri1Nbpk2e6mIaIQsUEKq9C1xVa3TZDCFPXTL2JTt5zch6qlTJMDU+g==
X-Google-Smtp-Source: AGHT+IFzrt+20YcBicCQwfyJ+mUBIOMfNnIP2J0ZKEzrCrBDMEr3UYtUjafNmadoQZ655bU1nScC3Q==
X-Received: by 2002:a17:902:db03:b0:202:4bd9:aea5 with SMTP id d9443c01a7336-2037ef2a562mr46871435ad.14.1724335813800;
        Thu, 22 Aug 2024 07:10:13 -0700 (PDT)
Received: from thinkpad ([120.60.60.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560fb70sm13035215ad.232.2024.08.22.07.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:10:13 -0700 (PDT)
Date: Thu, 22 Aug 2024 19:39:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Message-ID: <20240822140956.unt45fgpleqwniwa@thinkpad>
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

Atleast for this device, this frequency is going to be static. Because, the
device itself cannot change the frequency, only the host driver can. That too is
only possible before enumerating the device. So there is no way the frequency is
going to change dynamically.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

