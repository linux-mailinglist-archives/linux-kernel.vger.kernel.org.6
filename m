Return-Path: <linux-kernel+bounces-191003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7168D0560
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F2828B602
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B6F15A876;
	Mon, 27 May 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WhIGIRCw"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667F15A871
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821261; cv=none; b=iA/yRKtV6D8AeVHl9Rx8IgPfMji2uj86ptj8PZ7f75qfEdP0o2llx1nnzf38novoQRAcRH2hYpUw389vqhuwV4yGVwe9caNYSL3dciGct6zKYt/JcZiZlSkG796ONJHShKGcLBvH2rw7Jo+3fkClr17UlyIYWegV1euKQDPbphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821261; c=relaxed/simple;
	bh=HACKvre1pIBs/aWZ5jYK05lsHFuo10a3g/JGol4WVjc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO0xJRt0EdVSmAgpySQcVIEk2czWyq7yqU2la3E8wutlEAPsj9rOFrh7zgKaBLqjLrwz49emTjGGOkVBW2CnALUU39WhK1qRKaKRpclg/ij91tHCQstxDRjg/XGzxlQgtTYYcgsfWuBagLHVRQp3gbUkr6RNGTdRJTAU53gey0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WhIGIRCw; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RCer6v013257;
	Mon, 27 May 2024 16:47:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=dfWYNyl5RflnX4ioZEA/J3kX
	5e0K+XhMtPdUDFcZJkY=; b=WhIGIRCwV27Oglb8hnUrqSj9fMEsgejqRRS0CAT9
	JL5s+AUrFAAUM4zcoy7P1XOQdg2/RuvcZAX1b8AOUwzeaq4ymDei0x0w4HjDrJDj
	nnG1CEV+CC01dhj8Y9E5v3nDKqnSYb3KpnejPs5Uy4Y7Z0Cu6zn7si1SUqNUWDUw
	rsRqBE5iAVFRbK37Im+3e7mN7CHUuAipNSDvHopTsg+svLvo+GLcqXDQHx+39f1f
	87vsvu5DTq/172bzezP0y0KxrknATQLe6ilm/kVb+6CWjBjfPtLl3gVddLxiXlEt
	oQHmUn6GyPAXrCxrpW3t7HbrD28tCpCPTniv7Ts/seHbPg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yb9yxyq2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 16:47:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EF0DF4002D;
	Mon, 27 May 2024 16:47:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36D61223668;
	Mon, 27 May 2024 16:46:34 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 16:46:33 +0200
Date: Mon, 27 May 2024 16:46:32 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/sti: vtg: drop driver owner assignment
Message-ID: <20240527144632.GB713992@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330203831.87003-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240330203831.87003-4-krzysztof.kozlowski@linaro.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-24_01,2024-05-17_01

Hi Krzysztof,

thanks for your patch, sorry for the delay.

On Sat, Mar 30, 2024 at 09:38:31PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/sti/sti_vtg.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
> index 5e5f82b6a5d9..5ba469b711b5 100644
> --- a/drivers/gpu/drm/sti/sti_vtg.c
> +++ b/drivers/gpu/drm/sti/sti_vtg.c
> @@ -431,7 +431,6 @@ MODULE_DEVICE_TABLE(of, vtg_of_match);
>  struct platform_driver sti_vtg_driver = {
>  	.driver = {
>  		.name = "sti-vtg",
> -		.owner = THIS_MODULE,
>  		.of_match_table = vtg_of_match,
>  	},
>  	.probe	= vtg_probe,
> -- 
> 2.34.1
> 
Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Alain

