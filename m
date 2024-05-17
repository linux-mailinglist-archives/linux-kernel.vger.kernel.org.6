Return-Path: <linux-kernel+bounces-182131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FD58C86FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA121C22107
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75550297;
	Fri, 17 May 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ezJV/AUn"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC74CB58
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951450; cv=none; b=QqtdneEpoKtGWpIY3eXQhHL3sxRXN58qnAsJPzRBes1cC+K3LFuQJ0lA2t1KV+C3BQ/rQHFwFhSv9vLCxnvjZs4kWO0jArL7GRpyESyB/XGeUTa/PaYEk/QQ8/h54xUqPt02AIcxi9GOthT0gPfjFWe86wVpcRKT2nMJNXEGEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951450; c=relaxed/simple;
	bh=rpeGMg3VZFVKTPRzqYdY/OLeiqc2vqeGhOwCqNItokM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gFwk27gQmQGaP3nwr0W7vDu7VUr2g0Zj11igHbR00kK0oAEAorDP7EWkKZOJcxjuB/iu175TLpM7c7uooEYDHMch0knWpZTPchjnit63EjpwTLsZvcY5zYyrzzJnIuGG6uq7KcsaaDBrLwSUUfxRmCkXWiRCNSyhH5xOq6pY/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ezJV/AUn; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44HBgiCp013892;
	Fri, 17 May 2024 08:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=DExvazvuf+WMGus+dEP2ywWcXztMrVZYz4EzYGscjyc=; b=
	ezJV/AUnLon9Rj7NClepCn82fCIcFsmOaK+JzOwFnTQXfRXdlaQ/fj3Hc43JkLC5
	ykAyN4uGuRsLZBx7udP5FtneaLXdDsK1JLEwiLByny2eeaVjKZlIQYt107r7X5+J
	EV38IUbkVXfqz6/XN5x3PLpt1GYWmBooWRADpqDR6gbotBR8OgGuDcuM+hFuF8TY
	/t4HcjeUdZIPhw25NUu6qXtkIqtHg0HzzWMz+zFtZQApYonRB95RgsZtff5EGBTr
	FxmFmafrPiAOD7TmSVqryjfhKoDwWchUn+iIEVIHMz0xCHQ7D/egT1vU73MvwJd9
	yuGTvjrks+iKKwR/KFIaLg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3y3qvevg2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 08:10:30 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 17 May
 2024 14:10:28 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 17 May 2024 14:10:28 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A11A4820244;
	Fri, 17 May 2024 13:10:28 +0000 (UTC)
Message-ID: <b198b1e3-3e7e-4ec7-b86f-f09aab22842d@opensource.cirrus.com>
Date: Fri, 17 May 2024 14:10:28 +0100
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
X-Proofpoint-ORIG-GUID: _iac-Ca52m6ny2Twes2WVjK6OHXTQg4Y
X-Proofpoint-GUID: _iac-Ca52m6ny2Twes2WVjK6OHXTQg4Y
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
I've managed to reproduce redzone errors in a x86_64 build with some of
the SLUB debugging enabled. I will investigate.

