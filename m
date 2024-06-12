Return-Path: <linux-kernel+bounces-211308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1115F904FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201BC1C21599
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB4A16DEDD;
	Wed, 12 Jun 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Efyl2+vv"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC60A34;
	Wed, 12 Jun 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186269; cv=none; b=k0A/Y3aPS3u4FHa4GwWhCilvl/Cs6EwvDxTD3XxRAyQ4/y2zfzyIgpUhN8br4WY01Kv007eiRI2TIqXhXs+nObU0RU2o36pkfjX3hcR7MbK/8F22Zolh/G6uCD4ddK//gOibqu6xHtJCVMBtgd80xFWkdPxxbHL6LdOCP0Sflbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186269; c=relaxed/simple;
	bh=iThV4k/VSpUxzzcfw2ggt5LI471Y/PmXZJjWEJdwVjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0bm+AgISN34QqeIC5pTgBxGNlHJIvoUP3LSZlV7oHbL0EvNWtN7gyLaNFE4/3+230/dtLlbCnuQEFh1glIOTyDoN+3V0k7Nzlf+P5uRUxdAihINeSd1Mvk5TwY6JwULFb80eXykZbuFk0S6Ur1THTOayCjNeBgyU1lU/w/5diY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Efyl2+vv; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C5ADfm014989;
	Wed, 12 Jun 2024 04:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Q8uuLceiRabcfzSggO
	IFKi2cARAPS+Lac4yeJDIRirc=; b=Efyl2+vvP4+iaGprZsgRLJSz1wjF5TN/2O
	AVmvFIHdl3tNrvzioe4cAnsRDvbBNWJ3uIXrRTuTnjQZ9Hc1NfvXNNIjML5GZT9L
	Rb5eVXwANuYkp0uzXbhs1jJIAZCl2XSb1MjAjpesyfHMgkQuae+/6svzdATLcIXM
	UmR5s1fnKwTIBBD0jdy8vcItBpmUmjYcHmGls3AiP3ONxweu3e5AUCmJBh7i6sSC
	3ffRF3yPqG2QJzBqkYq2MoidGZjZRGSHXePhE8J4VreyA3/bUdxiydBqqGhYW5lo
	e0ng96aZ4kmOOE952wp2Tv9Ih9sMYvMCnQJ7SiSDoAr6M+hMKmtw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ymmq0bpb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 04:57:29 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 10:57:26 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 12 Jun 2024 10:57:26 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 5A7D8820248;
	Wed, 12 Jun 2024 09:57:26 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:57:25 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
CC: Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: wlf,wm8782: Convert to dtschema
Message-ID: <ZmlxBSPro1GtWx3Z@opensource.cirrus.com>
References: <20240611124405.63427-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611124405.63427-1-animeshagarwal28@gmail.com>
X-Proofpoint-GUID: G-Ki3PCoe0PhLSbnIzZ6qAfxCTOxwcUk
X-Proofpoint-ORIG-GUID: G-Ki3PCoe0PhLSbnIzZ6qAfxCTOxwcUk
X-Proofpoint-Spam-Reason: safe

On Tue, Jun 11, 2024 at 06:14:00PM +0530, Animesh Agarwal wrote:
> Convert the WM8782 audio codec bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

