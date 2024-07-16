Return-Path: <linux-kernel+bounces-253489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14427932204
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA12B212B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA5917D346;
	Tue, 16 Jul 2024 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Gq2vRck/"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B93FB3B;
	Tue, 16 Jul 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119223; cv=none; b=NM4nVpvfDmkGztvUj2yeUx9PyPR5NRTbR1+PuSydHVEtGNI+Obk4kGfsl+mHw9GrZLJf7NyNR6oM5sFgawh4cpQormSP+Vh0vM36WJM1c8mhTrCG2PRW4cICmg6q+YpwLKXMdIUu+yTNU8lF+nRWxm8x8hQse1BxgzWSKo/MeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119223; c=relaxed/simple;
	bh=+cb+A396TX01g/+krPAkegLsduwSJBAoVPNUU5Z37no=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QGklHBnpj0U/kem2TJK+lB6vYv/X/1rS6AeV9wyHSRA7mr2txvb6tj8Idyq1MUU3Q2nBz06SwXEWWYm0TROujCHcrmqipk1YgcABa2WqdnUy5acvPIxSnhKJoisDoiEIGrlRIhvrXbFFJvGSA8DPkI7UYYbu6Y18n2ZTJl0eMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Gq2vRck/; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G4hlA9004722;
	Tue, 16 Jul 2024 03:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ITk2kB8sB5irsmZZA3IWAt7qcuvh9CDhBEbjd9TVeBs=; b=
	Gq2vRck/Wc9wYqV7eTMmO+E3SpDVljLtpleVSPMImSgY/I4HhEASKihLW6QwD+Nd
	ai2OI5iikP0hq+P/pZhfPZeXSVdiZsd4hX0wJb5oJqtuBEWkZgbOBQhDF51yuHSD
	38F8jxO8C9qhjXkV98aoqcvc4A6/jeg7ODvo1Lnrf43li7FU7Ve0/Pn/JuV6+p/v
	QgqU7V+zuOg6Y3fZxlKCcc4FBUIRHgPz7sJYCWTv78J/HAQpwN5eUyN3ZhCgveRb
	4LlEo4Jw33TFDt+R0yjeRT0y/u/E3v+j6sGJut4o0lRd2gCRtiJL65VAhL8sjfoI
	5K0iptwj7xZ0F900KuvvGQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40bp0jjrcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 03:39:49 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 09:39:47 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 16 Jul 2024 09:39:47 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4258D820244;
	Tue, 16 Jul 2024 08:39:47 +0000 (UTC)
Message-ID: <f551bffd-43f1-4162-9eaa-aac64ab227d0@opensource.cirrus.com>
Date: Tue, 16 Jul 2024 09:39:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs42l42: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>,
        <sbinding@opensource.cirrus.com>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240716025307.400156-1-nichen@iscas.ac.cn>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20240716025307.400156-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OGq9hTF291lQclwBhHxKYphq6Eq1Plre
X-Proofpoint-ORIG-GUID: OGq9hTF291lQclwBhHxKYphq6Eq1Plre
X-Proofpoint-Spam-Reason: safe

On 16/07/2024 03:53, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: 90f6a2a20bd2 ("ASoC: cs42l42: Add SoundWire support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   sound/soc/codecs/cs42l42-sdw.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
> index 94a66a325303..29891c1f6bec 100644
> --- a/sound/soc/codecs/cs42l42-sdw.c
> +++ b/sound/soc/codecs/cs42l42-sdw.c
> @@ -323,15 +323,15 @@ static int cs42l42_sdw_read_prop(struct sdw_slave *peripheral)
>   	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
>   
>   	/* DP1 - capture */
> -	ports[0].num = CS42L42_SDW_CAPTURE_PORT,
> -	ports[0].type = SDW_DPN_FULL,
> -	ports[0].ch_prep_timeout = 10,
> +	ports[0].num = CS42L42_SDW_CAPTURE_PORT;
> +	ports[0].type = SDW_DPN_FULL;
> +	ports[0].ch_prep_timeout = 10;
>   	prop->src_dpn_prop = &ports[0];
>   
>   	/* DP2 - playback */
> -	ports[1].num = CS42L42_SDW_PLAYBACK_PORT,
> -	ports[1].type = SDW_DPN_FULL,
> -	ports[1].ch_prep_timeout = 10,
> +	ports[1].num = CS42L42_SDW_PLAYBACK_PORT;
> +	ports[1].type = SDW_DPN_FULL;
> +	ports[1].ch_prep_timeout = 10;
>   	prop->sink_dpn_prop = &ports[1];
>   
>   	return 0;
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

