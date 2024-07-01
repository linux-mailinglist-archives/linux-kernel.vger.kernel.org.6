Return-Path: <linux-kernel+bounces-235603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB191D740
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0C0B244C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812582AD05;
	Mon,  1 Jul 2024 04:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pJNeMRFP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6D329AB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719809731; cv=none; b=HxE35bNosOaH+Az/bCwlRqkTCmnx9oI0PZruf3o874I3jauPbdscel6ew9ts0KYOk2jTNMFkqkxOb9/8PYTEc2vSBxKuGr0BzBJz41jqTisl4GmLsO2I0H3/HHStEj1oczhxpdzNcBc9NA/rbVFMFqb6BRmXpioGhiNPwBi58ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719809731; c=relaxed/simple;
	bh=qx2i3nuJk8bJLjorfGUm06rte3GhES7sGQJYwHADTNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Crr7plkgmhmCV0+dOOGxURzD63UGF79FW+J8Ym+uOuoiaGZHD8M/biPaqp3jIRhirzwoDNLVD63QGtmVRbJ3KqOdt+QWk8PIQXEvQvCYXI0LL44RMvqxVpDijVVea/vZaWjLd5ITdR+7qpvUVPgj73Ui2AwAcx6pb/3lbvPA15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pJNeMRFP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4614qDpm024734;
	Mon, 1 Jul 2024 04:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=6
	s1Wp1MJPT5iZygHaUn92dcxM+cXHEFm46diAdXVT/g=; b=pJNeMRFPvC8FUCrcW
	3NeK7VgRVJMDZCFxMLt+AnsDSELDiZIyMeRhYWOLpdUbwVK7pVMlqIbkn17B8obC
	qFQAJOAbTifSUQOGZULYSbj1PAD7hJ4mZMDflOuaEFG+C34JXkQkqR5Pukaj4bG3
	dq1p1EewBSZiYsVnbbRSL04KPty9GbiuavI/KN2BL1vqOsBtKpjQYl5brXbJeWJU
	iqN/h/uop+xnztFeYeudRBBRAuZRBrHNk5YB9XvYO0jTsY+dovVPPw4Dw6o3eW02
	uomAl2OgYeZAQaz8tFrmMeZuiNU1NXTKG8xppCetfaS/ctop8dCnrzh6iMd77MQT
	jgJUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403hxu8g7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:55:00 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4614t0YK029180;
	Mon, 1 Jul 2024 04:55:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403hxu8g78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:55:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4614DCm1026417;
	Mon, 1 Jul 2024 04:54:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpncrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:54:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4614stJ63801774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 04:54:57 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB69258056;
	Mon,  1 Jul 2024 04:54:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D24A58052;
	Mon,  1 Jul 2024 04:54:51 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 04:54:51 +0000 (GMT)
Message-ID: <dcab2925-11cb-454a-ba1e-a32e06117ca4@linux.ibm.com>
Date: Mon, 1 Jul 2024 10:24:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Skip offline cores when enabling SMT on PowerPC
To: Thomas Gleixner <tglx@linutronix.de>,
        "Nysal Jan K.A."
 <nysal@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michal Suchanek
 <msuchanek@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour
 <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
 <875xudoz4d.fsf@mail.lhotse> <87ikxza01w.ffs@tglx>
 <11f9cc04-91eb-4a70-9ff0-5c6f24483cd3@linux.ibm.com> <87sex26nlw.ffs@tglx>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <87sex26nlw.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8mr7tDjkjiElWILwVd6jh9jlf9XVFZeJ
X-Proofpoint-ORIG-GUID: XqkE6oS4WMgQ1S91_2M3_x2Mc-TIed-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_04,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010034



On 6/25/24 2:54 AM, Thomas Gleixner wrote:
> On Tue, Jun 25 2024 at 00:41, Shrikanth Hegde wrote:
>> On 6/24/24 1:44 AM, Thomas Gleixner wrote:
>>> Right. So changing it not to online a thread when the full core is
>>> offline should not really break stuff.
>>>
>>> OTH, the mechanism to figure that out on x86 is definitely different and
>>> more complicated than on power because the sibling threads are not
>>> having consecutive CPU numbers.
>>
>> wouldn't topology_sibling_cpumask have this info? 
>> If the mask is empty does it mean the core is offline? 
> 
> The mask is not yet available for the to be brought up CPU. That's
> established when the CPU boots. It might work because all threads are
> brought up during early boot for !~*&^!@% reasons, but then it won't
> work under all circumstances, e.g. 'maxcpus=$N'.
> 
> We could fix that now with the new topology enumeration code, but that's
> a larger scale project.

Ok. 

Can we please document the behavior on different platforms i.e on x86 and PowerPC? 
May be in ABI/testing/sysfs-devices-system-cpu? 

