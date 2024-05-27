Return-Path: <linux-kernel+bounces-191007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521F8D0568
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F211F24D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFCA167293;
	Mon, 27 May 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nr8xZTp7"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3F16727F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821323; cv=none; b=jgW6LosBkUbqp8ncxyI20E58D+H4jbu5CaTxsTBRBJIMNL1L9eCgWFtGWIQ8gIWTtFzEoyLAJkTdXfkZO6ogoE4+OgJPsj12gW480P2O21sRR6v5L6Zh625Zwg+gwSn+EjZY6zMonA3oDtqIehjTRmVhJcnFSGECq+pQioyM/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821323; c=relaxed/simple;
	bh=QNYiKgvCSMq+Rl+3GSzWqloKjhRNQ9jD/iiF2mDtsdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1epXmdF5jhdEXiYPEFlMuuos96zK3Hvq2SDyTj/MM1abuDN9UbfNMQQFm62stON5fiQUr8MLmjBMo8Dec6fpEXJae+NAF6Vxm1kGoCBcXUwniWVHiGfHAoWo4QGltRZupBZe0dOZ0wIXYxH2uNuCSPz72fTuYaymGy68oAQ+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nr8xZTp7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RDGF0l030751;
	Mon, 27 May 2024 16:48:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=N7jsceVysf9e5IrQ+DFE05f4
	RgvwzapkqLDkcxHCMpo=; b=nr8xZTp73MEPJwRkOdcfvLWzaYzIMfNdnUf+S/WY
	AE4gZLYU38qMG4Va7fVZ8Whic8bCLfeq132VR2MjEc3hOrIG1/w77V0uXx8dBK9Q
	59jFtxRFCPz0QvN4oc0ppJxZg0dBGVz5PxT8nc/0bshBbiG2lhVMpJX4rnUgBzqe
	BH6mx+b+9FwEMC3qYUaF29oEES/lwAazEb3mXiKvY5ygIytgyM2vRIOcsgvyDn++
	6X28Nh/m//AU0QdODPZ0aKI4KttsbelDKrH6nUTnRZqo16B5mcpVRl1Yr66zkxCA
	9G69HZ2XSDdbPuCeiGwhdyJfTF52gBWxUzs3aV6m6tikPg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yb9yxyq3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 16:48:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6CB6040044;
	Mon, 27 May 2024 16:47:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EC3A2207AE;
	Mon, 27 May 2024 16:47:02 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 16:47:01 +0200
Date: Mon, 27 May 2024 16:47:00 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] drm/sti: hdmi: drop driver owner assignment
Message-ID: <20240527144700.GC713992@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-24_01,2024-05-17_01

Hi Krzysztof,

thanks for your patch, sorry for the delay.

On Sat, Mar 30, 2024 at 09:57:21PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> I forgot two drivers.
>  drivers/gpu/drm/sti/sti_hdmi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> index 500936d5743c..b0d84440a87b 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -1485,7 +1485,6 @@ static void sti_hdmi_remove(struct platform_device *pdev)
>  struct platform_driver sti_hdmi_driver = {
>  	.driver = {
>  		.name = "sti-hdmi",
> -		.owner = THIS_MODULE,
>  		.of_match_table = hdmi_of_match,
>  	},
>  	.probe = sti_hdmi_probe,
> -- 
> 2.34.1
> 

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Alain

