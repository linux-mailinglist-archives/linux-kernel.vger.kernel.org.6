Return-Path: <linux-kernel+bounces-337086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8907984514
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943C61F207CF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F258086277;
	Tue, 24 Sep 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rS/teoq0"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2D154C0E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178243; cv=none; b=DRBUlU/LiU3oePBKYD78Q8BH3P+Kkx8BaVnWt7nAXloTiBdHWc8d8kWfjC9uFoPd9u9Epw+u58eURPwdVWrGlxRGy0St3jfzb+sK4bxgeNBgKLH2rJ/cD1sBfsHiRFQzBjt46X/8NdQ5Jg1lguDYTuC5OlmUSfIQDCzX/dUF6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178243; c=relaxed/simple;
	bh=8SeBeMit1erdjYZ5mBMFGazV3ILdKe6iS4Sdobi/Mk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9l6KQBtj8D0KblHWdkOjwlh/ix19INYhVqJljlyGkk+3+/t/Mv0nEIbcZPCo6IFTdIm4eodnbtr8eyc0WqOydUsrsKCpwwX0bPYJJ1UCwmjzdPgKeUGNTKAiy+P5JapYCrn2FDfEeKPWv0oYWcgzN98jT2rRB8f6nO5RIlMWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rS/teoq0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso3731532a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727178240; x=1727783040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKduaMO4XMlChzXeXd41yjomvNaLJYSYU9jwBphsY7o=;
        b=rS/teoq0KIJHtaAF50VUV95jW5v6O7jvtvRPS5XLEZnjC3DS+6JtDwAI0yjsvdb/ne
         Do/ssYUFqNtGB/K2CH3WZ2Xa+vyXC4hhXBq3atX9dXEup67fXxzelXLU4DAx3CnyryJr
         avHL2WooiEBcVsVNKlMmGYgAWyxm3Bb31GaxefE+7NKszf2Mo/m9b9iXoo3ikpZffwH0
         b4t6Y+AjQlJbWiiqd1Zlsv8qFtliP1OuQ/3EUoF7ZDeyd5jT176JjHD5YevDr7lveecj
         VGVkksq+rDbFeapywh6g/Jk2MTK8+Qd70ZC/2R7tDHhV/RttcchnF/q4gBiv7IFieIH3
         0M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727178240; x=1727783040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKduaMO4XMlChzXeXd41yjomvNaLJYSYU9jwBphsY7o=;
        b=qxoNMFConp2/GAfVI5pl112yti19MI8/YYdfGFmvesNxCrSgwuLmHh6KpK804jYEaF
         QpEJZQxQygTatToAmYvKQ55CW/oHev3osyTxvZqdTixm5jCpbSr2PSvr5VPhaCGCkPk/
         o3DVX7FA0LNjWhYMPyudRMG1vUFWKLsUWmw6Wf6Xa4tVt+PA5GMk0UEpS4/U9EpfLVUK
         kUNOp2QvIYNQEcRnLRtGplPXTtQy/uHDuIBqvMRCcMp/7q/uhRv5SOMBdkkwMhdBoyk0
         A3YJLCT36jb6CUZ8gn9dLz6DHukrXwHnhJuPt5U/+cdjvJM0Lx23outVpj2mHGM5Y6eg
         nwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdnzW61SCCZLx2V90Tzca5zrVUAUsyuwCWKC0byM+5NamhMcYn4ZVTRbAZV+RSu8fWtCJRmFY2FqIulVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1J47fx4cLNqbBWvibdE3YEJbJvMwOI6UHs3v2AXL9rIW0IIas
	0/PzDq62Bc/njFe1pKSoHeQ1TzSJdJ44mQa6koddTkYbbZpSMPknQLjSoDX8GmI=
X-Google-Smtp-Source: AGHT+IHdFRTRmrq9kDY7XVL4TEPwSnDzTbPxg5dRRwKzNPceZ2XDt56AOJMtQcehLOdKTJPbRhj/oQ==
X-Received: by 2002:a05:6402:42c6:b0:5c3:d8fd:9a3b with SMTP id 4fb4d7f45d1cf-5c464df3304mr12936844a12.28.1727178239620;
        Tue, 24 Sep 2024 04:43:59 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:8e91:35e5:c6f3:1246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c286sm659697a12.17.2024.09.24.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 04:43:59 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:43:54 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: stephan@gerhold.net, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: wwan: qcom_bam_dmux: Fix missing
 pm_runtime_disable()
Message-ID: <ZvKl-i-UESyzSG02@linaro.org>
References: <20240923115743.3563079-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923115743.3563079-1-ruanjinjie@huawei.com>

On Mon, Sep 23, 2024 at 07:57:43PM +0800, Jinjie Ruan wrote:
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time.
> 
> But the pm_runtime_disable() and pm_runtime_dont_use_autosuspend()
> is missing in the error path for bam_dmux_probe(). So add it.
> 
> Found by code review. Compile-tested only.
> 
> Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
> Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Thanks for making the changes!

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

> ---
> v2:
> - Drop the unneeded pm_runtime_set_suspended().
> - Add Suggested-by.
> - Update the commit message.
> ---
>  drivers/net/wwan/qcom_bam_dmux.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index 26ca719fa0de..5dcb9a84a12e 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -823,17 +823,17 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(dev, pc_ack_irq, NULL, bam_dmux_pc_ack_irq,
>  					IRQF_ONESHOT, NULL, dmux);
>  	if (ret)
> -		return ret;
> +		goto err_disable_pm;
>  
>  	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
>  					IRQF_ONESHOT, NULL, dmux);
>  	if (ret)
> -		return ret;
> +		goto err_disable_pm;
>  
>  	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
>  				    &dmux->pc_state);
>  	if (ret)
> -		return ret;
> +		goto err_disable_pm;
>  
>  	/* Check if remote finished initialization before us */
>  	if (dmux->pc_state) {
> @@ -844,6 +844,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  	}
>  
>  	return 0;
> +
> +err_disable_pm:
> +	pm_runtime_disable(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	return ret;
>  }
>  
>  static void bam_dmux_remove(struct platform_device *pdev)
> -- 
> 2.34.1
> 

