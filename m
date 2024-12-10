Return-Path: <linux-kernel+bounces-439431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155059EAF32
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96396286159
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78A2153F0;
	Tue, 10 Dec 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EmtBrXw/"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C88212D98;
	Tue, 10 Dec 2024 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828828; cv=none; b=iWmQtVbK7S/oPv5vzGKz2Ea8/RaNzWrflY64ouqFm3nTOpv1vOoxaXjJ0mvlo1+TT+TX/7J7VRkAwhm43tLzQB0nH6KS879e7hxS2zGQLzaf7p6cBN5Dt8Zx0YZYFzQbew7XwtHESFwOtBu3/RIgfiS3DRWsKE/UdZ6yIztmD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828828; c=relaxed/simple;
	bh=suGVnewTTw4T8anGYzAeJv/H2X+j5F3hcGtPHrjmOe8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk+REoI+10vklr/U+2blNcNX2YmooKjw/4/ABnXGfKJAiBuy8BuFjTqio2hwp2vG/d1gPCntj0EDMsfsz0BRu0vWaWnkg6T7102r3F2DZYwOIORhw+pv9gpmkfWSfr3X9DPRFwehGRL3j7NbsZqpG9VO3m/WorJflOiDkKvVMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EmtBrXw/; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA7xOZk007371;
	Tue, 10 Dec 2024 05:06:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=lVzLNj3rXAH+GU2UEU
	4TH+gttJpUh7a6maPob5Gu8Do=; b=EmtBrXw/AKoXGEDQvRmATBMEihecisE6rm
	69aQR8T0flW6MCvO2QVxf9nlkS/B5lOjV6Rxl6NxUXK0fz+XGJnTWDk/rp2vFYDH
	/f5T6tuBYt2UHhc7kOY2D3VgV9rucCSI+hJsX0CRraZCxXKEdtgScVNXp5764/yE
	Y2yZbZ2M5ee51B+0FaHtmKMqUPQtW0PKYQt1mSD+gED9CQpc92V3xP3oJjAPDV2Y
	TjE7Y5/0rOK/ZeCjADTOlXoZFEBKMALZ9u6SubiiaItli5V2YlDS3PRIzW9rlgSn
	D3pESVmfl0xqX+7nTgSZw/SoJN6l1p+iUzdgkanfW+/QtEx5VDZQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43cknkbddu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 05:06:43 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 10 Dec
 2024 11:06:42 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 10 Dec 2024 11:06:42 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 4FCA7820248;
	Tue, 10 Dec 2024 11:06:42 +0000 (UTC)
Date: Tue, 10 Dec 2024 11:06:41 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: anish kumar <yesanishhere@gmail.com>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH V5] Docs/sound: Update codec-to-codec documentation
Message-ID: <Z1ggwXLAu+/Y817c@opensource.cirrus.com>
References: <20241207193441.15767-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241207193441.15767-1-yesanishhere@gmail.com>
X-Proofpoint-ORIG-GUID: zCs7qdWlZtgdbJwj1Ze5H-CzHxXoNLnf
X-Proofpoint-GUID: zCs7qdWlZtgdbJwj1Ze5H-CzHxXoNLnf
X-Proofpoint-Spam-Reason: safe

On Sat, Dec 07, 2024 at 11:34:41AM -0800, anish kumar wrote:
> +Boot-up logs will display message similar to:
> +
> +.. code-block:: text
> +
> +   ASoC: registered pcm #0 codec2codec(Playback Codec)
> +
> +To trigger this DAI link, a control interface is established by the
> +DAPM core during internal DAI creation. This interface links to
> +the ``snd_soc_dai_link_event`` function, which is invoked when a
> +path connects in the DAPM core. A mixer must be created to trigger
> +the connection, prompting the DAPM core to evaluate path
> +connections and call the ``snd_soc_dai_link_event`` callback with
> +SND_SOC_DAPM_*_PMU and SND_SOC_DAPM_*_PMD events.
> +

I am still not really following this, what are we trying to
convey in this paragraph?

What do we mean by a "control interface" here, is that referring
to the kcontrol that is created to select the rate in the case
of multiple rates? Or is it simply refering to the fact we call
snd_soc_dapm_new_control_unlocked? But really that function is
adding widgets, as I noted in my last email.

Also what do we mean by a "A mixer must be created", I am not
aware of any requirement for a mixer? The DAI link needs to be on
a valid DAPM path, but I don't see any requirements other than
that.

Thanks,
Charles

