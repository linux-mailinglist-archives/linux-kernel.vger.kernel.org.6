Return-Path: <linux-kernel+bounces-367788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80EC9A06D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E83B21471
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19740206956;
	Wed, 16 Oct 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuTJrw2h"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E66206066
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073674; cv=none; b=QTqU5w7e+lamJbuDdH3e5Fq9B//EjwwZe62U8/A0m09Gww4TuU+8FLtLxfiVKx8Hy7/X27NBHbAwT+kT4WuVbCLYK0Wbvi2V4XcG51BzTX0VAZ+wh6/V/qu+ApYEwivkMCzNqvWfukti1fWEC7+KWMAP1BOwa0eZcm7AXDVD6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073674; c=relaxed/simple;
	bh=Jy/4YRGjM5uU9fBaBkoJwFVJOY3w+JZVrcjpicoQrtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG8pT3KTyCK++mBfzVOtQ3GOdxdVYJaV9msIWecqFEUlPBzeOlaLbt4jEp6HrfeVURhFdfsu2SNCJKZs8ty4AAVfaaYLA484HZ47/rO8uReoATmy5ncyutMkepyeNjvXVQKW1+Mw+qxfIIBmHEtdzsZcaQ+pOPOks7Jn+BqjPdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LuTJrw2h; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f6e1f756so3709782e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729073670; x=1729678470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lM65E4+Eo8QstTSX4BkH0aaP4WZN36AHY5LgVC065Sc=;
        b=LuTJrw2h+1zJFD47KiuOy9sITM/ibaMvS0mEubNW7eq8LTaAy2FqQWEUOmeOMhanPI
         2gaIu858CiHrkDf16zGBzX21VfVE1YGZvwVLbSVtM+mLVglcXlULvijv6lEXVAQ7V7oH
         Ofy60aDOBEUplCVgtgWVLutolDyMZnO02uIDXnjUfA4YRfQGy+hk2GjZlIgP6XFPv7Bi
         LI7uvy2RuMlAkqI8VIeggwN+SPMn7N7nr9lCh05/yRezO770Giefc53NhALZdxZekcEy
         n0jvIGN1iucJEp3vPh0KxELU7gF3jchfERHbmHROzetFSQSuw0LMDMDyG0E7sbjfx5y7
         p/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729073670; x=1729678470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM65E4+Eo8QstTSX4BkH0aaP4WZN36AHY5LgVC065Sc=;
        b=NtAsABKaRmyI07tLTkEbzSAggC4D8Vkn+2fWjVxpqmeBCILc9YwcUBYZChLnWWB98l
         iCLWjJQQtCzGRYMOBho7CThu8HCVPeZbrPbET2HGl+9xo0lEd7fLV5bODvLS3+vdCDcM
         yTtSuTPdizQRh2VgVmpwrW+qEUY5460Dpt4/NTXrxAPz7kqxixjoGLJavQt67s5dTF4k
         lv7+mX8xkolAJCYz7FoRdQe4DLCarc8G8+RisHlRDjrGCXd5QdawJ9qS7un1/77glse+
         wuH2IP1HhoQQOPrKuWsSLGDqjPff8r1CXiDTWDGrqYmvBNQ8i6NnNKgbPkIWRZDEHrNN
         oqgg==
X-Forwarded-Encrypted: i=1; AJvYcCXfw9co0iVPXAD+IZZD7K3P5UZ4hlZRgL2Ci5UJWteUwJgCrG7p1rFGhJDRfMw5wQNsKuWTjIt0sfUh4kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+KARUOIJFdDtNG21GBm4L5MNESTkil+MMbyGvZPSGOzWf3DQ
	5SSTKJGJG3ObcPFgexvbPhAi8rKqeOFZmYmsthMjay4kFlYd5HiZk6mVXwPmVLY=
X-Google-Smtp-Source: AGHT+IEFRXiKZjGcstJy+MKY385TLFHcYZD3pT8PlWoFfPmx83LlhFdNsBRJBrkU1Avk5D/mqxOMUA==
X-Received: by 2002:a05:6512:398d:b0:539:f995:5b00 with SMTP id 2adb3069b0e04-53a03f0c0e6mr2137629e87.7.1729073669885;
        Wed, 16 Oct 2024 03:14:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffb1ebesm408714e87.105.2024.10.16.03.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:14:28 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:14:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org, krzk+dt@kernel.org, robh+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	conor+dt@kernel.org, abel.vesa@linaro.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add X1E001DE Snapdragon Devkit for
 Windows
Message-ID: <utfifivkqt2mgejmycnyrw4aoy6rbxkifgaxajdbb7lgq76p25@i2zzpeksbwja>
References: <20240911073337.90577-3-quic_sibis@quicinc.com>
 <pt4wtycddqhcvw2iblaojmzsdggmlafft4vu6lg5j2vstbhbqj@acenyi5k3yeq>
 <eqy4yicgeqlgaytgzybnitvbrdr7jmjjk5k2swmadad6scwk77@ubaf7a2kgmdm>
 <1BBC34CC-92D9-4F6E-8DFA-1F2DA36D545A@linaro.org>
 <20241001085105.iglzp3art5ysli2d@thinkpad>
 <b1d982c1-f800-97eb-1be3-e77e04a8e81d@quicinc.com>
 <20241006180146.m6xvpwbvkiy7obpx@thinkpad>
 <20241015135114.kbiyvymng4e6dmvb@thinkpad>
 <CAA8EJpombwmYimszNoQ51m+cfcNs9x+TQ39+-6kXXp+Ziq=d7Q@mail.gmail.com>
 <20241015152736.exon6q77jathhp55@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015152736.exon6q77jathhp55@thinkpad>

On Tue, Oct 15, 2024 at 08:57:36PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 15, 2024 at 04:57:45PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 15 Oct 2024 at 16:51, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Sun, Oct 06, 2024 at 11:31:52PM +0530, Manivannan Sadhasivam wrote:
> > > > On Sun, Oct 06, 2024 at 12:33:21AM +0530, Sibi Sankar wrote:
> > > > >
> > > > >
> > > > > On 10/1/24 14:21, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Oct 01, 2024 at 09:56:30AM +0300, Dmitry Baryshkov wrote:
> > > > > > > On October 1, 2024 5:42:35 AM GMT+03:00, Bjorn Andersson <andersson@kernel.org> wrote:
> > > > > > > > On Wed, Sep 11, 2024 at 10:55:05AM GMT, Dmitry Baryshkov wrote:
> > > > > > > > > On Wed, Sep 11, 2024 at 01:03:37PM GMT, Sibi Sankar wrote:
> > > > > > > > [..]
> > > > > > > > > > diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> > > > > > > > [..]
> > > > > > > > > > +
> > > > > > > > > > +&pcie5 {
> > > > > > > > > > + perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
> > > > > > > > > > + wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> > > > > > > > > > +
> > > > > > > > > > + vddpe-3v3-supply = <&vreg_wwan>;
> > > > > > > > >
> > > > > > > > > Please use pwrseq instead.
> > > > > > > > >
> > > > > > > >
> > > > > > > > What benefit is there to wrap a single 3.3V regulator in pwrseq driver?
> > > > > > >
> > > > > > > First of all, is it really just a 3.3V? Second, is it actually powering up the host controller (as expressed in the device tree? Is it a power supply to the slot (in this case, I think, it should be expressed differently)? Or is it a power supply to the card itself?
> > > > > > >
> > > > > >
> > > > > > Yeah, we should get into the details here. We were not paying attention till
> > > > > > now, but with the advent of pwrseq, we should describe the power supply properly
> > > > > > in DT.
> > > > > >
> > > > > > Here I believe the supply is to the PCIe Mini Card connector where a modem is
> > > > > > connected. In that case, 3.3v supply should be connected to 3.3Vaux of the
> > > > > > connector and we should have a generic pwrseq driver for the mini cards.
> > > > > >
> > > > >
> > > > > Hey Mani, Dmitry,
> > > > >
> > > > > The schematics are identical to that of the X1E CRD with
> > > > > the exception of the pcie daughter card having the rtl8125g
> > > > > on it. Yes, the 3.3V supply is connected to the card as well.
> > > > >
> > > >
> > > > Is this connected to the 3.3vaux of the card? Please specify the actual rail
> > > > name as the 'PCI Express Mini Card Electromechanical Specification' specifies
> > > > only 3.3Vaux and 1.5v supplies.
> > > >
> > > > > Doesn't this mean all other x1e boards out there needs to be
> > > > > updated with pwrseq as well? Anway will get that addressed in
> > > > > v3.
> > > > >
> > > >
> > > > pwrseq is the kernel driver abstraction, nothing to do with DT. But for making
> > > > use of pwrseq, the supplies need to be described in the proper place. In this
> > > > case most likely under a separate node of PCIe bridge. Then you'd need a
> > > > separate pwrseq driver in kernel to parse the supply and take care of it.
> > > >
> > > > I'm currently writing a pwrseq driver for standard slots (x8 for X1E) and should
> > > > be able to post it early next week. So you or someone could use it as a
> > > > reference to add a new driver for m-pcie cards.
> > > >
> > > > If no one picks it up, I may just do it.
> > > >
> > >
> > > Hi,
> > >
> > > The slot driver is taking more time than anticipated due to the pwrctl rework.
> > > So please go ahead with the current binding and we would switch to pwrseq
> > > later once the driver is available.
> > 
> > I assume this applies only to the case of the actual 3.3V being used
> > to power up the PCIe slot? Or to all existing pending items using
> > vddpe-3v3-supply?
> > 
> 
> What do you mean by 'pending items using vddpe-3v3-supply'? I was referring to
> the slot supplies only.

As we've checked offline, it seems to be just a controlled 3.3V supply
for both NVMe and WWAN. I'm fine with using vddpe-3v3-supply.

-- 
With best wishes
Dmitry

