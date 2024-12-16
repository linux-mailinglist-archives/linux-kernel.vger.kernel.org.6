Return-Path: <linux-kernel+bounces-447211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1F99F2EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA17A21DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E62040A7;
	Mon, 16 Dec 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cD4/X1B0"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24920100C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347945; cv=none; b=fFjIhTH6JXZetHBSiIsZc89f/TU3Q5cY0otmJoulS8yulngiGu6nwaXcNArSopCwpgDtGAjzpPxyflKJ2hXiQwlWTNXqEOliOkoPdug/UvmSSdgDOCgku/zZ/yPY+jnjI/3TFhs0HaacXSxHgF7GXiYPmOKBuMHku+kl9BIQtvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347945; c=relaxed/simple;
	bh=MhUgYz7XA6zgpxQz4vA0I4FTLe1FQz6CuofaeKKlrao=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=FB9JbLq/11lippQRFE4Uk0YULotAPx6KqfKVIerIyGdsOON/8AXnTda/1j7vOxU/cc8oRRmGrDM0kSZqDBIzrJhZdtXxUyZciEdHCM/DP+fNTVbjge103td5oyA553y3/LEf0nWbuDJ0Pb9rhMEaGNJ863pbGwSq+e6DeijWfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cD4/X1B0; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6mTqm012591;
	Mon, 16 Dec 2024 05:18:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Fq58yDgO0PgM4kHcBVxNyPeVs5pwEwGet0G7PpLpFjc=; b=
	cD4/X1B0BT33WUHbWoUs6K2WYUiMoERhja2m0iUAM6Ry3z3TrrQC/pAZzxGmvvJa
	evVMZ6iAwuwhywSVxDBuxzIAgT2OoyNOME8wQRPo2OQK4XNr3ZWPh4HR2yOvr++r
	VzQx1a3YW535WRSc44jcZSjPi/X5/CTucdQJLEpdMJNSZjyJ/XlXHTpCJQxv4ami
	aHcyKRTYS2dR6GG798Y4e7/BnQOKDe/8bZgJaLBil6rbzblRDaKRvFlggHUL94H5
	P2ykGJPqd+rnAeFHQ2zwcZsZ2N+ITsbJAI6Y5Tf4ftOD5GAa0c5J0HHyAHgKNMib
	JLV2v9XJ4v9lcDREgc+26Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43h8a21spx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 05:18:57 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 16 Dec
 2024 11:18:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Mon, 16 Dec 2024 11:18:55 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B5DEC820248;
	Mon, 16 Dec 2024 11:18:55 +0000 (UTC)
Message-ID: <ec6881c2-10a9-4b4d-a53b-f882d6aa89d3@opensource.cirrus.com>
Date: Mon, 16 Dec 2024 11:18:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: avoid large local variables
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: Arnd Bergmann <arnd@kernel.org>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20241216083350.1866908-1-arnd@kernel.org>
 <940e60d3-2617-4156-945e-01b1e345c27e@opensource.cirrus.com>
Content-Language: en-GB
In-Reply-To: <940e60d3-2617-4156-945e-01b1e345c27e@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 65LKhq1BAdWPyfhAvJ5iKcnom9hRhND6
X-Proofpoint-GUID: 65LKhq1BAdWPyfhAvJ5iKcnom9hRhND6
X-Proofpoint-Spam-Reason: safe

On 16/12/2024 10:38 am, Richard Fitzgerald wrote:
> On 16/12/2024 8:33 am, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Having 1280 bytes of local variables on the stack exceeds the limit
>> on 32-bit architectures:
>>
>> drivers/firmware/cirrus/test/cs_dsp_test_bin.c: In function 
>> 'bin_patch_mixed_packed_unpacked_random':
>> drivers/firmware/cirrus/test/cs_dsp_test_bin.c:2097:1: error: the 
>> frame size of 1784 bytes is larger than 1024 bytes [-Werror=frame- 
>> larger-than=]
>>
>> Use dynamic allocation for the largest two here.
>>
>> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file 
>> download")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   .../firmware/cirrus/test/cs_dsp_test_bin.c    | 36 +++++++++++--------
>>   1 file changed, 22 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c b/drivers/ 
>> firmware/cirrus/test/cs_dsp_test_bin.c
>> index 689190453307..f1955813919c 100644
>> --- a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
>> +++ b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
>> @@ -1978,8 +1978,10 @@ static void 
>> bin_patch_mixed_packed_unpacked_random(struct kunit *test)
>>            4, 51, 76, 72, 16,  6, 39, 62, 15, 41, 28, 73, 53, 40, 45, 54,
>>           14, 55, 46, 66, 64, 59, 23,  9, 67, 47, 19, 71, 35, 18, 42,  1,
>>       };
>> -    u32 packed_payload[80][3];
>> -    u32 unpacked_payload[80];
>> +    struct {
>> +        u32 packed[80][3];
>> +        u32 unpacked[80];
>> +    } *payload;
>>       u32 readback[3];
>>       unsigned int alg_base_words, patch_pos_words;
>>       unsigned int alg_base_in_packed_regs, patch_pos_in_packed_regs;
>> @@ -1988,8 +1990,12 @@ static void 
>> bin_patch_mixed_packed_unpacked_random(struct kunit *test)
>>       struct firmware *fw;
>>       int i;
>> -    get_random_bytes(packed_payload, sizeof(packed_payload));
>> -    get_random_bytes(unpacked_payload, sizeof(unpacked_payload));
>> +    payload = kmalloc(sizeof(*payload), GFP_KERNEL);
> 
> Should be kunit_kmalloc() so the kunit framework frees it automatically
> if any test case fails and the test terminates early.
> 
> Apart from that it looks ok to me.

Also the check for NULL should use KUNIT_ASSERT_NOT_NULL() so the test
case will error-out.

