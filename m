Return-Path: <linux-kernel+bounces-243961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B637929D12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE51C20F42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8862032D;
	Mon,  8 Jul 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LX5YplkN"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48D1EF1D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423865; cv=none; b=f2/hK8kWWkTMp959qdcssc2Jp9S9LgEMAlsDjbE2PhxBcw34FLdFp2waZxuUKE2MjIkd5ae2DARNWlsim4JR9jUcGGRWD6+6izUJdxeC/IPWUH2zRip4qDGPr4JBvGl6YF4YyWWNJdSuGuEmOWZy5Nhv+7zz+b+uL27fm150YOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423865; c=relaxed/simple;
	bh=/s9HlacpNrNPP0c5UiPoRGiSI9dEtk238RuQ1sql0bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vqsnv7CJ0QrkYttgYI8M6ph1XDGcEoqc+LCVzjajE0dzM/7pIIb61pdIcRlOww5Rfr07/6+zXrIMVZSK68eFuD4wwx37De0fWJ9+98SlX3OTYVapnMakcoG32sKQi5wwao4BA7BY6FQU7DWdd7DZl49Ycpfm69HORkqsyQkXe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LX5YplkN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af22a9c19so2609139b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720423863; x=1721028663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04lokAIK2DVm70h6hbqWf0NOWgMsHej24fV9dG9TpGQ=;
        b=LX5YplkNPTf6iBxByvI/YisWMMNG5HUTcRgCtHGkMlZDNVXgXqnwvRvuNHZygdP3ug
         i0AyGRRayzak4SspTm1dkNpLvGrnhG17LNnuR1a3kFSpUZe0ucD2K8snAhbvSCKFnyny
         BF8N9pB9CFO/7lBzBZ/0crn9+PhCO2wfhZG95iCzQZE+sbnXMI1yf3Ou74zlt2tZO5HT
         rKj3q2OTqsTiP8LMs4m9dHcsybP98/k/qBtersmKiIO3gkEhRaPJSwtHg+D7NsWQYrD1
         YGDPnUvPa3w8zOQqCoPsU9zS8jKB5ZW/v5Tn2yIN6y/LePS04InOAIjma7ixlIZaW26M
         2RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720423863; x=1721028663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04lokAIK2DVm70h6hbqWf0NOWgMsHej24fV9dG9TpGQ=;
        b=hwYwB8rblLj5XA93ydbHvqWp4EX0FOuzfPJ3E1Df6IsQTE6ZmgbXYTApzq61hyfgmu
         ygY/eqVoi0wwO9xMafKyevqbqYadkSq3NRE9nTdHYSMeuIgq1hs2wwykww+X0V/bJbi8
         dwy8RK5pNS7tSjbsVT/Lrpx8BCFVD4x4YSydHYcMvJg/FBoNSG6xvFrdHYC9pX+jPyYu
         aWkv1sQY8wrHX/GyonNF9wS5NNs6IUT8Pw4c0GSdnw3kIJLddUWwi4yce77RSOeVhShU
         /vmm6v1DRo9/8jt29EmKe5jzNviYpUlPNuC5juzXqbqbW9gi3K2egpHRS0Puf6FOzAz+
         1BoA==
X-Forwarded-Encrypted: i=1; AJvYcCUJfgoU0629Ykfakwh/8btxjkklA3/eBW9pgn4OYqGWEedcq6nxUNPcCnCyt/6MhcMy3ErjRKYwLM6ivFAS/fNbJmDYtVxMkEQE6wWi
X-Gm-Message-State: AOJu0YzaDx3nIAx4wrtplph+XaqhPzp70bptZNDGP1v61GMDWeBKK8b1
	C0ZJknu5KYhDSkXIz4UkuWRf0K3Y81Ba+9pqTJ/KDFOnbMnpHa+8VtGmQj195w==
X-Google-Smtp-Source: AGHT+IFvv4Pd7VFYbG7eiH8oQ+wjcz5+hLqwrySLRnKEQOV+ru7qYsGROLS6HSONsNK2yfhu4Y9Keg==
X-Received: by 2002:a05:6a00:4b16:b0:704:2f65:4996 with SMTP id d2e1a72fcca58-70b00948508mr15015215b3a.11.1720423862588;
        Mon, 08 Jul 2024 00:31:02 -0700 (PDT)
Received: from thinkpad ([120.56.204.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b0d368d7csm5810667b3a.49.2024.07.08.00.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:31:02 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:00:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
Message-ID: <20240708073056.GC3866@thinkpad>
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>

On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wrote:
> The Controller driver is the parent device of the PCIe host bridge,
> PCI-PCI bridge and PCIe endpoint as shown below.
> 
>         PCIe controller(Top level parent & parent of host bridge)
>                         |
>                         v
>         PCIe Host bridge(Parent of PCI-PCI bridge)
>                         |
>                         v
>         PCI-PCI bridge(Parent of endpoint driver)
>                         |
>                         v
>                 PCIe endpoint driver
> 
> Now, when the controller device goes to runtime suspend, PM framework
> will check the runtime PM state of the child device (host bridge) and
> will find it to be disabled. So it will allow the parent (controller
> device) to go to runtime suspend. Only if the child device's state was
> 'active' it will prevent the parent to get suspended.
> 
> Since runtime PM is disabled for host bridge, the state of the child
> devices under the host bridge is not taken into account by PM framework
> for the top level parent, PCIe controller. So PM framework, allows
> the controller driver to enter runtime PM irrespective of the state
> of the devices under the host bridge. And this causes the topology
> breakage and also possible PM issues like controller driver goes to
> runtime suspend while endpoint driver is doing some transfers.
> 
> So enable runtime PM for the host bridge, so that controller driver
> goes to suspend only when all child devices goes to runtime suspend.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Note to the maintainers: This patch should be applied at the start of the RC
window to give enough testing in linux-next since it touches the PM of all host
bridges.

- Mani

> ---
> Changes in v4:
> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
> Changes in v3:
> - Moved the runtime API call's from the dwc driver to PCI framework
>   as it is applicable for all (suggested by mani)
> - Updated the commit message.
> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
> Changes in v2:
> - Updated commit message as suggested by mani.
> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
> ---
> 
> ---
>  drivers/pci/probe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565..fd49563a44d9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  	}
>  
>  	pci_bus_add_devices(bus);
> +
> +	pm_runtime_set_active(&bridge->dev);
> +	devm_pm_runtime_enable(&bridge->dev);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_host_probe);
> 
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240708-runtime_pm-978ccbca6130
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

