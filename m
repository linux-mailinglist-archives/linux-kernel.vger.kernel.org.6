Return-Path: <linux-kernel+bounces-191006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3818D0566
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C1C28C9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282AF167275;
	Mon, 27 May 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OzmpSxYr"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E21E4AE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821310; cv=none; b=mCWOtKBvZg1gEtUyKw2M05gfTdwCnsgBdizbNu0XbWBwmvp8gr2iJMcFDZyV5Q6i5Is4xUBpDaN6wVO3i+mj3vH1SFzRnfuu95MOWFsheaoxaLcf9m2QXebpAGhdNn8XdW9XbZ2uMMsUCJ8bAGmkZU6vWc17spiIfa51iEIXFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821310; c=relaxed/simple;
	bh=uj43s2e84B4Rcv5RpTl0jnL36Z8SyJB0IzOcAUJN2bI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCpmqeUgsM/tqs/ySoHQhntkZSljqLbrrqbyTDAQIBVieMy02AmsHhBqENE9gdX6Ctmq5OqsyHEw9qQERzLA3wS6Cg9/Yn8SXLoicuz9xfMX6eHI+Q+DOEMHw7AZ53i8ok81PoN2hMediVpKgLpmPwJXHCOlCAqwS61ZphkFUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OzmpSxYr; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RDG0i5001861;
	Mon, 27 May 2024 16:48:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=rL2QO5fqYq8aWV0+X6jIyD/0
	k7VSEFkrOE4rijDK4CA=; b=OzmpSxYrcWTxfNjZrYt9Gv0IfFFekU+WpP1fpO05
	JCtgZSsKQ/8EoMudgOeWme/ThFyuOMarNGx7hsRYxxZ0eCigEzCnBu+SRARhiCHW
	VtuUUmQ0h3DJ0t1J9VVsHjK2hXIIt4FumSsNynyWqWcoMVz1sDJvxM3bVlAa0h98
	TIDS/1w8ixIEqXp23nXoc5cJqg7qP2jlwZ6O6s/vnJlK9P0vnO8YcSAlH6ta1s1d
	rVZavJKLYP/IXS63IZKuIkhLiXZppwK1IqNPuvS30eutapHF1TecyRuC0jM/fuxt
	3jdkVvlxCc3EMEDYLRS1co0nIabFf/9UdWcbwZdzAjI45A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yba51qe63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 16:48:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 18F1D40048;
	Mon, 27 May 2024 16:48:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AD9B223F0A;
	Mon, 27 May 2024 16:47:26 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 16:47:26 +0200
Date: Mon, 27 May 2024 16:47:24 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] drm/sti: hqvdp: drop driver owner assignment
Message-ID: <20240527144724.GD713992@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240330205722.93801-2-krzysztof.kozlowski@linaro.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-24_01,2024-05-17_01

Hi Krzysztof,

thanks for your patch, sorry for the delay.

On Sat, Mar 30, 2024 at 09:57:22PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/sti/sti_hqvdp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
> index 0fb48ac044d8..acbf70b95aeb 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -1414,7 +1414,6 @@ MODULE_DEVICE_TABLE(of, hqvdp_of_match);
>  struct platform_driver sti_hqvdp_driver = {
>  	.driver = {
>  		.name = "sti-hqvdp",
> -		.owner = THIS_MODULE,
>  		.of_match_table = hqvdp_of_match,
>  	},
>  	.probe = sti_hqvdp_probe,
> -- 
> 2.34.1
> 
Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Alain

