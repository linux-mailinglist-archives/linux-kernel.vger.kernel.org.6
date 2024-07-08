Return-Path: <linux-kernel+bounces-244528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40A92A588
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384A52810B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8301411D7;
	Mon,  8 Jul 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NpY2jbAh"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B076035;
	Mon,  8 Jul 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452176; cv=none; b=GqFif+JiomflED4VEZ7ePzkO2HnASGCw0A1EemH0h2u5GS+BF+ZGuptsScjoM29FrBPWToAstTQfUJ9xoBO2dFv2hRVWTBcWbvzBBsgJ71IWxfGrK9EaaT/jh7os6A+giOo8FPNdAI4TUKElUUt53v5U27lpi4y9Reh5xppcj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452176; c=relaxed/simple;
	bh=h2njFu7TIEqrPdpwvjFWiI7tGVMwAAs6ckdpT7Is0tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mLiYm6/EIOv18mOIa/7f0lQiVl0IY6GAdq/11UXL0tLM8cN8fiUscbh5db+hp/l7gUbAI+GS5ZVvxTASJFwTv7NB0to3A3EhxdnYnjUqAHj70Tgt2a6tVZLl8Gdbdd5VWJUIhYFmHKUjw9ugmIT5NyeKfD/paS1CyWTG/VoYKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NpY2jbAh; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687FtcM021773;
	Mon, 8 Jul 2024 10:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=qkDw+gdhuVNaP7dtZkKOvbQQm2hXZrgeSjCzU4o42SM=; b=
	NpY2jbAhljbmxh+Whldsp/+pbGX/MngLOYpFAhyGttlgXu40dxAMTy4IVa4cnGgu
	Cy5lL2hG2sQdk3YWJ8cEfioYYAG+16kA6h5nEc2h1FSoAMnkqzonsmR7g8RgGBtV
	Sffe5OPIxW7vOgvzln9lMuTC2vkzKt4nVe+Cq5r917WyFzjRTq1fr40b/IFBTKTo
	V6vTJlRSv3T1P8CMh45hBD9Blyfe0mt+6SFapUotmUIQdmlGxHCDtYqcwpTdGHBp
	yR5jRBbTHoDHGD/oucGmLNLRzf3QqJ5z3nE7sCv0uF/+mLfw2yzL+jXlWndrs0Ou
	YBcKxclhZ1hiESAiehLAFw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4072bj9ndy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 10:22:47 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 16:22:46 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Jul 2024 16:22:46 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0CF91820244;
	Mon,  8 Jul 2024 15:22:46 +0000 (UTC)
Message-ID: <27d74268-53ff-4248-8d3d-71948ffcf68b@opensource.cirrus.com>
Date: Mon, 8 Jul 2024 16:22:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw
 files
To: Mark Brown <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20240708144855.385332-1-rf@opensource.cirrus.com>
 <de44f274-4e02-4c66-b784-41031e99c33e@opensource.cirrus.com>
 <91fc7cb3-6a00-4b3b-abed-a3a41b191912@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <91fc7cb3-6a00-4b3b-abed-a3a41b191912@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C5Xpfo28h2Z8MSXKe7cFaebQnU94j1ko
X-Proofpoint-GUID: C5Xpfo28h2Z8MSXKe7cFaebQnU94j1ko
X-Proofpoint-Spam-Reason: safe

On 08/07/2024 16:05, Mark Brown wrote:
> On Mon, Jul 08, 2024 at 04:00:07PM +0100, Richard Fitzgerald wrote:
> 
>> Don't take this. It applies to 6.11 but not to 6.10.
>> I'll try to sort out one that applies to new and old code, or
>> send separate 6.11 and backport versions.
> 
>> Sorry about that.
> 
> git seemed to be able to figure out the context for 6.10 (I apply
> everything with am -3).

Oh, I read this just after I'd sent a V2. You can ignore my V2 if you've
got it to apply (it's the same patch but with a couple of conflicting
lines dropped from the context)

