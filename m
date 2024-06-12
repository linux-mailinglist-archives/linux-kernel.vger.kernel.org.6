Return-Path: <linux-kernel+bounces-211247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909FA904EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FD71F24C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC5B16D9DA;
	Wed, 12 Jun 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UoJHKpBi"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6F2AEE3;
	Wed, 12 Jun 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183961; cv=none; b=CCu6OyiYkJQ+21an7tRzeJpxMjx+/8yjSTbtOKoMIpLjTS/edohXB5pzOAAM6N7Uq+rju1vJyrGrmYk9W4Kfh8g1jH9iTr9wtXue/BajMs4mi/mjixFT+tCBmQdN3mT6GR0rG/vrWkoVvymcr3UO/yblE3GS+MqkfJ9Pk4Ya00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183961; c=relaxed/simple;
	bh=F0A4d3hGnN6+nvgQFbeYftwbhwXUE8Wyx+tNtqKxuVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OgLf29HJnxh8e5EPuuC1X2JPvtT6zotrdtdWLLljfWxkK/FT7kVvum0s29sNmmY2MjQC+mqnDm3RuBcLVrmrA/7Jq5SdNZLJiHw5KCuYuthYTNlMKNMYTqn3Oc9wtklJatZsTyUAP3ncVRP2RQ/zD6uic/dI5KIkNssCEE81tFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UoJHKpBi; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C30uMP015315;
	Wed, 12 Jun 2024 04:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=vcNSGSbVY6Ikenk/caiUKmLsl6LeZS9uRP4qAW5SnA0=; b=
	UoJHKpBid2CjyABmHjWnr29CPJ2VooyQ+kXLs5cbbD5rKACwcuLGzoCLnMhJl86n
	+qotEEvy33oncuWIOruFyVZGWqXBKFv/4lRUCHxQUlsyx7EYNRJRwwd8cmc3/D58
	7GLtv2OvinXfA722/Tw6LOPgwSA2QxxSXMkTouNctsP6gTbAYcJ0TQsGYmop9il3
	Sny94klAYbkkUAiPmhGzKXNgBc69pZLnC8KKYascS702fqyugdI9Fc5IRpa0E78H
	E+nY1f5lWhP9wdhr6bTEYsuADFVO2wwHIWqeq0AMmQucPc6k7AgA5eOgvB/y0UsB
	A1eG2GAF3nX/wYAdsoKA/g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhutf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 04:19:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 10:19:06 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 12 Jun 2024 10:19:06 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A316F820248;
	Wed, 12 Jun 2024 09:19:06 +0000 (UTC)
Message-ID: <36219997-397b-4a26-96ee-7527fb6eb024@opensource.cirrus.com>
Date: Wed, 12 Jun 2024 10:19:06 +0100
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
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <Zmh3VmRfGEU6pGps@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vQsCTsFBVzalywJRQxJATsNxxml4b8AZ
X-Proofpoint-ORIG-GUID: vQsCTsFBVzalywJRQxJATsNxxml4b8AZ
X-Proofpoint-Spam-Reason: safe

On 11/06/2024 17:12, Mark Brown wrote:
> On Tue, Jun 11, 2024 at 03:57:46PM +0100, Richard Fitzgerald wrote:
>> If the ASP1 DAI is hooked up by the machine driver the ASP TX mixer
>> sources should be initialized to disconnected.
>>
>> The silicon default is for the mixer source registers to default to
>> a collection of monitoring sources. The problem with this is that it
>> causes the DAPM graph to initialize with the capture path connected
>> to a valid source widget, even though nothing setup a path. When the
>> ASP DAI is connected as a codec-to-codec link this will cause the other
>> codec to power-up even though nothing is using it.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> Fixes: dfd2ffb37399 ("ASoC: cs35l56: Prevent overwriting firmware ASP config")
> 
> This doesn't seem particularly different to any other unhelpful chip
> default, I'm not sure why it'd be so urgent that we'd hard code a

I'm not sure I understand the objection here. Are you objecting to the
patch itself, or that I marked it as a Fixes?

> default?  There were some other devices with things like bypass routes
> set up.  The capture path getting spuriously triggered feels like
> something that should just be sorted in general (TBH I thought that
> worked OK but it's been quite some time since I looked properly).



