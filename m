Return-Path: <linux-kernel+bounces-190991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BD28D061C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FDFB35539
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521616DEB9;
	Mon, 27 May 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6oT8Cc81"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED315EFA5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820975; cv=none; b=XjSzablxiKdQB5Xy1C0jVqfVYOMo9Aey61cGwd22g/xQZeAfc0LJ2ScxWHO5ckLlaBf4+78bDxAxtAHqIno15x2ZYxg9/BZ1IBgRcLfarf1Yg4NjVRDYUXC7nhn0aykM4zt6chWhrvvDSZWDJT5k3kx1wKHKqHhiS+r7vxmUUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820975; c=relaxed/simple;
	bh=LbBODEt43jl9xDIy4+WcpRz+32AchPP5nB4P0n3pEnQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqmlt4Ny1mdeP4ApLl7Y+jq13R99FxXKL+bstdLF4jUTXjUrkJVEKaBDeLlW1p1QyMU7T4SLJRS9oxEyglA+ptyEG1kobNqnU7l8LfkvyWALkBmLMZs8YQcQAol35DJzuUKaAIZsWAyHbhf7KyI4Y2dImNAy7kMfRdwwdL5XO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6oT8Cc81; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RD73Lv003651;
	Mon, 27 May 2024 16:42:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=JKE5ZdTw/r7O4+6MCS099EC5
	8FAD4/vQV+rJWeHAHN4=; b=6oT8Cc81gP8XxsU9I3WLsgKN+udTSjqzpDy51gVZ
	4z7OJ7WYgUr/mUpoSt5JvZUpUAdXzWBctsSFY1jqeMiPRUp6JIiBufxXQVfwGJ6A
	vSDQDt+1mjTtObFQK50m1dJlVmR7niDXoL/ZYVy1aht25Vt07baGGTZYkL1FSgWk
	u8qrri6LP6QsMrbTvr6N18EvMHWMoY+JMIYYdgMN4GbfvIoWwKuqzwaWCh11M6K4
	/YzF1o6kTXFazZyc3Mu/mRlflMdev5Gr3+gdKh0TKbKriYfNCWPXWWnlNM3mJiym
	d/RoLicHLZ4tqhmWNpI6MOiuT+D08fXK54YiQ46gWO+L/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yb9yj7st8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 16:42:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A6F1540044;
	Mon, 27 May 2024 16:42:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B33222365D;
	Mon, 27 May 2024 16:41:59 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 16:41:58 +0200
Date: Mon, 27 May 2024 16:41:57 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/sti: hda: drop driver owner assignment
Message-ID: <20240527144157.GB585402@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330203831.87003-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240330203831.87003-2-krzysztof.kozlowski@linaro.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-24_01,2024-05-17_01

Hi Krzysztof,

thanks for your patch, sorry for the delay.

On Sat, Mar 30, 2024 at 09:38:29PM +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/sti/sti_hda.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> index 6ee35612a14e..f18faad974aa 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -807,7 +807,6 @@ MODULE_DEVICE_TABLE(of, hda_of_match);
>  struct platform_driver sti_hda_driver = {
>  	.driver = {
>  		.name = "sti-hda",
> -		.owner = THIS_MODULE,
>  		.of_match_table = hda_of_match,
>  	},
>  	.probe = sti_hda_probe,
> -- 
> 2.34.1
> 

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Alain

