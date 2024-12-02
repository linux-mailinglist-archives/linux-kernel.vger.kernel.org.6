Return-Path: <linux-kernel+bounces-427183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC309DFDCC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE212B23ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443BE1FBC9B;
	Mon,  2 Dec 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VF2K9Myb"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244921FA84A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133119; cv=none; b=dNKRAuXciW9by7FW5vQ4QXCTQtaOeEFlIeC8Ppa8fiC2xh4DJcUEO29oyRFQQp2xup5z3yNd3UszznxU7f2TIi5vhTSw/jr8GAeZl2nO8dqxITJNQbrNVkRNJS8xiIKP5ap0PLmN+yY05ytPUMj+EXUQHUFomQBjcLUeCdj/vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133119; c=relaxed/simple;
	bh=rrHT5ISu4ntl7jHH5qk6ptP2W7I5hEkSFLbxbRC4wt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+J7qxRKuJl5RUYPjDxuipWKeNSG1TAwVZPv+p4rEgWLlykFH3xaKl2bQHqOT3CQQYX1zuO+egBXJC++rzrutr0lCCLVfZvLoS4Q1vblqG8Ahuee+rt5C0fpU5YwkGIz7GG4GG5fQY6WMqa9DKSBmllSlwzSVE5QM6qPfZTg+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VF2K9Myb; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fc88476a02so3309937a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733133117; x=1733737917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=us2DAUmz8SSO9Fkdpm3cqKbhkQy4ljHHURt29NsDe3M=;
        b=VF2K9Myb8JmTT8AOTWmLlHqkghAN/0zS+nm4hoV9vzaMHV2Ih4dtZx7Rf3Dc6Hk2X6
         RxS6Tv+Dx9MOvnNlTWuVY/kq+qgmGxfKUobQtA4F0hJveZmhk+w0TEOL5/dKlHMAubW/
         O0j0W6hp0bwAJVsSzUBQaNq8yJZeT7xodnsZ5qAmb+Jq7iK5RcrZFcjsv+DYV7F5Vc+F
         ZFwAVSO9K6O0+DJfrTkQGlMBjJnVzuiliAhZAupn9gsF3N1Ai44xQ53AeIdVXHB1ELDd
         dE1DAq4Lzc4vGFIxFuzG/8VfYgQ24MQCO+PKZpuepKFUoZbQlnfmOh0c3SitxEtlnlvL
         G6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133117; x=1733737917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=us2DAUmz8SSO9Fkdpm3cqKbhkQy4ljHHURt29NsDe3M=;
        b=Yd264MFMGJpHwEcoHnCQGYTC9qwpH1yxdifOi4dcm797d+CgWPqGUn9p0bFeOVFV9r
         t2NlV+7kgcLnOmcqitu9KOmjPvyptM8odXFBw1Ln24qXnXYGaZf9FxqXIC58DS7gMzMn
         AaTJHmEU3ogqsLR+weIg66nON/BSjorQzKruT/bBga9//ZnOZUKpMOR+67mj8orbHHD6
         MDymtMR2UiTh6pBDijtZ0uI6eNmLZZ1v++OQHQCDTXCEqiXJ7lZUQmj+kuNZthgE+ofq
         Smy5uoQI311U1H33X3OtXYixraHHI/afVQ7F4KA4QOK3uGSchBU7mu/tliQY7LiZNvWo
         oJbw==
X-Forwarded-Encrypted: i=1; AJvYcCU472vMl1XdAJe6BI46JhVpGenatrbpbms2wr+rYnVDEVlZglx7F4LwWBHGfs6NCwb+/KbjPX6JeyIHPh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9MfVTXJt7m3bvvQa4WEtvdcR8t8i56GpPcLnnUyMZ+9Os5oE
	F5PxTMXxeJcRqjXIgbcaB7BHhCW9uJdDUnk1LVc5atc4K+v7KzqdiaTOVl+jwQ==
X-Gm-Gg: ASbGncs2NNZ6T5bbeqNi7tb6zJsnNNL/30IN8XwKg8R16sjlruX+Gg2UMaPEFWIXdMG
	D6tJmUitqpnHPdzdOZjSnvZBI9o2JmH/3iASK83GgxlmCOClUTmFUFZndUuql8VzHX4KUlWmUvD
	a/Nmtd+3MYXnzEZfvsaJcGztNya1YCu2d6D8FADG8EUeC7qvym65zxnhXO3WW3QCBapTvZ7AqBc
	DgVcO4mFywKZ6W8wJ1bNIdsbP7Uw04LT9YzXMzWye86dhVuUshqangNW612xw==
X-Google-Smtp-Source: AGHT+IHG5Cu0Pp0i4nhGKaYi5qQQMFoWyzPs6PVgf5vKt8vckryTy7wgHXKr6o20H/OIRqQE8YLxDQ==
X-Received: by 2002:a05:6a21:2d87:b0:1e0:c954:ea7c with SMTP id adf61e73a8af0-1e0e0b16a5emr32819128637.27.1733133117491;
        Mon, 02 Dec 2024 01:51:57 -0800 (PST)
Received: from thinkpad ([120.60.140.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848259sm8044152b3a.174.2024.12.02.01.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:51:57 -0800 (PST)
Date: Mon, 2 Dec 2024 15:21:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mayank Rana <quic_mrana@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: fix MHI BAR mapping
Message-ID: <20241202095152.ghhi2opa6nfhjvbm@thinkpad>
References: <20241201171120.31616-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241201171120.31616-1-johan+linaro@kernel.org>

On Sun, Dec 01, 2024 at 06:11:20PM +0100, Johan Hovold wrote:
> A recent change converting the MHI pci_generic driver to use
> pcim_iomap_region() failed to update the BAR parameter which is an index
> rather than a mask.
> 
> This specifically broke the modem on machines like the Lenovo ThinkPad
> X13s and x1e80100 CRD:
> 
> 	mhi-pci-generic 0004:01:00.0: failed to map pci region: -22
> 	mhi-pci-generic 0004:01:00.0: probe with driver mhi-pci-generic failed with error -22
> 
> Fixes: bd23e836423e ("bus: mhi: host: pci_generic: Use pcim_iomap_region() to request and map MHI BAR")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Mayank Rana <quic_mrana@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Applied to mhi-fixes!

- Mani

> ---
> 
> The offending patch was marked as "Compile tested only", but that just
> makes you wonder *why* the patch was never tested...
> 
> 	https://lore.kernel.org/all/20241004023351.6946-1-manivannan.sadhasivam@linaro.org/
> 
> Johan
> 
> 
> #regzbot introduced: bd23e836423e
> 
> 
>  drivers/bus/mhi/host/pci_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 07645ce2119a..56ba4192c89c 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -917,7 +917,7 @@ static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
>  		return err;
>  	}
>  
> -	mhi_cntrl->regs = pcim_iomap_region(pdev, 1 << bar_num, pci_name(pdev));
> +	mhi_cntrl->regs = pcim_iomap_region(pdev, bar_num, pci_name(pdev));
>  	if (IS_ERR(mhi_cntrl->regs)) {
>  		err = PTR_ERR(mhi_cntrl->regs);
>  		dev_err(&pdev->dev, "failed to map pci region: %d\n", err);
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

