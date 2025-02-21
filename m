Return-Path: <linux-kernel+bounces-525368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91835A3EF1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78104702F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA320103B;
	Fri, 21 Feb 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MgLWnVDZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE720102D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127876; cv=none; b=uOGnI/6zHKKZuaxAgX0HNBJH7JV5C+lejLGdh5mCslVeboJK6HGzKIXxYjoHzzxwCO2erFHN+NEAVnt5hsr4L27GCYI+NGFFIShhDOdfYae1hA0Bg0C0cS5zM8pApMlDayN0zlNvXF8WY6KRXLrYhy90E5sIxHgCHeC4JIxelbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127876; c=relaxed/simple;
	bh=KBtQRNIBn4e51K1jL/S3lAhAapHCBuNyEZ8KdMrqrkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+h0ZRBoBhkVY+zygHAztjVSVMfO8UU9xPxgQUxI12/cHmEzv3dUydKzO2fU4CPVr0+6tFslswbyL8UdEKmgzzVKl/Ii86ZKl16NXzwmp9f/qGypeURkICbZWuC0vZ3SEEgzWt1r8pbOsnZLfM+8OHgbqfE/6yhABO1zkn4gUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MgLWnVDZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L7XAZv025290;
	Fri, 21 Feb 2025 08:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s8+29E
	eHqQF6eIoO/niupmgR0Z2tv9z/gpls1BiogYM=; b=MgLWnVDZbscTOZurB8w9t0
	AbngklJ6qygw9H5FGjF4e0/gSdsS5z1uGwdQpatrsxRm4t26wEp/CRl7g2u/EfAr
	BJ5u6iPHc9yc3n093uzfSO4OHaZZ3eY+bFtQdkHmtsweFvLQVizvB7Mq3kL2vFx8
	xp+Yag0GVAhb6oUGmQIlmrzgt5mffj6PbxU6nSJ6PQOO8Wh6Ux/LfpELwLZyEjR3
	88YGRxbO4R6DiRxK6xgPO574vf9BSNfcaOu1aiPqDDJNG3YtEPowD/XZg9gKgSYI
	jrKNUZ6dX2RH6oT1M5oMjy4lHsV2+bvh+++qO+ia/OE3XDig6MDZZSfRAHYy1vuA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xn6q0aht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 08:50:49 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51L8jLsj016073;
	Fri, 21 Feb 2025 08:50:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xn6q0ahq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 08:50:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51L5TKph027113;
	Fri, 21 Feb 2025 08:50:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025ewr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 08:50:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51L8oigM42139958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 08:50:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B2320043;
	Fri, 21 Feb 2025 08:50:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAE5120040;
	Fri, 21 Feb 2025 08:50:42 +0000 (GMT)
Received: from [9.124.208.10] (unknown [9.124.208.10])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 08:50:42 +0000 (GMT)
Message-ID: <4bea75bc-d3f6-4972-b644-f9b5a4e8bb77@linux.ibm.com>
Date: Fri, 21 Feb 2025 14:20:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call warning
 for bl+mflr pattern
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, christophe.leroy@csgroup.eu, npiggin@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <20250219162014.10334-1-sv@linux.ibm.com>
 <20250220195940.ely2l2fpsozd2tuv@jpoimboe>
Content-Language: en-US
From: Sathvika Vasireddy <sv@linux.ibm.com>
In-Reply-To: <20250220195940.ely2l2fpsozd2tuv@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OunnJxUc6Zck2ospmegSrnkEZXwY7tvL
X-Proofpoint-ORIG-GUID: BWcpXq7Ew6D85UMDcV_9GS9kop2COYQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210064

Hi Josh, Thanks for the review.

On 2/21/25 1:29 AM, Josh Poimboeuf wrote:
> On Wed, Feb 19, 2025 at 09:50:14PM +0530, Sathvika Vasireddy wrote:
>> Architectures like PowerPC use a pattern where the compiler generates a
>> branch-and-link (bl) instruction that targets the very next instruction,
>> followed by loading the link register (mflr) later. This pattern appears
>> in the code like:
>>
>>   bl .+4
>>   li r5,0
>>   mflr r30
> If I understand correctly, this is basically a fake call which is used
> to get the value of the program counter?

Yes, that's correct.

Also, just out of curiosity, how does x86 do it? Does it not use a 
branch to next instruction approach?

>> Objtool currently warns about this as an "unannotated intra-function
>> call" because find_call_destination() fails to find any symbol at the
>> target offset. Add a check to skip the warning when a branch targets
>> the immediate next instruction in the same function.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202502180818.XnFdv8I8-lkp@intel.com/
>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> This should have a Fixes tag as well.
Thanks for catching that. I'll add the Fixes tag.
>
>>   static int add_call_destinations(struct objtool_file *file)
>>   {
>> +	struct instruction *next_insn;
>>   	struct instruction *insn;
>>   	unsigned long dest_off;
>>   	struct symbol *dest;
>> @@ -1625,6 +1626,11 @@ static int add_call_destinations(struct objtool_file *file)
>>   		reloc = insn_reloc(file, insn);
>>   		if (!reloc) {
>>   			dest_off = arch_jump_destination(insn);
>> +
>> +			next_insn = next_insn_same_func(file, insn);
>> +			if (next_insn && dest_off == next_insn->offset)
>> +				continue;
>> +
> This won't work on x86, where an intra-function call is converted to a
> stack-modifying JUMP.  So this should probably be checked in an
> arch-specific function.

Thanks for letting me know, I'll introduce arch_skip_call_warning() to 
handle architecture specific cases in the next patch I send.

Regards,
Sathvika

