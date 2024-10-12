Return-Path: <linux-kernel+bounces-362110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B399B134
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38771C2198B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037F137742;
	Sat, 12 Oct 2024 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbGKiPBt"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F04A1E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728713337; cv=none; b=qXG2uTaDkLNKVeQVUhXReMwZcTqmlxQIqOVKxBd7o3lSV+miXfnmbau5xtt3AMrhA4c2s6cXhUvhh4Obszzkfe6qiBinOPN/99TO4OmeFJYtFqx00GhNHhJUotuzbe3snIH93EGjmPEImfJGD9qF15yBjJ9gk/YDhFp1+QH5sWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728713337; c=relaxed/simple;
	bh=ia4Yb+LtDiyz4D7G83VJfB9YyqQcZvVcBWsHAH+1NWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF+z73VZ1X8cGtSVK9zm9Ni9/ICmLqPCZ2gJuKZGcJCyTp2pM5W0o9hMz6vc1S6C5eG40/QKr+tSo3jlQ9NtNxiPpwCM8BX6YPA/VRWeM/tJ6s+bFMd3N1ZczCxm4x7CXyBZVUUVk3cyoe8Dod9ruOy8tHGQQ0Rmj5GLketvpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dbGKiPBt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so798322b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728713334; x=1729318134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tm+CjjmF+8X+/H05Bxg8usWBkcPnBrCtCrDgxghNmlg=;
        b=dbGKiPBt/N1t/NvKazIUmH/aYFanoH6jAQ9U+8qIXqCOk+T/Ajoxez9d1u7p3V2ABC
         YW2tQ/cjoCi1yt71ARwZZkSrm4iP8Y5AMvVn2YqgZc9awGRjjzVjhqACi4TdCMMU4CvH
         u08pbkznuMqLfpvZ4udA2gCMnnniAB4oAsIorkvYbMMqz1JNIeIbWSokcOX/TREwzOr7
         klFdT8VfvhH3TI6tdJ4xAfQc0YmJ+6VNMr8hPfLdCuodyN0P5QAlDtjm6hFVZXVosf+l
         +B87zVDQnJzvyhjbi9hQv8JkLez/BnUfplCLZJqFGf4Ll584EmywmkPLZvVoCHTCbJ+G
         ju8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728713334; x=1729318134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tm+CjjmF+8X+/H05Bxg8usWBkcPnBrCtCrDgxghNmlg=;
        b=BpcFAaJmYYelaEB65l6IALnSd/G59J/4D+T4LUnSm2r9unakgJzsI1kBM1GHDudy+B
         lxJv+LhAS445z5u8hWesTgEUhiTchXX0gbZpq+nAO+yCu6NOJ6L9TBJg1oic+sqBZO4U
         BoHa9pN1weoea80GSZ+RTyvvnGx9d1DjeYg7+Fu6Lh46vzQ5mDqN7qGdk6VDN106Ieqb
         62CUraq27Q6xg0SZUicPvubw4nN4x1cZwIhb6g6re5IGAgb+qrxigJhitgf/5j+lxV/Q
         uHUQDXiro+GK0VKACdF+w/KwNB3/HBVt4KBJN5/d8G7c8wReMAQhytuiDvWWYRrqWxUL
         L2ug==
X-Forwarded-Encrypted: i=1; AJvYcCXrDpw2PMh58h3qnub+Xlgi1+JS/MyIXFpz0sKtPYTcewt4BypdtKf8IZJ0LWWO64XtKFR6i1GJ5MNz7zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFFZQ4K1o5e1r2MgTNztvN3tH73RUK8CdA8SQXd3htzX3D07n
	7UeXbYZpSnYrdelcqwhlKsUR8VNF8hldQUkctTllj1hIfFrUAgdI27qCWntk0A==
X-Google-Smtp-Source: AGHT+IEOdJrCawaHpKf+RauJKcw0b+JnkybZXuZ8BcDrpMdner6dqxfzlp6iHTXNerTNdqRm7x4xqg==
X-Received: by 2002:a05:6a00:188f:b0:714:2198:26b9 with SMTP id d2e1a72fcca58-71e37e982camr8122107b3a.13.1728713333711;
        Fri, 11 Oct 2024 23:08:53 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e474889a8sm1454250b3a.29.2024.10.11.23.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 23:08:53 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:38:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <20241012060847.6teuutvy2u2es2qw@thinkpad>
References: <20241012050611.1908-1-linux.amoon@gmail.com>
 <20241012050611.1908-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241012050611.1908-2-linux.amoon@gmail.com>

On Sat, Oct 12, 2024 at 10:36:03AM +0530, Anand Moon wrote:
> Refactor the clock handling in the Rockchip PCIe driver,
> introducing a more robust and efficient method for enabling and
> disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,

I think I mentioned earlier to use impreative tone in commit messages.

> the clock handling for the core clocks becomes much simpler.
> 

Could you please elaborate how? i.e., devm_clk_bulk_get_all() allows the driver
to get all clocks defined in the DT thereby removing the hardcoded clock names
in the driver.

> - Replace devm_clk_get() with devm_clk_bulk_get_all().
> - Replace clk_prepare_enable() with clk_bulk_prepare_enable().
> - Replace clk_disable_unprepare() with clk_bulk_disable_unprepare().
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

With above changes,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v7: Update the functional change in commmit message.
> v6: None.
> v5: switch to use use devm_clk_bulk_get_all()? gets rid of hardcoding the
>        clock names in driver.
> v4: use dev_err_probe for error patch.
> v3: Fix typo in commit message, dropped reported by.
> v2: Fix compilation error reported by Intel test robot.
> ---
>  drivers/pci/controller/pcie-rockchip.c | 65 +++-----------------------
>  drivers/pci/controller/pcie-rockchip.h |  7 ++-
>  2 files changed, 10 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index c07d7129f1c7..2777ef0cb599 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -127,29 +127,9 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  					     "failed to get ep GPIO\n");
>  	}
>  
> -	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
> -	if (IS_ERR(rockchip->aclk_pcie)) {
> -		dev_err(dev, "aclk clock not found\n");
> -		return PTR_ERR(rockchip->aclk_pcie);
> -	}
> -
> -	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
> -	if (IS_ERR(rockchip->aclk_perf_pcie)) {
> -		dev_err(dev, "aclk_perf clock not found\n");
> -		return PTR_ERR(rockchip->aclk_perf_pcie);
> -	}
> -
> -	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
> -	if (IS_ERR(rockchip->hclk_pcie)) {
> -		dev_err(dev, "hclk clock not found\n");
> -		return PTR_ERR(rockchip->hclk_pcie);
> -	}
> -
> -	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
> -	if (IS_ERR(rockchip->clk_pcie_pm)) {
> -		dev_err(dev, "pm clock not found\n");
> -		return PTR_ERR(rockchip->clk_pcie_pm);
> -	}
> +	rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
> +	if (rockchip->num_clks < 0)
> +		return dev_err_probe(dev, err, "failed to get clocks\n");
>  
>  	return 0;
>  }
> @@ -372,39 +352,11 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
>  	struct device *dev = rockchip->dev;
>  	int err;
>  
> -	err = clk_prepare_enable(rockchip->aclk_pcie);
> -	if (err) {
> -		dev_err(dev, "unable to enable aclk_pcie clock\n");
> -		return err;
> -	}
> -
> -	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
> -	if (err) {
> -		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
> -		goto err_aclk_perf_pcie;
> -	}
> -
> -	err = clk_prepare_enable(rockchip->hclk_pcie);
> -	if (err) {
> -		dev_err(dev, "unable to enable hclk_pcie clock\n");
> -		goto err_hclk_pcie;
> -	}
> -
> -	err = clk_prepare_enable(rockchip->clk_pcie_pm);
> -	if (err) {
> -		dev_err(dev, "unable to enable clk_pcie_pm clock\n");
> -		goto err_clk_pcie_pm;
> -	}
> +	err = clk_bulk_prepare_enable(rockchip->num_clks, rockchip->clks);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to enable clocks\n");
>  
>  	return 0;
> -
> -err_clk_pcie_pm:
> -	clk_disable_unprepare(rockchip->hclk_pcie);
> -err_hclk_pcie:
> -	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> -err_aclk_perf_pcie:
> -	clk_disable_unprepare(rockchip->aclk_pcie);
> -	return err;
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
>  
> @@ -412,10 +364,7 @@ void rockchip_pcie_disable_clocks(void *data)
>  {
>  	struct rockchip_pcie *rockchip = data;
>  
> -	clk_disable_unprepare(rockchip->clk_pcie_pm);
> -	clk_disable_unprepare(rockchip->hclk_pcie);
> -	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> -	clk_disable_unprepare(rockchip->aclk_pcie);
> +	clk_bulk_disable_unprepare(rockchip->num_clks, rockchip->clks);
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
>  
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 6111de35f84c..bebab80c9553 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -11,6 +11,7 @@
>  #ifndef _PCIE_ROCKCHIP_H
>  #define _PCIE_ROCKCHIP_H
>  
> +#include <linux/clk.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
> @@ -299,10 +300,8 @@ struct rockchip_pcie {
>  	struct	reset_control *pm_rst;
>  	struct	reset_control *aclk_rst;
>  	struct	reset_control *pclk_rst;
> -	struct	clk *aclk_pcie;
> -	struct	clk *aclk_perf_pcie;
> -	struct	clk *hclk_pcie;
> -	struct	clk *clk_pcie_pm;
> +	struct  clk_bulk_data *clks;
> +	int	num_clks;
>  	struct	regulator *vpcie12v; /* 12V power supply */
>  	struct	regulator *vpcie3v3; /* 3.3V power supply */
>  	struct	regulator *vpcie1v8; /* 1.8V power supply */
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

