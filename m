Return-Path: <linux-kernel+bounces-410345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AB79CDA2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E917283145
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636A1DFFD;
	Fri, 15 Nov 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5SoIKSa"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723D17BED0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657818; cv=none; b=Ykr500vO5zDZqh+UuU/yGR1keNZooAjGag883AIDlwOi0yh0aTl6rOsxPJVUP7TzNYH1KKwhZqdS7dqqpLRLgAch7lLPRvSpZm/KyhO3e49BZqbH6JmozZtMOYVgkpBH4G/EKcwVWFkQVWcEeW7lWn0Lq9GrAQoIWE/yD7Ho4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657818; c=relaxed/simple;
	bh=CDDWkMTRsaqG8fDpo4QcP5vpY+jE/dyCbCBBW4aAA68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsBwWV/WaR82Rg7J55+6IRB1z/SPj1YavntnyC3W1EI/4j7va2l36BOELf9TnIznjMesdJjFuPQ/zWwJPBN99vEiwnv46VyhDxN343+wIy8ZEi0ZUDhly6Ha7OIym+dI7kJk8PKx+oLZYPvoIrWpjTXwpsOlJWu2SGaWU8RPv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l5SoIKSa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1454663e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731657814; x=1732262614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg52ed6dDB7uAWG/HTj6AHSw2HsFAkB0m6M5yLEc71Y=;
        b=l5SoIKSaduG2oacWNq5TUGeuSmi0g1xzI9M+hhgVq1I7oAwA4cPMz2PnzqFUbFMXv6
         EVkIfZRwTyWnbBu08RxNQJSI6xV5ej/TtZi+L90pEllBw3zzM+DXW+E08rUCnWe1AVps
         LolNNCkOWyU2t7yMR8sr0sIs+kohPZvuydmHtAV/xyclbR8uTeXFVkfxCf7IvOpBT5so
         vyPXAbru9tDvY7erlCiDLV0mdaJ4Gqb69G+ApW+o1OSswyLop7aepmp0lfQBtpsJWKM2
         fL/oE8vFa2sR280qxthE1vHWV7dij/+k5MCZ2fMYm2tPfvGzUabJyKqOZ4OqZD0c60VF
         YcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657814; x=1732262614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wg52ed6dDB7uAWG/HTj6AHSw2HsFAkB0m6M5yLEc71Y=;
        b=F+8D14/bsDPJ456W6V9Czgh72HoPQ4KXCM3i2iNv44JBdhPwYwOeR1DsBtczOalt+2
         eVRiyfGKr3P23SfNKDEVf7LCPBX7K85aSofEPo8un8bfgGC54RhdlhWK70u5ys6+8IHZ
         XTFIU43qGGYCSpzWNZ8J3jD9FmyjBbpL90weMTBxKkUz3VHhpRLUsTi4PD8uNZO/dEIg
         MmnqtSBZtYw1wlIrRrKyJ5SzVgTlbeKlhEWbPKGao6tgNKy7aYf6ZC8CDXsRY3tkKdjV
         MLNxDhPbpRtH1mmylJCIdKEIsE38Y3iuiyQ5Gr0CJnZAUS4zkiFkLthxh2WWvEVBu6y6
         Ud2A==
X-Forwarded-Encrypted: i=1; AJvYcCXbgzkwtywOM3UFmRaBvl/AI1a521kuFb07zL5R4wZmR2dnyvxIylpbYfUiFjfD3c15k++1XikBtQpDcrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87AoZ99tgxO3GA5c8ttnGA52iBDVprAW4U6C7Bq+ZYWdgxbQs
	xucmFTLfUuPO22rBKDOcId7rAC22tTET7D0b9ZoGQq5hlyOg5ynfLkyFmzT/KEY=
X-Google-Smtp-Source: AGHT+IEkwODPhmetrFQ7JC1ZlQC8WpzWNpnVaZRGwH7SFyoDcr2DtE+ysrIGhm40Nj0M4383sof/KQ==
X-Received: by 2002:a19:5e08:0:b0:53d:ab50:4e23 with SMTP id 2adb3069b0e04-53dab504e50mr598467e87.0.1731657814295;
        Fri, 15 Nov 2024 00:03:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548e9bsm474592e87.262.2024.11.15.00.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:03:33 -0800 (PST)
Date: Fri, 15 Nov 2024 10:03:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] remoteproc: qcom: pas: enable ADSP support on
 Qualcomm SAR2130P
Message-ID: <2iuvbh5ubtc7nwkoducgmsuzgsl7427xcnpi4jgitsbij4yned@c6zwqcaz7r4b>
References: <20241027-sar2130p-adsp-v1-0-bd204e39d24e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027-sar2130p-adsp-v1-0-bd204e39d24e@linaro.org>

On Sun, Oct 27, 2024 at 01:09:42AM +0300, Dmitry Baryshkov wrote:
> Enable Audio DSP support on the Qualcomm SAR2130P platform. The CDSP,
> also present on this SoC, crashes the device during the start and is
> thus omitted from the series.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (3):
>       dt-bindings: remoteproc: qcom,sm8350-pas: add SAR2130P aDSP compatible
>       remoteproc: qcom: pas: add minidump_id to SM8350 resources
>       remoteproc: qcom: pas: enable SAR2130P audio DSP support

Please excuse me, is there a reason why the series wasn't picked up for
6.13?

> 
>  Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml | 3 +++
>  drivers/remoteproc/qcom_q6v5_pas.c                                | 3 +++
>  2 files changed, 6 insertions(+)
> ---
> base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
> change-id: 20241027-sar2130p-adsp-fc3fad54ded3
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

