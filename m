Return-Path: <linux-kernel+bounces-306465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1C963F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3521F2585D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6218C036;
	Thu, 29 Aug 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IO9zLGNq"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A61158541
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922146; cv=none; b=nDLlJYC4XyuinpGZKPrAC8Hj2PzS/ZeMiggl0oC7GzdJtPB2iPSihttVVkCuBmDYdvrSQnLLD4E9y88EcWXEazMgbXocXNGNuN6i73pMyt+IJRJaJnQW/R4STEEvLTAr8okGkDkdVPysPPyln+D6EdlJmjh7yy/AqoWFCneWeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922146; c=relaxed/simple;
	bh=SJWHpbSUdECm28dnl4r/RzgBRh4JcSct6K0jvQuIYy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVANXJe9JhdaIrbxjdn0S4v0bytWA5B0u+cmlBbaUCr+Vi+NEKXemiPfF78hNmtad5Lb86A0ffsjU/Q2txy9yKaoC3YOB6IrhoKfmKGqnKSApVISQnK4g1dhdMkHg2qlDvmBFIgn4eqvjw8trHygvVSfGyxyEai1/+hX52wSr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IO9zLGNq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533488ffaf7so573188e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922143; x=1725526943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5P5Ex+N4LZb6zHIhcHrVj3uRGPH7YOgGJO2m8XKmhGg=;
        b=IO9zLGNq6CFij6ASdq9vmHo7Pzx/CeeytKVj3y0V0WP2NTsGRv2SmNX5aSKlzz8ram
         R2f5fmP25DBJWnXcGjaUHQwDMlrhGkd//w3QsRchozam2XmJ3mQEiJYWBy2vS1AVLG23
         w3TQlBycqDY1T5dJsAsbLXLHKhBENRCiTf+idN7wZa54LajF3zOTG59oubS3CbyoH+Vj
         EtOezoPhJra/4lZ6G5ml/6BQGodX8+xgmpk+4kBxXqHhaGxex9fc8OqFBF0x4zF2fxiZ
         fhL+6NBciYNZvjjUGjS08bNz+MrHHAYrlj47DW0+UoCobssVQjuyHwP3a0yjkOdsJD2q
         mOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922143; x=1725526943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P5Ex+N4LZb6zHIhcHrVj3uRGPH7YOgGJO2m8XKmhGg=;
        b=KDOAX0q4lV2lJ9JstvN5xHKrLWXSDLQiwRUDkNnp+zE197s17X1lvR4ZUcIfg4ppcW
         jnPyTpGOKuaCqAMvE/adnQSGAAmyUWufd81qYr3YcoM++uzKj1UcvdW6dz4+yjxka6lO
         PheF0vkD/soddyQvOXsVTCzeRmv1Sgs01GizQd0jSdUInDRILCJnOVyy0w+E6uKLrcpN
         AmXHVTHfgJz5h0xXq6mSX61YzlgjPEwDf9tUQSzCaeOoV1HL5Y1f5uncj4ixwe6sYQA4
         aOjPrNXmNqIlrU35nyNl3dGFHdFPPQ4CL6rpzETKvPp9BBKSL/C7iyIOqSWADmlCXkSK
         2iMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDtjL18oElNCVLrKmPe12WFw9OAcgFl7b7OSBwfuRJt81Ff8fGXaHyX86SyynExsiobihu/g3EDECWM8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2tQH8GAth5dq4ape7hK82floYpwYF6KpF1E8D4/USX3DowYW
	zhw107g3fQPi0A50xVdyGx92n0cjn63ErdrIoM7bwua1qR4ddht+JH1THKEK1ya0dflJUWLdOgC
	y
X-Google-Smtp-Source: AGHT+IGcMcm2044/0WGDWFbJHRAvj/BsTuOR4L9ig5/T+UOYFsPZ/6eOLoDYbc614YSbGs4frHyR7g==
X-Received: by 2002:a05:6512:10ce:b0:533:4aa1:a517 with SMTP id 2adb3069b0e04-5353e5742admr1706621e87.36.1724922142243;
        Thu, 29 Aug 2024 02:02:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535408278ffsm99157e87.121.2024.08.29.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:02:21 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:02:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, andersson@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensoure.kernel@vivo.com
Subject: Re: [PATCH v2] clk: qcom: Fix error checking for
 devm_clk_hw_get_clk()
Message-ID: <cpcdztpwosze4l3uhf467vorfu7jqfciglmzr4r6xcre5eci6m@pqwaadsviapv>
References: <20240826061717.2016126-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826061717.2016126-1-yanzhen@vivo.com>

On Mon, Aug 26, 2024 at 02:17:17PM GMT, Yan Zhen wrote:
> The devm_clk_hw_get_clk() function returns error pointers.
> It never returns NULL.  Update the check accordingly.
> 
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
> 
> Changes in v2:
> - Return PTR_ERR(icd[i].clk) instead of -ENOENT.
> 


Fixes: 8737ec830ee3 ("clk: qcom: common: Add interconnect clocks support")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

