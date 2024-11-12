Return-Path: <linux-kernel+bounces-405259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F499C4F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED22D283AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC7F20A5EB;
	Tue, 12 Nov 2024 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVJmn2Fc"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CE20A5F7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395324; cv=none; b=mhtn9A3AzTDxegOfIhrXtbovXAjtlcqNPaBueZ6Gyk5C/+xm7eBHMVXBuekLe54PPbjXy9hUxecJRkTKDxuBPiAW2PyVhHhEJA3BbYsMOpPkM160NinkSVAABUb2CMJvQVF6CVrw/7nei2FhEb5Pb2hkyKyXKU7M9n/NOpPHE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395324; c=relaxed/simple;
	bh=vQpLr73fPAhyt03b7DbuAYrhHB/HfoQbi+CkELdcpO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp/1n59PllZAA8kjh/QlQQ+u4Z4kFxYQDwLsKxj0EnBYMMXwj8sl8YzwzWCXjLgtPjS7f++4RP3TXWGUxIW4T28ENafI7+Z5Zz9U+YIvfDluasq2NkxuJT6Tbty08CcwA6jW/8E+/+4iuX18D1cMPB+6lxloP98qY1MY2X0jqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wVJmn2Fc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720d5ada03cso5368501b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731395322; x=1732000122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GYotEMBcArnksOWpjr0ougrZeUumVFiWesABvsp9ubM=;
        b=wVJmn2FcDREXPawtIwjpevNGPVIB0METJpU83ImusUEzJmQ15IEgjKCZgL6BNiY7Vu
         KxMNL8uJzcgIogK1tFRgAS2oRn9Gihnj8S3eRYBVFn6lPfroF0IeS+kNn45wbfaScVm0
         onvZ+rgN18OaPw4kj/rG6L5QIKiGqupX4F6qyVnqaCvbqVyTP7bKeNM5vPppeoSQD/Rh
         wvBNaYd/ozs9bUayIj/PuRho95JHtK5klANjZau2CWc3A4P3IRg98zha8WuhOtAFQOuy
         E0M0QHgsYwMWI9g6HuHOVAxD9m+GqeiO9gGMSRaEa5oejbul4YS6gdghmouQyGY5FX0d
         Urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731395322; x=1732000122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYotEMBcArnksOWpjr0ougrZeUumVFiWesABvsp9ubM=;
        b=AhFbIi5s3qh+vonG9TgQhTnRemaKV4XQ3O3f787VriJrIOUwncWb2C58xYm6QrAef7
         hFtjRqWUTTVdRmOfmutRdx0AtKv4S8sJKf5uxb6wf2e/pHyE40drflXjLIQni7jqq93u
         dQSB+cB/UtYO+JGPtQnmn49e/b/u4rkfXYkUKMcSLG/BGXIZt0xZ3yjOnYgA6zPOfoQ/
         Q6mGTELO1Vjc31o+DVmibFiPQqU9+0xc5Mt2QdpqwMlv61sESX6M9w1LKAjYRtXLsWGb
         CDgfpiOadKUjtR/0AMwRGWoY0uSly7x5zUNibJ6Lk7EGtgFWU6y6LXuqU80CamMgFsue
         7tyw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4ggM/LKFoy6GpMw62c6+CbfFCJX2Gjzri5X7lAWVvYUE4vPTnMnARngbqLfp20BO9/4x7DymGFw2uzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYicjSZrNmi2B62IXp0uRyS36ZLWHustwB+coIJEROX0YWzH+
	PBMvxcuVNB43aDQ9Ny4mv9Ajp2Tajz3oCJa4GmDWImLo0otekYS2BX5bN3sV4Q==
X-Google-Smtp-Source: AGHT+IEgoR8vcVl0tRHfaHi7w/ESUdKFgKdOZs0ADUUkeKDj40lQwin0LYfqby4SbBaVUfu+WzSmOA==
X-Received: by 2002:a05:6a00:4f93:b0:71e:6c65:e7c4 with SMTP id d2e1a72fcca58-7241339e122mr18485552b3a.26.1731395322004;
        Mon, 11 Nov 2024 23:08:42 -0800 (PST)
Received: from thinkpad ([117.213.103.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bb25sm10714175b3a.109.2024.11.11.23.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:08:41 -0800 (PST)
Date: Tue, 12 Nov 2024 12:38:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: endpoint: Fix API pci_epc_remove_epf()
 cleaning up wrong EPC of EPF
Message-ID: <20241112070834.ttnmue5bfu6lnxdb@thinkpad>
References: <20241107-epc_rfc-v2-0-da5b6a99a66f@quicinc.com>
 <20241107-epc_rfc-v2-2-da5b6a99a66f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107-epc_rfc-v2-2-da5b6a99a66f@quicinc.com>

On Thu, Nov 07, 2024 at 08:53:09AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> It is wrong for pci_epc_remove_epf(..., epf, SECONDARY_INTERFACE) to
> clean up @epf->epc obviously.
> 
> Fix by cleaning up @epf->sec_epc instead of @epf->epc for
> SECONDARY_INTERFACE.
> 
> Fixes: 63840ff53223 ("PCI: endpoint: Add support to associate secondary EPC with EPF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index bcc9bc3d6df5..62f7dff43730 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -660,18 +660,18 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
>  	if (IS_ERR_OR_NULL(epc) || !epf)
>  		return;
>  
> +	mutex_lock(&epc->list_lock);
>  	if (type == PRIMARY_INTERFACE) {
>  		func_no = epf->func_no;
>  		list = &epf->list;
> +		epf->epc = NULL;
>  	} else {
>  		func_no = epf->sec_epc_func_no;
>  		list = &epf->sec_epc_list;
> +		epf->sec_epc = NULL;
>  	}
> -
> -	mutex_lock(&epc->list_lock);
>  	clear_bit(func_no, &epc->function_num_map);
>  	list_del(list);
> -	epf->epc = NULL;
>  	mutex_unlock(&epc->list_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

