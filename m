Return-Path: <linux-kernel+bounces-245300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05AB92B0DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 536C0B20F16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301213F43B;
	Tue,  9 Jul 2024 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3iN3ZOH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944513AA4D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508965; cv=none; b=d1Qa8V800D6keu7mJzzxpJolE3rhxOMpdKAVNK21mXg/9vC90RPpWQoqR6X8C92dvokMuMKRghAqlWXTnac3InEbloAz+auEnTw1D7xiY2mXPMphdXyBXWPL0tN7XSEIuK044n24rOoAWMieOeJUsiQ3/j/FUPnz4O6odG9ZYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508965; c=relaxed/simple;
	bh=0EbaZGBCGAlDdaBpz5q6jU7//pUs+PQe1Irem1Hb25U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6eQAd3qijc726H677Eps7TpN/NJZZDGjZ2ltCc6odm0L8ous+Ij++nHP4uSesQ//tfCZoKryuB+5W1CEi18aEC8uFMgdFwd83cSkUnMjfNwjZCUyVcAzatyTHRTC4sUu/1Pw58xanc5lc11rJad+qYOgCBkb/MCItQNK19KTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3iN3ZOH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70aec66c936so3225242b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720508963; x=1721113763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ktSm4q1vxdmtkavfLnfXdh6fXORXctBwSCyUPkuRKh8=;
        b=G3iN3ZOHopm3mtgq9x4VbtBLd7+87pueMbEYcQnnSp50fQkEH9BunryS3idlc32bpT
         lICEHU3GZHkY6Fwt7b9n/M5TKQFOVUQZvoD74yUU+EpI3lFFb8632YEi03ZfU+Qi5bnJ
         4idXjAj9chCnjQ10t+syErNh4P75UXzPKEs+Tz59s2qZo2Ovi/589E5YmZu8JIV+LHKy
         jzKgFEDncvzG8JmfsCPJJ8u97LtgXRSHL1jyNzPe7YOmQZSklLEXEV/3FUMbBhu+vgi5
         2aS5lOpQPue0NMExEIelXgPamT6oLqKd1j2UffxQpiGZKmHarRAwnIy17hJ8C0wWXYgb
         mLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508963; x=1721113763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktSm4q1vxdmtkavfLnfXdh6fXORXctBwSCyUPkuRKh8=;
        b=dtyk8wz8DMl3urzvJYSUl0iFApwzOP6MkUfK69fBkYhucvbdA4QPHZlCI3C9fHa/H5
         dx3H1CbHEedOHwQUidSq3AjbkMAEMYYS7DsO5OJ/I7UnU/mfn6PxK9nqbo+SbbQUhHM3
         bUFoPFYU1LcjV64e8CRMPS+WXmUb/0yx4XF7D1kITy33mEnPdRJbsEZZrojJb3QU7bVZ
         dUWm3OlvMB2fLfSSyR/yraT/74DdYmT6S3wcBnNBSxfrNpFYIqdW2CvhOVskZSPu6EmY
         AV0HlsfdbaJEeQlIbmRC/0XYjhSMGqb0z9SF8E62BK5DnUKgghLZ1KjnKwEVcPEAYdml
         R5cw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7ekv9aDzdkx1eLjYkTU0tkxqS+DMTpFGz0OqBjAodyw6xbC9UBHqG56e5uhhkG1DzXPBXqqhkxhyk/rHcXccizefDj7QnibSUGhx
X-Gm-Message-State: AOJu0YxcRNHImcWFCVwaALkRXHgWKnk4IGFsIJYvBTBpWB9TxVsutdm5
	6Pq8/QKKhjhJrrAQtPyg40X7dpT0pi6mcYJM6EFBdQZlncNe/tG1CwqtZsaTqA==
X-Google-Smtp-Source: AGHT+IFqpYgrrt5uc3kzJJ3RWffhZnZTxn37z39ek238VkDPJg7zYx6wk2uXBCCVizNNoOnNVTUF1w==
X-Received: by 2002:a05:6a00:2352:b0:70b:1525:9adf with SMTP id d2e1a72fcca58-70b4364fe15mr2135383b3a.22.1720508963273;
        Tue, 09 Jul 2024 00:09:23 -0700 (PDT)
Received: from thinkpad ([120.60.141.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c27b0sm1064532b3a.64.2024.07.09.00.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:09:22 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:39:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, quic_krichai@quicinc.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pci: qcom: Fix 'opp' variable usage
Message-ID: <20240709070915.GA7865@thinkpad>
References: <20240709063620.4125951-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709063620.4125951-1-quic_varada@quicinc.com>

On Tue, Jul 09, 2024 at 12:06:20PM +0530, Varadarajan Narayanan wrote:
> qcom_pcie_icc_opp_update() calls 'dev_pm_opp_put(opp)' regardless
> of the success of dev_pm_opp_find_freq_exact().
> 
> If dev_pm_opp_find_freq_exact() had failed and 'opp' had some
> error value, the subsequent dev_pm_opp_put(opp) results in a
> crash. Hence call dev_pm_opp_put(opp) only if 'opp' has a valid
> value.
> 
> Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Fix was already submitted: https://lore.kernel.org/linux-pci/20240708180539.1447307-3-dan.carpenter@linaro.org/

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 26405fcfa499..2a80d4499c25 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1443,8 +1443,8 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  			if (ret)
>  				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
>  					freq_kbps * width, ret);
> +			dev_pm_opp_put(opp);
>  		}
> -		dev_pm_opp_put(opp);
>  	}
>  }
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

