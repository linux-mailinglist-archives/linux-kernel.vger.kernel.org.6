Return-Path: <linux-kernel+bounces-441170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6E39ECA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C63168FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF24239BD7;
	Wed, 11 Dec 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZO9i/ETi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F8239BA8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913968; cv=none; b=RDnv/TmbKSqf2HQHkVlsx3U3R9Jun9zXvgew+QMpLuTZgqhZ/B/7MWIXf7H2S1fhLYT5d5OaP6Ybnl3DIQP4a6xkM7vp/jA24ooZvAkEWQQ3HvQVx/4p7LwdIZyKPaeG9CdllXroJItcu3mObcOcoEUVDK/IIw7KZbaQJXWz25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913968; c=relaxed/simple;
	bh=drTVui+JWkB8s0++FuEkNboTZC4hEHwkE8bvp3D077Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oh9c4gsolRfmxsrJd/ZNcZkxXIvLHzP4eA1ZZBDzWnMnaYHfzBUKAxLl6Xyj662PR114es1WhGrG0qX3CYp4F50ogveocpKHxMT1jic23UFoaXdZUL5UZwWxoo5IuG5Qc/WHKnShuoJ510jU3GxzIC2EDlidBqEfAnvrIq6b97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZO9i/ETi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB6KmNF002777;
	Wed, 11 Dec 2024 10:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BQevAwZ0YPc2kqXNrNdRwGljTan2wotQ3zH2pn6WzPU=; b=ZO9i/ETi0KaKeRa/
	OzLjZg/MkuYHrV7gFfAp4ulqU6B6jv2cnIgUhgjGhgkaT+SFBCGao2vV1wSyaD/T
	XqvnfiHFATO9WFrQWDN99Ty0OzVmnbBHACaag+yXyfNwthDdCtJB3EmtlYp9uzQ4
	nv+DQDY7m+bXd33TIik/2Jb6bbt0yfJPEFIXiIG9gnRbaT2RhTCsImp/ZWpg6r/b
	YBIa1WWR7V33lnGrGD3VjzhJ5ymIkctXeLKOlrXQjhE+AymIC6YN0N3PlKWmEKLp
	v7c/4clgv907msv22pQq4aHdO8ph9uXLepYU6g8y94lG5GIlaCpUB5yO/UMDDny3
	ZNVaJQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw47juy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 10:45:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BBAjpkv004326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 10:45:51 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Dec
 2024 02:45:48 -0800
Message-ID: <1b9b0482-9a6c-4182-ae87-9202f15725ca@quicinc.com>
Date: Wed, 11 Dec 2024 18:45:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/core: Enhanced debug logs in do_task_dead()
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Zhongqiu Han <quic_zhonhan@quicinc.com>
References: <20241210134513.2179786-1-quic_zhonhan@quicinc.com>
 <20241210141823.GU35539@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <20241210141823.GU35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m60oAYt6exWg6lJHcuMaaOfL0G4_KvyQ
X-Proofpoint-GUID: m60oAYt6exWg6lJHcuMaaOfL0G4_KvyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110081

On 12/10/2024 10:18 PM, Peter Zijlstra wrote:
> On Tue, Dec 10, 2024 at 09:45:13PM +0800, Zhongqiu Han wrote:
>> If BUG() is a NOP, dump the problematic stack for debugging purposes.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>> If BUG() is a NOP, it should make sense for debugging purposes. However,
>> just arising the patch with RFC, because at least for now, I haven't found
>> a definition of BUG() as NOP in various architectures. Thanks~
> 
> Yeah, this don't make sense. If you want a stack-trace you shouldn't
> have killed BUG.
> 
> And yeah, having done a quick peek, I don't see how you can kill BUG
> these days other than explicitly modyfing your source, in which case you
> get to keep the pieces.

Hi Peter，
Thanks a lot for your review and reply!

My initial thought was that if BUG() is a NOP, we should dump the stack
for debugging purposes before executing cpu_relax(), because according
to the current do_task_dead() code comments, BUG() might be a NOP in
some cases.
void __noreturn do_task_dead(void)
{
         /* Causes final put_task_struct in finish_task_switch(): */
         set_special_state(TASK_DEAD);

         /* Tell freezer to ignore us: */
         current->flags |= PF_NOFREEZE;

         __schedule(SM_NONE);
         BUG();

         /* Avoid "noreturn function does return" - but don't continue if
BUG() is a NOP: */-------------------> This comments
         for (;;)
                 cpu_relax();
}

For example, in the code _before_ 7/4/2014 commit a4b5d580e078 ('bug:
Make BUG() always stop the machine')., BUG() is indeed a NOP if (
!CONFIG_BUG && !HAVE_ARCH_BUG)

  #else /* !CONFIG_BUG */
  #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (0)
+#define BUG() do {} while (1)
  #endif



However, since 10/4/2024 commit 5284984a4fba ('bug: Fix no-return
statement warning with !CONFIG_BUG'), with !CONFIG_BUG, the default
BUG() is implemented to call unreachable() to ensure it does not return,
and if all architecture-specific implementations of BUG() also do not
return, I now think my thought should be meaningless.

commit 5284984a4fba ('bug: Fix no-return-statement warning with 
!CONFIG_BUG')
  #else /* !CONFIG_BUG */
  #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#define BUG() do {             \
+       do {} while (1);        \
+       unreachable();          \
+} while (0)
  #endif


By the way, do you think it is reasonable to remove the cpu_relax code
by evaluating whether BUG() does not return in all architectures and
configurations? Additionally, _if_ some architecture-specific
implementations of BUG() do not have the capability to output the thread
stack, should we consider using the panic() function as a replacement?

Thanks for your time.



-- 
Thx and BRs,
Zhongqiu Han

