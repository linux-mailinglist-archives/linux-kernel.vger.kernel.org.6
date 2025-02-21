Return-Path: <linux-kernel+bounces-525533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E2A3F0F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED80B188A099
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D8205AD9;
	Fri, 21 Feb 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c9CW/cbQ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65F204C23;
	Fri, 21 Feb 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131216; cv=none; b=qc/YDGeuIpDAqaoX/FZNKqQJZ5WHBHauGbPAJOMMPVdLir+8s6zjGwQgth6yi2FWlSYi8HrY8cOJ/6wjGWNcEpNqHu6ahwZBSM9zUcOMXlwpklgQig6/wPnqwbiDfL7WdHOz4URY++YgvZSYBvVtkVcwfXn9mIjGbFO4PvjE/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131216; c=relaxed/simple;
	bh=zf1SyORZqfZjkffuYXcPmbuH1XsivG8HNOpibUwyJd0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2UM/C28+TR04AO0jwQ5/ZSURcH7SSm6IHT4u2WUaIj+OpmQgcW9ppBlCOhbrIPb3EfRnYrRjo6uZAVJZ3jRZmX94ZFIXGvyD5CP9C8/nMZVNIIhbaOz12NpAdzJcOjbOPnCmqJ0i0xgAtcmofWj1yKSLKfB8PXjZgIwXURPzmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c9CW/cbQ; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L6jgZF013439;
	Fri, 21 Feb 2025 03:46:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=kUXpsxt39/VziyhmUX
	TXA0VmtdZKPc6S0GNSpJjMKek=; b=c9CW/cbQMnC1eifeuLXSEXgXwExxtRQ0dx
	7j1h8JMLeOInLC3HHite1vVEDEUDrBx/HCuSmvQL+Bup+vVjxWPUPwGMl8V8tH7B
	DMoDRCCaEqc4ubr59+GGms9wBfYkdm9IKDXCRxCGDeQI5p5Ymx/ZHr9088nxMw6f
	btDoNMXgrdAR0utt1Umk9UHUaaFFir8AkoWhZlNbNuPOaDlJ+VhmRi5p3CnHGYF8
	6OLnrZ/HYcb3uRmIyBdRuRuSSfRthV3AEB0UcFk+b6y7SQ2YTRSg1ss56hXecJsB
	VNBrdvkY23RFeJ3WM1OHAU8gxahdKpWWvkkRsgiRUlR2j9QNMUog==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44wjcamjv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 03:46:29 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 21 Feb
 2025 09:46:28 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 09:46:28 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 20908820248;
	Fri, 21 Feb 2025 09:46:28 +0000 (UTC)
Date: Fri, 21 Feb 2025 09:46:27 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
CC: <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add SDCA register map support
Message-ID: <Z7hLc647A8wUIQtO@opensource.cirrus.com>
References: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
 <8f0f70de-d3cf-4956-a5aa-c5bed91a61cf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f0f70de-d3cf-4956-a5aa-c5bed91a61cf@linux.dev>
X-Authority-Analysis: v=2.4 cv=aplICTZV c=1 sm=1 tr=0 ts=67b84b75 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=4Vqx6HtD56EmJ5slJp8A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: uwfMfv4jYVSXbopqAuSshCoMsxoKDdJU
X-Proofpoint-GUID: uwfMfv4jYVSXbopqAuSshCoMsxoKDdJU
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 20, 2025 at 07:01:44AM -0600, Pierre-Louis Bossart wrote:
> On 2/17/25 08:01, Charles Keepax wrote:
> > This series is the next step of adding SDCA support. Here we add
> > helper functions to allow drivers to easily use the SDCA DisCo
> > information to create a register map for the device.
> 
> Can you remind me where we ended-up in the discussion on one
> regmap per physical device or one regmap per function?
> 
> The DisCo definition are all function-centric, but the physical
> SoundWire bus access for all read/writes is shared by all functions
> so having a single regmap isn't silly either.
> 

We haven't really fully resolved that yet, however, I have
came to the conclusion that all the helper function bits I am
currently adding are completely agnostic of the choice.

So I think it makes most sense to address this once we are adding
an actually driver component. That way we will have the most
context for discussion.

Thanks,
Charles

