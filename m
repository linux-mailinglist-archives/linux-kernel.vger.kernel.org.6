Return-Path: <linux-kernel+bounces-348580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3898E955
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18890B21259
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D333C488;
	Thu,  3 Oct 2024 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzyehmA5"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB13EA83
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932702; cv=none; b=Fk0DPHrksFog0BDg8diuM3rQ37VtTYJGPlaqjY7s20bNA7mHtvnxtT2yaTXbxCBaK9FsTk3FPeQI+y/HgABKuy4eoWaI1iyjvmcPJzg4YuXn3FT2OpXEobUoPo+98uZ+p9MXN3A9OdCqDPDlTZYRkWtI+qIkuvYMm/QPGBXX/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932702; c=relaxed/simple;
	bh=p9cTNf+ce+MkFrpLZLlHEwPklnOHGHnSpCKPYrEmLd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0uf3bMbz5aljFlxa/QZsjqQJpFhxZBCDHMYondTbZGJiizdz+zRHBpft/biiWKPjVYwQqCcT9Q3TnU7CBTtf5E+TOYK5V6I1iqVXH8fIyBQuw1NmxdJ61F+J87HGQ8FhOOp1pjZm5Ivj0jqHuEg9WRE1ANkcY4VbIP+U2XIkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dzyehmA5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71dc4451fffso544105b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727932700; x=1728537500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=La8UkmMy64RUqJRJKCrBaEEk9eBf956ZjgLNFqjYKFk=;
        b=dzyehmA5+wCV3EgfoJnjZh+SLN3nBVRFArPMo5YrAz/KFeaZYPYE/FBuXBZcUitzP0
         1uj2UEOCcix0M8lZNH1iIY1ZiR0sVxVW9qFdtEcoo1DkPhSxVEtFKySYtNWIR2KiebrO
         c4XE0MVN1LAVbBVZkfgf6wEr0200RJMtn+3Nv6HP7PowydGoz66p3+WFj/I7HCD5+KG/
         8dLvyUG2sR4AOhFUv2VVNsbtQvFs+eYL8wvxxX3vx8dTWTrA95cd94X6Honlx5Vg5f3r
         k4Aia8WWvrf8V5HQO12isqm0Tk84TF6NZtke0B/rbhedWdukS6MjgNr9JCwmRbFQmkA7
         srhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727932700; x=1728537500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=La8UkmMy64RUqJRJKCrBaEEk9eBf956ZjgLNFqjYKFk=;
        b=O3oBg1E9rCEnnYfg9izOjjfuUVTB+w3zW19Bajou2L1LqLM0cPEYtos2QIunPVg31x
         NlKBnBNIaW2xr3b+dRCin132CAHt3uX8upZ+WTNRFZ9B+127qmM9RgX2A9DSzv59+V3a
         BovphYpDdQH7uJkiiRtHVqwdcx8dt9FNZfostZQiUuNY6sdSspFb/gv2pY4H3E/4X3q0
         HNiZawjxc6163Ea8K/TRObNnJuWL2zDxfjnnLeV7Vhh6xN2HwKDMbcGghIFrt2h2/nTx
         3dgReXP11SkM8BoCAtvbakxOx02ccq+6gYoNnOYeIK+yjR25Dz4AntJLw6ThuAuNN2lA
         +sEw==
X-Forwarded-Encrypted: i=1; AJvYcCVH7Og0MjSk3DchzP9FrsKSHlgC09EuHJZce0jJUMPy6HkKzhr2sZEpeyDuJWwh5zwUpSTIMbmKKTakmuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhn1gYzbxODK+sJT8PhVzm/d1Tw1BBmoXqnWMwpKlNwCXSEjQm
	mcjCIK0MXjFlNk9StCPKN6doTDu9kIKkywhLzryc5MLoB4W44kEwlIYakDwBEw==
X-Google-Smtp-Source: AGHT+IFZIWorr/HQ8QCSrVUvOBlny0PGSXcekwxov0MUHcurUi3xP8jMoZMLLkGa/k/YVOcbFt4CIA==
X-Received: by 2002:a05:6a00:181c:b0:70d:2892:402b with SMTP id d2e1a72fcca58-71dc5c66d09mr9998786b3a.7.1727932699794;
        Wed, 02 Oct 2024 22:18:19 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8c2b9sm444447b3a.79.2024.10.02.22.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:18:19 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:48:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] bus: mhi: host: Fix typos in the comments
Message-ID: <20241003051816.lnx6qo5fm43ljygt@thinkpad>
References: <20240929090334.524543-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240929090334.524543-1-yanzhen@vivo.com>

On Sun, Sep 29, 2024 at 05:03:34PM +0800, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Fix typos:
> 'Normaly' ==> 'Normally',
> 'gurantee' ==> 'guarantee',
> 'guranteed' ==> 'guaranteed'.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/boot.c     | 4 ++--
>  drivers/bus/mhi/host/internal.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index dedd29ca8db3..e8c92972f9df 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -82,9 +82,9 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  	 * other cores to shutdown while we're collecting RDDM buffer. After
>  	 * returning from this function, we expect the device to reset.
>  	 *
> -	 * Normaly, we read/write pm_state only after grabbing the
> +	 * Normally, we read/write pm_state only after grabbing the
>  	 * pm_lock, since we're in a panic, skipping it. Also there is no
> -	 * gurantee that this state change would take effect since
> +	 * guarantee that this state change would take effect since
>  	 * we're setting it w/o grabbing pm_lock
>  	 */
>  	mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index d057e877932e..3134f111be35 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -255,7 +255,7 @@ struct mhi_chan {
>  	/*
>  	 * Important: When consuming, increment tre_ring first and when
>  	 * releasing, decrement buf_ring first. If tre_ring has space, buf_ring
> -	 * is guranteed to have space so we do not need to check both rings.
> +	 * is guaranteed to have space so we do not need to check both rings.
>  	 */
>  	struct mhi_ring buf_ring;
>  	struct mhi_ring tre_ring;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

