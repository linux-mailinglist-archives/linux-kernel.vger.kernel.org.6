Return-Path: <linux-kernel+bounces-419649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2F9D72FB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF56B3B264
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833C188938;
	Sun, 24 Nov 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ke87KqhL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA150188737
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732454236; cv=none; b=obqdaK7rHZewX4/16rtZXqjenGZQeHvifursDaFzTkRREpsilik+t00WmU7U4+xP9VtMwzFJOnJv0g5vLDD35jXHIP+9MvPLEWPzhcR7PjljlW91SX4ulUhHur+WfQGixlHaOHgv68iOGlocODeqeod6z2hY0JSA7PhVbg82a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732454236; c=relaxed/simple;
	bh=IlLv58cNCyEoanSXpkpsRvNx5ayjQp+gFk1gE15T0ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYQkzbIU4AASppJ/DmRZ6WLgekxcyZdDw7jddHPI7PWLZS4vIsWLszhZq3Zkt6INnaKpVrJh9h0AjkEHN4LPRlCSau3CnWJ7lTmrHbnpQCAT9vDuxni5SE8Bwiyxe2sv0U3G7XHPlCZ4TgATuu+dcXi7n9Ijqo8iYB8DDSkIS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ke87KqhL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724f81cc659so617893b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732454234; x=1733059034; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3x2SMWVaYfpqUnnbF6mOMPwbeMyaHbo8dfeGfWcWU+k=;
        b=Ke87KqhLJ8+KWLXql/FEQByTxuf4KF/G5KUlY5DpRVCxnIZRnqSgWonfGPfoLY8KY1
         EUGtej55scjCrP2tIXLIeFjoLEnz7Tp0nEB3R+rZLtZAadfNJu4c4j9dmXNPhYUTQmoL
         fsNUidLAMpDd9Zvtgn+ICh0Dpsxv5T27Bv87XGYaqADn6YRFdFThxHFep4mG2bleH0sV
         xoV2Nlvj/P6v7sE96HVrtj0OqYaEabIzd9L+ieuhpkMKpM5yYb6Sy3bo+2Tn4Hmo2ozc
         RVA2v67sglQpp3SEwMv7SByTyiR8S7fEOkw+2t3flZ0muX7TTA5oWULXoku13ldm7z6m
         FH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732454234; x=1733059034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3x2SMWVaYfpqUnnbF6mOMPwbeMyaHbo8dfeGfWcWU+k=;
        b=diul9A/UrsJT5RczS5XJnrftaFuyLOddBZHd/Yn20x4+iKballPZFUJ7LCquRnVeIn
         EFah3fRReKkiwaIbHU3EJVp3U7azGpa5CvLNXoXB+ImH1xr5QzJ0e30xRkbSYnZvreVq
         9gwuaU6t7VkJCaTDDE7oH2prtxG2t3lj4abbD5uFgTE1+MZV84g6CH9CsZh2XV1wJ5Iz
         ro73ppwVokN7DXJ/2Y4iun5l6l+5GBqV+szlLlQDyqVf8UIRal6YGwNLwxRshdfR5NzM
         NaUcWKa7o4tW44lJWh8quuNFvR0KnCbRgGK8ixarLzpy7LzIk9oBRBJWlgNmCvVxayS3
         eXgA==
X-Forwarded-Encrypted: i=1; AJvYcCXkffkBvsod7P+wOj7VtXTz1XFA2bC2xfOcVtKKdzkLtXNiMCetZj1T3iTtRxhqAkMebhLh92GWef/35bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXm+TXuLujSZ0mjWY6l1PKExVOdzmJRc6TVbGg04Lp2PQYj+4d
	Hw5lNHzmbLUVnIzCF6DAFpV9zioEINbCn8/BZJ4eaZp+P22VhssXGl2zH64qcw==
X-Gm-Gg: ASbGncs+BL4WZ7UwuSWI2ocorrzmCcgMTFv8uYCg28f/7kLX7p0n3nZ6oWyHN8TSLvC
	KuyptIWSZ6+pCpfY28MaNfMkWXezA/PuGadU+BckdeRYK/dnekwDd9Nv+hoc8acbsSvJpRgKpRq
	zBRwuR8kNLFE+NGHTAUQmlgDgZt2t/nxAUG9IlcZmYSnyjtXY0TW+7y/UbX+a2NPwkUkRhLNr9l
	OFq2U7Ef6svei1RGUXuX2iAspSbVA1D1rftPxxhMQyR4I/zWAIqfKZs//I1
X-Google-Smtp-Source: AGHT+IEtFLA66MFjNRjbQgvd5A29dDLWgZl+Mi7ZlRgR1PZjK50HEIwS0D8UPsDBN8IXVDgJz+1Pcg==
X-Received: by 2002:a17:903:32c1:b0:20b:8bd0:7387 with SMTP id d9443c01a7336-2129f28f81amr143096695ad.52.1732454233985;
        Sun, 24 Nov 2024 05:17:13 -0800 (PST)
Received: from thinkpad ([36.255.17.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba357bsm46433795ad.88.2024.11.24.05.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 05:17:13 -0800 (PST)
Date: Sun, 24 Nov 2024 18:47:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v8 2/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <20241124131701.yrb4bkhwigcux6b4@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-2-6f1f68ffd1bb@nxp.com>
 <20241124071100.ts34jbnosiipnx2x@thinkpad>
 <113B93C0-8384-431A-BE4D-AA98B67C342A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <113B93C0-8384-431A-BE4D-AA98B67C342A@kernel.org>

On Sun, Nov 24, 2024 at 10:56:38AM +0100, Niklas Cassel wrote:
> 
> 
> On 24 November 2024 08:11:00 CET, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >On Sat, Nov 16, 2024 at 09:40:42AM -0500, Frank Li wrote:
> >> +static int pci_epc_alloc_doorbell(struct pci_epc *epc, struct pci_epf *epf)
> >> +{
> >> +	struct device *dev = epc->dev.parent;
> >> +	u16 num_db = epf->num_db;
> >> +	int i = 0;
> >> +	int ret;
> >> +
> >> +	guard(mutex)(&epc->lock);
> >> +
> >> +	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to allocate MSI, may miss 'msi-parent' at your DTS\n");
> >
> >No need to mention 'msi-parent'. Just 'Failed to allocate MSI' is enough.
> 
> If you look at the existing pcie_ep device tree nodes for all SoCs, you will see that it is very rare to see an EP node which specifies msi-parent.
> 
> I guess that makes sense, since before this series, AFAICT, msi-parent was completely unused, so there was no need for an EP node to specify it.
> 
> I'm okay to change the error print as you suggested, but in that case I really think that we should add a comment above the check, something suggestive like:
> 
> /*
>  * The pcie_ep DT node has to specify
>  * 'msi-parent' for EP doorbell support to work.
>  * Right now only GIC ITS is supported.
>  * If you have GIC ITS and reached this print,
>  * perhaps you are missing 'msi-parent' in DT?
>  */

Looks good to me (except that the comment needs to fit 80 columns) :)

- Mani

> if (ret) {
>         dev_err(dev, "Failed to allocate MSI\n");
>         return -ENODEV;
> }
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

