Return-Path: <linux-kernel+bounces-425664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB019DE8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBAB231D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E73613D276;
	Fri, 29 Nov 2024 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeO6VCfw"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB675588F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891119; cv=none; b=Prb3P+Kt7XE0mJDuULgdAS2cWbeovric6HAH+T2sCJZYntN/wOCUaMEvdlnqULgVKEO+0Hk4TbBtd2mekWC4CTNpzzNpo2cvDkqRxhbL81womQmsikdpRUNvKJpg2UKbPuB/4GopnJ4e2mnUmqGF5fanY3/m+GaLrJf31jq2edM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891119; c=relaxed/simple;
	bh=ebG+jgbYOVoxIaoEIS35kNojrHWYdKq3ZDu90W3WPIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acHpIY/mQShZBGLXKaU+ftehibkcaUF0L5CJYsWhriaTRvMNkMwVwXnAebiIe0JBf60HpMFGGa/Fox4X0LCs5hnTyVx9tgV7fZd8I0YaS786+cjhaUjBWqRZqeaZPdeOJbq2D8UCt8ScZFTw4CRhI0XY7WNfX5/4Pvs0xZOMM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LeO6VCfw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso2348539e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732891116; x=1733495916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ImmgwusNuF0D/bVRnwcDuw484FNRos5Zt6w0fJUjY8=;
        b=LeO6VCfwJEAe+FlaCuRkS9ZmLtvfDlLcWsXfukU9cwI1m1aV4+YuoC369b78Pq5ORy
         f4eb7SslJAsQuQJ+wo5KDU7LohSlpTbvicpEGcDaj2GXKbUwoIbFKqaBGphllOfgib/C
         +HUWyHB/8i28+biiRdPEONF74hqqCNxQq9Ljh7PZ5L7HVInBh6Q1IJEZFGW0GYy+kaNi
         HzcrGOkHTu/f2srWdJvNDJ1RmZ6ctjGC2SczwOV48eAN3/h5Fy+N8c43zhkTeCiiCG8M
         WLPH3jUiEmtkpupLLyOOAZTfJ2AAlRcQmqclFZVf9eTtWF/s+CZnGJpA/5oNl6ttiF04
         kgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732891116; x=1733495916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ImmgwusNuF0D/bVRnwcDuw484FNRos5Zt6w0fJUjY8=;
        b=mNkUmAtLmfYalDBhX+NfCYdjf1y777w9bY51aEeqxtwlv4o/FhFrbwt3io5m85ZS+H
         EBz9S7dsfkGJ0FrQgZn0hqewAOIvUuteKXgyx5xCePqlQSX6Q/xwin+TZCF3LmR5wY7i
         7qblqywAEVl6y4sv3EmJryXKmgnfM4HulCHeQGM2K0dMTYnRR8PblcKXK64uW3L43Uvg
         73cGlQCzmECNoPoDUSfybL9MxjuRZWHP1IiFWLRS6rizXnOg9bBHD4XTPZVGjJ6d6NP1
         c1S0UYCv75IGGsVddUbOWyVP/Ps9PwYYpM8dWZScxjmOENb4bDLLA2v2t1Jzxne5Icmm
         +8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyHO+KiprrI/RR2eCErR/FqLMMqHrPk/2FcF9YZdDIyUVWoRstg59yh2SxlrayxoRL9o/lacu/xftLBf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouBE5mnayFrCPJ6pQ0JHfHFtlUZ4JBxM2dbZcvutS6hMPEg/O
	PP+n9G/WOAupHYPDCGMmvW8/OTHfOrB1p7i564m5Wo8eRCiKkbg6WMb3oqpz/ts=
X-Gm-Gg: ASbGnculsGJwdQ1s1QyFnOaHrisw92TMeuNNLwVeo2zLRoYOSAu5Y0Ne0rs+QZS4rD2
	A11KZM6i63VfBiJfD4csENF1W+LYliQc6DKTZoZzxRcR9vL09eR46HPMJ+ayEH9DVk6DJ2kvc1S
	OJAzlfz9p+bmOYc/sVm3D62/48NYhQLNSvIomhTsMIf48FreIohBLCcpG+7r8EbClJDRy1/h27B
	dZleIfkAIGycbhIner0dajVBgqFl0p3WXCSkrMbZGQj9cpGAfW40YJdJrEoevZ9y6mfeUUclzDO
	FssxgoGqknJ1FOZQWyWHhS7QFIZTlg==
X-Google-Smtp-Source: AGHT+IFqTjbWr8NjF7+pqz/AQpJ3G3c4XTWyU4iDu/CsyQxhZEjPixqkHRfYJEDMmoPVCfkgLhGrWg==
X-Received: by 2002:a05:6512:2316:b0:53d:e5cc:d06b with SMTP id 2adb3069b0e04-53df00cf669mr7688145e87.20.1732891114511;
        Fri, 29 Nov 2024 06:38:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a068esm503034e87.273.2024.11.29.06.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 06:38:33 -0800 (PST)
Date: Fri, 29 Nov 2024 16:38:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de, 
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org, aman1.gupta@samsung.com, 
	p.rajanbabu@samsung.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org, 
	linux-kselftest@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and
 BAR1/BAR3 as RESERVED
Message-ID: <372csbbx4fogqubtz2mh6ztqhpriohecszidhr47fx3lnjm6nq@6whpuyd6vypc>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>

On Fri, Nov 29, 2024 at 02:54:12PM +0530, Manivannan Sadhasivam wrote:
> On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
> cannot change the type. So mark the those BARs as 64bit BARs and also mark
> the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
> use them.
> 
> Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

