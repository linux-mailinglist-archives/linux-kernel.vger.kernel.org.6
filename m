Return-Path: <linux-kernel+bounces-319505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0696FD7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BCB284238
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A171598E9;
	Fri,  6 Sep 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCOPJwq+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754015853A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658628; cv=none; b=t3FMuCZU75JVvrKdS72aZz9tr15Y3T+1W+48MP756ihYdpy70S6unekAK7njc/qksGtsSvOke3hyEq626ZLhniZGKA9h+JIHCPHxn+z5RjOMT3ZQNLnoYQw0hwFC9IVHD+VWUoXG6FfntCHhfPNlYL4icxmfDxN7my+lhSuyfdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658628; c=relaxed/simple;
	bh=0ZgKZs4rF3oVvAvJx+D4IPYRW/9ekQuSaC/jCDWEZ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaR2g4HU7/S9uRik0rR6/keEaq3G5An6njabBO84tLp/8l6puVq4/N+9vVGuRfLG/+obdXNw4F00RuIS30u9U5OU/NS9fPDCrXWJTVevWxF1Snt6iWWScIgdU3NAHTA/qi0uFH1bNTkW7WSXD7Xl4fraGfEDZed+/M9YqEuGkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCOPJwq+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365c512b00so691306e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725658625; x=1726263425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqhH3BWBw+AefsrmQfYYHhnyb9JUlap6lKEip60G6ow=;
        b=NCOPJwq+EpsQgtmQsqFsuVdlQuRq0YcemJBwtF2OV/8Yc89v7T2SY1nr846Nfemhmw
         zs5rlKUk9VPlCi2FWdTqt6oG1nkgmQiEbleHlJroUkaG693VL0hZq8MlMHb/YISfF9JW
         xWx+PKpUlROlrJNYEe5EWsKmMZYm05CHxUS0pXZYD0qkO7oojX815gNhJKsac21KZthE
         9NWTgpnVq+/8oScLyhrhia7HIak2/pk+rToBTe98PHROY2AHoWm+U6sv4szqm8M5tmrf
         TyvYdBTh9v3zPyrg3QPCUk4JOyfQgo86CkZJNPUWtnktSzGvL476di3UCeEthJgqJuVa
         Ki+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658625; x=1726263425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqhH3BWBw+AefsrmQfYYHhnyb9JUlap6lKEip60G6ow=;
        b=tmmiAfrgcPvMkuktU5MZ1r4WyPAU5LdbwqxcOOYN/vb3LbLycyIIBo6dOhV8Cdky13
         ypLwtlH7F6ve55q7NM3iWmvMQynhQkirS/FYAg6KemTFetQitMIkM+ebHjFDO/UQmusp
         /PnNVnqeFHZa8JolqqCnbIBSiSnlOZNrstaPkWTJKgOzxdDydewv00NMGo2LKKxER3/2
         dthN6/G66MY7ljw/DpLA3V0yRQXgvXoN0ivdyJTFz83hB8z79py46ikoYMpAmFUyoU9S
         QBmS4kban+QfucNqyUgBu4EHg33XX0NuOmvl65UHhGkx4bwtphAvvTZ6hM31Dor5ruaF
         ba9A==
X-Forwarded-Encrypted: i=1; AJvYcCUtzLAgxpVDY863iRccSilwLo8PZo/E0MjE54aXtIpb3BHW6C0ynVPSqRlR66je+J8nun5cvpbnzUZjoD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZGyq2Iq+yLr5ZNI7RvV5xw758+zozjYOIEV6tZRlaxe2eigd
	87Yu9N1spO9a+0GV47bOBk4VnKOha2cvmX2WNbMv0oJIGndtRwOhNcSNsqm2hkA=
X-Google-Smtp-Source: AGHT+IH+baugswl99mWw7eWQU7vn2q3bbqccxjOLIAxP3wxeEVM1/WxhpuQF6wNva2ks7ePoVer43Q==
X-Received: by 2002:a05:6512:124e:b0:533:3268:b959 with SMTP id 2adb3069b0e04-53658805f76mr2485245e87.53.1725658624038;
        Fri, 06 Sep 2024 14:37:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53654e344e1sm435576e87.232.2024.09.06.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:37:03 -0700 (PDT)
Date: Sat, 7 Sep 2024 00:37:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Baryshkov <dbaryshkov@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, ath11k@lists.infradead.org
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc8280xp-crd: model the PMU of
 the on-board wcn6855
Message-ID: <on6dwkh3mjbc7dmz2ackkgqcmxpntr62aoduhkd5ue34y4vjhn@hscbtjerfhge>
References: <20240905122023.47251-1-brgl@bgdev.pl>
 <20240905122023.47251-2-brgl@bgdev.pl>
 <6vikrqhdnkefzpahhhtz2hpi62jvcwnzclm7touwtnpxdzvgrf@uc7r6a7bbjek>
 <CAMRc=MeijX2by+MS_vq_OVx25JO6z=zNfymta35h11mbm=vmtQ@mail.gmail.com>
 <CALT56yOP+un5nkxuirJVg=gr7fo4Hqjt1ew3z-=F2J_Y_RcTqg@mail.gmail.com>
 <CAMRc=Mci-8R1Oe3Fe+1E+K-7khzwBPgn_8SQSUPXthpE4032Pw@mail.gmail.com>
 <d6d5a943-ab29-4034-b465-b62d9d1efa61@kernel.org>
 <87v7zagcyf.fsf@kernel.org>
 <ywn7bq6j6jgokwmm3vsumkuwijplezmery5tr6z5yeblnpyjh7@djkwdbt4sl3q>
 <ZtsXUyBRV9yDeq1P@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtsXUyBRV9yDeq1P@hovoldconsulting.com>

On Fri, Sep 06, 2024 at 04:53:07PM GMT, Johan Hovold wrote:
> On Thu, Sep 05, 2024 at 10:26:04PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Sep 05, 2024 at 09:41:44PM GMT, Kalle Valo wrote:
> 
> > > There have not been really any naming rules for the variant string, it
> > > just needs to be unique so that it doesn't conflict with other variant
> > > strings. What have you been thinking?
> > 
> > QC_8380_CRD (following DMI / Windows name) or QC_X1E80100_CRD (following
> > marketing name). Or maybe QTI_ instead of QC_. WDYT?
> 
> The x1e80100 uses ath12k and the calibration data was recently pushed to
> linux firmware (and does not use a calibration variant).
> 
> This thread is about sc8280xp and ath11k as I guess you've noticed by
> now.

Yes, I'm sorry for the possible confusion caused.

-- 
With best wishes
Dmitry

