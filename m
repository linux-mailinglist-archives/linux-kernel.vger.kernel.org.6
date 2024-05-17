Return-Path: <linux-kernel+bounces-182095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98D8C8634
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D5AB21CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0AC42059;
	Fri, 17 May 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XuucxtbC"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB041C68
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715948706; cv=none; b=Du5iZRE6PWCiLXYMnM+JoYwV/yCfVg2a/zjwQYKylyY5PHj8H68QwOvK3vQpd/1G/vQuo+pLzmFudYpqnYiaMJ0v4ZJweGaDsi9mp3193VEhkoy5fVox5409cnZIHefJ8dE4AYZgjfh3ykfqMp+dMZtqFGIE7o3g6qwRS4sRmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715948706; c=relaxed/simple;
	bh=auN0caH7D6wVUHe+HwaFcQrcS3XrqjErEzQRs7BVtbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BPP3+pumlzGRwZiBaankoYgjsKjBiTnPnHNDfwqkPjiBFbU4gia/eKB8wb9D8pk0nowioT2TBUqJhOBkUjeD3vpsPA109jtVmHyb1+1qyynehETztPzHEVZq1v6md5bpAtEepckms3KWpZfikhjp1OcBf6qllz0RWH3IWlFGJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XuucxtbC; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44HBl9kK019146;
	Fri, 17 May 2024 06:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=n/U1T0up33AqvYftHIrXa/+1I2+X8aJw6y0lb6mwEz8=; b=
	XuucxtbCbY6q1DpvOo9lNtqkpW3+YL7G+hrwyQd9MkMEFUuNUpTckXchnfou9yzR
	gGgcr0vaRLnrCmYpyxOr1OtUO5ifTv1DZPU+V1SZGff4FpYcasN1nUtwBjyNuBAi
	Aa/szo2dCdMbs7QED4GDEUm92uc36YmA273E9ZNO8vd1aSTFW2Hp6bFFrioBDB2W
	Q0qPf17M7IwMckfmfAbkHPp6o03G88f2xxsplNpz7EtV0hKrtuHo5frdnzKoVkL9
	d6bb6yQMFGkxnW180M7KYcxEkTVIWd6Mfz03KZFIM6MPv2KDM5Cmlb7V/YWHI9xY
	TY8BkSt9TxnQErw/qKC5UQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3y3qveve4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 06:58:33 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 17 May
 2024 12:58:30 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 17 May 2024 12:58:30 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CE563820244;
	Fri, 17 May 2024 11:58:30 +0000 (UTC)
Message-ID: <ffa73a17-ac32-493f-b0a4-32d3ac4c9027@opensource.cirrus.com>
Date: Fri, 17 May 2024 12:58:30 +0100
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
X-Proofpoint-ORIG-GUID: jQyPbB5cl9eiAX21IbeZVOX5_cO30Wqz
X-Proofpoint-GUID: jQyPbB5cl9eiAX21IbeZVOX5_cO30Wqz
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

Just a random thought, I wonder whether in gen_regmap() this:

   if (config->num_reg_defaults)
	config->max_register += (config->num_reg_defaults - 1) *
				config->reg_stride;
   else
	config->max_register += (BLOCK_TEST_SIZE * config->reg_stride);

should be:

config->max_register += max(config->num_reg_defaults - 1,
			    BLOCK_TEST_SIZE) * config->reg_stride;

I've only had a quick scan through the code without seeing any other
obvious problem.

