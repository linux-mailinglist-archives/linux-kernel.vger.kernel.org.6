Return-Path: <linux-kernel+bounces-211358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F6905093
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249C11F23DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7C16EBFD;
	Wed, 12 Jun 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FDP387qa"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E16A93B;
	Wed, 12 Jun 2024 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188945; cv=none; b=NA/PmLABz2BpKUCpyaZP8iHn8N3Pa+Z4Whh5tbmnerzA4EDuclVWhw6vAzLlSG2rur5+iZrt5IoYQgluejZ3fmA+UeSqed0Wy9xtsNimqQ1QqsIiPWhWDK2tv9G+0yo4f17hITWdaOIp4lfwtbLvt7CKjpWpHpVa3GXDPvhhhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188945; c=relaxed/simple;
	bh=ysAXpRLhIcT/GOAm7v/+Clr4iJrJuvUTzEBkH6BAlaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oFn17Mywj853wPmpJ90VU7f1aGzeF1jbnLHkCQboElMNFa2f+7qEGpT1ya4wHq+el0NRkrLqAu99h1xE5qVUCOW1qvji9qa5zt2K/ARM+9OvDSBawKf9vJj2hBZx0N8wWr33e/q8gHdcZI2CqL2Qf5ZrpwWRrcsqN4xNbG6eFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FDP387qa; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C30uPm015315;
	Wed, 12 Jun 2024 05:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=GB7rgou2Iel3eL2Pod465DGSIZnJ8g2kdqSbhokKaDo=; b=
	FDP387qawdvdjsY/G6Px6OYneGHTYH3KsLCn1IlrgtmL1dl/co5vN79AI/prskd7
	JB8UrhAbzj0aRJY6G/vfZg8fhp5xS0MJvhF89Qiaed5XEFXz5UHo+Kj1jZoGt8z0
	vdc+/H/z55mIuDnRnS+szx6/G2NlO0rGKbcfVb3nhIY1BftE7B5AOKP/ZIiURhPs
	DquddngIVGznY4waLw/vyuN9LzWMIgaG8WfrfniVA+uB5l9L62O/hPzQWYO+7pi5
	/X7m6cfzXrQxjx+BE0WRvRjX8VFT/wPUvw/WtJfA+hR2u/ErHMYrVRGVTXAKTNib
	ya9yYJMuB6qWoFGDpJ4qng==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhuvrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 05:42:17 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 11:42:15 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 12 Jun 2024 11:42:15 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 941D2820248;
	Wed, 12 Jun 2024 10:42:15 +0000 (UTC)
Message-ID: <92f2d6c6-2d63-42eb-ae91-59a14831145a@opensource.cirrus.com>
Date: Wed, 12 Jun 2024 11:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI
 is hooked up
To: Mark Brown <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20240611145746.1454663-1-rf@opensource.cirrus.com>
 <Zmh3VmRfGEU6pGps@finisterre.sirena.org.uk>
 <36219997-397b-4a26-96ee-7527fb6eb024@opensource.cirrus.com>
 <Zml2FfjbO4Vgk0jy@finisterre.sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <Zml2FfjbO4Vgk0jy@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: G7tYJZmFjGeC2vFlZ_S6TRIyENKswo-P
X-Proofpoint-ORIG-GUID: G7tYJZmFjGeC2vFlZ_S6TRIyENKswo-P
X-Proofpoint-Spam-Reason: safe

On 12/06/2024 11:19, Mark Brown wrote:
> On Wed, Jun 12, 2024 at 10:19:06AM +0100, Richard Fitzgerald wrote:
>> On 11/06/2024 17:12, Mark Brown wrote:
> 
>>> This doesn't seem particularly different to any other unhelpful chip
>>> default, I'm not sure why it'd be so urgent that we'd hard code a
> 
>> I'm not sure I understand the objection here. Are you objecting to the
>> patch itself, or that I marked it as a Fixes?
> 
> Both I guess, but mainly the patch itself - we generally have an
> extremely high bar for setting defaults different to the chip defaults
> to avoid issues with differing use cases.

But that's somewhat part of the problem. There's no such thing as a chip
default for the cs35l56 because for Windows reasons the firmware patches
up all the registers on boot to setup a hardcoded use-case configuration
so that the Windows SDCA drivers can be generic and don't need knowledge
of chip-specific registers. The firmware is customized per end-product,
so the initial register state can vary.

The driver currently attempts to sync-up the mixer registers with what
the firmware set them to, which means that the initial starting state
of the ALSA controls can vary between products using the cs35l56, and
in theory even between revisions of the firmware if there was a need
to change the routing setup for Windows. We don't really need to do
that on Linux - it has a use-case manager and ALSA controls for this
stuff, and the code to do all the syncing-up adds a lot of driver
complexity. We want to remove that complexity, and instead patch the
registers back to silicon defaults - obliterate the Windows use-case
setup and use standard Linux mechanisms to setup what is required.

However, the mixer settings were already causing a bunch of log
warnings. So I decided to split this fix off so it's not dependent on a
big code revert.

I can send a V2 of this patch with this long explanation of the
background. I didn't put it all in V1 because it never occurred to me
that defaulting the mixer sources would be controversial.

