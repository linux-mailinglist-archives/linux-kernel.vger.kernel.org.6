Return-Path: <linux-kernel+bounces-170873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5098BDD2A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6C28613F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33DF13C8F7;
	Tue,  7 May 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvMWLB7E"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5613C83F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070521; cv=none; b=mBvwBb/9d4YNM/QbS0SN94gyyskHIXK+SmAwXMKtXOQUx9TLg1OByJ3ap23A1PtIuOrTuR6lTu7342CSSfz1m58vAQXnULG5XOgq7VDdvGyt+bXIqrVlug03vcoDf9dxq2p5mWiwhr4D80m2CArduFEYDgFCHuQVbm0eNo24Ulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070521; c=relaxed/simple;
	bh=WAA10rA6qRqoYCr9XeTblOpVslB6CTUD6a/rB8ts6T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmi/eCMx/sJlGxtw2E742rve1AIlgP5jqx/ZksfN4pDSHIDNE+LTN5/Q8ZvtY/8vswICHUBPVZYvXlmvOzJ2XKf9QYM32reQa/7RlQLOAk6qVZKx35hMMtxRt0phTOcNUq8a4W9LdDak7/cP9I3fRClBp2RqSm3AeMnBznckNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WvMWLB7E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso19950715ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715070518; x=1715675318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GVgauUSBhCFoJsX8lOkvxxApBqvEtasgyEBvsQiV6aQ=;
        b=WvMWLB7E7Vioc78gLbcP+uIOdjLgNFyZB9fYMLjyHdQ0K/0s8XVqxUsxSNp0SwnhBV
         Po0ygzSSPvuKNYBuIEZ2qLhJWTMtXEQbsEe73BhDSODBIRXflIFkEtO0SBpCi0mv0Uzx
         6BvDm5B7Ahhp0Py7XxqJ0UTrhB7dH4Z6H5nK9unsRMCxZoM/zOBWuQQUJBApbXYghm3l
         0sKXt9B/QNEQJ7espVI/0Kyw2HJLvOPCDBb7R0Ldawusan1I9QmafSd2GQKsXYKrt+Yt
         p27GqajK0LK4LsoicOAz1oiQrze7N8KJ37oTXJpIMXS3iXAi7+I5fme9w4cEPYqsL/FU
         rqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715070518; x=1715675318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVgauUSBhCFoJsX8lOkvxxApBqvEtasgyEBvsQiV6aQ=;
        b=fLS/J+FbhYopmM64rTugFxeyxXSginEYBR4Q9KoHhRVw27OFH40KvIMiTaXqdUbxtL
         DXJRWT7k14zdllhA4ZzvsvdC/m6LD58AypiuLl5D1rdyYLt7u2UBSXlkFSgPelV4rPy+
         wefsaGg/5Rp5S06HgtPr6/BHl3YOBUb+9LcANAwNAQ1o2TShziyeFXgny1p3QS6X3UPm
         WXFU9BMVfK8bombN1qz41iUyZSUKOCXUvY4K7sPykRD+EJ8VA9aVN2tz4OR10ADgbee3
         55iTxCl1rQQpIYGPloA4Zc+WLuhDdZK8EGnUs9+nX0g58y6ChNr+4TwhNKHGCM/2kGQE
         goLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxE4tTxFn7OEIdws6Xj04FVEjAYuIFV7jnmnrmWJ8xrhBbQ+VFuaVV0/la607iBUrTZbMRlTCIrGXMxzYRDmLHY9BXKBRnaws1qJk9
X-Gm-Message-State: AOJu0Yy8QICQjYxtSzdXNWLSOBch+cvnDmfQbpYVRjgA9iHl3t1TGdpX
	T1Uj6gvYZwbaw5sXECYzzdJL5jIz/scAiFK4H+9rweHwjt08v5hRbI+TufyCVw==
X-Google-Smtp-Source: AGHT+IFkZxsg9zZ8uGCj6F9b96ztkp16VI7pxyk7k4qDQRuZ3fJBvMiqX1TfN7jL1VUt3SzWbyr1LA==
X-Received: by 2002:a17:902:ce8a:b0:1e4:9ad5:a666 with SMTP id f10-20020a170902ce8a00b001e49ad5a666mr15845336plg.25.1715070517573;
        Tue, 07 May 2024 01:28:37 -0700 (PDT)
Received: from thinkpad ([117.213.100.197])
        by smtp.gmail.com with ESMTPSA id jb13-20020a170903258d00b001ec4ed47ddesm9603688plb.86.2024.05.07.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:28:37 -0700 (PDT)
Date: Tue, 7 May 2024 13:58:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v3 4/5] PCI: imx6: Convert to agnostic GPIO API
Message-ID: <20240507082822.GA6659@thinkpad>
References: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
 <20240429102510.2665280-5-andriy.shevchenko@linux.intel.com>
 <CACRpkdZUsA034L5GjF_-XELX9369PwNjONfsDV-_EC564R0QWg@mail.gmail.com>
 <20240507081441.GA6025@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507081441.GA6025@thinkpad>

On Tue, May 07, 2024 at 01:44:56PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 06, 2024 at 02:10:24PM +0200, Linus Walleij wrote:
> > On Mon, Apr 29, 2024 at 12:25 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > The of_gpio.h is going to be removed. In preparation of that convert
> > > the driver to the agnostic API.
> > >
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I think there is a bug here, the code is respecting the OF property
> > "reset-gpio-active-high"
> > but the code in drivers/gpio/gpiolib-of.h actually has a quirk for
> > this so you can just
> > delete all the active high handling and rely on 1 = asserted and 0 =
> > deasserted when
> > using GPIO descriptors.
> > 
> 
> Wow...
> 
> So this bug is present even before this series, right?
> 
> > Just delete this thing:
> > imx6_pcie->gpio_active_high = of_property_read_bool(node,
> >                                            "reset-gpio-active-high");
> 
> But this is just a bandaid IMO. The flag for the PERST# GPIO should be properly
> set in the board dts as per the board design.
> 

Hmm, no. I was confused by the property. But this quirk in gpiolib-of.c is going
to be applied while changing the GPIO state also or just during request time?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

