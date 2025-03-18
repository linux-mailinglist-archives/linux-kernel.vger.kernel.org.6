Return-Path: <linux-kernel+bounces-565682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A120AA66D50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FF03BB8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC861EF373;
	Tue, 18 Mar 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYeZngaC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D51DE4DC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284994; cv=none; b=GBxn9hnYqHdq6Yc/d81EykCuDZDl330ptCjvrdXcBhX2H/KtVbo1PXj77gMW78gYdO7hJJ2643BrRJEfkmvIq+mij7OApQy2EiKcSoSGQe9I9sMK0n7nXZqc5ogv3jQFYxoZMeiFV3XYb9xtuItTRUn1HPf9tBgJkv3KxDzlpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284994; c=relaxed/simple;
	bh=oPq+d71Iufy56/UZaCHSTNp7Y6uM8EA9OXViFdwCyp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq2VmdcBCayjBQuJWsY5HScXfkCqfalNyUpHgJrWIBm1Y3iUSdC4cK1iOfv/72m6a2tRx4QMU4DIvtaX6QF6cmptFRR3xuK+u8CuAWYfXtT8vtBwVtaB2QqfpTwF4gbzz11sALR2Ylh6+SuZk/WKZYNqWHsDM5vCe6SBcCuX3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYeZngaC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225d66a4839so64688055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742284991; x=1742889791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7zATNOB+RN3GRdRq8GAz0vH7sY1Yh90UPf+hvtUwtFk=;
        b=JYeZngaCrwqCXIUh9R+MuiHFdmMsx8A6+rRBrfTE+9f6E5LAEMfM110JoGbaJbvTx0
         0M64/ZLb+vlCBmA4VB2gSxtELDDfLaSbhCeEwRfZoNfapZ0kQ6c4SYl9PhgmcDWzCx7S
         +/5gvNWri+zOT8f7G3PkcDK10PIB+orJlfuPM0GFVSB/r3uxz9CehvayG6DjjLpeylNv
         MbFWrnSAqYZSClu7UpyCZIseq2+olRAblT5mD5B0Er8232PVRsuUU7q2vFeIlartOM8S
         l8AAjWkRVRyijhmYDRfca8ROU/2VFlMMcfew3Ebslh92JToNmRSbvJocqKaYBYAhjZKm
         giaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284991; x=1742889791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zATNOB+RN3GRdRq8GAz0vH7sY1Yh90UPf+hvtUwtFk=;
        b=v6is1riZs8rJDQmE44tIzkBwW1cXRKAWXQO23BXts2324vp1AaQGLL2rdSZU9yrmV7
         pFZ9Bdo+1gXTdHGgqj3rB2HbtQDsfwuIRYw504cl0tsAPDutB15iPENpr+8Z7+dS3Mij
         z2t8Sd8mZoY+jrmms/+0uQQdqcvbbuUcMRy1/QbKs3Ug7DqXzyxpiYjI9VfWIjwbPT/9
         Ne2v6F1RHm5hhSDU8c/jRU1Gm4Sm9zy0laPjlCf3xl7x7XjhscihjvGwQD89BHbF5gcV
         xE/rhFLm5QjaZ7RMP5QGOV34AlaCopR+NhNj9djCKKQpRaaNwRXzXJhbhMj4xnQW9Tvk
         +54A==
X-Forwarded-Encrypted: i=1; AJvYcCUi8LwXgdAjGt/i3yKLbUHSkQyamI3s/amQscLytTglc7NzfhCb8iw58oCuB8C/SboKlWO7CxXoPT2oySU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhRCvDnlxzML2omuRkSl55qwYzxgtt2fyJtsJ42LZgb5Si+UPx
	r1N2CZFTZVXMb/tbqvjK4MSZ/ffu5a2+QMNM79lHlJAvtdMyXGrDnVeQgGRyQg==
X-Gm-Gg: ASbGncsNOgZ5JPo66m/0KKCFRPBLmwY0InVyPYmiqQiLPZr11jP3GFCa8pHidrZXx3K
	JXFiLAvSzKzCcOtbz6ETpk7cRFlXFZJMeBURiqfPiZ1vgWdKoTTD6k0sqcGVTCd/YTRM1yk9iRD
	j8FbiQGanpIK4XkR7jMbNBSLQT07KnfT/LXMjZmqSJC6Ti827PXn3sU9H9FAS6drAjY6KA4v7OM
	nrdW/u+TNPyovRNSzB8bJkbn/Ej9SELUGe6AG5QLutypLRG87RnP/XU4PxQjtjvO0eRCBezIPI0
	B8gpAwP7bq6M8fZSYlU9yfzmwVctQvYwJ9sww9XsX0WCqSyktJjZO1Ea
X-Google-Smtp-Source: AGHT+IFQI50pcGaomE3YOZGMmALp0D+8DIQDQoTe6NaI/OMfzJ9nJAe8ts6tZPm5ugXC7xjglM9V7A==
X-Received: by 2002:aa7:9902:0:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-73757932a76mr2891234b3a.9.1742284991535;
        Tue, 18 Mar 2025 01:03:11 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1103sm8934019b3a.167.2025.03.18.01.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:03:10 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:33:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	thomas.richard@bootlin.com, bwawrzyn@cisco.com,
	linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable
 helper for cleanup
Message-ID: <20250318080304.jsmrxqil6pn74nzh@thinkpad>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-4-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307103128.3287497-4-s-vadapalli@ti.com>

On Fri, Mar 07, 2025 at 04:01:27PM +0530, Siddharth Vadapalli wrote:
> Introduce the helper function cdns_pcie_ep_disable() which will undo the
> configuration performed by cdns_pcie_ep_setup(). Also, export it for use
> by the existing callers of cdns_pcie_ep_setup(), thereby allowing them
> to cleanup on their exit path.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 ++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index eeb2afdd223e..85bec57fa5d9 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -646,6 +646,16 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>  	.get_features	= cdns_pcie_ep_get_features,
>  };
>  
> +void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> +{
> +	struct device *dev = ep->pcie.dev;
> +	struct pci_epc *epc = to_pci_epc(dev);
> +

pci_epc_deinit_notify()

- Mani

-- 
மணிவண்ணன் சதாசிவம்

