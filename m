Return-Path: <linux-kernel+bounces-429586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074629E1E38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1D7166690
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA0B1F12F3;
	Tue,  3 Dec 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HOb+ZO/K"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D62AD02;
	Tue,  3 Dec 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233918; cv=none; b=dUlSQzO072npB+3FbcblRWa1w2FZeXFYEksl4nFLLTy/kxWtnaGreg1qTeqfSF0op1k+YCY61RopcFnKHDJVSdboMCWxnPaK4400sQv0DRSPpbVGrubHRBnerPAxF2jYeAJUrcKguzBgRZbS8axssRAGjKxRAs/YD73KYCfq6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233918; c=relaxed/simple;
	bh=1/cnLiX0o5UtztRH+o1E5t6mBRSHSOJfAqw2q5NSJdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HP8eAdxUNCYv8vRBOlsUx9hJ6+6cE+T8UboO/Ml+DI8DGPTJ545pSiKF6zGKTbG6RLAXUf2o2tCoqBqewAjubrt7IUyJ/bovqg8OkTPcHtMWwQFlJlFJsypfLipzJzLN6fl8FkgtwCDiWkXLCuIgwDkCnY7QKNsxxsqzmODHJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HOb+ZO/K; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B35Sa7w019986;
	Tue, 3 Dec 2024 07:51:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=xi6Bd1pHOXM6sXoTOE1RkVnj3Q7HyyEWw7hIRRnc7Eo=; b=
	HOb+ZO/KtmvmGP9hQNH8kjaqgHG2Jv70xNU6wlVGx4DdZOTWbUZyp/DRMYjuGXkw
	lWevyfJiHKZVSj9rIkrN9239kUWVCPhy7/Sdh8jGwzx2hHziZbq2f573yYU5RA53
	VK/x8UgHbKQW7Ii+6TQ4T4VAW0oyu+gdtHEDXMP4kC2t8fG3dUFjUvPWVxZZSeW0
	o0m2wuGgWtEhyVFVJUdXjG7cg6H8CRcHlowdEOjB7DFnKt7dD5qFhH8fybwLi7Aa
	m0daWCBt6HdD9Q0wTxE+bKrZO/j728y0G5Vtp147lGPBm3pt66pbQwUyrtXBGCPm
	KhOBKPCOYdQZ1AZ2g9jWWQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43800nycjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 07:51:39 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 3 Dec
 2024 13:51:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 3 Dec 2024 13:51:37 +0000
Received: from [198.61.68.170] (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 44B4F820247;
	Tue,  3 Dec 2024 13:51:37 +0000 (UTC)
Message-ID: <e888ffb4-90a6-41d4-b081-e084b09b3780@opensource.cirrus.com>
Date: Tue, 3 Dec 2024 13:51:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] Soundwire: stream: program BUSCLOCK_SCALE
To: Bard Liao <yung-chuan.liao@linux.intel.com>, <linux-sound@vger.kernel.org>,
        <vkoul@kernel.org>
CC: <vinod.koul@linaro.org>, <linux-kernel@vger.kernel.org>,
        <pierre-louis.bossart@linux.dev>, <bard.liao@intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
 <20241203131813.58454-8-yung-chuan.liao@linux.intel.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20241203131813.58454-8-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: woPU4XfMAGJAsuqOI32Muo-zkm4eUzDl
X-Proofpoint-ORIG-GUID: woPU4XfMAGJAsuqOI32Muo-zkm4eUzDl
X-Proofpoint-Spam-Reason: safe

On 3/12/24 13:18, Bard Liao wrote:
> We need to program bus clock scale to adjust the bus clock if current
> bus clock doesn't fit the bandwidth.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>   drivers/soundwire/bus.c       | 10 ++++++++++
>   drivers/soundwire/stream.c    | 32 ++++++++++++++++++++++++++++++++
>   include/linux/soundwire/sdw.h |  1 +
>   3 files changed, 43 insertions(+)
> 

Does this still have the bug I reported here that breaks on systems
that have peripherals listed in ACPI that don't really exist?

https://github.com/thesofproject/linux/issues/5257


