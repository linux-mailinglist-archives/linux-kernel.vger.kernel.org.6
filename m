Return-Path: <linux-kernel+bounces-243956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14348929D00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B83928152A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436C31CD15;
	Mon,  8 Jul 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naJtVH36"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AE1C17
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423353; cv=none; b=U4pYuevzHKWLxLM+JSilgaAQ2pmWrtJcvFADgH/tfyZAUMzLyxU7+Ls5JqGa76ix75Kb2iTMgWU0vfzJMsEQ5fR0IT0pEE+ZOiKKVAgntmJNvIoaejV9H4GoIQgL4TXJBcyIbnSuo8EoLxjCR8uBtvEurbHRH+46esro315iVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423353; c=relaxed/simple;
	bh=idrcO3j6ZJtjys03L4/z16VLpQLwc7Vr6ABcCm9c4rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcHtVvplTD6rBZhillqk71KteggXe3rNLYSzkp9LlEInScr7/fwidtI6SM085tjr7eocA+anRDTTp54mJAJ+C95Jpti0NcxG2vMLs7h/m8yB9pmhYBzCGgxnNlWdrGY35vSDE/in39IBRyH53PZ36BP8aH9zqqEZVDZtP5hlfbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=naJtVH36; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c980b55741so1976305a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720423351; x=1721028151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WBYy4DFhtHluGvHK6v5yjGoMYZnZkSaBjiQQhAn19qs=;
        b=naJtVH36XF1jE7eLb7qFGnd0s0CnBklb/R39zYap08YrXaBuLp78z7BBvXdSrpE081
         dyGO9RSJQTN7tv8YG7K9z1n99aJgSvVw1cL8tswEV6SfYzr7hbU8wAVwUG0wJOgsBMvU
         At9CxJ5F/uAkyQVEupaqc0nejtYCzSKggO1r3eRIGfuTq7vPq2YwCdAuK7Xjr7xp40dM
         /9xgz9n1i8vgFDGwapEbewocYCDWiPAxhQ5ULRNn02BeqDeUyHH6jF9QmHWwdex98qN6
         uzsPXMlhc47SYLlmdC8sCIw7hBqcOi1M0t2TrbmsoG8nGj2PvapGR+s50K/dFCoSlwxK
         Psnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720423351; x=1721028151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBYy4DFhtHluGvHK6v5yjGoMYZnZkSaBjiQQhAn19qs=;
        b=uBuwghFPdtl3qA88yFDPs7oNllocLT/julPTEnbB/cFqamtlrI1foLE/6HhBx9VCPl
         QGn9Zj7+XHgC6+JnmrH8DJ+nObXwMdhyTTbXC9zSZkFk7w1KyWfQ6egs+zLxDOtJG1JF
         oKu7VYvKrVcM+h5y6j+GmAYaDzPWIv9Z596nybUbzZbMiK0Z4TSCV71VOQ/QBTK48Xuq
         VAt+yL99jlG2oQKKBqxh2L1uYWS0uLS2PLXXB4jFG96mGKRdEP2UfU11ompErZm1nMW6
         05z3zyTtCq4Vh+eKQwtYDqVbCaXi0mTRocUTmN3AhcvS9g3QV0O2nFkoFAHk7huHRdsM
         yd3A==
X-Forwarded-Encrypted: i=1; AJvYcCUL5HgpTr4YyzN4HfN2AqMFOZP9jHSerQFj5aRgVLTCEmUlS9YSg+RJzuqTRzzKIoOsEk1WGpVQ0cHbvNGcD6lic/brdXk+LF4uIuLr
X-Gm-Message-State: AOJu0Yzwi7P0Wvdqu3OKxHMw/j0bZJdVpW/5qCjJVHf/7gN2tgkwcbfE
	TseSgSRoYtnIr3tLVBgMeoltTu05jhAxbhlyybEVjXcd4Grg6snlww1N9q9YcQ==
X-Google-Smtp-Source: AGHT+IFngwXllRFZcKK0nuNe7EQX8bnOyVP4qDVSraN9DPENqjrGFBeOrH4P+ZLdpGIK4/tpQ4aKPg==
X-Received: by 2002:a17:90a:f0d6:b0:2c9:8d5d:d175 with SMTP id 98e67ed59e1d1-2c99c825acbmr5927647a91.48.1720423351318;
        Mon, 08 Jul 2024 00:22:31 -0700 (PDT)
Received: from thinkpad ([120.56.204.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aab8e04sm7429684a91.56.2024.07.08.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:22:30 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:52:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
Message-ID: <20240708072226.GB3866@thinkpad>
References: <20240707183829.41519-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240707183829.41519-1-spasswolf@web.de>

On Sun, Jul 07, 2024 at 08:38:28PM +0200, Bert Karwatzki wrote:
> If of_platform_populate() is called when CONFIG_OF is not defined this
> leads to spurious error messages of the following type:
>  pci 0000:00:01.1: failed to populate child OF nodes (-19)
>  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> 
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index e4735428814d..3bab78cc68f7 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -350,7 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> 
>  	pci_dev_assign_added(dev, true);
> 
> -	if (pci_is_bridge(dev)) {
> +	if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
>  		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
>  					      &dev->dev);
>  		if (retval)
> --
> 2.45.2
> 
> Just in case this is needed.
> 
> Bert Karwatzki
> 

-- 
மணிவண்ணன் சதாசிவம்

