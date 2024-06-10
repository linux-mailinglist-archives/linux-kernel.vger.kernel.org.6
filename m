Return-Path: <linux-kernel+bounces-208436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223DD902526
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B522B24198
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE14113D2A2;
	Mon, 10 Jun 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oYDXvN+f"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAB139578
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032445; cv=none; b=D4rz9U3Q3V6Q1sslhkSw8rpwl5e9wa2YRfiJYGU05xkBdxQW+Cj3TBkseKwgH0pi3RLGRLlD7pWkneDcWcveDTegAVO/etm+JkD1evLcLvyPD1tbpadYkerSUzpNQaZBPqUGCNinhfAYq5ZGgAXkGbiZIqo4DZdTPsYQRsYj0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032445; c=relaxed/simple;
	bh=fPnKg9UID+mW1zrXenYbwf76f9AMLdNbTU/wD+Y1ggE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZpUfmqQLxXSvUcdKHdwq5BJ+GDkpTb6abxzGHvtVmWTGxQD54Oy78C/oBIWxRUMLVdPvlUkgFQtROPAeCssTFiz9OWDj5SDWlJGYQlycnFW3zjTwdEAB2QCx83kANPslZhF9R8+jubf6mUOAYKcFN8OH2uh3RvgxtEWOlUCpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oYDXvN+f; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEOLGM023981;
	Mon, 10 Jun 2024 10:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=FmhsMKY9VRZDBt7z9T
	hX2z5wmJchEAJOWcoteS0TQMo=; b=oYDXvN+fJav+XWjOxDewopJK5uVYcLEOzz
	ImNfoVFw45H3EOgwD5kGR4ZyvpZKjQmG49NzrQ/FpXnNqCD4cx9HUO0pqQKz1SuA
	+W4oMlc+g9FbYSUJAeTyjvDr1ObNDwmW4D0diujZb68xToMXNe9NOmHfQrtD7q+A
	kwRp0uCMnRe9LEnJPkwd2cwDjpNVMEz/ExqfwOExlmJjuMBivA8oaZgv8AEd83bt
	S1nwrJnsjwIRqpI6d7HGsJ8EWNYtRPLT+rgysDp3J+tnVU+NYG5Rg/ultP1EYpNd
	dYi/90EcrY7G80iJhfuITf9/ClRkpdCEmEUAuIJl3weorNuRdRfA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhstn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 10:13:57 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 16:13:48 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 10 Jun 2024 16:13:48 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id A6B54820249;
	Mon, 10 Jun 2024 15:13:48 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:13:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Lee Jones <lee@kernel.org>, Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] mfd: madera: Simplify with
 spi_get_device_match_data()
Message-ID: <ZmcYK6JNAzjFAukn@opensource.cirrus.com>
References: <20240606142457.130553-1-krzysztof.kozlowski@linaro.org>
 <20240606142457.130553-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606142457.130553-2-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: aejApCCrLxPpTbOgXJWX5wnk5n1pe2Nx
X-Proofpoint-ORIG-GUID: aejApCCrLxPpTbOgXJWX5wnk5n1pe2Nx
X-Proofpoint-Spam-Reason: safe

On Thu, Jun 06, 2024 at 04:24:57PM +0200, Krzysztof Kozlowski wrote:
> Use spi_get_device_match_data() helper to simplify a bit the driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

