Return-Path: <linux-kernel+bounces-384667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209AE9B2D05
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CCC282A59
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF431D433F;
	Mon, 28 Oct 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="o7v6jURI"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0E1D270B;
	Mon, 28 Oct 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111926; cv=none; b=F5jqgjsJ1kyWBmASZHu19v8a7vfNcrPI9GGTBQGs8Ono6dY2XbPQPdKBNbHn24U8Uv1T9q3i5nCiLGlOAnvlMnnVsJS7OIOIkfocVM1x77SfVNlChGjRxjk60p5xTGU1X/JCMk31yBOjHH2sLghSIiiem8e3hBcrpw9UlKCVGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111926; c=relaxed/simple;
	bh=wzdsu2j4UjuiVcgocXfHDpRtIlfWStfryai7a9e1h9w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv8ji6vEcjDeW4OxkAPaGBafK76Nu1djUuUxrsLF6oxDRDOhFooUAFWEv6KLybNBqJU8fRN+aGqqiF3r+7rln+Gmn6J+yKyjs9tk/kkavgLmOeOPwEiCiGEA2kfJO4EE7VPp2BuLPDpvhDPilFi4Db/cMMJ2RYQyel84GG9CFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=o7v6jURI; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S80mfh026238;
	Mon, 28 Oct 2024 05:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=/WeVNuKv2qeq8LI2dz
	MNVIh7KIor3At70uWYTMRemZk=; b=o7v6jURIdptaXzuhZjAMcW9Bd9JhZ8HXdp
	XAVYL3bNgnLMOjOFKQHqFGE88TLRRQv0FYT2g+3hkpww/ANppWLY6DzlKR6SUe4c
	TUtQV3Pjgjj+GVDH1aAKcJzpWS5gSPHJqz8qf3KhOesj6kxbhInwRdzfH2eXytND
	8Vt6+QHElGukHK6fzUyHjMuWwuswKRMj5+MWllLubM0u9xi6zTJu0W/1KJim7bAu
	plORmcBD+mgsjrdn8MTqwdaQBTvNxGzGKFe4i9mPw8i2By9lVpkq8MKzKBAIZYwb
	LRfpZ7Ker/Dv6fhWo6iT/9vTQtomYnkJTEdRu2Mswl7CsPL1+m8Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 42gwtvsq2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 05:38:18 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Oct
 2024 10:38:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 28 Oct 2024 10:38:16 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 686F6820241;
	Mon, 28 Oct 2024 10:38:16 +0000 (UTC)
Date: Mon, 28 Oct 2024 10:38:15 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Olivier Moysan <olivier.moysan@st.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l51: Fix some error handling paths in
 cs42l51_probe()
Message-ID: <Zx9plzaiLcObb6PT@opensource.cirrus.com>
References: <a5e5f4b9fb03f46abd2c93ed94b5c395972ce0d1.1729975570.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a5e5f4b9fb03f46abd2c93ed94b5c395972ce0d1.1729975570.git.christophe.jaillet@wanadoo.fr>
X-Proofpoint-ORIG-GUID: PKqJLKztO8jDcUeYX2R4iikGQC1njIQG
X-Proofpoint-GUID: PKqJLKztO8jDcUeYX2R4iikGQC1njIQG
X-Proofpoint-Spam-Reason: safe

On Sat, Oct 26, 2024 at 10:46:34PM +0200, Christophe JAILLET wrote:
> If devm_gpiod_get_optional() fails, we need to disable previously enabled
> regulators, as done in the other error handling path of the function.
> 
> Also, gpiod_set_value_cansleep(, 1) needs to be called to undo a
> potential gpiod_set_value_cansleep(, 0).
> If the "reset" gpio is not defined, this additional call is just a no-op.
> 
> This behavior is the same as the one already in the .remove() function.
> 
> Fixes: 11b9cd748e31 ("ASoC: cs42l51: add reset management")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

