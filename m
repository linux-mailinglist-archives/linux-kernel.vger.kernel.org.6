Return-Path: <linux-kernel+bounces-266187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBA993FC28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C64283757
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED61662EF;
	Mon, 29 Jul 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dIfKZgdj"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73787158D63;
	Mon, 29 Jul 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273264; cv=none; b=OhQrcpjiMoTqWDRTbt4qpbaWQaORaNDA5JP2tOPr4x1cRyDG9gpmdR+72T5qXvTY92quR3eeslfxC3DA0paEOGnEFYOXCNxa7/a+H8c+NHkTz7VddSqEdez/j3iz4Fnd3xBuSjK4zWRVqs/K936hj7YgSExuqn4Tc7htfMj2+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273264; c=relaxed/simple;
	bh=k6ksBZ8+yz65X/L4HiwrGsPSjDnf1yKvvTsD+2UxvV4=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kfFcCY9Yy36vbhUaf0CjzrSAraZlLaDOw8qpCLPIzMOXLrWrH7zQBHjrfMiYuY1t0brSggT38as1+CP+Lav9pA13MPedZdmy7waGCbba+aEgfA8DajhaljjkDQ/TgcegJyK4m0jg6Ygc7l7Qa6cG5QIFx997d2C89ab/MefPVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dIfKZgdj; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFFcrO019068;
	Mon, 29 Jul 2024 12:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=1FFP2i5VBb8mE8rlotGa2erv9oQ/ADnp9DnG2pdUJnU=; b=
	dIfKZgdjTS1we5G6s81FhKX1NYb7si5jsGyV3LquTxTC4pafTzTajGcJFUV7CzZU
	Q8/pgBoqdmwzHWNzY0TEBgVcaKWWVSEd9BpvLUvka68XKheiBJkoT8AnkgsgkOxN
	KP0C264GXLwbab04h1kt5IU/q7RGJ7gEG8ExtJZ944uof2Acw77FK3E6tNshscl6
	6M9YN39hQkqrONEIZg6ZHloXyZPlQ7oYZlKIRgWVpec1A93mlrIDNKd1dhIjmNK8
	borMM4ZJCvLOv0nPiPIHBOZKoWFIJ8Iory299asfbq7gUqHO5bGmxJ3u+WrdxbiX
	mD+JqgaCljzUfRISKY2Duw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40mwajtd9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:14:15 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 18:14:13 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 29 Jul 2024 18:14:13 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8D108820244;
	Mon, 29 Jul 2024 17:14:13 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240729161532.147893-1-simont@opensource.cirrus.com>
In-Reply-To: <20240729161532.147893-1-simont@opensource.cirrus.com>
Subject: RE: [PATCH] ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients
Date: Mon, 29 Jul 2024 18:14:13 +0100
Message-ID: <019d01dae1da$bc32b1d0$34981570$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQEcFAlpKboO1qvXEI+3RGtpBQpfeLOLjSvw
X-Proofpoint-GUID: BNXFBh-k94F6vNGNUKZDZtnSWk1xHSIu
X-Proofpoint-ORIG-GUID: BNXFBh-k94F6vNGNUKZDZtnSWk1xHSIu
X-Proofpoint-Spam-Reason: safe

Apologies Takashi - can you ignore this one please? It will need a V2

> -----Original Message-----
> From: Simon Trimmer <simont@opensource.cirrus.com>
> Sent: Monday, July 29, 2024 5:16 PM
> To: tiwai@suse.com
> Cc: linux-sound@vger.kernel.org; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; patches@opensource.cirrus.com; Simon Trimmer
> <simont@opensource.cirrus.com>
> Subject: [PATCH] ALSA: hda: cs35l56: Stop creating ALSA controls for
firmware
> coefficients
> 
> A number of laptops have gone to market with old firmware versions that
> export controls that have since been hidden, but we can't just install a
> newer firmware because the firmware for each product is customized and
> qualified by the OEM. The issue is that alsactl save and restore has no
> idea what controls are good to persist which can lead to
> misconfiguration.
> 
> As the ALSA controls for the firmware coefficients are not used in
> normal operation they can all be hidden, but add a kernel parameter so
> that they can be re-enabled for debugging.
> 
> Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic
CS35L56
> amplifier")
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---
>  sound/pci/hda/cs35l56_hda.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
> index 96d3f13c5abf..1494383b22c9 100644
> --- a/sound/pci/hda/cs35l56_hda.c
> +++ b/sound/pci/hda/cs35l56_hda.c
> @@ -23,6 +23,10 @@
>  #include "hda_cs_dsp_ctl.h"
>  #include "hda_generic.h"
> 
> +static bool expose_dsp_controls;
> +module_param(expose_dsp_controls, bool, 0444);
> +MODULE_PARM_DESC(expose_dsp_controls, "Expose firmware controls as
> ALSA controls 0=no (default), 1=yes");
> +
>   /*
>    * The cs35l56_hda_dai_config[] reg sequence configures the device as
>    *  ASP1_BCLK_FREQ = 3.072 MHz
> @@ -758,6 +762,9 @@ static int cs35l56_hda_bind(struct device *dev, struct
> device *master, void *mas
> 
>  	cs35l56_hda_create_controls(cs35l56);
> 
> +	if (expose_dsp_controls)
> +		cs35l56_hda_add_dsp_controls(cs35l56);
> +
>  #if IS_ENABLED(CONFIG_SND_DEBUG)
>  	cs35l56->debugfs_root = debugfs_create_dir(dev_name(cs35l56-
> >base.dev), sound_debugfs_root);
>  	cs_dsp_init_debugfs(&cs35l56->cs_dsp, cs35l56->debugfs_root);
> --
> 2.43.0



