Return-Path: <linux-kernel+bounces-190275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC128CFC4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590811F2293C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACDA132492;
	Mon, 27 May 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoiqfWZq"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A1433C8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800376; cv=none; b=ub2Ok1OeN6c9OzfjQ0m5uVok3sVZ2hi2I23D0okRstux5Zgry467JvM9eQNHS748zhnWnNNpvEbs9Z3KMO9y6wva9BT3qQFSxeAHqdnPQQT1BldPKRxa3E+RvCDcd9n/C/XM2aUoqcD6hRWf7nsC2TdWR9eP7XD1bNgLPOf470g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800376; c=relaxed/simple;
	bh=wmMNK/mGZPfXxGbNsHsz3bs35s6GdqGyNaBoQQp/a9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/hDQTwO3glYZXFs56MI8FdmyNdU5n09NZ1ceWE8VcFh4Q4TAXkeBa72LiUhe/BNYRFnLkXxL/2J5a5xvj3MGpLuivY+6pnXEHiWtojGLvVJrnFL8cg5mhjyDlvvqnvK5XLHWVl4BqvXtDHQbVDLoMEkyW3CjIRHFxLXA8xbVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aoiqfWZq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5295a66e775so3292975e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716800373; x=1717405173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IflnmrJEBByrw6RHNme/+1coaGuRNlHIrGL2PB8jagY=;
        b=aoiqfWZqucJkXOzrd9gDCRdfWZbIVmzx31ecKKuVbgVxpVd47UNWV+mhup9YooArDy
         a1muEsuMCu8bj2Af6DQ0rzHCYa10ayddi1ZNAX7Cpc8HB1uLenW8aJBv3kFrhPYNqRv/
         6HRju9G458PSk6WQRZel4dhBAkySUPW4Czrwem7br+FSiAV131Bpw4OvQj0e4Pfv2Z/e
         Yn+8HudZYoXOsH/rWped7VpclAMd+k0YVkyoOrrzJ+h7AdpaP1MWb+17X5rBDV3NQHW4
         Iwa8l96EjwLJCP7A6nsy1V9GUuONl0iE5ePPtxrZ5E/rB8f5TXaidyIToZh+29EYuwQM
         XUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800373; x=1717405173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IflnmrJEBByrw6RHNme/+1coaGuRNlHIrGL2PB8jagY=;
        b=OwHEKzWYW+qsVuml/FzWYJdO7vs3zM4KWTy3+3dWmNCevZx0DvSaxQDTcGTDtPCdD2
         729t0F/FXt01emb953EdMSs8EG9jK6TI4FHY6kUrAB2cka/obITfX3gSkz+b4wJict/y
         2ayFWt3aN0dC+vtbhteU9R4dObKyI8KMW4GKEzJ0WPkZ7Ouzm4GedqqIh6y23TMXP5F/
         sZcTdnY/98RC1fxMiqvad9YBzoS6TFf88QmdlU7xnS+xxuEZHCjbNZwCcQsHOpMvBgL/
         KR/sh7JLm8Yzb0KKV+3Yvr/alUWvv1dyLIiO9+I+i0VbHJVdG3MYrzCtkSPZdRy2vfG9
         MTug==
X-Forwarded-Encrypted: i=1; AJvYcCXIeliQs78lCDbBmXCOZY2IvceoRFPKo0XqL+rWtCmF4fz5vsQHTdtB0RkPzfP9oqmLDX7wyUIJhaPZ4HHjAU4VMC3VGL7fwUF7qK9p
X-Gm-Message-State: AOJu0Yx9WbqqVLf2SL54v6O6j8haHJD0xb4N0G3bRb+ptMvQQQZNVFyz
	trXpctCccauy6OcJw1XzrkCNtQsi7/bj6xkXUwg7GXAoo0vaoqjtTWgbe2XWWi8=
X-Google-Smtp-Source: AGHT+IGxLF6Lsaiga0V2BV/ezr3upTDEyPXADhRzuAoievMrQwZKkYyAfjc3DSDTbeXZtZBAHPlTUA==
X-Received: by 2002:a19:ad4a:0:b0:529:4864:9c17 with SMTP id 2adb3069b0e04-52967463e64mr6936847e87.57.1716800373131;
        Mon, 27 May 2024 01:59:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529716dd12fsm499151e87.305.2024.05.27.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:59:32 -0700 (PDT)
Date: Mon, 27 May 2024 11:59:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] phy: qcom: qmp-combo: introduce QPHY_MODE
Message-ID: <vze2yhxnd4vem6kg65kb3du4lgorluuitbtvkupwftrtgb2a3v@y3teljehz7xu>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
 <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-3-a03e68d7b8fc@linaro.org>
 <v36mrliwd7rarqofbitv5mtb6kd3n3hmuwp6bgg67krnvzejd6@luityjlkb7nn>
 <c767bc42-f4f7-44f5-b712-5933a921b386@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c767bc42-f4f7-44f5-b712-5933a921b386@linaro.org>

On Mon, May 27, 2024 at 10:48:12AM +0200, Neil Armstrong wrote:
> On 27/05/2024 10:46, Dmitry Baryshkov wrote:
> > On Mon, May 27, 2024 at 10:42:35AM +0200, Neil Armstrong wrote:
> > > Introduce an enum for the QMP Combo PHY modes, use it in the
> > > QMP commmon phy init function and default to COMBO mode.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 41 +++++++++++++++++++++++++++----
> > >   1 file changed, 36 insertions(+), 5 deletions(-)
> > > 

[trimmed]

> > > @@ -3603,6 +3631,9 @@ static int qmp_combo_probe(struct platform_device *pdev)
> > >   	if (ret)
> > >   		goto err_node_put;
> > > +	/* Set PHY_MODE as combo by default */
> > > +	qmp->init_mode = QPHY_MODE_COMBO;
> > > +
> > 
> > I see that COMBO mode is backwards compatible with existing code. But
> > shouldn't the USB-only be a default mode?
> 
> No because it would break existing platforms without "mode-switch" in DT.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Neil
> 
> > 
> > >   	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
> > >   	if (IS_ERR(qmp->usb_phy)) {
> > >   		ret = PTR_ERR(qmp->usb_phy);
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

