Return-Path: <linux-kernel+bounces-517347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD1A37F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA68189559C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF288217703;
	Mon, 17 Feb 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TqBgJJoo"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70864217F24;
	Mon, 17 Feb 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786878; cv=none; b=lWFerPoVxX5bBQwu+PTrynZ376yDtBAHqihdsML92+dX7JuDgxSyr9TJJCRIPkCjrOZ6rMOVhfLBIQJAW/FzDNmTNZm5AChiMNybrIU1LsZByp919N9NpxXMl5AImD1w81CL7Y43tkIEFGoODwNnE9HCdWo9wLgIxnOJ5TivxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786878; c=relaxed/simple;
	bh=WTEkBJbEoohvOnLs8ZG8ZjIpCctoGaPaGiS99nzNFK0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SouZbqk9zSTE6M2Ywn6Tr3qRx0yLf7RD/9HsGiSQey22rnm77un9af1pcei8aV+BSgnpWaPPPzkxRcsa6YSqXWAcjEBMdRQZ9l61SKbGTqt5+j4IS2tm64ZREtb7Y5ICtLb2QwrHP2xFmz674yDI30v+Au+DVl+FpZRNEKq6xUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TqBgJJoo; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H7w1Pk014998;
	Mon, 17 Feb 2025 04:07:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=wakwyFHAJCVvGbhqrn
	JLBZqnmDFS/vx4KyMQ/0AZRz8=; b=TqBgJJooCiD0i3nqRH/tNYo9ETb0kO2R9f
	r2ZCPpXFcLEPuvhAO4cEV0+MP8sXyjkGyO9bxQvmg3k7t5Ovl4aAyAp+yoLG5hYF
	guDr+YvW9d1A9ivbdqbUVIi/A3VIgnOd3SNmQIK8J+E7V6CLtNBI5GzrMrhD+OeL
	9vgjF9av3PsEu4L7rkpqi4Qnfy6EP+hhXXK/IiSgxyIkJhLNktjdo+EcQA9cKkds
	Ku9hIhJLnBhWFLxj7KAyJVyHHdWwoBDz3zW4xbBlBysaWQXCSbzF5snxl1QykDdL
	gcEHgLCMOLgZ9HLN+uEwxxHMPAA+iAtF9apRPc2/WjnwDhuKWh9A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44uwg18j61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 04:07:38 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 10:07:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 10:07:37 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id ECD59822561;
	Mon, 17 Feb 2025 10:07:36 +0000 (UTC)
Date: Mon, 17 Feb 2025 10:07:35 +0000
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
Subject: Re: [PATCH v1 4/5] ASoC: wm8904: get platform data from DT
Message-ID: <Z7MKZ11fRNN5XS90@opensource.cirrus.com>
References: <20250206163152.423199-1-francesco@dolcini.it>
 <20250206163152.423199-5-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206163152.423199-5-francesco@dolcini.it>
X-Proofpoint-GUID: zFVgUBsuYQTWAFBp4JceVwXbSnEn3_pf
X-Proofpoint-ORIG-GUID: zFVgUBsuYQTWAFBp4JceVwXbSnEn3_pf
X-Authority-Analysis: v=2.4 cv=CYzy5Krl c=1 sm=1 tr=0 ts=67b30a6a cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=m8ToADvmAAAA:8 a=dvSm-TvE4kW1qXnr-8MA:9 a=CjuIK1q_8ugA:10
 a=YXXWInSmI4Sqt1AkVdoW:22 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 06, 2025 at 05:31:51PM +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Read in optional codec-specific properties from the device tree.
> 
> The platform_data structure is not populated when using device trees.
> This change parses optional dts properties to populate it.
> 
> - wlf,in1l-as-dmicdat1
> - wlf,in1r-as-dmicdat2
> - wlf,gpio-cfg
> - wlf,mic-cfg
> - wlf,drc-cfg-regs
> - wlf,drc-cfg-names
> - wlf,retune-mobile-cfg-regs
> - wlf,retune-mobile-cfg-names
> - wlf,retune-mobile-cfg-rates
> 
> Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

