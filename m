Return-Path: <linux-kernel+bounces-227385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2AF915060
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC36428464A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D719B3C3;
	Mon, 24 Jun 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qslt2FLe"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F319AD45
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240235; cv=none; b=quLkNkIyBHlGyWBxFb+dLSxBfscgA/rDhHoz7tDx5Ik8LHsw3IF5jhBRUzgMB2cNBPTuKvjOux3IicuSc6KqlOTEU8th4ckz44GJNdcJ3L1ChRO4K5jsQ+hQ41hZ2p1NDLL0luo70kJULPUZFjvw9FZEbXkeYLO3Yr7+ZXSqZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240235; c=relaxed/simple;
	bh=UDpU+sZqeqvUZpvFhIKYvpxfwqDGEwHLn0kUG34kq84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=czvyjQCHxHdxU6NJT2cRtevo1bvhf8a7oFA7vHbEw6zpJwpHUkm0JxFd3CNTosdBVe8eWtpRyEl4RUchGSEyXgGAX06Vmm0pzjs+KGb59q1ZFIdgTPicCyP4fRo5IlhhVInrU4DmMKy5hDM7nrUhdtvaOWiC1Qa6JuwvgFr8RrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qslt2FLe; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODT690017080;
	Mon, 24 Jun 2024 16:43:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	FDQqDeGBhOzd+z+gYx2dRkj2fnt78H+rCdF+VFiaJcc=; b=qslt2FLeTkNuSTgG
	FWEK3BzU3lE/f9wYZiDR+qbKV48FdFR6ubicgIUDwYKjV9LxAsP51JAPdGKXHkcU
	W2hi8YgILi5iJTAhqrOuoU7hZ+Wps2HdRXJYQt3CwvPMXBCNE8VcF3mhGSGZolOL
	mGi49Rbw1gNwC5KvDUCndpp93daBoJWZnM0e0M1BsqI/HZjDvjS6MmanVivr3w7k
	tUwO1cL3iz9nc4zvixbC9hKng7AYlQEmxuEN2ArP089/3TwA1ZAq7ej0qoExVmV8
	pmdi8uCSPTra5gbpjAwXli3yOYrd3PF+2oWCFU0J8ps9hXk02+RqmQM/Tnz9K8hB
	dCdAFg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywnxx7jux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 16:43:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1FF3C40047;
	Mon, 24 Jun 2024 16:42:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 280FB221E8B;
	Mon, 24 Jun 2024 16:42:07 +0200 (CEST)
Received: from [10.48.87.177] (10.48.87.177) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 24 Jun
 2024 16:42:06 +0200
Message-ID: <c8b7d693-5008-49c4-883a-66e2f9a3c7b2@foss.st.com>
Date: Mon, 24 Jun 2024 16:42:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: ltdc: Remove unused function plane_to_ltdc
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC: <raphael.gallais-pou@foss.st.com>, <philippe.cornu@foss.st.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Abaci
 Robot <abaci@linux.alibaba.com>
References: <20240624024113.54850-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20240624024113.54850-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01

Hi Jiapeng,

Thanks for the patch.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>

Best regards


Le 24/06/2024 à 04:41, Jiapeng Chong a écrit :
> The function are defined in the ltdc.c file, but not called
> anywhere, so delete the unused function.
>
> drivers/gpu/drm/stm/ltdc.c:494:35: warning: unused function 'encoder_to_ltdc'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9403
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 5576fdae4962..3f280155e25c 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -491,11 +491,6 @@ static inline struct ltdc_device *plane_to_ltdc(struct drm_plane *plane)
>   	return (struct ltdc_device *)plane->dev->dev_private;
>   }
>   
> -static inline struct ltdc_device *encoder_to_ltdc(struct drm_encoder *enc)
> -{
> -	return (struct ltdc_device *)enc->dev->dev_private;
> -}
> -
>   static inline enum ltdc_pix_fmt to_ltdc_pixelformat(u32 drm_fmt)
>   {
>   	enum ltdc_pix_fmt pf;

