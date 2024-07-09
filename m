Return-Path: <linux-kernel+bounces-245181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755A092AF5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD6E1F21E86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE317139F;
	Tue,  9 Jul 2024 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0nh4MA2"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9293F9FB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502151; cv=none; b=QVbhthvEoxbTdhs2xNlEB+SZF+D9m00JyjPOJkyMWBs+Pqc8uqh9MOwjodOZxwUky59XgsZ48A9ANiyGThjUtKMHROdnhVq/FhergB2YjSvqkN2fX/qXHG7uN1SKruy9xLYKNeONns3T2CVKm4XOYLK6uDYKkYYYYwz1eSPuLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502151; c=relaxed/simple;
	bh=P7OeQP7c9HqgK2yLsYhiPWT6hYg1DVYUTG3lGVemS90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7L6LG5M7Z9Ierp3rI+WnP5NVy8a+OMuhZUmPQTPUlTOLdBLX4KRPvhOCvUFixcXOY4rrWpzmGM9X7ewVTsizxkKd7P5ybw2foJYd+rXlG781WGg2R5hw6tlrCdhCTZOGeary+RUGBU6nAyYS+e+Mwtqz5KtOd22gwsmETe/uvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0nh4MA2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso3432931a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720502149; x=1721106949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xDLPivrmkjKyg2q4jQZy8nP4kzWQRBZ8m1RjyeeDtNE=;
        b=q0nh4MA2YgLcxfv61xgbOZDaE9opkE+uRymic/YLbcqNt8vFp+ACYurmNiTGYPTTLD
         NJqM+RnmlQj5qOTAk3t5Pk/jci+tmfqARcB7+HmNGJRrJ7YkqkQf8G++nPWuwRJUugdg
         Yri79TuHTZB4G/KFnk2tkryZ/+f02thWxS3vpLnXaIZo0S1tlOwLOIuAynPIUCjT9l0c
         YQxch9CJEweRYXIqA1Wq2OutHuX09xxDzMkNZ+mVSCc5FA7qRjF1VB/A2EpVHWjnjcKq
         2McuhHopgXH3BJlkZCrsfFrqtaX3WBCG2dZZDkOWYvPtshetT5TYVJtFBjaxvtc2YHc3
         2low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720502149; x=1721106949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDLPivrmkjKyg2q4jQZy8nP4kzWQRBZ8m1RjyeeDtNE=;
        b=cRZXQHyVnBlKdgPJbJ9IAAhiy6W1e9al+bdExHQTBJ7DxVL0hwc2rYx50N0BMCjR9D
         +v6shZplf43dj94R8w8w8MWwKgh+4i9AC1gPHUrbMdLO77HcVHwN7Y/6qQCoGoiFL6UT
         yu/VLeFt1XrtUIb2bgJdHmbITwPYgo8+IK/cc++ddMMYf3M1l/XHPg2Qf1OCOiTyhd/B
         Tfy8AkdtbFQHtRyBdGnLIC6bvPJntubyIpJnLEtWAgnM7xcryzzj7M6uvNWTmBbIhrwM
         MMe2ZPIsg9q8VNNxdm3oRw2ERNJfakgtRpOWmJbi4ty/MPgtw9mvXYEY9hu3/Xdn96JH
         gL9g==
X-Forwarded-Encrypted: i=1; AJvYcCXt/ZGoz6V57NVjTuKdal5vninoJOD6gZBeR+xrwi1ti9ZICFePUGmUPRrPRLeVNE23iqhSKegcuWMmMY31LFn2NXugWHQ12uBKl1e1
X-Gm-Message-State: AOJu0YyJiopsYJJyyYBeWYKGsxdR+FbvWprqdB+NqL9Fiv2/r3mrGO2/
	ktbtpgy0ifajg8kaiCkztuSNP7GBHR07F9hW5VTOUzwS9X4T0p9SDhgwzJRK2mtvdHnf2DWnF2w
	=
X-Google-Smtp-Source: AGHT+IGdB/mSqtlNzgyqtDYVfh5FespmcM82pecp53Uky3WSQDR7yhPKobzUwLPTl1k6IYZxsBLaWg==
X-Received: by 2002:a05:6a21:6b0c:b0:1c2:3843:c7a with SMTP id adf61e73a8af0-1c29820c0dbmr1605818637.8.1720502149071;
        Mon, 08 Jul 2024 22:15:49 -0700 (PDT)
Received: from thinkpad ([117.193.209.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a1085dsm7259775ad.29.2024.07.08.22.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:15:48 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:45:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: qcom: Potential uninitialized variable in
 qcom_pcie_suspend_noirq()
Message-ID: <20240709051540.GI3820@thinkpad>
References: <20240708180539.1447307-1-dan.carpenter@linaro.org>
 <20240708180539.1447307-4-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708180539.1447307-4-dan.carpenter@linaro.org>

On Mon, Jul 08, 2024 at 01:05:38PM -0500, Dan Carpenter wrote:
> Smatch complains that "ret" could be uninitialized if "pcie->icc_mem"
> is NULL and "pm_suspend_target_state == PM_SUSPEND_MEM".  Silence this
> warning by initializing ret to zero.
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
> index e06c4ad3a72a..74e2acf4ae11 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1633,7 +1633,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  static int qcom_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * Set minimum bandwidth required to keep data path functional during
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

