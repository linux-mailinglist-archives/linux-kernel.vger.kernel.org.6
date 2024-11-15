Return-Path: <linux-kernel+bounces-410772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA09CE156
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574E3B314B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3E1B6D18;
	Fri, 15 Nov 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXthVxCN"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093D1BC08B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679228; cv=none; b=RWCQuoCl7Uf/gfPjCTFJL0qJrnH2HR/YPASQeGsMGhlHuVHNgG746Z9xk0epyWNKzWshxOx7sipZNXdY3CB8GqkBUqXnC0nOsI/D4sQ8xpeYEwHowwo3RXFL3+hjsdVdNJsjWeViYMzUwZ/LOVzoEanX0M6UX197B2Wo/Vg0e+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679228; c=relaxed/simple;
	bh=wITQEuGHifPLZfrjNBLGf1/VYU3ldYv0BLlgjaO4tNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/u9FTwbOemcb5f9qo/GEKlFxjuiyvLuK8v7qLVvaHRs18E4HfJZ/dj3otlcCAmIxmP9ovG3yNwF7QoOH269wWI3deNtdDghBdCj4b6JkBL9wpTtwaKRBQ8+mwltFKTeZctKVwl5AXHQns5dmskdQinBFO4zEuJY9rdRz2H565I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gXthVxCN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720d5ada03cso728438b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731679227; x=1732284027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wfpzUgAKV0jqCB/bxXS4WblmHJxx7PtLijC6sKxlHnQ=;
        b=gXthVxCNfmxGvqT54y2CL35QG6KRDX73m0zdEDWcEy7wBr4jUv1MFJj1yNd9qQym32
         paTBb8MQCNrhQnSU7XIIiyUxtbCRvEXdgpgGJTXKmLx4N+BS2Rsp7KGFUCTM0GH5R5Ap
         U5/uhPyUQMNlCf230pXctCKjJ/TcVsL8cir2NPJ2qAXkOagXj//ON9nXQi7gh11cS/Cd
         pKXIQf4XQcGakstUfVCtmSCX64iGqLXGCLaY++AdIOpQ01mCMfqLldT+t7gKsx5KaxDW
         voBzIzARi0yhb0ieRkA4t7cQXmibAjRlTU2f2bh96qB3sknDAuN0QJAJPGWmLhlCfHOF
         VIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679227; x=1732284027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfpzUgAKV0jqCB/bxXS4WblmHJxx7PtLijC6sKxlHnQ=;
        b=e7IzWeXltFji0RJZGpKviMHeBBJneytvU//H4beSGHRGm5xBRjqZirjO71AZmV9tIe
         BPqQO9kVBiOgeUM+tm9C3Y78fuvT84rCSj2E9wO6IZefZIfD2a/n6JNKU2LrhKUXJ8e/
         isnzsKmPgHO1gg30dwHg3dE5PIVfd0rSuP9vjcHY/dn0un0S3Lr02/aHaGp5Nq1U2k+w
         tLNEf+fnGaI94Hj9ngCKSf3gqwd9RQ0qvAIDwX3Vxa+xFx+jlxAK5FxgKSasiPlVhu7S
         EMRlii3thHLj+4xo6d0SrB/9Im165gjwnhSOWX5QHgAybhOUUidxlAHl+7VVQsx4G0DT
         BqTg==
X-Forwarded-Encrypted: i=1; AJvYcCVidlzr6L5qw9aegze0nekCWzlzxV23RcgnyKq1CeqzQSb7h4lmyIQRYM8r/2bOtg5lDyzGvDkbmIJKvw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0m/7TkBaAABob/y+iyscdvJWCi3bV0vfQPbfhEY6g4sNwLV5k
	m9H67uS5xqLvHBp7HQRgaMG1+URGzYlSZb56CAYa0F9ySGcZmJ5hhZvPj0h3+A==
X-Google-Smtp-Source: AGHT+IF2wtEKwXutObdUBNcfljb4mzMuPVgleqWOzqod5ZcyZXK+6BYBJljNVhpODn7AtoJMoCNd5Q==
X-Received: by 2002:a05:6a20:729b:b0:1dc:154a:81fb with SMTP id adf61e73a8af0-1dc90c05ecdmr3582385637.44.1731679221986;
        Fri, 15 Nov 2024 06:00:21 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee81csm1362494b3a.32.2024.11.15.06.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:00:21 -0800 (PST)
Date: Fri, 15 Nov 2024 19:30:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
	andersson@kernel.org
Subject: Re: [PATCH v4 2/3] PCI: qcom: Set linkup_irq if global IRQ handler
 is present
Message-ID: <20241115140013.ichb3ntic6jicsy5@thinkpad>
References: <20241115-remove_wait1-v4-0-7e3412756e3d@quicinc.com>
 <20241115-remove_wait1-v4-2-7e3412756e3d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115-remove_wait1-v4-2-7e3412756e3d@quicinc.com>

On Fri, Nov 15, 2024 at 04:00:22PM +0530, Krishna chaitanya chundru wrote:
> In cases where a global IRQ handler is present to manage link up
> interrupts, it may not be necessary to wait for the link to be up
> during PCI initialization which optimizes the bootup time.
> 
> So, set use_linkup_irq flag if global IRQ is present and In order to set

s/In/in

> the use_linkup_irq flag before calling dw_pcie_host_init() API, which
> waits for link to be up, move platform_get_irq_byname_optional() API

s/API/call

> above dw_pcie_host_init().
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ef44a82be058..c39d1c55b50e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1692,6 +1692,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	irq = platform_get_irq_byname_optional(pdev, "global");
> +	if (irq > 0)
> +		pp->use_linkup_irq = true;
> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "cannot initialize host\n");
> @@ -1705,7 +1709,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_host_deinit;
>  	}
>  
> -	irq = platform_get_irq_byname_optional(pdev, "global");
>  	if (irq > 0) {
>  		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  						qcom_pcie_global_irq_thread,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

