Return-Path: <linux-kernel+bounces-212891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E23A9067DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334541F21A69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACCE13F45E;
	Thu, 13 Jun 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ndQ8oFuS"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784613E036
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268903; cv=none; b=mKWQpcm6ycj+E+xdRYfahhTp0ytSAjbAufwNYvSKmOdJDV9Wx0CvIoBIMMtEl/YNQrwR0XLZzm7dgKHBz/3ayfEPvdbuFP3LExrDCfC3+InzD/ixhnHuf81g2Nhj2+1mjGBw7kxZAiYLJbbS95W0+y9TIFmfnxcI/KMzOrrm11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268903; c=relaxed/simple;
	bh=6Dp5z9ju75aH+FsH4apNpldKWYtpIrXAlWNsBFc7nBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UpgBO8lvc9cunZ7iiEt2iQJDvXsPxwYdRKa+UYx54taPPKuPIF5LFPQaIdsuWVVUHRCfX0bKsb1Ea6wQ2VSmTmfhCfBSYZqZxgOXSjFE3kLDVLvzBt17O3wZcajhH1T+wfoUqgvH38E7/66p0fPuUjAO+CHrAqzs8bh5IeJfH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ndQ8oFuS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8sBjH026475;
	Thu, 13 Jun 2024 03:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718268852;
	bh=7kkBMQaDoeYNzDsRgMfJgiGjbnPVFl+KEhsMxEZwPWY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ndQ8oFuSNEgyU9+O5CrbuDsQgtS1wMbvYEp7/hJEalFISshugd2BiIVI5GONrtid1
	 of9bejvvcUYkbR/FdokdLT8v08nZgbwzmkjQrh1jANU7txBr8papTo+BgVMp00e02/
	 CvGkJadgG5XtPU+keiWigbeBfUfSzd+QZ07bHB7I=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8sBwV094870
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:54:11 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:54:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:54:11 -0500
Received: from [10.249.129.248] ([10.249.129.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8s5Db095270;
	Thu, 13 Jun 2024 03:54:05 -0500
Message-ID: <11b01dd4-79f7-432b-8a43-ec653d60a87b@ti.com>
Date: Thu, 13 Jun 2024 14:24:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/bridge: sii902x: Add pixel clock check in
 atomic_check
Content-Language: en-US
To: Jayesh Choudhary <j-choudhary@ti.com>, <linux-kernel@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <sui.jingfeng@linux.dev>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <mripard@kernel.org>, <sam@ravnborg.org>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
References: <20240613083805.439337-1-j-choudhary@ti.com>
 <20240613083805.439337-4-j-choudhary@ti.com>
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240613083805.439337-4-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 13-Jun-24 14:08, Jayesh Choudhary wrote:
> Check the pixel clock for the mode in atomic_check and ensure that
> it is within the range supported by the bridge.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 00a8c469f553..7f91b0db161e 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -496,6 +496,10 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
>  				       struct drm_crtc_state *crtc_state,
>  				       struct drm_connector_state *conn_state)
>  {
> +	if (crtc_state->mode.clock < SII902X_MIN_PIXEL_CLOCK_KHZ ||
> +	    crtc_state->mode.clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
> +		return -EINVAL;
> +
>  	/*
>  	 * There might be flags negotiation supported in future but
>  	 * set the bus flags in atomic_check statically for now.

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

-- 
Regards
Aradhya

