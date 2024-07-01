Return-Path: <linux-kernel+bounces-236838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A691E7AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28EF2B239BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3716F27A;
	Mon,  1 Jul 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Arg4wOvc"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8616F282
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858854; cv=none; b=SpDUlYfAAMWnRemoVEBoMvfRr2rH7cbdNhvzayXCCL4YhQym6eWUoJqNEgvq3exJ3c7hPjLIvOczJDEu6j3kCgeJcZxgITkS/iwicN73pCw4NSykD6nIu9m8rJ96Dpf4dYPDBRfWALnejT/H8aDWEhYi1sYvNVaeTXcRWU0Tj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858854; c=relaxed/simple;
	bh=AlleWO7seezdRQOko8HA4kvBQETQ1mo34KZ8VJew1fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJs0qqaO1sKUwIz/rk9qISrOvRzBC7TUv2gME9nC5aU2qic6b1YXdFBMeipajFZOWFGwl6XWNb9OcK/M0bCq7qJoDt7ATztZ9AqZSK+X1kx5JUyckx5gQVVBK38nKIzpBEBRGHE3a8XkvtCzzKZDoDLWkMerAML6f5CpECrS6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Arg4wOvc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e743307a2so3809479e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719858851; x=1720463651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlMQ98Rr8Ts5zoOoR0fpYPnoRARBs+uq2fu6Ocdpreg=;
        b=Arg4wOvcWE8W8yApgZ0wQMHK7a6SpPdMOyMK6XEOabIRe2d9uI5VQ1IHn+4tDUylkj
         9iV2Wwk1NsEKC05Zqbwh63xgZChHtLyYqOCAgxABq0CcUCprPVCxk4NVI2CUHy/cCNBE
         SrhFlfISi03fECa+OBWznrfHiuyP/Kp1oAL4JRi9+mLmKzgCMw6rQgLnJiGCUDfO6eC9
         dQJtXFd9lYCiOki7q/cal1OPLVjsebYG0UlLROZklymG0VhcyjTyoYfzQ1h3r/qhztNE
         /WfZx8kHj155n4S903LmCcTNZBkmAWk17UlK6Ixh1AQPJjaCfKOelx3ztiukZ/f4oxzx
         CpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858851; x=1720463651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlMQ98Rr8Ts5zoOoR0fpYPnoRARBs+uq2fu6Ocdpreg=;
        b=Lh5UrDo9ZoNu5HTNKfMuK3VEH+0sfrK2SkPaKame4FJ/0zUe+mV8KzNnPuTwjn8LKx
         eS6FqqjEWRU1a+SrxlzEu6hRLtYzVFV7iqSXJ/gwI0Iu5aysIUXD7DXAQL5hK8VWBDvH
         PUrpeJfvKGcJjf4jdgWgFh2aSZhmIkiBr9jpXD7f+pLgK/jdMYzgOhIdV4167AOHk4g7
         XmQOABn1IKuNuwDVpvV3cN66gmjID3OTsuNkfjb5wRelkjkwAgUg30uFnV4Kxjtu9Bin
         1TkW/miBGUP1M/xn//pE8qEzk0MjRyOcUwIPq6ckqYKK4aI72iNI68TcgkiDlgk8PJhz
         ebOA==
X-Forwarded-Encrypted: i=1; AJvYcCURcMwxy53kYu17d46YUMhGBVi2iUDdyP8yVH74Ek2Ni24L9LdbKIoTYnd1SrAEM+k5joPlWVOnn53i2y/E3OTfl5M1qjoWNupopmQu
X-Gm-Message-State: AOJu0YxxSoH58SgsqeCiOan4KA/iZkPnRQ/waAoeu3ZSy1xcBlRlI/R8
	UHUnkKNBtnNaEUnyiI+Q1305RzXyBlnts3+9tDS9guRzgqTORQJryJt+q/YlT+U=
X-Google-Smtp-Source: AGHT+IF85zrSDvg5F1wY2TkxPxIK+nbL8qBZtByDVmsAVS6fcE3x5dghVoObnWk5Od3sYp3KGPLBAQ==
X-Received: by 2002:a05:6512:3d86:b0:52c:e086:7953 with SMTP id 2adb3069b0e04-52e8264df6amr5042600e87.4.1719858849378;
        Mon, 01 Jul 2024 11:34:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2eae5sm1526774e87.212.2024.07.01.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:34:08 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:34:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, konrad.dybcio@linaro.org, 
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 4/6] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Message-ID: <ueuhu5xfzp2rnuxzeqqd6cho476adidztgx7oq2tbiufauv6h4@obblpxvqwnno>
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-5-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628140435.1652374-5-quic_bibekkum@quicinc.com>

On Fri, Jun 28, 2024 at 07:34:33PM GMT, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 77c9abffe07d..b4521471ffe9 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -23,6 +23,85 @@
> 
>  #define CPRE			(1 << 1)
>  #define CMTLB			(1 << 0)
> +#define PREFETCH_SHIFT		8
> +#define PREFETCH_DEFAULT	0
> +#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
> +#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
> +#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
> +
> +static const struct actlr_config sm8550_apps_actlr_cfg[] = {
> +	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },

- Please keep the list sorted
- Please comment, which devices use these settings.

> +	{ 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c07, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c08, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c09, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c0c, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c0d, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c0e, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c0f, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1961, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1962, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1963, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1964, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1965, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1966, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1967, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1968, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1969, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x196c, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x196d, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x196e, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x196f, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c1, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c2, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c3, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c4, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c5, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c6, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c7, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c8, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19c9, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19cc, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19cd, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19ce, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x19cf, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x1c00, 0x0002, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x1c01, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x1920, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x1923, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x1924, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x1940, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x1941, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x1943, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x1944, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +};
> +
> +static const struct actlr_config sm8550_gfx_actlr_cfg[] = {
> +	{ 0x0000, 0x03ff, PREFETCH_DEEP | CPRE | CMTLB },
> +};
> +
> +static const struct actlr_variant sm8550_actlr[] = {
> +	{
> +		.io_start = 0x15000000,
> +		.actlrcfg = sm8550_apps_actlr_cfg,
> +		.num_actlrcfg = ARRAY_SIZE(sm8550_apps_actlr_cfg)
> +	}, {
> +		.io_start = 0x03da0000,
> +		.actlrcfg = sm8550_gfx_actlr_cfg,
> +		.num_actlrcfg = ARRAY_SIZE(sm8550_gfx_actlr_cfg)
> +	},
> +};
> 
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
> @@ -606,6 +685,15 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
>  	/* Also no debug configuration. */
>  };
> 
> +
> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
> +	.impl = &qcom_smmu_500_impl,
> +	.adreno_impl = &qcom_adreno_smmu_500_impl,
> +	.cfg = &qcom_smmu_impl0_cfg,
> +	.actlrvar = sm8550_actlr,
> +	.num_smmu = ARRAY_SIZE(sm8550_actlr),
> +};
> +
>  static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>  	.impl = &qcom_smmu_500_impl,
>  	.adreno_impl = &qcom_adreno_smmu_500_impl,
> @@ -640,6 +728,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
> +	{ .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
>  	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ }
>  };
> --
> 2.34.1
> 

-- 
With best wishes
Dmitry

