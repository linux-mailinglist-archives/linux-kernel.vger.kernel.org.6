Return-Path: <linux-kernel+bounces-418939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1079D677F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 05:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604611615AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 04:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136E413AD33;
	Sat, 23 Nov 2024 04:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrW4vgGt"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532D374CC
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732335897; cv=none; b=avKgdpPN4Qp2JpkIpbeY8KlFl6ZgkgLMpbmqKGNK8hmmUW8Bjcd2XqbYgmR3lT68NxxY88iBvIBprYIsnu4PU2EWTn5/vDReILNBcPFf2A5OErymG/vHHygchFiajgLAivlpWrM/UcrfUxWaY3oUu5cL8Wbyz3gBkYPK1GPTfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732335897; c=relaxed/simple;
	bh=e9nHpwMBjaoFqUkoyryIoEFTX/TGNX1aD1pPnnHMG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHCoDyHzsbNmurcreCjjiyBIYsnvVXVJDxb7ooG4PlJ0cMECnXkRCYMd4UXF2yxacXM3cHwaiitQCJ4su6vqjIcZapwUVXuwWR1qJ9lv9QCKOXAuQXjOl+FSLlWBLm80Wk/jIbbMxu9+663V5tcnfzrFUC1Lsnn5uxO1WxrUhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrW4vgGt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffa678ddd2so15513801fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732335892; x=1732940692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRhFfCU54K+2vGl9KCGpU43DH6Z3TBwkPWpTyROlHtc=;
        b=VrW4vgGt8EcWtpjCu1+UxXXFKexHQOyVrdNF+hg54nx2PQ6rZXU+Zx7H7ctG7PgC41
         1SFptXCFFZ74ReB8AC7BqQdzQvczmcm7oPnueIFgel79R9pE9eG9DefaINNuy112zawz
         kzKHJzEVmx37nTtOYEv3niZfvHuZ9rAKMLtd4VERngKVpkBTuE4+4lmJ+GE6kFVUN/25
         WNGw26sAEFxct/5TqTQqzUVo2+T1lJ4GNlEG989d63egMYa0Ed+gg9vAVuaplWqnQz0B
         8Os7Vf/WfhaGA+X30W1zNgJj3E085s3gQ7t/zgQSPCsEyQCJzabr4p/T9Vur0NAXLUJQ
         dV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732335892; x=1732940692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRhFfCU54K+2vGl9KCGpU43DH6Z3TBwkPWpTyROlHtc=;
        b=YvRLTxVtQu0yJOsf9sYuLM58hAtLcMp60oyzoVde6y0Ka3c0tKw4/UyUNzdO/nBxwp
         psnAejC7dqjrt+vbCy4cCk2GsV9voCFLixRBCoBWf9xrWYFywxH14ekZIGY9qJ7ugyQi
         Yzq5RIntifwz/3FwJ9uLNH/Tfh27sSLwnz+vMrFCNIlY1+ylyehap1RNR8/1LKtYDp4c
         SZoA3Bh+69HCCUcEBoB3egX6xL4adxfDc1SkMJhbzyRH9VbSCvogABkyne00y8Op5bFJ
         LZnVPe9adRKWA/CscFcnkK4bwDL1aL2Vo2p735oZwTH0GldsIoFzz4H5XbSU/DT8/RrE
         I/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkZvLKplpi9QMhgjIMlM6LfLbbMeQaxMDw9LMl6aR1hhl5kkcR8SM5LRUcZyibaMtCgC3Q/ueWiLFMDZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jCxPgzlYVnq1ilgoPS7H2U+WDcI0u/bZkzQZMJ+bqycpcFjn
	prxQ5uHdmrxi5uRkrVlBEcYV7kEuTIom5qRblyXHXf/R/N3RQ5np99PSi/3GBnQ64HUrn9Kwqt6
	Y
X-Gm-Gg: ASbGnctCGb/WFCkFkvcXJqbIFm8pIk23nhCJ0SqrgiYouiRqaYgRsiewmBtFHaIn/5l
	gFvLhtO8syY1GVbg+d8WSwIat7xXD5WVDcfB5VfucVw3AmlLsB0LhZg8YI99ZJQQX0MHwSEGeBL
	y+m1bPhCe++oRgctdnQXN0/PHyv8BeQzLoOc/pyic4Ndo1vijG+UuhKRHWo325jlNCeabtKeo+m
	DgUzTD8+Xjuflo5N+wRnbFDe0819uRWAUwzh9WHarRWFZ9yDc3h8nkqD6HCPINqdPm4pnLIU+8k
	46o+TAMssiBdE/7qo05WRysCV+wn+w==
X-Google-Smtp-Source: AGHT+IFdByuwlVrForEzT8tv23srj0gnAIFOKpmn1yRMnyw6GbJuVEjWF46wgEUprlaX5HOFYnyPnA==
X-Received: by 2002:a05:651c:1594:b0:2fb:cc0:2a05 with SMTP id 38308e7fff4ca-2ffa71c4f76mr33073991fa.37.1732335892280;
        Fri, 22 Nov 2024 20:24:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa5375d8esm6320591fa.89.2024.11.22.20.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 20:24:51 -0800 (PST)
Date: Sat, 23 Nov 2024 06:24:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v17 4/5] iommu/arm-smmu: introduction of ACTLR for
 custom prefetcher settings
Message-ID: <w3rqdjygedgwsacn4ybajvv3fwuhhaaazo5x7zqcip7xdtf4lo@shwsl5acgqzk>
References: <20241114160721.1527934-1-quic_bibekkum@quicinc.com>
 <20241114160721.1527934-5-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114160721.1527934-5-quic_bibekkum@quicinc.com>

On Thu, Nov 14, 2024 at 09:37:20PM +0530, Bibek Kumar Patro wrote:
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
> 
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  1 +
>  2 files changed, 34 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

