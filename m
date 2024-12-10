Return-Path: <linux-kernel+bounces-439821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900279EB45A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D732E167F39
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF2C1B6539;
	Tue, 10 Dec 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v343TJ32"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E441AE01F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843366; cv=none; b=InQgliUap/LbTAJqXTwRaEEYjW3b2279X4IkIH+HhjULUGAoAtdW7Vu/EU5LND++lLEzO7VUQAcck9bMrK57E0NxPI0BU6W2k3hQp9KGmwOx9rSXVDaViux43aenXy+Ge2waVWl7UDgnz43ACincK1ubC7Yp6HQmQHYfeYlkzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843366; c=relaxed/simple;
	bh=80/01DvwhCk8ER/fRhyWLCJzR9PTogDCxXobO9F/RVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNLS2XCjcXi1sB0Y/FCq1fB0biELLW9Gv1jrn0KowXIDr6U8ILxRWjzRxXGgkjzyw8+MEFDATHhrc69N2thcwFxz5mXqJl1tvQEF+1/Q8fYz5hepRYXWoiewGaHs2bP+2BWk3HX4PMtwIPdevbsc62xnPPATYfk4egC7Xh9tpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v343TJ32; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3023c51146cso5322571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733843363; x=1734448163; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ONPoAWCr/z6lJfjDFKtgqfFAw1BGCZer+GCPiaXmPhw=;
        b=v343TJ323DUGi5/m5/FrFrr89Ph+Zv0XeBvNt5huqxBnTkff5QRbzRW4pZWUNVttAH
         Tlu95DPvvAHT6zUodswBHcvRf56JzyawVTfBR3dNWKdZBuljZlgr98bGiaYlYhsT2uPr
         gu2V6zwkFTh/b0OkdHryyJxrj6RtGPrHiLfKlc7gYXsQf9dCVs7btgZvkKZX6c2s7A5D
         j16flk5a/dCWOovI+7SnICyPlYr2x69lQCEDNw3b+KKPoQstS9stPw88m8Cgd+fcoYjM
         k5eTuUxolSI1b/X9ta78apmdeiOgLYvib+f/TqAunaMr6fsiBMlz4PwghoiKHHVF7aMN
         xuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843363; x=1734448163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONPoAWCr/z6lJfjDFKtgqfFAw1BGCZer+GCPiaXmPhw=;
        b=OIb3uBPWTyAV4cYu1vmG54Qp34JJvs1DEUEN4HjP5rUcpWklvvgaqVkZnlWGAHrb40
         pkACndw7goZ/wnKON+C88949wtpvcHl2TnAWm9Ny6L5TUtZFQwGzUn26o0NZPdFVPDEk
         +12bgY9hycq184tIYwgoSOvkHCkf672RHUdDiDSmTt6Be2ceIcCmVXM+x01JcOUCPhtv
         VI8rUuVylSHFYIIjsqZ6jU/BLxTkajNm7w6wSvS8B+POSEjf1AS8h16HMi8rvEJcL5TI
         8sNW3Is7Ffh3UQnIVBFafIXS5k32lyxYmL/37NhvJSD9VLLaL1yY433C3WhcgND4pKd/
         i+0w==
X-Forwarded-Encrypted: i=1; AJvYcCXTFd6nEdQ40jB2jk4vKIYZiywOGzRyzicJ15+nOu5axiT7IM9eL9EK0HPrWNTsFCbOlnOLsR8DthBSnis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpgq1XjL3Lub9D2aQV/09+c0BkG/1C6RAzii8nHaW0H/i2jpW
	cPDXX+IF0O9TQRaGmidfCJK5598siaooXuHF5JRUzkI367e20WHH9/CUQp7cxAo32AnC4uVAHK3
	MuGU=
X-Gm-Gg: ASbGnct9duph/MmsDCjTsNlAHOA978q/yImXqV2DHJFWcHtCd0jlOvbLj0q3Rob6QJ+
	5al9lFo44kuB2MTrGUCdF2i4FuUw8X8LSSZanIqFA390z/ME3Z2pU52Fc0gzwzBqF4+qrBNeXqA
	/Io4xPUDxfGOMV+jbVgOjrKI8MMozOQC1qTz6KroPR4hBMI4MweYteNBi+ge48IfWv0vammUdXT
	AxLICvuXbMo5/HXBO4FERYbPHoxzsu9APrNIuitKPgKBLX3umoAEPnvbqx5d8+POhZtpUJ7FKJM
	z9vR23vqgMI4izOcxAYk0fZVJsXKuBFsPw==
X-Google-Smtp-Source: AGHT+IH4LG5o5SbyEh1Vovj71WLwSfFbBGhk7NJh/k58qLpSj2p2TBBGrOFSDDq9rnPlmsaGShNmLg==
X-Received: by 2002:a2e:be0b:0:b0:2ff:b8f5:5a17 with SMTP id 38308e7fff4ca-3023282c1femr12568441fa.5.1733843363188;
        Tue, 10 Dec 2024 07:09:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-302259416c5sm5907321fa.6.2024.12.10.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:09:22 -0800 (PST)
Date: Tue, 10 Dec 2024 17:09:21 +0200
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
Message-ID: <iqcofcntirmlwcpyfr4yabymqfcgyrij57bibf337tmxpa73t6@npkt6wquenf6>
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-3-09a4338d93ef@quicinc.com>
 <CAA8EJppOR_UXoVpMt-dhfWdCz3UNfsXGdz8X9NqpaSmYj3AZDg@mail.gmail.com>
 <5ea14162-567b-462d-be02-b73b954b7507@quicinc.com>
 <5whv4z7u6fkfwlv5muox5dmv6fow4mga76ammapw7wph7vwv3f@xibcjdfqorgf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5whv4z7u6fkfwlv5muox5dmv6fow4mga76ammapw7wph7vwv3f@xibcjdfqorgf>

On Thu, Dec 05, 2024 at 08:31:24PM +0200, Dmitry Baryshkov wrote:
> On Thu, Dec 05, 2024 at 09:26:47PM +0800, Xiangxu Yin wrote:
> > 
> > 
> > On 11/29/2024 10:33 PM, Dmitry Baryshkov wrote:
> > > On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
> > >>
> > >> Extended DP support for QCS615 USB or DP phy. Differentiated between
> > >> USBC and DP PHY using the match table’s type, dynamically generating
> > >> different types of cfg and layout attributes during initialization based
> > >> on this type. Static variables are stored in cfg, while parsed values
> > >> are organized into the layout structure.
> > > 
> > > We didn't have an understanding / conclusion whether
> > > qcom,usb-ssphy-qmp-usb3-or-dp PHYs are actually a single device / PHY
> > > or two PHYs being placed next to each other. Could you please start
> > > your commit message by explaining it? Or even better, make that a part
> > > of the cover letter for a new series touching just the USBC PHY
> > > driver. DP changes don't have anything in common with the PHY changes,
> > > so you can split the series into two.
> > > 
> > Before implement DP extension, we have discussed with abhinav and krishna about whether use combo, usbc or separate phy.
> 
> What is "DP extension"?
> 
> > 
> > We identified that DP and USB share some common controls for phy_mode and orientation.
> > Specifically, 'TCSR_USB3_0_DP_PHYMODE' controls who must use the lanes - USB or DP,
> > while PERIPH_SS_USB0_USB3PHY_PCS_MISC_TYPEC_CTRL controls the orientation.
> > It would be more efficient for a single driver to manage these controls. 
> 
> The question is about the hardware, not about the driver.
> 
> > Additionally, this PHY does not support Alt Mode, and the two control registers are located in separate address spaces. 
> > Therefore, even though the orientation for DP on this platform is always normal and connected to the video output board, 
> > we still decided to base it on the USBC extension.
> 
> Could you please clarify, do usb3-or-dp PHYs support DP-over-USB-C? I
> thought that usbc-or-dp platforms support that, but they don't
> support DP+USB pin configuration. Note, the question is broader than
> just QCS615, it covers the PHY type itself.
> 
> Also, is TCSR configuration read/write or read-only? Are we supposed to
> set the register from OS or are we supposed to read it and thus detemine
> the PHY mode?

Any updates on these two topics?

-- 
With best wishes
Dmitry

