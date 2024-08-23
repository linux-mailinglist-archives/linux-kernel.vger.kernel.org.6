Return-Path: <linux-kernel+bounces-298617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B295C97D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B49285FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FC14E2D6;
	Fri, 23 Aug 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9QtM2Fs"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACE14D431
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406271; cv=none; b=bQ1wGstmE6OwKoS578zIibNLyxVBVpIy0nsdjrR12cpQAJ65NXWrxKO6XxA7Ioyb78GnxyKnjoi0fPCPICUk7Bbf6DsGaq4XIpdrZ3cAU12n2Od/JIoE9Or0DXKEMTlw67Psns3iUAIICJN2HHrxsoMTeL2gOSkUPAJAtyqqAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406271; c=relaxed/simple;
	bh=3PvN3jtOvPAZoaO89i8WxnDTkvSqatK/JcoT3DeVYSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoAoih0uJBrcTYJjKrjbMNHlm8w/nuG/4z13ohA3MQRdPyIZL+kwt8cqHo7T3WR9/Mvg9vR1FPNO25eWLzG1iYUlyLQ+rEs+iP0zIuiZzeelWxcP+50Y6WTbU4GGeBMGNw5OUDHEbmOa9JRAqOPgAXeCxi8FYBBV3CtkVOVPamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x9QtM2Fs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201fbd0d7c2so16437685ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724406269; x=1725011069; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/UI0fMy+8miLNDvNonKP4baMvE/ykNIwcSEuW14yBSE=;
        b=x9QtM2FsPT5fFX3UAyTAHgi1rBVOEak5I7f8eWDjuaq7QS3czsZi5NsgVSntW5PFTg
         M2miXuBWC+2vZ6z1u8siuiSTMCXrlYXWvRnJTXf0LvJf6d8qc8kd/2WtmZv/Z++fIfQg
         XIeGHp6cSZc8WLWcpseQps+q+QMFxBgOU6jqLde+0uyD8SWSCn9VdQC+8UCxQuLW5I6r
         vY0AXbYaT4VoTrOIz33XdZCDuNVTiFXz4CHJI2Qn50QE+BRAigohIIXwvEeyHPsnB8Hf
         RGnyPaOew2SxFLVWzhpIBi9JmfdYi66uc4qqrhmneNPBFQRntSdV+nhEdVLsgJHJs7SR
         Ekow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724406269; x=1725011069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UI0fMy+8miLNDvNonKP4baMvE/ykNIwcSEuW14yBSE=;
        b=haSBlkvBbQA8MxNNKYST4z01vhJUxTkAmKJfl2I16XnrrQ7liyXoR+cDCUNNczQ8/3
         KhZ/Exst80LdYhoD4DlmmjMv8GbD11HYCkX95fMQQeGs6KUoTlYsjTIF0Q38EkJqYVA7
         YvFDtxPgP49a1+HA4Y8AAzLz2R1jDk2d2kzMB8I9gWT4RhSjPYaU5Y+fQyG72+JCQEzC
         AdAefY8V+WsKlZXWM1rIWRYn9L+bwY5SIKHC9AwFIPGtCLs5B9JWMnmzAQl1JnyImHWa
         dCwnMIJEJaMI/WHC3DVKuVlRvd+fB3X365ByZjZpP23ccMPTfHElVofvTxUlPbAHuEpH
         FmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLCK/GS2hKWKf+BdrvevOcbxH5MFoO0qN7Rvl1XnjsnvccDp1ChcCkz66grSzHXOdYk6LPUP2/sFkgqMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdRCim9mVXck+niK6ubFS5P7z0wPfdJKPPS2mAQdBwaq3OLnm
	NrrzZO2JYfNB9sv88OrrBiBi4JWKPBtOJbtoYEytYxPpsMkzdyngDO7XA8YXOw/OtMUZ7PckptA
	=
X-Google-Smtp-Source: AGHT+IGbFyjY9zU3XHhTX7eBPKnZgYQO/jUribauXzoWCAqaf7GVCGFIFJsv+qddX9jb1Lk+ZzvFtw==
X-Received: by 2002:a17:902:f544:b0:202:5af:47fc with SMTP id d9443c01a7336-2039e4bd43bmr18884285ad.13.1724406268772;
        Fri, 23 Aug 2024 02:44:28 -0700 (PDT)
Received: from thinkpad ([120.60.60.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385be08f5sm24910975ad.275.2024.08.23.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:44:28 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:14:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
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
Message-ID: <20240823094419.7l2kvly4mnajrm4z@thinkpad>
References: <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <5f65905c-f1e4-4f52-ba7c-10c1a4892e30@kernel.org>
 <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
 <58317fe2-fbea-400e-bd1d-8e64d1311010@kernel.org>
 <100e27d7-2714-89ca-4a98-fccaa5b07be3@quicinc.com>
 <c80ae784-c1f3-4046-9d86-d7e57bd93669@kernel.org>
 <7f48f71c-7f57-492c-47df-6aac1d3b794b@quicinc.com>
 <aa311052-deba-4d13-9ede-1d863a4f362e@kernel.org>
 <20240822141622.tw7vcoc4ciwbydsw@thinkpad>
 <9cff09b0-d039-4e65-b6dc-57adaf94c12e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cff09b0-d039-4e65-b6dc-57adaf94c12e@kernel.org>

On Fri, Aug 23, 2024 at 11:01:37AM +0200, Krzysztof Kozlowski wrote:
> On 22/08/2024 16:16, Manivannan Sadhasivam wrote:
> > On Mon, Aug 05, 2024 at 04:43:47PM +0200, Krzysztof Kozlowski wrote:
> >> On 05/08/2024 07:57, Krishna Chaitanya Chundru wrote:
> >>>>
> >>> Hi Krzysztof,
> >>>
> >>> QPS615 has a 3 downstream ports and 1 upstream port as described below
> >>> diagram.
> >>> For this entire switch there are some supplies which we described in the
> >>> dt-binding (vdd18-supply, vdd09-supply etc) and one GPIO which controls
> >>> reset of the switch (reset-gpio). The switch hardware can configure the
> >>> individual ports DSP0, DSP1, DSP2, upstream port and also one integrated
> >>> ethernet endpoint which is connected to DSP2(I didn't mentioned in the
> >>> diagram) through I2C.
> >>>
> >>> The properties other than supplies,i2c client, reset gpio which
> >>> are added will be applicable for all the ports.
> >>> _______________________________________________________________
> >>> |   |i2c|                   QPS615       |Supplies||Resx gpio |
> >>> |   |___|              _________________ |________||__________|
> >>> |      ________________| Upstream port |_____________         |
> >>> |      |               |_______________|            |         |
> >>> |      |                       |                    |         |
> >>> |      |                       |                    |         |
> >>> |  ____|_____              ____|_____            ___|____     |
> >>> |  |DSP 0   |              | DSP 1  |            | DSP 2|     |
> >>> |  |________|              |________|            |______|     |
> >>> |_____________________________________________________________|
> >>>
> >>
> >> I don't get why then properties should apply to main device node.
> >>
> > 
> > The problem here is, we cannot differentiate between main device node and the
> > upstream node. Typically the differentiation is not needed because no one cared
> > about configuring the upstream port. But this PCIe switch is special (as like
> > most of the Qcom peripherals).
> > 
> > I agree that if we don't differentiate then it also implies that all main node
> > properties are applicable to upstream port and vice versa. But AFAIK, upstream
> > port is often considered as the _device_ itself as it shares the same bus
> > number.
> 
> Well, above diagram shows supplies being part of the entire device, not
> each port. That's confusing. Based on diagram, downstream ports do not
> have any supplies... and what exactly do they supply? Let's look at
> vdd18 and vdd09 which sound main supplies of the entire device. In
> context of port: what exactly do they power? Which part of the port?
> 

The supplies for the downstream ports are derived from the switch power supply
only. There is no way we can describe them as the port suppliers are internal to
the device.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

