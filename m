Return-Path: <linux-kernel+bounces-358293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2D997CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74E81F23648
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE6D1A01D4;
	Thu, 10 Oct 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvEBTza4"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F819ABD8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540538; cv=none; b=I+e6g48+bZJbI9CaSY+90utU1OwRse7HsRc1At7a1i1mQosBuqmpO19NDFt9+oC9iJsNn68WlY0fXbKpFSTiznXl8jNb+cXNu5CBv/SZpxIKaMatZXaBb3nTl8LSMS/76I1tXWPWyZ4VpjUS7kM3+XaQFxylCNCuZc7sOZ+WXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540538; c=relaxed/simple;
	bh=0OgbtqLlAbN1z9OYA94xJ5Sh/iz8vI/2Qy/cvuRnLhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKS9Ry2/Hb7JiPPF1UYcz4BA/IxweUsK4Ai2N4lh87ZMmgPuCLmLXaQfLJ4avID2wSvhbpd5o+oM6HACIF12dHrlh80ARzHHLVXRb/CbieCWYYpc54v2TPiRiL+Dy/wIftDqBbj44spkXgw4dzDWJW1KW5HCrkPcJLoZrXJKtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FvEBTza4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db908c9c83so358906a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728540537; x=1729145337; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AaPggIK+kjDlsf6IsGWVxs3sFhGqqFMMOjs0GcEV8bY=;
        b=FvEBTza4U6AwN52MzBVlh3/hOlDpY16sNcI2WjzytZzzhL5K5iZQOp6GCulgymgRUB
         5fSbSbJEJC4WzAlXMUQ8TDywrhNn6zyCKnvvc/O9MgDHcYgO7JZxbB8n7SSsWFTRkAfX
         KpNQjX3JiQuWyyqlOoSVfRrpiIXOCs8NYo5lBTRD9aE+4S9p2Cf1lUk0T5u856lxD3JB
         tWzBqvCUpgkaKhr6zsEonS8fYr0krR+WFweafK/GP9fKTWMGA8o/xsNnzteqMK1Mrlq8
         pHzG0wpJB4suiNjSHLljYVTND4Eo5JTGkspBNe04oHUqG1SfzB6zfpx6aJTFgj0emgg/
         U6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728540537; x=1729145337;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaPggIK+kjDlsf6IsGWVxs3sFhGqqFMMOjs0GcEV8bY=;
        b=u0Pgasi5Cw80RJuwI77EMUNcCW1lBF3JF7W/KUOGh7eqWsq1DJDc8d4m0zthfJ4wy2
         rJe4vV5ugZQtFMK0cRofctaBFJzNs2mTc6PTCFhFJol444fKm2ry+J+m6WRorqW6u2Hq
         LLu0gOP/CEoJZlT2cnwO/rzt7fX0m5E5/gpE3W4EW/dCojT6VL2mS495J7LYFnUGaqMZ
         ok/y6LL9vkQTDuVeGXpfNIxH5GMcQn77nXBRF6iK91lg2tKWXOq4XDL6D8NTN3j8S0jd
         rUc9fyClrmCxvaCD0QEQPo0f7YINAMVEm+ToRC9NtGonzepDBxGjFxVbl5JFRTM9ltnQ
         fYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVkt+bVUe7RUqQIsPA84ZlI9AP0AkQfl8oyQCGwHno0Hxchpx2BFcas/9wlaYwfV97RKkaKyEP6ILIJrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QiTs8weRJuKG5sASxs/eaAVX+n8JV5SMsoE8ArMmre7PcLTI
	1wB3l+wX+qP/2soTgGx0pFfT6oTmwXcPfZ1EjU+Bw44R1ryeXgp/duV625FhIw==
X-Google-Smtp-Source: AGHT+IHJpYGRJTHFQXTthKewIrwQapdvb4GxGEdi12sQvxgsVegfawgotyn03GV9XW3NMfSHpGpZzw==
X-Received: by 2002:a05:6a20:c791:b0:1d2:e94d:45a6 with SMTP id adf61e73a8af0-1d8a3bfec45mr9343196637.14.1728540536767;
        Wed, 09 Oct 2024 23:08:56 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa0a645sm384131b3a.94.2024.10.09.23.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 23:08:56 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:38:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Markus.Elfring@web.de,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com
Subject: Re: [PATCH v5] PCI: Enable runtime pm of the host bridge
Message-ID: <20241010060850.4j4r75yaigzjwuk5@thinkpad>
References: <20241003-runtime_pm-v5-1-3ebd1a395d45@quicinc.com>
 <CGME20241009181035eucas1p1410785aa81c9ec764c44d3f6eea940ed@eucas1p1.samsung.com>
 <6d438995-4d6d-4a21-9ad2-8a0352482d44@samsung.com>
 <03aa3a08-735d-4a6d-ae6d-e2887ae36840@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03aa3a08-735d-4a6d-ae6d-e2887ae36840@quicinc.com>

On Wed, Oct 09, 2024 at 03:20:25PM -0700, Mayank Rana wrote:
> Hi
> 
> It seems that PCIe controller (pcie-starfive.c driver,
> starfive_pcie_probe()) is setting (child device) PCIe host bridge device's
> runtime state as active going through plda_pcie_host_init() ->
> pci_host_probe() before parent i.e. PCIe controller device itself is being
> mark as active.
> 

Actually the pcie-starfive driver is enabling the runtime PM status of the PCIe
controller (parent) *after* its child host bridge. It should be done other way
around as like other PCIe controller drivers and hence the warning. It was not
triggered earlier because the host bridge (child) PM state was inactive. Since
it becomes active after this patch, the warning is getting triggered.

> log is showing below error from pm_runtime_enable() context:
> dev_warn(dev, "Enabling runtime PM for inactive device with active
> children\n");
> 
> Is it possible to try below change to see if it helps ?
> ======
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c
> b/drivers/pci/controller/plda/pcie-starfive.c
> index 0567ec373a3e..10bcd7e2e958 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -404,6 +404,9 @@ static int starfive_pcie_probe(struct platform_device
> *pdev)
>         if (ret)
>                 return ret;
> 
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_get_sync(&pdev->dev);
> +
>         plda->host_ops = &sf_host_ops;
>         plda->num_events = PLDA_MAX_EVENT_NUM;
>         /* mask doorbell event */
> @@ -416,8 +419,6 @@ static int starfive_pcie_probe(struct platform_device
> *pdev)
>         if (ret)
>                 return ret;
> 
> -       pm_runtime_enable(&pdev->dev);
> -       pm_runtime_get_sync(&pdev->dev);
>         platform_set_drvdata(pdev, pcie);
> 
>         return 0;
> 

Thanks Mayank for the fix. This should fix the warning (and hopefully the
lockdep splat). Marek, please let us know if this helps or not.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

