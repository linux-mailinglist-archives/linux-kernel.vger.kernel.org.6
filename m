Return-Path: <linux-kernel+bounces-517424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B707A38082
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D7F3AD0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B962165E2;
	Mon, 17 Feb 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AO+cO6aE"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21B18B492;
	Mon, 17 Feb 2025 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789127; cv=none; b=RF5+dI9opgKvLAk09Z3hWeKO5xzs7eCFHze9SRpRNPBa1gOq1gXJYzN5NHK9JGOOxM0L8Kfy7jeXI/KRMI9ttSSH5XZTLommK/wP4Jhgz8DrXBWxJaLu4HOVk8xnPznAZLuvjtMfJI9CqelL8zeZoqwRVQJ08wWnYTJJtS1jvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789127; c=relaxed/simple;
	bh=cHMTH5ThduHPdm1u7j3eIF7LX5+Lv5c07rwUKurCD78=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8aDO6fHMlz7IH3NCYI0rt8qFKhCnvq2O5sk/8HxIWURbpnVEUclEPhYJ5eWCruo5FAMAdpEbALsA8qRyoKmxV3h+q1smbXGpyY9tcN2tIZPD3UbklyQRCdhSYV/dFhVmdP46hur5bpJubfXvCbCIqA+fL2Nuf/En2qrZB5Ng9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AO+cO6aE; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H6wnfW032475;
	Mon, 17 Feb 2025 04:45:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Z+adAFYoeuvQiptLGn
	Wx4ye3m2CIyBhfhF/WV6K8hz4=; b=AO+cO6aEhe0qmccdB88MmK6uUW6dRrbTFh
	zaiDAESSgfE3MJMz9XG7l70fYPZ68I8AKpvFEn6gl4KiQ8aQPGO4avSvfdVDYSET
	5aBIZp/kzX2DJLZtDavOR6jG3MSlRCLIL2AJG7zjsGG0U/gapEbCPiFLdGf5l94A
	qOSBDSs9Z6PdYDeDsfG1ji6GEJvuHeOFIaTQCF1Vuf3Nc+u2+WOYToBCxq/+AzMR
	idxPqgg+Eqhnb911H2p6HVRreX/T7k2Jdtp1ALVWAbtC7DmZDxO61PsTsAUL06S4
	emu/RQzxAYNYUnxTrkfHPBFkmoajmb+RcGS9I8YrTDr5OKaWwESQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44ts75um9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 04:45:10 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 10:45:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 10:45:08 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 8F39E822561;
	Mon, 17 Feb 2025 10:45:08 +0000 (UTC)
Date: Mon, 17 Feb 2025 10:45:07 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm_hubs: Use str_enable_disable() in
 wm_hubs_update_class_w()
Message-ID: <Z7MTM8ylhVSz5+0d@opensource.cirrus.com>
References: <20250210115804.53504-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250210115804.53504-3-thorsten.blum@linux.dev>
X-Proofpoint-GUID: d1pyz2tdppd4YM11vnQI4DLOVDFQO27e
X-Authority-Analysis: v=2.4 cv=fepXy1QF c=1 sm=1 tr=0 ts=67b31336 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=XYB6A2eQeqfmdjx3t9EA:9 a=CjuIK1q_8ugA:10 a=vyftHvtinYYA:10
 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-ORIG-GUID: d1pyz2tdppd4YM11vnQI4DLOVDFQO27e
X-Proofpoint-Spam-Reason: safe

On Mon, Feb 10, 2025 at 12:58:03PM +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enable_disable() helper
> function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

