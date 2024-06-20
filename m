Return-Path: <linux-kernel+bounces-223442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A11911317
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47643B2217C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BC2E859;
	Thu, 20 Jun 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qE4YyeQ1"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB51B9AC7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915056; cv=none; b=JmbhSDG07sRBA7ob44NKfRsbX9zxQFxedOgwk9nk+0mts8B4L9DUgOENNgyE6gaCz2w78z+6bhHnX4HM4Kxjy2e4rzycRc7pTWauqxVCHH+1fqlPx0OJ0F4hjZ1XzUWnVkrmH1vC7rkRX8dRA1skop23dF+5GfhS87bEOhLMMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915056; c=relaxed/simple;
	bh=DXU+kaQ13mDGzc/ERef772ITWHwfMHgJ1whdUUQWN5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSY3wII9fsL0HnWUhKlIEp0MEMvo/NRVK18QRcPh3m9JySHDRVz1Go9npeDg5CMzIvAVQ4kcjPCLsFvZCPJV9QL9ExzL8Thsgu1//gXbLtbiV71Sd0dGPBZqDheYOObuZIyFG6TM99Cda7EwPwEmVB6B1oK+eMXdonLjPRqVgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qE4YyeQ1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso1516671e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718915053; x=1719519853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjwgpUTvj0kF3WJiIA1rR+AvckGLAoKpZg/E+Ljg++0=;
        b=qE4YyeQ1jlqKNCbJwysMQtB2F/3JuJboDCc51OUgaRRNdeR8yzQy17/WTz3seimzB1
         IDECObgnpRBftgq7JvM8jtr7BPWcleXZqx2yKY0+NxwCVfm2tWzbsTAIsIiLJH8ibQjb
         Y7qGyvf6OvVX6fgB0DYISjxN4DbV55/fzTDixBK5MyBVYS9JniNV0T4wEvlfVvLcBnwM
         63RiqE49rBH3d6RqNStPqZSOG8GN3AkYbROaeSLYZEQNpzrd+U3CxEc5ThRg4dBIaRyy
         iSMgL4M6F0GNg1xschNsCjxRSvyTSY+biDtDllWo7s/ASaQjeUxAfylgvcswhWTCtkrz
         iKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915053; x=1719519853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjwgpUTvj0kF3WJiIA1rR+AvckGLAoKpZg/E+Ljg++0=;
        b=M+vjOZ/oVmOu84ToK55TAhLi4/HiE/THRDSHwEQyWgo35uYfaNY9iWtRWKtxMN7L+l
         n+6h0je6mbu1G/5Wwsa1Y/9QxkkgSKOc2OsxJGfBzC2UB1/T+x/krItVJhLeDidnk8TZ
         t93LLNiqfIMpQraIQ+Ixxo6wjrl4PiiYDxgnYQbsC2crm0tSV5JMru+WrZnbNvbsNRnA
         ZNHA3LzZRZEwtd9QxqXaq/fZVff8t8q5ADT1yNj7I19ME1ZQVVLYW5htX2AqSjaDrT0x
         UfmR2i9cn1/fc5XuChSZKqVNBOvSmjYxo27VWiWSVKF0xh8Ctj5nwsUy7tNTRu2tpD8o
         rXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/jT7En5Ay6MbXso8uQJ/cGv1hLnSv++4UvkUHsbWMuYxlbmF9S7vh1P74Z4iZ/hT4PVlxFPKsV9VKZ1Pc1vCktzXCEm+4UTUMC4V+
X-Gm-Message-State: AOJu0YxmoCP1AnsB+8mjQPJI+DbNo+0nRpoVeC0TmfFFSrcgECv4RTYS
	CgVSKfWz9Dq/X7WKlaQ2mDXLNyBF4vUXCNV8SvIqwDCn5yTD6fu7je/8YCJgmS4=
X-Google-Smtp-Source: AGHT+IH9EWkurMSwiLpS9SksacWAo23NNuhZoV9rS+DFQjCv4svEZZXVS1qoWFAt8tLMdslowIQ2nQ==
X-Received: by 2002:ac2:4e06:0:b0:52c:80fa:2967 with SMTP id 2adb3069b0e04-52ccaa2d61amr4627356e87.12.1718915053081;
        Thu, 20 Jun 2024 13:24:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282ed95sm2154233e87.75.2024.06.20.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:24:12 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:24:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] clk: qcom: select right config in CLK_QCM2290_GPUCC
 definition
Message-ID: <lrvvogzmhtxsjyebebjngnhu2s7rwwrxl6urvl35kte6n4panl@hvejq4mbwvb3>
References: <20240620201431.93254-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620201431.93254-1-lukas.bulwahn@redhat.com>

On Thu, Jun 20, 2024 at 10:14:31PM GMT, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 8cab033628b1 ("clk: qcom: Add QCM2290 GPU clock controller driver")
> adds the config CLK_QCM2290_GPUCC, which intends to select the support for
> the QCM2290 Global Clock Controller. It however selects the non-existing
> config CLK_QCM2290_GCC, whereas the config for the QCM2290 Global Clock
> Controller is named QCM_GCC_2290.
> 
> Adjust the config to the intended one.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  drivers/clk/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 8cab033628b1 ("clk: qcom: Add QCM2290 GPU clock controller driver")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

