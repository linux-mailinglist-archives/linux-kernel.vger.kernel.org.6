Return-Path: <linux-kernel+bounces-410580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3A49CDD83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA95CB27EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379BB1B4F0D;
	Fri, 15 Nov 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSs9mHKw"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C05188012
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670260; cv=none; b=ugOzvcp4XySze8KoP+uuCLWteLz5MCR+SwOKpoq41llu6LSdyHAxVrV8auhapx8s5S9mpOq+lKer0kCpiUuuOWgUXfP36p1qI72ufJvwV4ucjtAHcrQddmL/kfaz/53mHZf545TgttY0iQ1nXaeqtnHfjhiMxHLNfdt8NOTbmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670260; c=relaxed/simple;
	bh=ehimFfDv8UtuMolhRzUjFj2kdev4ObCL8UCE6beSYno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxKau2jLylzZbd3xwyocx3nJ2+ch14pS4RHte06fpNYDCsNHHiwHR5GSB3ass+C4RYYrLHPV804ZXUzED71ImieaPN77iTWLdApD94mC+4e5HGdLwjY4q9rOiNy9Jo4X6mAm7fJALR1NEqz+1DYu40tvRqySummEFbeA4ButMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JSs9mHKw; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29066daf9e2so847561fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731670258; x=1732275058; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mBAVDm/HyIJeKw4QrikaI8e3Ha7FEO3BpZ5rP20QtvA=;
        b=JSs9mHKwawDdDHSJCGm9fNvyIbwCeKVJGV4KilUafBDR/9AdydIb8s9DWCPVJ+CWuX
         H+gpEkxMAibGoHMTD/xC7a1dMj3fDoJ722C/6DCpA7ygh78Qx1biAUyXLJlAQ95UuZ3s
         DW98O6JN5L6hvaciz78WyACyWT60SD2C65R1hIj3ZdV1MEoTkjyZXRJoP77niG1PLW1X
         G4qplObCZFvfep8Vva5LPNJ8ipnGIPXoASS3pKJjZ7L+IpMl74K341kQ4pc+r6548DbS
         FGrCVJ91AFw383+pKGqbmXwhp5MV+/0FbueuBiJ1ISL7PpxO92ToaUT6fVO3Gdzu/3Kq
         /X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731670258; x=1732275058;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBAVDm/HyIJeKw4QrikaI8e3Ha7FEO3BpZ5rP20QtvA=;
        b=CBNOYJMFowc3r9XvnQRBtDFCNhy177VPuWf1liw6JZJGFir0wx2bMtJgXQDOfXOpDW
         ySvRHvIUvEfQoasPfT9tgt4kXODkivutwm/FJzgcZJy6My+UO/Z1bfr9g1HBPsbW4a1V
         Rdpr1KyPWT4EqpcO5NSErH0v5cUcM3xSNk66eRE4NMoFjlSxippY6YrNkAHbGQj6egvc
         HjOjhyWpeKCOxxp8kbZFb44YSYPt88jFtoFS3SvDZ7Gf1jsQXXbRWD3ErUOONNq0Y71g
         CHqgo+nni5HUep6dRvlqopaG8e7yleLOwQmRB5EYykRK5Zc/UrQIDafHPSqxfOexA/ee
         lzUA==
X-Forwarded-Encrypted: i=1; AJvYcCVRdjahl2btwPIsxgOUIBgmy+f8K6GDqQs1US0hApI0gDgiC0fkhP3+pjZBm4cTwAczmMBZNqS1iTbqHdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTQMoMZbzlo2/e0wJp3ASvwddZXePuGnKDu1dRWikppihAkUI
	reZwtE2GVdJlHI9DonMuWW5jcn6f/IqbShvm3hhpvYeVIY0l/58xLapK6xRTvg==
X-Google-Smtp-Source: AGHT+IE/ge20qog0yFxzgEC24YLSYbDvu7K76ATAApaSYqzivIdSAQP0WbgXkAqH6fbnKdHOzoo0iQ==
X-Received: by 2002:a05:6870:514e:b0:277:7147:26ff with SMTP id 586e51a60fabf-2962e2899d8mr2475887fac.35.1731670258074;
        Fri, 15 Nov 2024 03:30:58 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dae95esm1056828a12.58.2024.11.15.03.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:30:57 -0800 (PST)
Date: Fri, 15 Nov 2024 17:00:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: helgaas@kernel.org, kw@linux.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: PCI: Fix several incorrect format specifiers
Message-ID: <20241115113050.z7agp7bw2mc5uz2i@thinkpad>
References: <20241112090924.287056-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112090924.287056-1-luoyifan@cmss.chinamobile.com>

On Tue, Nov 12, 2024 at 05:09:24PM +0800, Luo Yifan wrote:
> Make a minor change to eliminate static checker warnings. Fix several
> incorrect format specifiers that misused signed and unsigned versions.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  tools/pci/pcitest.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 470258009..7b530d838 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -95,7 +95,7 @@ static int run_test(struct pci_test *test)
>  
>  	if (test->msinum > 0 && test->msinum <= 32) {
>  		ret = ioctl(fd, PCITEST_MSI, test->msinum);
> -		fprintf(stdout, "MSI%d:\t\t", test->msinum);
> +		fprintf(stdout, "MSI%u:\t\t", test->msinum);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> @@ -104,7 +104,7 @@ static int run_test(struct pci_test *test)
>  
>  	if (test->msixnum > 0 && test->msixnum <= 2048) {
>  		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
> -		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
> +		fprintf(stdout, "MSI-X%u:\t\t", test->msixnum);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> @@ -116,7 +116,7 @@ static int run_test(struct pci_test *test)
>  		if (test->use_dma)
>  			param.flags = PCITEST_FLAGS_USE_DMA;
>  		ret = ioctl(fd, PCITEST_WRITE, &param);
> -		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
> +		fprintf(stdout, "WRITE (%7lu bytes):\t\t", test->size);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> @@ -128,7 +128,7 @@ static int run_test(struct pci_test *test)
>  		if (test->use_dma)
>  			param.flags = PCITEST_FLAGS_USE_DMA;
>  		ret = ioctl(fd, PCITEST_READ, &param);
> -		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
> +		fprintf(stdout, "READ (%7lu bytes):\t\t", test->size);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> @@ -140,7 +140,7 @@ static int run_test(struct pci_test *test)
>  		if (test->use_dma)
>  			param.flags = PCITEST_FLAGS_USE_DMA;
>  		ret = ioctl(fd, PCITEST_COPY, &param);
> -		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
> +		fprintf(stdout, "COPY (%7lu bytes):\t\t", test->size);
>  		if (ret < 0)
>  			fprintf(stdout, "TEST FAILED\n");
>  		else
> -- 
> 2.27.0
> 
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

