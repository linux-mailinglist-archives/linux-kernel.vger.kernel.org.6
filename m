Return-Path: <linux-kernel+bounces-289154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608095427D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA6D28E19D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E812CD89;
	Fri, 16 Aug 2024 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhEhrDR1"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45422127B57
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792483; cv=none; b=lmDNEI+F94K77DuQ2TY4qUQWtsFGjgagu1fvKLUNe4cpme71OijyqD7SiY06zbwQiRJWQCG4LhvG4CGEP/P85kkI0Ti8J2ZgPtQfrcQNExXb+LyKMwxRBxqtXUYys56nvOpMZRUeDwNL6A9jBLT0P2DNcOhgIkIvlY0GNkmzJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792483; c=relaxed/simple;
	bh=Tye5lc15FhyuFHWJS52ywhOiKNMq2cc7/bt+U8IvG+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSQ0P7E+L/ywitH9Fsx017XVv18q4xMvCYSg/bKTjZJUuJJtMJA4cTTZhKyUPNzcUoDZXu4V9GZmcFnVKdBaaBxIpxtXdz5WhFzpQxLI/wL5ZLLGO3iAKpaWzxxI2WAoEAEOyDQdU8/Qgtf6707SiUddn38U6M+qOD+iPn26A7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jhEhrDR1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710ffaf921fso1120485b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723792479; x=1724397279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1go7sx0ECg3Nrbun5bUntSM8dbrApaP82pTFnxOeNLY=;
        b=jhEhrDR1Yo1HaB0zifEI+fZaGoTfwkphLH07ieo+VmtnTXBw/jULms0N2n7YAK4JOx
         +RxiZCEX5osZRViU2A4MPHRVn/hgzQ6c8XO0YAb7zUlyjfSdSl2ZrP5GEixy6lhekpdJ
         vZfoMdgVngkEavGSazWrv/YAPF0Ybt315smv+W8xeWJtNnK70r6VJu6kynjNN6EUG0dp
         BlNMcLjoZZCUhRuTunyPqs7TZvmc8/IZAm7Mxv8lPPOE99Up3xqYbP+3lTc4U8eQTpwd
         RUXniizs8ZCi1IvYJWJryH+h+WspAaqtsEjQSrB/1ss6/Qog5JDYPI4jitm3J7xC8hgt
         n7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792479; x=1724397279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1go7sx0ECg3Nrbun5bUntSM8dbrApaP82pTFnxOeNLY=;
        b=NvPWsp3ikMuAVfZa3UWD94M4vmFG5A6LoJlwwqBcmwZNxWacBBPzsBIjC6/dgNbLbx
         ToVIEKRZlw8vcUFfWff6ny9BHLwWnnQR7WVQjLPW/RSfh3kNrMlLIUZW0eCDVPlJozA0
         PySAWPzVSfEfVmTXXHmh8coh3qTO7gSN5x24h0BI8NX4JQKdCXZXd8zw3HNCidmzjal3
         HSIBXHQ/qetPM08Sr6db/LrVn9cU+Dki/9T6wzFADRhffgJ8g7jEAcMXEkFRHNbupxQk
         VNAiqg5CWiLHNYTDv3G+UwQWY6KPkgq7pT0F+dRraj4y3WmGGucCX9j1SCDk2dKeTWuH
         VvRg==
X-Forwarded-Encrypted: i=1; AJvYcCU39FzJgk4AA4w1d1dg1TUIdVLr6L050e/eUdau78+fnvH6iqX7UkOUZVejE2lg19AhirO6mrBYN/KQmjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78Ffa2l9k6JQvEgN3kOYT4erqufosjqVo4VSkLeQAzBeZCVV0
	PghOiVJVOy+g7+OdwDnJGDXbyb7tc/fXpbB1hb7upQQ6ZvqKqftz2+u5MLcYFg==
X-Google-Smtp-Source: AGHT+IEs7skbPukuQ+QD2T4e30incfTrK+bKIykg7J49EQF5T/hlK5KpRQ9P3b2QajFbL/ijk8kb7g==
X-Received: by 2002:a05:6a00:6803:b0:706:938a:5d49 with SMTP id d2e1a72fcca58-71277094499mr6925763b3a.14.1723792479465;
        Fri, 16 Aug 2024 00:14:39 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07e41sm2054202b3a.65.2024.08.16.00.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:14:39 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:44:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 11/13] PCI: brcmstb: Check return value of all
 reset_control_xxx calls
Message-ID: <20240816071433.GM2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-12-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-12-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:24PM -0400, Jim Quinlan wrote:
> Always check the return value for invocations of reset_control_xxx() and
> propagate the error to the next level.  Although the current functions
> in reset-brcmstb.c cannot fail, this may someday change.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

But one comment below.

> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 102 ++++++++++++++++++--------
>  1 file changed, 73 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c5d3a5e9e0fc..d19eeeed623b 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c

[...]

>  static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
> @@ -1479,9 +1515,12 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct brcm_pcie *pcie = dev_get_drvdata(dev);
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> -	int ret;
> +	int ret, rret;
> +
> +	ret = brcm_pcie_turn_off(pcie);
> +	if (ret)
> +		return ret;
>  
> -	brcm_pcie_turn_off(pcie);
>  	/*
>  	 * If brcm_phy_stop() returns an error, just dev_err(). If we
>  	 * return the error it will cause the suspend to fail and this is a
> @@ -1510,7 +1549,10 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
>  						     pcie->sr->supplies);
>  			if (ret) {
>  				dev_err(dev, "Could not turn off regulators\n");
> -				reset_control_reset(pcie->rescal);
> +				rret = reset_control_reset(pcie->rescal);
> +				if (rret)
> +					dev_err(dev, "failed to reset 'rascal' controller ret=%d\n",

Do you really mean to say 'rascal'? ;)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

