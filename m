Return-Path: <linux-kernel+bounces-263210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD393D2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B686B20A11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9CC17B42A;
	Fri, 26 Jul 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuZlufqB"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201617BB07
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995239; cv=none; b=YJMh0Mw5MZF+8fE0vJ2Sb8q5Nt9XQARemrXPifwi1IJwUgsbjW5otzEMDmvvUyt2s9hFuhG42gAw5jcp4/DccY/CAXwUOyqo6rWmaIaqM2DuCH2UtwvY1JVy1p5ODMJcMBohRk1gK0bup3q42JF+uJ3lL9vZaF3jdjAWrkOnwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995239; c=relaxed/simple;
	bh=t3NW53ZkPecb65g7j6b0wRbYmlTbwnDzeBcUWc6cKiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKNjwA04dAr5usjluhGzPGPTT7x5DkGj2wiE8b5VeQ78CYFdTKtkc09dQCTcNyjWm2OfdvZ5btR+SwsxQRtnY19yfgpEHL8Am/A01+kKQqanEd+crlr4EwcN7vSvKjDn9zASrbH/nJI/NEsp9HdWmmqsD4YTNnD7mNh74HSqKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HuZlufqB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8036ce66164so43030739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721995236; x=1722600036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EPFRRW8AIlKuxP8Q7EZWY4b5/1cZ7kF3YNc7kBeCMNA=;
        b=HuZlufqBGFtw5tz/HtAUy969P3ORfDrEf4aXeT6Lbmre3BuoKNM/hpUGZGKgpVNw2y
         wklD9Bqi6jEGxv+g0qcBqbgAanr0FXJH/9i3Q9Dq4WJxDJHJIyvjEH84BZdOE8FCB0QJ
         U9LyRQT74gisK1+hEEjRnxFkEzbG8jfyRCKoKGVlnyJstNkjY9Xda3YV+VVWfJHUS+my
         4RlpQFpt4ClhjjBZ+O1no0SsOOJrZFDrMVMUMbdowyyZC4kXSKAUEWgt7UummJRyZpit
         nelCah4mh/Pt4qomvrJCBNNKp2RUKibjW0mhO34WR3nMqn+knFzuggwpdrdBjGO84MHF
         24gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721995236; x=1722600036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPFRRW8AIlKuxP8Q7EZWY4b5/1cZ7kF3YNc7kBeCMNA=;
        b=uRENcWC3BrNHO3y4fwRqFDnF6hZ6w9ozyaU95G1qY2QACKoSTjKcoXau85A6VTZMFI
         23yy2oToW7+Q8HIajtam30Pr5v7Hrwx2uH+bEsAOIVsIiqOTQgPbXrvyif0XPE1129L7
         s2jFfl4uwJRzrkYBI0Qy/rYZ3M1tnxtm+DKeUeqDypeA0Oex4MRZvToe94y8lgP+ZKhF
         ngK3xM/3ZIs7fsdZ6I5i2UaMgETWgMJ704Yxf/O0juY2Q3tR95kIoAclhbf5QHH/oiUn
         mihvf7+QrwOv1vfBMxhyZMzgbfN+c6R6Dzp6DXc9O00uBL3PUuMlgv6C3ilO6J39yXJF
         Z5XA==
X-Forwarded-Encrypted: i=1; AJvYcCVF4R+wgN4tgvEwZ5pGv4Jy0bWGlNK5LWycwCq5AGF2uJga2gbnrTaPhCTUTrEMUIbjcVdqx8FxcfyY3EUUtrXGT8hhDXPQLEUuUow9
X-Gm-Message-State: AOJu0YwBqBl7czRUhr7/D6kqV6UIkxPWRNA28ExVcHaAAz8/nYe/8WQM
	n+qdhc1q6ejqraCshtBHiO4SX69K0SXY7nW5z5QsDHhcddZdwQw4f35bgWYO7Q==
X-Google-Smtp-Source: AGHT+IGF1Vy8+vSXqTOa6id6FOH6iP3wriAe5OvwBBfxhoWQnfblL/Mji+X+LUi4afRVv7DXfGZn1w==
X-Received: by 2002:a05:6602:6d8e:b0:803:85ba:3cf9 with SMTP id ca18e2360f4ac-81f7e43ed89mr685325739f.10.1721995235684;
        Fri, 26 Jul 2024 05:00:35 -0700 (PDT)
Received: from thinkpad ([2409:40f4:201d:928a:9e8:14a5:7572:42b6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72bd1esm2623180b3a.96.2024.07.26.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:00:35 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:30:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Disable ASPM L0s on x1e801800
Message-ID: <20240726120029.GH2628@thinkpad>
References: <20240726-x1e80100-pcie-disable-l0s-v1-1-8291e133a534@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726-x1e80100-pcie-disable-l0s-v1-1-8291e133a534@linaro.org>

On Fri, Jul 26, 2024 at 09:54:13AM +0300, Abel Vesa wrote:
> Confirmed by Qualcomm that the L0s should be disabled on this platform
> as well. So use the sc8280xp config instead.
> 

What are the implications of not disabling L0s? Is it not supported on this
platform or the PHY sequence doesn't support L0s?

Please add these info in commit message.

- Mani

> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..04fe624b49c1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1739,7 +1739,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
>  	{ }
>  };
>  
> 
> ---
> base-commit: 864b1099d16fc7e332c3ad7823058c65f890486c
> change-id: 20240725-x1e80100-pcie-disable-l0s-548a2f316eec
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

