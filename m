Return-Path: <linux-kernel+bounces-321606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40092971CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D831C231EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0301BAECD;
	Mon,  9 Sep 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ye20z4xF"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095A1B3B11
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892595; cv=none; b=lvAxAihjsyTijPh3j7m3SJqYR6ws5RzpJG4sS/5XhQ1u+njHVeh2RKuBoDmq85C4lOUmTA6nZFJ9xY5JwEkh7IRdu4xwIHyAhr63YnxLKZVswi7TV8KvFmulECnjvN/gK8Qjez1WuogBgWIdaZM3IyL/NxX1vQTh+KKUnPAox7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892595; c=relaxed/simple;
	bh=2p1aBZqsUmCuXQ3jiGz0sZlXSSmxwwNLGq3tOI53ZZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeqwLdbgvxv9tkU8THuHas6sqAY7h5xu7C6Q40bxM9QiQEt7LV6ukbVuzyP2THwr00t6zKlaFWoSDBh4RDTayqs8jnwJt6LSb7kFks2cNek00aYFiiZRdgsn/7i8Qdevp8Sf8cKmbjSUdb8lHFJVYBrX9nsFUnvX6H7bTpv5EfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ye20z4xF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4895bCw5012744;
	Mon, 9 Sep 2024 09:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=9tHyNH/L4dVK8ecBDE
	2nZgXN5xeNAU1JDx+oAdHfNpw=; b=Ye20z4xFy8uOsE9ahafBpm8JfZKh5Nui/K
	oLuSts1jvOi2YDbruSgNoMn4X4tMkADO2gDYdsK/3BF20y5Vz5iVevIJOzkiD84W
	C1COTjSiM/rvARPNit0Je9225+X9jafXgHi96GsLCMlW10OvaD42Z+B1cWBBnEUc
	HMI9yd85llVYl0kZCe6M8+RqAD+4C/3Et/K4LFHlDS98smjAPF8LDQtdaTt5ZoMZ
	j86sjBTBCe38VrZ5NpUveqADJWDA0ChMTprWzAx0c2oCWTgT/BeNFOcufGRRV+Rr
	9xkHuXYHNsSI/Xz6cRtVVGTkNx+gh48hYLJE5yOQKFE6Cd9m5S3Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 41gm7x1qcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:36:26 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 15:36:24 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 9 Sep 2024 15:36:24 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 9B557820249;
	Mon,  9 Sep 2024 14:36:24 +0000 (UTC)
Date: Mon, 9 Sep 2024 15:36:23 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Vinod Koul <vkoul@kernel.org>,
        Bard Liao
	<yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soundwire: stream: Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <Zt8H530FkqBMiYX+@opensource.cirrus.com>
References: <20240904145228.289891-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240904145228.289891-1-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: UWsB2DbKv8vFLqSDML-G28WGcjBtvHa_
X-Proofpoint-ORIG-GUID: UWsB2DbKv8vFLqSDML-G28WGcjBtvHa_
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 04, 2024 at 04:52:28PM +0200, Krzysztof Kozlowski wrote:
> This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
> breaks codecs using non-continuous masks in source and sink ports.  The
> commit missed the point that port numbers are not used as indices for
> iterating over prop.sink_ports or prop.source_ports.
> 
> Soundwire core and existing codecs expect that the array passed as
> prop.sink_ports and prop.source_ports is continuous.  The port mask still
> might be non-continuous, but that's unrelated.
> 
> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
> Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Would be good to merge this as soon as we can, this is causing
soundwire regressions from rc6 onwards.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

