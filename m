Return-Path: <linux-kernel+bounces-210309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52D90422D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD928A2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED94502B;
	Tue, 11 Jun 2024 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fYjpVsu3"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AA4D131;
	Tue, 11 Jun 2024 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125863; cv=none; b=Bi8QiaX8b6deXYDRwq6+igQumdEeJUrVGvFxF7/TChoxnfM2vWg54fXHMKAoGKaSkxerJb+dnZlBi59LcTTGH7OzaUI+ewH7za3h3YIAO82s6WWIbhR03+VV2SROpRSiP6Q/QKCUh1CZCBXpr90UWug7HGEKXP+7bqZZvWtVATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125863; c=relaxed/simple;
	bh=bJBl+PlfjanSE1Eg6G1C2wEirLeTb7Y9hb7ms4wt5Sk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWXGuIw4kET0Hjyq92AWWmuhH1J4dEFh/Z3X1Tw9SQogbyfm278Gn2KnnJmChjFc5L6ZcRkw8iQ0mUQEC7KQES1vNiER+qsxNtIGpaBm4nYIUqbz+PUX3kzMAE7X+RYL2WhNE6Z08O1NQzonp+egqfKkj1jMqPH82AxJA1AWsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fYjpVsu3; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B4c4ag010402;
	Tue, 11 Jun 2024 12:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=BIhOXmsqkEoOXO78P5
	ESWns7BwfqoAGaVVQe7oaV3Gs=; b=fYjpVsu33NhFd/aKifFg+mfk/OadJZMqHn
	8QrckYPYp9zNGG/mOMSwDnXlR14bxHBw8pj9DJwOu1v9SIy3cwAqcJwzE6bBX5dE
	/1jE/4plaPbR4AN5nFtld9iiTTjLlwzi35jH24448VquZr514jusiNo7lFNQ4QFR
	6D2/2vRImyPtKCiwy0M0YGEkGRLOHxoGXbRiAQMTAhTeOwxOPv0LD83vaqAS4Ddj
	6DzyMhwLrKKDXHPZCTjKLoUYnSnGXAgS4B4rM5KScyrgaP+sCELHouz+QKzgizz9
	Ar3/RKnDaahH8HI+bjmgwxVKeH8K2ziUnoTMblrW7wggXzRXjo6Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhu5ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 12:10:43 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 18:10:42 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 11 Jun 2024 18:10:42 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id E56F5820244;
	Tue, 11 Jun 2024 17:10:41 +0000 (UTC)
Date: Tue, 11 Jun 2024 17:10:40 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: Richard Fitzgerald <rf@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI
 is hooked up
Message-ID: <ZmiFEAw/IkkLWx2O@opensource.cirrus.com>
References: <20240611145746.1454663-1-rf@opensource.cirrus.com>
 <Zmh3VmRfGEU6pGps@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zmh3VmRfGEU6pGps@finisterre.sirena.org.uk>
X-Proofpoint-GUID: _J5zIlRbkHY3ImhYwjrPmJug-zBav0AV
X-Proofpoint-ORIG-GUID: _J5zIlRbkHY3ImhYwjrPmJug-zBav0AV
X-Proofpoint-Spam-Reason: safe

On Tue, Jun 11, 2024 at 05:12:06PM +0100, Mark Brown wrote:
> On Tue, Jun 11, 2024 at 03:57:46PM +0100, Richard Fitzgerald wrote:
> > If the ASP1 DAI is hooked up by the machine driver the ASP TX mixer
> > sources should be initialized to disconnected.
> > 
> > The silicon default is for the mixer source registers to default to
> > a collection of monitoring sources. The problem with this is that it
> > causes the DAPM graph to initialize with the capture path connected
> > to a valid source widget, even though nothing setup a path. When the
> > ASP DAI is connected as a codec-to-codec link this will cause the other
> > codec to power-up even though nothing is using it.
> > 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> > Fixes: dfd2ffb37399 ("ASoC: cs35l56: Prevent overwriting firmware ASP config")
> 
> This doesn't seem particularly different to any other unhelpful chip
> default, I'm not sure why it'd be so urgent that we'd hard code a
> default?  There were some other devices with things like bypass routes
> set up.  The capture path getting spuriously triggered feels like
> something that should just be sorted in general (TBH I thought that
> worked OK but it's been quite some time since I looked properly).

Mostly the problem here is it causes a bunch of errors in the
kernel log. The cs42l43 can only be clocked from the soundwire,
and the rate of that is only passed to the cs42l43 when audio plays.
When the ALSA control restore runs, you end up with a temporary route
(cs42l43 VMON -> cs35l56 ASP -> cs42l43 ASP -> cs42l43 Speaker). But
as there is no audio at that point there are no settings for the
PLL. I don't think it causes any lasting issues, but it does cause a
bunch of fat warnings in the log which people then complain about.
Plus also having things not routed by default is just nicer,
especially when the defaults are things that are an actual source
so likely to cause things to power up inadvertantly.

Thanks,
Charles

