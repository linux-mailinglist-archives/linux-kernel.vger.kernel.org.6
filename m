Return-Path: <linux-kernel+bounces-289731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A4954B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9436A284AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEE81BA86D;
	Fri, 16 Aug 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lvYc/3sd"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220838F91
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815150; cv=none; b=buyRtmn9jiDXrn4twsXGKRf9bpHqR7Wdtsmc8AJkaBJ4TZEgTK+VXyRVt2iHupK+3jbJsCKxpud5awEp6ud85+GTvy58cKDCV2/LiTdXB180C5dCuKhJ6Ae2koYgmGtEGdmuoWcd6VdIYLM24fftGCKZaHuyrO2cb3XSbGWtkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815150; c=relaxed/simple;
	bh=x3S5s+Hej4DQldTEO6rhmuDuDxXeRxvdU3Zwg4JhmwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALVDKQS8AY/vpZ4K08/4rn/7c5D+LpSRhHD79KjsAclABODCy+hcSvCTfmx9Brsf9OTW2YwGFCViWH1uqEzvvit5hgkWNib5BCskamu22ebmccs+fswr8LDdUJLDU4GbvBSCjcTcKH74WfCFkklNFFQFR1qP8LrBz3H5GmXTeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lvYc/3sd; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so10099846d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723815147; x=1724419947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WLdyyDxuoCEu/ofqE3qKzxzdPAofyeH2iLCwX0g+TKk=;
        b=lvYc/3sdZ4z7nxMnlsTVHj8ur0pOGChOEpXDffjo0HnMy2gqAiQHRCcji4NUViOgKL
         NkYzjToJoZC1ICWC5PIVN+vTtQD+R0p+P8IZWSAoyK/eI8gXZlsM/C8bq4X1hU4FUax6
         KfG/rF+nYP15y9xP7chrAqPz0zyg73ICSENBiMynYE8QWXj6Dn45Z+dOaYY0FJy3svhH
         mqRvFTTUrH6gNrH3kZlQwBl+0Gi+tLjxsOhnes0a/Hc4TuKI65nQekn+vzEB/Bq4LQQa
         IUnrlqwDbHKH6edngYsoYo/++BKeEvfBHtEFGTbjgytYTQSRGJc8h8/sQovnpWw4JT04
         HlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815147; x=1724419947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLdyyDxuoCEu/ofqE3qKzxzdPAofyeH2iLCwX0g+TKk=;
        b=AdQXD9BUDDkxJDWSk1qVo8xAV2UudOHweokykXBworSsSrtXTXCThG+JsCCr58uja1
         I5FiTWOiUehh3TfYJXQ1ZrPATo06H9f3WQiRhHlnNprevKHF2tgCM0QKT4Kz+rX9A/3N
         x7E52e07Tl+ySdHb6BZ2+ySdnLWpdenNU2POBFLHFltdfz1P3qCJbpEApKHslmjHcz/7
         ZC1O+b+rWlYrZgAUxD4EANOcNyFsb+uQVdVuxEho1ptpDPIETc4aU8f2qIrWaP802T2t
         bmkExs6oBb0P+JmTg8+7ERdezffh1ntc4pea13eJXLPr5WvD9vZ2jcwFNHz6Hy1j5wx+
         GGYA==
X-Gm-Message-State: AOJu0YxI488bwxQAgss+5V5KnUoZUGQtLOTmm/RjC5TRuWJ5wYQR/Ijy
	32UnJCUrkjHni24esSRId9cVG5Ba9DMmz7cU0m2eM5/BKI6nPf1l41zK+2F75kM=
X-Google-Smtp-Source: AGHT+IFSYD7XIUdE2zz0q7OwzKKppto9XaQU9IEejkC+twRGET75J3c2JhhzjEgdxqdQt2xI7LB8Qg==
X-Received: by 2002:a05:6214:3f8a:b0:6bf:7aa3:92dd with SMTP id 6a1803df08f44-6bf7cd80e7cmr35004036d6.9.1723815146697;
        Fri, 16 Aug 2024 06:32:26 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0a5a6sm17351556d6.138.2024.08.16.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:32:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sex3H-009kK9-3S;
	Fri, 16 Aug 2024 10:31:35 -0300
Date: Fri, 16 Aug 2024 10:31:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240816133135.GP3468552@ziepe.ca>
References: <20240816125901.3773388-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816125901.3773388-1-smostafa@google.com>

On Fri, Aug 16, 2024 at 12:59:01PM +0000, Mostafa Saleh wrote:
> According to the spec (ARM IHI 0070 F.b), in
> "5.5 Fault configuration (A, R, S bits)":
>     A STE with stage 2 translation enabled and STE.S2S == 0 is
>     considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
> 
> Also described in the pseudocode “SteIllegal()”
>     if STE.Config == '11x' then
>         [..]
>         if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>             // stall_model forcing stall, but S2S == 0
>             return TRUE;
> 
> Which means, S2S must be set when stall model is
> "ARM_SMMU_FEAT_STALL_FORCE", but at the moment the driver ignores that.
> 
> Although, the driver can do the minimum and only set S2S for
> “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
> behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
> master has requested stalls.
> 
> Also, since S2 stalls are enabled now, report them to the IOMMU layer
> and for VFIO devices it will fail anyway as VFIO doesn’t register an
> iopf handler.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> 
> ---
> v3:
> - Set S2S for s2 and not s1 domain
> - Ignore ats check
> 
> v2:
> - Fix index of the STE
> - Fix conflict with ATS
> - Squash the 2 patches and drop enable_nesting
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

