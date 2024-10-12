Return-Path: <linux-kernel+bounces-362069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C2999B081
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130581F23101
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C0126C09;
	Sat, 12 Oct 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDypJi7W"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4C3FBA7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705030; cv=none; b=Hwezc2QAVcdDX0LI0Sb1I13G/PaTVx75e0tumpUoXGN2b0m05RGC9QI4jaa+cANTaT40Rhx0H52vpchZ83bBTJXipc26QfLsZFREL8Vh+P2Q9LtczUb0UmjT/QyIjIpYqFeiSwl0EWcdD67c1tyW0Gmsq0Uw5+IMJyYAxNiehwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705030; c=relaxed/simple;
	bh=RnF7ivMfvnzgzM8pebBvusg9gGe6XuwcoPNE0AkgY7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQymJj521+WIJCZtceEFLp78vaqfW7Hou61C+Ou8QnDe8FltBZothv/HNgIM3Jr20XF4LHsTGzOAtqaNDKnQRWiz7+CneFdHwT2fbNTIoYG8qztTHoVLBMTayvtZGOeeKIiN+ssfkJ+dvmKUo19ktCa62vMkrSOR+SeCz7UfpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wDypJi7W; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e427e29c7so656589b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728705028; x=1729309828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7xd2XYFri8DksBYctsP4y3C7irgIPUJgSkvRCB5K9O8=;
        b=wDypJi7WA+KqV0j52JVPtxh/Rfc5yhBm8+3/4Sd+7mad0tTXZhVIgjFvyzM5ApeSd+
         57UaLp10+h0sIhpVWpJkkK+D8d1VE1euQISRQ78Og890+lO5zI6iCMhol+omkqBnL2RB
         tgOcdMB5siPnjRJ9ul65aYsXb1w087KEyAloBO4cDGL1+mrr34e0YS7Nhj0E3j3MsqpX
         NxXz15WwWUhBgr5xZG6trecWJyg8mB8oArglki2HgW70CNQ1vdn4EiEhnB0PcFKy7bi3
         jjGYOGHGrxXU/i+TiA2R9LxhahO7fDYfC0nhNp4y6xHtwQRVBpDoYZwNtbqfjJOH62J3
         F+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728705028; x=1729309828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xd2XYFri8DksBYctsP4y3C7irgIPUJgSkvRCB5K9O8=;
        b=Ep/SzmC7f3R5gc9++596FSVBQO3UCC9umSQc2Jm/Up11Xf48foIejJmNcmUIUm/V/y
         WobuJR919O8+k7ulqHL7Vr3rvISj2J7C0RCdDtN8gjD+yh61DZXa6w5RibL7HqBSPZTk
         waPCrFOS49sdhA82EI1peQ0h8E+9tzoHS4lJW4oDY49YVWELCMgDhRpltPgGWB9iDdYQ
         e00iD0iAY4Ahg5h0hnihk8BpmQyxY9WQ5xm+xoLxBsPpUXXaMFGzWT1AZL+wdzuLt18k
         vBp3h9V5/zS6FCie3A5GvkHzPYG/k+o6pu1uxgAk6ZqlnwE7GzRKDV+JoLa8Q1Ykjen0
         HuBg==
X-Forwarded-Encrypted: i=1; AJvYcCWH1EUAhTw0RzuH0yTSNdcATsQbD2BDb1pc2lGcVcQEFRKPXJeP9BK7gms/S5TJFpxhJ9KIx3YeM7c70o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNtRniyzpMOWiFxbv8emcB4yw/qJfLbS28d+CWGqAOvH75Fw1H
	sXievLK32i7EINptBfFgPrryamqPFBvXiQyu+f+RU1q80LOi8RNE8plqAIBPxg==
X-Google-Smtp-Source: AGHT+IF4zz4I11EJJaQjoC63mOUtCQHTC2gvazmoA+u7+QenabiezQrabqUBp6+IGcwAVnq9Hr0H/A==
X-Received: by 2002:a05:6a00:148b:b0:71d:f2e3:a878 with SMTP id d2e1a72fcca58-71e4c13dd50mr2364487b3a.5.1728705027717;
        Fri, 11 Oct 2024 20:50:27 -0700 (PDT)
Received: from thinkpad ([36.255.17.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa93e0fsm3531277b3a.140.2024.10.11.20.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 20:50:27 -0700 (PDT)
Date: Sat, 12 Oct 2024 09:20:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: kevin.xie@starfivetech.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Message-ID: <20241012035022.tvcffmnqzpqb7e6q@thinkpad>
References: <20241011235530.3919347-1-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011235530.3919347-1-quic_mrana@quicinc.com>

On Fri, Oct 11, 2024 at 04:55:30PM -0700, Mayank Rana wrote:
> PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
> bridge device. To enable runtime PM of PCIe host bridge device (child
> device), it is must to enable parent device's runtime PM to avoid seeing
> WARN_ON as "Enabling runtime PM for inactive device with active children".

"to avoid seeing the below warning from PM core:

pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
with active children"

> Fix this issue by enabling starfive pcie controller device's runtime PM
> before calling into pci_host_probe() through plda_pcie_host_init().

"before calling pci_host_probe() in plda_pcie_host_init()"

> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v1->v2: Updated commit description based on Bjorn's feedback
> Link to v1: https://patchwork.kernel.org/project/linux-pci/patch/20241010202950.3263899-1-quic_mrana@quicinc.com/
>  
>  drivers/pci/controller/plda/pcie-starfive.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
> index 0567ec373a3e..e73c1b7bc8ef 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -404,6 +404,9 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
>  	plda->host_ops = &sf_host_ops;
>  	plda->num_events = PLDA_MAX_EVENT_NUM;
>  	/* mask doorbell event */
> @@ -413,11 +416,12 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>  	plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
>  	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
>  				  &stf_pcie_event);
> -	if (ret)
> +	if (ret) {
> +		pm_runtime_put_sync(&pdev->dev);
> +		pm_runtime_disable(&pdev->dev);
>  		return ret;
> +	}
>  
> -	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_get_sync(&pdev->dev);
>  	platform_set_drvdata(pdev, pcie);
>  
>  	return 0;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

