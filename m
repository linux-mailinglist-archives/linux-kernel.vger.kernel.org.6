Return-Path: <linux-kernel+bounces-208720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C73C7902876
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF211F21DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A61494B9;
	Mon, 10 Jun 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBXCreDw"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28612F5B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043158; cv=none; b=WhIsWmo/Hqpn9x18540pQ1pGdeL1blcGW3SUOHuEkKkcl0a/rk1TwpLh93lJN/cyVv0DHuaMpx9lsqt9JUfkcWbTmRN/C4NjCLI5Xy93qTWDto2WSXQQnkpR29Qici0z/SYVVaPDvv7oVE7wFAO+fUIksUQz0vzZtIypIbmKCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043158; c=relaxed/simple;
	bh=TmYk8AQTt77I88b8Jz/JLqc7LmxM/K3bVUUXLSf/MFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzAW738MOb9K/yYy3y4u2hhdmNrmjSCV/UOv4CnHAl42PpjOsRUmAchDrTZCaJfGQ+/DwYe/zN5VpjkRaFNDHRO+eRisEFbueoM6cplFqTUVgZrcEj8+rNormfbNi/Mt8e9R3HQVUC3bks1prvkRde1nuVSPD8lVvKevVsmORcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBXCreDw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso10487131fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718043155; x=1718647955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1eyvHhcPEWgM5aVu/hiZDwHX5cRNXDZircOMLa2sfD8=;
        b=FBXCreDwKRje1BUo9+JZHZ4h2eZdb1N+LWmBD9aJ5BeG+IR11JSevZMHBPx6iCfofz
         EMSXDQtmBr/LI7Q/zYFMJ8XOwBomBMQVvNaf9OkVIUObHD0Mtej95R7ip8HePz5LXFo0
         NgOf8D0ZbWZtjVAOvfLiPaQWE82Q6uxvmYzkKzglZuthY3bDhXZMtL5Mj8igygbQTOeU
         XbLKQh+OuWHqG04eTSwlhjdZPhaNSxCQqQsERxudy74+L0EDgabacbD98GozqR2kCLjX
         teVRCizsbWgxgkHcQCh5pKlBeZC1gGS7dFBOi6vFZPHIifpUFZ/MWWdcaCG4+7hGk2Rc
         t67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043155; x=1718647955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eyvHhcPEWgM5aVu/hiZDwHX5cRNXDZircOMLa2sfD8=;
        b=v3Eg5itzCw08s9Udcx1iC3pm43pMrBOb43dvwbzSmCp+wtXfW7u7CmOTQjTKSyiLIU
         aav14uCQ8SkSDlxwF0h0F0U/RwF0hjAWDQVcEyzw/cuRbEgmOYa2otsAT87A+gAtXNb5
         YmH4x7nFc5OYCdyigLTpP4DCVHPgIS7/LNAh60KpkcNw0IUVYXf29Gt4U+Dg8h6xDZeQ
         BPjupzjQ31IyLHS+RKETKrKkaOHZYgNwAsBF4D4dZ8LmgeJN4A5KVRXo6XaIisGNehv9
         XM68lTQLLf3yj2e6fcADBM6u5oEGiO9BO5zXYDAbrYmYWEax4i3nzk0/1YygB19XJPEM
         BcNg==
X-Forwarded-Encrypted: i=1; AJvYcCXhU6Sfho14aXNUHqwoznOKV3Ym1K9IRwNIMWw61Tr6ubkJNIIflbMB8nIp3hq6T1A02F0hc9C6+Gb8kFNQiTR1MnkgxJEBo8iGrK9k
X-Gm-Message-State: AOJu0YwVq7GPB062u8HRS7UJBbnQkSddeq6DIeGMP7c5NM+6XKXd2qCm
	tqipXZgLz6UD6/2kWfZuRGDOaVBEZr75hIFyAq/80pQ+UPrFCl6Yrxu/vD4JLrM=
X-Google-Smtp-Source: AGHT+IHptFF4qjzY9OneEo387ydgbKnCmTpXLrXWpOn78SwqX3YAdGo0qVjscWhklES7rFVJ6YV8jg==
X-Received: by 2002:a2e:9eca:0:b0:2eb:e634:fee6 with SMTP id 38308e7fff4ca-2ebe634ff29mr24562661fa.18.1718043155042;
        Mon, 10 Jun 2024 11:12:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebdf286a1dsm9815661fa.65.2024.06.10.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:12:34 -0700 (PDT)
Date: Mon, 10 Jun 2024 21:12:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Das Srinagesh <quic_gurus@quicinc.com>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	Stephen Boyd <swboyd@chromium.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 11/14] dt-bindings: mfd: pm8008: rework binding
Message-ID: <5ecytnzonh2m4p2zpw5ms6ljjvlo3zkasce6tnhmal2twlo4i3@trf3f53bwdxt>
References: <20240529162958.18081-1-johan+linaro@kernel.org>
 <20240529162958.18081-12-johan+linaro@kernel.org>
 <d5omeycp4l3mrzgswga2jkgxydpiayqfdjavwnfswcojawiqkt@zuol3vvkao5r>
 <ZmR6hPVZsYlyC5o5@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmR6hPVZsYlyC5o5@hovoldconsulting.com>

On Sat, Jun 08, 2024 at 05:36:36PM +0200, Johan Hovold wrote:
> On Wed, Jun 05, 2024 at 11:43:16AM +0300, Dmitry Baryshkov wrote:
> > On Wed, May 29, 2024 at 06:29:55PM +0200, Johan Hovold wrote:
> > > Rework the pm8008 binding by dropping internal details like register
> > > offsets and interrupts and by adding the missing regulator and
> > > temperature alarm properties.
> > > 
> > > Note that child nodes are still used for pinctrl and regulator
> > > configuration.
> > > 
> > > Also note that the pinctrl state definition will be extended later and
> > > could eventually also be shared with other PMICs (e.g. by breaking out
> > > bits of qcom,pmic-gpio.yaml).
> > 
> > Obviously we want to adapt this style of bindings for the other PMICs
> > too. My main concern here are PMICs which have two kinds of controlled
> > pins: GPIOs and MPPs. With the existing bindings style those are
> > declared as two subdevices. What would be your suggested way to support
> > MPPs with the proposed kind of bindings?
> 
> As far as I understand newer PMICs do not have MPP blocks and we do not
> necessarily want to convert the existing bindings.

Well, I definitely want to do so.

> That said, if there is ever a need to describe two separate gpio blocks
> this can, for example, be done using subnodes on those PMICs.

This creates an asymmetry between older and newer PMICs. Wouldn't it be
better to always use gpios subnode for GPIO pins? This way older PMICS
will use the same approach _plus_ mpps {} subnode instead of having
either nothing or two subnodes.

The same approach probably applies to some other subdevices: temp-alarm
vs adc-tm, etc.

-- 
With best wishes
Dmitry

