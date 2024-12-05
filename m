Return-Path: <linux-kernel+bounces-433358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA31E9E5761
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855D5161448
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E2218ACD;
	Thu,  5 Dec 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CNIzS7nX"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827D218852;
	Thu,  5 Dec 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406019; cv=none; b=EsXgpFbn96LxA02Sg8E4vs/UTzJCjiHnV3jQztlxQ4AKgNebbTD2XAHlED3scTYlPfZongzL7BnU8PRIrbgZ7Fo8HNYe4YT9ePnn8+LjC90CIoBDrx7QJBe32uoAOJDpM6dqNccMLngApzxmyyAMF3xXmIXasjq7TReLOybHn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406019; c=relaxed/simple;
	bh=cnq3gp7YX1P7Bynt0s2lNzZknHh7JdWJnkN+5mfVzog=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sACYdjYL+0aLZWKYiVWy+W1GBxoX2EZ2N+iUoecUPy1ZFMeLewFNj4t9DDhlyMT6+mVpcKrKLJECSKP6r708ZHChrGcHMqDqDuPBH8IN5n+kVHnWTRnP8IFvo5plNkBlqVCxQdVLLyHm4e+s+0rFAhuiIX1gqJyxj4ehUxr5A3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CNIzS7nX; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B570Hl5016009;
	Thu, 5 Dec 2024 07:39:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=1uz8aCNvQqAbJ7vo9y
	V65KiEmDTUBsdcZ7iQRZ0H5H0=; b=CNIzS7nXO8FAChiIB0E+7d/iLvPAupUh6w
	Vp6kmgMiDVpMmvmpzulZu2Mh14C8ErExJGkddHdT5z82nfPQeuMXYfT8xOvku1bC
	xwfVXdhOlGOYM+vTsF9TeXaOs2peuQ5jM/Tgi3qYYa0DE5FR4REv4sJeCZVTU83Z
	4JkZeT4XOR7gNL6LjhAZiqgu4vsFU7OPghWjqCcpzmmS290B53FDomCMWdR3Fsrm
	dCI0Xj/T9goq6S4ythHGQcnNxqffZYbSEcdDJffVRoL37VLcdOvhJQVaoBqlXphI
	ucPDbvM71mWXoU4qgDIOlbwDjwiueohoRWXVeaAw8FohYE+LWS2g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4381022fun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 07:39:58 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 5 Dec
 2024 13:39:56 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 5 Dec 2024 13:39:56 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 3B94E820247;
	Thu,  5 Dec 2024 13:39:56 +0000 (UTC)
Date: Thu, 5 Dec 2024 13:39:55 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andrew Davis <afd@ti.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/21] ASoC: wm8985: Remove use of i2c_match_id()
Message-ID: <Z1GtKyYLneBoaKOO@opensource.cirrus.com>
References: <20241203200001.197295-1-afd@ti.com>
 <20241203200001.197295-21-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241203200001.197295-21-afd@ti.com>
X-Proofpoint-GUID: kIHI8rp5YJNdP-uJW8WjKyZAsOX8hcK0
X-Proofpoint-ORIG-GUID: kIHI8rp5YJNdP-uJW8WjKyZAsOX8hcK0
X-Proofpoint-Spam-Reason: safe

On Tue, Dec 03, 2024 at 02:00:01PM -0600, Andrew Davis wrote:
> The function i2c_match_id() is used to fetch the matching ID from
> the i2c_device_id table. This is often used to then retrieve the
> matching driver_data. This can be done in one step with the helper
> i2c_get_match_data().
> 
> This helper has a couple other benefits:
>  * It doesn't need the i2c_device_id passed in so we do not need
>    to have that forward declared, allowing us to remove those or
>    move the i2c_device_id table down to its more natural spot
>    with the other module info.
>  * It also checks for device match data, which allows for OF and
>    ACPI based probing. That means we do not have to manually check
>    those first and can remove those checks.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

