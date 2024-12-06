Return-Path: <linux-kernel+bounces-434893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8189E6C58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0336228FA12
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE248199E92;
	Fri,  6 Dec 2024 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OvlaLO0/"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363761DF978;
	Fri,  6 Dec 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481322; cv=none; b=pVaEbcZTaWJ2qIwLYByxK4VCs8T2lDfxcI39g7lK6aEZDuB6ftHadToxi+3RJiWr5mnBLFUnEl6NcEAR6jLnLYW0/lXzCB8nmdt0ydtQjB+VWe+lHkWw69vgGZwbpoXm9ph9fMmNGyBoFXCICZXGb/ylD4k8wrm78k0zo/l2wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481322; c=relaxed/simple;
	bh=UxJXuWJ5ThYOM2wpxglSc61Ze5uMCy/3edaG4WVImTk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUvJwwB9G/itToMmgy3PKHNkAkJMyqS6lmKccheDmA/LJ1QgNvmJ7UIxiGZ0LPJuLTCkZ5Sw56edPwfGK1DaZCjL1JFmYLt+AZY+t7cmK4UpVzCBifbeb/PRmoDGB6Z8hfMzNa0UpMwf6qgHLY4LZK5QmfDns2SIm0ayDqPH7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=OvlaLO0/; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B66Wwmt028165;
	Fri, 6 Dec 2024 04:34:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=3MHHGhnK5Y2zsDYRkZ
	EK/nJzMDB2uZ4a8qkD9C1qxiU=; b=OvlaLO0/aAijFVHYpTQv3C0zr5re80k0iV
	g7k3HaTiXMRYsdJkwrv/BybEiwXXTJ5MdI0XQb6zl9AFCNNzmUamHp6aJ1kIN8By
	/cCC1vUwc3z8EWQOOR3wIbs+p22msKJx/w5EVQyE0VVPvdgqQ2XimRZYxe4qJpDa
	H5AzIsjjyoUXvajR2+G9cypkjRg63JVI5VK7yw1FBkC8rFzpt/rpWDictWEzCxXW
	SKNVRMiCtxUAx68ETcu/hKPf8iAxLcoIjoB+Ap67oY76XQN5zabrMSiOLa+E7tql
	n6FNYejCjRQwgR0jNGqFZMRbwiV2xlcU7Ckw0twy69IkFwS6EPVg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43ap2bb2xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 04:34:59 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Fri, 6 Dec
 2024 10:34:58 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Fri, 6 Dec 2024 10:34:58 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id EA88E820248;
	Fri,  6 Dec 2024 10:34:57 +0000 (UTC)
Date: Fri, 6 Dec 2024 10:34:56 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: anish kumar <yesanishhere@gmail.com>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH V4] Docs/sound: Update codec-to-codec documentation
Message-ID: <Z1LTUDDJZyg1+OOz@opensource.cirrus.com>
References: <20241031211411.58726-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031211411.58726-1-yesanishhere@gmail.com>
X-Proofpoint-GUID: z4wo7ClzZH60Ie0gro7wEM0F7YTSxSHB
X-Proofpoint-ORIG-GUID: z4wo7ClzZH60Ie0gro7wEM0F7YTSxSHB
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 31, 2024 at 02:14:11PM -0700, anish kumar wrote:
> Updated documentation to provide more details
> for codec-to-codec connection especially around
> the scenarios and DAPM core details for C2C
> creation.
> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
> +Boot-up logs will display message similar to:
> +
> +.. code-block:: text
> +
> +   ASoC: registered pcm #0 codec2codec(Playback Codec)
> +
> +To trigger this DAI link, a control interface is established by the

Probably better to describe this as a widget rather than a
control interface. This widget may have a control to switch the
params but really the key point is the widget here.

> +DAPM core during internal DAI creation. This interface links to
> +the ``snd_soc_dai_link_event`` function, which is invoked when a
> +path connects in the DAPM core. A mixer must be created to trigger
> +the connection, prompting the DAPM core to evaluate path

I am not 100% sure what we are going for here with "A mixer must
be created", I think we are saying that the DAPM graph must route
into the C2C link to power it up. I would be inclined to drop
this and just mention the callbacks that get called.

> +connections and call the ``snd_soc_dai_link_event`` callback with
> +SND_SOC_DAPM_*_PMU and SND_SOC_DAPM_*_PMD events.
> +
> +It is important to note that not all operations defined in
> +``snd_soc_dai_ops`` are invoked as C2C connections offer
> +limited control over DAI configuration. The operations typically
> +executed in C2C setups include startup, ``hw_params``, ``hw_free``,
> +digital mute, and shutdown from the ``snd_soc_dai_ops`` struct.
> +

But I think those are my only remaining comments.

Thanks,
Charles

