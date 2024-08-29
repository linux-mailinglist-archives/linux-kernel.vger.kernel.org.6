Return-Path: <linux-kernel+bounces-306366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A31963E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51F81F227FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87248189F54;
	Thu, 29 Aug 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZyaHPkZ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2452E16EB50
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918926; cv=none; b=iWX/fPjuwhOtupr9x/SiuPK9fk6kN976J6+MpKuES7idZb45CRid2SO6+0bWM/tmcmEodFLzoaREss980TWcASXjxoWmExm6UgJ4MQMRkL8Nv0DwSiSBp24qFrMz1jPd/41Jk65MFPHkH3wcN0hdgGlyzjTeW+cHomRoxA7PsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918926; c=relaxed/simple;
	bh=0/9pzeYLRdS8zB2Y2FxT7S7A9LvOM/8Gj6nTQAlPhG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM1N8eg1dKllmKi8uye1ZkOBqMhK1KWpBpsZPMumyAaTvlKQhbAput1mzO08+npAs7ZOuHjUYgBmsZN8pyidZpzje9aZ1dFYmJyLynmNCZTeZY7zMIKYWA9cduyvSOl435TTYyuDt2yVs2ZYCg0Mx6P0HE90uOLN8KytYApDwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wZyaHPkZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533496017f8so481506e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724918923; x=1725523723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4BmdnrzBdhHgzltTkpUo2txI/5MakiYPq5y08PZ3iA=;
        b=wZyaHPkZuwlOGp0iunpaOknMyf0WyHC9wRgSIYzy+TpzomJnZ+Ws7znVeJARtzvPsh
         OutWYQSTBSd+8uo9Vl2zDINhaSTi1o0ir1ed9eizWn00nmOaw8aC+V4T3Zv0fLQXWRfu
         wgJIMA/NezdkSG0lEdbHoJsdTgG5efBMoCRoEpcbQ4nPJRelShyFOf+FwR+9WQs1z/3D
         4gqcQWslpdXnaz5mX1X8ZOCKg6E0oZq6tIwyJyOhCoQ+VsfC5f6udZOZr5qAuS0nB07m
         FKlgfjQnMGwVE+ynN4XWoAkP8hlE6iUm2HKM+lsT255Oyd1l17UXKhe7E5wKmohLtjID
         jMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918923; x=1725523723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4BmdnrzBdhHgzltTkpUo2txI/5MakiYPq5y08PZ3iA=;
        b=Bgy+Kn7WpQbF3EkgH0e6WGCtSv7T8Gzj7rPeAghC9MVIfqMNUJuMg/Vi639jlBLTVD
         EkVTNL5TlRfCstZrInQwoIK0QojdzpsxyEmLmt0qoupioKJP/1vjWX2XludHTqopGutQ
         iLtK/QsalVYNYcWZyV5pFYYitADLlXc8fv/QxVuMXxjpGMLxjyZ3rsC2WWZQJpaTEiGd
         MdPSGuW+r+jQ5TQ8LdhIAXiQ0utAZHzb3Gx5sw75wgQ9Cot+OTbder3+aBGzJdthkEno
         S4mdq1dBwdGG0XSuCc2YoNQ6QUWUMEaUXPlymZ0nXbcNRAFZi68ieBNzsHgZzMUuRqcV
         uT1w==
X-Forwarded-Encrypted: i=1; AJvYcCWusOmby5Kyh7TSY7DWJcxh51oEGRtMi7d07GcWMIhGadNtNwf2zqOQ1F+TCAK/01wrTuMMtMWpG/WWE9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNA5Imm88arLgAumJbqGCr77aP+o/fLKXiR3lIIH5yWU92bUMv
	crZQM0cQyypdF/kYQ2iAkgLqBD9VuW1RPmSumF40FeEXl1wk35gd2VtUqnpN+c0=
X-Google-Smtp-Source: AGHT+IFTQjqSKFSw070YjNsOEWLTFMBsy1Rq3X8Pmfp9WqqZRc0GHm4rRo/dmxH9UycESrTXamJ/2A==
X-Received: by 2002:a05:6512:1195:b0:52c:e159:a998 with SMTP id 2adb3069b0e04-5353e57874dmr1271656e87.29.1724918922593;
        Thu, 29 Aug 2024 01:08:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540827759sm86257e87.158.2024.08.29.01.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:08:41 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:08:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yangtao Li <frank.li@vivo.com>
Cc: vkoul@kernel.org, kishon@kernel.org, krzk@kernel.org, 
	alim.akhtar@samsung.com, konrad.dybcio@linaro.org, liubo03@inspur.com, robh@kernel.org, 
	yuvaraj.cd@gmail.com, ks.giri@samsung.com, vasanth.a@samsung.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] phy: qualcomm: phy-qcom-apq8064-sata: Convert to
 devm_clk_get_enabled()
Message-ID: <fngnwis5yyf56w3vs424clfuqf6qvaquq4udipqidco7jmr6fx@ijledjmr6apj>
References: <20240822084400.1595426-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822084400.1595426-1-frank.li@vivo.com>

On Thu, Aug 22, 2024 at 02:44:00AM GMT, Yangtao Li wrote:
> Convert devm_clk_get(), clk_prepare_enable() to a single
> call to devm_clk_get_enabled(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-apq8064-sata.c | 22 ++++----------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

