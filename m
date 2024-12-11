Return-Path: <linux-kernel+bounces-441978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6149ED645
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABC7283DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2522A7F3;
	Wed, 11 Dec 2024 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSwLKZkk"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083D205AB6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944538; cv=none; b=L7fftyVmbYSGqrOmiG3L0bnld8jrgQ3bDNp6XwxJ2zhU43pxki6a+ISL1gfuhoM0Iqrk5XdnMDTD/3LlhRGjsHVyTyB2uvV1Ip+1sWpeOoBRlGXZuv6REQh9RgezUCzx/nF9Gu3HL7C43xsRyF0eQwOsDgLbUqcxE6WG0YE19gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944538; c=relaxed/simple;
	bh=iv4lu3fsbHxWA6dS15zlzvhVDsMUChoLyknk3qVoC6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btgp+vPkqC/urYdmrzwXYHTY9HAfgl6gHBtqiqK5vfk+0RyVnK8/am3qPaRC2FUD4ivWpF8QoaNgumqX/N7Zw+UgZJP9WOXXWTUiYE8dBHC6Y61d6NrQxHQ9wd/mfVihneguFW7afJ7lh2yrNkcd01duqcrWAM9PY1LOnSpTfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pSwLKZkk; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso65429361fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733944534; x=1734549334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xwJG5tVEAPuDua/+zEisi7SKCgTlTwRIJJOT5jh9lAk=;
        b=pSwLKZkkJwRZMeJcdIh+FexhJtnLbz1gIBy1C02D9oFS0CbOoO3dhEmPrX0tY8eKiM
         73iL+Qc8NBaJt2K/yDzCLbLKZCxZX+IcipFY3mxl6q7XTEfMPTNpYN8R6PpJr+XQlzQR
         AhtvsvfA+dE8IhEZeF8fWhbEOdTtDU9fzIV+S1rtUvg4X7U1ID8JTnbo95a1vSLy+CAJ
         hvGUXhnGZwxwHo0dzqwgxqgiZ9OX5ik1wUcMIg/84DumEw/NCH97DLhyuQumgPBDES2l
         X8lMktgak0dUToJDtBF2LCJi7fXqkJyX2U79BNJehjqPlKSx81udm6NcWThZw3KS6fOp
         K6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944534; x=1734549334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwJG5tVEAPuDua/+zEisi7SKCgTlTwRIJJOT5jh9lAk=;
        b=q29rHb4b8K4+jJqU4Ur5vHDCmHkVs6fFtyrMRaGwUYOP+wby+8tMR3quUEgL5zN3en
         gCvjLpZ/XHbJ+8ohYhJPyG9x+zhJEDMb10AdVkc2u8yriXr9wx4v4EH2OVraL0IUjvm/
         knAok8iZx4fpjZStbLGWpmXAAmFewuqlSQ+3RZtqnFoRUVwJK/nkD0NETUBiXrJewt5X
         Ejg1nAs9Uztx7v6Jji3xGAj90Qv//+CuXufU30fRebIrxCrW4zrtG5KHbj9iEEjuFVTB
         kkk13RilwLYAOztNG2M83BA2BctmLkn5salWMRU0OkthkBsB8dmLez9yeJuJnD1Nw5VT
         PWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq3PMdTMnJ3kNnKt7qJMqxWEXA2zB8DYtQROEbzgAjwcZw87pJx2qo2sEIgpVe64z63BV7BVzkKbWGycM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnt+iuml1/AX+O0FUQmIMUk1V9yTLLcEH21zybzmvG7SiaHT8l
	OWT2jZ5Su83Ovjj/+LssvFebAUKFhpQoRXw5BgWaFIKw0VuGZUikksd6GoSXDdI=
X-Gm-Gg: ASbGncuSCjps9caQMTXew0ZhzCnKEX7kiHcGO9Q1s6JMkaivzLbyoXJOBGsq7dhZPFe
	7Tr7Ak4dJZiQzU9hdOVZr2nxeLSXijNvisb4QR3wXxWMEMiwLXGHA5dCqgURo324Dzxtgw/FGAy
	UcC/0eIp8f+Cnp9qAuxM2rF9VF2KEsQpvIlzhu5WTdmGsIFCVZdlWrFzftvh2G+9361vJvHVxdn
	KaflmGMHbnT/uu3DQYln3ZgmLbA6n0RXg2G+ZCc5vxuiK7XmwITWayCg+t2mWtMcBr3ugduV2oC
	46ehwioIPMmvbnJe1GQrRPrxkoOM97erVg==
X-Google-Smtp-Source: AGHT+IF+vVtTZWka6wAG9ssDBMOZChK/BACOngdEv98xkt4y+52aaxKOJEYpuiSr8ME5jDwv2CFS9A==
X-Received: by 2002:a05:651c:886:b0:302:4115:acd with SMTP id 38308e7fff4ca-3024a21c6c9mr1832311fa.22.1733944534510;
        Wed, 11 Dec 2024 11:15:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30220583defsm10758071fa.4.2024.12.11.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:15:33 -0800 (PST)
Date: Wed, 11 Dec 2024 21:15:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/8] phy: qcom: qmp-usbc: Add DP phy mode support on
 QCS615
Message-ID: <7vdaasc3flhpabnorjty5qjorlbp22honuscgpbteakgagg2tq@frqa6flk2mmv>
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-3-09a4338d93ef@quicinc.com>
 <CAA8EJppOR_UXoVpMt-dhfWdCz3UNfsXGdz8X9NqpaSmYj3AZDg@mail.gmail.com>
 <5ea14162-567b-462d-be02-b73b954b7507@quicinc.com>
 <5whv4z7u6fkfwlv5muox5dmv6fow4mga76ammapw7wph7vwv3f@xibcjdfqorgf>
 <iqcofcntirmlwcpyfr4yabymqfcgyrij57bibf337tmxpa73t6@npkt6wquenf6>
 <527baded-f348-48a8-81cd-3f84c0ff1077@quicinc.com>
 <t5vcjlf44fhae4f2h75cfs3f7r6tdstw4ysmkapvvawj6xp23x@xnxqnxvyhshe>
 <d5151b82-5f05-4826-99b4-e925c20550b4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5151b82-5f05-4826-99b4-e925c20550b4@quicinc.com>

On Wed, Dec 11, 2024 at 08:50:02PM +0800, Xiangxu Yin wrote:
> 
> 
> On 12/11/2024 5:46 PM, Dmitry Baryshkov wrote:
> > On Wed, Dec 11, 2024 at 08:46:16AM +0800, Xiangxu Yin wrote:
> >>
> >>
> >> On 12/10/2024 11:09 PM, Dmitry Baryshkov wrote:
> >>> On Thu, Dec 05, 2024 at 08:31:24PM +0200, Dmitry Baryshkov wrote:
> >>>> On Thu, Dec 05, 2024 at 09:26:47PM +0800, Xiangxu Yin wrote:
> >>>>>
> >>>>>
> >>>>> On 11/29/2024 10:33 PM, Dmitry Baryshkov wrote:
> >>>>>> On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
> >>>>>>>
> >>>>>>> Extended DP support for QCS615 USB or DP phy. Differentiated between
> >>>>>>> USBC and DP PHY using the match table’s type, dynamically generating
> >>>>>>> different types of cfg and layout attributes during initialization based
> >>>>>>> on this type. Static variables are stored in cfg, while parsed values
> >>>>>>> are organized into the layout structure.
> >>>>>>
> >>>>>> We didn't have an understanding / conclusion whether
> >>>>>> qcom,usb-ssphy-qmp-usb3-or-dp PHYs are actually a single device / PHY
> >>>>>> or two PHYs being placed next to each other. Could you please start
> >>>>>> your commit message by explaining it? Or even better, make that a part
> >>>>>> of the cover letter for a new series touching just the USBC PHY
> >>>>>> driver. DP changes don't have anything in common with the PHY changes,
> >>>>>> so you can split the series into two.
> >>>>>>
> >>>>> Before implement DP extension, we have discussed with abhinav and krishna about whether use combo, usbc or separate phy.
> >>>>
> >>>> What is "DP extension"?
> >>>>
> >> I'm sorry confusion casued by my description. It's means extend DP implemnt for USBC phy driver.
> >>>>>
> >>>>> We identified that DP and USB share some common controls for phy_mode and orientation.
> >>>>> Specifically, 'TCSR_USB3_0_DP_PHYMODE' controls who must use the lanes - USB or DP,
> >>>>> while PERIPH_SS_USB0_USB3PHY_PCS_MISC_TYPEC_CTRL controls the orientation.
> >>>>> It would be more efficient for a single driver to manage these controls. 
> >>>>
> >>>> The question is about the hardware, not about the driver.
> >>>>
> >>>>> Additionally, this PHY does not support Alt Mode, and the two control registers are located in separate address spaces. 
> >>>>> Therefore, even though the orientation for DP on this platform is always normal and connected to the video output board, 
> >>>>> we still decided to base it on the USBC extension.
> >>>>
> >>>> Could you please clarify, do usb3-or-dp PHYs support DP-over-USB-C? I
> >>>> thought that usbc-or-dp platforms support that, but they don't
> >>>> support DP+USB pin configuration. Note, the question is broader than
> >>>> just QCS615, it covers the PHY type itself.
> >>>>
> >>>> Also, is TCSR configuration read/write or read-only? Are we supposed to
> >>>> set the register from OS or are we supposed to read it and thus detemine
> >>>> the PHY mode?
> >>>
> >>> Any updates on these two topics?
> >>>
> >> Still confirming detail info with HW & design team.
> >> I’ll update the information that has been confirmed so far.
> >> This phy support DP-over-USB-C,but it's not support alt-mode which 2 lane work for DP, other 2 lane work for USB.
> >> TCSR phy mode is read/write reg and we can read for determine phy mode.
> > 
> > Ok, thanks for the explanation. From my point of view:
> > 
> > - Implement the DP PHY to be a part of the same driver. Each device
> >   supported by the usbc driver should get both PHYs.
> > 
> > - Make sure not to break the ABI: #phy-cells = <0> should still work and
> >   return USB PHY, keeping backwards compatibility. Newer devices or
> >   upgraded DT for old devices should return USB PHY for <... 0> and DP
> >   PHY for <... 1>.
> > 
> Yes, currently we have implemented like your description,
> Each deivce shoud get both PHYs, DP PHY for <... 1> and USB PHY for <... 0>.

Please note the backwards compatibility clause.

> > - I'm not shure how to handle the USB and DP coexistence, especially in
> >   your case of the USB-or-DP PHY.
> > 
> For coexistence process:
> 
> When we start implement DP part, usb driver team said only need config TCSR phy mode and orientation during switch in USB-C port.
> Based on your previous comments avout SW_PWRDN, I'm confirming with the USB team whether SW_REST/SWPWRDN/START_CTRL registers might affect DP.

Thanks!

> Anyway, even though the original SoC design supports DP or USB over Type-C，
> but on QCS615 ADP AIR platform, there are only four USB-A port which works with 'qcs615-qmp-usb3-phy' driver, and no USB-C port.
> DP port is mappped from usb pin to the video out sub-board.
> so we are unable to verify the switching case between DP and USB devices under USB-C.

That's also fine. We will get to that point once MSM8998 / SDM660
get USB-C support (the only current blocker is the support for the
TYPEC block of the PMI8998).

> However, I'm also confirming whether anything other will affect USB and DP each other.

-- 
With best wishes
Dmitry

