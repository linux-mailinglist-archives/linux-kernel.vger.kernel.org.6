Return-Path: <linux-kernel+bounces-190990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A318D053C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BF52881AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E23115F41D;
	Mon, 27 May 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="K8yz68cz"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934017E911
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820912; cv=none; b=WR8miKEyx5GWalVnpU/LuBj7r6OPZRVwG7+kh1hnLsF8VMR9lmQ2qmiwgCQ4d3YOvVkpZbjRU1dyVhnb6gy+D7IR6ct+cGxMtucxYDagUu34VkwJ3aCCmwPXYgr/o+Yi4yA7SvMx7q7Ym4Tzqvu5WcqHT7ZeUrMbd1mfquYwdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820912; c=relaxed/simple;
	bh=y52Pyuy2axPlLPm9JRttUU/uPGXkKb/tddqD07fLB4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rItTZmXFKUo524T4XW7x2UG10h3pdr7F2Wk2L321krva7/6Lg51ezWMrQH1Bz+9tCpBfleDZZXUUu1yO1Rgiorcs4XSbOVABt0nhOG+zORR39gQxeRsRTHOXRI7FkH9J0yPbzdSsOxAvndzwTWs0sW3yN32593U5/KvoXVqtHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=K8yz68cz; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RASHJb018304;
	Mon, 27 May 2024 16:41:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=GtOJliylw3esNK5w3idFfAAg
	TFca1UIiVljMLLSaS9I=; b=K8yz68czoHk6FeHiy/sxHjxyo5lgQo+tNV+hOkOA
	PhLzirDPrGVOgsJHMHxyACP+2rfKYtnHIPTwMdHJ61RgF1XGaDhQpypfujjTUyC6
	Q2dZgxQSoXCxZCBkFeAxGuZ9qXGTO3ET4gvK2G8XmrvYTkr6MaFdynSLUl2cTAII
	plhi42v2s9AvqAIpCc5lSRpDnyDoSq5zEzDRQZwE0NIwiL55BHNIn28C8mh563bf
	saB976hb1E4s8H2dZliCLSfWw/EjtVSejiAYIV8aYOcEkdOsJQ9LpXn4D4l0yqok
	C30Cu7DW8zBhprvbVi9S869+F/rjfIb01bG2/H7A810GHw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ybtxh59y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 16:41:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4ABA440045;
	Mon, 27 May 2024 16:41:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AD53022365F;
	Mon, 27 May 2024 16:40:51 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 16:40:51 +0200
Date: Mon, 27 May 2024 16:40:43 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/sti: dvo: drop driver owner assignment
Message-ID: <20240527144043.GA585402@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-24_01,2024-05-17_01

Hi Krzysztof,

sorry for the delay.

On Sat, Mar 30, 2024 at 09:38:28PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/sti/sti_dvo.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> index fd1df4ce3852..00502889c7f4 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> @@ -581,7 +581,6 @@ MODULE_DEVICE_TABLE(of, dvo_of_match);
>  struct platform_driver sti_dvo_driver = {
>  	.driver = {
>  		.name = "sti-dvo",
> -		.owner = THIS_MODULE,
>  		.of_match_table = dvo_of_match,
>  	},
>  	.probe = sti_dvo_probe,
> -- 
> 2.34.1
> 

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Alain


