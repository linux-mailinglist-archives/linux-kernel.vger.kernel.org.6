Return-Path: <linux-kernel+bounces-371503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C089A3BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB4E2812CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B4202625;
	Fri, 18 Oct 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="za/PuNel"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B620126E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248534; cv=none; b=gSZWtUbd4ir9KYzClYe52aKaDTvD3AffJhxkVjBJkcWBEKj9ZDO85BxybeUMmbKvkpW11v0F/KPRGvgCcM9xVaYeSzeqtq5ZBV0YmN8WzIRUAxOMP9JXtDqK3K1V7myfBoce4uJsVPW0cUfs+bz9pq8ntG1o5mDWrWFzHEVXneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248534; c=relaxed/simple;
	bh=UOflmbQ1LxMt8jWk7AGI/4KA17EvSwoQbdN0huIXq6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCZLXyg+cRwHUajGzdVQp6+nYh6Dq0+q50jtbTof/73OcFQQut7ICkYH5y6pppSERJkA7XRPxk474ZXFfsXPlRP+BS/iP9a/UpUnE8ABXKAoY3DEAWC/2fUpKxx9aXp+KgOpXr/yecAekJnR84vazjQB3ZDNxO+5l4ackYQZj+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=za/PuNel; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso22602051fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729248531; x=1729853331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlBIkgXoHUpGGxgUzabtKImK+2Y3lnlNINbK3gk3Nz4=;
        b=za/PuNeltkuy3G4RY5QF3XrOPK8c3g9ZUbyHns/X+eBdi1LqDqXAlyOKTskd9biO+K
         U9dDrTyNXFHsmj8PzIa+LrT/BWmuY7haaLMbemM4/mTLcga/o9sDYwUcoRuXbK+g7QZU
         nWVzbVKEIdzQbyvoYTvG7z0e/6fhEa+IvW1IjAmfyrtuMGlm7WHhffcOWsypCzHv+xiC
         VQQ97hnf1oeaENY/kDvAOn0jSkqln+eF1HLi4Sb30oCh+WC87dqr2RuLgPx1vkpLDDZw
         OnomRlBY3MnXtm1g9RkFQUfwC5WhVIG4KEMm8ML+fc23M73sLFNvZVgF9W5EZZ9Te3yw
         sHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248531; x=1729853331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlBIkgXoHUpGGxgUzabtKImK+2Y3lnlNINbK3gk3Nz4=;
        b=rsbQz99KDAIT62dUkBbXNrk6tQ2Sxq2mPmuqmYC4JBzFrY0bDThc8N7jiAvbEhEsJl
         /xtFinKYhbVbMFaWeIkDW39W0CvJfAe0uCek0WnAbsZXsH8MkM/HyR0DbNH7CzD6cQVp
         psZEZEFtXVYhd0uOW6aa96sp9nROEnaxHjKoBN4rd4UouBYvsqJFVddL4wK4YhrSOxPY
         Mp1uXrQ5XN1uoegebdRHHKb5ozPXusBqAGSf0s4GUx5odsbOcMeeZMyexnCN0A+h2D0U
         jd+D8Aw7/iUAbpdDmoA/C2a635BdB0avCGacLxI70x42OlECY1gRYLwwuiVQoa6Xc7gF
         Bm/g==
X-Forwarded-Encrypted: i=1; AJvYcCXfP6cu0m528uvRt67JqkLG0I6erO6GD8+CP3PyGtguicwOfuL33IRIiiws7HwSldVWMeyz3f9dnd+qgeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxeIPgB4Ur2sGKEF5YUO5Txc1x48l8i1Iz9YpoZ12CAWLTaHD
	vMoa298cT53iyPJGx57CyuCwmdZMZ5Rz48wYSVTlYr9xllo6HGBBtqXDHMU6lXU=
X-Google-Smtp-Source: AGHT+IF2/mMJKN4qJLCEm6+7VHHGgg8ckR5wYi1E0HptcP5qqGwJ+gSkEFi6bLWEeVPwTURdIQKZVQ==
X-Received: by 2002:a05:651c:b0e:b0:2fb:6198:d22b with SMTP id 38308e7fff4ca-2fb82eaf011mr10625731fa.17.1729248531088;
        Fri, 18 Oct 2024 03:48:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809a6a7dsm1864591fa.10.2024.10.18.03.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:48:49 -0700 (PDT)
Date: Fri, 18 Oct 2024 13:48:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v2 4/5] phy: qcom-qusb2: Add support for QCS615
Message-ID: <47w4t45mtools7wwd2q5ak6te63e57wk22eqvixeljh3cjg3wh@hxcm3xwgyna6>
References: <20241017130701.3301785-1-quic_kriskura@quicinc.com>
 <20241017130701.3301785-5-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017130701.3301785-5-quic_kriskura@quicinc.com>

On Thu, Oct 17, 2024 at 06:37:00PM +0530, Krishna Kurapati wrote:
> Add init sequence and phy configuration for QCS615.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

