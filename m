Return-Path: <linux-kernel+bounces-576986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC07A71701
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A85189B04C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2331E25F7;
	Wed, 26 Mar 2025 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TySHglpC"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DC1E505
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993873; cv=none; b=hFLimu3MD83g/t1MfcHvLGtBLTqxGcX5te+QEsbHX2boUOvwt2h+0rya6lIQvAMQhTHZzwtXI6BASA34ikzhQ8gd3GcGiCN88W97t6TipXvxqA0ICdcFwfRhkl2USGU5hJJ1NkFvKGTBTHWTPfkAprmoVdZb+PJB1LlpNCHj06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993873; c=relaxed/simple;
	bh=fMfWkXzrzG6b2b7FJDG+sP3cB3Nluk75FDYwaksyX+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLyjFOHKKJLSC2OQs6oSsiiaCG60L0SiwSllFAwi8RDCLoUul0mCc7y4bFznpXQS8ip/fSIWjZrqxstqO+07OcuBX3eBYqBoyBS7RzhUhrCW6s/95lCSC96fzMOaOqYJfManvUts7r8fgXazCVqma72INs6cVg6G4HkSqbau2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TySHglpC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q2aajM027823;
	Wed, 26 Mar 2025 12:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fUL5kU
	Pao1qlI7NeuB9QYIUz5zCNvVxpyyXsrRJII9Y=; b=TySHglpCKSBIrbNycBRkN4
	km/yaMOZC3MMbPWk/XTrelgWH8JGyYuGuzDjh55XgwilEThBoM4fzaSr0RMQxNxz
	GWC8Xv4V4bh2DIR40qQU3/i3Rh5O8KJwIvtL1+LVUwdKP3BbobLx+64jtS6oeLnd
	hGRBmljCs1FI2bwKCn8wTf6W3BaVLnEcJYPdYHa1klX7fR4kHtHdYaTCtli4Lvpy
	BxzRr3JilXj4PbMOCyQAvlmDFNA14PUS3nxRlFUL4F1bhmRl3Y8PvX+60CSo7mDM
	RkbaDmqeYvcqs0QXznJuX8eQkEKJX8dXgVLzrw6eKs2Qtgtb5p9lccvQ0+HloI2g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx2wrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 12:57:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q9QV96030321;
	Wed, 26 Mar 2025 12:57:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htgk5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 12:57:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QCvNSc42533140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 12:57:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 632FB20043;
	Wed, 26 Mar 2025 12:57:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114AF20040;
	Wed, 26 Mar 2025 12:57:21 +0000 (GMT)
Received: from [9.124.217.36] (unknown [9.124.217.36])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 12:57:20 +0000 (GMT)
Message-ID: <4d0059f1-d834-44d5-bc57-7425980f5a97@linux.ibm.com>
Date: Wed, 26 Mar 2025 18:27:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/21] futex: Implement FUTEX2_NUMA
To: Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-21-bigeasy@linutronix.de>
 <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>
 <20250325225600.GP36322@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250325225600.GP36322@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i7wHBrpXkj4opd2FgNFTB970h7W7bhkx
X-Proofpoint-ORIG-GUID: i7wHBrpXkj4opd2FgNFTB970h7W7bhkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=524 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260079



On 3/26/25 04:26, Peter Zijlstra wrote:
> On Wed, Mar 26, 2025 at 01:22:19AM +0530, Shrikanth Hegde wrote:
> 
>>> +	return &futex_queues[node][hash & futex_hashmask];
> 
>                              ^^^^^^^
> 
>>> +	hashsize = 256 * num_possible_cpus();
>>> +	hashsize /= num_possible_nodes();
>>
>> Wouldn't it be better to use num_online_nodes? each node may get a bigger
>> hash bucket which means less collision no?
> 
> No. There are two problems with num_online_nodes, and both are evident
> above.
> 
> Consider the case of a sparse set.

I am sorry, i didn't understand. Could you please explain?

