Return-Path: <linux-kernel+bounces-565845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0955A66FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93ECD3AAA81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3254F2054F1;
	Tue, 18 Mar 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c8DBxM16"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6B1F4619;
	Tue, 18 Mar 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290812; cv=none; b=AOsxU3VqbzWDY1xjuy2R/PkuV/sdQdnuJnmfg/6RWbphybbSy9XAz9wPGFMnP6sjDKCf+8oTjEr7WdkGAyK32Kqrd8L6BvC1lGHDWWzhQQDLZT1Jw1V811K7YOzTBKCdv05rhSB8pdHU9OtlzpchGm3Jv2m7A43v3EVzp066Ev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290812; c=relaxed/simple;
	bh=atBM9uoHH7gMr/v1f9FwbCCOTrtjCGXtLJB5z+YR6Wo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNHXNAFEj9tzJ1z7Kzgr3r/2zgkAMdiVhmFXckXcxeQ6z2wChHyEG9YqZHPdwmhsA6nYZObGUzeFqVWIZH8iv/Nh8UZE24YoE7oLgpoKciWqMcIVzzoaD+DqeRzOyxFJ+bN9qraG6u9Yn2nWKCNmz8z4MAN4QeqVzNtw9gCJbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c8DBxM16; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I4QToC021542;
	Tue, 18 Mar 2025 04:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=T8k62eV0vAJp0y/Szq
	D4YHMyYgDeSXiiAponFwPO89Q=; b=c8DBxM16xcHIqK/sI6z5FgmcdmtHkXpeKC
	sq2jk7YAh2ZhFkXWUBes1Dvo+mTnGA1FHx2707igs3Z4c/10m8EgBDzAonWS0zBh
	UtT0vYaBAAf0sVGQaZSoRybr04Za+hHNDLiv3G5G1OAdwW+bnELZJO3lksk03a6t
	pXqu7LOj2iGAEeHH0bPRmRhJjXk7WkeCfUdoo7dUUISAN8CfzSF89SwaULYkdJTP
	DgHu3Gp63aUSZOUF35zx6hLzsorjIjy9hgG6iyIVirasO9MiU8Ztdq0SJM2UWX63
	kxAM4TfhK0tA2waSVXLoyZi6XonAclw6sD93I2XcjBRm31fv2lyQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh75qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 04:39:37 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 09:39:32 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 09:39:32 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 1EF6682255A;
	Tue, 18 Mar 2025 09:39:32 +0000 (UTC)
Date: Tue, 18 Mar 2025 09:39:31 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <u.kleine-koenig@baylibre.com>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: Add initialization for wm8997 component
Message-ID: <Z9k/U+8TSVfSzFKw@opensource.cirrus.com>
References: <20250317140845.702-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250317140845.702-1-vulab@iscas.ac.cn>
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d93f5a cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=HBWco2q_b250qaoshC0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: w3Pzgv4h-TJHvfdBDGWbP69jN0cytI4k
X-Proofpoint-ORIG-GUID: w3Pzgv4h-TJHvfdBDGWbP69jN0cytI4k
X-Proofpoint-Spam-Reason: safe

On Mon, Mar 17, 2025 at 10:08:44PM +0800, Wentao Liang wrote:
> In wm8997_component_probe(), wm8997 should be initialized by
> arizona_init_gpio(). A proper implementation can be found in
> 'wm8998_component_probe()' where the wm8998 component is
> initialized with arizona_init_gpio().
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  sound/soc/codecs/wm8997.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
> index 5389c363b14e..ef8e09cc7211 100644
> --- a/sound/soc/codecs/wm8997.c
> +++ b/sound/soc/codecs/wm8997.c
> @@ -1066,6 +1066,8 @@ static int wm8997_component_probe(struct snd_soc_component *component)
>  	if (ret < 0)
>  		return ret;
>  
> +	arizona_init_gpio(component);
> +

This is not a missing initialisation, arizona_init_gpios hooks up
the signal detect feature. I am not certain it is worth adding the
signal detect feature to wm8997 at this point given I am not even
sure it shipped any units. If you do actually have a reason for
doing so, this is not sufficient to enable the feature. You need
to also add the Signal Detect widgets and routes.

Thanks,
Charles

