Return-Path: <linux-kernel+bounces-381536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5F9B0097
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E854C283737
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC01F81AF;
	Fri, 25 Oct 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z17N4hI6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C01F818E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853640; cv=none; b=lbI6jQ12xzyOiBocxYNw+K4/4Dv09bK6lvsMctCzTNIkatuBUCxrzzKzcF4pFv+2+Q30JhL7ihwOXsXZWYuFrBcwHelTk9QulvOjyu5kHntuWXPYvoBEWTBuv84r2lh6VDLpiXuSGDO2pseNIMVBCZGhVMWarAuYJUKqcUmDVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853640; c=relaxed/simple;
	bh=LEOouHjz3xgbZqxKkGMbEVqRkjVE6m+mBqZncj7UWWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfb+C1alhtZHGr6cdVOcdofl+F+J7KFy4AoB7JuDiQSEhLUb7BmxhLI0Q0p1k4qCFCv1M5+ZeK5fHOtbAkrae0yC/ULi6hwjwO9GB/T/LdWR3g9LM3b0ofqbO2dl1V+6WiwpEso9KHsvryAbFqrnJvKDSOLoklXdG74EFExPvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z17N4hI6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fe76e802so2416276e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729853636; x=1730458436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmKXZIf8Ec7f1tVnIx5TT9jHdGRyQWK0W1K6HaVuKu0=;
        b=z17N4hI64ixekqKAug+6uGm29hrprobIpgQxSI0uwMMNsIocm6XLZCo7zeYpyphAl6
         RZE/nf9hdF1md6gPteM97XqptYCseWX4oRkfBq/ypn9jMEe3Vf4z7DgrNCgcd4oRfhxt
         JjmiQNqXahpz9wrh9X/9BeoNcsnj3TTDedGoGT5a3co2wSPicFAQRaSlAmtcxNFnCXdO
         khjpqsf7jMyZNgVV6CGn/gy0a17DU7axSMy1P8TePsBi+3Iaxq2NXfbdKxjPY0y5fQWR
         Q6URyO2tDZlWAzb0qyJ53myQTrJ+H+V6PIv+aEtC++JGJBoFkIQP5m0qoMHKzDErPRPN
         i0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853636; x=1730458436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmKXZIf8Ec7f1tVnIx5TT9jHdGRyQWK0W1K6HaVuKu0=;
        b=n4zpYM8t+T7lrM2/XAweGswmKyfVxchW87CXujogJnKD0y9DN0InmF8S3adnApKJLd
         0y1zl7Bfn+bx3cZ/cJioXyX3rVJWGikcJqkLGH9Bqhz3vy8F+ratwoLEL8RCaTW5qnVo
         2VCcdPQ+nwIrYO5qnWpwYJ0vzGa+MhgK5LCgIzOjqB+6f2SJ7DMgnOVHugW9oKAo1jY0
         yeOp2MFmRhVfDzogcx2uBI/j9mukOGZcO6VW/lLW2QGdyEErt1u7hHrg34cMrFvwrUjp
         Wq0HhQdAorcZSMUuNU3erRWXVhvDPUQhStyleJ2n6E0u5cymALftqFbGfyAWiC1TD3zA
         fOVw==
X-Forwarded-Encrypted: i=1; AJvYcCWtIjHAy5pmkN/fCf7Xr11/gzvloILCDSff1baCwwZgn3WPaH9NpaRFLud7rM3o5JPpYZuU5wacU9e+g6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyljPp1K7s+0B2hlAPND9FE47KpTm9Bq/RHJiU+3NmbkklnKr+d
	/UCSwUXMd958vYyt5+tHgL6+x7lU0/gt5pN8Id+yDCU+klgWCbSpIeLdtVPhDSI=
X-Google-Smtp-Source: AGHT+IEG/HWpZ0M54se6Xct+kh2GChQAVmq4mfyhxQS4HKSlZc/4tTJQommgTh0ryS0ELWVi8q7ApQ==
X-Received: by 2002:a05:6512:2820:b0:535:6aa9:9855 with SMTP id 2adb3069b0e04-53b1a23cf0emr5001815e87.0.1729853636123;
        Fri, 25 Oct 2024 03:53:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e124620sm135774e87.76.2024.10.25.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:53:55 -0700 (PDT)
Date: Fri, 25 Oct 2024 13:53:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com, quic_narepall@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH] mmc: sdhci-msm: Slot indexing for distinguishing
 multiple SDCC instances
Message-ID: <i67dn7yopqu3szooas7tnlftbba6ad4h2324axsgu6g6htmo7f@gbwqohqmixz5>
References: <20241022141828.618-1-quic_sachgupt@quicinc.com>
 <3e2f8132-af87-40c0-9c31-c0103078fe39@intel.com>
 <1cb1e8c1-63f4-4752-8358-b5c7078f9c6b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb1e8c1-63f4-4752-8358-b5c7078f9c6b@quicinc.com>

On Fri, Oct 25, 2024 at 04:07:52PM +0530, Sachin Gupta wrote:
> 
> 
> On 10/24/2024 4:38 PM, Adrian Hunter wrote:
> > On 22/10/24 17:18, Sachin Gupta wrote:
> > > This update addresses the requirement for accurate slot indexing
> > > in the sdhci-msm driver to differentiate between multiple SDCC
> > > (Secure Digital Card Controller) instances, such as eMMC, SD card,
> > > and SDIO.
> > > 
> > > Additionally, it revises the slot indexing logic to comply with
> > > the new device tree (DT) specifications.
> > 
> > This patch seems incomplete because all it does is assign a global
> > variable which is never used again.
> > 
> 
> Qualcomm internal debugging tools utilize this global variable to
> access and differentiate between all the instance's sdhci_msm_host
> data structure (eMMC, SD card, and SDIO).

"Internal debugging tool". Thank you. NAK from my point of view. It's
upstream kernel, so none of the behind-the-closed-doors tools exist from
its point of view. If you'd consider making it public and open-source,
then we can discuss a best way for it to work.

> > > Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> > > Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> > > Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
> > > Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> > > Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
> > > ---
> > >   drivers/mmc/host/sdhci-msm.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > > index e113b99a3eab..3cb79117916f 100644
> > > --- a/drivers/mmc/host/sdhci-msm.c
> > > +++ b/drivers/mmc/host/sdhci-msm.c
> > > @@ -292,6 +292,8 @@ struct sdhci_msm_host {
> > >   	bool vqmmc_enabled;
> > >   };
> > > +static struct sdhci_msm_host *sdhci_slot[3];
> > > +
> > >   static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> > >   {
> > >   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > > @@ -2426,6 +2428,14 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> > >   	if (ret)
> > >   		goto pltfm_free;
> > > +	if (node) {
> > > +		ret = of_alias_get_id(pdev->dev.of_node, "mmc");
> > > +		if (ret < 0)
> > > +			dev_err(&pdev->dev, "get slot index failed %d\n", ret);
> > > +		else
> > > +			sdhci_slot[ret] = msm_host;
> > > +	}
> > > +
> > >   	/*
> > >   	 * Based on the compatible string, load the required msm host info from
> > >   	 * the data associated with the version info.
> > 
> 

-- 
With best wishes
Dmitry

