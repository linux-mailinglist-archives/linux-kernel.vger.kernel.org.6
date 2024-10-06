Return-Path: <linux-kernel+bounces-352521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF2992048
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BF81F21A6A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22809189917;
	Sun,  6 Oct 2024 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHSVlzyw"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E93189B9B
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238428; cv=none; b=hTGOGh4BCau9BwbVEEnN2mZRzH7WlRWdcb4SVvayWNpiyAwZbA+irTXoGORVI5DNDMM563k5fywajJ5Wi1i2M6h0zevxONS5BHetEin5LW0576mgjNqpnurV4l0tniaLUUKwbH6YmK/uwjHcpNrGYPKWXiQiYhvMPbPyrVy5spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238428; c=relaxed/simple;
	bh=Ua9EPz2F0ax/VTNXjs0OZ+SzQLhTYERlSHK26OI8qU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQJXupDO99KI7tDbgRm1Dp8KXc0d57OoD2T5fqM/uo/pTbME9cx7aHyvbz/j2vbJQTLlQ8YpAcOuQF5oLMbPLpfSSeGfItgJKywIA8M9SO9UPq/eXR5cgVfRD2BMNzhdpmgj9zUqxHrN171UhjkZUsdZmf63Xbr1JvlNAdI0DYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHSVlzyw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so3113159a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728238426; x=1728843226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/0dUjW4cyzgF6yaoe7/JlUubqxNdOah7f3VO0ZqngU=;
        b=lHSVlzywUJpd+ykKrwbEuPgwrZKxjFm3jGZvjJb8oE9ehjEd/BM3BA47aR6RALPYMi
         vH/4jgnKLb/HE8Jg3EoOX13o+hfpeOpjgybJCXbCBiVWXbBsNgkianVdM6ktK3IKlX6I
         Ez7VBIFgzJydqIHDZbxAHfKXE/+eJv4vbzJPD6BlH4uDYcAdU8iBt2MnxPQvUBvpxDT3
         1m406a6gQ1pCOVlEWlIL/ss1BUtv31ix0fmL9nHGG3kXSve8nLHYCZtrBP7aeyT9gUjJ
         2h7W41AXAh6pKTUlbRpj0Hb2Sb+4GGjnHS3clRuoRiyBZ1I4k+4ufnW/LtAvt6lubW6X
         HhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238426; x=1728843226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/0dUjW4cyzgF6yaoe7/JlUubqxNdOah7f3VO0ZqngU=;
        b=UJBJclw4PTBZrsKCb1QsOeeIZlvjAVPYpwYncE+42YdyRqkEMu1+YBCjzOEpadwBXx
         V6RQJ3tjquj4S18Wdffz+Yybw/6Eu+5RmpbH77lfcQ+6pLbQcFmLGPEn02iMjflYBgy3
         m0bXYV/ZxRimSarlj1/jzRR40soFbQ+VDta9KzsFa/qmAFsysbYNfS1rN3sE6AGYrTNW
         NTS50UtQJp9vAjjhR/O3wFhT8YapOD0hMBv5pn9e9LhdKCt9DhGx0vapy8qY32wzPTdx
         dAZ4tV6nle7yFTMx7S0Gi/pCgULOBbt89BGdCtKWsyfY4kVAM+fL6n67tlJobxecZauh
         +2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOgrxxs7bfh/mDpRYuDB+MGSZZzneYqpVxzrbUNkP+rsMBr7gDXvQOqAFO3Q8m6KKXK59/0/dxu82Gcik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNyr1YFZj4Ga1WzGQdxfh7OvTCXQs/wdJb2eI1y/EQmazxFS2
	bzNbEUAlAmj/6v8j8BcQlmCsjSmj1MQ+1KLa0ikMn/jswzdicUlMAThNyuePoRz6VjbOfyrsCQo
	=
X-Google-Smtp-Source: AGHT+IGR+azJ48oun8zo9Wf54stSUamrDzyOck3wVNecSl83OrIq+R2fL++Y4u9uqPUWdAaT8lZzWQ==
X-Received: by 2002:a17:90b:4a46:b0:2da:8edf:ddc with SMTP id 98e67ed59e1d1-2e1e5dbc080mr13800947a91.19.1728238426412;
        Sun, 06 Oct 2024 11:13:46 -0700 (PDT)
Received: from thinkpad ([220.158.156.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0fb8c1sm3673804a91.43.2024.10.06.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:13:45 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:43:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mhi@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Use pcim_iomap_region() to
 request and map MHI BAR
Message-ID: <20241006181343.bng5gkwvmofefomv@thinkpad>
References: <20241004023351.6946-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004023351.6946-1-manivannan.sadhasivam@linaro.org>

On Fri, Oct 04, 2024 at 08:03:51AM +0530, Manivannan Sadhasivam wrote:
> Use of both pcim_iomap_regions() and pcim_iomap_table() APIs are
> deprecated. Hence, switch to pcim_iomap_region() API which handles both the
> request and map of the MHI BAR region.
> 
> Cc: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to mhi-next!

- Mani

> ---
> 
> Compile tested only.
> 
>  drivers/bus/mhi/host/pci_generic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 9938bb034c1c..07645ce2119a 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -917,12 +917,12 @@ static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
>  		return err;
>  	}
>  
> -	err = pcim_iomap_regions(pdev, 1 << bar_num, pci_name(pdev));
> -	if (err) {
> +	mhi_cntrl->regs = pcim_iomap_region(pdev, 1 << bar_num, pci_name(pdev));
> +	if (IS_ERR(mhi_cntrl->regs)) {
> +		err = PTR_ERR(mhi_cntrl->regs);
>  		dev_err(&pdev->dev, "failed to map pci region: %d\n", err);
>  		return err;
>  	}
> -	mhi_cntrl->regs = pcim_iomap_table(pdev)[bar_num];
>  	mhi_cntrl->reg_len = pci_resource_len(pdev, bar_num);
>  
>  	err = dma_set_mask_and_coherent(&pdev->dev, dma_mask);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

