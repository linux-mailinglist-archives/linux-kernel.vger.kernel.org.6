Return-Path: <linux-kernel+bounces-517309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F776A37F28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CE53B374F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3743216613;
	Mon, 17 Feb 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MIKIQw9U"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70E2163AD;
	Mon, 17 Feb 2025 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786259; cv=none; b=c2QorVMJp8kcv75QWDT9YPBvNKZ/lBngN3Cp3MsI7kUmj647z08t9dCxZYUiG7mPVJI4ALwLxN5C4ArSiGA6lCpxauXEgYcwW94v2fL9R0v64X3/6FfdKjp2NIFjbqGbzWbX6o7/Pu/hVuuAlWO+JF0QZLbYzp6GytaPQTA3FSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786259; c=relaxed/simple;
	bh=ff/ojdVCfYwCjERwRe/r6CKIxlJq2Z0EEhLcqhySaGA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asCUVut2Dwzgmqj/CxyfSwdzS57VGuXJ3INqDroxg2VsAxVeJK7zFabJQFMsUtfGIURYrY11TeTSo9BQG4ou+kN58oBCPTk35zqHmi36OzKgG5DUH4Uu4S4Zn4+/HHj14Ue6lOH+n0qQqk5/WZEW3ogRYemlQKe+7iA/7t54AEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MIKIQw9U; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H6wncn032475;
	Mon, 17 Feb 2025 03:57:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=VQnPTbRnGx3MDcwlem
	XHsudsRqJWoOG4TTIJvD7dU94=; b=MIKIQw9UHMR+nhAJNeX77+8ZgBYF3r6t0L
	ZynOZRXOCsPGNgM0/jaTybOXbOwRKNRBHm49LaLhRQJKazuoCzuQIk3fu3oh7Kr2
	FGTTDRIyfsmsUgo5sQByZtdfxMfbJXTB7oj+WkZXcGFL2MK2XNnowsB7xJcFCJuO
	YS1mwChT3ddp8HplGu+kQuonyOCsueBfwBxfuhQI9ecdm2J4erwQ2xJYUGyicC6F
	pi7LiPmU5FFwL6C8vpdHDxWibCe2tcHxylSjOnwOND7kqkGf5KVrWBWKshEgTXeK
	HH54jNoTuvvnW8GU8FY9oKF7Fdh3u6AQhg9IuwflgzwRmFX8IVoA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44ts75uhpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 03:57:06 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 09:57:03 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 09:57:03 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id C4BB3822561;
	Mon, 17 Feb 2025 09:57:03 +0000 (UTC)
Date: Mon, 17 Feb 2025 09:57:02 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <patches@opensource.cirrus.com>,
        Ernest Van Hoecke
	<ernest.vanhoecke@toradex.com>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Francesco
 Dolcini" <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/5] ASoC: wm8904: Don't touch GPIO configs set to
 0xFFFF
Message-ID: <Z7MH7nZHq7GXRoQP@opensource.cirrus.com>
References: <20250206163152.423199-1-francesco@dolcini.it>
 <20250206163152.423199-3-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206163152.423199-3-francesco@dolcini.it>
X-Proofpoint-GUID: RxRjI2Z8tOCwjc_wg2qm43HxgoGQ0ko2
X-Authority-Analysis: v=2.4 cv=fepXy1QF c=1 sm=1 tr=0 ts=67b307f2 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=m8ToADvmAAAA:8 a=2M6oOL_jOPCmwRCwdCkA:9 a=CjuIK1q_8ugA:10
 a=YXXWInSmI4Sqt1AkVdoW:22 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-ORIG-GUID: RxRjI2Z8tOCwjc_wg2qm43HxgoGQ0ko2
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 06, 2025 at 05:31:49PM +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> When updating the GPIO registers, do nothing for all fields of gpio_cfg
> that are "0xFFFF".
> 
> This "do nothing" flag used to be 0 to easily check whether the gpio_cfg
> field was actually set inside pdata or left empty (default).
> 
> However, 0 is a valid configuration for these registers, while 0xFFFF is
> not.
> 
> With this change, users can explicitly set them to 0. Not setting
> gpio_cfg in the platform data will now lead to setting all GPIO
> registers to 0 instead of leaving them unset.
> 
> No one is using this platform data with this codec.
> 
> The change gets the driver ready to properly set gpio_cfg from the DT.
> 
> Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

