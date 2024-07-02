Return-Path: <linux-kernel+bounces-237647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26656923C17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8C1C22A61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A844415B108;
	Tue,  2 Jul 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0fZ5M3a"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730E15B107
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918526; cv=none; b=QcXUecRVrU2vtJF54kNoHz/faQZRvpj/z17MhoIAIb/E1P/zZcpHttk7+L/2n2Tnnspp2L5Gm/mZ+QGlokZRBNQIjYISenFLXOkCnbkQ8YRvXiDLI0iJNHVxItOtaf7wAXjr1t58NLirls5w09cRFYhMGywkXmfs1JG5H5V2Gak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918526; c=relaxed/simple;
	bh=rkLpdMgiJZFVhnB8hgL0AQQ81N+bITs8qz59JOchlCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcTOQmhtrHXiFUDHSif38NLVe68FJsCsXcSAZJW3V9FWDmfgU1yruG4lssU7rmvaA6FcE07Hiejslt2JdJ+IWlViK3/uMy8iXLFWrF+P66a5KAhpWMt+qhtu/10sXOMBu8Jh0gxBNkf9qaRuyonLj8LT2f2WB1JFFVvrvszh9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0fZ5M3a; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ed5ac077f5so48353271fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719918522; x=1720523322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BetJ1UFbBIbWuWtZ702eQZdFCcSKSw0NShAWxEnl87w=;
        b=G0fZ5M3akgdl+DVQOA7cf6HpEZILjVZkCIgavcFOZHjFXxmY19RmX1p6fgZWGATN+c
         4+fmwIZuVhJsak0/LwtafE5W3ocERs1J3IVD0PtVwbzuaFpp2aFdda1UZhOrckMvKPqo
         2YjQRqc4XDb6dpTU6BAGIMtrfeoy1i3HbUuuUQhJvH/D6f+JPi/yBUM4oGJAOhVuTkoJ
         ShFXuNpKZSEUX9e6Xbf4abS6ktplNicOKMJxpfZ6yLhJ0z85tkOe+54dXlDCF6wogsFS
         n0CpGnKanCqB5wlDzxiUMMnJ8q93/OW4yOpP0gX2iyQLDBusrTNo7Zv792aBZHtgchiM
         7CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719918522; x=1720523322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BetJ1UFbBIbWuWtZ702eQZdFCcSKSw0NShAWxEnl87w=;
        b=mXhtOmBVLycVQY3F0BGkPqOKSuxQhd84Jw91Ij20kPzJelrVBPYlfaJIiqGX3lQFEB
         7M7mUMGZQPofRzwpoH4lEgyBCS7DTvAEiPibr7drdi1AEejxCKzdJ1/jlDOlUyxzJPnf
         rzNkXgKhjW4Gev7nCWnpvh+kZS8ww31h0SFAbK3pdjBDMrbw7k9nwhD2T1sEYcJ2kOFV
         YC0OpzRO3XiwzKk6HfssB46T3QRymyBMOByMgCqTtFh1/8ZZj7Le6fJ+fV4vNSG+gzBO
         L/hFVZs1yfd0GRUbfMxkJZxz3bTCeYXyGFfnxNwu49kq/EYl30akj2QwizKp4n/EH6Ht
         y25Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtT5hrPksjuxBaUeI+V5i693+48kCVf2Ec/unMKGECo42IH1DninmEmFrri4p1n+J4xxK7jk2fmaH+bFURcaQFw6UGkxyPnl9IclsS
X-Gm-Message-State: AOJu0YzVVkNl9bQE/167JFNms8X0R33LUFAsnirvFTAiV2GKOjRk/qYO
	/LpEf4G7hGHp7q7nQRA6Or3UgWVXns8yPXikJh5qhi4YNg09KtshcxqZWG/pJrs=
X-Google-Smtp-Source: AGHT+IG9yoIyOpavgSvp8xHwWJUEv9GqMHuoWpEObJoubi3aQFctTwmkcSut9eRF8p0IN+IsXf9WjA==
X-Received: by 2002:a05:651c:198b:b0:2ec:5843:2fbd with SMTP id 38308e7fff4ca-2ee5e6cd69cmr61059341fa.41.1719918522391;
        Tue, 02 Jul 2024 04:08:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee55fa9c47sm14955721fa.15.2024.07.02.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:08:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:08:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: record reason for deferring probe
Message-ID: <ecomdlciigigng36ao6j4sj25dmbkoy6j5qun6nje3ok4rp6ld@n7cwb7v2ynbt>
References: <1719910870-25079-1-git-send-email-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719910870-25079-1-git-send-email-quic_zhenhuah@quicinc.com>

On Tue, Jul 02, 2024 at 05:01:10PM GMT, Zhenhua Huang wrote:
> To avoid deferring probe smmu driver silently, record reason for it.
> It can be checked through ../debugfs/devices_deferred as well:
> /sys/kernel/debug# cat devices_deferred
> 15000000.iommu  arm-smmu: qcom_scm not ready
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

