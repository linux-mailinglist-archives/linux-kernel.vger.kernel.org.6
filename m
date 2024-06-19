Return-Path: <linux-kernel+bounces-220860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCC90E84C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7107B2192A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33B712FF83;
	Wed, 19 Jun 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VMNoveSj"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AC77F0B;
	Wed, 19 Jun 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792657; cv=none; b=bvfbBCDJmcxXj5ykG7u45m4+Bdx2BMoO6KM3YMVpU9cTTSt1UZxGWCu87u/qTzyU5dtvqlDM3CorxoEdFOskxr2Tk6sc+J+Q2pZfEHH1WoSSXCESRojsoy09h6piQOrbBSRBoXNlguYO0Qu9ex6yhVvuyXbtYH5bEylGNc4vN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792657; c=relaxed/simple;
	bh=oRd71k4awj/6s9BRMEV7w3ZoQI9623aTuz0KN1OcpdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DMUEGgx+Z3CblTwNhaL86F0pmkMNllusNbJgojN8SdUlhRtCadqFc8AcudS2sS+koPSuxH3hoD32SL3mn11sFOESKwUOKANwyjwj/+ldlrrfwjeEROXiwzJIXc81ADwJUsiQE4aAR8tz7ucehxLZQhYnlEpohDSOrXv5RJKUhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VMNoveSj; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J6sYgY029887;
	Wed, 19 Jun 2024 05:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RPk4rBMEEC3dEWsw4E893T9mznv8r6hBMz9IHmL9niE=; b=
	VMNoveSjmRpH0g0U3QBmQU/2CxVO8AUB3GSvSihrz5ou8Mlv7/2xOSSACm9Zc1XL
	fSEgfbWQnTOGa8Jp+kk31uYliOtnpxmvHjgNew0B0GyI/buoDkA2aVhSxkfGoLNe
	04k5ZFqe/6FZsBbOrQxKW+Q9FCVyDVEgUguSnX/UzWK4KtmYnOo3Qq7p+4CZBlLe
	ROzAHis1RxP6sXSZ9LYwUxH5AfBh8AjvORChy7GSvsHYyFsTVMxIJAp6opCNntLB
	t6he/b1BAWqmOinZz1aTdQl5d1e56VpSMV9PuTfw1DoMLnwAPnEmZj3JfZ8yme6a
	dZ0enXU8AHkh6iZF/7No4g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yuj8m0g1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 05:24:09 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 11:24:07 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 11:24:07 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 01DCD820248;
	Wed, 19 Jun 2024 10:24:07 +0000 (UTC)
Message-ID: <97da8398-599e-45cb-abb2-97cc66567628@opensource.cirrus.com>
Date: Wed, 19 Jun 2024 11:24:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
To: Mark Brown <broonie@kernel.org>
CC: Simon Trimmer <simont@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <fe9dd613-8909-4c7d-a7d7-9094b75fe8fb@opensource.cirrus.com>
 <941d2b8a-18b5-43ad-9aec-6785f841dfaa@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <941d2b8a-18b5-43ad-9aec-6785f841dfaa@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YpzMdpZlHV6yBMraLsbqwHkcovA7cKyq
X-Proofpoint-ORIG-GUID: YpzMdpZlHV6yBMraLsbqwHkcovA7cKyq
X-Proofpoint-Spam-Reason: safe

On 19/06/2024 11:22, Mark Brown wrote:
> On Wed, Jun 19, 2024 at 10:44:47AM +0100, Richard Fitzgerald wrote:
> 
>> Mark, I don't understand what your objection is.
>> What is it you want us to do to get this bugfix accepted?
> 
> Have patience.
Ah, ok. Sorry, I assumed you were objecting not just overloaded.

