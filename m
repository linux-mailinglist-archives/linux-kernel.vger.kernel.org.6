Return-Path: <linux-kernel+bounces-208435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C4902525
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04E91F25108
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690E13D89D;
	Mon, 10 Jun 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JLlg+p4V"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038471E4A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032429; cv=none; b=gRUBXf3WkLg+viTIVi//1+lZBptNTOk00bUa6f6Yyh5OvBl4VWK+ImpMEZl3vLxz7I+HlA6Pa/LTZD/Bbq9glxYt+dqF55etxzG3wNY8Xnp07PCiQEyLE5wcTm29MEYLbrCXh4UyUdIJvPWrjzsKV99QvLMqtL2q6/1jWtmbXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032429; c=relaxed/simple;
	bh=CmL2clMiceh98ITdDb3nHytGm31ml3VGWT8md7qDVwo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIE3lWTZM4eXIXLz+zKxCo4wV8UZdU+W7zMJrvt6HEeCv3Pw7mzA0wqfdIPmvmqUB+3cu9m3/vRVrezCh+/HAIvrOHp3qG5K7dXDmtpIcruOZVaRN01CO9vP1GzZoVK9sML8f/otXYKLmWLyCyoqtDh0nvHzFFOOUB17gSRMTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JLlg+p4V; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEODuh023922;
	Mon, 10 Jun 2024 10:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=oPwV6DNi2iZ8a+TnR3
	efBN2gwSgK39HaMgBTQJnht74=; b=JLlg+p4VYPz8ilvfWSFJTE0HSrJQ4frDxh
	p2hLGcgK8M2GR2/naflIlT+9bXewM+By3kece5B6+DdnIPUCtTx400GDFS4gKOhG
	s+tjhwrg4l7I/O7a0dDYRDeskV0p+2KLt/u5l1xRiy4IHOnvMYtzqgKlVcjgH5m5
	1LpMb0/z+IUP3q8VQoYWtizbH4XxiTe4ucuzywjyv8NDJQ/5umuYy02kCJ2yIOds
	B2fXX0E0zGAbb+tlScmcmmaONuNhcEqGLeslKrl3r86s9XQLOgSButeTF/ufzqN8
	gbkFCNbHlXeA7dUlFCo3fKLY/+diVsQG01haB8WShDHUd/0lFeNQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhstmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 10:13:28 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 16:13:27 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 10 Jun 2024 16:13:27 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 16B69820249;
	Mon, 10 Jun 2024 15:13:27 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:13:26 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Lee Jones <lee@kernel.org>, Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/2] mfd: arizona: Simplify with
 spi_get_device_match_data()
Message-ID: <ZmcYFgEKgg0plA7k@opensource.cirrus.com>
References: <20240606142457.130553-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606142457.130553-1-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: ohGpH9_75i7nI5hbz6N2WSEP-b4nldDS
X-Proofpoint-ORIG-GUID: ohGpH9_75i7nI5hbz6N2WSEP-b4nldDS
X-Proofpoint-Spam-Reason: safe

On Thu, Jun 06, 2024 at 04:24:56PM +0200, Krzysztof Kozlowski wrote:
> Use spi_get_device_match_data() helper to simplify a bit the driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

