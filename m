Return-Path: <linux-kernel+bounces-308289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8F9659D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508711C21E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C41C16C689;
	Fri, 30 Aug 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EjcW/iXx"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700C14BFB4;
	Fri, 30 Aug 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005695; cv=none; b=mu9i4X1Twi1L7U1IPBwO1hMcngie7e083ThuZqxroTgPICuIvLEpvqzhnvABIkXwpdC21eyRoo+d42cjiWr44CdyEpVmMgBUbiZgD+HUvEGOkaPhLocIf+HWl1gregreKk2iqsj2sAueR/fIKmCbZi77JR7Tc3EDAXmuMgVwkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005695; c=relaxed/simple;
	bh=u3vaPi4med1O6USTp2YrdKvfHtJkdmZmS0MxlUz8BQs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uorCqdyyYYIHndsMUPmMcPiSu3VRxsbKTCTHYoyMlGne3j+XqeCKPb8PY0VGBhJINssRYyGVBNSR0zyCjzplN8PGGc42S/3Y3zEbmbA/Dh8JL7K/CjMK1bseOctElxOGixnAo4smMfwsJerQXUoxHOry2+DCPDobqc5u9jm1JgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EjcW/iXx; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U4TA83006885;
	Fri, 30 Aug 2024 03:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=HE+ZHb5Werdu1CGONZ
	mh99lXU9j25qKzD92evBFq5yY=; b=EjcW/iXxiuxK/taLJbTEnNk82KepZd/23m
	CHzoWIoztwKqrllTW22ZjnTbn3y3b3Nnkp6aSIGrmhkmBpFFgHhwoha+qzclLF1d
	Q+dskL0rK9aNZXvi27Dw+i3Nrw7p7h+Iq1tsgCCVfKteBSqw153rk41oysm8ULpg
	8vp6SSY5JVO59S1gjcKSlcneO5KQBXgIPIaU9UKTX5JAbgEktQzj7lakd3us/oNY
	osZ+5Llesfly6StiSWjO/fpxx0mVLcqOD+6PY+OyqXWRexBEd5mYtHvdvyQlVfRZ
	9XMPKJXxd/ShoHtuZxO+hJoma8bqUraXtHATBMb8xa87lvQQoi9A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 419puw3eta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 03:14:51 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 09:14:49 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 30 Aug 2024 09:14:49 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 745D0820249;
	Fri, 30 Aug 2024 08:14:49 +0000 (UTC)
Date: Fri, 30 Aug 2024 09:14:48 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Yan Zhen <yanzhen@vivo.com>
CC: <rf@opensource.cirrus.com>, <linus.walleij@linaro.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] pinctrl: Simplify with dev_err_probe()
Message-ID: <ZtF/eGlQXPjaeBRa@opensource.cirrus.com>
References: <20240829044835.2047794-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829044835.2047794-1-yanzhen@vivo.com>
X-Proofpoint-GUID: _xd2txAgVOr1pnyGXCyo_Wd4DjzgxFyl
X-Proofpoint-ORIG-GUID: _xd2txAgVOr1pnyGXCyo_Wd4DjzgxFyl
X-Proofpoint-Spam-Reason: safe

On Thu, Aug 29, 2024 at 12:48:35PM +0800, Yan Zhen wrote:
> Switch to use dev_err_probe() to simplify the error path and
> unify a message template.
> 
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths. 
> 
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---

Subject line really should be pinctrl: madera:, but otherwise:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

