Return-Path: <linux-kernel+bounces-283163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8EE94EE14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252E2282CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367FF17C9E4;
	Mon, 12 Aug 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdrCveZz"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75417C7A2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469147; cv=none; b=LqOZ3GjhHX8st9r9b3RvDf4gH3B1TNSrtjJfYQEeVxHFEpAP4+m2y2ceb78yxJwNuLjLBWdxzp8ovhsXWEm+E4r3RcToJYLQHWC7LjlLg3C4KjdmehpN7ubxIvRS+OKhOWdOxPPl3Sen4sb1YwZcc72BfMSSFLKRhda66CmGtrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469147; c=relaxed/simple;
	bh=V9W1mHBG7nCjOakKrNvlHdCSu7XhfjXNoktXt/lNYZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ifsy2VywlIN/+TIRtPGckIM4xuuKFyaXc6xzveOCZvUiiLi2K/O+/In1Wqmk4BbF4grTqQgLa2h/Y1GwA/hoOGkLed8jVmTT3P8VdLXn63yxIgbRsJ1SPvGVhRtuyWRK1DbsfRMEz9srNr3pVvo7sFYfOVhuXOkCDxH9GbnGlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdrCveZz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd657c9199so255565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723469145; x=1724073945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmYajX4gMaVGigJxbQG+9M3259675dZnYWJeb/SxvFA=;
        b=SdrCveZz8kcTv7g6nPUZzG9HVj0VCgqPC2B/1JWwOMIXIw+yGIn2Ua3JybTDt5ZO0d
         Gq6f18I9Jc/9D/C83jhFBXpv6G+Ot0FQga/LcyDy7ofFv6vvJw55hkPijgGk7vpM/8NB
         fwk/QOsXrmnM+pyHoVFQd6OBY97L4MvDtEapss+MVA7HQuzPfJP7p5xh40fthn3nN1/n
         4UeGQb7ozk9be29jsRv/E99xO170axB3SJvZsRauWqUmM6xHjWoyiHK34/BKpTCH7ZqS
         3oyX/zz81eyxRHDnZjubV4vjblTQo43qN92zDnM6o1vgqTJ8JHd31Ne/8JVrGWWi7yMV
         YnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469145; x=1724073945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmYajX4gMaVGigJxbQG+9M3259675dZnYWJeb/SxvFA=;
        b=VhrdCALyJ6VEcddMSQ/GzPS4XWWZE3sWRtjwEVaben9mUNGmliOvjTj6D/2uvRui8/
         827cvnKgC+/QfZE1+nl7cesP+uxLOvC0n2RGYVNK4JTPMmVKnC0ZMZe+3Y+AcjX66YiR
         uAu1D/2I+JlfNjjMda0klS/54blsSUQWCIf97GHp/4WLXCQXMGr0xVyT1tbF1euZnpxk
         pKdBiZqpPSjDBGNZ9/LYTigph3lqIeuoYII/JVJ2MVjX8QSwaEpXrPgm8UsyVz+GTsV5
         QXzq1PzqUrPD8u5YN6d29/HXGY/MvfT1jgzGRE9fLao+8+5VKeaUiSH+ObuvA3V+nVg4
         CMfw==
X-Forwarded-Encrypted: i=1; AJvYcCX3orXmlqp+qk0ew3rFdVEV2t+Kr4sZkNoBIF+UoFEtB9AX23y91PXtnTb/0IfxT9S8KUgY6VgXLca1u8SSUcBFPRx/fvcty+Ghfl33
X-Gm-Message-State: AOJu0Yyx20y2INEFa43C3qAhFHEAkthCK8ElWGGnwTNYo3/Wpxjo/rjD
	I1WihlDZnwaB3N02yFUu5aDvLF3FUXCTYhbm6K8T8Y+bECVZwAqUKK69MbRqtQ==
X-Google-Smtp-Source: AGHT+IHb6qeSJStNs0pVR+CmYkttDl20c4Sd0X9v5RgYO5YZwdbSZX0vov7dB1RIgvFULpIown2sxA==
X-Received: by 2002:a17:902:db04:b0:1fb:3e93:79cf with SMTP id d9443c01a7336-200bd27550bmr4027905ad.13.1723469145000;
        Mon, 12 Aug 2024 06:25:45 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a89e22sm4085935b3a.170.2024.08.12.06.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:25:44 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:25:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, quic_c_gdjako@quicinc.com,
	dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: remove runtime pm enabling for
 TBU driver
Message-ID: <ZroNUGkKuC1L7Qfr@google.com>
References: <1722335443-30080-1-git-send-email-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722335443-30080-1-git-send-email-quic_zhenhuah@quicinc.com>

On Tue, Jul 30, 2024 at 06:30:43PM +0800, Zhenhua Huang wrote:
> TBU driver has no runtime pm support now, adding pm_runtime_enable()
> seems to be useless. Remove it.
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 36c6b36ad4ff..aff2fe1fda13 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -566,7 +566,6 @@ static struct acpi_platform_list qcom_acpi_platlist[] = {
>  
>  static int qcom_smmu_tbu_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
>  	int ret;
>  
>  	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM_DEBUG)) {
> @@ -575,11 +574,6 @@ static int qcom_smmu_tbu_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	if (dev->pm_domain) {
> -		pm_runtime_set_active(dev);
> -		pm_runtime_enable(dev);

I assumed that this was required to avoid the TBU from being powered
down? If so, then I think we shall move it under the
previous if condition, i.e. CONFIG_ARM_SMMU_QCOM_DEBUG?

If not, we can remove it give that the TBU would be powered ON as needed

> -	}
> -
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 

Thanks,
Pranjal

