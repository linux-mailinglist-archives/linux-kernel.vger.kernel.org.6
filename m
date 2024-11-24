Return-Path: <linux-kernel+bounces-419988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A99D7412
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C60D286D34
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8DC238F73;
	Sun, 24 Nov 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RfPNRz0x"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E712389D2
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456297; cv=none; b=EsZPAAltnjpfOzWS48+K6iYmeHwNWRayhiFywwqbv4F0ceXiv+8j6/uJtIceKz3SFO1X8X1YkXtEcy3M3jMtXwmeFlAp+IrC6+83hbM9uIOdLkcWwBra6j1oxLqFXbrFdNLIXkoY06fL/rHIPe2HFZjyqzajH9y1Vng6SbQUbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456297; c=relaxed/simple;
	bh=RJsjqr4IiY7Cv7vF7lbpxYrASAZu+7fQCrywo7wd1cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWU7OIDDOACarbUpljxkXbI+OIrruZweGo7at0QzCtRe4pC4SISINL44Tsm6WG6rgELPoTME7rkGkqvRE6E2kZAU2cVRDdnKJ4KRuXBT83pB0wQ6gXAJ6n5VPj4fLbjEA3lZvZEgLArCXJ1PQAd75YJ7/ugJtTNz+gVo/Ktm8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RfPNRz0x; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so2602099a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732456295; x=1733061095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvwL6kRJHjUocjJpIPTlFq19Lrj3E/Hany+pDs45/JI=;
        b=RfPNRz0xxjGkUukk2In6l/k+hHshtemkI7sP/bnALVANPNcaPYfZnuQNHuh73k1WVg
         /P0NHyshz6CedPEjs65XbhIzktV2hlvdzYVniEyJeuOLVHRbuwM1dodDz0tZEz+31i/O
         WmkKu9U/MvSeUh2qEcWglRHDeeSO4b3MMob06H6OkOJ4boYnIaCbZYSCpFOGg6/d+6XE
         uL9BvWQhh2txuANQDHLcERBgAXugq1kJzpbxMgqErQGTYZag80jroDV5J5X3sS2JVD3S
         id+7nlvq7B+S9z3ET7oiWfoX5DiH9oZqZZvpI2IX5dP4A8PltPT+eODuw/iph35SG4h/
         eVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732456295; x=1733061095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvwL6kRJHjUocjJpIPTlFq19Lrj3E/Hany+pDs45/JI=;
        b=rm2vUqgp76YpjD7eBzVZGkVdSfMtpn+nz92MWEF+BHsGW03rAzFfLjwv8h3iM+nu0Z
         pVQuh3olCFD2IidHCAgTGWuteLMiKcztjYrzdpayS+KPkCpmEu18LtG0pqB1Si7cZfsa
         wv54k6/mvCdF/EkPjBeK73WVNfjYoQgJ/Gf4UUwbKEkPRD3mCVfd2ioccAupJIOoiL9c
         BBnUHblfW7ko4Lj6bEE1sKMeruSVU6JXfkMQGd0pY97hRH35w3YA3IFfj7Fh2asiz5lV
         Slwp9I+VMwbQ0bS6UtsBEnWJhndkNEDZrEWn2s3LJ4BKzVgMRoO1RbOrTdNcGgyKaE86
         Hfxg==
X-Forwarded-Encrypted: i=1; AJvYcCXvCy7wY+cEPYQCJn3iQuz9+rMVnTroNEhKV6gNmEZ+831bGFzmsenBwWTrUBbvrQKd2whrZgHz3HtjNRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RUm330IWRJ2JdvznwtKEPKxcH5Ei3Rw49JhEzKj/WyzXS59R
	lys5ViIAIMsFOfa+6IkTwaxOMdOTWxoNDIR5B5uq0cNBEYtQaZiIlOnn7BiFxQ==
X-Gm-Gg: ASbGnctLXR4Isj/Akln4wGpHLmfgyINlRbU0gl7VvASkSly/yu8fP/MSI8WFvJzUeJ+
	+F67iwQkg+QxsNqyuSa2lLgfjSacTxIyeyXN809b6gYElTBl+wZV+p+imyLQ2YoFFZRAxAtVyhV
	n5lrs0Qju/HwsP+KTwpie82+5IZ/gt/RjrhtYmCjjVV1+9D0jOkEIXvt7lN1d8Q3kiLdD+tgCJ+
	DqElX6xtljL+XGAk/mx+ymn70IyjWMXcsnV6ocBt43MAlOSOCyNmWzu1Dl1
X-Google-Smtp-Source: AGHT+IEzlys82+csTBT6VGLCobeegey4e2aYC2fZg5o/NAz2y+kFhnSKiB+ktDAdEDxDDXN3XKTHYA==
X-Received: by 2002:a05:6a21:338e:b0:1d6:fb3e:78cf with SMTP id adf61e73a8af0-1e09e631698mr12401964637.41.1732456294822;
        Sun, 24 Nov 2024 05:51:34 -0800 (PST)
Received: from thinkpad ([36.255.17.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3ddc8bsm4787668a12.60.2024.11.24.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 05:51:34 -0800 (PST)
Date: Sun, 24 Nov 2024 19:21:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 5/6] misc: pci_endpoint_test: Add doorbell test case
Message-ID: <20241124135128.775zh3xqkrajzvn4@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-5-6f1f68ffd1bb@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241116-ep-msi-v8-5-6f1f68ffd1bb@nxp.com>

On Sat, Nov 16, 2024 at 09:40:45AM -0500, Frank Li wrote:
> Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> and PCIE_ENDPOINT_TEST_DB_DATA.
> 
> Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
> address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
> feedback.
> 
> Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
> to enable EP side's doorbell support and avoid compatible problem.

Can you explain the 'compatible problem' and how this patch avoids it? Just for
the sake of completeness.

> 
> 		Host side new driver	Host side old driver
> EP: new driver		S			F
> EP: old driver		F			F
> 
> S: If EP side support MSI, 'pcitest -B' return success.
>    If EP side doesn't support MSI, the same to 'F'.
> 
> F: 'pcitest -B' return failure, other case as usual.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change form v6 to v8
> - none
> 
> Change from v5 to v6
> - %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g
> 
> Change from v4 to v5
> - remove unused varible
> - add irq_type at pci_endpoint_test_doorbell();
> 
> change from v3 to v4
> - Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> - Remove new DID requirement.
> ---
>  drivers/misc/pci_endpoint_test.c | 71 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pcitest.h     |  1 +
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee2..dc766055aa594 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -42,6 +42,8 @@
>  #define COMMAND_READ				BIT(3)
>  #define COMMAND_WRITE				BIT(4)
>  #define COMMAND_COPY				BIT(5)
> +#define COMMAND_ENABLE_DOORBELL			BIT(6)
> +#define COMMAND_DISABLE_DOORBELL		BIT(7)
>  
>  #define PCI_ENDPOINT_TEST_STATUS		0x8
>  #define STATUS_READ_SUCCESS			BIT(0)
> @@ -53,6 +55,11 @@
>  #define STATUS_IRQ_RAISED			BIT(6)
>  #define STATUS_SRC_ADDR_INVALID			BIT(7)
>  #define STATUS_DST_ADDR_INVALID			BIT(8)
> +#define STATUS_DOORBELL_SUCCESS			BIT(9)
> +#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
> +#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
> +#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
> +#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
>  
>  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> @@ -67,6 +74,10 @@
>  #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
>  
>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> +#define PCI_ENDPOINT_TEST_DB_OFFSET		0x34
> +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> +
>  #define FLAG_USE_DMA				BIT(0)
>  
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> @@ -108,6 +119,7 @@ enum pci_barno {
>  	BAR_3,
>  	BAR_4,
>  	BAR_5,
> +	NO_BAR = -1,

I really hate duplicating this enum definition both in EPF driver and here.
Maybe we should move this to pci.h?

>  };
>  
>  struct pci_endpoint_test {
> @@ -746,6 +758,62 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  	return false;
>  }
>  
> +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	int irq_type = test->irq_type;
> +	enum pci_barno bar;
> +	u32 data, status;
> +	u32 addr;
> +
> +	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		return false;
> +	}

Is this check necessary?

> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> +				 COMMAND_ENABLE_DOORBELL);
> +
> +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> +
> +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> +	if (status & STATUS_DOORBELL_ENABLE_FAIL)
> +		return false;

I think we should add a error print here and below.

> +
> +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
> +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> +
> +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +
> +	writel(data, test->bar[bar] + addr);
> +
> +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> +
> +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> +				 COMMAND_DISABLE_DOORBELL);
> +
> +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> +
> +	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> +
> +	if ((status & STATUS_DOORBELL_SUCCESS) &&
> +	    (status & STATUS_DOORBELL_DISABLE_SUCCESS))
> +		return true;

Usual convention is to check for error and return true at the end.

> +
> +	return false;
> +}
> +
>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  				    unsigned long arg)
>  {
> @@ -793,6 +861,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  	case PCITEST_CLEAR_IRQ:
>  		ret = pci_endpoint_test_clear_irq(test);
>  		break;
> +	case PCITEST_DOORBELL:
> +		ret = pci_endpoint_test_doorbell(test);
> +		break;
>  	}
>  
>  ret:
> diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> index 94b46b043b536..06d9f548b510e 100644
> --- a/include/uapi/linux/pcitest.h
> +++ b/include/uapi/linux/pcitest.h
> @@ -21,6 +21,7 @@
>  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
>  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
>  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> +#define PCITEST_DOORBELL	_IO('P', 0x11)

I think defining PCITEST_CLEAR_IRQ as 0x10 was a mistake. It should've been 0xa.
But since it is a uapi, we cannot change it. Atleast add new ones starting from
0xa.

Niklas's consecutive BAR patch adds a new ioctl for 0xa, but we can fix the
conflict later depending on which patch gets merged first.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

