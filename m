Return-Path: <linux-kernel+bounces-560034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB69A5FCE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FAB16FDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767826A0F7;
	Thu, 13 Mar 2025 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMx8oSY3"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83E1581F8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885267; cv=none; b=iSiXIO1Ab7tNUsj/gfKNoJDRcIKikI3CUTkgjz2t0t4si1Bwhw/BSSv5cWO1NrvITtfR3a0uWldAaqfwysgMXg3qjSYtLXFYHJCuwe0izAMAKSUJZaoxrerjFson/prbHYuR4yQ5NwexmpRUPjhtChdvpUy0NjGCVRTAyzkbtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885267; c=relaxed/simple;
	bh=VHxiw1iOPaehIdCmiB9jD7hA9jp4hpkFvH2VdqlEv7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd0M1MiHW0X7cKi8YiNi2RAWpoqkM7HhS+U+R5+DIr8MVM3oAoQUVyYArpxk/thrt49vn/2iUj9kpihrTx5qTNnDyCcKL2ZB0fYTq77mosFUOuDFHFRAejVALGNzia9QZ+JOpXUjCUCMf/Z7YXnnwT1zIzMueE+kgmeUl9PWaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMx8oSY3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223594b3c6dso24510945ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741885265; x=1742490065; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ENSH6oEAjz00ZnZknt14hjq4bTe+aXnnbXc59If/D0s=;
        b=QMx8oSY3t0s4thGL2cm25475tnOfDx/tj4RMrib71I0TkO1jqotrZVoiv5b2o783Db
         ZCTVGj1O8DGt2XHVf29NbbuXAYqc2JCKsqWL5ztBm/R6dxaT4nlakWdxtDmtPYeE8QPg
         OZlEvt32gymuXeLYDvIx+UYSnEOf5HA0KTTpmNH77ErvOwTey54v4F/bfj0OiSYggdSv
         8M40WN/tVTifSnZQbrB7yfkrxHTkWYVPAJATwJge2UKOytRF8izPZPkGM3GJW06upIGr
         yHseYivuB/6jNUUAmQ3YXBQCGp/YLXT/wJWVPUFFwGX7PknPVhN0wlRN5aQNyVx0OcTW
         UqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885265; x=1742490065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENSH6oEAjz00ZnZknt14hjq4bTe+aXnnbXc59If/D0s=;
        b=vh12s9wkw48yqC9DmRyh1ItEiXehVB8cee4t/z6kBTptmV7c+gAGpMwhbTE5CAKsTx
         f8NQwjl7xsER0mmkxwQEJxe5TsOpaUejLNWsqg1Tg4CFqUCj02YvloqYARN+1gDh3GQO
         evaSnoSAt2sz002dX6Ab/Ce83SaYyQjQdYyv+ugQmw+/bARJw79dF2P0jWG6YMFX2by2
         t0YCH0aQN/O248dXr7zbprNZsWDbfLUbrFKMXZAzowG5idc6rr3w8TYbiMbSv5qmykRF
         WRK1+qusDY4cKr3VTTvNDnQr4oDiHazmbfuVHLtDqeG66qyJi+w+fDYaTtO8PGcjqDDj
         8GUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPRUeVFO8tx76YH+9Gg9uP39AjxuNIH47PTWtSLRMVZ+Eq9RV7+FxxYbCiqH+2DukxY2wu7TcYnli8BAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZzvQh3x9WJ1Bzef9naLBgCAbB7rDnk32S4VI5UpfnvsePXYeD
	sVRAvzs/bxo6TSNlM1ysVG7ivr4PsMeS4csrNHnUjl5QFArrKPcYejThTe82Jg==
X-Gm-Gg: ASbGncvgriBA18tl28GewalOZNEJZE/voD7ZbTTcj70JDeTnTxDW2ROYJpMf5skU8XJ
	uMFkwP8BWRdUqAWO7oQMmlOM8egxDxeNB8Ozbbvl2/9nhRRn4E+cOc9VaWB6yQj40lsJEx1W9ri
	nBK9h4NT9VqxGkQUorS6j7ag4hNBprw95mL3x6DcCD+b29/0izawHVlGV2J0VlN9qMlNcIdM5Bb
	C7YOR2c+b619NuLohShyXkzwP1tdZ4XusnoZ0tn5oiGeC21cROQaO9Y54fiHk3SLu+a8O4aA3XZ
	Rvg6IK5KMKect1qXHimtozqyNyFdkE61o9FPz9Fxzniz9+zYusdm1Q==
X-Google-Smtp-Source: AGHT+IHQMTcJPPra4QR4Z982bc4UAA16JNaqY6kNLE7y6s4ubR1yWd0wLKsyohPsCDtXtyVOiDNePg==
X-Received: by 2002:a17:903:2347:b0:21f:988d:5756 with SMTP id d9443c01a7336-225dd8cb8ffmr2797435ad.42.1741885265127;
        Thu, 13 Mar 2025 10:01:05 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167def8sm1616117b3a.90.2025.03.13.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:01:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:30:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 5/6] misc: pci_endpoint_test: Remove global 'irq_type'
 and 'no_msi'
Message-ID: <20250313170058.ncixyafsse5ry7xh@thinkpad>
References: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
 <20250225110252.28866-6-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225110252.28866-6-hayashi.kunihiko@socionext.com>

On Tue, Feb 25, 2025 at 08:02:51PM +0900, Kunihiko Hayashi wrote:
> The global variable "irq_type" preserves the current value of
> ioctl(GET_IRQTYPE).
> 
> However, all tests that use interrupts first call ioctl(SET_IRQTYPE)
> to set test->irq_type, then write the value of test->irq_type into the
> register pointed by test_reg_bar, and request the interrupt to the
> endpoint. The endpoint function driver, pci-epf-test, refers to the
> register, and determine which type of interrupt to raise.
> 
> The global variable "irq_type" is never used in the actual test,
> so remove the variable and replace it with test->irq_type.
> 
> And also for the same reason, the variable "no_msi" can be removed.
> 
> Initially, test->irq_type has IRQ_TYPE_UNDEFINED, and the
> ioctl(GET_IRQTYPE) before calling ioctl(SET_IRQTYPE) will return an error.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 896392c428de..326e8e467c42 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -96,14 +96,6 @@ static DEFINE_IDA(pci_endpoint_test_ida);
>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
>  					    miscdev)
>  
> -static bool no_msi;
> -module_param(no_msi, bool, 0444);
> -MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
> -
> -static int irq_type = IRQ_TYPE_MSI;
> -module_param(irq_type, int, 0444);
> -MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");
> -
>  enum pci_barno {
>  	BAR_0,
>  	BAR_1,
> @@ -833,7 +825,6 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  		return ret;
>  	}
>  
> -	irq_type = test->irq_type;
>  	return 0;
>  }
>  
> @@ -882,7 +873,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  		ret = pci_endpoint_test_set_irq(test, arg);
>  		break;
>  	case PCITEST_GET_IRQTYPE:
> -		ret = irq_type;
> +		ret = test->irq_type;
>  		break;
>  	case PCITEST_CLEAR_IRQ:
>  		ret = pci_endpoint_test_clear_irq(test);
> @@ -939,15 +930,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	test->pdev = pdev;
>  	test->irq_type = IRQ_TYPE_UNDEFINED;
>  
> -	if (no_msi)
> -		irq_type = IRQ_TYPE_INTX;
> -
>  	data = (struct pci_endpoint_test_data *)ent->driver_data;
>  	if (data) {
>  		test_reg_bar = data->test_reg_bar;
>  		test->test_reg_bar = test_reg_bar;
>  		test->alignment = data->alignment;
> -		irq_type = data->irq_type;
> +		test->irq_type = data->irq_type;
>  	}
>  
>  	init_completion(&test->irq_raised);
> @@ -969,7 +957,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  
>  	pci_set_master(pdev);
>  
> -	ret = pci_endpoint_test_alloc_irq_vectors(test, irq_type);
> +	ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);
>  	if (ret)
>  		goto err_disable_irq;
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

