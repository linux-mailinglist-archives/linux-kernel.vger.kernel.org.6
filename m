Return-Path: <linux-kernel+bounces-556234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DECA5C2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A7172D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E9D1CAA63;
	Tue, 11 Mar 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZFBWUtaO"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38B1C695;
	Tue, 11 Mar 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700764; cv=none; b=YROxB1slXx1RZDTJD3aNJyt6Ehek8HXnp/hKvYWENIMxfgIjGtifTgWUvDaq5P+cveAyTbNe/fZTxXBKA+vc0+SfLj3vEYWMJSuwxyPA2qc15iguQXK3HQW05+j1H9YvEEKU25SPWqBRb5U2rXc4kcMYtju3u7u/qS1Iz3HCDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700764; c=relaxed/simple;
	bh=7487bNMx0KLZfinFW+iJ0bt5bL0K6pEGLja26xALGF0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVDeW/sgJYcvxKjZUc/rQPKK921WG6z3xGjamH5Knvq+yFBVyB9nwhNnypLkup22auer6SdoZp5l3D8PJQcVojS1CxP6yHvYwOS1p4/KfYvDWloVmLJiCGwiwktGA4ziSxxQ14l6qvPh6eRQUtG6W12NrvwrQnLhLJtv6/lkrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZFBWUtaO; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B8Uhfw012652;
	Tue, 11 Mar 2025 08:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=zCVBQr7oDz/bG0Iam1
	7TXUvWhByBDOd4UeH308Vq6zw=; b=ZFBWUtaOmw/wUF0PRxDai/ndKkZmglpnyx
	LVHBv2N/fjxnaTrNRm56ngNCuWdCbnGBdn/7nLQNtpFfRdxn9Ywc9g67+lhS0hSU
	9m7x54xzizwS0oFYGIEBqs/vz6/A5MMvCRnctYhdu6Pl35L5s2rtbJgzlY1LdCOk
	xaA2c89NaXnajexCzxaOdb8Sa4Xvgz+nYOf/9NB83i6rr5U0ZJwx3o4CSI6TJ/fg
	wcgHZWYy6ZBkLUsmJBKGM6lwhewz+U9CmLxk1EYFvM8cOlaoI9F3IXTMCGWv2JtL
	t2/mIaFFz5KmXJa4550U67mk1u5CAA8ZsDOrjb1R4zwYDD08U6bA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 458m65xmup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:45:43 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Mar
 2025 13:45:41 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 13:45:41 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 7E22982255A;
	Tue, 11 Mar 2025 13:45:41 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:45:40 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: <amadeuszx.slawinski@linux.intel.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Dimitris Papastamos
	<dp@opensource.wolfsonmicro.com>,
        Charles Keepax
	<ckeepax@opensource.wolfsonmicro.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Mark Brown
	<broonie@opensource.wolfsonmicro.com>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: codecs: wm0010: Fix error handling path in
 wm0010_spi_probe()
Message-ID: <Z9A+hNeL6s9Dibzu@opensource.cirrus.com>
References: <5139ba1ab8c4c157ce04e56096a0f54a1683195c.1741549792.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5139ba1ab8c4c157ce04e56096a0f54a1683195c.1741549792.git.christophe.jaillet@wanadoo.fr>
X-Authority-Analysis: v=2.4 cv=CuVFcm4D c=1 sm=1 tr=0 ts=67d03e87 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=kdJoGvSddbJ0Pk3_t30A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: YlTXEfG3T37icTgxjzL37mZ2-Q5dbxNI
X-Proofpoint-GUID: YlTXEfG3T37icTgxjzL37mZ2-Q5dbxNI
X-Proofpoint-Spam-Reason: safe

On Mon, Mar 10, 2025 at 06:45:36PM +0100, Christophe JAILLET wrote:
> Free some resources in the error handling path of the probe, as already
> done in the remove function.
> 
> Fixes: e3523e01869d ("ASoC: wm0010: Add initial wm0010 DSP driver")
> Fixes: fd8b96574456 ("ASoC: wm0010: Clear IRQ as wake source and include missing header")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

