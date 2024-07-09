Return-Path: <linux-kernel+bounces-245179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B8792AF59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168F11F2202F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0A12D75A;
	Tue,  9 Jul 2024 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiZY5C6O"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50DE12DD90
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502106; cv=none; b=A4St1GdjQJ9xtaMe39+CKmoDNAPjQ0aeQDJ6zUdxtv5I9HgoFb/qyLmRoF1AYOJ0K3LGPPQND6sD9iE39xfqVjA3sCyQ7s5JUp3KdkfLvob/HR8VkhU8ZqdgaLHLdcNUuT3qRCtNp7fQmlZeaq9rlqM2QSiqRZJqjxO+icMHOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502106; c=relaxed/simple;
	bh=t7jsp+2AhCj4302LaXnCltCJorzxGApkgadG8T3SGZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFERtkb8kzcd5rNUUcPuUEMZrMimnTa3XkZG4bvoDi25EcJjbfOrBbgOHVTpnP+Jkk2AUIUBafk/rZMNR/TzaJe3mOMA38133liYGYhRftleia5IRXEd9Hzd9avAIPDnr8mNFk5t7WrmVaqYQXL7ZeauvZg6lgfGL+3Z5Hb3YFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NiZY5C6O; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so3218402a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720502104; x=1721106904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sOxAsVn43J6UpGnYmdp9+zQbgWtHk77XaVfxeI89xW0=;
        b=NiZY5C6OQMuNb6zxCZb5x+IUbLlJdeKErjVXzpvJTpQ/Kfh76XiQZrvdWGEE82BQXh
         Bw10gJFSU78rGF5Wtpku0BPNlHBYje6RS2WuOphrZOm1ZYbs853jvDKS+xjDEMO7rhwI
         BC+Qg+rm92zwu4ZRMv9xa7RM6GFuNylSHphPqCMK3y5PnMR20YjO0iGhdgC2TF8Gzji9
         Oix9A0vGmVS5YJ8W8wxaKswsO1m9ThCnepfl+0E4+adAVeC3klT1b26fvrGWlmEovbfm
         s4tJR8kmrV/Wvu2ne3cx2WXbX0wkKp1bjXoL8vd9cC0lo50hYiL/UdNf/iasRBW0Iylp
         MAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720502104; x=1721106904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOxAsVn43J6UpGnYmdp9+zQbgWtHk77XaVfxeI89xW0=;
        b=ZKNWE2GAChtXL2jt7as1x84/cP6V2zQ2ekA2X4pwWtk/Eg8Iqt0OXm3HPH9XItW7+P
         cNxPs9hi0CgxaIV7JR4I50bnaXKIuED/jqjhp4YpdHt0akDJtumiikeftEyG8Z7wbdHH
         yQaU+2yvof4Y2ILM3hRF0XWA52B2rsr3U+DFredIrlOhmwfg9rQwPRYaZnkHMBCgv+Fn
         gE2XAMb0/nxP83grXoI4+YI1FLS4+5ebaMkMj6lQySV+6zOEMiaXkfWDj3/dCvxae/IK
         OE7NNY17lmbUw/IIqg8vrhS/JKwzyAfTtO/2T0EZ0/1dmejcZBOJXzq2/Sn34EcAWVFM
         ouNg==
X-Forwarded-Encrypted: i=1; AJvYcCXyD9LLvaEdOX6QKnzQ5anKPdHLw89O3RJx263xbfbn++g6hAZDRc5WIN9WhMRTmd6uf+YFKjHrID77w7zpNQmNcLw0CHu5twtnnI3T
X-Gm-Message-State: AOJu0YzGMmfsl/fN9oF2XBXPcGgsDXEOQmTaS+wC3q1oE/vBhdgrQqOv
	YKnLYf27mtjqhZnLEd4GAZE81i/QMJ0M7Gq+fYIIoLD6v6IGA8jRbBUSJ5PUCA==
X-Google-Smtp-Source: AGHT+IFMPt2WcyXDbYXxbpB1uFGYlWS51hUTnzsaIrD7vrfdxxoFcZTdu7U1ZXRjpWQLeduAHLq8ig==
X-Received: by 2002:a17:90b:1049:b0:2c9:649c:5e10 with SMTP id 98e67ed59e1d1-2ca35bca181mr1425092a91.10.1720502104337;
        Mon, 08 Jul 2024 22:15:04 -0700 (PDT)
Received: from thinkpad ([117.193.209.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca352c5bd2sm912487a91.40.2024.07.08.22.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:15:04 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:44:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: qcom: Prevent potential error pointer
 dereference
Message-ID: <20240709051455.GH3820@thinkpad>
References: <20240708180539.1447307-1-dan.carpenter@linaro.org>
 <20240708180539.1447307-3-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708180539.1447307-3-dan.carpenter@linaro.org>

On Mon, Jul 08, 2024 at 01:05:37PM -0500, Dan Carpenter wrote:
> Only call dev_pm_opp_put() if dev_pm_opp_find_freq_exact() succeeds.
> Otherwise it leads to an error pointer dereference.
> 
> Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1d36311f9adb..e06c4ad3a72a 100644
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
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

