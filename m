Return-Path: <linux-kernel+bounces-350229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B949901CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207251F2356B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64459156C5E;
	Fri,  4 Oct 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ38FyTj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DF146D65
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039850; cv=none; b=Po8VB51nqvtpF81cMTHnjwphL08E1Qhbc59eHtSpJYfcspfXDl7Zk74ek46cQX6e7TkMnL40RYK5+7b8HXAGJ8wdYBqugsAugbP1+HGvYEsxBDmajMc/Ub7yhGbywp5FcpjquiadPFXkFQfp3+hBKjOO4+AMV/Wjd21lkNKzUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039850; c=relaxed/simple;
	bh=pFXxe/yUZKlzZQPRtsT1o1siyG3tjwsMkTygaR/xRGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3Wxp2GGoHJv08syBpFCO9TULclvFUySWtaJVaxb51B9roLhN4MY6ZSdFkcgyvQ3LVl7qsBhYcaAmiwnDUyoadMkfmW9DD3nN/Nr5TYGg/CXTjrrA0QJ7j3ss8dltG33bQ1RyX0fTvd/HSBIZOLz0CtJuv/fsHtvRtDRnzd5NL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJ38FyTj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398939d29eso2522420e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728039847; x=1728644647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HseLO/WaTB/fjB3bbmzH9nd+LvPABDmeFCtM4k+UA88=;
        b=lJ38FyTjevDr/gq4Y1RCMeJFcty5OdlsvoYmC44PVJIz1DvMlKAiC9WXSKa+r7PNml
         x+OArr4uTrgvKrWP1TDq048Sxd9TunBRn5VHZiOXJOIDoeXiI6Uqv4XCJIJwjq6VkdMU
         b9YN9u+u3nmWcUemdJYEnjEXjTrBfk80fHyhgOi9+aqncjyGH+6gdWZ+njUmo5pirfAQ
         CGufx6MwwcajIQ7SVhofmLxv09ZNFsecVnE1Qst3KwpcxgbyW0Qom2rRtalGlW9go2PC
         k1fXr8ehZvT1JG0D8ymbZMDzQ9FgUik1QmwCAPSUxg4cc8npw/aylUrJ6vnbGd7F51Zf
         uBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728039847; x=1728644647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HseLO/WaTB/fjB3bbmzH9nd+LvPABDmeFCtM4k+UA88=;
        b=WaCv++NKtPCyu7m2uGAtOPDcCHRyM2nr/DgySwleBvqDe4LfX4RlirfF4oC4JqmeTc
         GYQJQ1N+6j2h8j+nN/pY73ifuplMTo8eQw3lx//jFqi77H5foqIT0MUVHOZi1hY1v0pZ
         H49omTWnuQQazznNh5hSJ8n9u2X/7zYHPqTjoOkYhQqgnjnt9MmZIn/MYq47VpP31dPb
         8qJCIA2qLsj/QQ1MYd70i8tzn7hsBL04II3DAgjIPdmSez0pNgTAUd65wswq+N8QUNdo
         ppsFR7PKcOJF2+a9TCAS2iEzVmgknQb/H+bDx42f63ZOOS/9QQzUOibhZPYYcTqMKlWU
         MecQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVdKo981PI/0K0CVRaX3sQqzj2/skP0hIHe2PrFGh7a06jQWQP7eh6VY2WWYUyO3XQIlmKsQEfcNAIJTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYD9HiufSIdaAKpgAG12U+ur/EyiVJpkUs/7VHWdZBB/Za+cL
	AuzBIVjQ9gnw+qHYXFSkWDfTwJelES6HanAcJAQ+HMyfVXF20GDtUzp40lWOPHA=
X-Google-Smtp-Source: AGHT+IGdUPJ0kntVLqGy38/xVOfnhtlhCAG5dhoWW0n7t+wosHXX10r29uCX8RKPxTxaIWkYlo/tmw==
X-Received: by 2002:a05:6512:31c4:b0:539:8f68:e034 with SMTP id 2adb3069b0e04-539ab8c888cmr1283317e87.54.1728039846982;
        Fri, 04 Oct 2024 04:04:06 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:e3b7:7a6d:7c39:3d94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b36d0sm211170566b.137.2024.10.04.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 04:04:06 -0700 (PDT)
Date: Fri, 4 Oct 2024 13:04:02 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sc8280xp-x13s: model the PMU of
 the on-board wcn6855
Message-ID: <Zv_Lok1BT1Hg13dC@linaro.org>
References: <20240930103041.49229-1-brgl@bgdev.pl>
 <20240930103041.49229-4-brgl@bgdev.pl>
 <Zv565olMDDGHyYVt@hovoldconsulting.com>
 <CAMRc=Mc9jMe=hSXmcRLLX61abUjetCRZVeOK3G31vdx5JQNNMQ@mail.gmail.com>
 <CAMRc=Mde8rGT+81ViTX0Qj2sDrD59dkLHeUZd1xkWO_H=QvC0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mde8rGT+81ViTX0Qj2sDrD59dkLHeUZd1xkWO_H=QvC0Q@mail.gmail.com>

On Thu, Oct 03, 2024 at 05:16:59AM -0700, Bartosz Golaszewski wrote:
> On Thu, 3 Oct 2024 13:38:35 +0200, Bartosz Golaszewski <brgl@bgdev.pl> said:
> > On Thu, Oct 3, 2024 at 1:07 PM Johan Hovold <johan@kernel.org> wrote:
> >>
> >> Without this patch I'm seeing an indefinite probe deferral with
> >> 6.12-rc1:
> >>
> >>         platform 1c00000.pcie:pcie@0:wifi@0: deferred probe pending: pci-pwrctl-pwrseq: Failed to get the power sequencer
> >>
> >> Can you please look into that and make sure that the existing DT
> >> continues to work without such warnings.
> >>
> >
> > Ah, dammit, I missed the fact that X13s already has this node defined
> > so PCI pwrctl will consume it and try to get the power sequencer
> > handle. I'm wondering how to tackle it though... It will most likely
> > require some kind of a driver quirk where we check if we have the PMU
> > node and if not, then don't try to set up power sequencing. Any other
> > ideas?
> >
> 
> This is untested but would it make sense?
> 
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> index a23a4312574b..071ee77c763d 100644
> --- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2024 Linaro Ltd.
>   */
> 
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> @@ -87,7 +88,31 @@ static struct platform_driver pci_pwrctl_pwrseq_driver = {
>  	},
>  	.probe = pci_pwrctl_pwrseq_probe,
>  };
> -module_platform_driver(pci_pwrctl_pwrseq_driver);
> +
> +static int __init pci_pwrctl_pwrseq_init(void)
> +{
> +	/*
> +	 * Old device trees for the Lenovo X13s have the "pci17cb,1103" node
> +	 * defined but don't use power sequencing yet. If we register this
> +	 * driver, it will match against this node and lead to emitting of
> +	 * a warning in the kernel log when we cannot get the power sequencing
> +	 * handle. Let's skip registering the platform driver if we're on X13s
> +	 * but don't have the PMU node.
> +	 */
> +	if (of_machine_is_compatible("lenovo,thinkpad-x13s")) {
> +		struct device_node *dn __free(device_node) =
> +			of_find_compatible_node(NULL, NULL, "qcom,wcn6855-pmu");
> +		if (!dn)
> +			return 0;
> +	}
> +
> +	return platform_driver_register(&pci_pwrctl_pwrseq_driver);
> +}
> +
> +static void __exit pci_pwrctl_pwrseq_exit(void)
> +{
> +	platform_driver_unregister(&pci_pwrctl_pwrseq_driver);
> +}
> 
>  MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
>  MODULE_DESCRIPTION("Generic PCI Power Control module for power
> sequenced devices");
> 
> X13s is the only platform that would use one of the compatibles supported by
> this driver before power sequencing so it should be a one-off quirk.
> 

I'm guessing the pci17cb,1107 node in x1e80100-lenovo-yoga-slim7x is
also affected?

Maybe you can check if the node has one of the -supply properties and
return -ENODEV from pci_pwrctl_pwrseq_probe() otherwise?

Thanks,
Stephan

