Return-Path: <linux-kernel+bounces-236627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D970B91E520
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650E6B22558
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0816D9A7;
	Mon,  1 Jul 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnUJMmt/"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B413C908
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850799; cv=none; b=Rqrw0tDt4JOJjtin9GiNOcPxSeUlDYwKT8mB+0MyFOlEmWOsFwA3I+le/hK1pUNPTmMD3MN1XEz6xbjiLmiUnmNGoQwg5T+ZiZ90PX9q9hKCu4sapGtm9n1ysJzlwGFQ233I+pp5f0Pw6FOz+MghkrYgaPxqCcsaG0xflqXkQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850799; c=relaxed/simple;
	bh=XH8Osb0c4CXWeNNmUjzFX2RRUGL1tu0cvHhkCktcXCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyXq1LUxU4F0T30X1+cYRz178JkeKi2DmZpGBiQZh9HwaRBt1QH4HRm4C8anxqsIaLpeEOks5RzvKXJkhvBDE7fUAWHDk7q7wmtjLkVELWlh8bGDhqeDUYbFZmMYF9cvWY4AgCTCm0qt8rrhX+E64K5b07pObPYNAPGBXDg5SVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnUJMmt/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c8e422c40cso1759461a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719850797; x=1720455597; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npGZbPFkc3bZWaaUO0pnaqKWSuNckmKN9XglNUgbS7A=;
        b=pnUJMmt/XRjdixV/rzmpPKFZ54U4yHr1p28oQpBtv51H0RxUp8aamCmLkNlovOV/2h
         kU5U9dOaLxu5hhdU9VryDyqkAgOzQpF7tGsbFGFTUUKI2pQcpqJvc6sHhwZtGnTGwqeM
         NNA1cQo889uQWWdqal6cmDI0hK9I2CTWHVuen8bh+k953YqlpNLpWr9gWRj3N3JJSKng
         C4gbHLz5HWyR4snDxtAXVxZnDlAvIK23m+TUk/1IzzQlet7/tfmKTHfcrag1Ur/pAVMQ
         Ab+V0OAH/7ga3DebgiL2WpyMI0JBssj24fTHdSdM5G84/HX72m2+lCoK47hXs/5txnYs
         jxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850797; x=1720455597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npGZbPFkc3bZWaaUO0pnaqKWSuNckmKN9XglNUgbS7A=;
        b=GDw0AtGi5/oUkGKS7fKTVGVAyraApm2rDgEogsjLhdWqlDrdqEVo3T0ZE+5AH2fAMA
         Sg+//TNir9QZsSWu3o58EXS/o7UR78UleJex/ddadfrKk4UQk49dwCkJq5buBLukGpsq
         j+Vq5WhzWKNVWHUGtYvES55iV6iLgrAgRqqVorck7VfKLEDRSEVDnHbGOf/8o4DlVTUD
         3dJTOwAbyU5tU75Ps5uZG+cekxEgPjEL+SdmPRUL4NnmoAhTMc2zFaFea6lRkuyR49zZ
         aZr1e1ISI0ajee4BYW4MGFkmX1ff/mxdfojxXlLMVOIMZobU1aWQR9RQkEhl2YPGvxA+
         LwJw==
X-Forwarded-Encrypted: i=1; AJvYcCXkMXolIXXWGI6AfvPRAR7WqvKUGt3qJtYxnikvrIMaQ7kt7qUK/V0olYr2z87+unKePbRulAvd05CxRCWQd5YJcDHQhtGDE3h/NGOr
X-Gm-Message-State: AOJu0YwoPVDViXG7OCV/eIoq7EtFTeQbFyg3p3nSBYaV3wUUHfSZkjd4
	4q8Z5EfysLR76Q8K2fEuailsHv5ESXkqukRGc6Mw0uiE23g+uw8zAsg+rH/+5QdZcjLID85sMeQ
	=
X-Google-Smtp-Source: AGHT+IGal1R5vzpDJ7sCzSGyMQEj1ejbiV5YpF8XbjBnrGN69ahWIq2HbSymiIabAN8Zgt3y/qBZgQ==
X-Received: by 2002:a17:90b:e0f:b0:2c7:c6a1:42d9 with SMTP id 98e67ed59e1d1-2c93d77c8d8mr2945206a91.49.1719850796986;
        Mon, 01 Jul 2024 09:19:56 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a8esm6956074a91.1.2024.07.01.09.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:19:56 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:49:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: pci_generic: Use unique
 'mhi_pci_dev_info' for product families
Message-ID: <20240701161951.GA133366@thinkpad>
References: <20240626053237.4227-1-manivannan.sadhasivam@linaro.org>
 <34a76874.acd9.1905479d200.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34a76874.acd9.1905479d200.Coremail.slark_xiao@163.com>

On Wed, Jun 26, 2024 at 08:16:28PM +0800, Slark Xiao wrote:
> 
> At 2024-06-26 13:32:37, "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org> wrote:
> >Currently, a single 'mhi_pci_dev_info' is shared across different product
> >families. Even though it makes the device functional, it misleads the users
> >by sharing the common product name.
> >
> >For instance, below message will be printed for Foxconn SDX62 modem during
> >boot:
> >
> >"MHI PCI device found: foxconn-sdx65"
> >
> >But this is quite misleading to the users since the actual modem plugged in
> >could be 'T99W373' which is based on SDX62.
> >
> >So fix this issue by using a unique 'mhi_pci_dev_info' for product
> >families. This allows us to specify a unique product name for each product
> >family. Also, once this name is exposed to client drivers, they may use
> >this name to identify the modems and use any modem specific configuration.
> >
> >Modems of unknown product families are not impacted by this change.
> >
> >CC: Slark Xiao <slark_xiao@163.com>
> >Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Reviewed-by: Slark Xiao <slark_xiao@163.com>
> 
> >---
> >
> >Changes in v2:
> >
> >* Used 'mhi_foxconn_t99w175_info' for HP variant as well
> >
> > drivers/bus/mhi/host/pci_generic.c | 78 ++++++++++++++++++++++--------
> > 1 file changed, 59 insertions(+), 19 deletions(-)
> >
> >diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >index 08844ee79654..35ae7cd0711f 100644
> >--- a/drivers/bus/mhi/host/pci_generic.c
> >+++ b/drivers/bus/mhi/host/pci_generic.c
> >@@ -419,8 +419,10 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
> > 	.event_cfg = mhi_foxconn_sdx55_events,
> > };
> > 
> >-static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
> >-	.name = "foxconn-sdx24",
> >+static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
> >+	.name = "foxconn-sdx55",
> >+	.fw = "qcom/sdx55m/sbl1.mbn",
> >+	.edl = "qcom/sdx55m/edl.mbn",
> > 	.config = &modem_foxconn_sdx55_config,
> > 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> > 	.dma_data_width = 32,
> >@@ -428,8 +430,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
> > 	.sideband_wake = false,
> > };
> 
> Seems nobody use this mhi_foxconn_sdx55_info.  Please help remove it.
> 

No, it is used by a Qcom modem.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

