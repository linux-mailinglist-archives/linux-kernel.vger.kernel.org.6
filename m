Return-Path: <linux-kernel+bounces-374021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2579A60B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AF71F22FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FCF1E3DCD;
	Mon, 21 Oct 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NXXh9/lv"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D1194AD9;
	Mon, 21 Oct 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504443; cv=none; b=nJ25a1taDlWXkonR4xSM6W9yq8dtzUPe/tVXJaRt4REbs5jZoVGV4d/bPG7V5uDrsdJmKxrB2O7Fg76+lus6moITPcm9D38/vJdmpfJ27Ae5bVH3zhFOCaVPcYCvMuGg3LPitT3Mpj+Dr8lEJyXV70ZK/PuxYv9fW9CVdWFyQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504443; c=relaxed/simple;
	bh=CIW9ZC2EyngmJGlXZEFJAvl6FtKTAOifG9n7YfxM9cY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbn+8THvGzp+XEiBRNNVchViRW7+w8sbOxaoQkWml8WQVy/MQ1tB0Ty8mr5aNCdp746p4yX1eCG5NDN/5JV8c0rb20sZxdg2ZpurfL7CBmad7Ve9Ut0LqbTvNkSmNm5+ZqdS0wNyAGXaNLbaaKExYvxxa7xWDxiZ1ThpcxLHG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NXXh9/lv; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L6u2bf011580;
	Mon, 21 Oct 2024 04:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=hM09E1+hns79M/Y0+P
	hDqXtGIDUWWbAYZx9DOPn8bWY=; b=NXXh9/lvVtt9VRlmZqmPGby7pMP+0fTjPn
	ZIN8YloNWqMW/8EItBXTNNeLRBCEiWgrSj36QzDVEEnNA8B7EBD5VhZPQ8dMbBKL
	rsn8POb+Hvkfnuxp5qxjyMlKlz6enmfoQREp4ZDd1QAcHnel7DhXZ09n2m0iachS
	q7rdpLSTWOPJV1RvTNH3UqijYZBcGvbwIli1XPzU7hkdRxiBj9ZIQBfeiWaalBcJ
	W/Yu7iotKxSTrLrvSRmjCDgL1dYx/u3ujjsUzXvCoAJYBAnDkilnsFnAC2Ks97yQ
	R9hoS43winsiVXsmaYWB+/AWRTbvClOqCwhrij2B5Ot+xBAul8nA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42c96j9jxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 04:53:46 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 10:53:44 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 21 Oct 2024 10:53:44 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 8780982026A;
	Mon, 21 Oct 2024 09:53:44 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:53:43 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>
CC: Mark Brown <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: cs42l43: Disable IRQs during suspend
Message-ID: <ZxYkpy10UxKJScHp@opensource.cirrus.com>
References: <20241014095202.828194-1-ckeepax@opensource.cirrus.com>
 <Zw0AlU9QsWpZs2Sh@finisterre.sirena.org.uk>
 <20241015143426.GK8348@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015143426.GK8348@google.com>
X-Proofpoint-GUID: vOJWK6sN6R_UZb9Hqo8RxchqtyKCQ659
X-Proofpoint-ORIG-GUID: vOJWK6sN6R_UZb9Hqo8RxchqtyKCQ659
X-Proofpoint-Spam-Reason: safe

On Tue, Oct 15, 2024 at 03:34:26PM +0100, Lee Jones wrote:
> On Mon, 14 Oct 2024, Mark Brown wrote:
> 
> > On Mon, Oct 14, 2024 at 10:52:02AM +0100, Charles Keepax wrote:
> > > The ASoC CODEC driver masks the IRQs whilst entering and exiting
> > > system suspend to avoid issues where the IRQ handler can run but PM
> > > runtime is disabled. However, as the IRQs could also be used from
> > > other parts of the driver, it would be better to move this handling to
> > > the MFD level.
> > 
> > Acked-by: Mark Brown <broonie@kernel.org.
> 
> Do you want a PR?
> 

There's no other changes going through the ASoC part of the
driver for now, so should be fine to just pull this one
through MFD.

Thanks,
Charles

