Return-Path: <linux-kernel+bounces-405839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9C9C57F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285781F22999
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6691F77AE;
	Tue, 12 Nov 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iHeKwftd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9A1CD21F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415110; cv=none; b=W42BzyigreB1t7cX49duxACC3mgTcrmm6RITvq0Wj4E62WWgVWrS19jZyOJxhxVsJ7U2I5i5XKVOoFxyKsUFVcgT7mFhMSKhMnQ2tx7XREumN7pS/H8FNBdleo2OIX4rlHBBiV4wKN7kbsVCKg+wBw9W7XFAqPLSBOASAy0814Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415110; c=relaxed/simple;
	bh=td5xwDebi/Jymg3imHTutAr7wtiRIxozgpsljucQnng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtJWLMQ+IYQYzONqUzViWvFl3bJ2ai4VBZAtPPtv19k3GBzVjv9XO8WhbPYC8znAPkBG/Td/IhtuHKkWLv3lUcUD/zkQUBe2h//lGjxCjoxRigOsF4B2gjmt17zqZl3x7khyeQxPZQsIRHf//JFjDbLgraVypCqVKhoFvOkme2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iHeKwftd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACAe7T1008284;
	Tue, 12 Nov 2024 12:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Aq7rIS
	1/qLHvvImUDr5i/MyFcdyLITOHxfkNuLlurlY=; b=iHeKwftdn7BiVLMDFnibzK
	FTYohIJyxJpT4Wtckep5i1RFTtrp9l13JX7pbaYaIuwqVI0fWhNJYs6cJdimRuI0
	CeW+LtV15ay37db5of6xtoTyoQaGEfv1UQmjW/Q5D3IwBHdjbIJ2EKatAfLP/4UH
	ZjEC7cbaggda0K/h0wqC+j5qrwtA44/IwKJZpO3+8d2L9OtN9IMCaqAybQwAEB6k
	LyGfIKWYX0svsgn25ZseTRRaTErlw5yVGe00e/aLJP5SVsohkXWuSENke3izuxjU
	Z2ddX7siDiSkNy3+Nko7XshQXJDesZCb567PzYmp/8yaP4Nwk+MjL6uX5facOHrg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v5fe0ds8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:38:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ACCcO1U024894;
	Tue, 12 Nov 2024 12:38:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v5fe0ds3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:38:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC95pjJ002886;
	Tue, 12 Nov 2024 12:38:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9jc3eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:38:23 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACCcMBW43254098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 12:38:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FECF5805A;
	Tue, 12 Nov 2024 12:38:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E3B35805E;
	Tue, 12 Nov 2024 12:38:20 +0000 (GMT)
Received: from [9.109.198.181] (unknown [9.109.198.181])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 12:38:19 +0000 (GMT)
Message-ID: <fec6d8c4-d46d-4e1f-94fb-18f1f3b30f91@linux.ibm.com>
Date: Tue, 12 Nov 2024 18:08:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] cpumask: gcc 13.x emits compilation error on PowerPC
To: Brian Norris <briannorris@chromium.org>
Cc: kees@kernel.org, nathan@kernel.org, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, Gregory Joyce <gjoyce@ibm.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com>
 <CA+ASDXPKosUXy1x7Yvbu3pEYiMfDPSt69xt3Jq-zHw66yeUSRw@mail.gmail.com>
 <6f0cd0ce-f217-4397-8785-7590d1e0e0e0@linux.ibm.com>
 <CA+ASDXPw+1mvHaS21_Z=E7cCsErv8sMseW2pBCMRdB4iyVzzKA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CA+ASDXPw+1mvHaS21_Z=E7cCsErv8sMseW2pBCMRdB4iyVzzKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kxexfoK4MP9SBe1QVFYray6GUFZuFgeT
X-Proofpoint-GUID: O3OGr9yUZIrVf4Y88mizMUtGKKr8_FEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411120102


Hi Brian,

On 11/12/24 02:27, Brian Norris wrote:
> Hi Nilay,
> 
> I'm responding here to try to help move things along for you, even
> though I'm not a maintainer here and don't have a strong (nor
> authoritative) opinion.
Thanks, I really appreciate your help:)
> 
> On Thu, Nov 7, 2024 at 5:38 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
>> On 11/6/24 23:30, Brian Norris wrote:
>>> IIUC, he was hoping for better compiler diagnostics to help out there.
>> Hmm ok
> 
> AFAICT, things aren't moving so fast there, so it might wise to try to
> silence the problem for now.
Okay
> 
>>> (Also, I imitated Thomas's .config notes from that report and couldn't
>>> reproduce with my GCC 13.2.0.)
>>>
>>> I also happen to see there are a few scattered instances of either
>>> disabling or working around -Wstringop-overread false positives in the
>>> tree today.
>>>
>> So shall we wait until we get better diagnostics from GCC or can we bypass this
>> error temporarily with either using __NO_FORTIFY (as I proposed  in my another
>> email) or disable -Wstringop-overread for kernel/padata.c file? Later when we
>> find a better fix, we may then revert this change.
> 
> If this warning is causing pain, then we should probably bypass it. I
> *think* there's less blast radius by simply disabling
> -Wstringop-overread for this file, but I'm not completely sure.
> 
Alright, I'll send a formal patch disabling stringop-overead for kernel/padata.c file.

Thanks,
--Nilay

