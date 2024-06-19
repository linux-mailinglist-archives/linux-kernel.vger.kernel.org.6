Return-Path: <linux-kernel+bounces-220797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242E90E73A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5B3B2135F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CEC80C13;
	Wed, 19 Jun 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gBmti9bE"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77757E0E8;
	Wed, 19 Jun 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790298; cv=none; b=RxhDoOl+BeZ371soYLY7wl2hmc+wUbIAJfCTOQ/4n3EQgpf8Qn+gb0fYoVfLPqZmjm7ap32ZSWqzK8SezYXLtaOG4VCbrS9FYrppnLwi5QCYYSVvWhmoPslyqbjgfR6PxpC79opCMnQLJhw0uYYYrGJOved5lEwPrR4BfRgjKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790298; c=relaxed/simple;
	bh=8qnvawOIxf4Du3tOQGAjAvXzq4tbas8FMaYY0qf1JOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M5bTu42z343cCGafgvEOVVu1J0LuVom/FW5k1y8JBR8ZuMO2EOuoE6cSXS9W3t9UZ8bjr5ewSqfphLHE0Pv/j1qaxMDFfJFFez1QMZw0o4QlpvGh0BT7vjkdEQqnW7y0p3ARIVY75AcPSXzFI/FacamhaL1EPZf5QyyEWdgB4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gBmti9bE; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J6sYf7029887;
	Wed, 19 Jun 2024 04:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=vR82SfQk2QLaKL6yomuL0hZ8ERucSrJ1SZnbJDBbC78=; b=
	gBmti9bEM4S0UfCvRilWxIiDADWKg1qVakOTdHQW4/Na4yNhTiKgasm8x0Ul0ocs
	tnL+CJ7jw2NeeugYH4xwTnEKSHaJKbjN3m9BmpL1PmPnVmba8TQWwM7eTFUYYYWp
	geTx5/UI99ZwWa3J0EKBqe8eCgZdqF3hqXfuiovXXqhfSlJC0ZEhVu/xWWbk13gi
	5XbATysX4dE4LujTvMKa6i7SfkANImkXn33ZEQLU2Pi2k4EG/fvRPA+Onheozh/t
	x6b3909LIpGqEXqr+mLsX1cCNWDVUd8clrFrwsYmaNRbjCqD/EfuW/+jAt60QzaC
	iKNDveOhZ8HBPEC4+zWFRQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yuj8m0f21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:44:49 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 10:44:47 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 10:44:47 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 63807820248;
	Wed, 19 Jun 2024 09:44:47 +0000 (UTC)
Message-ID: <fe9dd613-8909-4c7d-a7d7-9094b75fe8fb@opensource.cirrus.com>
Date: Wed, 19 Jun 2024 10:44:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
To: Simon Trimmer <simont@opensource.cirrus.com>, <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20240617135338.82006-1-simont@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MFDlYEKTMAYpEuUNyXh1jdRo7OAMWHpm
X-Proofpoint-ORIG-GUID: MFDlYEKTMAYpEuUNyXh1jdRo7OAMWHpm
X-Proofpoint-Spam-Reason: safe

On 17/06/2024 14:53, Simon Trimmer wrote:
> IRQ lookup functions such as those in ACPI can return error values when
> an IRQ is not defined. The i2c core driver converts the error codes to a
> value of 0 and the SPI bus driver passes them unaltered to client device
> drivers.
> 
> The cs35l56 driver should only accept positive non-zero values as IRQ
> numbers.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
> ---
>   sound/soc/codecs/cs35l56-shared.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
> index 27869e14e9c8..880228f89baf 100644
> --- a/sound/soc/codecs/cs35l56-shared.c
> +++ b/sound/soc/codecs/cs35l56-shared.c
> @@ -397,7 +397,7 @@ int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq)
>   {
>   	int ret;
>   
> -	if (!irq)
> +	if (irq < 1)
>   		return 0;
>   
>   	ret = devm_request_threaded_irq(cs35l56_base->dev, irq, NULL, cs35l56_irq,

Mark, I don't understand what your objection is.
What is it you want us to do to get this bugfix accepted?

