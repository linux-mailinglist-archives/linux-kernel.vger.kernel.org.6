Return-Path: <linux-kernel+bounces-182311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA598C8985
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C2D286CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EEE12F589;
	Fri, 17 May 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qDj/We1H"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC712F583
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960661; cv=none; b=Ecn7If0WP5pdxYki7DW7w3iSxqFwYFJ3Ydl3YtnTmetK0hFP68O/kJpWYy8Gtl6c45yxDQOsxS5QDYGkhWjy7h48G0YWl2EWwICzBAnf+in/DzinL6RLQa5Ktr0gOf8Dr1NhxGryYcKn9qfyb67n2S9eG/I/Ynl9lOne7dOHDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960661; c=relaxed/simple;
	bh=ubyDTwryfQPZLTc+IjrHIJp94tvVFhpq1O41naBbjCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YhzbT0iaiOmlaTpMFVDr1VFtr/zmuFYHxqlAe3AN6MYXqDxSUvssNDpKBPRA8VodWK7B7J2Mtg4rpzDTqA1oon8phNoJFs5Erq9MWXT4r5tYCgjMPWLOWYOVlMKlMb23PiGRO6csVvyanje85YPIup747xWIBN6XLCFLTnVDuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qDj/We1H; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44HBkwC4006101;
	Fri, 17 May 2024 10:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=aI5LaUqJdFSBuuJH0VoyzX6QInTDuqm+xUeSu8umdAk=; b=
	qDj/We1Hd8fCnVzDrsmlO48hwdf2s9sl9Au5+1n7wqhEtjoSWMx/jRlMaO87FqLH
	XhzwQlLvEbEgvXlUnRmGypWfEOuz8cJALgf6siqxUJysFMtxCamvPHl7mNfojjJN
	IkM34EjV+aV20SKVoks4MH9wQyVvwEy26+Czlu9KKUYJTeCqQoBe3Ub7lyHHa724
	fXR803jk6sLFawtVrnM0cfS9Rgh4vzgCCRd6dWBIVBmSedTY6yq4M+7Iy0sQMfX4
	RfneY97ZuK6YNUgP4FYhGuGk3TRSlrIfewSfgpZtpsVdLGDCR3PmKFI0CHtFcbpU
	sX+SIa/PHhJpFe8XbcLQJA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3y253hpjtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:44:05 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 17 May
 2024 16:44:04 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 17 May 2024 16:44:04 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id F4016820244;
	Fri, 17 May 2024 15:44:03 +0000 (UTC)
Message-ID: <c5f8c1cf-c575-4619-bfca-e89e9c439017@opensource.cirrus.com>
Date: Fri, 17 May 2024 16:44:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] regmap: kunit: Run sparse cache tests at non-zero
 register addresses
To: Guenter Roeck <linux@roeck-us.net>
CC: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
 <20240408144600.230848-5-rf@opensource.cirrus.com>
 <5c1daddb-d8b3-420a-839f-208e0a6e168b@roeck-us.net>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <5c1daddb-d8b3-420a-839f-208e0a6e168b@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fi3BOhpBBGmWom79-ofhUs6ozaq06rTw
X-Proofpoint-GUID: fi3BOhpBBGmWom79-ofhUs6ozaq06rTw
X-Proofpoint-Spam-Reason: safe

On 16/05/2024 20:53, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Apr 08, 2024 at 03:45:53PM +0100, Richard Fitzgerald wrote:
>> Run the cache_drop() and cache_present() tests at blocks of addresses
>> that don't start at zero.
>>
>> This adds a from_reg parameter to struct regmap_test_param. This is
>> used to set the base address of the register defaults created by
>> gen_regmap().
>>
>> Extra entries are added to sparse_cache_types_list[] to test at non-zero
>> from_reg values. The cache_drop() and cache_present() tests are updated
>> to test at the given offset.
>>
>> The aim here is to add test cases to cache_drop() for the bug fixed by
>> commit 00bb549d7d63 ("regmap: maple: Fix cache corruption in
>> regcache_maple_drop()")
>>
>> But the same parameter table is used by the cache_present() test so
>> let's also update that to use from_reg.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> With this patch in mainline, I get lots of errors such as
> 
> [   23.494308] =============================================================================
> [   23.496391] BUG kmalloc-64 (Tainted: G                 N): kmalloc Redzone overwritten
>

Fix sent:
https://lore.kernel.org/lkml/20240517144703.1200995-1-rf@opensource.cirrus.com/T/#u


