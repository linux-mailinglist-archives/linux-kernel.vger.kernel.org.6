Return-Path: <linux-kernel+bounces-418172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A09D5DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C5F285DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431601DE8A7;
	Fri, 22 Nov 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CceA88AG"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09091CBE81;
	Fri, 22 Nov 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274563; cv=none; b=ThGCBCo063o84tdPFQ1LCz8Z4nNeKV607yWpI8x1B9hiwGZoUvpWGdOdCl4X/3cOT1w7X9JMV8rkAGsi1E1MA5IJ8E24+bjwvpG0njS4+uCWY90lUTqutMvIiQZQCEMHrNHNxTozCAnmbgai8Z69L7APc4bzfuFU9f3eoX7A9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274563; c=relaxed/simple;
	bh=65Ijo5vJpmhsoBymWJbToFAmSaF7qnmqSxEfKTj09cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K+fzznDZhek3R/0Yn+LZ5R9v2Yp3NBwH0XexRq5HEZrXR3v5UuLLPLnbuXir1udON/gIy0NDyMrRHiFZbZv5r7QM2bsbYUi2vnQX4SMkQVC+iWfUJw6Lx3fCLi6SQiWpsZw+VpQP+ZDlncf4P2NLz3dGF21bh/ic6GCZF82x6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CceA88AG; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM6ijhq016237;
	Fri, 22 Nov 2024 04:59:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=jRF3F/DQGOvMIPywQGKXsKFC5768SjEjQceXrbGp96g=; b=
	CceA88AGT/AUFWZZmkD2MpnolcxmVoFfPsFmxoAPjpbKG+A6su13GsM2BShfn8+r
	7iqSEce9gKl6zJ/EsjFwJa5mytpkXKmfSZWSJNdeRpJSav6j/Jkr+Ww4IG55am+R
	dTz0sSaJ3KsYo4TNGHVjDad2y+67vXEe1ZkUMpBFUnuqE2HuRaRScYO2KRAqIkf7
	gRAp2xoTu7IS6UT8pt3SvYcZmgFRJwZAtc2AosL5UNLrQzgEIxxGx0myZWq/aCuh
	YSJOE4H7XYhI8QeaE/BSXaAG2zSCCiUDYMFw0o8h5TFEQZlW50CebKO0LSsPbM6A
	iNmKH7NTe43/LwbsEZYvrA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42xrpng1mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 04:59:35 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 22 Nov
 2024 10:59:34 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 22 Nov 2024 10:59:33 +0000
Received: from [198.90.188.46] (unknown [198.90.188.46])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B228C820247;
	Fri, 22 Nov 2024 10:59:33 +0000 (UTC)
Message-ID: <de0f8e31-f1ca-4a96-99a9-45439c7463a7@opensource.cirrus.com>
Date: Fri, 22 Nov 2024 10:59:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support HP Elite Dragonfly 13.5 inch
 G4
To: Nicholas Wang <me@nicho1as.wang>
CC: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20241122044435.28061-1-me@nicho1as.wang>
Content-Language: en-US
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <20241122044435.28061-1-me@nicho1as.wang>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LAi-Qo5iH1hQE-f1cXcaswlcBlyM8Awi
X-Proofpoint-GUID: LAi-Qo5iH1hQE-f1cXcaswlcBlyM8Awi
X-Proofpoint-Spam-Reason: safe

Hi,

This laptop should have valid _DSD, which would mean that it shouldn’t need to be added into the configuration table.
I can see the cs_gpio_index field set to -1 in this patch, which should only be valid for this laptop if there is valid cs-gpios _DSD in the ACPI.
Did the laptop have some kind of issue which prompted this patch?
Is there a BugZilla for this issue?
Can you send me a dmesg log of this issue so I can investigate?
Can you also send an acpidump of your laptop?

Thanks,

Stefan

On 22/11/2024 04:44, Nicholas Wang wrote:
> This laptop needs to be supported via the configuration table.
>
> Signed-off-by: Nicholas Wang <me@nicho1as.wang>
> ---
>  sound/pci/hda/cs35l41_hda_property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index 61d231483..c97b8f808 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -52,6 +52,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>  	{ "103C8A30", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
>  	{ "103C8A31", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
>  	{ "103C8A6E", 4, EXTERNAL, { CS35L41_LEFT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_RIGHT }, 0, -1, -1, 0, 0, 0 },
> +	{ "103C8B63", 4, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT }, 0, -1, -1, 0, 0, 0 },
>  	{ "103C8BB3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
>  	{ "103C8BB4", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
>  	{ "103C8BDD", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
> @@ -467,6 +468,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "103C8A30", generic_dsd_config },
>  	{ "CSC3551", "103C8A31", generic_dsd_config },
>  	{ "CSC3551", "103C8A6E", generic_dsd_config },
> +	{ "CSC3551", "103C8B63", generic_dsd_config },
>  	{ "CSC3551", "103C8BB3", generic_dsd_config },
>  	{ "CSC3551", "103C8BB4", generic_dsd_config },
>  	{ "CSC3551", "103C8BDD", generic_dsd_config },

