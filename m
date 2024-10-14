Return-Path: <linux-kernel+bounces-363011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2499BCB8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2EDB20F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563513D2B8;
	Sun, 13 Oct 2024 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAz2lTvz"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EC42F34
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728861937; cv=none; b=h1FIEqazeBnlQ2g8fvUD3ZLzgHASnKxb1zyeMpJH5yzIXq9uy+3CXvb2O/2Z1RWMIGl6nVlrLSQtmSMeIKTNiI/FinUxjUdJ3Sdk9D8SguZIvdOudrlodtEBkOvJ3GrAFQBQyCasGJYojW6QflVI/h5iM3c0s5LIRvUx+bQB8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728861937; c=relaxed/simple;
	bh=p9stHoOH8kkpzFCF4Mbrh0/N0hNI0ALhcvny2+V1ViA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHMCPCZnK5+BEk3kYY0fpE08h0z0p1zc9Bhjb1Ff2IkoEqGqI/SapNXv1b6kVwB9Z5QELkmRfU6TSpXn+dWHbelLID0lcKXoG8SJ/rhgEHnySbLw1tMUw/VzpHcOt/Qu4yUtVLC/5QAi3KpiYa/g+RziuIa2vgy2OjlTcVb3aCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UAz2lTvz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f1292a9bso646969e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 16:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728861934; x=1729466734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7ppDo8eXEXiW7XbxyYtkiDxlhQRgo6UTY3wAxOKzT0=;
        b=UAz2lTvz5jxVSa+o2Nhp6bb3Q60E3YPvvnACnedOjOvh1/88jDBbHVwcoFuVWdvUYK
         dAXAdES3er5JeehXa2ZYdqhcjq8hV/VmygL3z4g7h2CEnvyr+HhbjNg8cIFGDyE45k2S
         Zt1fMVN1dVKWGqMzkhj961nz25T12CDKj95iuh4WnQJgbxMkzj0AwraRsOF7fdoIuJzM
         xA7h6bpInaDpPGe0U20nbSc4N7OIYFoVZZlORPu+upS5zGkQJq5bRl8HHjxKKyEDMNGV
         AI4Uvut3LUsyzWf/ENpeqBOHyRiOvh1jiTeNTl6KcF8qiNehGk69Pi+jPwP6YDD6yhMl
         wuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728861934; x=1729466734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7ppDo8eXEXiW7XbxyYtkiDxlhQRgo6UTY3wAxOKzT0=;
        b=gH5/Cbs7wNcX5jPGxggImuU5SnP8SziHVRdUprX9uaVS5B+dwf95SPk88y++194RGi
         U9mqaYJOJNDgM2Dg3AtQmCRjdjoh5pEOWBgrLmucyJ81Mk9Bwexrax8xgm6kDCaJeYoG
         cZYRptxPV7GZpjGI3ZB1Dr+TVSCLBgsTCbP1JcazW6LVacIBy7ea2jydLP4scQP2In3F
         MD/0k90BMi/y+yAJdlUIQydKGDkW2f65YRm4wxe8Rf5zb0KuTt2rG7rRzD9IKRLK9D9b
         3VrU/QXyuzaLBLkpApUv0+jO/dRIWMtAE0yI3tCkdIWsxmCSDDyJ+FAD9GjMm/8uarAc
         SKyw==
X-Forwarded-Encrypted: i=1; AJvYcCUOhg3rk2tQchrEL2bnbLu540vT6z6BXKBQBDUJr95RkDxoAHN2jCxzrEzVnJJFRPvh6wbwKTlIFT8AFCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7F5A68iZ9icg2IVQJrk+4U6y2wNJXkH4ZN2GP0y4fmPuTLtK6
	uez/0Mmy5oDsKsNpqCRfkUHEgX6nmh5nKu9dhuWDjZwR4snx69dAU6c3tOE6uEM=
X-Google-Smtp-Source: AGHT+IG5vye8bbxSx+nbimIrHZrTf8ydt2CJhidqMxft9FquUHUFUTAFYexvP92VmmkXD6RHLn00zg==
X-Received: by 2002:a05:6512:1256:b0:539:ea7a:7688 with SMTP id 2adb3069b0e04-539ea7a76dbmr1188496e87.1.1728861934157;
        Sun, 13 Oct 2024 16:25:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539f37134c3sm323013e87.109.2024.10.13.16.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 16:25:32 -0700 (PDT)
Date: Mon, 14 Oct 2024 02:25:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
Message-ID: <7yzjgqitjvfwricftcpelktwjbgwkjuibwkpodjd6x4gwkjkw3@wkeqp6lqwfqv>
References: <CAA8EJprRF0tVFZK9c=MT8bSRcBdRvcugBaeEzpX5-wfRyNgc3Q@mail.gmail.com>
 <c8be2bbf-a51c-a38f-6e6f-a88801f953d5@quicinc.com>
 <20240209075716.GA12035@thinkpad>
 <CAA8EJppfzc_dM9c9mHPVWheVxi-1gJxCmaWPvreELijEQDDSyA@mail.gmail.com>
 <20241001101622.ys36slymgjbaz26q@thinkpad>
 <8459161B-87B8-481F-AE71-3D5156B1CA56@linaro.org>
 <20241001141948.g74rn6777ywvtcmx@thinkpad>
 <CFF89D4D-8131-47C2-95B8-A0E130A16E46@linaro.org>
 <9c24ba5d-431a-c45e-ce1c-3541eac7d017@quicinc.com>
 <20241012124334.4gsspgtuud4uudop@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012124334.4gsspgtuud4uudop@thinkpad>

On Sat, Oct 12, 2024 at 06:13:34PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Oct 11, 2024 at 05:24:29PM +0530, Krishna Chaitanya Chundru wrote:
> 
> [...]
> 
> > > > The logic here is that the fixed endpoints in the switch will get an unique SID
> > > > and the devices getting attached to slots will share the same SID of the bus
> > > > (this is the usual case with all Qcom SoCs).
> > > > 
> > > > But I guess we would need 'iommu-map-mask' as well. Hope this addresses your
> > > > concern.
> > > 
> > > Yes, thank you!
> > > 
> > Hi dimitry & mani,
> > 
> > This particular board variant doesn't expose any open slots to connect
> > a different endpoints like another switch(which might have BDF unknown
> > to us) so static table should be fine for this board variant.
> > 
> > I tries to add iommu-map-mask property, the issue with that property is
> > that the driver is applying the mask to the bdf before searching for the
> > entry in the table. If I use a mask value which satisfies all the
> > entries in the table ( mask as 0x718) and if a new bdf is enumerated
> > lets say 0x600 due to mask 0x718 its value is again 0x600 only.
> > 
> > Can we skip iommu-map-mask property and use only static table for this
> > board as we know this board doesn't expose any open slots.
> > 
> 
> Hmm, I was not aware that it doesn't have open slots. Fine with me then.

It doesn't feature open slots, but it has two PCIe connections on HS2 /
HS3. Users might attach external PCIe devices.

Krishna, could you please clarify, how those two connections are routed?

-- 
With best wishes
Dmitry

