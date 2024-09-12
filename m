Return-Path: <linux-kernel+bounces-326733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA32976C53
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2161C2362E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B41B4C21;
	Thu, 12 Sep 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Sy3Jg3KR"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C71AD25D;
	Thu, 12 Sep 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152129; cv=none; b=QKGIOdBUl9FZGHewWEahhONqcIllxhGe49hitJQiodTft/J35ndn25/0QZSh9OrPU+irAnMpEN2xdB/5L+26QsHKGGn7mDy7Sf2uq87J+8xQAS6huAkFj7we98C/dDPZNLZFbljqNP/t0RfdTsq7VbV+xT993w189J2MaSf+9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152129; c=relaxed/simple;
	bh=T+OWrNoIs5BCtbUkYQfXZniHPmlZ45gy1qVQ3T0ew6I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb4rc/y9jLfKiJhzmMP6opxy0sT1lCHd57O16Tr/Pk/7btFXl2opaLiN1TqZEC0QRhwgwI3a/tCOSlsOiAWT47a/LNH/rnPYfPmVzqthCPwKBlvuSf4pFIvuufF4Q4OutLlat6CLfHAE0YuDF3yo3eMHjD6wzPQybuLNxWB9F8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Sy3Jg3KR; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CBd5o9001157;
	Thu, 12 Sep 2024 09:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=4+PRiUSNYnock2lwwj
	VFDAM/iZwI9ar50XC9d7K15I0=; b=Sy3Jg3KRAg+9dhN1sIKxW4Kzjdw1AzdtBv
	eDprWWHIrVfzNVFe42Hrxo/0/g8IoW6YZQz4KqwIBxIFp8m3IVIQD8ZqGAX7Lc7Y
	kI6jecGBdnok/1omq9+htpV6pV7FWGNBWsQPI+TkUASJCDHaalUPP96akDDS+8V2
	r+tEANyzuBNjzp4DvuvUmAuKLDFf3TtTlTG0/KtGgJuL66TIWpLPXZJbaaO5eULf
	4yJ9+ahevAJVaU/7JEGP94NnOAo0D3PV3CpQQg5SApyEwb6XpP+P2qHDQpBAFNlz
	RQrZ0KKLmQu+4f3VIalgmNTEfWTyhh+8+vKyPfWBrWnpvn4vIEyQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 41gm7x5h6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 09:41:50 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Sep
 2024 15:41:46 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 12 Sep 2024 15:41:46 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 1C89982024A;
	Thu, 12 Sep 2024 14:41:46 +0000 (UTC)
Date: Thu, 12 Sep 2024 15:41:45 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
CC: <linux-sound@vger.kernel.org>, <vkoul@kernel.org>, <vinod.koul@linaro.org>,
        <linux-kernel@vger.kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <bard.liao@intel.com>
Subject: Re: [PATCH v2 00/14] soundwire: mipi-disco: add partial SoundWire
 Disco 2.1
Message-ID: <ZuL9qSMTG8rBr680@opensource.cirrus.com>
References: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
X-Proofpoint-GUID: 1SNr4TgtuVXos-nIPVrDfdEDZUmzXtTr
X-Proofpoint-ORIG-GUID: 1SNr4TgtuVXos-nIPVrDfdEDZUmzXtTr
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 11, 2024 at 07:58:13PM +0800, Bard Liao wrote:
> This patch series adds partial support for the SoundWire Disco 2.1.
> 
> v2:
>  - use mipi_device_property_read_bool() to get "mipi-sdw-sdca-interrupt-register-list"
> 
> 
> Pierre-Louis Bossart (14):
>   soundwire: mipi_disco: add MIPI-specific property_read_bool() helpers
>   soundwire: optimize sdw_stream_runtime memory layout
>   soundwire: optimize sdw_master_prop
>   soundwire: optimize sdw_bus structure
>   soundwire: optimize sdw_slave_prop
>   soundwire: optimize sdw_dp0_prop
>   soundwire: optimize sdw_dpn_prop
>   soundwire: mipi-disco: remove DPn audio-modes
>   soundwire: mipi-disco: add error handling for property array read
>   soundwire: mipi_disco: add support for clock-scales property
>   soundwire: mipi-disco: add support for peripheral channelprepare
>     timeout
>   soundwire: mipi-disco: add comment on DP0-supported property
>   soundwire: mipi-disco: add new properties from 2.0 spec
>   soundwire: mipi-disco: add support for DP0/DPn 'lane-list' property
> 
>  drivers/soundwire/mipi_disco.c | 144 +++++++++++++++++++-----
>  include/linux/soundwire/sdw.h  | 200 +++++++++++++++------------------
>  2 files changed, 206 insertions(+), 138 deletions(-)
> 

Series looks good to me:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

