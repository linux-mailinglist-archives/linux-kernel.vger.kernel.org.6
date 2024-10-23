Return-Path: <linux-kernel+bounces-377592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2FC9AC100
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6501F23F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39A315820E;
	Wed, 23 Oct 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPqLJ7hb"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EC158214
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670683; cv=none; b=b295PcQi4DhKJTF4xa+ZT+xxGu8ySHPMBtaOytGhBrz0VS+9pyYemZzRe/kb52TvvMz1pj0cuFu1vlIKWR/XIrk0jG2Z02W7juj9ZENgnnIunXzioUnoBQHVjzUjKuUwUv3+ZU8Zi69rX1nSgxDEDfQLJvOdtdkyUE9UCHOZMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670683; c=relaxed/simple;
	bh=D3CLnPGNyMPYexChlzYiATcbJjQtpiQCDkIqJ9Za0iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fchqqpvVekMD2gxJTxIfqTVLDcFoGCyu0QnMBn8s+QHG5vkw70hNX79SPLoFVzi9Gh4VhK2esVOssTzjSizMHLPIC6mEMnCHq5/OiD9PwWqDrJxSoYsvu6BoeIVo2PWiPj/43JFpNH5O0bl9Hcjds5edSFlLoxsbWHEyJD2aqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IPqLJ7hb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431616c23b5so4061225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729670680; x=1730275480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=640yGN5iXrEqvUdxBKaSevUog3GotXGjXCRRBnWHy3g=;
        b=IPqLJ7hb1FveSTwmjIe7kS+UpWXIzrhmmkTn+ZTH06BmuYfwciTYin89SOnBhiU0QG
         vhO2w524K/TV5n7z2yqeUIVPOiwx5VaENnTrR34omF6MI5UC++zvdrEKZxPcR8+wwEmX
         gFUO+JbqcA7sevHOHTu5TwdMsdo+mXohiF/Z54oIBZI0wMdzYyfY3UsvYU0y4j2LBBDF
         +pOX1Cynr5ROTlkBfeoJ3Txre1xqKashM1jq8eOkfZFikRdUcbM8QJr0Pslrsd1vrJaR
         eKCWwzAbtyFfH8iRvyE5DaL9ABnk/wkvKIj2XXiDsWPXlBaFIme1DXI72Z1bZ/uNi3hR
         SJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729670680; x=1730275480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=640yGN5iXrEqvUdxBKaSevUog3GotXGjXCRRBnWHy3g=;
        b=Ld+bDnRjH2U1ssWv6jICnq9hEhv2rsBXFYz10JS2zdxTJE2cG4a5QTKVGZ633JDamI
         weDTuv86cILjeruLgJQw0tan0FY0765V0tFR02ZMhR06YYlUzYIRLdpd6ZUTjCKRnSKG
         gibsDrMqHKpPFhNDqhD3v5wnLVqZcmYrx6x3R4lq5RxE7tKC3LjZghrMTsnBUudMsNkO
         hRrnEcjyAELX26zKg99upEJHtO2PVzxiQlWmJUbcThBihtY3TpJ8xO4MtfcEp8zvnCxO
         nsGNUZbPMSN5PZqiYMP2n5CaBGgU1TaCu1nNn8S6IEGs7fVwiiPmUgZebrCLAmL7OwUC
         VePA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7WASYdyOAFXChqgHJl8F0WIKouhLZrY9dqKrZyHFRCYYAO1GsJoPDET4L0XUT2RaOxiTk3NuDsPfgLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28ayBtNgcj9tvICPisUAs+zw21hLwSAcQNn2rPlGOs6qX8beO
	ZLf2olP4wippJ3+gENElZzPLHLlOcXVe0Rr7pxRsebPHpoOh26nnFNoCbK3e6NU=
X-Google-Smtp-Source: AGHT+IFlUcIPc5Wvs4vuda7h60x05vaE9/J6mhMXBYWyXTSxBGJ7z+3Tl3D+Tg2nAWfNAXyiFxqn4A==
X-Received: by 2002:a05:600c:1ca4:b0:431:55f3:d34e with SMTP id 5b1f17b1804b1-43184463c48mr9517185e9.15.1729670680010;
        Wed, 23 Oct 2024 01:04:40 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37ac4sm8429790f8f.6.2024.10.23.01.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:04:39 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:04:37 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: Add support for Parade PS8830 Type-C
 Retimer
Message-ID: <ZxiuFRFnZFlcdMPs@linaro.org>
References: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
 <20241004-x1e80100-ps8830-v2-2-5cd8008c8c40@linaro.org>
 <Zw5oEyMj6cPGFDEI@hovoldconsulting.com>
 <Zxdp2vHzREJAFkwj@linaro.org>
 <Zxif6vmh8BE_C-_n@hovoldconsulting.com>
 <ZximeTNi7huc95te@linaro.org>
 <ZxirM9HJELXGWVqv@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxirM9HJELXGWVqv@hovoldconsulting.com>

On 24-10-23 09:52:19, Johan Hovold wrote:
> On Wed, Oct 23, 2024 at 10:32:09AM +0300, Abel Vesa wrote:
> > On 24-10-23 09:04:10, Johan Hovold wrote:
> > > On Tue, Oct 22, 2024 at 12:01:14PM +0300, Abel Vesa wrote:
> > > > On 24-10-15 15:03:15, Johan Hovold wrote:
> > > > > On Fri, Oct 04, 2024 at 04:57:38PM +0300, Abel Vesa wrote:
> > > 
> > > > > > +	ret = ps8830_get_vregs(retimer);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	retimer->xo_clk = devm_clk_get(dev, "xo");
> > > > > > +	if (IS_ERR(retimer->xo_clk))
> > > > > > +		return dev_err_probe(dev, PTR_ERR(retimer->xo_clk),
> > > > > > +				     "failed to get xo clock\n");
> > > > > > +
> > > > > > +	retimer->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > > > > 
> > > > > The reset line is active low and should be described as such in DT. So
> > > > > here you want to request it as logically low if you want to deassert
> > > > > reset.
> > > > 
> > > > This is being reworked in v3 as we need to support cases where the
> > > > retimer has been left enabled and initialized by bootloader and we want
> > > > to keep that state until unplug event for the cold-plug orientation
> > > > to work properly.
> > > > 
> > > > On top of that, we don't want to deassert the reset here. We do that
> > > > via gpiod_set_value() call below, after the clocks and regulators have
> > > > been enabled.
> > > 
> > > Ok, but you should generally not drive an input high before powering on
> > > the device as that can damage the IC (more below).
> > 
> > This is just not true, generally. Think of top level XTALs which feed in
> > clocks (and can't be disabled) before ICs are enabled.
> 
> I'm talking about an I/O pin here, you must generally not drive those
> high before powering on the IC.
> 
> And AFAIU the same applies to clocks even though the risk of damage
> there is lower.

As I stated before, enabling (or rather preparing, from kernel's point
of view) will definitely glitch due to PLL switcing (unless the mux is
glitchless from design). And there is literally no risk of enabling or
keeping a clock enabled even if the consumer is powered off.

> 
> > > That is, in this case, you should not deassert reset before making sure
> > > the supplies are enabled.
> > 
> > Wrong. Even the data sheet of this retimer shows in the timigs plot the
> > reset as being asserted before the supplies are enabled.
> 
> Reset *asserted*, yes (i.e. pull to ground). Not *deasserted* (i.e.
> drive high) as you are doing here.

Oh, yeah, that has been fixed in v3 already. Also, this v2 version was
also wrong from active level point of view. Which is also fixed in v3.

> 
> > And generally speaking, the reset needs to be asserted before the
> > supplies are up, so that the IC doesn't start doing any work until
> > the SW decides it needs to.
> 
> Again, the problem is that you are *deasserting* reset before enabling
> the supplies.

Yep.

> 
> Johan

