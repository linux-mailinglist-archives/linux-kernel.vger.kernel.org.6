Return-Path: <linux-kernel+bounces-171271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF818BE20A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A681F249A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A03D15CD75;
	Tue,  7 May 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dj+djPZm"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20E15B995;
	Tue,  7 May 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084704; cv=none; b=VtccfAYZQ0qjKj1ZkTc+oE1ee4u75SOv2ZSP/kW66Ym9jzlE9RMEtggKq8IXzt4NbGltrDkRYUmXbtuT48dwyzlFvThWXMAVIKC1TcWoHjP9GrWmFllUenVC8kyynv1l0usR6Fdam2tkuWw11igTNMNrCE9NHEhY0Ko/gMsyWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084704; c=relaxed/simple;
	bh=7SblqolKjySmEc6V7cBH+cBlOqX473FOdbBoGQaq4bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMo+Ylvgm8p3tlpsLDi55vG+FA1vWY3SMkeAuOZILkzCVdgZIheg8cDSsXxr0BwNqQZkFAs/NuTQ0fYPbsrwKtS7LCO/DNqp5N2dZlZQzorCDwtqNm2a9v5H7Yv1kRrOMJnfrk+yzCVDVCUI1kxH7vEc1XFREfcCgIuQmWjcSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dj+djPZm; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4475oO0n004102;
	Tue, 7 May 2024 06:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=ftBlVY/8+8MJLqv
	he1wF4ZSuv2MhawQfCqt8ygN3VQI=; b=dj+djPZm7UuJ4P1+gdmrC6npbftpIzV
	Cn7oGOBQ94BeHYmQqp5rYZKlYgM6FZqeYDcR0h4yd2qreGTqIAQFKVvlZe51PSn5
	fEQEUE28InOBFMIi7968yoZkf1ecC/VLfi0Wa6UFogK6XdidF5inddpDg+ZBy5Pj
	yJs6PDiB+QDDarDxVILc53kk6pslk4FY7Sm5CZJWddfSLoTtXIrk2SVOXtLlwMew
	D3YprLNu8d+EHHyfaDiirnemaycRdSUB4Lg+wCPFoSWYmL2+WNGXYkPnu2UcNgHy
	Q/r7wIyubU0Csb6k0N7Oa6i30Lwmx9pmDSAl2j9uAPuPdcAIKsphE/w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xy2cmh154-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 06:57:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 12:57:11 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 7 May 2024 12:57:11 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id F1C16820244;
	Tue,  7 May 2024 11:57:10 +0000 (UTC)
Date: Tue, 7 May 2024 11:57:09 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Liam
 Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Lars-Peter
 Clausen" <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ASoC: Constify channel mapping array arguments in
 set_channel_map()
Message-ID: <ZjoXFedPicgq8fyP@opensource.cirrus.com>
References: <20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org>
 <20240507-asoc-x1e80100-4-channel-mapping-v1-1-b12c13e0a55d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240507-asoc-x1e80100-4-channel-mapping-v1-1-b12c13e0a55d@linaro.org>
X-Proofpoint-ORIG-GUID: _LFPFoz0pvkHmcCFOZwADU6UMjJP1mf7
X-Proofpoint-GUID: _LFPFoz0pvkHmcCFOZwADU6UMjJP1mf7
X-Proofpoint-Spam-Reason: safe

On Tue, May 07, 2024 at 12:27:30PM +0200, Krzysztof Kozlowski wrote:
> There is no need for implementations of DAI set_channel_map() to modify
> contents of passed arrays with actual channel mapping.  Additionally,
> the caller keeps full ownership of the array.
> 
> Constify these pointer arguments so the code will be safer and easier to
> read (documenting the caller's ownership).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  include/sound/cs35l41.h                 |  4 ++--
>  include/sound/soc-dai.h                 |  8 ++++----
>  sound/soc/codecs/adau7118.c             |  6 ++++--
>  sound/soc/codecs/cs35l41-lib.c          |  4 ++--
>  sound/soc/codecs/cs35l41.c              |  3 ++-

For the cs35l41 bits:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

