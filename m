Return-Path: <linux-kernel+bounces-531861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44242A445E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7F8188ABC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E34192B8F;
	Tue, 25 Feb 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FSosTLsX"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB218DB09;
	Tue, 25 Feb 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500589; cv=none; b=sw6zOLbybkkCwDR7/w+rALwQ75P+uk+TPWkmXVZXYf7PfNsKYoFA+nRXCh1v8hZ5T6N2lnTrqznugfpOXSzUxwOMyIeJd+kgotyi+8fY09Cx+z+PSkLdVz94gaDWXle7sNMDwt0frRC7ebgBSYznNUqokqKG/deM/ve5dzWpNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500589; c=relaxed/simple;
	bh=njrjcyJPge/h5dZ0Uk9mlzgjkTwBWMZIka8AEb5N860=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GbgGnUrDwK5nb0c5bqpHBu69NMcrpkATuDfS2o0EX0IytPWGBsjLwGO6A7fzrxQ5I6zd4ivhJsS88TtIvQB8LRL4GWl24zkgMjf8k7C3xmiKDk0DtUIIi6RvVpjIrKzm9JwsIz1tJVYaUyvC4FrvrNEiJ0xU42gtkrvpApMp1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FSosTLsX; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P4Sj4J005888;
	Tue, 25 Feb 2025 10:22:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zAI3cVRk/zYi3skFlAy3pn2KRdgiwLHEQmJNZuB9oxk=; b=
	FSosTLsXWSz3xt/uyytE7j4HYXRn7cnueCJJlG3Fz1gLTrWIa6WfkWPPEKKiMpyZ
	KJhN7zfNrvtHm88sb7maIo25jSMWUsed5irLQjKcAP2ZdgfKn/YDk64AMPA9bx8S
	Nd73k/W0vATjgWwAwRnKYPuFUzArD81YSyUrl8UQmYvSQ9ONjCjAzz+ly9+VWH0P
	pwGXHGEdMMOG4Zu+g6941lRpeu2Ftr5l5d/vmxIl6/ZUAn679TbdHfHeTr2Pgtwa
	0qs8d3ZaDqsDEMDU1J1BcWLTNnS1DozHDsocYPQVVuIpNSj9uwsvjJpdX+CoiH0d
	eP8dVM+lhONE520g0nFa5g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44ybvpy85w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:22:51 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 16:22:49 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 16:22:49 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B6A7782025A;
	Tue, 25 Feb 2025 16:22:49 +0000 (UTC)
Message-ID: <a027bb81-01a9-4658-a089-8035ae5f0815@opensource.cirrus.com>
Date: Tue, 25 Feb 2025 16:22:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] firmware: cs_dsp: Remove async regmap writes
To: Mark Brown <broonie@kernel.org>
CC: <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20250225131843.113752-1-rf@opensource.cirrus.com>
 <20250225131843.113752-2-rf@opensource.cirrus.com>
 <e2f3397b-05c0-42f7-9950-29c4d9b24350@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <e2f3397b-05c0-42f7-9950-29c4d9b24350@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HoCMG1TS c=1 sm=1 tr=0 ts=67bdee5b cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=l4K2p79tHvvzm6wvxRIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8USdONOCFGdy5sACm-iHsmNeeJuWcyGi
X-Proofpoint-ORIG-GUID: 8USdONOCFGdy5sACm-iHsmNeeJuWcyGi
X-Proofpoint-Spam-Reason: safe

On 25/02/2025 3:15 pm, Mark Brown wrote:
> On Tue, Feb 25, 2025 at 01:18:42PM +0000, Richard Fitzgerald wrote:
> 
>> The async writes are a 12-year-old workaround for inefficiency of
>> synchronous writes in the SPI subsystem. The SPI subsystem has since
>> been changed to avoid the overheads, so this workaround should not be
>> necessary.
> 
> That wasn't really the issue, it was that on systems with low numbers of
> slower cores (especially single core but there were some dual core
> systems too) there was a surprisingly low threashold where it was useful
> to overlap the marshalling of data to send to the device with
> transmitting already marshalled data.  SMP adds locking requirements
> which loose a lot of the gains, and it's controller dependent where the
> cuttoff points for interrupts and/or DMA are.

Ok. It was a very long time ago.
Do you want a V2 with a commit message that doesn't libel the SPI
framework?

FWIW switching to sync write reduced the download of small amp firmware
by 200ms on a 1.67MHz SPI bus.

