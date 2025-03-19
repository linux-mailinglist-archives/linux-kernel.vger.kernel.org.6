Return-Path: <linux-kernel+bounces-567731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E4A689BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DDB188DF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E7253F14;
	Wed, 19 Mar 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEh1EOjj"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0A20ADFA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380510; cv=none; b=c0lPSljg5CIjVkRVpvkKw3EysJrVi7Wrg38I7U1CmioKXg2UGkxYPHfVgBcwz08t2ICk88YzvXtGJpBjhpTaQvtY5KEbRGZl2b+bNgCKGKCvwWdfEDf630uJPrXOts3AC9KW7HHZZaFmyW7geeszpC6pa+Ytc1pjWvQ2JegP6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380510; c=relaxed/simple;
	bh=KCsRkb8vN36baSyiy6rhEXHNSa5J+ZegQpsnCp9SCUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBeZ7KL3I8+Go++c5hI5Z5eCMC1l7iyOhq+l+bWvpM5LEFPlkDdGI/daEBxCkS9A28vZAsriMmGhWuEyWxJruFCnJA0EpVixtQc7f47Vu0Upj+WZp8z3pIz0xcUlf4Y/7h0MNwjlpYtp646orb8iD29oHMr8oETDg8pzPMfN3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dEh1EOjj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so9893601a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742380505; x=1742985305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJiELQ7SXzvhmTEHFyv/E/da9nG/EmOnRVtuGWlgjU0=;
        b=dEh1EOjj9qH7Ii15X81bYgkXUWds768UHhJHooKHo6IS4RV2WSAbAls26QnQ1zftD1
         rNcacrzwtCaavKnxPLgesX/t+W3dDFMx9Je6V8Nmwt5tK/VyTDEUkvCKX6CG8czWSEmT
         aAiafS+Oqf6uHnaccQeUIC+olGL6fA/rNx7K6ijBnEuf6hSuwe+uwfTqGegDKbMlJDxb
         ALDSA6lz4+9Wni/2cA06MNqvdXUWlPWPg3chYMRJlJNFXlh3NF77+yAH2madxptzXiyq
         VdzDFrNsm88AqdD/6SDxNTJ4TKMiOUrbtgA2C/Lr4KhSRMjGsy5udK+/uMc4qncUnbdF
         if+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380505; x=1742985305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJiELQ7SXzvhmTEHFyv/E/da9nG/EmOnRVtuGWlgjU0=;
        b=iBbSrRaS/J3WFJDqXW2mVe+xr9Sg7pLNVShyCxirPGTTetvcqFkCedkHNbnpboXoOe
         iC3wZ2ds+2SSlZuebgdFyCqtWtgwHqcf8dpccvTmWoCkGpiuIWcpRq2oKJoF9uo88QCK
         Zwsmkw65p8aWsp6f/NO4SfIXNBOhSkS+czvRVhGvNob3ChnT1o8aFEjeOmxuSxmYceQY
         VPkhqGs8PoFjnh1C5g5Oeb0LkYMVuWMbN0wt8ePGzCdnppQYjmthKfc1o07Z1wX1BMFG
         10PCXDh/nu8tih2ALIKvW+o5zuOLN4WgudI/JbSti+FzRXL2OoSZu3AY5LuksJ0RVHVo
         DECg==
X-Forwarded-Encrypted: i=1; AJvYcCUBIgRSPTYw6bsUqU5JVKjQmuJtKBHjfRyDr2yd7nySo+xMgB28iErBKAalEDhq/YfeKNe0bvsjv2/9PGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIDcGByLMh6bgADKkHYNN2je47qI98OgtO+raVh0NiVXkEifN
	p9VLRRmbCcVbZNVDY0pzZlEQvflEkFMc20gwk0KQZasY1seip3NAh5fWjMVX488=
X-Gm-Gg: ASbGncurwisNZGEJEdV2t9pbTRTolqMMQhQ/MDq8VhScQmUKmVmyqinp1dyO5xE4H9M
	EhJFKBg5oScMBh20A+nDQjOH1nr7X3R65yzWpbPZR9HHgOXFmPe4eI1FzvxtUPP8ggkdXi0eHSC
	lCiUI8ZKdKfzXaSYhZ2QIjU+QAbrCeVOj2fp37aNiXMUlYmTA4DLb4+ND5yGgD92Us5pEH368hD
	/HDR7CGdi1440723jc0mI+81eZTenhIUhZNIR4/X4kY/gRFupOqGH3MHhJcmz4+Z8N2GtPxgfC1
	TDfqDW8rK6MCZp8wSBl0PgOwRex+CSQU1iF9iaSxvQg3d5+pvgCadEgeA7Iq9Co4Dac=
X-Google-Smtp-Source: AGHT+IF/qM0/SASBIGdjRrvuMPa5qGcIobujWIpo2w87RLiD6k2szichS0jUQdcbOxhJtXSDIis2vg==
X-Received: by 2002:a17:906:d7cb:b0:abb:9d27:290b with SMTP id a640c23a62f3a-ac3b7adcbb3mr239283966b.9.1742380505236;
        Wed, 19 Mar 2025 03:35:05 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:1274:3124:56cf:f607])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf09dsm971492966b.121.2025.03.19.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:35:04 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:35:00 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	bjorn.andersson@oss.qualcomm.com
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: qcom: phy-qcom-snps-eusb2: Make repeater
 optional
Message-ID: <Z9qd1GJ1418CbaOt@linaro.org>
References: <20250318-xps13-fingerprint-v1-0-fbb02d5a34a7@oss.qualcomm.com>
 <20250318-xps13-fingerprint-v1-1-fbb02d5a34a7@oss.qualcomm.com>
 <6yykvszzbhonc3dkwhva55arsdvp4hv4p2fo2vv6ftwr46httm@wnofgs4jaqaa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6yykvszzbhonc3dkwhva55arsdvp4hv4p2fo2vv6ftwr46httm@wnofgs4jaqaa>

On Wed, Mar 19, 2025 at 12:20:07PM +0200, Dmitry Baryshkov wrote:
> On Tue, Mar 18, 2025 at 10:22:56PM -0500, Bjorn Andersson via B4 Relay wrote:
> > From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > 
> > In a multiport configuration based on the SNPS eUSB2 PHY it's not
> > necessary that all ports are connected to something.
> > 
> > While this is allowed by the Devicetree binding, the implementation
> > current fails probing for such PHYs, which also prevents the multiport
> > controller from probing.
> > 
> > The lack of repeater does not alter the fact that the PHY is there and
> > attempts at describing only the used PHYs in Devicetree results in
> > failures to initialize the USB controller.
> > 
> > Make the repeater optional, to allow the these PHYs to be described in
> > the DeviceTree and for the associated multiport controller to operate
> > the other ports.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > index 1484691a41d59a7eaf257ef44300827c668bf7e0..8897d2072ccfcaa5b4a510c17761dcdeed5bad0f 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > @@ -401,9 +401,13 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
> >  				     "failed to get regulator supplies\n");
> >  
> >  	phy->repeater = devm_of_phy_get_by_index(dev, np, 0);
> > -	if (IS_ERR(phy->repeater))
> > -		return dev_err_probe(dev, PTR_ERR(phy->repeater),
> > -				     "failed to get repeater\n");
> > +	if (IS_ERR(phy->repeater)) {
> > +		if (PTR_ERR(phy->repeater) == -ENODEV)
> > +			phy->repeater = NULL;
> > +		else
> > +			return dev_err_probe(dev, PTR_ERR(phy->repeater),
> > +					     "failed to get repeater\n");
> 
> Can you use devm_of_phy_optional_get() or devm_phy_optional_get()
> instead?
> 

There is such a patch from Ivaylo already [1].

@Ivaylo: Are you planning to re-spin that patch set? Might be even worth
putting that patch first / sending it separately, since Neil pointed out
there that the bindings already have the repeater as non-required.

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/20250223122227.725233-6-ivo.ivanov.ivanov1@gmail.com/

