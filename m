Return-Path: <linux-kernel+bounces-352477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B10991FCC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F881F214F4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC3155C8C;
	Sun,  6 Oct 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+oUvJFg"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E234E167D80
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728234420; cv=none; b=Ef/4efuzY9/SnG+j8samJEk0zrwL/xcdO7AL33PMHtdDl5XZOwzlkc/qzugmUhvwsv4XRCne6Cc3FiqDUQYJ6uH+rSpz7RrDtRTwL3XzoFykYHDTRXlTJhfOhyt7NkmlM375u4r48i8wsr8QN0y0+1lalniDmUlvZpSotGZ2q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728234420; c=relaxed/simple;
	bh=QLZOPV2KCdW4/rWDe98NOGrenAixRMGh/7THynPfEIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNEqlq3kQgbzJhBIak7tYIgOXXpm4fx/xqhDV6DmyBxTmk3tJYTpK18PzNGTvkbG+ML5oiZdr4JptjFfiONG9WwF5P43fDcI0+8kJcuiYSL/527ahqvnnbIKwTZXf0NQjXgS/tFs6Va7oxEs43fQmSp+plXC/K7ReRwmYwzIz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+oUvJFg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so4400651e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728234417; x=1728839217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgiOfmVMYDxKqStonmB8yqlxiThjQt2okmdO+ALgRlI=;
        b=A+oUvJFgA5lkI1MqjlHMWHvUrr2Q3NZNBNkEif+GUNciuSuMALcCgyGH0ICBLZy5QX
         gg2H9GtMcq3zP7GXd3BPZBJEVqmZHqW1EMk8Yicb8jY5ihPg1ytxzxxpeaqNGixz19fC
         1Ox/CVZfI7GU8q7ooE1oLvAkJkjmq/0k5u9LJrjCiIOfhuI4J9JSjv1XA2wRxIypbZpx
         zatwDcI3SYOVU8tYTvwt/V0vguRzZkFTJav2P6NoUFSdRj78FnUY4ztpiNSJ+I+s3Z1P
         4MrcIvw+Jqe1kHqlWOZ/rHlsUJZ/oR84AQWOq9da+LCzn7xGWxEDDhYUie42XPra5Phj
         i6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728234417; x=1728839217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgiOfmVMYDxKqStonmB8yqlxiThjQt2okmdO+ALgRlI=;
        b=p4Uym4XfKdhzmSdWNWDTtA/ew/rils9qp04X/TGN4xdnLTNoZb6wmgkJ6n1Fe0fXnK
         Yl1J6UbvjecqzJPVZ8fPxjuF+JZHE83tDcugyCn6o6vua6SVjqrU4+FCC9JdYKMwDfcs
         qN8pG1ZPdrC0hhETSyPxiK7wRbjItA6gVPHU7o9P82Cg99tEeKgKCX9i8HYz/iVKlcAH
         nvn7rwKqFAZKE22VL695/oXfYWzLlTrjWjFkHTCb8ogt9p4BjDyW1BUeFZYZiYVIEpVT
         YjlQCfLMTYLRQHKM4AHbBsE17xIJr8sNq/SS1BV+oyofgdqLzK6iCjhUtMW0lljyBIVU
         Zwcg==
X-Forwarded-Encrypted: i=1; AJvYcCXxYHaRpW9RV8HjchwMhNrJuDnsVU6W9a8hMC7UPcAqmZvfULGqm40QQTW36EV8MNsTQUF09QruMuwv5rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2K0C+9+rzHgl6sigjGJeg0Z4PzWAPfusCL3J5agVL8TZ23xKy
	93m0FKeN327ga0AEBVVHbIO6IfCrnh3w6OZJK1bOBEiDGawRZVgxjPnRv0q5S2U=
X-Google-Smtp-Source: AGHT+IHffHfShn8xyefRkGtbG356/CbIEk2NFW/1Jb4Xs0sYFx6K0VNQHn+Ngf0TWbBmbX9M7T1xmQ==
X-Received: by 2002:a05:6512:398d:b0:539:8847:d7e9 with SMTP id 2adb3069b0e04-539ab8843c9mr4905244e87.35.1728234416966;
        Sun, 06 Oct 2024 10:06:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec8297sm559913e87.78.2024.10.06.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:06:56 -0700 (PDT)
Date: Sun, 6 Oct 2024 20:06:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org, krzk+dt@kernel.org, robh+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	conor+dt@kernel.org, abel.vesa@linaro.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add X1E001DE Snapdragon Devkit for
 Windows
Message-ID: <7ilh7yjdesoo3hwwjjlsnwe7dftegtv32mnwvsiczn33diwihy@mi2ukoowdq47>
References: <eqy4yicgeqlgaytgzybnitvbrdr7jmjjk5k2swmadad6scwk77@ubaf7a2kgmdm>
 <1BBC34CC-92D9-4F6E-8DFA-1F2DA36D545A@linaro.org>
 <20241001085105.iglzp3art5ysli2d@thinkpad>
 <b1d982c1-f800-97eb-1be3-e77e04a8e81d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d982c1-f800-97eb-1be3-e77e04a8e81d@quicinc.com>

On Sun, Oct 06, 2024 at 12:33:21AM GMT, Sibi Sankar wrote:
> 
> 
> On 10/1/24 14:21, Manivannan Sadhasivam wrote:
> > On Tue, Oct 01, 2024 at 09:56:30AM +0300, Dmitry Baryshkov wrote:
> > > On October 1, 2024 5:42:35 AM GMT+03:00, Bjorn Andersson <andersson@kernel.org> wrote:
> > > > On Wed, Sep 11, 2024 at 10:55:05AM GMT, Dmitry Baryshkov wrote:
> > > > > On Wed, Sep 11, 2024 at 01:03:37PM GMT, Sibi Sankar wrote:
> > > > [..]
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> > > > [..]
> > > > > > +
> > > > > > +&pcie5 {
> > > > > > +	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
> > > > > > +	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> > > > > > +
> > > > > > +	vddpe-3v3-supply = <&vreg_wwan>;
> > > > > 
> > > > > Please use pwrseq instead.
> > > > > 
> > > > 
> > > > What benefit is there to wrap a single 3.3V regulator in pwrseq driver?
> > > 
> > > First of all, is it really just a 3.3V? Second, is it actually powering up the host controller (as expressed in the device tree? Is it a power supply to the slot (in this case, I think, it should be expressed differently)? Or is it a power supply to the card itself?
> > > 
> > 
> > Yeah, we should get into the details here. We were not paying attention till
> > now, but with the advent of pwrseq, we should describe the power supply properly
> > in DT.
> > 
> > Here I believe the supply is to the PCIe Mini Card connector where a modem is
> > connected. In that case, 3.3v supply should be connected to 3.3Vaux of the
> > connector and we should have a generic pwrseq driver for the mini cards.
> > 
> 
> Hey Mani, Dmitry,
> 
> The schematics are identical to that of the X1E CRD with
> the exception of the pcie daughter card having the rtl8125g
> on it. Yes, the 3.3V supply is connected to the card as well.
> 
> Doesn't this mean all other x1e boards out there needs to be
> updated with pwrseq as well? Anway will get that addressed in
> v3.

Yes please. Check with Bartosz and Johan if they are working on pwrseq
for this platform by chance.

> 
> -Sibi
> 
> > Sibi, please verify the above in schematics.
> > 
> > - Mani

-- 
With best wishes
Dmitry

