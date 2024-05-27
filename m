Return-Path: <linux-kernel+bounces-191002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A68118D055F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB0E28B38E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7215A850;
	Mon, 27 May 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qHp2r6Ho"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19631E868
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821218; cv=none; b=ap0WiVttBjELafRa9tZ9FJqYXwZBX3RHm2A/aP3IV4VWfqN0RM6gFrd31h094gMud4ABWlYcooOhFF6SyhOHM1lKYn1LIRPxC1+q8fBc8gTGzwfuKnx71fuN1OmWfe+KTEP9b6MKW6kmHX2/jnzQlJrdDo48NHu0U4Gu8z38jL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821218; c=relaxed/simple;
	bh=zOYVkMsdtp+zS3EUg+6gsrxKnioUEibTbhjO+oHqH/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZJKmbq0AHS7tECto1ijNf+o8q+k7qYt48/OuCNcpEf1+kVQBZeSuhCQEAjqdqSErX1+t7YmLLpO1zduhUaV4xBsWuKloSsPvaHzGRw86LVfkGVb+kgT480i1Dibsl6T2bMiv8zmvJbgWY0dwPchiS3ABIhCtJyyKz3MNP3rcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qHp2r6Ho; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RCCRba016126;
	Mon, 27 May 2024 16:46:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=fXCtRhH83xnfqbBLNhAJ8sKR
	tFU5uQsKid0FBSkW6bs=; b=qHp2r6HoYz2xN79OIbCp0wrfRCCHfryXa305Osor
	BCl75YgcG/4rCJbjI31W7zHZJA1Hsyfjk0P9x2pYGrCooFuliC/LvVDOWzyTxWX5
	hzenhBEUBAS+2KxzhPXmEC4BS1gYvRQuZrTM1VFj0l7a5vk4/DtSfHYIcMqvcgit
	RTcvrWdaNoYbm75VqoiDYoEVBWd93rQU+1AuZQeNbY/f8MMGC4/mo++Up1Tmpwhg
	2KZAgrewlPMbjTPiEjggv0mFA61gxJGnAFT2mLfBJpiffpAqUPKyNpBxlkiWC88k
	H+BnFkxy6p8ftG7Netz7AXqm5cWu8Gl+ujqk4zFbo3aK5A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yb9yj7t6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 16:46:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5598E4002D;
	Mon, 27 May 2024 16:46:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 907A322366D;
	Mon, 27 May 2024 16:46:07 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 16:46:07 +0200
Date: Mon, 27 May 2024 16:46:02 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/sti: tvout: drop driver owner assignment
Message-ID: <20240527144543.GA713992@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330203831.87003-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240330203831.87003-3-krzysztof.kozlowski@linaro.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-24_01,2024-05-17_01

Hi Krzysztof,

thanks for your patch, sorry for the delay.

On Sat, Mar 30, 2024 at 09:38:30PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/sti/sti_tvout.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
> index 64615638b79a..e714c232026c 100644
> --- a/drivers/gpu/drm/sti/sti_tvout.c
> +++ b/drivers/gpu/drm/sti/sti_tvout.c
> @@ -886,7 +886,6 @@ MODULE_DEVICE_TABLE(of, tvout_of_match);
>  struct platform_driver sti_tvout_driver = {
>  	.driver = {
>  		.name = "sti-tvout",
> -		.owner = THIS_MODULE,
>  		.of_match_table = tvout_of_match,
>  	},
>  	.probe = sti_tvout_probe,
> -- 
> 2.34.1
> 
Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Alain

