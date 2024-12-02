Return-Path: <linux-kernel+bounces-427150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D979DFD44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88A42818F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41B21FA825;
	Mon,  2 Dec 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPaxCPzd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C03398B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132125; cv=none; b=VwLa6cqPkY2Vhr87vnfht05M1f5n/hR01T3XdZBGk7t2FKfnjtfwloLTy+2V4wF3U4tDs3CaoiKkIEX3Sp3cFYsJvWYFuZySZY0Au8B1jIBewmrl6zKcwNNN8b+d8DuqtutO9+v74Yd2cvY9oYDH2f9zDarNEicYIGqB9ebdLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132125; c=relaxed/simple;
	bh=4Ls56rRdnVJ9EpHYJal+FjHAigp26UK24vfmyXe9/Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CebiBlsqzGM8tQlqn8fALmy/Wbl4Nn4lhTeY+rOFP0mUyhaE4QCAXgIc2OkFzsAg96LstHmZ94MGL/f9vlDZEgCWeYOE3qM0MtjjzGtfwAm9YYq/JUMy35o48y20eTnYbyB3lsaYVPp57tcgy+dowSomkpLeKPE0zBrhyAHJAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PPaxCPzd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21288402a26so28665665ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733132123; x=1733736923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D0/jNAjkVdudPnX4cpNWF1d7Eupiz108pESERY6Okt4=;
        b=PPaxCPzdImX3W0PMJOn4VF5xSp9jVWczpsplWPgkqJsLbMbCldSsadph4l1HBUmMha
         FaaolOc2DaoHFtoPNfLCgNf8QzGly46rSwZ/bv85Hgj/rr3MZrFFWprGlGyRs+Q+iLfv
         /3VH0YxRh3Pkdf8D2w4gSkYjOLaRNoQ41sRh13KHXzr5KvdYxkHo+SqjV2mH7V+X0JZl
         rS9gmAjhjv+xBpjr14NhbjWf7DCgojGksAnbbVmB6JSPFWyBmGAbqwlv65ZEZ6urHeyV
         iTzUNNHlNxG6cZmx1K/x1n4KF/AQG6rwtiP3YE3snGC95hNs4oXarC7eLVavW1BbviIz
         XS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132123; x=1733736923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0/jNAjkVdudPnX4cpNWF1d7Eupiz108pESERY6Okt4=;
        b=gMGhSKhnA1SRgAhLfnzPMTvJTRO/6SXMugnpdLK344Dmxe0l7gEidWdsPtS8OO1Tr8
         XXT9nw2F1DOY+h25v54/SJpZrOOcGcE7tJyZJTUfCypotx0lgWUxVX98hPvDMt7Jw9S4
         rUUSdAc08glU3JXd0J6qiqD3sNAKz/Eu2XpErZd5BW42aynzFrigLHB66vowIpqLG7v3
         iaLI4AqLN5U/1RyPnAPAEbq+3Y9z1eJ7vUoK4k6Y5MIPGsrDnKkwT3b0c5Ni+NPQ8YAQ
         HQ+d+ZiRD37tXrce7z8s9nearJvw+QWohsZ819i4hc0El3VY0+7uWFPTDP6lYR/3zYnY
         f6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUiPi29ftpSY0bqmUvA0DqbqN0ibkFa7ojXMN3Ii8nMIznfUNoZ4IQDETGDaouBDfe3UHHBkt+24uaQw+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYV3heU7wAAPSqLqBDINYpCduftFYdtihXzyAtktia3snmBR/
	tykalNlwVHVVePJSngNNJLZx+8Pp1wj9m+jiJr1HABzxCL6sUQHX2iwL1aY75Q==
X-Gm-Gg: ASbGncsRe8wZ4eNGGkHobz5YN/D6gfp5L8GrnV9GN2r5tF2op9ESpNbRh+q37NO3uQs
	/Zij3vOX1Z07bcTvd3roPQcc0/kr2/gp8hBohhksMgnMC9VvxgoPOqjhiZ4fFVI9xtJ9WcjG5mS
	UMbN+hqkLdemddC74t/JCezuvzDN2jWoFi+rdb5I1m4ejxqF++OpC3ueH9825sACMN2vdCqRw0Q
	h+nAGemRutYBtYhFVKHKbw2XwgMgWM1Jo6x40v2B+MFIlKhe3Oi4N7UCKOMNw==
X-Google-Smtp-Source: AGHT+IH6WqX5McwcnER4/bmD3nrKzgQKw8S99c/9pxMGg83RDoUGvFiPAnv49QNfV8BiBVRyQvzg2g==
X-Received: by 2002:a17:902:ec87:b0:215:9642:4d6d with SMTP id d9443c01a7336-21596424f7fmr34824995ad.17.1733132122840;
        Mon, 02 Dec 2024 01:35:22 -0800 (PST)
Received: from thinkpad ([120.60.140.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f479asm72459645ad.41.2024.12.02.01.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:35:22 -0800 (PST)
Date: Mon, 2 Dec 2024 15:05:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mayank Rana <quic_mrana@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: fix MHI BAR mapping
Message-ID: <20241202093517.qhiy7larutekuk2l@thinkpad>
References: <20241201171120.31616-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241201171120.31616-1-johan+linaro@kernel.org>

On Sun, Dec 01, 2024 at 06:11:20PM +0100, Johan Hovold wrote:
> A recent change converting the MHI pci_generic driver to use
> pcim_iomap_region() failed to update the BAR parameter which is an index
> rather than a mask.
> 

That's silly on me. Thanks for the fix!

> This specifically broke the modem on machines like the Lenovo ThinkPad
> X13s and x1e80100 CRD:
> 
> 	mhi-pci-generic 0004:01:00.0: failed to map pci region: -22
> 	mhi-pci-generic 0004:01:00.0: probe with driver mhi-pci-generic failed with error -22
> 
> Fixes: bd23e836423e ("bus: mhi: host: pci_generic: Use pcim_iomap_region() to request and map MHI BAR")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Mayank Rana <quic_mrana@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> The offending patch was marked as "Compile tested only", but that just
> makes you wonder *why* the patch was never tested...
> 

Because I didn't had a modem platform to test my change and since it was a
simple API conversion, I merged it after some time.

- Mani

> 	https://lore.kernel.org/all/20241004023351.6946-1-manivannan.sadhasivam@linaro.org/
> 
> Johan
> 
> 
> #regzbot introduced: bd23e836423e
> 
> 
>  drivers/bus/mhi/host/pci_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 07645ce2119a..56ba4192c89c 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -917,7 +917,7 @@ static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
>  		return err;
>  	}
>  
> -	mhi_cntrl->regs = pcim_iomap_region(pdev, 1 << bar_num, pci_name(pdev));
> +	mhi_cntrl->regs = pcim_iomap_region(pdev, bar_num, pci_name(pdev));
>  	if (IS_ERR(mhi_cntrl->regs)) {
>  		err = PTR_ERR(mhi_cntrl->regs);
>  		dev_err(&pdev->dev, "failed to map pci region: %d\n", err);
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

