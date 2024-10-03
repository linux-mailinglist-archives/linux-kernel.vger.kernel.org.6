Return-Path: <linux-kernel+bounces-348592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC9898E96D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BB2B22837
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95C2232A;
	Thu,  3 Oct 2024 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfAOFHIH"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B3224D1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933907; cv=none; b=C7InHpQJKMuI54Ynh7vl/gi/HocBMcEDQvzh4WKsnt+9iF98484BU0MGnlVa/4OgZiiy28MRiuH+dT99qp2hKt/Rj1GQKJasvNf8tCL+X2G3fYSqT1BXQyuj2lzJ4SiUolU/qwq+9VpZEyLY5qkuC+khduD7iyWnZLI1zCP14Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933907; c=relaxed/simple;
	bh=OZf5T1dMlAEXY8gTRUkhfj9KW2sc8CDfqqYDFYBKrCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt1MvjySeabBTnTo9pn7DvyNuAX4rdP3fkwns7LlG/gY709RMpZgVpu/GXQ9Cx8k8J3ZBQBvljYhiwwyFQkBLdjWqc8JdJz48V+qIsbEqnVgyeYw/Bg4lgo7Ii1SsbL5q90NGLXzPoaLciWQsA1J4Uh+iN3g5Hgkf2j1p+FIxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EfAOFHIH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e07d91f78aso435040a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727933906; x=1728538706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pd1LkdkCibllI1ORTg7Irg02FkDWiTpEyiSVdQth11o=;
        b=EfAOFHIHy61mW90b2kdWTYvOPpMC8QRvTKV6wc6LdEuBbusegTguXpnLPskCko7ep8
         9I7Vke8R9tWdwNXEZqW8jj1/1rcmBMEgUHCL55uBrGkr8/lm+mCbOMDsFh8nQcXTibko
         sfjHWHY23rhkEYOXlEFlhOSspKYmMVfu7UdRvy9vyGzi/NNgcRJORWq2gxv6gArG4gML
         wve5gy8iLw5Q8tf5NxtNzBKnzodbOnbTc54l1Oe+6/GDT/0AeV7tUM+uMK2utHgXxgiP
         j3xWNLjItUln/XkF9qVqG/dys8ic0cRNamJjBRhaqeUC2QugStHQo6MSIZMzAleyoYpO
         fUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727933906; x=1728538706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd1LkdkCibllI1ORTg7Irg02FkDWiTpEyiSVdQth11o=;
        b=C/WswNrNEvPR0NfocFhVpAbs2+VnVbkV0hKgi9PLax+ymKbfd8IppbAvr2XRRqHrkD
         6/DYqkV9XcGld3FTPKF6nf9JROUpKZQfpECqVUCCMoMzunvU7dkEcrXrn5I4qyBpC8xE
         Spa/VyJyIUugwadYdLBrbMW1Z/XCHr4CFihd2nEV1boBLfoEwjaTCygfaWmYKOcAr1f3
         AHpOFRnkOgfeKZ8yQP8M4TQWr8w1PVVLLMrH0Sn/eo6Rc12+HyEAequP/xf76A9nn1Tf
         bPtpmASQv4l0zCnSXXE+U63GqtTo3+//VxRco8aKfDlsZ/eGZXmVdcBriApLLCAfwEjB
         9H0A==
X-Forwarded-Encrypted: i=1; AJvYcCW1Uhwmr4e9yzdcdx4FBOMsdCSdirCeVopUeTQMeMqyAVFb0A7BYcNRMf3DeeI7mI0PZ0QPOJ3jljtjkWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07o8cCvLDRyNriJHQ1PY8p0Scd+KvfFbs/0gshO1Q/MjxWfWk
	Qa23hx3v2mSX61BEs+wJTut2Y4LZJZPumDcRUAiKB6+kzpaQtcd/jBWgrcxAgQ==
X-Google-Smtp-Source: AGHT+IETFJQL7nnoFerivVi2DQB/Jkm21orJvAufRoGLmUdngzWZk//7FXKGWhSccYa6K7py+Gxobg==
X-Received: by 2002:a17:90b:1e42:b0:2d8:ebef:547 with SMTP id 98e67ed59e1d1-2e18496989dmr6233335a91.35.1727933905751;
        Wed, 02 Oct 2024 22:38:25 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e182634b11sm2043389a91.0.2024.10.02.22.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:38:25 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:08:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] of: address: Add parent_bus_addr to struct
 of_pci_range
Message-ID: <20241003053817.eycemurigrr6qy4u@thinkpad>
References: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
 <20240930-pci_fixup_addr-v3-1-80ee70352fc7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930-pci_fixup_addr-v3-1-80ee70352fc7@nxp.com>

On Mon, Sep 30, 2024 at 02:44:53PM -0400, Frank Li wrote:
> Introduce field 'parent_bus_addr' in of_pci_range to retrieve untranslated
> CPU address information.
> 
> Refer to the diagram below to understand that the bus fabric in some
> systems (like i.MX8QXP) does not use a 1:1 address map between input and
> output.
> 
> Currently, many drivers use .cpu_addr_fixup() callback hardcodes that

s/drivers/controller drivers/

> translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR",
> "cpu_addr + BUS_IATU_OFFSET", etc, even though those translations *should*
> be described via DT.
> 

It'd be useful to mention which driver has the mentioned fixup as an example.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

