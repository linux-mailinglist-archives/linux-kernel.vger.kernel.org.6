Return-Path: <linux-kernel+bounces-544304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7AA4DFF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD93176218
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6856C204C22;
	Tue,  4 Mar 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="H1hNbkL4"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9C20485D;
	Tue,  4 Mar 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096605; cv=none; b=EWx2fj6tPpLWhaGTPvvtuBNPOTCdub/EUfY3T5wRAYAeYXggibDhHJTY8jsdNR6d1njn+a72+kBW33MqSOyvNbbd+tsrJ5mtd9Gt9poiULSN3+WFE9zC9OBHpHk/qXK1k3elgadXVB8GkjthYfhxfxjrlIRp68BmM/qpIv82hF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096605; c=relaxed/simple;
	bh=WX4kS6nIMmulr3rV6w4z+g+wZXdahcIWYzxhlj1Y5YA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF48xaJ2sTCtRRsPXK1Euttnajm38OBzuiCV3WXxzf57U7Rd8um6TMqDcExEMTNJXyKkPxEHMNBr11JXUVGRVpzUmSc5ruBMihda0pToqmX81q/juXngX+4d9dnqCGR+4XFShwao9Wxwm/Znc6U+0F/LE8unuvsUd7enY1UnL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=H1hNbkL4; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5244xVpU027794;
	Tue, 4 Mar 2025 07:56:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=fX7b0J1Hf2WyOx0n5V
	5Uluc5WRes3j4a1QlUJSYsrDs=; b=H1hNbkL4Xy2jkShPJJJRcgDb7QcO5/nQp7
	9NgWBpW3X08DN56sFZdV+lOOqhxAPG5CXK4RVe3vsC8ejs0sLhpGjBlwNfRax0gh
	iHfoTdzowmC4M4Qar/pSEa9Kpqg3p0MJBtn6c/24gj5kpgGdYPWzI9Hr7a3QlFrg
	5YEQFbES2BmS6+XpQAGAhLXDrKJvqZdO2RXr9d4KAF6NNTap6xDhtHFyjAZ39pGY
	cp+9orqkRiEw+h0zf5tPlMgynuawJ+OtNtBxwxLQXsPnIHusYkXPCQg0Cy75yrnG
	16CAeNC7FXRt6K7pxv+o2BADDPfQsqOk6DNcQ7Iys1nQmYvPZUpA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmf8qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 07:56:20 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 13:56:18 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 13:56:18 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 88481820248;
	Tue,  4 Mar 2025 13:56:18 +0000 (UTC)
Date: Tue, 4 Mar 2025 13:56:17 +0000
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
Subject: Re: [PATCH v2 5/5] ASoC: wm8904: add DMIC support
Message-ID: <Z8cGgcq4ynfeCNKp@opensource.cirrus.com>
References: <20250224155500.52462-1-francesco@dolcini.it>
 <20250224155500.52462-6-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224155500.52462-6-francesco@dolcini.it>
X-Proofpoint-ORIG-GUID: 9S4_Iw2GNLbnxIUqVjjXV3AMQY-u2KCb
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c70684 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=m8ToADvmAAAA:8 a=w1d2syhTAAAA:8 a=ctNVv1JNONuTxNbLFmwA:9 a=CjuIK1q_8ugA:10
 a=kCrBFHLFDAq2jDEeoMj9:22 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: 9S4_Iw2GNLbnxIUqVjjXV3AMQY-u2KCb
X-Proofpoint-Spam-Reason: safe

On Mon, Feb 24, 2025 at 04:55:00PM +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> The WM8904 codec supports both ADC and DMIC inputs.
> 
> Get input pin functionality from the platform data and add the necessary
> controls depending on the possible additional routing.
> 
> The ADC and DMIC share the IN1L/DMICDAT1 and IN1R/DMICDAT2 pins.
> 
> This leads to a few scenarios requiring different DAPM routing:
> - When both are connected to an analog input, only the ADC is used.
> - When one line is a DMIC and the other an analog input, the DMIC source
>   is set from the platform data and a mux is added to select whether to
>   use the ADC or DMIC.
> - When both are connected to a DMIC, another mux is added to this to
>   select the DMIC source. Note that we still need to be able to select
>   the ADC system for use with the IN2L, IN2R, IN3L and IN3R pins.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Apologies for the delay, I think this looks good to me:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

