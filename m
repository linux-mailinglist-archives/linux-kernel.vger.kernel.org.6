Return-Path: <linux-kernel+bounces-515420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994BA36493
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F0F188E34D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EC92673B9;
	Fri, 14 Feb 2025 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTQTHXQa"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB2267F4A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554184; cv=none; b=BL3lKiukPCzAKXzoWOp2Rn4WJPfs6xkKFvZVWg+5Xz5cBQ9dw+I3c/qgRNS9TTMiH441Z+IuOQe1iAeAkSbDKIVSK7hflFIqUrCNcsJOO0cUaaOfU+vm5Ml9HMd4ZQCjiTaAB79ferWDpB7ooPbrgJKc1diD+c2QMn6ApoJqmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554184; c=relaxed/simple;
	bh=LWxIuFXSX9m8GW5L588vDhQDC6zRy0K40LKOopQ0mpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ7OWo0UQ+WWgmiyuRc92P21oIuz4qp/CsZlylg0FKA4WBPqVKemLOp7uyjvdIdRhFP6L0TdaenlYFQYgLt4ugIVAo27LPRbj74Uap5RRCxdhfSl9phhM4VS9gNuWAbdKVu0wue1M7+6seEn4xksk1jhWNiIe2EiZRZq2VigxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CTQTHXQa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f44e7eae4so45306395ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739554182; x=1740158982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ELI/xEjw1uh6b74BcnUgTJCqcnXwKg8w1E10nnathDE=;
        b=CTQTHXQaehlxaItgsw2MpQPNJBMlRbBRg4/XIkB13GIS7y5RQdx8UYe2I8GVYaPcoK
         ror6nNlGThAfpUsSDlQe2hQu365ndVsX1XJXHDrbLuMo/x26CuPPmh20qf/WKqVs78E+
         FLwGsJ1GVzBeF4Jd937BTWJTvyMJACvtEu9CM1KLFY60BeGGRSdp6DetlhnFM9Uk9pbi
         VDUUiSLsp3PJxvdQDMq2IAn4ObJfcQWfPlET9dA2TROcsjddxmveVT9xJz16NKEPjnHU
         SaROsuQ2glk/5IZq7LzFewACY3jUI2W6PaBzwKakqIZfAyJGXHTmKBsLzBaYGDnSIuGo
         dcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554182; x=1740158982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELI/xEjw1uh6b74BcnUgTJCqcnXwKg8w1E10nnathDE=;
        b=JGxlXTEd0Mx2AFtnsgmuYUBAWnDuBCUQlwnGbcmfqBdcRGqxu20B2OurluZ2i8HEFO
         G0VcGYhnhL7CWZR5i3iF9QGi15oyUv60+rOhq0CVdH3NLoFU0f/RND9vbiTi6BshZWSk
         5zlSRpUm0BWYHfx9b3HpjNTlHrIrihdyKkeCQN5PZ3iAYWpXBhcEOcp7W/oiRn0/t1pn
         /29nkPuqlE1Zg792KwqojO6OjnYMLc/1ZKpkcUDxKiS/cL+QjoldCFL6DVJbcpVOdm0h
         PRM8p6/dSqODTEg/PT6NPcWKaUgU2C8ysh4nXOlGVhQVV1iDFUrR//irtB0WLxo9Vy84
         cygw==
X-Forwarded-Encrypted: i=1; AJvYcCUNP+yqWvWvXDJKClJY9+9nA/RYTJp6N08uHMkCv5NVQyb9JjbM4+kxtqSaJQ1TBhkc8NwIE2NdpvfxM7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnB1ZopL9bPQ/g2td/yDg2mqlNJqTRY7fAvmax+oF1cFApgXZ0
	SqQtGhBLfiPCZ903CidSj1XEoxZc3SQtvXAuJywG4kPXi0nE0E+H8Udf+/Bbzg==
X-Gm-Gg: ASbGncsY7fyOVre6atxpkEKzfwk1hP+N9yoVVihIcp9A+rMAU4vrz/a1o+vHrbBt/x2
	ZcyPDFym9DoGo7fSq7CNUAyYMcAy/5NmiDELU9+HdARy9cM9IOg+LHFIFJ+XlxECdaU1pnIgFqo
	o2wTZl3TU3cKVYdd4CJxF9aWd6I+/YRDG1hqMNU/pg7p/MYbE3GvR6j0kZF3x9mBouldmff0zTa
	07vZ+rxb42L5OV+mOctHaK/XUo79j9Butd+l5BKToArj5b/A1bLrtwJHzaOedInC2lDbfqehxVg
	4NdO2zWIC/AdqDp3AtVWNb0W1bA=
X-Google-Smtp-Source: AGHT+IHNABlhUNAWdSjcRb/hYy/2fshtO9XklLTg0TKpN+C9Gr2+9CK/PpINy5rWODndFowOuADONg==
X-Received: by 2002:a17:902:e5d0:b0:216:3c2b:a5d0 with SMTP id d9443c01a7336-221040a4d45mr522085ad.51.1739554181042;
        Fri, 14 Feb 2025 09:29:41 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556dc4bsm31421075ad.188.2025.02.14.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:29:40 -0800 (PST)
Date: Fri, 14 Feb 2025 22:59:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] misc: pci_endpoint_test: Do not use managed irq
 functions
Message-ID: <20250214172936.4l24mwry2efm6dyy@thinkpad>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-6-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210075812.3900646-6-hayashi.kunihiko@socionext.com>

On Mon, Feb 10, 2025 at 04:58:12PM +0900, Kunihiko Hayashi wrote:
> The pci_endpoint_test_request_irq() and pci_endpoint_test_release_irq()
> are called repeatedly by the users through pci_endpoint_test_set_irq().
> So using the managed version of IRQ functions within these functions
> has no effect.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 8d98cd18634d..9465d2ab259a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -212,10 +212,9 @@ static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
>  {
>  	int i;
>  	struct pci_dev *pdev = test->pdev;
> -	struct device *dev = &pdev->dev;
>  
>  	for (i = 0; i < test->num_irqs; i++)
> -		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
> +		free_irq(pci_irq_vector(pdev, i), test);
>  
>  	test->num_irqs = 0;
>  }
> @@ -228,9 +227,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	struct device *dev = &pdev->dev;
>  
>  	for (i = 0; i < test->num_irqs; i++) {
> -		ret = devm_request_irq(dev, pci_irq_vector(pdev, i),
> -				       pci_endpoint_test_irqhandler,
> -				       IRQF_SHARED, test->name, test);
> +		ret = request_irq(pci_irq_vector(pdev, i),
> +				  pci_endpoint_test_irqhandler, IRQF_SHARED,
> +				  test->name, test);
>  		if (ret)
>  			goto fail;
>  	}
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

