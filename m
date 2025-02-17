Return-Path: <linux-kernel+bounces-517423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21395A3807D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380533B0185
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879D217701;
	Mon, 17 Feb 2025 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MwV2d8CT"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96782135AF;
	Mon, 17 Feb 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789101; cv=none; b=r2GbFqwpHbZeE7PCynUXAo4YXZMzx0h/UaXiBbwJPwdSc+QYws/6uFylywJIbrwOAVgwTpPKDQBKOJYzX1LOFHt9THT87B1tip1rPy8BNl552GV4jM2ceG0PQAC0dH092SUtrsYnXml+rOOB6MZ15ADb2F5pHihNSnYPPsSqi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789101; c=relaxed/simple;
	bh=onsLhD/OZqjgCpNx3Oc/IawsINkP54EZmAsTG4JNz8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksPF+8E83YJWzJ2lp0Hpd5aYhTgOgHxK09peJJ7cbD+HpExtrEW935CPhzpfLn0piIqik4+vG7stTZOw2FcPsE5aL+Z2HQ0wy54I1n3a/AxDQGQ5ZindBz/Ux4fLdvssj/kJzmQJ/p3xJs9tkV1fxKkLfnBxVoWOGE4eiTz0yBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MwV2d8CT; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H4i6n0022196;
	Mon, 17 Feb 2025 04:44:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=K4icBczrJUhz4IG1RT
	JgNxQUMXbKqoFC7lTBBpaTZnU=; b=MwV2d8CT7JHrOHtG044twa9o/yEQ73Vru4
	hGfmNVNkgRPA6OCEhYbo8b5kdk3FvUaZVuhvXdfe/4c7Rnol7IzBv77eNjvfbUtR
	/Y9Hx7RWWFIYFpP/qJHZgCNdgyOXMA1ilheU0+fp+oPeI4V9SmL5ScRuugQHrkwP
	7YUWevg20Gdd1gJVFF3w1q6lSNGg95Z6slE5+iWLWruYnw/bd8+SSIgNwJGE3dky
	64TQoZyl0ZzBTFJ2oJuq+dUlQCdy3PN9eopOj5eVoHCrUyRDsxXLTJvCEMKmsgJF
	VEkiXHaBB6jtSuGdd5CvhgeRzEu5j5LyT/7OTJW80EMnC2cQA60g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44uwg18m0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 04:44:45 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 10:44:43 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 10:44:43 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 6E10C822561;
	Mon, 17 Feb 2025 10:44:43 +0000 (UTC)
Date: Mon, 17 Feb 2025 10:44:42 +0000
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
Subject: Re: [PATCH v1 5/5] ASoC: wm8904: add DMIC support
Message-ID: <Z7MTGq9zBqWCJ4kt@opensource.cirrus.com>
References: <20250206163152.423199-1-francesco@dolcini.it>
 <20250206163152.423199-6-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206163152.423199-6-francesco@dolcini.it>
X-Proofpoint-GUID: oThxAcshgNmhow2UrBHkn92R5j6EUo4M
X-Proofpoint-ORIG-GUID: oThxAcshgNmhow2UrBHkn92R5j6EUo4M
X-Authority-Analysis: v=2.4 cv=CYzy5Krl c=1 sm=1 tr=0 ts=67b3131d cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=m8ToADvmAAAA:8 a=JqlO1anYB2KeO3qhde4A:9 a=CjuIK1q_8ugA:10
 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 06, 2025 at 05:31:52PM +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> +static const struct snd_soc_dapm_route dmic_intercon[] = {
> +	{ "DMIC Mux", "DMIC1", "IN1L" },
> +	{ "DMIC Mux", "DMIC2", "IN1R" },
> +
> +	{ "ADCL", NULL, "DMIC Mux" },
> +	{ "ADCR", NULL, "DMIC Mux" },
> +};
> +
> +static const struct snd_soc_dapm_route cin_intercon[] = {
> +	{ "Left Capture Input", "ADC", "Left Capture PGA" },
> +	{ "Left Capture Input", "DMIC", "IN1L" },
> +	{ "Right Capture Input", "ADC", "Right Capture PGA" },
> +	{ "Right Capture Input", "DMIC", "IN1R" },

Am I misunderstanding things or does something not quite look
right with the routes here? Shouldn't you end up with the these
three situations:

Analogue:
	{ "Left Capture Input", "ADC", "Left Capture PGA" },
	{ "Right Capture Input", "ADC", "Right Capture PGA" },

Digital in1l_as_dmicdat1:
	{ "Left Capture Input", "DMIC", "IN1L" },
	{ "Right Capture Input", "DMIC", "IN1L" },

Digital in1r_as_dmicdat2:
	{ "Left Capture Input", "DMIC", "IN1R" },
	{ "Right Capture Input", "DMIC", "IN1R" },

So I think you need to add the DMIC routes conditionally here.

Also is there not some part of the existing analogue routing that
needs disconnected in the DMIC cases? This only addes routes,
which feels like the existing analogue path is never
disconnected?

Thanks,
Charles

> +
> +	{ "ADCL", NULL, "Left Capture Input" },
> +	{ "ADCR", NULL, "Right Capture Input" },
> +};

